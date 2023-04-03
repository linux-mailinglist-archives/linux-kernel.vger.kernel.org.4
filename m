Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FA6D4D31
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjDCQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjDCQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:06:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F62423A;
        Mon,  3 Apr 2023 09:06:17 -0700 (PDT)
Received: from [192.168.2.163] (109-252-124-32.nat.spd-mgts.ru [109.252.124.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62445660313D;
        Mon,  3 Apr 2023 17:06:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680537976;
        bh=51DH+WEXRTwye3bL60EML5+n6ov/nUbID+1syBtvpVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C9GkqTYAX09V3aIvsoWtqW3YPmEWj7zFP3HggswnZ4se7DeHa3lkiNFh+heVl0M8r
         SMS5ViZbdpkfsdTECVba356upLtrBCtf/hNI9XsK/zgOjLro2s7iXKpiHBPbtwebTl
         KmGe4nw/TN92clBXluiu6KIIxxbc6dDRGFReFqMARCrijGVwoRa4ZJilHlovsJDHDo
         j+sCM4MDZKBJqgndI3A4ms85H9GC6k1totnOzsXmlIM9oNQ+l6D08COyCBlP7K9d9N
         lzCUdaIjaMrO122v9zron59ycQAJAJwca0VO36KRO8MSvgkXEdy+iizwUIUlWzs4uH
         PbHYXc3qx29gw==
Message-ID: <f70c6d62-a7fd-c153-932f-16886e46329b@collabora.com>
Date:   Mon, 3 Apr 2023 19:06:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] soc/tegra: pmc: Support software wake-up for SPE
Content-Language: en-US
To:     Petlozu Pravareshwar <petlozup@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, ulf.hansson@linaro.org, kkartik@nvidia.com,
        cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viswanath L <viswanathl@nvidia.com>
References: <20230330170621.258068-1-petlozup@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230330170621.258068-1-petlozup@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 20:06, Petlozu Pravareshwar wrote:
> The Sensor Processing Engine(SPE) can trigger a software wake-up of
> the device. To support this wake-up for the SPE, set SR_CAPTURE_EN
> bit in WAKE_AOWAKE_CNTRL register associated with the wake-up for
> the SPE. This SR capturing logic is expected to be enabled for wakes
> with short pulse signalling requirements.
> 
> Signed-off-by: Viswanath L <viswanathl@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
> v1->v2:
> * Rebase the change on latest code.
> ---
>  drivers/soc/tegra/pmc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index cf4cfbf9f7c5..2a2342eff622 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -3,7 +3,7 @@
>   * drivers/soc/tegra/pmc.c
>   *
>   * Copyright (c) 2010 Google, Inc
> - * Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
>   *
>   * Author:
>   *	Colin Cross <ccross@google.com>
> @@ -177,6 +177,7 @@
>  /* Tegra186 and later */
>  #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
>  #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
> +#define WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN (1 << 1)
>  #define WAKE_AOWAKE_MASK_W(x) (0x180 + ((x) << 2))
>  #define WAKE_AOWAKE_MASK_R(x) (0x300 + ((x) << 2))
>  #define WAKE_AOWAKE_STATUS_W(x) (0x30c + ((x) << 2))
> @@ -191,6 +192,8 @@
>  #define WAKE_AOWAKE_CTRL 0x4f4
>  #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
>  
> +#define SW_WAKE_ID		83 /* wake83 */
> +
>  /* for secure PMC */
>  #define TEGRA_SMC_PMC		0xc2fffe00
>  #define  TEGRA_SMC_PMC_READ	0xaa
> @@ -355,6 +358,7 @@ struct tegra_pmc_soc {
>  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
>  				   struct device_node *np,
>  				   bool invert);
> +	void (*set_wake_filters)(struct tegra_pmc *pmc);
>  	int (*irq_set_wake)(struct irq_data *data, unsigned int on);
>  	int (*irq_set_type)(struct irq_data *data, unsigned int type);
>  	int (*powergate_set)(struct tegra_pmc *pmc, unsigned int id,
> @@ -2416,6 +2420,17 @@ static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
>  	return 0;
>  }
>  
> +static void tegra186_pmc_set_wake_filters(struct tegra_pmc *pmc)
> +{
> +	u32 value;
> +
> +	/* SW Wake (wake83) needs SR_CAPTURE filter to be enabled */
> +	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
> +	value |= WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN;
> +	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
> +	dev_dbg(pmc->dev, "WAKE_AOWAKE_CNTRL_83 = 0x%x\n", value);
> +}

To me this needs to be moved to the SPE driver, which should get the PMC
regmap handle and enable wake only when needed, similarly how it's done
by USB Tegra drivers that also need to configure PMC. Otherwise this
looks like a hack/workaround.

-- 
Best regards,
Dmitry

