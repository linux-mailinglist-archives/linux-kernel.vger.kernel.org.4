Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D646C8184
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCXPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB31F933
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+04OpsvyUrUsuT6XcLeeN9Ze/5Klc/NacWCLWIQp650=;
        b=DFk1pdQ07teVn7ZY1Wd+9E0p9T9egSGBCqYCgLZkJDltdPVGKpYAyj24zNx6+EiHvRFpvx
        9lz7IFXTP0+X8BU+mZ5YaDVJLrzYSl3s4t8hNvjiD3BE08kTwwQKi77Rw2I8mYI2DMCyhA
        yf4RIkTErbsQs6RvdUf8a8xvZzMe11s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-BhoK-CvqM_ummrG53THxaw-1; Fri, 24 Mar 2023 11:39:31 -0400
X-MC-Unique: BhoK-CvqM_ummrG53THxaw-1
Received: by mail-ed1-f71.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so3750888eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+04OpsvyUrUsuT6XcLeeN9Ze/5Klc/NacWCLWIQp650=;
        b=iMfKv7Qlb+BreUBBTN4zHMYN56Jwz8i1jdnkfqiAlcq7/cc7Uq0QPbFVooR4EkQ+6W
         Mf+87i3PgoElblgE+JwcJeYF8LQFKcGc+rOXLVhXZOzGdwgYmZIesyfvpctNOFpByIng
         tDPncgH+joZ4kara3Dy3iorObcJtPmupZOUapPqjoGJqptcDHIkaXa4mXeDTAzhyXP8C
         M1Yf0aitXAnkVwZWjbRHlVL+SZMSBMGOSEhZnw0rKGpYvnND0qaJh+sCuEwAhBSDSwLI
         2TOXZ5150Wce+li7hKP6d0PT7clt9KDfiSqE/Laf+Cp/+hbg/ojAoIu20uJb2nljIF+t
         Xwlw==
X-Gm-Message-State: AAQBX9eb9z25n2LvApuBJtgTc0ne/2HMlLdDmDFnMZRmKZ4neOS/2xfO
        GKxcY/W+9M1p7kCRP+M2MIa6gx3Aidp9OQR6bHP/Bp53L2OBCCCbGQ9tAk9VZtYG1jRERZXXS5W
        1AQ+GewBIHmzCSlbO/Rehs//M
X-Received: by 2002:a05:6402:3445:b0:4fd:2b05:1722 with SMTP id l5-20020a056402344500b004fd2b051722mr3182554edc.7.1679672369857;
        Fri, 24 Mar 2023 08:39:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350bq4L61I8EczA4/4nm0Gn5Q60S6s6HDFgOqRKq3vWBdC5wTa3I/hX31ckQT0ABvHJvSMmcVxQ==
X-Received: by 2002:a05:6402:3445:b0:4fd:2b05:1722 with SMTP id l5-20020a056402344500b004fd2b051722mr3182539edc.7.1679672369577;
        Fri, 24 Mar 2023 08:39:29 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id u5-20020a50d505000000b004c09f0ba24dsm10904587edi.48.2023.03.24.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:39:28 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        Jason Wang <jasowang@redhat.com>, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 5/9] vringh: support VA with iotlb
