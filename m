Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243F72D11E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjFLUtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjFLUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A3212C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686602766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+9OvtK97veHl6+HegxVNiurUYmzQbeChvO9xmQ5r5g=;
        b=BWQ3ghMPvF9CGG2rUpQZngc9xqZB+ytJvyXqbvIwnizzzSdTn/Xm75scjdQTsIEgtvx/ik
        on0JS7W5548qbCdLKLUehwXCZyO1iddEl+X+c6uMpEkl+o9rnUL+tAX7u/3A7iJpZqYxah
        VQuY8pDDYKWMK4yOhp+dj60bclNhPgk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-uHtOuO4hN0OAfNejYAw-RQ-1; Mon, 12 Jun 2023 16:42:55 -0400
X-MC-Unique: uHtOuO4hN0OAfNejYAw-RQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-568ae92e492so69644767b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602575; x=1689194575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+9OvtK97veHl6+HegxVNiurUYmzQbeChvO9xmQ5r5g=;
        b=YfyAPFDvAOWjU3P4hMekJlloumNp4qcmTs2+IguuZ/h33ZImpCVk5HsKU9ay7lCW+Q
         ET8TEzmCtr9tP+hZk3djEdN22HXEIcJxmDo0EyzTUUYUTCMFr7os9w/W08fkX+6vsKDo
         3g/ZSQrQ4s8l/wqI4BMfXKBCdmabcjj2pCP3uT7XX6PdefGFRVntIgpdmZbBGsZctUZU
         86a1RHbPs7+OA5tkfJpTWHdJDYpm1Vfy/YFDvL2xPQh1oVPtwgidhE/pLMl82s6WhG/I
         olOu/CydP6cwBDhznnwu0fDuzERqbv4YZEwcwmoQhQzYFvqlHQeQaA+6e1T8HqYj+9Vg
         iDSw==
X-Gm-Message-State: AC+VfDx4MgdM4/G9eBP2RwmBi08Ly2EIruLNr9tfYgouJBTF7FbCeAKI
        gE8ndVYxyFhakz7blm/BIsfbSrZlSCdGQiUWucJQkXDzO/tjK3YIqLe6F97snGdOG/u1bUXPK1a
        FVav9LZURuRnx7Dn3MqKIafu1
X-Received: by 2002:a81:7bc6:0:b0:56d:3372:71c7 with SMTP id w189-20020a817bc6000000b0056d337271c7mr2596025ywc.23.1686602575041;
        Mon, 12 Jun 2023 13:42:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xUUOwVWCsyVOTXZeMW6GB/UM/A5jZuRMVvmYBzle/O+VHgBsWxsSIEBgDZ0wTd7/cMwI9Mg==
X-Received: by 2002:a81:7bc6:0:b0:56d:3372:71c7 with SMTP id w189-20020a817bc6000000b0056d337271c7mr2596001ywc.23.1686602574825;
        Mon, 12 Jun 2023 13:42:54 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id x186-20020a817cc3000000b00568cbb028c6sm2769484ywc.85.2023.06.12.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:42:54 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:42:52 -0500
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
Subject: Re: [PATCH 14/26] net: stmmac: dwmac-qcom-ethqos: add optional
 phyaux clock
Message-ID: <20230612204252.kb57m72ehazt4bco@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-15-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-15-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:43AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> On sa8775p we don't use the RGMII clock but have an additional PHYAUX
> clock so add support for it to the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 252dca400071..2f6b9b419601 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -94,6 +94,7 @@ struct qcom_ethqos {
>  
>  	unsigned int rgmii_clk_rate;
>  	struct clk *rgmii_clk;
> +	struct clk *phyaux_clk;
>  	struct phy *serdes_phy;
>  	unsigned int speed;
>  
> @@ -604,6 +605,13 @@ static int ethqos_clks_config(void *priv, bool enabled)
>  			return ret;
>  		}
>  
> +		ret = clk_prepare_enable(ethqos->phyaux_clk);
> +		if (ret) {
> +			clk_disable_unprepare(ethqos->rgmii_clk);
> +			dev_err(&ethqos->pdev->dev, "phyaux enable failed\n");
> +			return ret;
> +		}
> +
>  		/* Enable functional clock to prevent DMA reset to timeout due
>  		 * to lacking PHY clock after the hardware block has been power
>  		 * cycled. The actual configuration will be adjusted once
> @@ -611,6 +619,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
>  		 */
>  		ethqos_set_func_clk_en(ethqos);
>  	} else {
> +		clk_disable_unprepare(ethqos->phyaux_clk);
>  		clk_disable_unprepare(ethqos->rgmii_clk);
>  	}
>  
> @@ -669,6 +678,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		goto out_config_dt;
>  	}
>  
> +	ethqos->phyaux_clk = devm_clk_get_optional(dev, "phyaux");
> +	if (IS_ERR(ethqos->phyaux_clk)) {
> +		ret = PTR_ERR(ethqos->phyaux_clk);
> +		goto out_config_dt;
> +	}
> +

Similar comment to the prior patch about whether or not this should be
optional (or selected via platform compatible and required),
otherwise looks good.

>  	ret = ethqos_clks_config(ethqos, true);
>  	if (ret)
>  		goto out_config_dt;
> -- 
> 2.39.2
> 

