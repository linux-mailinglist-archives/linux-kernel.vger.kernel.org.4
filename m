Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2826BAA38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCOIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCOIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:00:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6765C75
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:00:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d22so4072075pgw.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678867207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bXhScNvJirB/hCflBGsU4AHsXlFvEM2HEzIa7ETc+5w=;
        b=CZ45Os5vAhiGxnaT2B5NTGpIkwiI8MqD/ziRs0x3wnMbEgj8jw1airgeraYdxyWsyV
         vmF96YsILMJEU4DhPbSXzSP5aCEr1dkAiFEhW3lSCH5z9aOmhMXUXLDyoioY7gYRodJ+
         /1wL6GA0qAexm4vJ6PSRs37PhqkdAZ8RogaqUg218Q8GPm8XHFDrjWRNY18V20ZcuxNi
         3kVZEh68djLaFncYHdgp601CGij3HCsgUPRB0dRmK43JQwSw+zQc2djkNO+g6QSLKNjk
         ce2wd1NFtyHkurOmdqkDgMxMWSujkoJ6jy7ewXi26cpBL2NPiMRzj7mVzsoJETslVPup
         P0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXhScNvJirB/hCflBGsU4AHsXlFvEM2HEzIa7ETc+5w=;
        b=AYdIUcCtD/9MOBqAFIGRnMrupnEX1HvydWu6W5RpbeluzJ2llhNp64KqlkzM8dckCj
         UM8+ExTd9fA46EKxoa62kOAC8BZEyjL4tkskg/GKMhK7TfzLuwfJYAInRQzPtmwDt7hP
         8JYQs2nufmnEApEH3gomc7BH32Tw1DNA0hwm1sDJXUwc7epVYFwRJLeHP3bgafNcKNCD
         7wGh0eQ30EW574YtpRvLazzjBbOw2d+eQmH21bz0T6nmvIKs83Sjh+B4DKa9HRzo7zc7
         l8N0hA1vTpdHJkHO3Mg5+tNLSLjrXvDqrOrfgtCW5s9V2ueFISdbM99V1Pfb33hBdwpK
         wRvg==
X-Gm-Message-State: AO0yUKWt80wuVsVHApr9mbaSb0HkJRMmhWiZ7DwDiiNWZyVym5M9JR0i
        2uAWIYxI00cd2NKhMam/RKk1Q5ZwgfI8w9/x3g==
X-Google-Smtp-Source: AK7set/ceQHRKEOXXse7gpx0PCqzmM42mq0cpYr+xa3HGUM1xkOh9XW4RheqWjZcyLZs28ahYe6HYg==
X-Received: by 2002:aa7:96b5:0:b0:623:7340:3741 with SMTP id g21-20020aa796b5000000b0062373403741mr8696841pfk.23.1678867207070;
        Wed, 15 Mar 2023 01:00:07 -0700 (PDT)
Received: from thinkpad ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b005a84de344a6sm2996510pfo.14.2023.03.15.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:00:06 -0700 (PDT)
Date:   Wed, 15 Mar 2023 13:29:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230315075958.GC25575@thinkpad>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
 <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:37:32AM +0100, Johan Hovold wrote:
> On Wed, Mar 15, 2023 at 12:16:59AM +0530, Manivannan Sadhasivam wrote:
> > The logic used to find the quirky firmware that intercepts the writes to
> > S2CR register to replace bypass type streams with a fault, and ignore the
> > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > 
> > The current logic uses the last stream mapping group (num_mapping_groups
> > - 1) as an index for finding quirky firmware. But on SC8280XP, NUMSMRG
> > reports a value of 162 due to emulation and the logic is not working for
> > stream mapping groups > 128. (Note that the ARM SMMU architecture
> > specification defines NUMSMRG in the range of 0-127).
> > 
> > So the current logic that checks the (162-1)th S2CR entry fails to detect
> > the quirky firmware on these devices and SMMU triggers invalid context
> > fault for bypass streams.
> > 
> > To fix this issue, let's limit "num_mapping_groups" to 128 as per ARM SMMU
> > spec and rework the logic to find the first non-valid (free) stream mapping
> > register group (SMR) and use that index to access S2CR for detecting the
> > bypass quirk. If no free groups are available, then just skip the quirk
> > detection.
> > 
> > While at it, let's move the quirk detection logic to a separate function
> > and change the local variable name from last_s2cr to free_s2cr.
> > 
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v3:
> > 
> > * Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
> >   check for 128 groups in qcom_smmu_bypass_quirk()
> > * Reworded the commit message accordingly
> > 
> > Changes in v2:
> > 
> > * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> > * Moved the quirk handling to its own function
> > * Collected review tag from Bjorn
> 
> > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > +{
> > +	u32 smr;
> > +	int i;
> > +
> > +	/*
> > +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> > +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> > +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> > +	 */
> 
> Please fix your editor so that it wraps lines at 80 columns, which is
> still the preferred (soft) limit.
> 

If exceeding 80 columns end up making the comment more readable (fewer lines),
then why should we limit ourselves?

> > +	if (smmu->num_mapping_groups > 128) {
> > +		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");
> 
> dev_notice() should do since there's nothing a user can do about this.
> 

Ok.

> > +		smmu->num_mapping_groups = 128;
> > +	}
> 
> So this hunk is really all that is needed to make the current quirk
> detection work on sc8280xp. Why not simply stick with the current logic
> and use the last group until there is a need for anything more?
> 

No! What if the bootloader had set up mapping for 128 groups? In that case
we'll overwrite the last group. It is still required to find the valid group
and use it for quirk detection. If no group is available, we'll skip it.

> Also, should this not be done in arm_smmu_device_cfg_probe() as I
> suggested earlier (e.g. to avoid allocating resources for the groups
> that will never be used)?
> 

I just went with Robin's suggestion on adding this check to cfg_probe() hook.
But I don't have any strong preference either.

Thanks,
Mani

> > +
> > +	qcom_smmu_bypass_quirk(smmu);
> >  
> >  	for (i = 0; i < smmu->num_mapping_groups; i++) {
> >  		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
