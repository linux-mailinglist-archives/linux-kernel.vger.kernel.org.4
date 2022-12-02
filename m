Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA6640530
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiLBKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiLBKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2BC8D2D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669978228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/WSDhCff5cI0oKVC2xG/rXWZdwpVxH3SgK+Cp6160A=;
        b=XrynmiK0wza+XQ3T3lCIYUWuee97+OOYwa2q/Q/9J0fkr6i+Tl6nJOw9MDHjbVRasqzoE+
        vOjdrVond2KMUkhacDfGA7Ty3slAPpJwaKWDRTfxVIwl+wN+q3ZZM5k0j53gujPhG42VQ9
        1CAX77zMZBAdGyB2NbjSFQr+z3NW4Ng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-GUnHlLmOO7appM6gaIT2gQ-1; Fri, 02 Dec 2022 05:50:27 -0500
X-MC-Unique: GUnHlLmOO7appM6gaIT2gQ-1
Received: by mail-wr1-f69.google.com with SMTP id l8-20020adfc788000000b00241ef50e89eso983377wrg.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/WSDhCff5cI0oKVC2xG/rXWZdwpVxH3SgK+Cp6160A=;
        b=hc3eG7OYaYek197CBj5eboDWbAEBh1nN+W16rcQ2+sLcBmPbVqU3fdmuRdcg59zETu
         BV6uYi94IUOFYwrR8o1Z1Pp0UMU2lRY4QzOcTSwfCb9UbhU0xne0IcbWjOz79lq10nL+
         Zp1p0jicSBvLq3B0Kxkuj+kfGVQqIlgo8l9ym++/4Mu7SKXxeiimysXGumWI9+1vNJ5x
         4FvWKfuVj5bgQvRPn3i4mPpk8PtR0ueHjYzAf+rzh4mMLRBd60WLCR5V9kOrWfZwyog8
         J8LIW4LcMxvnvntEsBgdZU6prhA8KLl35yeFm1u0W538VYK+DQdbfPxwW/jwNaA7Pwmu
         jUTQ==
X-Gm-Message-State: ANoB5pnppAd8V4nBcqh6MdTPVl3mkvNBePX5k7s+kiCwvbCEnpHyiEoc
        O+ceUMOIfk3EphYfJ7DfMF0rCBVSO9L87rOy5VmT3pzpxHdaNFFG7+J65zQkKU+F6wH1QLxQ4Fg
        vdQ0eyB0EOmeLJ4hiAhL3ol9HmHrkxRbRUedDC1ie0XNphgugQZCFuCKVfy5PY0GfD31OOg6/HS
        Y=
X-Received: by 2002:a1c:f216:0:b0:3d0:70fd:92bb with SMTP id s22-20020a1cf216000000b003d070fd92bbmr8875631wmc.14.1669978225834;
        Fri, 02 Dec 2022 02:50:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf685QZj2W6wR2OfJVqBlDm1LFTsF4LNxBCQdfUos9S5uMPZkJFB11z0tALtJyodHM0eSiyWmA==
X-Received: by 2002:a1c:f216:0:b0:3d0:70fd:92bb with SMTP id s22-20020a1cf216000000b003d070fd92bbmr8875597wmc.14.1669978225479;
        Fri, 02 Dec 2022 02:50:25 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a3170a7af9sm9728818wmb.4.2022.12.02.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:50:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Guang Zeng <guang.zeng@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/4] KVM: Delete all references to removed KVM_SET_MEMORY_REGION ioctl
Date:   Fri,  2 Dec 2022 11:50:08 +0100
Message-Id: <20221202105011.185147-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202105011.185147-1-javierm@redhat.com>
References: <20221202105011.185147-1-javierm@redhat.com>
MIME-Version: 1.0
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

The documentation says that the ioctl has been deprecated, but it has been
actually removed and the remaining references are just left overs.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 Documentation/virt/kvm/api.rst | 16 ----------------
 include/uapi/linux/kvm.h       | 12 ------------
 tools/include/uapi/linux/kvm.h | 12 ------------
 3 files changed, 40 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index eee9f857a986..54af33645df3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -272,18 +272,6 @@ the VCPU file descriptor can be mmap-ed, including:
   KVM_CAP_DIRTY_LOG_RING, see section 8.3.
 
 
-4.6 KVM_SET_MEMORY_REGION
--------------------------
-
-:Capability: basic
-:Architectures: all
-:Type: vm ioctl
-:Parameters: struct kvm_memory_region (in)
-:Returns: 0 on success, -1 on error
-
-This ioctl is obsolete and has been removed.
-
-
 4.7 KVM_CREATE_VCPU
 -------------------
 
@@ -1377,10 +1365,6 @@ the memory region are automatically reflected into the guest.  For example, an
 mmap() that affects the region will be made visible immediately.  Another
 example is madvise(MADV_DROP).
 
-It is recommended to use this API instead of the KVM_SET_MEMORY_REGION ioctl.
-The KVM_SET_MEMORY_REGION does not allow fine grained control over memory
-allocation and is deprecated.
-
 
 4.36 KVM_SET_TSS_ADDR
 ---------------------
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0d5d4419139a..8899201d5964 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -86,14 +86,6 @@ struct kvm_debug_guest {
 /* *** End of deprecated interfaces *** */
 
 
-/* for KVM_CREATE_MEMORY_REGION */
-struct kvm_memory_region {
-	__u32 slot;
-	__u32 flags;
-	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-};
-
 /* for KVM_SET_USER_MEMORY_REGION */
 struct kvm_userspace_memory_region {
 	__u32 slot;
@@ -1437,10 +1429,6 @@ struct kvm_vfio_spapr_tce {
 	__s32	tablefd;
 };
 
-/*
- * ioctls for VM fds
- */
-#define KVM_SET_MEMORY_REGION     _IOW(KVMIO,  0x40, struct kvm_memory_region)
 /*
  * KVM_CREATE_VCPU receives as a parameter the vcpu slot, and returns
  * a vcpu fd.
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 0d5d4419139a..8899201d5964 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -86,14 +86,6 @@ struct kvm_debug_guest {
 /* *** End of deprecated interfaces *** */
 
 
-/* for KVM_CREATE_MEMORY_REGION */
-struct kvm_memory_region {
-	__u32 slot;
-	__u32 flags;
-	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-};
-
 /* for KVM_SET_USER_MEMORY_REGION */
 struct kvm_userspace_memory_region {
 	__u32 slot;
@@ -1437,10 +1429,6 @@ struct kvm_vfio_spapr_tce {
 	__s32	tablefd;
 };
 
-/*
- * ioctls for VM fds
- */
-#define KVM_SET_MEMORY_REGION     _IOW(KVMIO,  0x40, struct kvm_memory_region)
 /*
  * KVM_CREATE_VCPU receives as a parameter the vcpu slot, and returns
  * a vcpu fd.
-- 
2.38.1

