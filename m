Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E106B9195
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCNL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCNL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:26:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DC7E797
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:26:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so14791992pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678793194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CL2m5QJSCrBqCt1t0/+z74nTRJXZajDsckBb/Qqy+2U=;
        b=qCnBXJLD7xKIUQcuuxEe6d3U8ZPd04JvcUn3U78D0Y7ivGUvv0hAY2txCdo9INAH8e
         /N35QXRYe86s9Cp4Ti3Th5WfO5kA5s6BJWE2J9Ew5NFvLbXg4JNBEvOL7PbOB/MSDyNv
         bHisUR19w4HM0Rl4Q9cogACq3JiAlLsfq85EF6TKy57CqqQ1VJnGVAgE6ALmH4MXqcRJ
         YlDVkzEuLi1cdA/ZJDymtkYgv8FcN965DK/WFfNHLIgEStzPrjHenqgVqMpdmrHoav28
         w/ov8fBpySuBPrj6YOhqEMzQRLbWIvxiF/tpvH2KU8Qiox8Sy0kfVQ0IrOPgBxcoK5HS
         4E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL2m5QJSCrBqCt1t0/+z74nTRJXZajDsckBb/Qqy+2U=;
        b=GD8yclgVyGe95xwOBtjRMZkkLqNJQLfUiQjt04FeFwnwAxbxGgt/nIOh+slkDY84Sk
         bfZ13DsJ6xwL3is6Qx8B6NLBqR6H+ChA7ZRdVN/Wik5mtmlPqZTxZeLLOMIqfwbUbvkv
         MMq53gKG5v1kCWDQfJJPMXdyNqXxZPrYYjGZcMcx8ONOui7vEhB2RHx6j3QF8HvzqSkY
         njzBnXgBJePSgxZ3qzr5R4KJVdVz2cB/hqqLTQGTwhaR6DSbkkWI68+XXKA7oGnaxqXX
         9LY33Gpv5hd6OGxTRGeIx2hGFIsFyidKJqj2aK18+OtuT1JLnJcibUTDzubSZpYp5pVf
         yOmA==
X-Gm-Message-State: AO0yUKV9/L6y5mj4REIDk4GIl6+x/cqR61JRddbwfcgK8+s6LCYyTt7D
        oA62VVvplhPbi26RqYsV9Dz1
X-Google-Smtp-Source: AK7set8u7KqlkfrMDgYmtIWW+7fCkQiPY32aBeWBgi+e3AEITQmWhDiSXofs7zaMfCL945Efb+t1zg==
X-Received: by 2002:a17:903:32cb:b0:19e:7f89:b3a7 with SMTP id i11-20020a17090332cb00b0019e7f89b3a7mr44278152plr.31.1678793193960;
        Tue, 14 Mar 2023 04:26:33 -0700 (PDT)
Received: from thinkpad ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id ko7-20020a17090307c700b0019b06263bcasm1516985plb.247.2023.03.14.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:26:33 -0700 (PDT)
Date:   Tue, 14 Mar 2023 16:56:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230314112620.GB137001@thinkpad>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:17:38PM +0100, Johan Hovold wrote:
> On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> > The logic used to find the quirky firmware that intercepts the writes to
> > S2CR register to replace bypass type streams with a fault, and ignore the
> > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > 
> > The current logic uses the last stream mapping group (num_mapping_groups
> > - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> > reports a value of 162 (possibly emulated by the hypervisor) and logic is
> > not working for stream mapping groups > 128. (Note that the ARM SMMU
> > architecture specification defines NUMSMRG in the range of 0-127).
> > 
> > So the current logic that checks the (162-1)th S2CR entry fails to detect
> > the quirky firmware on these devices and SMMU triggers invalid context
> > fault for bypass streams.
> > 
> > To fix this issue, rework the logic to find the first non-valid (free)
> > stream mapping register group (SMR) within 128 groups and use that index
> > to access S2CR for detecting the bypass quirk. If no free groups are
> > available, then just skip the quirk detection.
> > 
> > While at it, let's move the quirk detection logic to a separate function
> > and change the local variable name from last_s2cr to free_s2cr.
> > 
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v2:
> > 
> > * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> > * Moved the quirk handling to its own function
> > * Collected review tag from Bjorn
> > 
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index d1b296b95c86..48362d7ef451 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >  	return 0;
> >  }
> >  
> > -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
> >  {
> > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> >  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > -	u32 reg;
> > -	u32 smr;
> > +	u32 free_s2cr;
> > +	u32 reg, smr;
> >  	int i;
> >  
> > +	/*
> > +	 * Find the first non-valid (free) stream mapping register group and
> > +	 * use that index to access S2CR for detecting the bypass quirk.
> > +	 *
> > +	 * Note that only the first 128 stream mapping groups are considered for
> > +	 * the check. This is because the ARM SMMU architecture specification
> > +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> > +	 * groups with the help of hypervisor. And those groups don't exhibit
> > +	 * the quirky behavior.
> > +	 */
> > +	for (i = 0; i < 128; i++) {
> 
> This may now access registers beyond smmu->num_mapping_groups. Should
> you not use the minimum of these two values here (and below)?
> 

Doh! yeah, you're right. Will fix it in v3.

Thanks,
Mani

> > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > +
> > +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > +			break;
> > +	}
> > +
> > +	/* If no free stream mapping register group is available, skip the check */
> > +	if (i == 128)
> > +		return;
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