Date:   Fri, 24 Mar 2023 16:39:19 +0100
Message-Id: <20230324153919.47633-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vDPA supports the possibility to use user VA in the iotlb messages.
So, let's add support for user VA in vringh to use it in the vDPA
simulators.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - used uintptr_t for `io_addr` [Eugenio]
    - added `io_addr` and `io_len` variables in iotlb_translate
    - avoided overflow doing `map->addr - map->start + addr` [Jason]
    - removed `is_iovec` field from struct iotlb_vec [Jason]
    - added vringh_init_iotlb_va() [Jason]
    v3:
    - refactored avoiding code duplication [Eugenio]
    v2:
    - replace kmap_atomic() with kmap_local_page() [see previous patch]
    - fix cast warnings when build with W=1 C=1

 include/linux/vringh.h |   9 +++
 drivers/vhost/vringh.c | 171 +++++++++++++++++++++++++++++++++--------
 2 files changed, 148 insertions(+), 32 deletions(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 1991a02c6431..b4edfadf5479 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -32,6 +32,9 @@ struct vringh {
 	/* Can we get away with weak barriers? */
 	bool weak_barriers;
 
+	/* Use user's VA */
+	bool use_va;
+
 	/* Last available index we saw (ie. where we're up to). */
 	u16 last_avail_idx;
 
@@ -284,6 +287,12 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      struct vring_avail *avail,
 		      struct vring_used *used);
 
+int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
+			 unsigned int num, bool weak_barriers,
+			 struct vring_desc *desc,
+			 struct vring_avail *avail,
+			 struct vring_used *used);
+
 int vringh_getdesc_iotlb(struct vringh *vrh,
 			 struct vringh_kiov *riov,
 			 struct vringh_kiov *wiov,
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 4aee230f7622..771c2aba8aac 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1094,10 +1094,17 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
 
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
+struct iotlb_vec {
+	union {
+		struct iovec *iovec;
+		struct bio_vec *bvec;
+	} iov;
+	size_t count;
+};
+
 static int iotlb_translate(const struct vringh *vrh,
 			   u64 addr, u64 len, u64 *translated,
-			   struct bio_vec iov[],
-			   int iov_size, u32 perm)
+			   struct iotlb_vec *ivec, u32 perm)
 {
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
@@ -1107,9 +1114,11 @@ static int iotlb_translate(const struct vringh *vrh,
 	spin_lock(vrh->iotlb_lock);
 
 	while (len > s) {
-		u64 size, pa, pfn;
+		uintptr_t io_addr;
+		size_t io_len;
+		u64 size;
 
-		if (unlikely(ret >= iov_size)) {
+		if (unlikely(ret >= ivec->count)) {
 			ret = -ENOBUFS;
 			break;
 		}
@@ -1124,10 +1133,22 @@ static int iotlb_translate(const struct vringh *vrh,
 		}
 
 		size = map->size - addr + map->start;
-		pa = map->addr + addr - map->start;
-		pfn = pa >> PAGE_SHIFT;
-		bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
-			      pa & (PAGE_SIZE - 1));
+		io_len = min(len - s, size);
+		io_addr = map->addr - map->start + addr;
+
+		if (vrh->use_va) {
+			struct iovec *iovec = ivec->iov.iovec;
+
+			iovec[ret].iov_len = io_len;
+			iovec[ret].iov_base = (void __user *)io_addr;
+		} else {
+			u64 pfn = io_addr >> PAGE_SHIFT;
+			struct bio_vec *bvec = ivec->iov.bvec;
+
+			bvec_set_page(&bvec[ret], pfn_to_page(pfn), io_len,
+				      io_addr & (PAGE_SIZE - 1));
+		}
+
 		s += size;
 		addr += size;
 		++ret;
@@ -1146,23 +1167,36 @@ static int iotlb_translate(const struct vringh *vrh,
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_STRIDE];
+		struct bio_vec bvec[IOTLB_IOV_STRIDE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_STRIDE;
+
 	while (total_translated < len) {
-		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_RO);
+				      &ivec, VHOST_MAP_RO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_STRIDE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
+		if (vrh->use_va) {
+			iov_iter_init(&iter, ITER_SOURCE, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_SOURCE, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
@@ -1179,23 +1213,36 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_STRIDE];
+		struct bio_vec bvec[IOTLB_IOV_STRIDE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_STRIDE;
+
 	while (total_translated < len) {
-		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_WO);
+				      &ivec, VHOST_MAP_WO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_STRIDE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
+		if (vrh->use_va) {
+			iov_iter_init(&iter, ITER_DEST, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_DEST, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
@@ -1212,20 +1259,36 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 static inline int getu16_iotlb(const struct vringh *vrh,
 			       u16 *val, const __virtio16 *p)
 {
-	struct bio_vec iov;
-	void *kaddr, *from;
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[1];
+		struct bio_vec bvec[1];
+	} iov;
+	__virtio16 tmp;
 	int ret;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = 1;
+
 	/* Atomic read is needed for getu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_RO);
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+			      NULL, &ivec, VHOST_MAP_RO);
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	from = kaddr + iov.bv_offset;
-	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_local(kaddr);
+	if (vrh->use_va) {
+		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		if (ret)
+			return ret;
+	} else {
+		void *kaddr = kmap_local_page(ivec.iov.bvec[0].bv_page);
+		void *from = kaddr + ivec.iov.bvec[0].bv_offset;
+
+		tmp = READ_ONCE(*(__virtio16 *)from);
+		kunmap_local(kaddr);
+	}
+
+	*val = vringh16_to_cpu(vrh, tmp);
 
 	return 0;
 }
@@ -1233,20 +1296,36 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 static inline int putu16_iotlb(const struct vringh *vrh,
 			       __virtio16 *p, u16 val)
 {
-	struct bio_vec iov;
-	void *kaddr, *to;
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec;
+		struct bio_vec bvec;
+	} iov;
+	__virtio16 tmp;
 	int ret;
 
+	ivec.iov.iovec = &iov.iovec;
+	ivec.count = 1;
+
 	/* Atomic write is needed for putu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_WO);
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+			      NULL, &ivec, VHOST_MAP_RO);
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	to = kaddr + iov.bv_offset;
-	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_local(kaddr);
+	tmp = cpu_to_vringh16(vrh, val);
+
+	if (vrh->use_va) {
+		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		if (ret)
+			return ret;
+	} else {
+		void *kaddr = kmap_local_page(ivec.iov.bvec[0].bv_page);
+		void *to = kaddr + ivec.iov.bvec[0].bv_offset;
+
+		WRITE_ONCE(*(__virtio16 *)to, tmp);
+		kunmap_local(kaddr);
+	}
 
 	return 0;
 }
@@ -1320,11 +1399,39 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      struct vring_avail *avail,
 		      struct vring_used *used)
 {
+	vrh->use_va = false;
+
 	return vringh_init_kern(vrh, features, num, weak_barriers,
 				desc, avail, used);
 }
 EXPORT_SYMBOL(vringh_init_iotlb);
 
+/**
+ * vringh_init_iotlb_va - initialize a vringh for a ring with IOTLB containing
+ *                        user VA.
+ * @vrh: the vringh to initialize.
+ * @features: the feature bits for this ring.
+ * @num: the number of elements.
+ * @weak_barriers: true if we only need memory barriers, not I/O.
+ * @desc: the userpace descriptor pointer.
+ * @avail: the userpace avail pointer.
+ * @used: the userpace used pointer.
+ *
+ * Returns an error if num is invalid.
+ */
+int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
+			 unsigned int num, bool weak_barriers,
+			 struct vring_desc *desc,
+			 struct vring_avail *avail,
+			 struct vring_used *used)
+{
+	vrh->use_va = true;
+
+	return vringh_init_kern(vrh, features, num, weak_barriers,
+				desc, avail, used);
+}
+EXPORT_SYMBOL(vringh_init_iotlb_va);
+
 /**
  * vringh_set_iotlb - initialize a vringh for a ring with IOTLB.
  * @vrh: the vring
-- 
2.39.2

