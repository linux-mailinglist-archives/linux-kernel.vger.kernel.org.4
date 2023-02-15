Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6AA697CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjBONIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBONIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:08:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039239287
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CF67B821F9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25876C433EF;
        Wed, 15 Feb 2023 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466443;
        bh=+hwO7JErfYD4tISTCHkKL1+A6053koS9PX7XC0ujeYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3EhsgsZn0VTwpxr63gGNBnxf8CoaEmcUge3otJJ6MWz5zRz+LI3pc69Zbrxcg+te
         eo6dq34XdS7Ni/ySYttdumSi0fK2VlgBMm0pBqEBaVpbemjguqBpQ2UlWDhZFERr0z
         Syi5Kp2osRKtcJSwWEhS8UJTpzD1HJsrvzCrWL01Qd1cG7nW3y0iIXbgk5lVJcTrAN
         dqKgmn05rtTpvkjr6CZFFi77NSiSO3grK/dI0vP30bIJoyIejtmlfafTBwkAYBA8VA
         5RlcF//1vvYgHZeHMGq7vWy7G0G7WvXd9HDblUY/U8MA7tH076/wQ68GKvpSWTwkTq
         5unmPNdr8X9AQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSHWF-0002Ri-Q4; Wed, 15 Feb 2023 14:08:19 +0100
Date:   Wed, 15 Feb 2023 14:08:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Rework the logic finding the bypass
 quirk
Message-ID: <Y+zZQ0PKW1d2XGbW@hovoldconsulting.com>
References: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>
 <Y+pozM9iTbQcx6cl@hovoldconsulting.com>
 <20230214075312.GB4981@thinkpad>
 <Y+tPWAUBwBxcOPFm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tPWAUBwBxcOPFm@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:07:36AM +0100, Johan Hovold wrote:
> On Tue, Feb 14, 2023 at 01:23:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 13, 2023 at 05:43:56PM +0100, Johan Hovold wrote:
> > > On Wed, Feb 01, 2023 at 01:55:00PM +0530, Manivannan Sadhasivam wrote:
> > > > The logic used to find the quirky firmware that intercepts the writes to
> > > > S2CR register to replace bypass type streams with a fault, and ignore the
> > > > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > > > 
> > > > The current logic uses the last stream mapping group (num_mapping_groups
> > > > - 1) as an index for finding quirky firmware. But on SC8280XP, this
> > > > logic is not working as the number of stream mapping groups reported by
> > > > the SMMU (163 as on the SC8280XP-CRD device) is not valid for some reason.
> > > 
> > > NUMSMRG read back as 162 here, both on my CRD and X13s. Was '163' a typo
> > > or a real difference?
> > > 
> > 
> > Ah yes, it is 162 indeed. Sorry, typo!
> > 
> > > > So the current logic that checks the (163-1) S2CR entry fails to detect
> > > > the quirky firmware on these devices and triggers invalid context fault
> > > > for bypass streams.
> > > > 
> > > > To fix this issue, rework the logic to find the first non-valid (free)
> > > > stream mapping register group (SMR) and use that index to access S2CR
> > > > for detecting the bypass quirk.
> > > 
> > > So while this works for the quirk detection, shouldn't we also do
> > > something about that bogus NUMSMRG value? At least cap it at 128, which
> > > appears to be the maximum according to the specification, for example,
> > > by clearing bit 7 when any of the lower bits are set?
> > > 
> > > That would give us 35 (or 36) groups and working quirk detection with
> > > just the following smaller patch:
> > > 
> > 
> > I'm not certain if the value is bogus or not. It is clear that the spec
> > specifies 128 as the max but internal qcom document shows that they indeed
> > set 162 on purpose in the hypervisor.
> >
> > So until we get a clear view on that, I'd not cap it.
> 
> But if we fault as soon as we try to do something with those register
> groups above 128 that also violate the spec, it doesn't seem right to
> trust the fw value here.

I realised that the fault is due to the quirk not being detected
properly as writes to groups above index 127 apparently succeeds
(including out-of-bounds index 162):

	qcom_smmu_cfg_probe - index = 127, reg = 200ff, type = 02
	qcom_smmu_cfg_probe - index = 128, reg = 100ff, type = 01
	qcom_smmu_cfg_probe - index = 161, reg = 100ff, type = 01
	qcom_smmu_cfg_probe - index = 162, reg = 100ff, type = 01

So leaving smmu->num_mapping_groups unchanged for now and using the
first available group for the detection indeed seems like the right
thing to do here (alternatively, never use an index above 127).

But perhaps you can update to commit message to reflect this finding
(i.e. that the num groups value is probably bogus, and that you at least
need to use an index < 128 for quirk detection).

By the way, I noticed that the number of groups is reported as 162 on
the sa8295p-adp as well.

> > > > This also warrants a change in variable name from last_s2cr to free_s2cr.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++-----
> > > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > index 78fc0e1bf215..4104f81b8d8f 100644
> > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > @@ -267,23 +267,37 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> > > >  
> > > >  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > >  {
> > > > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> > > >  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > > > +	u32 free_s2cr;
> > > >  	u32 reg;
> > > >  	u32 smr;
> > > >  	int i;
> > > >  
> > > > +	/*
> > > > +	 * Find the first non-valid (free) stream mapping register group and
> > > > +	 * use that index to access S2CR for detecting the bypass quirk.
> > > > +	 */
> > > > +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> > > > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > > > +
> > > > +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	free_s2cr = ARM_SMMU_GR0_S2CR(i);
> > > 
> > > In the unlikely event that there is no free group this would access an
> > > invalid index.
> > > 
> > 
> > Hmm, theoretically yes. But what would be the plan of action if that happens?
> > Should we just bail out with error or skip the quirk detection?
> 
> Yes, skipping quirk detection seems preferable to crashing systems that
> don't need the quirk.

Perhaps you can move the quirk handling to its own function and simply
return early in case there is no free group.

Johan
