Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4316C1CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjCTQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjCTQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:53:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAE26864;
        Mon, 20 Mar 2023 09:45:41 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yoZLOt43Nj4HcPAR6MnnHHxjOvqvURzyMrfyzfY3TWk=;
        b=t4kLOQd0b/+DTYAAZVhw22iJIwtUwcGq9+2OLL4bS++hK1xw3cBJ5kw32n23WKblx5s9co
        JqpY0Su6/xGH7cWX1Cespmfawka7LTPXckSZHbE8phFWAI8HVDRSZMPKGZoLgWN8abItF6
        8H1zRSxmREyzACoJmT/ei97gLOyDoelmaQdAZIkwTRcNr5eSjvn5r6vb3WyVosdc0oyaGU
        v9DJ+0IaqyaYBy9QwQ/n2i0gBz0yDbYyg/skANq4b7WRZdHBUaKVMpzX+gL9LVsEs+aTvA
        AirODSfcG/VvZ7ENhY6bToWeuTkiShWlRDLXdBnFNPpWeHydQMXGILh8qFPqoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yoZLOt43Nj4HcPAR6MnnHHxjOvqvURzyMrfyzfY3TWk=;
        b=UsNBxfnN8/+KX+Jhufhmpb772ZPQzIBXQ/aMwAX+fUX5/VdAoSpmhehLmizpqfP/HRvmSr
        rQaQTLh7zNzF5cAg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm/mmap: Add shadow stack pages to memory accounting
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036526.5837.17795357929902595060.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     4c8e07c3b6db4a514b03f2f2455e81e512d2f785
Gitweb:        https://git.kernel.org/tip/4c8e07c3b6db4a514b03f2f2455e81e512d2f785
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:17 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:10 -07:00

mm/mmap: Add shadow stack pages to memory accounting

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-23-rick.p.edgecombe%40intel.com
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b..2e9f313 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -491,14 +491,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 }
 
 /*
- * Stack area - automatically grows in one direction
+ * Stack area (including shadow stacks)
  *
  * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
  * do_mmap() forbids all other combinations.
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return (flags & VM_STACK) == VM_STACK;
+	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
 }
 
 /*
