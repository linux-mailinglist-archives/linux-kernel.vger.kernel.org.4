Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517C764CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiLNQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiLNQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0F15822
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671035477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lGOBSIFe5pUAxEjRFkRz63QN+FtG9EzKvnfhz76nOw=;
        b=gyS/Qx853+tG0y4ovn67hBzzpO64kyq3nBrzKQUACMOe6ZnjkeKHPEGK8Ccv6Qhm33uXfE
        2bCYy169o40L4NsytQeIpg4dWuLiCPDXbvsmSBq7IwA10zUgcl3cW/rnmB+8zZJPUpnc3H
        YfAm69GsIV9anrgt3gPAhy0oC9gYCn8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-1Nx6bXeDMpObx7rj-DH6Bw-1; Wed, 14 Dec 2022 11:30:31 -0500
X-MC-Unique: 1Nx6bXeDMpObx7rj-DH6Bw-1
Received: by mail-wm1-f72.google.com with SMTP id h81-20020a1c2154000000b003d1c8e519fbso7427625wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lGOBSIFe5pUAxEjRFkRz63QN+FtG9EzKvnfhz76nOw=;
        b=RokKwjW9b/kM/OFzUzGQtn1NxNz9OSBzdy4Izk/JS/WreBoHAXqKEa5ff3Hh28++fO
         r2YacpO8EqbAV1HDJ/6xDrNwlT2N33QUjJVWCCN0T27JZThpuLAopcueePKvxrtbEie4
         vyshU2kesCr8rbrgj8lHoF4IVGbDye9lWzSy6y+zyTTfEJMvO1oQBp4GlWfxUSBD/cyi
         uP95LFHJZIHn7s20v1rkNmh3nypMf8H3P3GdhqXLccE2UHE/7iS8CYYAX/ESYTCwKHti
         6JqkGAoGFgXCyT6WNSjbHpK5ypYkoq1qF1vz1RJS/K91pFloICQVHnhNukPsseogH+pp
         RcuQ==
X-Gm-Message-State: AFqh2kosOInhESHrbDgulDXsLP6YAfRoeCZrQJ1HWgMWNwUAqlZTL+7S
        C7Shy1uLLuBFq3MzdBQB9XthQy6g6oh43/IgbInmtyb0fenytlTHgtVioAQLiePcSCVNEazLUdb
        psQZERKW8gVwATWqy13KMD/hh
X-Received: by 2002:a5d:6b82:0:b0:254:e300:df10 with SMTP id n2-20020a5d6b82000000b00254e300df10mr3175569wrx.0.1671035430299;
        Wed, 14 Dec 2022 08:30:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtON+i2KOCKckOC+y5p1sstetwPc0ECbYZbXcpC/pxYXEHqSVOOlJPZuP9yMFAhSEmoSjaS2Q==
X-Received: by 2002:a5d:6b82:0:b0:254:e300:df10 with SMTP id n2-20020a5d6b82000000b00254e300df10mr3175558wrx.0.1671035430129;
        Wed, 14 Dec 2022 08:30:30 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b002422816aa25sm3791759wrr.108.2022.12.14.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:30:29 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, eperezma@redhat.com,
        stefanha@redhat.com, netdev@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 1/6] vdpa: add bind_mm callback
Date:   Wed, 14 Dec 2022 17:30:20 +0100
Message-Id: <20221214163025.103075-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214163025.103075-1-sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new optional callback is used to bind the device to a specific
address space so the vDPA framework can use VA when this callback
is implemented.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..34388e21ef3f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -282,6 +282,12 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @bind_mm:			Bind the device to a specific address space
+ *				so the vDPA framework can use VA when this
+ *				callback is implemented. (optional)
+ *				@vdev: vdpa device
+ *				@mm: address space to bind
+ *				@owner: process that owns the address space
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -341,6 +347,8 @@ struct vdpa_config_ops {
 			 u64 iova, u64 size);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
+	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm,
+		       struct task_struct *owner);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.38.1

