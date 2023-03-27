Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7116CAF70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjC0UKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjC0UJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB48172A;
        Mon, 27 Mar 2023 13:09:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2jw5BA/HVG6MhvyqeHZziDkRNXCWdjJkAUwLh/XHD4=;
        b=AfmK3AFwqSDfAWXTZsqDUaA8wViuBTcFQdRS239HONCZ+XschQxwpAr22pbiJdJsT+pGlk
        ymMPK6GGB4ZLWHJQMNtBYqKSn283+ZNWSnzW83zPMboJhD9ZJOr9rnEV7mc8/VK0v39QSW
        yZKa44cTTbtabthiiqTFkuf4pY8lfqBeZI8p6zre6K8TcNC5JnhhTf4Ak5ncUjug6eDEMt
        +Jn4GewSwdrznTUHk1a2lxvK6W4LvmebP/vRBwlEw2MvdbRPZ9R9IeuP3a7ttfVQIrhnxo
        dFrgWiG5L8wY3v++W7hVdi002nWqcQhkEt2MN2N0BIfWGG3yFNGxbUpgaIAenQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2jw5BA/HVG6MhvyqeHZziDkRNXCWdjJkAUwLh/XHD4=;
        b=SwEaRKjwxeI8erabPwBfIIIwQ2Ap9ho6p0ulqSJzMpUqcOp7Dq4gmq8z46WHgB04iX29s3
        r37U5S1f4iDBieBg==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] Drivers: hv: Explicitly request decrypted in vmap_pfn() calls
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1679838727-87310-4-git-send-email-mikelley@microsoft.com>
References: <1679838727-87310-4-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779321.5837.13303658601319169134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d33ddc92db8a61416473ff3d7f1c621c50733dc0
Gitweb:        https://git.kernel.org/tip/d33ddc92db8a61416473ff3d7f1c621c50733dc0
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Sun, 26 Mar 2023 06:51:58 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Mar 2023 08:46:43 +02:00

Drivers: hv: Explicitly request decrypted in vmap_pfn() calls

Update vmap_pfn() calls to explicitly request that the mapping
be for decrypted access to the memory.  There's no change in
functionality since the PFNs passed to vmap_pfn() are above the
shared_gpa_boundary, implicitly producing a decrypted mapping.
But explicitly requesting "decrypted" allows the code to work
before and after changes that cause vmap_pfn() to mask the
PFNs to being below the shared_gpa_boundary.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Link: https://lore.kernel.org/r/1679838727-87310-4-git-send-email-mikelley@microsoft.com
---
 arch/x86/hyperv/ivm.c    | 2 +-
 drivers/hv/ring_buffer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index f33c67e..5648efb 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -343,7 +343,7 @@ void *hv_map_memory(void *addr, unsigned long size)
 		pfns[i] = vmalloc_to_pfn(addr + i * PAGE_SIZE) +
 			(ms_hyperv.shared_gpa_boundary >> PAGE_SHIFT);
 
-	vaddr = vmap_pfn(pfns, size / PAGE_SIZE, PAGE_KERNEL_IO);
+	vaddr = vmap_pfn(pfns, size / PAGE_SIZE, pgprot_decrypted(PAGE_KERNEL));
 	kfree(pfns);
 
 	return vaddr;
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index c6692fd..2111e97 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -211,7 +211,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 		ring_info->ring_buffer = (struct hv_ring_buffer *)
 			vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
-				 PAGE_KERNEL);
+				 pgprot_decrypted(PAGE_KERNEL));
 		kfree(pfns_wraparound);
 
 		if (!ring_info->ring_buffer)
