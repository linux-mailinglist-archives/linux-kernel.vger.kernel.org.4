Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAD6D8E34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjDFEEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjDFEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:04:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219E93CB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:04:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w4so36380205plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680753881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwLGYJpkSUvkezkjBSZxDdx6SLvlS1QDZ05xZHf9C8s=;
        b=f5TVPL/AF/lWTHvhMDuOC7QySlTjg7gYCRAjhBH4uQ62esYtlqAxldfcLCuYSApMGZ
         Mv7PvEMGxpnPzatDGQClsf9PlRGCZsXAsM8rgrlIF0I0mdWcL8GGX7P/Mt6nlRJOZQUD
         ZhIUw/eM1Vktn7UqPHDeefC5nY7tO9Qxl4L1WHPd1hJMvdMHRrUyacOlYwdCz+gHovO9
         7EqLdICzAcSuGWKhzbk0mSMiSx++3fMvkvUGdHRZBcbINfdkZx3YxBPwFScZ/VpaGFk8
         GyC3KPHZaDCbp2W+BUo6W1RP8eY9gjATzCzFRO05zK6SaQ+oSfuGFM38J9AiTRILrC9G
         X3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680753881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwLGYJpkSUvkezkjBSZxDdx6SLvlS1QDZ05xZHf9C8s=;
        b=3pL6Hclya03EMYSZGbaiu7L1M0TC6IwNLwqaIK/Mh1MG1Scd6gaGJoqZHF1RawpbOq
         mQ+VV6dvfYno9LrtEmM4zwqC1yum1//ijbpl9vyo9Dbf7z8ar/sdo3k6wMKGdkCRrZHa
         uGyYMlzTyv0JX3plRAsPsPFd85C3B6TGiVHmOdanQQSM52WYgFc3h2XJFY0gqLoW/HD+
         elsTiGkcHfXwuGIfc7J31y0D4G9M1BdodRfYxq09FHGs/Zfpw58nbsv6jzluSO6UYV2p
         wSbj3uSsB6LE4ORLIdFSKjpKs4XgAi0jWxXOiruAHn4btjVmtLcZQHyEkk3Fqp8DBLNd
         eJnw==
X-Gm-Message-State: AAQBX9epZT1q0nxO/QTDJA0zOhHNZegVv6YO4qzA6+MODvMnMeGH07DR
        gG27bOya797iZNgSPj2HWT83EA==
X-Google-Smtp-Source: AKy350ZNp41dp/n2ozwLSh2ZspXcNbVwAuoURK+zspTfFxPXT9Vj2fU+SeUuGtC7FtsjNSbfA1Npjw==
X-Received: by 2002:a17:902:cf52:b0:1a2:23f7:1fe with SMTP id e18-20020a170902cf5200b001a223f701femr7122770plg.44.1680753881501;
        Wed, 05 Apr 2023 21:04:41 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b001898ee9f723sm320489pls.2.2023.04.05.21.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:04:40 -0700 (PDT)
Date:   Thu, 6 Apr 2023 12:04:33 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable
Message-ID: <20230406040433.GA111746@dragon>
References: <20230403174807.345185-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403174807.345185-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 07:48:07PM +0200, Konrad Dybcio wrote:
> The vast majority of shared RCGs were not marked as such. Fix it.

It seems we completely missed this shared RCG thing, as vendor drivers
do not use it.  Could you help me understand a couple of things?

- How does vendor driver handle shared RCGs?
- How did you find out these shared RCGs?

Shawn

