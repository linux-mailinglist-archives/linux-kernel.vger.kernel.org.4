Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8D6C4110
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVDcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVDct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12911B56E;
        Tue, 21 Mar 2023 20:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7711661F2D;
        Wed, 22 Mar 2023 03:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62957C433D2;
        Wed, 22 Mar 2023 03:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455967;
        bh=Hv8uuxPed8cDil9ZlKctjs7XigVOW2MRe21lYKtwHnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRyT6SOye5XyUwNVuFLu4gngAziCq+5ZMs4Xb4nda8xTQ2Oghi7F0TIw7v4pT+kwR
         pBuMKBNjJO+IqSmwoqj0Rbkj7mHkaa351wIF2JTu+HY2N8PMaN5GRTcdd01LcYA81b
         lOCSLWQXo0jRoO+U4kREBass8gFRAPIvh8ILUo29GaXW0spuWbvxBqruXBDLwMqS6/
         dfn10ptB25T6yIADgF2NBcZ3GXwVRuSAq9eptsCI6aemEeoq6SRrDezx3rhrq/U4Sa
         uiyN1gg9/mx88bvONsyEKzRTKZweAJJT/lwrfxBhBrNen5ohXUHeyk18kpi2usOb2V
         v6hqk8dCNPWgA==
Date:   Tue, 21 Mar 2023 20:36:00 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: Add SM6375 compatible
Message-ID: <20230322033600.mkfeldd7oftpm32d@ripper>
References: <20230307012247.3655547-1-konrad.dybcio@linaro.org>
 <ca7a9708-8909-d663-d02f-240f8087aa9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7a9708-8909-d663-d02f-240f8087aa9a@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:13:53PM +0100, Konrad Dybcio wrote:
> 
> 
> On 7.03.2023 02:22, Konrad Dybcio wrote:
> > While it was introduced in bindings, requiring a core clock, and added
> > into the DT, this compatible was apparently forgotten about on the driver
> > side of things. Fix it.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  drivers/firmware/qcom_scm.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 916a0c2fc903..2e8961c84b68 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -1494,6 +1494,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
> >  	},
> >  	{ .compatible = "qcom,scm-msm8994" },
> >  	{ .compatible = "qcom,scm-msm8996" },
> > +	{ .compatible = "qcom,scm-sm6375", .data = (void *)SCM_HAS_CORE_CLK },
> On a second thought, maybe the qcom,scm compatible could optionally consume
> all three clocks with schema guarding how many should be used, to prevent
> having to add nonsensical compatibles?
> 

I've picked the patch, but your suggestion is not a bad idea. Back when
this scheme was decided there was no binding validation...

Regards,
Bjorn

> Konrad
> >  	{ .compatible = "qcom,scm" },
> >  	{}
> >  };
