Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F974AC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjGGHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjGGHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:45:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A2126AD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:44:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so1087834a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688715898; x=1691307898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nc8hsYfP7p2/uQcQVsM1gSYitt4Oq+PGcwvXsUY6Xd0=;
        b=IfQPY7vmxYj1PcxBJ0L3J2rLmRwRg+zUfuHzIsME0fm2M91udhvySx62cP6yywzzt4
         KvOhwLh26kqJDnlf4IWE6uxj7II+T9pWexx/jm2CZTWedS1BBLEJ+VGwRDfMJWobxkzU
         R6+YJfBK93Rs3VXc+oSsLQJWfGGEMgIhMdvo58QveX/EPSvDd/k1YRO1f3p3Fc6t7vwh
         mrJqYVOH1zbrU1JJY1lCau/2jGzd+C5QrTK9htklBC46EHvzNiHnmjLqmyKv+JJjYf4p
         j56zOTQY/ZEv19FVy4NWdQaasJ/KK/qNqbFEr1QngwHfGm+fiodQHrhWWd4aOb2naWmT
         a1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688715898; x=1691307898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc8hsYfP7p2/uQcQVsM1gSYitt4Oq+PGcwvXsUY6Xd0=;
        b=I0iTMrIcZVnlYRXfzR9huwKGqxxxQAQClvI7cvws/ppDc9hm8esD9A150pxhd+U3Bw
         ojs8MfKVww70GwziaueOTlWGDL02z3nFSJPa3IA53tHvR9R23HOkSzkpCxZP7D0xU4Jb
         N4KP6+PgYLcBz8aX6xuI1EmCYXyYgl8JXSDtp/dkbYgc75xQKfZiaoWpyqEBEqeltuiC
         50DAqVhJG1mmquWUn+Spr9gekuYFm4d/PLRsEPfMrdgK1syGx8obpSnYxcAdGH44woqn
         bibSJ+e6ji9rewm/nFPxoGXotbXUwSVw9/nDArxdPtRumRsL3SKeGggFt1DyyZkSCahN
         sqtw==
X-Gm-Message-State: ABy/qLZk8IFk/1+7GYBKOA1N+qT3TspJb2HcSgX6p+Jw6kXQusARDz8u
        1qHpt1Y0uvHb43EDmGm+oFHA
X-Google-Smtp-Source: APBJJlE1giAF5ktcBdYwyPiW/RITGSYsHtaTsJIfAlizZBMQzPCsDxxmt3RXdsUWwYCMtjhL8i2biA==
X-Received: by 2002:a05:6a20:8f2a:b0:12f:5f2b:cbb0 with SMTP id b42-20020a056a208f2a00b0012f5f2bcbb0mr10538469pzk.23.1688715898358;
        Fri, 07 Jul 2023 00:44:58 -0700 (PDT)
Received: from thinkpad ([117.216.120.82])
        by smtp.gmail.com with ESMTPSA id z6-20020a633306000000b0051b460fd90fsm2382435pgz.8.2023.07.07.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 00:44:57 -0700 (PDT)
Date:   Fri, 7 Jul 2023 13:14:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] clk: qcom: gcc-sc8280xp: Add missing GDSC flags
Message-ID: <20230707074449.GJ6001@thinkpad>
References: <20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org>
 <20230620-topic-sc8280_gccgdsc-v2-1-562c1428c10d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620-topic-sc8280_gccgdsc-v2-1-562c1428c10d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:48:06PM +0200, Konrad Dybcio wrote:
> All of the 8280's GCC GDSCs can and should use the retain registers so
> as not to lose their state when entering lower power modes.
> 
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/clk/qcom/gcc-sc8280xp.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index b90c71637814..64bea886322d 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -6761,7 +6761,7 @@ static struct gdsc pcie_0_tunnel_gdsc = {
>  		.name = "pcie_0_tunnel_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc pcie_1_tunnel_gdsc = {
> @@ -6772,7 +6772,7 @@ static struct gdsc pcie_1_tunnel_gdsc = {
>  		.name = "pcie_1_tunnel_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE,
>  };
>  
>  /*
> @@ -6787,7 +6787,7 @@ static struct gdsc pcie_2a_gdsc = {
>  		.name = "pcie_2a_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc pcie_2b_gdsc = {
> @@ -6798,7 +6798,7 @@ static struct gdsc pcie_2b_gdsc = {
>  		.name = "pcie_2b_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc pcie_3a_gdsc = {
> @@ -6809,7 +6809,7 @@ static struct gdsc pcie_3a_gdsc = {
>  		.name = "pcie_3a_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc pcie_3b_gdsc = {
> @@ -6820,7 +6820,7 @@ static struct gdsc pcie_3b_gdsc = {
>  		.name = "pcie_3b_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc pcie_4_gdsc = {
> @@ -6831,7 +6831,7 @@ static struct gdsc pcie_4_gdsc = {
>  		.name = "pcie_4_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE | RETAIN_FF_ENABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc ufs_card_gdsc = {
> @@ -6840,6 +6840,7 @@ static struct gdsc ufs_card_gdsc = {
>  		.name = "ufs_card_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc ufs_phy_gdsc = {
> @@ -6848,6 +6849,7 @@ static struct gdsc ufs_phy_gdsc = {
>  		.name = "ufs_phy_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc usb30_mp_gdsc = {
> @@ -6856,6 +6858,7 @@ static struct gdsc usb30_mp_gdsc = {
>  		.name = "usb30_mp_gdsc",
>  	},
>  	.pwrsts = PWRSTS_RET_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc usb30_prim_gdsc = {
> @@ -6864,6 +6867,7 @@ static struct gdsc usb30_prim_gdsc = {
>  		.name = "usb30_prim_gdsc",
>  	},
>  	.pwrsts = PWRSTS_RET_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc usb30_sec_gdsc = {
> @@ -6872,6 +6876,7 @@ static struct gdsc usb30_sec_gdsc = {
>  		.name = "usb30_sec_gdsc",
>  	},
>  	.pwrsts = PWRSTS_RET_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc emac_0_gdsc = {
> @@ -6880,6 +6885,7 @@ static struct gdsc emac_0_gdsc = {
>  		.name = "emac_0_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc emac_1_gdsc = {
> @@ -6888,6 +6894,7 @@ static struct gdsc emac_1_gdsc = {
>  		.name = "emac_1_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = RETAIN_FF_ENABLE,
>  };
>  
>  static struct clk_regmap *gcc_sc8280xp_clocks[] = {
> 
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