> 
> Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/gcc-qcm2290.c | 62 +++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
> index 096deff2ba25..48995e50c6bd 100644
> --- a/drivers/clk/qcom/gcc-qcm2290.c
> +++ b/drivers/clk/qcom/gcc-qcm2290.c
> @@ -650,7 +650,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
>  		.name = "gcc_usb30_prim_mock_utmi_clk_src",
>  		.parent_data = gcc_parents_0,
>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -686,7 +686,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
>  		.name = "gcc_camss_axi_clk_src",
>  		.parent_data = gcc_parents_4,
>  		.num_parents = ARRAY_SIZE(gcc_parents_4),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -706,7 +706,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
>  		.name = "gcc_camss_cci_clk_src",
>  		.parent_data = gcc_parents_9,
>  		.num_parents = ARRAY_SIZE(gcc_parents_9),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -728,7 +728,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
>  		.name = "gcc_camss_csi0phytimer_clk_src",
>  		.parent_data = gcc_parents_5,
>  		.num_parents = ARRAY_SIZE(gcc_parents_5),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -742,7 +742,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
>  		.name = "gcc_camss_csi1phytimer_clk_src",
>  		.parent_data = gcc_parents_5,
>  		.num_parents = ARRAY_SIZE(gcc_parents_5),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -764,7 +764,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
>  		.parent_data = gcc_parents_3,
>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>  		.flags = CLK_OPS_PARENT_ENABLE,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -779,7 +779,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
>  		.parent_data = gcc_parents_3,
>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>  		.flags = CLK_OPS_PARENT_ENABLE,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -794,7 +794,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
>  		.parent_data = gcc_parents_3,
>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>  		.flags = CLK_OPS_PARENT_ENABLE,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -809,7 +809,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
>  		.parent_data = gcc_parents_3,
>  		.num_parents = ARRAY_SIZE(gcc_parents_3),
>  		.flags = CLK_OPS_PARENT_ENABLE,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
>  		.name = "gcc_camss_ope_ahb_clk_src",
>  		.parent_data = gcc_parents_6,
>  		.num_parents = ARRAY_SIZE(gcc_parents_6),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -854,7 +854,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
>  		.parent_data = gcc_parents_6,
>  		.num_parents = ARRAY_SIZE(gcc_parents_6),
>  		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -888,7 +888,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
>  		.name = "gcc_camss_tfe_0_clk_src",
>  		.parent_data = gcc_parents_7,
>  		.num_parents = ARRAY_SIZE(gcc_parents_7),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -912,7 +912,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
>  		.name = "gcc_camss_tfe_0_csid_clk_src",
>  		.parent_data = gcc_parents_8,
>  		.num_parents = ARRAY_SIZE(gcc_parents_8),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -926,7 +926,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
>  		.name = "gcc_camss_tfe_1_clk_src",
>  		.parent_data = gcc_parents_7,
>  		.num_parents = ARRAY_SIZE(gcc_parents_7),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -940,7 +940,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
>  		.name = "gcc_camss_tfe_1_csid_clk_src",
>  		.parent_data = gcc_parents_8,
>  		.num_parents = ARRAY_SIZE(gcc_parents_8),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -963,7 +963,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
>  		.parent_data = gcc_parents_10,
>  		.num_parents = ARRAY_SIZE(gcc_parents_10),
>  		.flags = CLK_OPS_PARENT_ENABLE,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -984,7 +984,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
>  		.name = "gcc_camss_top_ahb_clk_src",
>  		.parent_data = gcc_parents_4,
>  		.num_parents = ARRAY_SIZE(gcc_parents_4),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1006,7 +1006,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>  		.name = "gcc_gp1_clk_src",
>  		.parent_data = gcc_parents_2,
>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1020,7 +1020,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>  		.name = "gcc_gp2_clk_src",
>  		.parent_data = gcc_parents_2,
>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1034,7 +1034,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>  		.name = "gcc_gp3_clk_src",
>  		.parent_data = gcc_parents_2,
>  		.num_parents = ARRAY_SIZE(gcc_parents_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1054,7 +1054,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>  		.name = "gcc_pdm2_clk_src",
>  		.parent_data = gcc_parents_0,
>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1082,7 +1082,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s0_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
> @@ -1098,7 +1098,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s1_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
> @@ -1114,7 +1114,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s2_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
> @@ -1130,7 +1130,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s3_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
> @@ -1146,7 +1146,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s4_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
> @@ -1162,7 +1162,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s5_clk_src",
>  	.parent_data = gcc_parents_1,
>  	.num_parents = ARRAY_SIZE(gcc_parents_1),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
> @@ -1219,7 +1219,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
>  		.name = "gcc_sdcc1_ice_core_clk_src",
>  		.parent_data = gcc_parents_0,
>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1266,7 +1266,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
>  		.name = "gcc_usb30_prim_master_clk_src",
>  		.parent_data = gcc_parents_0,
>  		.num_parents = ARRAY_SIZE(gcc_parents_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1280,7 +1280,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
>  		.name = "gcc_usb3_prim_phy_aux_clk_src",
>  		.parent_data = gcc_parents_13,
>  		.num_parents = ARRAY_SIZE(gcc_parents_13),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1303,7 +1303,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
>  		.parent_data = gcc_parents_14,
>  		.num_parents = ARRAY_SIZE(gcc_parents_14),
>  		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> -- 
> 2.40.0
> 
