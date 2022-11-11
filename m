Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E660626410
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiKKV7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiKKV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093AE0FE;
        Fri, 11 Nov 2022 13:58:32 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TswilBXU7Oy2dZWbDT8QS/k6DwfBrI6z7NIJB3tf5LE=;
        b=nAN2yu3sIlFigIfN0mcq6rpB7d6KyiBWOQkU5medLVyb3R/WepcD1/7HALAdKnL7XSst+I
        LXE9tTTRFFauFW04iLgqUnZsaC+8gAz7nzdAHokJhmCiRQxmmuKdfpN0C2pobEEZWLF8JD
        /3yhXkPWhN0n6G7Qf7TPVRtMh2lLyXHwZsj3PUWA+40N6FUaTj3/Y6E/U0OdI/E9zxWkfR
        tuFkA2+t6aXBDYZHwcVSDq/zAYAAsMydQtAfjZl5jDcvnoFiYYJ/1cQ+WFvJVPQm9uD3cN
        tmdQa3EdpbDi/uDNHz4EJp1S0pQ/LBgYsFriHAlRv3BPqG/SMoO3MiPtI6y7XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TswilBXU7Oy2dZWbDT8QS/k6DwfBrI6z7NIJB3tf5LE=;
        b=7qj5LszF/Ho1YcA358+VyPszIVrx6cwH1OmTe2E7ceGguYWTIb2pzTnpQ4KOrEGcjcE+QW
        wHv+wHGrASp63nDA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] KVM: Serialize tagged address check against tagging enabling
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390975.4906.6851822769298607595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     9e4ce48087db09c0788a02fb2fd19f24c7f81529
Gitweb:        https://git.kernel.org/tip/9e4ce48087db09c0788a02fb2fd19f24c7f81529
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:30 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:28:07 -08:00

KVM: Serialize tagged address check against tagging enabling

KVM forbids usage of tagged userspace addresses for memslots. It is done
by checking if the address stays the same after untagging.

It is works fine for ARM TBI, but it the check gets racy for LAM. TBI
enabling happens per-thread, so nobody can enable tagging for the thread
while the memslot gets added.

LAM gets enabled per-process. If it gets enabled after the
untagged_addr() check, but before access_ok() check the kernel can
wrongly allow tagged userspace_addr.

Use mmap lock to protect against parallel LAM enabling.

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221109165140.9137-7-kirill.shutemov%40linux.intel.com
---
 virt/kvm/kvm_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d213990..8399aae 100644
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
