Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E364053D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiLBKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiLBKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583ED0382
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669978231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZiLhwAB4T5DlsifWPEOUp55KcHRF76jPNns8olDBLs=;
        b=Hc4NLD78+J6CD/ItmgTJgM2ITujoOJl44UrVS2ORnwjbqr6lR5k9B4HyljCz95d+P9xuWm
        mhUbFKYadcF/qwhAqAYATiYP/A8wbFscVucdZDa7Su/hY5v40QTR06Uc4FNidV2jMoUsdn
        zogq9cPOCVREkrPjN0EXFubUtBnn5X8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-hjBjK3HyOQe7N1ccMe4EzA-1; Fri, 02 Dec 2022 05:50:30 -0500
X-MC-Unique: hjBjK3HyOQe7N1ccMe4EzA-1
Received: by mail-wm1-f72.google.com with SMTP id 8-20020a05600c228800b003d0376e42deso1742456wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZiLhwAB4T5DlsifWPEOUp55KcHRF76jPNns8olDBLs=;
        b=q/iGZ0zFjC9o20rCOxfHzPbjdobaANiekutkWiGeMg643GsJAnDiBlalysxFfDX5Jm
         XwGzgAhHjsDO4YyogsdrYip3v97Cdoepdj2mEoGqB7Pk69BmEVSBu7QHyKx7hWqCWG3t
         XjfIcn6bNCKsRgqk9eUT1bOSpDxPy3qDEr1aYPGVujhfvDa8wM79fICDLkMZstL8lx1M
         96+EUxIDa/TBogmuKrfh4i33au7XUEj/7w4GhJGe7OqaCWXtSoAKtZcp9ae8AoGKFxj0
         cpYWVjObalSJghW9DyAzNj/3lvOeTQ+JgBX2mLytAUDlWwshDIrh7F+8heklxVzrDlv4
         Aqxw==
X-Gm-Message-State: ANoB5pm6amVwu95V12XV2s5mIF4AfeGJgHUERweFRSH7WL8iz9DB86cJ
        kri19WtRlOCXI9pmT2WmZteIc836MyWIzIC7WFjFnSe5nULeSmn8d+OOIbAou71g4kNOMZlJYTR
        UcuEd6QEo4VgnsW1FazjVOr8gifwVHR9xWZeOwNwXRzupvDJzpkiTEYdi/xUq5HwqeSUhVl7zYF
        0=
X-Received: by 2002:a05:6000:983:b0:236:aacc:ea07 with SMTP id by3-20020a056000098300b00236aaccea07mr45038558wrb.36.1669978229135;
        Fri, 02 Dec 2022 02:50:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5xmf8N/KoyM3E7rvK+vbyjX3grYot4oQfWOk16THK9TJ5D1uAwksRui+qdQ92XRGd+sHEYog==
X-Received: by 2002:a05:6000:983:b0:236:aacc:ea07 with SMTP id by3-20020a056000098300b00236aaccea07mr45038533wrb.36.1669978228835;
        Fri, 02 Dec 2022 02:50:28 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a3170a7af9sm9728818wmb.4.2022.12.02.02.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:50:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Guang Zeng <guang.zeng@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jing Liu <jing2.liu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] KVM: Reference to kvm_userspace_memory_region in doc and comments
Date:   Fri,  2 Dec 2022 11:50:10 +0100
Message-Id: <20221202105011.185147-4-javierm@redhat.com>
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

There are still references to the removed kvm_memory_region data structure
but the doc and comments should mention struct kvm_userspace_memory_region
instead, since that is what's used by the ioctl that replaced the old one
and this data structure support the same set of flags.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 Documentation/virt/kvm/api.rst | 2 +-
 include/linux/kvm_host.h       | 4 ++--
 include/uapi/linux/kvm.h       | 6 +++---
 tools/include/uapi/linux/kvm.h | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 85a5b12eb017..b15ea129f9cf 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1309,7 +1309,7 @@ yet and must be cleared on entry.
 	__u64 userspace_addr; /* start of the userspace allocated memory */
   };
 
-  /* for kvm_memory_region::flags */
+  /* for kvm_userspace_memory_region::flags */
   #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
   #define KVM_MEM_READONLY	(1UL << 1)
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 18592bdf4c1b..759ed18dabb7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -50,8 +50,8 @@
 #endif
 
 /*
- * The bit 16 ~ bit 31 of kvm_memory_region::flags are internally used
- * in kvm, other bits are visible for userspace which are defined in
+ * The bit 16 ~ bit 31 of kvm_userspace_memory_region::flags are internally
+ * used in kvm, other bits are visible for userspace which are defined in
  * include/linux/kvm_h.
  */
 #define KVM_MEMSLOT_INVALID	(1UL << 16)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6ba2928f8f18..e42be6b45b9b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -96,9 +96,9 @@ struct kvm_userspace_memory_region {
 };
 
 /*
- * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
- * other bits are reserved for kvm internal use which are defined in
- * include/linux/kvm_host.h.
+ * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
+ * userspace, other bits are reserved for kvm internal use which are defined
+ * in include/linux/kvm_host.h.
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 6ba2928f8f18..21d6d29502e4 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -96,9 +96,9 @@ struct kvm_userspace_memory_region {
 };
 
 /*
- * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
- * other bits are reserved for kvm internal use which are defined in
- * include/linux/kvm_host.h.
+ * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
+ * userspace, other bits are reserved for kvm internal use which are defined
+ *in include/linux/kvm_host.h.
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
-- 
2.38.1

