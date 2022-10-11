Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224D05FBBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJKT61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJKT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943B98C9D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665518297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgkB5amVUPRR3INxfCSynSvTKOcc2dw225AQHYbN8r0=;
        b=SHlUCObeyAykUCgNCT1NLdBpm6PDUS74F6JiPqVqopMzGoBVl7Nxf1/YZel8p7lC8Fy55X
        GaxeIZilkdoWgPiSxuDaCDXY9S4pMMA3anRGb/ie75RZ7sxbuxNmm/u+l46L4K5L6iKyOr
        JLyuK1ot+Ok4OxpYbHmIsP6jCTHrTMA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-XhASqH0AOcqQMG3VoSz_CA-1; Tue, 11 Oct 2022 15:58:16 -0400
X-MC-Unique: XhASqH0AOcqQMG3VoSz_CA-1
Received: by mail-qk1-f200.google.com with SMTP id k2-20020a05620a414200b006ceec443c8bso12577568qko.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgkB5amVUPRR3INxfCSynSvTKOcc2dw225AQHYbN8r0=;
        b=f9v0ABxYAu/PIqBq6NBXJo0aD+lfyOJdCYcoBRlkiy26dvVvFQzsHKNf5uwsWoinRY
         7YUW5u4k3XcHfHn67c8tFCbd8uEH6GvHyIHy4YK2SN3bvir7f+g+39kGhCgsTTFYDZKG
         y/I8cv7WL573BuJvTwoYfxQHu5UJzMu9FEutdhthgL//IuAgGlzswQZcdjxlsqeNshnV
         fEP0rLBsSKzHClG+W2RORhbaUnD7srAaKzKbo8sIit/9bKJ/enGs+O5FAnPeXvsCnTKC
         5J+v2vLZC3iqH0Mk02J15yILmqdoaAXMOs2WfS6lzyQXNWnU6R19dxwdiA30lAe4f53f
         BxCQ==
X-Gm-Message-State: ACrzQf3qhp0Ids+U+n5qT9aciF3iZJSwsFVYa9iD+twMaTHLJBcjdUkh
        Vikso7uqihx8wev12Ss3upnkcn02wtJWdCTpynzEC/P+A3Uoh6TtwGOfpE2pN3LmfPAFzv8LV2w
        5gyQqr3N8Mf3Z2XB54V/z6KTT
X-Received: by 2002:ac8:7c54:0:b0:35c:ebfd:32b4 with SMTP id o20-20020ac87c54000000b0035cebfd32b4mr20412162qtv.30.1665518296186;
        Tue, 11 Oct 2022 12:58:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6eeX3q/UT6wqtgDWH/uPjS+MLsxyPYFVtszRACLZWTMTJNfYFrayyjfrXgbM3yPOUwQH7YEQ==
X-Received: by 2002:ac8:7c54:0:b0:35c:ebfd:32b4 with SMTP id o20-20020ac87c54000000b0035cebfd32b4mr20412140qtv.30.1665518295920;
        Tue, 11 Oct 2022 12:58:15 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006ce9e880c6fsm13648837qkb.111.2022.10.11.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:58:15 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v4 3/4] kvm: Add interruptible flag to __gfn_to_pfn_memslot()
Date:   Tue, 11 Oct 2022 15:58:08 -0400
Message-Id: <20221011195809.557016-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011195809.557016-1-peterx@redhat.com>
References: <20221011195809.557016-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new "interruptible" flag showing that the caller is willing to be
interrupted by signals during the __gfn_to_pfn_memslot() request.  Wire it
up with a FOLL_INTERRUPTIBLE flag that we've just introduced.

This prepares KVM to be able to respond to SIGUSR1 (for QEMU that's the
SIGIPI) even during e.g. handling an userfaultfd page fault.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/kvm/mmu.c                   |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
 arch/x86/kvm/mmu/mmu.c                 |  4 ++--
 include/linux/kvm_host.h               |  4 ++--
 virt/kvm/kvm_main.c                    | 28 ++++++++++++++++----------
 virt/kvm/kvm_mm.h                      |  4 ++--
 virt/kvm/pfncache.c                    |  2 +-
 8 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 34c5feed9dc1..7b990b33b337 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1232,7 +1232,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 */
 	smp_rmb();
 
-	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
+	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, false, NULL,
 				   write_fault, &writable, NULL);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(hva, vma_shift);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index e9744b41a226..4939f57b6f6a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -598,7 +598,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
 		write_ok = true;
 	} else {
 		/* Call KVM generic code to do the slow-path check */
-		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
+		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, false, NULL,
 					   writing, &write_ok, NULL);
 		if (is_error_noslot_pfn(pfn))
 			return -EFAULT;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 5d5e12f3bf86..9d3743ca16d5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -846,7 +846,7 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 		unsigned long pfn;
 
 		/* Call KVM generic code to do the slow-path check */
