Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8367623086
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiKIQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiKIQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6124F25C41
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012739; x=1699548739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PRHpYCdvQPrEk4Dh8NC0NI3aanRW/V6efiDpPBADx4Y=;
  b=TygHs3kSZ2Sm/FQBkGTn8pSnkhgqhPSSedePkQYDPfPFIwNUTwkzvEUj
   cz3veemBdi6fyzn88HG7wV0DEcvcurTyE956E+fkJjNB2v1kbD9YMx9Gz
   lg0JuxdLRX2LJifQL3yVfblD2w1td54BOsK6wFidZnHMqufJr90f1da/z
   g+S+OeZGwk9D16w1D/fcO70JDCIv6i807GtqEnHEU5R1fMabEJLW30mQn
   wnYZAbaLFZLAPJAeSKvuaAzx7cym+apIzT+T64H6UlNS9oRkzU0c/7BOD
   UZJjWI9Y65Nt2NoU6aHOZz1/b4H2LHPHCflsnLwuh0fYCyxa9CN+mggmK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298553715"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="298553715"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="587827259"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="587827259"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:10 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 93A4C109472; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
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
Subject: [PATCHv12 06/16] KVM: Serialize tagged address check against tagging enabling
Date:   Wed,  9 Nov 2022 19:51:30 +0300
Message-Id: <20221109165140.9137-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index d2139906ff91..8399aae16e83 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1943,12 +1943,22 @@ int __kvm_set_memory_region(struct kvm *kvm,
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
2.38.0

