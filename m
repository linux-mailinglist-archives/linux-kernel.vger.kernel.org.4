Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597CE5B6D43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiIMM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiIMM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:27:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654B1CB1E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:27:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so3164964wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VTC8+roq761rPO1lbs0pNCCJS3R+FuNtWSS5Z+GCYq0=;
        b=miJorPWGXKjdCvQfUrlK5b1TBnftK3ihkKzT7xqaUavMG7CeLtoJKGsTDgIrHxw1I3
         2o8xQkGSzosqM7uGO5cLcDrsoGHQ8twTWgHZ2vDCp7Moq8rQyncPJPf9AH7M4U8xaxAM
         YggevJiZ/hK+JQccvTf9e0cZGg7o7aOJH35ps/x9/3ARbo/2W107ZSA8CUuSjnPY3N3y
         soct36MtuIzorK4dk2RWaf9fYqjmfgyJjBzvbG5Q6v2vAtcjNhQLt/2tXAKSrGGFkQfM
         wrSlwNuWKXmVGgcul7JnWyX4aFqYYq/VYsG9T/I1xdpyUdb4FKPcIL7ldqP87qC+7eEg
         /5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VTC8+roq761rPO1lbs0pNCCJS3R+FuNtWSS5Z+GCYq0=;
        b=s61gWAj1Ub0Te7WdAoXWvUWdHr5Ia8PCykXEPlJ+fG5CVSDRVkxuGb9hFODtmh2/nX
         RcmxZr5DP+8D4qOc7H0QrzhCgEwvwzYt2wG9Zh9rwCOW/nh2zRdp1kX32VBF1Puv+P/I
         K7bKHnz0B6tlwbCd+pqGFwPYBa55kgdodHoP/f42WLiQV6GxUyOBFYtxAxvv7BuDWici
         GiPssrC3Kfi/TTtsiarAdafxOB1oLFtseDyk8zk7KzPayE9MxL8MFBSZusW6/PMnSkmG
         eCQtJVm5Ks2RE68BPckr8UaDzvlyiD00H/E5WfkbA7EGbKeC+QumTRKlkJjcoSjSLtkS
         NjCg==
X-Gm-Message-State: ACgBeo0AJbRLUdz2tKnj6x1k2tVwTCHys6iRJz3fwyNzxlZ9xN385gaf
        k6M2Mnki5/gQLUPkUEgDSaeyAQ==
X-Google-Smtp-Source: AA6agR6T+QLT8jB5Xi/vSWb9EBDtxlHd1ocjnlnMMf5JCbG+ys2vKBcb/2DyNzFGWO0wDCo6sPf6Iw==
X-Received: by 2002:a05:600c:6026:b0:3b4:94ff:c019 with SMTP id az38-20020a05600c602600b003b494ffc019mr2218246wmb.101.1663072028280;
        Tue, 13 Sep 2022 05:27:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003b47b913901sm2496769wmq.1.2022.09.13.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:27:07 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:27:03 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        matthias.bgg@gmail.com, heiko@sntech.de, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, jgg@nvidia.com, sricharan@codeaurora.org,
        yong.wu@mediatek.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        thunder.leizhen@huawei.com, christophe.jaillet@wanadoo.fr,
        yangyingliang@huawei.com, jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyB3F/o3RfymqiFW@myrica>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913082448.31120-5-nicolinc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Tue, Sep 13, 2022 at 01:24:47AM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return ENODEV error code for all device
> specific errors. It particularly excludes EINVAL from being used for such
> error cases. For the same purpose, also replace one EINVAL with ENOMEM in
> mtk_iommu driver.
> 
> Note that the virtio-iommu does a viommu_domain_map_identity() call, which
> returns either 0 or ENOMEM at this moment. Change to "return ret" directly
> to allow it to pass an EINVAL in the future.
[...]
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80151176ba12..874c01634d2b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  		if (ret) {
>  			ida_free(&viommu->domain_ids, vdomain->id);
>  			vdomain->viommu = NULL;
> -			return -EOPNOTSUPP;
> +			return ret;

I think in the future it will be too easy to forget about the constrained
return value of attach() while modifying some other part of the driver,
and let an external helper return EINVAL. So I'd rather not propagate ret
from outside of viommu_domain_attach() and finalise().

For the same reason I do prefer this solution over EMEDIUMTYPE, because
it's too tempting to use exotic errno when they seem appropriate instead
of boring ENODEV and EINVAL. The alternative would be adding a special
purpose code to linux/errno.h, similarly to EPROBE_DEFER, but that might
be excessive.

Since we can't guarantee that APIs like virtio or ida won't ever return
EINVAL, we should set all return values:

--- 8< ---
From 7b16796cb78d11971236f98fd2d3cd73ca769827 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Tue, 13 Sep 2022 12:53:02 +0100
Subject: [PATCH] iommu/virtio: Constrain return value of viommu_attach_dev()

Ensure viommu_attach_dev() only return errno values expected from the
attach_dev() op. In particular, only return EINVAL when we're sure that
the device is incompatible with the domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..582ff5a33b52 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -669,13 +669,13 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
 			viommu_page_size, PAGE_SIZE);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
 			      viommu->last_domain, GFP_KERNEL);
 	if (ret < 0)
-		return ret;
+		return -ENOMEM;
 
 	vdomain->id		= (unsigned int)ret;
 
@@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return -ENODEV;
 		}
 	}
 
@@ -734,7 +734,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
@@ -769,7 +769,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	if (!vdomain->nr_endpoints) {
@@ -779,7 +779,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_replay_mappings(vdomain);
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	vdomain->nr_endpoints++;
-- 
2.37.3

