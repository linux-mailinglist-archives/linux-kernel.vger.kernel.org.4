Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E303D6693D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjAMKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjAMKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B95958836
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673604831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WlHJzmQ1+H/v9mU7ZLQBlLH1lOk+ivZJgLlR3gMZhkM=;
        b=G/ns3D6Dd4JJ22/lb2bfv/S5KrSdOfLLrbf9a+qljR2Ew1gqYK27Wnni6hN8JwbzfDB9lO
        g7a8Ppi4NnfkJotSyk0oLcF0L3S9p7BNKTJdvKm0Hl1EK9s73lT9auNyktHseW3y+ZjN7S
        P6K5gOmz/NRhwLF5pLvxgCn/EMYD9kA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-SfJQ6eVGPJ2z9YMbciufYw-1; Fri, 13 Jan 2023 05:13:50 -0500
X-MC-Unique: SfJQ6eVGPJ2z9YMbciufYw-1
Received: by mail-qt1-f199.google.com with SMTP id ay40-20020a05622a22a800b003a978b3019cso10174360qtb.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlHJzmQ1+H/v9mU7ZLQBlLH1lOk+ivZJgLlR3gMZhkM=;
        b=v1Ljzoj5gyoJviLFy1GSZW+QiEZa5yC5CNFAJKzGf3FS9ppuWAVoMnodsag0lS4TZa
         t0cGJmtqK296oLUR5uFfZq7QU1sSbIDnTd0RsZYHSKf1iMKBNlANAeTkedq5J8rZlDSS
         pyEIsbPco7dD8GceSAuIl+Ql5VaOFTjD38zPllFFYoS/4rIA+hWYAQKFI+XX0Cp5pPuA
         O7Sa9hlrDC3aoj7zGoVcV91IoPic8nphHETDGl62fKVFjpkCZuO3IXCgn+wj4arqWKQn
         ritQG6P8hVQYk7j/WfP0k6zVJgorOx3Ci0sZ6yHkTCAog84/y32t0lh15dE1eYi7ewlM
         7Bmw==
X-Gm-Message-State: AFqh2kpwc5MugqFqbVfAzEb2Ml0Rg7vs++sLfnkx5jpzRarre3Ce+H6m
        YcpLWUdtd4AluFAj/CkisiOQGY+vevndxPAOC0cL/C3un554MCth3L+VmkpV/gGHqrdZgLiz27A
        7i3Itsxqb6ng7/tzHrdgk2gjD
X-Received: by 2002:a05:6214:5c87:b0:530:49c2:a82d with SMTP id lj7-20020a0562145c8700b0053049c2a82dmr97518495qvb.47.1673604829681;
        Fri, 13 Jan 2023 02:13:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvW8LW/MTzlkSFCBwiM31B2B/W/aTzZ6RhChRcNkBcPtF1PUsu1l8favYt1sP1xW1ztjc74lg==
X-Received: by 2002:a05:6214:5c87:b0:530:49c2:a82d with SMTP id lj7-20020a0562145c8700b0053049c2a82dmr97518473qvb.47.1673604829411;
        Fri, 13 Jan 2023 02:13:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it. [79.46.200.244])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006fb0e638f12sm12442370qkb.4.2023.01.13.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:13:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:13:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH v6 3/4] vhost-vdpa: uAPI to resume the device
Message-ID: <20230113101345.j7s7ecn2sozkd44s@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <73b75fb87d25cff59768b4955a81fe7ffe5b4770.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <73b75fb87d25cff59768b4955a81fe7ffe5b4770.1672742878.git.sebastien.boeuf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:51:07AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>This new ioctl adds support for resuming the device from userspace.
>
>This is required when trying to restore the device in a functioning
>state after it's been suspended. It is already possible to reset a
>suspended device, but that means the device must be reconfigured and
>all the IOMMU/IOTLB mappings must be recreated. This new operation
>allows the device to be resumed without going through a full reset.
>
>This is particularly useful when trying to perform offline migration of
>a virtual machine (also known as snapshot/restore) as it allows the VMM
>to resume the virtual machine back to a running state after the snapshot
>is performed.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> drivers/vhost/vdpa.c       | 18 ++++++++++++++++++
> include/uapi/linux/vhost.h |  8 ++++++++
> 2 files changed, 26 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 833617d00ef6..1db7bd39fb63 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -502,6 +502,21 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> 	return ops->suspend(vdpa);
> }
>
>+/* After a successful return of this ioctl the device resumes processing
>+ * virtqueue descriptors. The device becomes fully operational the same way it
>+ * was before it was suspended.
>+ */
>+static long vhost_vdpa_resume(struct vhost_vdpa *v)
>+{
>+	struct vdpa_device *vdpa = v->vdpa;
>+	const struct vdpa_config_ops *ops = vdpa->config;
>+
>+	if (!ops->resume)
>+		return -EOPNOTSUPP;
>+
>+	return ops->resume(vdpa);
>+}
>+
> static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> 				   void __user *argp)
> {
>@@ -687,6 +702,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 	case VHOST_VDPA_SUSPEND:
> 		r = vhost_vdpa_suspend(v);
> 		break;
>+	case VHOST_VDPA_RESUME:
>+		r = vhost_vdpa_resume(v);
>+		break;
> 	default:
> 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> 		if (r == -ENOIOCTLCMD)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index f9f115a7c75b..92e1b700b51c 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -180,4 +180,12 @@
>  */
> #define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
>
>+/* Resume a device so it can resume processing virtqueue requests
>+ *
>+ * After the return of this ioctl the device will have restored all the
>+ * necessary states and it is fully operational to continue processing the
>+ * virtqueue descriptors.

IIUC this is a no-op if the device wasn't suspended.
If you have to resend, maybe add this info also here in the user 
documentation.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+ */
>+#define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
>+
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

