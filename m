Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63635BF9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiIUIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:55:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2163B95A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:55:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t4so5206wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NMm6vbupuNg3e8G1erinu7XgiIOmdNdtykV6wWBx/V8=;
        b=cs5Dvxfm7fd7aaUwKHNDAnKWcNrqMyWvSpCFhYmNjRwKQjf697cP12ef2JVhzS+nTr
         rBiEPfFCAvK18V0b4TPU93sWl3nBICTtuO2MuXRVpLAsvrnPMrSMT8utfj6qRBivTxti
         BXRo7n7yiwy1VFEU65sNSMFb9wbJX0Y01wSWLKT5xxq4/13Ub6Q0C+MSyK+vNliqzKv7
         7DJIhCBeCbjUg+pZttjuEgYoPhQn5piUM0+uqu6ez9uuEzMnz+dnjzErRDjuyGOk/BYS
         UkhbQnQFMY8EjTuZOsOAEbzscpTOQfKIqXeSfDZd9sFya7VbVqAP+h8BvB+DFZ+Idka/
         wnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NMm6vbupuNg3e8G1erinu7XgiIOmdNdtykV6wWBx/V8=;
        b=EjA1MHO9+oA1BznCvhS/kQYei3Ydt0ye4OWKcFSUODBPGLhTP6XOHTw3kkCOKoxneC
         Oew7tDeb6ILNbkzSuiw3DMUDMFHOUd6zdPWVUX8TN7usKCn0doUypsR2WiQhb2XMpPj7
         ylYsfQg53jbYV918xyCCPYWESKtpCMWtLld4+e+FsjT4vUgCSTzW21Qpmb4/oU9jt/ol
         rSleavC7Hxd+kPSymVo2x/qwGHZLVZF0STHxFiWrUfxSuPwj7BrtUwI3nDND++Llbpl5
         1iVj8mSBu6juAWhx4/tEpC3FzxbDcy3Kngu+HCCJo6o0SGe5SKK97spv2SMeK89UFT6L
         QLwQ==
X-Gm-Message-State: ACrzQf0scXNZeGVumgAxulBpZqr0aZSj+gsYQs5XoF8cf1HSq7x/nrYE
        1II+y7B7VZKdOvinOeQYNqgLeQ==
X-Google-Smtp-Source: AMsMyM5v4ccQB/sVn2S/zJDFsH4keJ/VCqNp428gK8IV32RalM87u6d3xbyo/Rp+qs75y4SGFW5eBA==
X-Received: by 2002:a1c:202:0:b0:3a8:4197:eec0 with SMTP id 2-20020a1c0202000000b003a84197eec0mr5125375wmc.83.1663750506995;
        Wed, 21 Sep 2022 01:55:06 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b0022afbd02c69sm1949060wrs.56.2022.09.21.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:55:06 -0700 (PDT)
Date:   Wed, 21 Sep 2022 09:55:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, sricharan@codeaurora.org, jgg@nvidia.com,
        kevin.tian@intel.com, konrad.dybcio@somainline.org,
        yong.wu@mediatek.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jonathanh@nvidia.com, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
        quic_saipraka@quicinc.com, jon@solid-run.com,
        yangyingliang@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 0/6] Define EINVAL as device/domain incompatibility
Message-ID: <YyrRZXVWWxBhW3ST@myrica>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 01:22:31AM -0700, Nicolin Chen wrote:
> This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
> https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/
> 
> The purpose is to regulate all existing ->attach_dev callback functions to
> use EINVAL exclusively for an incompatibility error between a device and a
> domain. This allows VFIO and IOMMUFD to detect such a soft error, and then
> try a different domain with the same device.
[...]
>  drivers/iommu/amd/iommu.c                   | 12 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 --
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +--
>  drivers/iommu/fsl_pamu.c                    |  2 +-
>  drivers/iommu/fsl_pamu_domain.c             |  4 +-
>  drivers/iommu/intel/iommu.c                 | 10 ++--
>  drivers/iommu/intel/pasid.c                 |  6 ++-
>  drivers/iommu/iommu.c                       | 22 ++++++++
>  drivers/iommu/ipmmu-vmsa.c                  |  2 -
>  drivers/iommu/msm_iommu.c                   | 59 +++++++++++----------
>  drivers/iommu/mtk_iommu.c                   |  4 +-
>  drivers/iommu/omap-iommu.c                  |  6 +--
>  drivers/iommu/sprd-iommu.c                  |  4 +-
>  drivers/iommu/tegra-gart.c                  |  2 +-
>  drivers/iommu/virtio-iommu.c                |  7 ++-

For virtio-iommu:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  include/linux/iommu.h                       | 12 +++++
>  17 files changed, 90 insertions(+), 83 deletions(-)
> 
> -- 
> 2.17.1
> 
