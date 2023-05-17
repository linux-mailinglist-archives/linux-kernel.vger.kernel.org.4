Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5989770654E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjEQKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEQKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:32:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A111359F;
        Wed, 17 May 2023 03:32:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1A7A6605877;
        Wed, 17 May 2023 11:32:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684319574;
        bh=yiNihgP3IrNI3loR/8a+ht/13x21xzVRUN2RDyTYeg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SylBTcxfImZLgeZy1TmMJVYWvo1PI/aclIfEm7SGQAyttBoQapaytZ0swJcMwAvZh
         bKfSaqLUB7e/bWNBbq6kjLMhK14dxPR4CLitPNZeNIcH9ppHS4EwwkNZM1AdOSupYH
         OWiOQF+G4PrytuzEyPsbkUvSCV3RO/bjTTuFGSKgvlChe+xtpMgnRG+mTPr16D99t7
         J7yW5TrrGcj9FUMWdikNzgmdA/WnF+U1LkcqnA6VqOAPPvMFU/Jp28qUBFSxWnIyCn
         vZ4sOlggmFfKyiUuJKaO2Px7sfatKk652nV/RApQGUvCfpyw2rHDJFy51XkP0pYVAi
         shjBqLWjhtCcA==
Message-ID: <c5315454-a155-3842-00b7-08b6b8ff92e6@collabora.com>
Date:   Wed, 17 May 2023 12:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/7] iio: adc: rockchip_saradc: Add support for RK3588
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
 <20230516230051.14846-2-shreeya.patel@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230516230051.14846-2-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/23 01:00, Shreeya Patel ha scritto:
> Refactor conversion operation to support rk3588 saradc and
> add separate start, read, powerdown in respective hooks.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 127 +++++++++++++++++++++++++++---
>   1 file changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 79448c5ffc2a..ac6fdf8e673b 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -38,10 +38,29 @@
>   #define SARADC_TIMEOUT			msecs_to_jiffies(100)
>   #define SARADC_MAX_CHANNELS		8
>   
> +/* v2 registers */
> +#define SARADC2_CONV_CON		0x0
> +#define SARADC_T_PD_SOC			0x4
> +#define SARADC_T_DAS_SOC		0xc
> +#define SARADC2_END_INT_EN		0x104
> +#define SARADC2_ST_CON			0x108
> +#define SARADC2_STATUS			0x10c
> +#define SARADC2_END_INT_ST		0x110
> +#define SARADC2_DATA_BASE		0x120
> +
> +#define SARADC2_EN_END_INT		BIT(0)
> +#define SARADC2_START			BIT(4)
> +#define SARADC2_SINGLE_MODE		BIT(5)
> +
> +struct rockchip_saradc;
> +
>   struct rockchip_saradc_data {
>   	const struct iio_chan_spec	*channels;
>   	int				num_channels;
>   	unsigned long			clk_rate;
> +	void (*start)(struct rockchip_saradc *info, int chn);
> +	int (*read)(struct rockchip_saradc *info);
> +	void (*power_down)(struct rockchip_saradc *info);
>   };
>   
>   struct rockchip_saradc {
> @@ -60,27 +79,77 @@ struct rockchip_saradc {
>   	struct notifier_block nb;
>   };
>   
> -static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> +static void rockchip_saradc_reset_controller(struct reset_control *reset);
> +
> +static void rockchip_saradc_start_v1(struct rockchip_saradc *info, int chn)
> +{
> +	/* 8 clock periods as delay between power up and start cmd */
> +	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> +	/* Select the channel to be used and trigger conversion */
> +	writel(SARADC_CTRL_POWER_CTRL | (chn & SARADC_CTRL_CHN_MASK) |
> +	       SARADC_CTRL_IRQ_ENABLE, info->regs + SARADC_CTRL);
> +}
> +
> +static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
> +{
> +	int val;
> +
> +	if (info->reset)
> +		rockchip_saradc_reset_controller(info->reset);
> +
> +	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
> +	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
> +	val = SARADC2_EN_END_INT << 16 | SARADC2_EN_END_INT;

What about using bitfield macros?

/* "LO" and "HI" may get a better name, if there's any possible one! */
#define SARADC2_EN_END_INT_LO BIT(0)
#define SARADC2_EN_END_INT_HI BIT(16)

val = FIELD_PREP(SARADC_EN_END_INT_LO, 1);
val |= FIELD_PREP(SARADC_EN_END_INT_HI, 1);
writel ....

Otherwise, if it's about two really "specular" instances, you can probably
keep the current definition as SARADC2_EN_END_INT and do

val = FIELD_PREP(SARADC_EN_END_INT, 1);
val |= val << 16;
writel ...

/* note: high, low bits are unknown to me, I assumed it's 16 bits :-) */
#define SARADC2_CONV_CHANNELS GENMASK(15, 0)

val = FIELD_PREP(SARADC2_START, 1);
val |= FIELD_PREP(SARADC2_SINGLE_MODE, 1);
val |= FIELD_PREP(SARADC2_CONV_CHANNELS, chn);
val |= val << 16;
writel ...


> +	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
> +	val = SARADC2_START | SARADC2_SINGLE_MODE | chn;
> +	writel(val << 16 | val, info->regs + SARADC2_CONV_CON);
> +}
> +

Cheers,
Angelo

