Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B76693D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAMKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823B392DD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673604710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S39Zw03yvzjBBH5aDpSObn8T87QjmStZQxn222GBMhw=;
        b=QJkxFkjBxMsPL53ctYN1jZVBF+o39dCaFz87SbCBN8hm9ETOfCbWT9tY4xeI8UR6oTYTNP
        ZpZXCbIThmHenXT0EWNQZf3iWQtCt9rJcTPZG5+E466FreIEVwjNFUzv1fNjU3mvpMXoKe
        tbRiCSLDIKT5sonawT0q4u7P0Nn4fyA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-SoQ8NXUEMVCbYwG-1IxECg-1; Fri, 13 Jan 2023 05:11:49 -0500
X-MC-Unique: SoQ8NXUEMVCbYwG-1IxECg-1
Received: by mail-qv1-f70.google.com with SMTP id lp10-20020a056214590a00b0053180ee70f1so11290050qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S39Zw03yvzjBBH5aDpSObn8T87QjmStZQxn222GBMhw=;
        b=v3mtLIUXipAWP0dtlYxJwoHvCJEcS6fOajPc7KM1k+KwSNxBE+yDcUYJEAjdZj5n2L
         zMBsC4EqodG1jjVSGZKjG+BGWIrWLKuDNj/50kNHvoI2EuiP2GG5pXLxiHyS8ZiCw1L9
         zQ19+XM5cnneiIRk2cx5n507ywiWi4CbYkHq4ww2XyglDe7XMwD2MzXjjD6kWg4Egz3s
         O/BfydTyTpMDK988Vzha7Psgz4NgCZN1lFvfdFh6v5dsUFiQ2XY122M9uyN1sStIxWG6
         m7ZhlyF3Mg2y1UOrEL+4ODXDuOPuDCWeBWeA7wAT4h9M9HmZ32Ew5fOGsIeqMe5Kd4tp
         BiNA==
X-Gm-Message-State: AFqh2koojl/lzwelVydKBYkyJGB48B8DCtC1+oPqArDTbYI94nnHH4Qf
        /gUItUAt0PNjb4REy79qvRb3+NsLrV/qiS7663QyekXzKTqFuipLclLQL46KIg/VBMJ7pySvMzM
        lyTseT7C+zPP/hC2B87GFQyTl
X-Received: by 2002:ad4:4249:0:b0:534:885f:f274 with SMTP id l9-20020ad44249000000b00534885ff274mr1614783qvq.40.1673604709221;
        Fri, 13 Jan 2023 02:11:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvGdzUjqzPGXTMJcXuUWT/fHuKd0p3YOc9smghZW9uBWvNKHGCowxFZEyIpOn10KyCEVrDWQg==
X-Received: by 2002:ad4:4249:0:b0:534:885f:f274 with SMTP id l9-20020ad44249000000b00534885ff274mr1614759qvq.40.1673604708895;
        Fri, 13 Jan 2023 02:11:48 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it. [79.46.200.244])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce76811a07sm12622741qkp.75.2023.01.13.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:11:48 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:11:44 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH v6 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20230113101144.xibw6z55g4cmvjvh@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <b18db236ba3d990cdb41278eb4703be9201d9514.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b18db236ba3d990cdb41278eb4703be9201d9514.1672742878.git.sebastien.boeuf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:51:06AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>Userspace knows if the device can be resumed or not by checking this
>feature bit.
>
>It's only exposed if the vdpa driver backend implements the resume()
>operation callback. Userspace trying to negotiate this feature when it
>hasn't been exposed will result in an error.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> drivers/vhost/vdpa.c             | 16 +++++++++++++++-
> include/uapi/linux/vhost_types.h |  2 ++
> 2 files changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 166044642fd5..833617d00ef6 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
> 	return ops->suspend;
> }
>
>+static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
>+{
>+	struct vdpa_device *vdpa = v->vdpa;
>+	const struct vdpa_config_ops *ops = vdpa->config;
>+
>+	return ops->resume;
>+}
>+
> static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> {
> 	struct vdpa_device *vdpa = v->vdpa;
>@@ -602,11 +610,15 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 		if (copy_from_user(&features, featurep, sizeof(features)))
> 			return -EFAULT;
> 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>-				 BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
>+				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>+				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
> 			return -EOPNOTSUPP;
> 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> 		     !vhost_vdpa_can_suspend(v))
> 			return -EOPNOTSUPP;
>+		if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
>+		     !vhost_vdpa_can_resume(v))
>+			return -EOPNOTSUPP;

Not for this patch, but I'd like to refactor this code a bit to fill a 
`backend_features` field in vhost_vdpa during the vhost_vdpa_probe(), so 
we don't need to change this code or the VHOST_GET_BACKEND_FEATURES for 
every new backend feature.

I'll send a patch.

This LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 		vhost_set_backend_features(&v->vdev, features);
> 		return 0;
> 	}
>@@ -658,6 +670,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 		features = VHOST_VDPA_BACKEND_FEATURES;
> 		if (vhost_vdpa_can_suspend(v))
> 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
>+		if (vhost_vdpa_can_resume(v))
>+			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
> 		if (copy_to_user(featurep, &features, sizeof(features)))
> 			r = -EFAULT;
> 		break;
>diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>index 53601ce2c20a..c5690a8992d8 100644
>--- a/include/uapi/linux/vhost_types.h
>+++ b/include/uapi/linux/vhost_types.h
>@@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
> #define VHOST_BACKEND_F_IOTLB_ASID  0x3
> /* Device can be suspended */
> #define VHOST_BACKEND_F_SUSPEND  0x4
>+/* Device can be resumed */
>+#define VHOST_BACKEND_F_RESUME  0x5
>
> #endif
>-- 
>2.37.2
>
>---------------------------------------------------------------------
>Intel Corporation SAS (French simplified joint stock company)
>Registered headquarters: "Les Montalets"- 2, rue de Paris,
>92196 Meudon Cedex, France
>Registration Number:  302 456 199 R.C.S. NANTERRE
>Capital: 5 208 026.16 Euros
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>

