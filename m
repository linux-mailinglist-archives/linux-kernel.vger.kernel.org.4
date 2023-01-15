Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5537666AF48
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjAOEMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAOEMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:12:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343A46AF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:12:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i1so3735628pfk.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HbOf8QOA+SQUVuPMrmy7ht0oGGMULpTbRXbzXkjFY3A=;
        b=hjm9nN1bYtTMlwFOMG3d/0+hrsk/uXSUsl+L6pAydr0htkM4+OO62Iuwkqqs0F29+6
         c0Inh+d64SeNTprg+UR0YTa++EI8ir5du58JpUmpg/YPn/1Z4mFw6QHRIWm0DkokKYJY
         IGCYf4oFqvDwKhQT6Yb/1DvrPwzbCwYuJbcdHhFDNUELUme+hQYEz9WWUBxVoIDLHOoB
         JR4i3Re1Lcl1LNWxpLZ02HzAQRqCPSwY48jzSQ/Iw0lgMscSDyz/AhlTlHyMVNru71CS
         uwtPFYplAhOE0WPpf3UTWiRnmjGxwx+ZNafGG0o6W2yDhudUrGuliTVHBAfKHFbOUdcT
         BD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbOf8QOA+SQUVuPMrmy7ht0oGGMULpTbRXbzXkjFY3A=;
        b=AFYAYVNQqdcV01z/jgL47aT2INTNMKFt6kq8ygB4Cv+vvc4bnPS1MSe+W2kHnKF0nF
         LU2dd0naEbJVKaeFCRvnrKvqp9nDhLyhTZhHIHeNhld3OlVJTjv8PfkintbRUGh+LPlz
         V2+5xvMlRvdrOlIA9CDUUm2Y7FuCGPLOHVkDw6Pa5pmYSIsYhmqplIFCSH+w9hH3TeiM
         jXN5mlF8SPdKwDosMjjw9hsk5YproDEjLoS7jmG4laqLHb+EBREwlhkZKVakqXFC91KD
         RKQOOI8fg6/Wpiz8FCUPYWgGDxYccsiiTasuyPT+Vjl/9+GSDrDW16/VzeInUUGgpu7U
         oT0g==
X-Gm-Message-State: AFqh2kprPCEvmZti8UNFtb65/N8o5huUScdyvQ2pSN3tgIzQUhdyt973
        UeR/q3QyYw89CbQVsLdt5Bnd
X-Google-Smtp-Source: AMrXdXstU3k+Ez9dUb7CwiCgHzcbkcy6cGiJpvcz1VmULRJ+tjsFA08gfUCtv2uGb2za3n8vLfag/A==
X-Received: by 2002:a62:2903:0:b0:57f:f2cd:6180 with SMTP id p3-20020a622903000000b0057ff2cd6180mr79015953pfp.0.1673755965296;
        Sat, 14 Jan 2023 20:12:45 -0800 (PST)
Received: from thinkpad ([220.158.159.143])
        by smtp.gmail.com with ESMTPSA id x6-20020a623106000000b0058bb8943c9asm3473463pfx.161.2023.01.14.20.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 20:12:43 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:42:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Remove need for clk_ignore_unused on sc8280xp
Message-ID: <20230115041239.GD6568@thinkpad>
References: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:10:38PM -0800, Bjorn Andersson wrote:
> With the transition of disabling unused clocks at sync_state, rather
> than late_initcall() it's now possible to drop clk_ignore_unused and
> unused clock disabled once client drivers have probed. Do this on
> SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/clk/qcom/dispcc-sc8280xp.c | 1 +
>  drivers/clk/qcom/gcc-sc8280xp.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
> index 167470beb369..c84a6481b879 100644
> --- a/drivers/clk/qcom/dispcc-sc8280xp.c
> +++ b/drivers/clk/qcom/dispcc-sc8280xp.c
> @@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "disp_cc-sc8280xp",
>  		.of_match_table = disp_cc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index b3198784e1c3..f4fdc5b9663c 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "gcc-sc8280xp",
>  		.of_match_table = gcc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
