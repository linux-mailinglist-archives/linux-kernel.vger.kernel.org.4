Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50172CE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjFLSjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjFLSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D75184
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686595131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PDNy4tlrStiRvaxnMXQiYuj7Ms4xtJijYK3hHSTiCgM=;
        b=H7qFbt2G/1zA73N8VaJp9BsN+Epzea+/mngAVCVxQtg0eLs7uU+UMfDKhxzzQEto5sEk+K
        rnpk7My/iNBFXuxbcEjgmhp8coSZhe7nPmEQULO3vkrWRtS8qXZWWGkLWGzltbpBYiI6IS
        t/SbjcM4qeUMi2jN5allx7QJWNysifw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-MHJYOlQhMFiGb0cJQ1nxbg-1; Mon, 12 Jun 2023 14:38:50 -0400
X-MC-Unique: MHJYOlQhMFiGb0cJQ1nxbg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-397f97f7966so3114343b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595129; x=1689187129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDNy4tlrStiRvaxnMXQiYuj7Ms4xtJijYK3hHSTiCgM=;
        b=c8Q2Hjk133mUOkWuk4t3vwhBtSO690BE4EI/CrYFsYKjj0vIoi1/BQzKVvVIyyYca+
         q2q2txxCPTKYUIxkHwGUauqIu6MPyLIdlLKG1l2ST957EUvzXSw7bLKuedwWLQZodeHy
         XDQevtNTo+ju1Ylh5pYJu5h2weCbs2iFDP8g2AmnsPpPQBvbslEYXYGbrofHqk3MqBs8
         IU/e/do7ujfPOkb4ZEtbI+C5pBTztwaFLbKr9Ssq7ZhzA1P1Fe+4ajRBWWSBgfnaQ2sj
         DRCtallRc+b60gWKK+wemPTGAeoCrOmzCxUZrZQiHzBfEH1QLVmhGfwrDidOODoQF8E+
         DiLA==
X-Gm-Message-State: AC+VfDywsjk9heQ3pz38RwEcpVQOwWY9EBbi6+827LFrdG7fDJtBks2X
        DQqB4px/yZ+jz7rfXtyoag6jrxaH99b01idrwgvgtKza9I8fqOEIisoZ5JLI4NRhj2j8KsQ/SPv
        RBspRdTU5JasOuQycY3ug1NA0
X-Received: by 2002:a05:6808:2090:b0:398:e4c:d5c2 with SMTP id s16-20020a056808209000b003980e4cd5c2mr6244353oiw.9.1686595129322;
        Mon, 12 Jun 2023 11:38:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ658SXpBYoZENXQUCSYrl2GfGIsHYqLLYyBLRDeoekAAyN1j6b2/N1aFPTIPKR17gwesdJaxg==
X-Received: by 2002:a05:6808:2090:b0:398:e4c:d5c2 with SMTP id s16-20020a056808209000b003980e4cd5c2mr6244337oiw.9.1686595129080;
        Mon, 12 Jun 2023 11:38:49 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id t7-20020a815f07000000b0054f9e7fed7asm2663490ywb.137.2023.06.12.11.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:38:48 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:38:39 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 08/26] net: stmmac: dwmac-qcom-ethqos: use a helper
 variable for &pdev->dev
