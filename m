Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E5710317
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbjEYCvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjEYCu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5913A;
        Wed, 24 May 2023 19:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E585A63456;
        Thu, 25 May 2023 02:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2FC433D2;
        Thu, 25 May 2023 02:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684983055;
        bh=xrBtlH9XLV3WQLwYJd/ujweniDgTMEIrltiM1P03kAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuLXsmDNA23iRja8+VlaTh1wpOAdbmplDAQdgImnXs2tu3EJoqBACNPe6StbOhzCo
         sB53LvoevqeyZUVw9kDSYqjatVDcWKIx3Tgi/H/MyI8s2fwYXFJpfRSKQPuHNBNqkQ
         yKgYuqPD+domU3cbqjBBZL4aEyCDMskbIIbbn8NQKCyOT3qOfeu/fyDuwnQiEYN5H3
         onLAV0y8oTGWd+0gno/pfbphqnC87CBa+Gu+M0QKrAXhGuOeQghBFAnf4/TsYLlIVJ
         bPqdBtJ3B6kRR0mZJ9MIqkPwE5vVokG6lZLWggpzof9HkO6cGicL4XIC5E7DEWO5rt
         4hN2XrXcpieyA==
Date:   Wed, 24 May 2023 19:54:45 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Message-ID: <20230525025445.lxfvmnlm2ezzi45g@ripper>
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-2-robimarko@gmail.com>
 <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
 <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:27:03PM +0200, Konrad Dybcio wrote:
> 
> 
> On 24.05.2023 20:16, Trilok Soni wrote:
> > On 5/24/2023 9:23 AM, Robert Marko wrote:
> >> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> >> exact SoC model as there may be differences in the same SoC family.
> >>
> >> Currently, cpufreq-nvmem does this completely in the driver and there has
> >> been more interest expresed for other drivers to use this information so
> >> lets expose a common helper to prevent redoing it in individual drivers
> >> since this field is present on every SMEM table version.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> ---
> >>   drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
> >>   include/linux/soc/qcom/smem.h |  2 ++
> >>   2 files changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> >> index 6be7ea93c78c..0d6ba9bce8cb 100644
> >> --- a/drivers/soc/qcom/smem.c
> >> +++ b/drivers/soc/qcom/smem.c
> >> @@ -14,6 +14,7 @@
> >>   #include <linux/sizes.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/soc/qcom/smem.h>
> >> +#include <linux/soc/qcom/socinfo.h>
> >>     /*
> >>    * The Qualcomm shared memory system is a allocate only heap structure that
> >> @@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
> >>   }
> >>   EXPORT_SYMBOL(qcom_smem_virt_to_phys);
> >>   +/**
> >> + * qcom_smem_get_msm_id() - return the SoC ID
> >> + *
> >> + * Look up SoC ID from HW/SW build ID and return it.
> >> + */
> >> +int qcom_smem_get_msm_id(void)
> On top of Trilok's point, this should return le32, or at least unsigned int.
> 

Returning the value in CPU-native endian sounds very reasonable, so we
don't need __le32_to_cpu() on the calling side.

If we want to worry about this value going beyond 31 bits the
appropriate way would be to take, and assign, a unsigned int* argument
and return 0/-errno to indicate success/failure.

Regards,
Bjorn

> Konrad
> >> +{
> >> +    size_t len;
> >> +    struct socinfo *info;
> >> +
> >> +    info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
> >> +    if (IS_ERR(info))
> >> +        return PTR_ERR(info);
> >> +
> >> +    return __le32_to_cpu(info->id);
> >> +}
> >> +EXPORT_SYMBOL(qcom_smem_get_msm_id);
> > 
> > EXPORT_SYMBOL_GPL please?
> > 
> > Please change it for other symbols in the driver as well w/ separate patch.
> > 
> > ---Trilok Soni
> > 
> > 
