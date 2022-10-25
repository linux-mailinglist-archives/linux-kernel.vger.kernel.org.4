Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FA60C088
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJYBJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJYBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:08:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9351E704
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657064; x=1698193064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLvyVSLWSQb+POxDNMInSWdsGrXEv5cSfT1ANJOQpLA=;
  b=djrvlDSYU1YcjeuPIjnkiYr5uwqoOFMkojpp+/U9ttcsNJYzTSkTxyvZ
   3JrF6l8S8zBBsXxvRjxKJDNFCP5JpKu3+oRxky/jtTWKUp4RoS5hI3kX0
   wTUxmsXbIgxKPhkVkHA8gI+lOsJkul/87Mt0/Ekp4sal5Yi/+2VD8CrwM
   jxpUvAqpmol6nwZ4Tb5L1TpCAo8Q2U247xUvq8Qyr4nguqMB81ekc2mb5
   PwiH84zX04mcIdo3FFAueduU4D7r1f5lbrqJEXUvQjncdNQTyjApWZUdb
   dZtKeaD0qDcXJuHvxn95/ZdTuwAJEuZ70s8M1w9Gpy2nK1IVxOpeF3dpQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308644667"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308644667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582587481"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582587481"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.118])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:17:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DB0371095BB; Tue, 25 Oct 2022 03:17:25 +0300 (+03)
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
Subject: [PATCHv11 06/16] KVM: Serialize tagged address check against tagging enabling
Date:   Tue, 25 Oct 2022 03:17:12 +0300
Message-Id: <20221025001722.17466-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 8c86b06b35da..833742c21c91 100644
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

