Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9A6B9605
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjCNNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjCNNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:23:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FF59E59
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:20:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1160660pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BGeO30lDzCVJA69wB0isBNBFflJKSvmbp2xv2YwkISg=;
        b=N8yB/hmvUwDNq4U380ZLQ/mBfJ3N6JqFs3E/DfzHd0EcSB/ROMEZ2X7Mbu/wDPqOSt
         X8hTWoryi7yHzP8voZRYRbbDJsmNC+QM5Ti/3R04qvFB+Wjq5EhxdtHasmw3z5REC+fX
         z+27vRr9MvJHV8ilBrWb9Fut8/r29WNrfZiRm0pX1fgRXEIfkUIpf3P0cH5ZnOrZrBLs
         2xPLfg/0K76pjejtBJovbOoVqa6XCgL8nnC4LWPxp3n93CDj7JqGOKDouu26VHIg9mxy
         NpT7hPDC4lxHQM4EzkypVTQsGklqNHuc3QMjmcLVeiirqBXE312jbNOBJN1GhDmwurCI
         Dxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGeO30lDzCVJA69wB0isBNBFflJKSvmbp2xv2YwkISg=;
        b=FmcdkyKvCO8CPbafS1ZqTwYz+tdHsNamuOqWoZDJt6tMetnt/xmuEq02os27XdooEm
         yOGPF6eQsyB2fBiNhkLI/DN0lJY2P7M78QD/7BEhFmAsy6GFKW557EeXyLI/Ou6MOpEi
         oc0GlbM0ihhnZpPMrT3pwBWjsNNVD+aJsTApxBVGaniPlUtlgQAs/G7hEwqHdtDpWwx0
         3FU9mE1thwggNbkmJRzQyTA77Y/ufx5Dj5x0/dipzjeu3UROML2y+8HSOYqR1RBB2DES
         GCcFOM2tx1k2pyhW9S8WftjAKCSeE9P/3ZrfTuPf3t/jCMiccqluHLhmLRzWIxUCieUP
         1VEg==
X-Gm-Message-State: AO0yUKUfP9juOtHB++XWeUHLp9KSMQN4EAFzbJSKDVAzEtlnwrkMjqYC
        OqAeGMwaSximMpEeM/0xGOdU
X-Google-Smtp-Source: AK7set92BKgWo9k7vOJJuH6sMlRcRQA156L8+Pr2OYvSE4DfETPPXr/PPN/jNfis14C4iqN8TK+aXg==
X-Received: by 2002:a17:903:2341:b0:1a0:6d96:d62f with SMTP id c1-20020a170903234100b001a06d96d62fmr1502663plh.2.1678800027391;
        Tue, 14 Mar 2023 06:20:27 -0700 (PDT)
Received: from thinkpad ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b0019251e959b1sm1716382pld.262.2023.03.14.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:20:26 -0700 (PDT)
Date:   Tue, 14 Mar 2023 18:50:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Johan Hovold <johan@kernel.org>, will@kernel.org, joro@8bytes.org,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230314132018.GC137001@thinkpad>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
 <20230314112620.GB137001@thinkpad>
 <13b46d42-e497-8dd7-4785-f58447128a40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13b46d42-e497-8dd7-4785-f58447128a40@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:58:24AM +0000, Robin Murphy wrote:
> On 2023-03-14 11:26, Manivannan Sadhasivam wrote:
> > On Tue, Mar 14, 2023 at 12:17:38PM +0100, Johan Hovold wrote:
> > > On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> > > > The logic used to find the quirky firmware that intercepts the writes to
> > > > S2CR register to replace bypass type streams with a fault, and ignore the
> > > > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > > > 
> > > > The current logic uses the last stream mapping group (num_mapping_groups
> > > > - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> > > > reports a value of 162 (possibly emulated by the hypervisor) and logic is
> > > > not working for stream mapping groups > 128. (Note that the ARM SMMU
> > > > architecture specification defines NUMSMRG in the range of 0-127).
> > > > 
> > > > So the current logic that checks the (162-1)th S2CR entry fails to detect
> > > > the quirky firmware on these devices and SMMU triggers invalid context
> > > > fault for bypass streams.
> > > > 
> > > > To fix this issue, rework the logic to find the first non-valid (free)
> > > > stream mapping register group (SMR) within 128 groups and use that index
> > > > to access S2CR for detecting the bypass quirk. If no free groups are
> > > > available, then just skip the quirk detection.
> > > > 
> > > > While at it, let's move the quirk detection logic to a separate function
> > > > and change the local variable name from last_s2cr to free_s2cr.
> > > > 
> > > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > > 
> > > > * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> > > > * Moved the quirk handling to its own function
> > > > * Collected review tag from Bjorn
> > > > 
> > > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
> > > >   1 file changed, 40 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > index d1b296b95c86..48362d7ef451 100644
> > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > > @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> > > >   	return 0;
> > > >   }
> > > > -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > > +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
> > > >   {
> > > > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> > > >   	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > > > -	u32 reg;
> > > > -	u32 smr;
> > > > +	u32 free_s2cr;
> > > > +	u32 reg, smr;
> > > >   	int i;
> > > > +	/*
> > > > +	 * Find the first non-valid (free) stream mapping register group and
> > > > +	 * use that index to access S2CR for detecting the bypass quirk.
> > > > +	 *
> > > > +	 * Note that only the first 128 stream mapping groups are considered for
> > > > +	 * the check. This is because the ARM SMMU architecture specification
> > > > +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> > > > +	 * groups with the help of hypervisor. And those groups don't exhibit
> > > > +	 * the quirky behavior.
> > > > +	 */
> > > > +	for (i = 0; i < 128; i++) {
> > > 
> > > This may now access registers beyond smmu->num_mapping_groups. Should
> > > you not use the minimum of these two values here (and below)?
> > > 
> > 
> > Doh! yeah, you're right. Will fix it in v3.
> 
> FWIW I'd say it's probably best if the cfg_probe hook clamps
> smmu->num_mapping_groups to the architectural maximum straight away, to also
> prevent the main driver iterating off into the nonsensical area in
> arm_smmu_device_reset() or the SMR allocator itself.
> 

We considered that also but Qcom purposefully extended the NUMSMRG for
virtualization usecase and we do not have a clear picture of it. That's the
reason we settled with capping the value only for the quirk detection.

Thanks,
Mani

> (Note that we don't support the weird EXSMRGS extension that appeared in a
> late version of the architecture, but even if we did, that still reports 128
> for IDR0.NUMSMRG, and the extra extended SMRs live somewhere completely
> different.)
> 
> Thanks,
> Robin.

-- 
மணிவண்ணன் சதாசிவம்
