Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F012695B38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBNHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjBNHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:53:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAEC3A96
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:53:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso6849348pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7q20+SNXT2AMtnhltu6WLGIIunSDfG6EAHJrNxTXkcc=;
        b=RQfRhtsBF00rc7XBryAEKIPojZtinvL6x3xfeKP2z704501dj2CDpFne1Rb+gkY6y+
         wQ6BeU18myH7bpAhqoOtMEypP9sy9SzVjefDJFKTcZgWwuS1lSpwADKMCU768o5H7Xvv
         KGD/bcsxkWRQWIdKwj6Q1djiKeGiy6qhb4qHVeVLcGB1fPDM3sC/OXeSyxVHk0IXh4YS
         EPLZKos4xMDabM+X5/iuMqeZkxv+4j2emVS/+WwgEN66s9dxLvFAjdvNwu9s+tu9bEgR
         rVjjp0dF/Vh03nZvjpJ7n2+DxW8NlwcH0ZgKD5NOTsv9HzSuJdOg+sslUAUFe/22GUUo
         VSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q20+SNXT2AMtnhltu6WLGIIunSDfG6EAHJrNxTXkcc=;
        b=Um8JuLqmG8F8GgnAxFgIexQw7/ycG4DJNp2qgcDeFSw4cfzPno2rl4cMOC6vVUZ10V
         iDq9c2aOAUUN/CIWrREbW9tqQrIfRtyz7FeJ7k2KdsGSFEBylGhw75CKVzBYD+t10VWL
         cymLwuXypq0IftRHqgRQYJb6wvulmK2Yt4IG1N5CPPhoBW9fILD8bBVqDyoLJ/9gRSXr
         GWp+syRKcHuzzQhmjaAsDC0NqG+gWhMLKXMRpa8xAMrS3wM0Ak7qxVgnCvPSnYv7L4DK
         WnTrlUmWt/0K+7j3ILsu3gJxKi14o9AxQ8M7aSe6EecifQa9RKnFJqj6SV4QHaulZXSI
         XzRQ==
X-Gm-Message-State: AO0yUKWiqnJ/Dh5hp7Aqff6zknaSXEchD9HXaeufnH8bs1k7Fjjy2v8t
        UcMsDN3HWguQdhfvqjS/vDmM
X-Google-Smtp-Source: AK7set+eT6+n3qyGsgE7ZX/AJoq2siIymbp5DKA1AsgWDfgj/m9HcIoZBdJgfq0nYmeThBKMXx909A==
X-Received: by 2002:a17:902:d485:b0:19a:b4f9:6cd with SMTP id c5-20020a170902d48500b0019ab4f906cdmr1895882plg.48.1676361199523;
        Mon, 13 Feb 2023 23:53:19 -0800 (PST)
Received: from thinkpad ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id jn3-20020a170903050300b00180033438a0sm9524798plb.106.2023.02.13.23.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:53:19 -0800 (PST)
Date:   Tue, 14 Feb 2023 13:23:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Rework the logic finding the bypass
 quirk
Message-ID: <20230214075312.GB4981@thinkpad>
References: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>
 <Y+pozM9iTbQcx6cl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+pozM9iTbQcx6cl@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:43:56PM +0100, Johan Hovold wrote:
> On Wed, Feb 01, 2023 at 01:55:00PM +0530, Manivannan Sadhasivam wrote:
> > The logic used to find the quirky firmware that intercepts the writes to
> > S2CR register to replace bypass type streams with a fault, and ignore the
> > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > 
> > The current logic uses the last stream mapping group (num_mapping_groups
> > - 1) as an index for finding quirky firmware. But on SC8280XP, this
> > logic is not working as the number of stream mapping groups reported by
> > the SMMU (163 as on the SC8280XP-CRD device) is not valid for some reason.
> 
> NUMSMRG read back as 162 here, both on my CRD and X13s. Was '163' a typo
> or a real difference?
> 

Ah yes, it is 162 indeed. Sorry, typo!

> > So the current logic that checks the (163-1) S2CR entry fails to detect
> > the quirky firmware on these devices and triggers invalid context fault
> > for bypass streams.
> > 
> > To fix this issue, rework the logic to find the first non-valid (free)
> > stream mapping register group (SMR) and use that index to access S2CR
> > for detecting the bypass quirk.
> 
> So while this works for the quirk detection, shouldn't we also do
> something about that bogus NUMSMRG value? At least cap it at 128, which
> appears to be the maximum according to the specification, for example,
> by clearing bit 7 when any of the lower bits are set?
> 
> That would give us 35 (or 36) groups and working quirk detection with
> just the following smaller patch:
> 

I'm not certain if the value is bogus or not. It is clear that the spec
specifies 128 as the max but internal qcom document shows that they indeed
set 162 on purpose in the hypervisor.

So until we get a clear view on that, I'd not cap it.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 2ff7a72cf377..0f564a86c352 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1744,6 +1744,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>                         return -ENODEV;
>                 }
>  
> +               if (size > 0x80) {
> +                       dev_warn(smmu->dev,
> +                                "invalid number of SMR groups, clearing bit 7\n");
> +                       size -= 0x80;
> +               }
> +
>                 /* Zero-initialised to mark as invalid */
>                 smmu->smrs = devm_kcalloc(smmu->dev, size, sizeof(*smmu->smrs),
>                                           GFP_KERNEL);
> 
> I also verified that using index 127 (group 128) for the quirk detection
> works on my CRD, while the invalid index 128 fails (as do index 161
> which would currently be used).
> 
> > This also warrants a change in variable name from last_s2cr to free_s2cr.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 78fc0e1bf215..4104f81b8d8f 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -267,23 +267,37 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >  
> >  static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> >  {
> > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> >  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > +	u32 free_s2cr;
> >  	u32 reg;
> >  	u32 smr;
> >  	int i;
> >  
> > +	/*
> > +	 * Find the first non-valid (free) stream mapping register group and
> > +	 * use that index to access S2CR for detecting the bypass quirk.
> > +	 */
> > +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > +
> > +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > +			break;
> > +	}
> > +
> > +	free_s2cr = ARM_SMMU_GR0_S2CR(i);
> 
> In the unlikely event that there is no free group this would access an
> invalid index.
> 

Hmm, theoretically yes. But what would be the plan of action if that happens?
Should we just bail out with error or skip the quirk detection?

Thanks,
Mani

> > +
> >  	/*
> >  	 * With some firmware versions writes to S2CR of type FAULT are
> >  	 * ignored, and writing BYPASS will end up written as FAULT in the
> > -	 * register. Perform a write to S2CR to detect if this is the case and
> > -	 * if so reserve a context bank to emulate bypass streams.
> > +	 * register. Perform a write to the first free S2CR to detect if
> > +	 * this is the case and if so reserve a context bank to emulate
> > +	 * bypass streams.
> >  	 */
> >  	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
> >  	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
> >  	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
> > -	arm_smmu_gr0_write(smmu, last_s2cr, reg);
> > -	reg = arm_smmu_gr0_read(smmu, last_s2cr);
> > +	arm_smmu_gr0_write(smmu, free_s2cr, reg);
> > +	reg = arm_smmu_gr0_read(smmu, free_s2cr);
> >  	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
> >  		qsmmu->bypass_quirk = true;
> >  		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
