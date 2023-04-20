Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70FF6E8BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjDTHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjDTHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:47:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F994208;
        Thu, 20 Apr 2023 00:47:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79CDB660311B;
        Thu, 20 Apr 2023 08:47:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681976856;
        bh=hPK316bstXNH8p7DHglZxidzS9fL7HRmhwrYeluTQRs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nWirLOMqNNjiBKaIlQu8K/5JxwriH+zMIAj/4STn4R0oq4L3+k/NyjUaRatSg3jtB
         4yrYu63RHD/sl1OYywd3nXn/ft6cQSQnM1vFAdLGmIl1yvQiqCnLlxahNpDIoNPeyi
         tpxNdSBVvct1VgwgzeMtPp4Z79ftiqozj4n/CBnx3I3bEjfIYlptMLzYSRupBrqIKB
         ufNjBCscrcqV6M4MQge6WHOxGi3CbAHg2Ip1LT2iZy+zURk7C2qS4GGwAoCVjItkNu
         nFi08P2F1YimlsNZQ+2aaC1zlngKDnmIcWlW616VscHNYjPFIycU07FYgJyQhScqW7
         6+TVr9CXT6f2g==
Message-ID: <b0819ff8-8fba-4464-9a62-be56d4bfa4cd@collabora.com>
Date:   Thu, 20 Apr 2023 09:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] pwm: mediatek: Add support for MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>
References: <cover.1681932165.git.daniel@makrotopia.org>
 <e22d8e66558f094b544aa208c722a7f88fd0bde1.1681932165.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e22d8e66558f094b544aa208c722a7f88fd0bde1.1681932165.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/04/23 21:25, Daniel Golle ha scritto:
> The PWM unit on MT7981 uses different register offsets than previous
> MediaTek PWM units. Add support for these new offsets and add support
> for PWM on MT7981 which has 3 PWM channels, one of them is typically
> used for a temperature controlled fan.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/pwm/pwm-mediatek.c | 54 ++++++++++++++++++++++++++++++++------
>   1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5b5eeaff35da6..2bfb5bedf570b 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -34,10 +34,14 @@
>   
>   #define PWM_CLK_DIV_MAX		7
>   
> +#define REG_V1			1
> +#define REG_V2			2
> +
>   struct pwm_mediatek_of_data {
>   	unsigned int num_pwms;
>   	bool pwm45_fixup;
>   	bool has_ck_26m_sel;
> +	u8 reg_ver;

You're overcomplicating this one... checking for a register version and then
deciding at every pwm_mediatek_writel() call what to use...

It's way simpler than that!
Pass a pointer to the register array in pwm_mediatek_of_data and then...

>   };
>   
>   /**
> @@ -59,10 +63,14 @@ struct pwm_mediatek_chip {
>   	const struct pwm_mediatek_of_data *soc;
>   };
>   
> -static const unsigned int pwm_mediatek_reg_offset[] = {
> +static const unsigned int mtk_pwm_reg_offset_v1[] = {
>   	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
>   };
>   
> +static const unsigned int mtk_pwm_reg_offset_v2[] = {
> +	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x1c0, 0x200, 0x0240
> +};
> +
>   static inline struct pwm_mediatek_chip *
>   to_pwm_mediatek_chip(struct pwm_chip *chip)
>   {
> @@ -111,7 +119,19 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
>   				       unsigned int num, unsigned int offset,
>   				       u32 value)
>   {
> -	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);

...this simply becomes:

writel(value, chip->regs + chip->reg_offset[num] + offset);

> +	u32 pwm_offset;
> +
> +	switch (chip->soc->reg_ver) {
> +	case REG_V2:
> +		pwm_offset = mtk_pwm_reg_offset_v2[num];
> +		break;
> +
> +	case REG_V1:
> +	default:
> +		pwm_offset = mtk_pwm_reg_offset_v1[num];
> +	}
> +
> +	writel(value, chip->regs + pwm_offset + offset);
>   }
>   
>   static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -285,60 +305,77 @@ static const struct pwm_mediatek_of_data mt2712_pwm_data = {
>   	.num_pwms = 8,
>   	.pwm45_fixup = false,
>   	.has_ck_26m_sel = false,
> +	.reg_ver = REG_V1,

...so instead of assigning that, you'd be assigning

	.reg_offset = mtk_pwm_reg_offset_v1;

Better, right? :-)

Cheers,
Angelo



