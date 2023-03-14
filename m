Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BA6B97FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCNOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCNO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B6ADC0A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 959F861602
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAEFC433D2;
        Tue, 14 Mar 2023 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678804136;
        bh=/Iq//iCK0bVlqx/zpdfToe3BwDvo8FQOdCVBLjm9TCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdDG16REkS4SyMTNnDP9HVcbJ9Nn9eiETqfuLnzmjpwxOyfEvYG+DaQKqNEOwJmF2
         Icld3GCNbebVRkvOGnfV3bp6RWcXERsysEPUdoWK82sGqHRFAL40JsYDKOO8q2Iy+X
         ZFkjzbV2cIy+tbTVe+TRQxITs5ry+Os9m1u9bKpvMUNrcdAVERX6kQY97u2KCAPCbl
         Jg0ikmwViyTT70hChjBnotJkT50I/GeNrY6zhK78lj16IbmQlmmFe40f5TR9hGToWg
         gvFwPQgkgqSdXrClJQqGLidlrtnPqMW+5y/HMZokuQBJvOJKQVR2SWDVGRwQmyU4SH
         fjMFLlfElkjHQ==
Date:   Tue, 14 Mar 2023 07:32:18 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>, will@kernel.org,
        joro@8bytes.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230314143218.fl3hedg336iofv3n@ripper>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
 <20230314112620.GB137001@thinkpad>
 <13b46d42-e497-8dd7-4785-f58447128a40@arm.com>
 <20230314132018.GC137001@thinkpad>
 <a81515c5-c88c-e3c2-2077-0a78b900bbe5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81515c5-c88c-e3c2-2077-0a78b900bbe5@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:41:56PM +0000, Robin Murphy wrote:
> On 2023-03-14 13:20, Manivannan Sadhasivam wrote:
> > On Tue, Mar 14, 2023 at 11:58:24AM +0000, Robin Murphy wrote:
> > > On 2023-03-14 11:26, Manivannan Sadhasivam wrote:
> > > > On Tue, Mar 14, 2023 at 12:17:38PM +0100, Johan Hovold wrote:
> > > > > On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> > > > > > The logic used to find the quirky firmware that intercepts the writes to
> > > > > > S2CR register to replace bypass type streams with a fault, and ignore the
> > > > > > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > > > > > 
> > > > > > The current logic uses the last stream mapping group (num_mapping_groups
> > > > > > - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> > > > > > reports a value of 162 (possibly emulated by the hypervisor) and logic is
> > > > > > not working for stream mapping groups > 128. (Note that the ARM SMMU
> > > > > > architecture specification defines NUMSMRG in the range of 0-127).
> > > > > > 
> > > > > > So the current logic that checks the (162-1)th S2CR entry fails to detect
> > > > > > the quirky firmware on these devices and SMMU triggers invalid context
> > > > > > fault for bypass streams.
> > > > > > 
> > > > > > To fix this issue, rework the logic to find the first non-valid (free)
> > > > > > stream mapping register group (SMR) within 128 groups and use that index
> > > > > > to access S2CR for detecting the bypass quirk. If no free groups are
> > > > > > available, then just skip the quirk detection.
> > > > > > 
> > > > > > While at it, let's move the quirk detection logic to a separate function
> > > > > > and change the local variable name from last_s2cr to free_s2cr.
> > > > > > 
> > > > > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > > 
> > > > > > Changes in v2:
> > > > > > 
> > > > > > * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> > > > > > * Moved the quirk handling to its own function
> > > > > > * Collected review tag from Bjorn
> > > > > > 
> > > > > >    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
> > > > > >    1 file changed, 40 insertions(+), 8 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > index d1b296b95c86..48362d7ef451 100644
> > > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > > > @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> > > > > >    	return 0;
> > > > > >    }
> > > > > > -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > > > > +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
> > > > > >    {
> > > > > > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> > > > > >    	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > > > > > -	u32 reg;
> > > > > > -	u32 smr;
> > > > > > +	u32 free_s2cr;
> > > > > > +	u32 reg, smr;
> > > > > >    	int i;
> > > > > > +	/*
> > > > > > +	 * Find the first non-valid (free) stream mapping register group and
> > > > > > +	 * use that index to access S2CR for detecting the bypass quirk.
> > > > > > +	 *
> > > > > > +	 * Note that only the first 128 stream mapping groups are considered for
> > > > > > +	 * the check. This is because the ARM SMMU architecture specification
> > > > > > +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > > > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> > > > > > +	 * groups with the help of hypervisor. And those groups don't exhibit
> > > > > > +	 * the quirky behavior.
> > > > > > +	 */
> > > > > > +	for (i = 0; i < 128; i++) {
> > > > > 
> > > > > This may now access registers beyond smmu->num_mapping_groups. Should
> > > > > you not use the minimum of these two values here (and below)?
> > > > > 
> > > > 
> > > > Doh! yeah, you're right. Will fix it in v3.
> > > 
> > > FWIW I'd say it's probably best if the cfg_probe hook clamps
> > > smmu->num_mapping_groups to the architectural maximum straight away, to also
> > > prevent the main driver iterating off into the nonsensical area in
> > > arm_smmu_device_reset() or the SMR allocator itself.
> > > 
> > 
> > We considered that also but Qcom purposefully extended the NUMSMRG for
> > virtualization usecase and we do not have a clear picture of it.
> 
> Whatever that supposed use-case may be, Linux does not support it, and
> clearly isn't going to support it any time soon if we don't even know what

Can you please elaborate on what it is that would prevent Linux to
handle hardware with more than 128 SMRs?

> it is. Therefore Linux does not need to accommodate this weirdness for the
> foreseeable future, beyond simply making sure it doesn't cause any problems
> for what Linux *does* support. It's bad enough that the emulation of
> "normal" SMRs continues to violate the architecture, but I'm even more
> uncomfortable letting the generic architecture driver poke at completely
> non-architectural registers which don't even have the same behaviour as the
> ones they're supposedly extending.

Afaict there's nothing special about the SMRs beyond 128 on this
platform...

Thanks,
Bjorn

> 
> Thanks,
> Robin.
> 
> > That's the
> > reason we settled with capping the value only for the quirk detection.
> > 
> > Thanks,
> > Mani
> > 
> > > (Note that we don't support the weird EXSMRGS extension that appeared in a
> > > late version of the architecture, but even if we did, that still reports 128
> > > for IDR0.NUMSMRG, and the extra extended SMRs live somewhere completely
> > > different.)
> > > 
> > > Thanks,
> > > Robin.
> > 
