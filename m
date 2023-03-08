Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DD6B064A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCHLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:46:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351D5CC21;
        Wed,  8 Mar 2023 03:46:11 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97D9F660000F;
        Wed,  8 Mar 2023 11:46:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678275970;
        bh=Fz4r9E9olNDyPmEeLOcgEBzWwcRZ44On96yQB42TXEw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=acrXZejibitZcABdpwyKEZGsbOVzp3Q4HAaFxtm54hQ4rGX4a+KIqL+7z3WHmfpD8
         ZirF9hYD51MjKGy2CLEVwbgVNu5jT3daVgNvXQDuhiY2p49wRK8Dk0T+ODmy0ZCgLa
         RVw7A3HWF1cGsyVQVXNnMvYk5X94xti8jRIRoleVb1j7/qUbCQ3vnTmkpVJtlBLphG
         u+mR5evvfUXZCiuUHU+faC0JhgH9V8I2GIpC0vGDs/Rmduwf6LA+4VC7WF6KDifFt5
         CkEH82xPXX5AzieR+T+2IVHx9gB1HET8RdXJJTahZWuHvTDkmhbIohQ/CNj5AmrhrF
         HY8k/P1nr81jQ==
Message-ID: <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
Date:   Wed, 8 Mar 2023 12:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
In-Reply-To: <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
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

Il 23/02/23 15:16, AngeloGioacchino Del Regno ha scritto:
> Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
>> Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
>> right register, an old two-wrongs-make-one-right issue emerged: as a
>> result, MT8192 Asurada Spherion got no backlight at boot unless a
>> suspend/resume cycle was performed.
>> Also, the backlight would sometimes not get updated with the requested
>> value, requiring the user to change it back and forth until it worked.
>>
>> This series fixes both of the aforementioned issues found on MT8192.
>>
>> AngeloGioacchino Del Regno (2):
>>    pwm: mtk-disp: Disable shadow registers before setting backlight
>>      values
>>    pwm: mtk-disp: Configure double buffering before reading in
>>      .get_state()
>>
>>   drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
>>   1 file changed, 23 insertions(+), 11 deletions(-)
>>
> 
> Gentle ping for this one: this is fixing backlight issues on multiple MediaTek
> SoCs and was well tested.
> 
> Thanks,
> Angelo

Since this series was sent more than one month ago, and since this fixes broken
backlight on a number of Chromebooks with MT8183 and MT8192 SoCs, and seen the
urgency of getting these fixes in, I'm adding Greg to the loop.

Regards,
Angelo
