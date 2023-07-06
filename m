Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3B749E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGFNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGFNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:54:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE21997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:54:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2cb7384so3370885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688651681; x=1691243681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8rVh13OFs9h1WXgdRFpacqzMIIEv1x17FSavnL+MZI=;
        b=NN00sezm7y/zHbubP8D8/nFh8h3umeC7cj1/pmPOxbXTYLwaDRuRleXejBn5lrTW1u
         vvyfR/hT7GixFsv2mGzQE8TPLCIQlLjOboHPKf2mVC9BWqVF9l0Yx4djWb1VO29xKqTO
         fTFJv3xmkwBwsL4pvWdDdPPNWxIpzaD3usQ/qmsy91JvF3LgoPkwZpwrolGDQ9wgSJuy
         BOwwgqtad2cePmm2ZPh8O3akZS5rnlpf3PF160HCqoWG+++mfvdTjxuSnc09WggqghK7
         8vqBG8qW5Cn5AzdiVFFmIyQdP8u9nyBbIW24K+FP8lskKt0rMVWmlVwrFKMub5qaVfcQ
         rTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651681; x=1691243681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8rVh13OFs9h1WXgdRFpacqzMIIEv1x17FSavnL+MZI=;
        b=GwTIJJD2QAZyApO51G9Yyojm4Ly0m93Pby/zeif8/nTsJqCFoaH9Ja+j9fYZ4769iw
         u07G0ynzWuJFgN46SIY0pu9T5g4YWBe6aM/gDn9AoI3Xgrays2BQ+kGrGZJO+Tj5lmKC
         DrV9YvAoiS0ySEKDGOUFIghKL/9IdPZTM4W4tbKa0B6BvpEVTZIk/XDYv2EayXtMjSMk
         5bFaohlALiMhW2gVJM5YfuGQD2gF2xdDEJG4YWi6ihrAk2b0CAOnRfczdLAsUXYguApX
         Zt6TfpM8bxbADNZgnVeA7W6WaR+qHxhTZCnaK5RhQ4xTj9exJH9f932pf6/8RxCyZ+cd
         +gRQ==
X-Gm-Message-State: ABy/qLYTI/U7LTyPCmvsd+tuDjH4NiHM3U/svKG+aYwGuFJhJ4EhxQeW
        vQzmEj2tsOTtOp+FXIdm177n
X-Google-Smtp-Source: APBJJlEGt2AAM9qhoBkd5VIwoPcmyDMKp6rjunJhI0p+cXGwqG3H7KYWOjzFlcyOiToO86p14TD03A==
X-Received: by 2002:a17:902:cec6:b0:1b8:64a9:ea60 with SMTP id d6-20020a170902cec600b001b864a9ea60mr1522314plg.53.1688651680835;
        Thu, 06 Jul 2023 06:54:40 -0700 (PDT)
Received: from thinkpad ([117.216.120.100])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170902efd600b001b55c0548dfsm1468705plb.97.2023.07.06.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:54:40 -0700 (PDT)
Date:   Thu, 6 Jul 2023 19:24:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "clk: gcc-sc8280xp: keep PCIe power-domains
 always-on"
Message-ID: <20230706135434.GE4808@thinkpad>
References: <20230706124700.12447-1-manivannan.sadhasivam@linaro.org>
 <ZKbDztmNp-KMXTDu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKbDztmNp-KMXTDu@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:38:22PM +0200, Johan Hovold wrote:
> On Thu, Jul 06, 2023 at 06:17:00PM +0530, Manivannan Sadhasivam wrote:
> > This reverts commit 12d2a4769380f0dc9ba6f827839869db2b81ef00.
> 
> Please update the commit summary and remove or rephrase the above as
> direct reverts are typically used for patches that were broken or causes
> trouble (e.g rephrase as "allow pcie gdsdc to be disabled" or similar).
> 
> The patch in question was correct at the time even if it may no longer
> be required, but see below.
> 

Ok!

> > With the minimal system suspend support in place for the PCIe driver that
> > keeps the interconnect path active, the ALWAYS_ON flags can now be dropped.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> > index 04a99dbaa57e..07eb6110442c 100644
> > --- a/drivers/clk/qcom/gcc-sc8280xp.c
> > +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> > @@ -6774,10 +6774,6 @@ static struct gdsc pcie_1_tunnel_gdsc = {
> >  	.flags = VOTABLE,
> >  };
> >  
> > -/*
> > - * The Qualcomm PCIe driver does not yet implement suspend so to keep the
> > - * PCIe power domains always-on for now.
> > - */
> >  static struct gdsc pcie_2a_gdsc = {
> >  	.gdscr = 0x9d004,
> >  	.collapse_ctrl = 0x52128,
> > @@ -6786,7 +6782,7 @@ static struct gdsc pcie_2a_gdsc = {
> >  		.name = "pcie_2a_gdsc",
> >  	},
> >  	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE | ALWAYS_ON,
> > +	.flags = VOTABLE,
> >  };
> 
> Are you sure this is correct? Won't the controller state be lost if the
> GDSC is powered off during suspend? Shouldn't this be PWRSTS_RET_ON at
> least?
> 

Doh! Yes, I missed that. Will add it in v2.

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
