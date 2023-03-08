Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE36B0BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCHO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCHO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:56:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608194D62A;
        Wed,  8 Mar 2023 06:56:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1A496602FE9;
        Wed,  8 Mar 2023 14:56:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678287363;
        bh=Da88jPbrAYVszvP/jyQ5xKD1FUfQYZqHG8N9tP5uhZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YdW5kNr/v4oJi/EhQxProI4Eg1+q8ern3OnpIewL7ChzjYEz/7rWz1S2HS5nlonNn
         I5pI5DJGKxfTjUhkOcW5rtFgSKKwk4umFLeRmO2rnM69qf6o/bPttEbbwMQDoMdbWU
         MndqkCf4f3/gdC152MFadbY52y53XZ5Ikb7TmOsJoIyppO9O2Nq6PlZbDugygvrI6t
         BZq1Pd7I/7BZHKt3hrgE6bdCGlsPzvO4PGZYIY5LBGSZhOx6Bf93anCex2eB4lAhc6
         Z7qQztrJ3mq+ZqX/H4yfacb6shzY4ltvcGIZW4mlaAXvJYeoTIgmoXA2+XMVbmDU9Z
         OgT/NIczgVkpg==
Message-ID: <28142704-d82d-d533-d2a8-b1061182f1f6@collabora.com>
Date:   Wed, 8 Mar 2023 15:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com, weiqing.kong@mediatek.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
 <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
 <ZAigsHAgqkLlBD1y@kroah.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZAigsHAgqkLlBD1y@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/03/23 15:50, Greg Kroah-Hartman ha scritto:
> On Wed, Mar 08, 2023 at 12:46:07PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 23/02/23 15:16, AngeloGioacchino Del Regno ha scritto:
>>> Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
>>>> Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
>>>> right register, an old two-wrongs-make-one-right issue emerged: as a
>>>> result, MT8192 Asurada Spherion got no backlight at boot unless a
>>>> suspend/resume cycle was performed.
>>>> Also, the backlight would sometimes not get updated with the requested
>>>> value, requiring the user to change it back and forth until it worked.
>>>>
>>>> This series fixes both of the aforementioned issues found on MT8192.
>>>>
>>>> AngeloGioacchino Del Regno (2):
>>>>     pwm: mtk-disp: Disable shadow registers before setting backlight
>>>>       values
>>>>     pwm: mtk-disp: Configure double buffering before reading in
>>>>       .get_state()
>>>>
>>>>    drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
>>>>    1 file changed, 23 insertions(+), 11 deletions(-)
>>>>
>>>
>>> Gentle ping for this one: this is fixing backlight issues on multiple MediaTek
>>> SoCs and was well tested.
>>>
>>> Thanks,
>>> Angelo
>>
>> Since this series was sent more than one month ago, and since this fixes broken
>> backlight on a number of Chromebooks with MT8183 and MT8192 SoCs, and seen the
>> urgency of getting these fixes in, I'm adding Greg to the loop.
> 
> $ ./scripts/get_maintainer.pl drivers/pwm/pwm-mtk-disp.c
> Thierry Reding <thierry.reding@gmail.com> (maintainer:PWM SUBSYSTEM)
> "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de> (reviewer:PWM SUBSYSTEM)
> Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> (reviewer:ARM/Mediatek SoC support)
> linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> 
> I don't see my name in there, did I become the PWM maintainer somehow?
> 
> What's wrong with Thierry taking this like normal?
> 

Nothing wrong with that. I felt like this series got ignored as I've never
received any reply from Thierry, even though it's a Fixes series that I deem
to be moderately urgent; that's why I added you to the loop.

If that created unnecessary noise, I'm extremely sorry and won't happen again.

Regards,
Angelo

