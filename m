Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8476B9742
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjCNOIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCNOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:08:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16192126E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:08:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k2so8838660pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678802890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lPoZZPacx9fdneUfHux1/KYUBYODq0fopFLjkjIOik=;
        b=V9hO1c5s9f9mi2Gw7qut7duszo+fbowP4j2pkKss4fRvTmwnbpNtZUv09ZmQGI3ZwA
         2jg5s2IoX5iTxbiOI+hCOk8zxrU+ZA+HPmsQ8WacVC9jKB9HaiXvZgPDOUJYRm3JVVsD
         ShJiA9OJVLRXC/NVMhwSPholWIRl9mXekIbK7nfKy0y4nbYwOavt6P9zs0v87+Ue41hK
         M3cNKIgE66yL0AbM9XP8bqulnFlNsqnfQDS//aztPR8hZ5Pk9LsKBPl/bykzAL6qvZK3
         ElT/PmNj19JT1scXffc5KNghTKw4add0Oa9tsJ8eNcF0hkixALFdttWswAAocBi8hBS7
         RYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678802890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lPoZZPacx9fdneUfHux1/KYUBYODq0fopFLjkjIOik=;
        b=q0jpSe7M63qSPvZ+GN2WzLAjDAYk+T782Xepy7l0NeUi50pwXnan1r8q/fNHgD6/Oa
         NrY+Pijcwrcz2PE7vfAg6FJ1X/SJjAPvXz2CNiTZq8xnuYbSP5k1dtPf0xlledUAxSCl
         LqAz1G8oZ0Le8IEhiSO6g08zuaoT0GNq9rTMxqIJdcugxIfjHr0Q1+EXKbmyrqjPN3L4
         19fouY7i+Fk1DOe7Gbrq81E622coKoMTyWYw0MbpXsugwIebYlY0HmNJWTHYV0mRmmQf
         +e32ed01k6bFX0+2qz7elpVJZNde0r8gYYpc9NXqnt1CWKh8jmeRJBIXfW3JBStvmJL2
         JDwA==
X-Gm-Message-State: AO0yUKXtVdbQyVORvGiKcnV4KV5+c0Dd1uRAthYsWxgsotQyXOqa0T/a
        zF57Hll8bc+ShmHbmHBX1oNy
X-Google-Smtp-Source: AK7set+jjrZxXvG/HqwihK5qqGzkzo6NJC3ZPFgQShYZYkHWr0ZYgNVzuREatJ5EWXGJaMtZmOcZew==
X-Received: by 2002:a05:6a20:b061:b0:c7:320a:60b6 with SMTP id dx33-20020a056a20b06100b000c7320a60b6mr31206938pzb.26.1678802890196;
        Tue, 14 Mar 2023 07:08:10 -0700 (PDT)
Received: from thinkpad ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b005a8b4dcd213sm1666092pfn.78.2023.03.14.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:08:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:37:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Johan Hovold <johan@kernel.org>, will@kernel.org, joro@8bytes.org,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230314140756.GD137001@thinkpad>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
 <20230314112620.GB137001@thinkpad>
 <13b46d42-e497-8dd7-4785-f58447128a40@arm.com>
 <20230314132018.GC137001@thinkpad>
 <a81515c5-c88c-e3c2-2077-0a78b900bbe5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81515c5-c88c-e3c2-2077-0a78b900bbe5@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> it is. Therefore Linux does not need to accommodate this weirdness for the
> foreseeable future, beyond simply making sure it doesn't cause any problems
> for what Linux *does* support. It's bad enough that the emulation of
> "normal" SMRs continues to violate the architecture, but I'm even more
> uncomfortable letting the generic architecture driver poke at completely
> non-architectural registers which don't even have the same behaviour as the
> ones they're supposedly extending.
> 

Okay then. I'll cap it to 128.

Thanks,
Mani

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

-- 
மணிவண்ணன் சதாசிவம்