-		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
+		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, false, NULL,
 					   writing, upgrade_p, NULL);
 		if (is_error_noslot_pfn(pfn))
 			return -EFAULT;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f81539061d6..cc26f425f41c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4169,7 +4169,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	}
 
 	async = false;
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
+	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
 					  fault->write, &fault->map_writable,
 					  &fault->hva);
 	if (!async)
@@ -4186,7 +4186,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, NULL,
+	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, NULL,
 					  fault->write, &fault->map_writable,
 					  &fault->hva);
 	return RET_PF_CONTINUE;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 92baa930b891..1904162a041d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1150,8 +1150,8 @@ kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn);
 kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
-			       bool atomic, bool *async, bool write_fault,
-			       bool *writable, hva_t *hva);
+			       bool atomic, bool interruptible, bool *async,
+			       bool write_fault, bool *writable, hva_t *hva);
 
 void kvm_release_pfn_clean(kvm_pfn_t pfn);
 void kvm_release_pfn_dirty(kvm_pfn_t pfn);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e20a59dcda32..903ec86c4d54 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2514,7 +2514,7 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
  * 1 indicates success, -errno is returned if error is detected.
  */
 static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
-			   bool *writable, kvm_pfn_t *pfn)
+			   bool interruptible, bool *writable, kvm_pfn_t *pfn)
 {
 	unsigned int flags = FOLL_HWPOISON;
 	struct page *page;
@@ -2529,6 +2529,8 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 		flags |= FOLL_WRITE;
 	if (async)
 		flags |= FOLL_NOWAIT;
+	if (interruptible)
+		flags |= FOLL_INTERRUPTIBLE;
 
 	npages = get_user_pages_unlocked(addr, 1, &page, flags);
 	if (npages != 1)
@@ -2638,6 +2640,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
  * Pin guest page in memory and return its pfn.
  * @addr: host virtual address which maps memory to the guest
  * @atomic: whether this function can sleep
+ * @interruptible: whether the process can be interrupted by non-fatal signals
  * @async: whether this function need to wait IO complete if the
  *         host page is not in the memory
  * @write_fault: whether we should get a writable host page
@@ -2648,8 +2651,8 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
  * 2): @write_fault = false && @writable, @writable will tell the caller
  *     whether the mapping is writable.
  */
-kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
-		     bool write_fault, bool *writable)
+kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
+		     bool *async, bool write_fault, bool *writable)
 {
 	struct vm_area_struct *vma;
 	kvm_pfn_t pfn;
@@ -2664,7 +2667,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	if (atomic)
 		return KVM_PFN_ERR_FAULT;
 
-	npages = hva_to_pfn_slow(addr, async, write_fault, writable, &pfn);
+	npages = hva_to_pfn_slow(addr, async, write_fault, interruptible,
+				 writable, &pfn);
 	if (npages == 1)
 		return pfn;
 	if (npages == -EINTR)
@@ -2699,8 +2703,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 }
 
 kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
-			       bool atomic, bool *async, bool write_fault,
-			       bool *writable, hva_t *hva)
+			       bool atomic, bool interruptible, bool *async,
+			       bool write_fault, bool *writable, hva_t *hva)
 {
 	unsigned long addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
 
@@ -2725,7 +2729,7 @@ kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
 		writable = NULL;
 	}
 
-	return hva_to_pfn(addr, atomic, async, write_fault,
+	return hva_to_pfn(addr, atomic, interruptible, async, write_fault,
 			  writable);
 }
 EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
@@ -2733,20 +2737,22 @@ EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable)
 {
-	return __gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn, false, NULL,
-				    write_fault, writable, NULL);
+	return __gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn, false, false,
+				    NULL, write_fault, writable, NULL);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_prot);
 
 kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, false, NULL, true, NULL, NULL);
+	return __gfn_to_pfn_memslot(slot, gfn, false, false, NULL, true,
+				    NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot);
 
 kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, true, NULL, true, NULL, NULL);
+	return __gfn_to_pfn_memslot(slot, gfn, true, false, NULL, true,
+				    NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
 
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 41da467d99c9..a1ab15006af3 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -24,8 +24,8 @@
 #define KVM_MMU_READ_UNLOCK(kvm)	spin_unlock(&(kvm)->mmu_lock)
 #endif /* KVM_HAVE_MMU_RWLOCK */
 
-kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
-		     bool write_fault, bool *writable);
+kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
+		     bool *async, bool write_fault, bool *writable);
 
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 68ff41d39545..6f66808d7793 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -182,7 +182,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)
 		}
 
 		/* We always request a writeable mapping */
-		new_pfn = hva_to_pfn(gpc->uhva, false, NULL, true, NULL);
+		new_pfn = hva_to_pfn(gpc->uhva, false, false, NULL, true, NULL);
 		if (is_error_noslot_pfn(new_pfn))
 			goto out_error;
 
-- 
2.37.3

