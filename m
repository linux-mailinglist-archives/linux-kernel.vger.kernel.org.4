Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8912E5F0DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiI3Oss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiI3OsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:48:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46212B4B6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664549298; x=1696085298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SFh0GJTyJWNp3y0moE5EY5JgImk4r4/0PgKi36Vpy/Q=;
  b=fRnwPX+MOHEM34dzBwH8uZMFTTyOJSLPjBESJyXrsHTQ+AgQ2XpRMtip
   Bp3HoLGPthdndhbsbKfHkyZK3tSOiWQeRDTxTV0L9+rD1VTCqeA9/dbIs
   dFRksvpkhtF01Vz6dzRzgKwBEN/hIEbO7NZEpA2wxMhWgSvL6D8epkmwT
   cBixrGu7opdl43h0MM35kWe+8FL3RT9HrTEjDpr7pChtaQanWRNZpSS4j
   pY3hz4MQOXQhkl699ga9vKlznSmVZ1DxJrE7o9dQxSkXypwjnnqJUUZNU
   pAziJ4QwE6fGgkPbm1pp+clBESgUuWMV5KEZWTUHf9J+NAV45dIZwxMxk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289368000"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289368000"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:48:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653563762"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="653563762"
Received: from herrerop-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:48:11 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 639C4104D60; Fri, 30 Sep 2022 17:48:02 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCHv9 06/14] KVM: Serialize tagged address check against tagging enabling
Date:   Fri, 30 Sep 2022 17:47:50 +0300
Message-Id: <20220930144758.30232-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
References: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM forbids usage of tagged userspace addresses for memslots. It is done
by checking if the address stays the same after untagging.

It is works fine for ARM TBI, but it the check gets racy for LAM. TBI
enabling happens per-thread, so nobody can enable tagging for the thread
while the memslot gets added.

LAM gets enabled per-process. If it gets enabled after the
untagged_addr() check, but before access_ok() check the kernel can
wrongly allow tagged userspace_addr.

Use mmap lock to protect against parallel LAM enabling.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/kvm_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d2239aa85cf5..858c3e870ebc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1941,12 +1941,22 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
 		return -EINVAL;
+
+	/* Serialize against tagging enabling */
+	if (mmap_read_lock_killable(kvm->mm))
+		return -EINTR;
+
 	/* We can read the guest memory with __xxx_user() later on. */
 	if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
 	    (mem->userspace_addr != untagged_addr(kvm->mm, mem->userspace_addr)) ||
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
-			mem->memory_size))
+			mem->memory_size)) {
+		mmap_read_unlock(kvm->mm);
 		return -EINVAL;
+	}
+
+	mmap_read_unlock(kvm->mm);
+
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
-- 
2.35.1

