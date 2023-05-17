Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7238706C03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjEQPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjEQPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:01:48 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06AD84E;
        Wed, 17 May 2023 08:00:33 -0700 (PDT)
Received: from g550jk.localnet (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B99AECE0B8;
        Wed, 17 May 2023 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684335570; bh=b+cK+yIredBclcZLDhIrSKK1DPiHez1yG+yF+QpEoIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dwp2HpAqySkhm6KLTWLtXtB124Zj7Xpxw0ZItIvaTZF0S1HEPdLbMbjIrKYOBRZbz
         hZBTrKZwbig8CtBwGP23KUmU7+F9VM4+PDzgP9RE2eq9hOjdNkZi8nuqmOrJkf7Zhu
         OT0QpD4A5WpyPqaF1yrRPqfu3GNRE5p0n2GyM6BM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: smd-rpm: conditionally enable scaling before doing
 handover
Date:   Wed, 17 May 2023 16:59:29 +0200
Message-ID: <2679120.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <20bd79c1-6c38-f1ed-1661-6fa4c308c5c5@linaro.org>
References: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
 <20bd79c1-6c38-f1ed-1661-6fa4c308c5c5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 16. Mai 2023 03:27:46 CEST Konrad Dybcio wrote:
> On 6.05.2023 22:10, Luca Weiss wrote:
> > On older platforms like msm8226, msm8974 and msm8916 the driver in the
> > downstream kernel enables scaling first before doing the handover of the
> > clocks.
> > 
> > While this normally doesn't seem to cause noticeable problems, on
> > apq8026-asus-sparrow this causes the device to immediately reboot,
> > perhaps due to older rpm firmware that becomes unhappy.
> > 
> > On newer platforms the order has swapped and enabling scaling is done
> > after the handover, so let's introduce this behavior only conditionally
> > for msm8226 and msm8974 for now.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> 
> Did you give this a spin on some 8974? I think hammerhead had
> issues around rpmcc in the past..

Yes, appears to be fine on msm8974 also.

I tried to reproduce the hammerhead ocmem hang we had in the past but even 
with v6.3 rpmcc it seems to be fine. But iirc it was happening more or less at 
random in the past so wouldn't be surprised if my tests just didn't show 
anything on accident.

Regards
Luca

> 
> Konrad
> 
> >  drivers/clk/qcom/clk-smd-rpm.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-smd-rpm.c
> > b/drivers/clk/qcom/clk-smd-rpm.c index 887b945a6fb7..6d5476afc4d1 100644
> > --- a/drivers/clk/qcom/clk-smd-rpm.c
> > +++ b/drivers/clk/qcom/clk-smd-rpm.c
> > @@ -178,6 +178,7 @@ struct clk_smd_rpm_req {
> > 
> >  struct rpm_smd_clk_desc {
> >  
> >  	struct clk_smd_rpm **clks;
> >  	size_t num_clks;
> > 
> > +	bool scaling_before_handover;
> > 
> >  };
> >  
> >  static DEFINE_MUTEX(rpm_smd_clk_lock);
> > 
> > @@ -693,6 +694,7 @@ static struct clk_smd_rpm *msm8974_clks[] = {
> > 
> >  static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
> >  
> >  	.clks = msm8974_clks,
> >  	.num_clks = ARRAY_SIZE(msm8974_clks),
> > 
> > +	.scaling_before_handover = true,
> > 
> >  };
> >  
> >  static struct clk_smd_rpm *msm8976_clks[] = {
> > 
> > @@ -1318,6 +1320,12 @@ static int rpm_smd_clk_probe(struct platform_device
> > *pdev)> 
> >  	rpm_smd_clks = desc->clks;
> >  	num_clks = desc->num_clks;
> > 
> > +	if (desc->scaling_before_handover) {
> > +		ret = clk_smd_rpm_enable_scaling(rpm);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > 
> >  	for (i = 0; i < num_clks; i++) {
> >  	
> >  		if (!rpm_smd_clks[i])
> >  		
> >  			continue;
> > 
> > @@ -1329,9 +1337,11 @@ static int rpm_smd_clk_probe(struct platform_device
> > *pdev)> 
> >  			goto err;
> >  	
> >  	}
> > 
> > -	ret = clk_smd_rpm_enable_scaling(rpm);
> > -	if (ret)
> > -		goto err;
> > +	if (!desc->scaling_before_handover) {
> > +		ret = clk_smd_rpm_enable_scaling(rpm);
> > +		if (ret)
> > +			goto err;
> > +	}
> > 
> >  	for (i = 0; i < num_clks; i++) {
> >  	
> >  		if (!rpm_smd_clks[i])
> > 
> > ---
> > base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
> > change-id: 20230506-rpmcc-scaling-handover-a63029ed9d13
> > 
> > Best regards,




