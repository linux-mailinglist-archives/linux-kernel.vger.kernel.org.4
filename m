Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3772CDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbjFLSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjFLSXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D77E7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WuZqmtvd4WjoknFOrkLRYxUsHp5/t5pNlhuMb2dd9d8=;
        b=Ptgnm/zcPxh2qyvS8qltOjVRhNbDAAvI7EAtTH2NJb1Ha/K2xYBYiyD/YrumENKo1HBem3
        gj4fMo5afQ4d4ESDS6UJutNcjBWPi3onKqQoSd+olWlMqzlkCIZNbO2NCSXCJMp5IRYPlx
        tr/Kzf+m3cz+BSKhYKzD2MtmbK/2tr8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-y0tEEWpYNimn8HksmNJwlg-1; Mon, 12 Jun 2023 14:23:00 -0400
X-MC-Unique: y0tEEWpYNimn8HksmNJwlg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1a68ea38be2so1187363fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594180; x=1689186180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuZqmtvd4WjoknFOrkLRYxUsHp5/t5pNlhuMb2dd9d8=;
        b=LbpcWwLSQLWB0UldRP4JhaBPFmr7MWHz06mRUyikDCA7vP/lQAuDci0nvmsyi+v5oI
         T4c0Vy2UsITHZ6ake9kywL0r1HAr/4b/XQu1R8IHTFtHh3VfuwX0RGsbrjnJ+48XYo9c
         1fhHxLbalKM5Md9fqE3V+XMlzB8VZXtoqPfLHTilfxyV1iXizGVyG6Z4IgfNoX3VzMdG
         dmhHmtyhb63kfPK3PyPHs9DXAvEzAjYlL/9Pr/X2Guhe78AQaSXzjtTjqQ620HSVGSFE
         dkqcqwY4dytz5mX3u66qzNlmJ16wsueDLh/YaJXJZI8pE9ocovyniZ/1VpyJLd83fQ5I
         Gdcw==
X-Gm-Message-State: AC+VfDxG/8xjJRl5TCLI3RYuSuAkQAX+cv5TNqmZILUQPANssuGWwlHd
        FtEFi2KpJKL2xptjI5Dt6D4VlBEP26xvTEHOk7TrfX0Qou7CXzUMChYjyOpRq0VOcARA9yMjoRm
        9FZHuVaSvueIOJApGJyRX5rxP
X-Received: by 2002:a05:6870:3403:b0:1a6:a28b:6e4 with SMTP id g3-20020a056870340300b001a6a28b06e4mr1424754oah.37.1686594180230;
        Mon, 12 Jun 2023 11:23:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ojOAZsqcF6bnSAgTcknWHmKu5ibIbDyN5vE0vwVE23kVcIn47oSmy77InfhxOlx0UQ4BxKw==
X-Received: by 2002:a05:6870:3403:b0:1a6:a28b:6e4 with SMTP id g3-20020a056870340300b001a6a28b06e4mr1424739oah.37.1686594179927;
        Mon, 12 Jun 2023 11:22:59 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id r34-20020a05687108a200b001a68feb9440sm1579964oaq.9.2023.06.12.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:22:59 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:22:56 -0500
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
Subject: Re: [PATCH 05/26] net: stmmac: dwmac-qcom-ethqos: shrink clock code
 with devres
Message-ID: <20230612182256.7cc3goqwid32fdn6@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:34AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We can use a devm action to completely drop the remove callback and use
> stmmac_pltfr_remove() directly for remove. We can also drop one of the
> goto labels.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I think using the remove callback seems more direct to a reader, but
that's pretty opinionated. The change itself looks good so:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 24 +++++++++----------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index c801838fae2a..2da0738eed24 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -586,6 +586,11 @@ static int ethqos_clks_config(void *priv, bool enabled)
>  	return ret;
>  }
>  
> +static void ethqos_clks_disable(void *data)
> +{
> +	ethqos_clks_config(data, false);
> +}
> +
>  static int qcom_ethqos_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -636,6 +641,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_mem;
>  
> +	ret = devm_add_action_or_reset(&pdev->dev, ethqos_clks_disable, ethqos);
> +	if (ret)
> +		goto err_mem;
> +
>  	ethqos->speed = SPEED_1000;
>  	ethqos_update_rgmii_clk(ethqos, SPEED_1000);
>  	ethqos_set_func_clk_en(ethqos);
> @@ -653,27 +662,16 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>  	if (ret)
> -		goto err_clk;
> +		goto err_mem;
>  
>  	return ret;
>  
> -err_clk:
> -	ethqos_clks_config(ethqos, false);
> -
>  err_mem:
>  	stmmac_remove_config_dt(pdev, plat_dat);
>  
>  	return ret;
>  }
>  
> -static void qcom_ethqos_remove(struct platform_device *pdev)
> -{
> -	struct qcom_ethqos *ethqos = get_stmmac_bsp_priv(&pdev->dev);
> -
> -	stmmac_pltfr_remove(pdev);
> -	ethqos_clks_config(ethqos, false);
> -}
> -
>  static const struct of_device_id qcom_ethqos_match[] = {
>  	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
>  	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
> @@ -684,7 +682,7 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
>  
>  static struct platform_driver qcom_ethqos_driver = {
>  	.probe  = qcom_ethqos_probe,
> -	.remove_new = qcom_ethqos_remove,
> +	.remove_new = stmmac_pltfr_remove,
>  	.driver = {
>  		.name           = "qcom-ethqos",
>  		.pm		= &stmmac_pltfr_pm_ops,
> -- 
> 2.39.2
> 

