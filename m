Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A27695E45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBNJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjBNJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:08:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22979241DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:07:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83C2AB81CA1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F5FC4339B;
        Tue, 14 Feb 2023 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676365604;
        bh=kp1wVIwcdvhNcVUnIXnS31Y8JKlXiQHAlaDN5T+0ibM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4ewpXF7SjWjM+mb44swT+LqkLRokikcBkPsFkRTGptgmYyFy+SRvG4LiW/il+X79
         k7xtdgIK2/YXfWze9ZalwbeL5114R9T1x9y0/NwyTHJ6iU5x8thP7fM4X31lphbSMy
         N8gBbP92PzVRl5Z5abUZQJivPclFdsKA7R4GJTm5NJ0RNYq7fBEoz/WGtWIw5V46Ox
         1UiV37T90KUrCzF76Z3Ekoc3HVri/NWChojUunn+nf5RK8sGwek8B+xDHXat7SdRoS
         m9QGI/tYgV56tzox2iUHajoy+7tpdTID8zEdRQA/juASftcp48cZ7pi1+ixEDN/HTs
         G2plgh7se8R/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pRrHk-0002ld-VL; Tue, 14 Feb 2023 10:07:37 +0100
Date:   Tue, 14 Feb 2023 10:07:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Rework the logic finding the bypass
 quirk
Message-ID: <Y+tPWAUBwBxcOPFm@hovoldconsulting.com>
References: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>
 <Y+pozM9iTbQcx6cl@hovoldconsulting.com>
 <20230214075312.GB4981@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214075312.GB4981@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:23:12PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 13, 2023 at 05:43:56PM +0100, Johan Hovold wrote:
> > On Wed, Feb 01, 2023 at 01:55:00PM +0530, Manivannan Sadhasivam wrote:
> > > The logic used to find the quirky firmware that intercepts the writes to
> > > S2CR register to replace bypass type streams with a fault, and ignore the
> > > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > > 
> > > The current logic uses the last stream mapping group (num_mapping_groups
> > > - 1) as an index for finding quirky firmware. But on SC8280XP, this
> > > logic is not working as the number of stream mapping groups reported by
> > > the SMMU (163 as on the SC8280XP-CRD device) is not valid for some reason.
> > 
> > NUMSMRG read back as 162 here, both on my CRD and X13s. Was '163' a typo
> > or a real difference?
> > 
> 
> Ah yes, it is 162 indeed. Sorry, typo!
> 
> > > So the current logic that checks the (163-1) S2CR entry fails to detect
> > > the quirky firmware on these devices and triggers invalid context fault
> > > for bypass streams.
> > > 
> > > To fix this issue, rework the logic to find the first non-valid (free)
> > > stream mapping register group (SMR) and use that index to access S2CR
> > > for detecting the bypass quirk.
> > 
> > So while this works for the quirk detection, shouldn't we also do
> > something about that bogus NUMSMRG value? At least cap it at 128, which
> > appears to be the maximum according to the specification, for example,
> > by clearing bit 7 when any of the lower bits are set?
> > 
> > That would give us 35 (or 36) groups and working quirk detection with
> > just the following smaller patch:
> > 
> 
> I'm not certain if the value is bogus or not. It is clear that the spec
> specifies 128 as the max but internal qcom document shows that they indeed
> set 162 on purpose in the hypervisor.
>
> So until we get a clear view on that, I'd not cap it.

But if we fault as soon as we try to do something with those register
groups above 128 that also violate the spec, it doesn't seem right to
trust the fw value here.

Clarification from Qualcomm would be good either way, but if they are
indication that it's not just a bug that has left bit 7 set then
limiting to 128 also seems reasonable (i.e. not by clearing the high
bit, but by using the minimum of 128 and size below).

> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 2ff7a72cf377..0f564a86c352 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -1744,6 +1744,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >                         return -ENODEV;
> >                 }
> >  
> > +               if (size > 0x80) {
> > +                       dev_warn(smmu->dev,
> > +                                "invalid number of SMR groups, clearing bit 7\n");
> > +                       size -= 0x80;
> > +               }
> > +
> >                 /* Zero-initialised to mark as invalid */
> >                 smmu->smrs = devm_kcalloc(smmu->dev, size, sizeof(*smmu->smrs),
> >                                           GFP_KERNEL);
> > 
> > I also verified that using index 127 (group 128) for the quirk detection
> > works on my CRD, while the invalid index 128 fails (as do index 161
> > which would currently be used).
> > 
> > > This also warrants a change in variable name from last_s2cr to free_s2cr.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++-----
> > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index 78fc0e1bf215..4104f81b8d8f 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -267,23 +267,37 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> > >  
> > >  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > >  {
> > > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> > >  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > > +	u32 free_s2cr;
> > >  	u32 reg;
> > >  	u32 smr;
> > >  	int i;
> > >  
> > > +	/*
> > > +	 * Find the first non-valid (free) stream mapping register group and
> > > +	 * use that index to access S2CR for detecting the bypass quirk.
> > > +	 */
> > > +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> > > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > > +
> > > +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > > +			break;
> > > +	}
> > > +
> > > +	free_s2cr = ARM_SMMU_GR0_S2CR(i);
> > 
> > In the unlikely event that there is no free group this would access an
> > invalid index.
> > 
> 
> Hmm, theoretically yes. But what would be the plan of action if that happens?
> Should we just bail out with error or skip the quirk detection?

Yes, skipping quirk detection seems preferable to crashing systems that
don't need the quirk.

Johan
