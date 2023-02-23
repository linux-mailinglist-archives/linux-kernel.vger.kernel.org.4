Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD66A0BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjBWOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjBWOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:16:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7049893;
        Thu, 23 Feb 2023 06:16:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1F0A66020E0;
        Thu, 23 Feb 2023 14:16:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677161764;
        bh=DExPf9AiH1cBAor2LPRH1UeqVdtp1oO6LQZ563fjEng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dsUs87YSLJdFMEq9PSAxDC+rpYg2aXK2Qpjs3fSO9JLTNEBfhj4dKDV35d53ENrIG
         ik/GD3J2rRYfOH4aV621pksA42WOyrMifzEsMVFC2dTnUo10aHGsarvvS/zor8jrH4
         Mm3XH+MUT41o+eNIUwaMxRBqkkrIT1pAdkm21iXswxm5Dk1/ay+DA45sbI5arubUnG
         BBXgs90RU82vQHaEAee3cuupalTLyjrIBi32XNb8u00XbENb6BhLiExorMEk7oDTqp
         JHQ1DBVUxcrouQRkXA50mjpU7AozR2srp6R/fQZN3w1xQK9sUgNXAApNP/l+qBR67y
         f6TiGHdA/WnmQ==
Message-ID: <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
Date:   Thu, 23 Feb 2023 15:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Content-Language: en-US
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
> Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
> right register, an old two-wrongs-make-one-right issue emerged: as a
> result, MT8192 Asurada Spherion got no backlight at boot unless a
> suspend/resume cycle was performed.
> Also, the backlight would sometimes not get updated with the requested
> value, requiring the user to change it back and forth until it worked.
> 
> This series fixes both of the aforementioned issues found on MT8192.
> 
> AngeloGioacchino Del Regno (2):
>    pwm: mtk-disp: Disable shadow registers before setting backlight
>      values
>    pwm: mtk-disp: Configure double buffering before reading in
>      .get_state()
> 
>   drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 

Gentle ping for this one: this is fixing backlight issues on multiple MediaTek
SoCs and was well tested.

Thanks,
Angelo