Message-ID: <20230612183839.zcn5glnhptptmbt4@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-9-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:37AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Shrink code and avoid line breaks by using a helper variable for
> &pdev->dev.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 48 ++++++++++---------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 28d2514a8795..e19d142630d3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -123,25 +123,26 @@ static void rgmii_updatel(struct qcom_ethqos *ethqos,
>  static void rgmii_dump(void *priv)
>  {
>  	struct qcom_ethqos *ethqos = priv;
> +	struct device *dev = &ethqos->pdev->dev;
>  
> -	dev_dbg(&ethqos->pdev->dev, "Rgmii register dump\n");
> -	dev_dbg(&ethqos->pdev->dev, "RGMII_IO_MACRO_CONFIG: %x\n",
> +	dev_dbg(dev, "Rgmii register dump\n");
> +	dev_dbg(dev, "RGMII_IO_MACRO_CONFIG: %x\n",
>  		rgmii_readl(ethqos, RGMII_IO_MACRO_CONFIG));
> -	dev_dbg(&ethqos->pdev->dev, "SDCC_HC_REG_DLL_CONFIG: %x\n",
> +	dev_dbg(dev, "SDCC_HC_REG_DLL_CONFIG: %x\n",
>  		rgmii_readl(ethqos, SDCC_HC_REG_DLL_CONFIG));
> -	dev_dbg(&ethqos->pdev->dev, "SDCC_HC_REG_DDR_CONFIG: %x\n",
> +	dev_dbg(dev, "SDCC_HC_REG_DDR_CONFIG: %x\n",
>  		rgmii_readl(ethqos, SDCC_HC_REG_DDR_CONFIG));
> -	dev_dbg(&ethqos->pdev->dev, "SDCC_HC_REG_DLL_CONFIG2: %x\n",
> +	dev_dbg(dev, "SDCC_HC_REG_DLL_CONFIG2: %x\n",
>  		rgmii_readl(ethqos, SDCC_HC_REG_DLL_CONFIG2));
> -	dev_dbg(&ethqos->pdev->dev, "SDC4_STATUS: %x\n",
> +	dev_dbg(dev, "SDC4_STATUS: %x\n",
>  		rgmii_readl(ethqos, SDC4_STATUS));
> -	dev_dbg(&ethqos->pdev->dev, "SDCC_USR_CTL: %x\n",
> +	dev_dbg(dev, "SDCC_USR_CTL: %x\n",
>  		rgmii_readl(ethqos, SDCC_USR_CTL));
> -	dev_dbg(&ethqos->pdev->dev, "RGMII_IO_MACRO_CONFIG2: %x\n",
> +	dev_dbg(dev, "RGMII_IO_MACRO_CONFIG2: %x\n",
>  		rgmii_readl(ethqos, RGMII_IO_MACRO_CONFIG2));
> -	dev_dbg(&ethqos->pdev->dev, "RGMII_IO_MACRO_DEBUG1: %x\n",
> +	dev_dbg(dev, "RGMII_IO_MACRO_DEBUG1: %x\n",
>  		rgmii_readl(ethqos, RGMII_IO_MACRO_DEBUG1));
> -	dev_dbg(&ethqos->pdev->dev, "EMAC_SYSTEM_LOW_POWER_DEBUG: %x\n",
> +	dev_dbg(dev, "EMAC_SYSTEM_LOW_POWER_DEBUG: %x\n",
>  		rgmii_readl(ethqos, EMAC_SYSTEM_LOW_POWER_DEBUG));
>  }
>  
> @@ -242,6 +243,7 @@ static const struct ethqos_emac_driver_data emac_v3_0_0_data = {
>  
>  static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  {
> +	struct device *dev = &ethqos->pdev->dev;
>  	unsigned int val;
>  	int retry = 1000;
>  
> @@ -279,7 +281,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  		retry--;
>  	} while (retry > 0);
>  	if (!retry)
> -		dev_err(&ethqos->pdev->dev, "Clear CK_OUT_EN timedout\n");
> +		dev_err(dev, "Clear CK_OUT_EN timedout\n");
>  
>  	/* Set CK_OUT_EN */
>  	rgmii_updatel(ethqos, SDCC_DLL_CONFIG_CK_OUT_EN,
> @@ -296,7 +298,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  		retry--;
>  	} while (retry > 0);
>  	if (!retry)
> -		dev_err(&ethqos->pdev->dev, "Set CK_OUT_EN timedout\n");
> +		dev_err(dev, "Set CK_OUT_EN timedout\n");
>  
>  	/* Set DDR_CAL_EN */
>  	rgmii_updatel(ethqos, SDCC_DLL_CONFIG2_DDR_CAL_EN,
> @@ -322,12 +324,13 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  
>  static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
>  {
> +	struct device *dev = &ethqos->pdev->dev;
>  	int phase_shift;
>  	int phy_mode;
>  	int loopback;
>  
>  	/* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
> -	phy_mode = device_get_phy_mode(&ethqos->pdev->dev);
> +	phy_mode = device_get_phy_mode(dev);
>  	if (phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
>  	    phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
>  		phase_shift = 0;
> @@ -468,7 +471,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
>  			      loopback, RGMII_IO_MACRO_CONFIG);
>  		break;
>  	default:
> -		dev_err(&ethqos->pdev->dev,
> +		dev_err(dev,
>  			"Invalid speed %d\n", ethqos->speed);

nit: You could put this on the prior line now

With that in place, feel free to add:

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

