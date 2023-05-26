Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52FF711DED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjEZC3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZC3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74271B6;
        Thu, 25 May 2023 19:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F286122B;
        Fri, 26 May 2023 02:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FA0C433EF;
        Fri, 26 May 2023 02:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685068176;
        bh=TP3AYaJ4gP/2S+h8KfHn4g2GfOx8vMvuIghBrxr/fiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtMQ1xiJkF679FZSYrrmjpzKauW9jGgFbHaW+BHUX6pT4eHYK/J1nyR1xqmVhdAIu
         /a5npppaQ74QON+5Aiu36bz9oEd4NfLcQzLzUZagM02o3RwbA36/R7FX7eqXk2OwgI
         pxCpoAQM5Y4NP8hd0HZczvIkVzNw8Pr7ZhZ9QuwZtRXsz0rvkvgPOiHSMftQFXHWs4
         IpsSutE1QrS2iUPIuJnGYYq1pLl56hFA5S614xIEeZnM/WgkK25UkqGUHl8QySHxv9
         SMHPkkhCiXXCpCPb93YcCDRu9Z3ZZH2IOKToIxwlTfTANvo/888CjB+7JmYRdEJ6qd
         Vq8yWfg5g/LGA==
Date:   Thu, 25 May 2023 19:33:25 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH v4 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Message-ID: <20230526023325.y7iqygmbtjmbf4zo@ripper>
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-3-robimarko@gmail.com>
 <a196330e-9d70-1bbd-6fae-7d60eb06e478@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a196330e-9d70-1bbd-6fae-7d60eb06e478@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 01:18:17AM +0200, Konrad Dybcio wrote:
> 
> 
> On 25.05.2023 23:02, Robert Marko wrote:
> > Introduce a helper to return the SoC SMEM ID, which is used to identify the
> > exact SoC model as there may be differences in the same SoC family.
> > 
> > Currently, cpufreq-nvmem does this completely in the driver and there has
> > been more interest expresed for other drivers to use this information so
> > lets expose a common helper to prevent redoing it in individual drivers
> > since this field is present on every SMEM table version.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v4:
> > * Change helper name to qcom_smem_get_soc_id()
> > * Remove len and just pass NULL, that is sufficient here
> > 
> > Changes in v3:
> > * Change export to EXPORT_SYMBOL_GPL
> > * Use an argument for returning SoC ID
> > * Update kerneldoc
> > ---
> >  drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
> >  include/linux/soc/qcom/smem.h |  2 ++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index bc98520c4969..78cf79ea4924 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> >  #include <linux/soc/qcom/smem.h>
> > +#include <linux/soc/qcom/socinfo.h>
> >  
> >  /*
> >   * The Qualcomm shared memory system is a allocate only heap structure that
> > @@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
> >  
> > +/**
> > + * qcom_smem_get_soc_id() - return the SoC ID
> > + * @id:	On success, we return the SoC ID here.
> > + *
> > + * Look up SoC ID from HW/SW build ID and return it.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int qcom_smem_get_soc_id(u32 *id)
> __le32 *id
> 

Why do you want this passed back to the user in little endian? When is
it not going to be compared to a cpu-endian constant?

> LGTM otherwise!
> 
> Konrad
> > +{
> > +	struct socinfo *info;
> > +
> > +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> > +	if (IS_ERR(info))
> > +		return PTR_ERR(info);
> > +
> > +	*id = info->id;

This should be __le32_to_cpu() though...

Regards,
Bjorn

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
> > +
> >  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
> >  {
> >  	struct smem_header *header;
> > diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> > index 86e1b358688a..223db6a9c733 100644
> > --- a/include/linux/soc/qcom/smem.h
> > +++ b/include/linux/soc/qcom/smem.h
> > @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
> >  
> >  phys_addr_t qcom_smem_virt_to_phys(void *p);
> >  
> > +int qcom_smem_get_soc_id(u32 *id);
> > +
> >  #endif
