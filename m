Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010862FC05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiKRRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:52:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6ED3F07B;
        Fri, 18 Nov 2022 09:52:38 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668793956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C9icFdV4kUTLB8nW3Zigy8SnuVAjyYCTdXQgDFSosuE=;
        b=PnTT8HBztbtDO/HULmqo2sMXhWKudg+EAzgU6+rT8y4zeWMvndZ0ifCABAUyptlzrkF248
        HxNF4Z+xfEnp2oy8IdKgbCC3XHG7siGFzGNoOGVY4MeLDPZgu076S2pKXL5ip5X+z+GoL+
        UzWyCQWPYMqprkt88vYstx1mu71Venh35XW68eogPR06iRo87swN6rp2LdrlEkWpQs71qV
        nQYnjsZ1Iz4KhiNqHWOBGCsXQUpEaVNpWFmKM2hxDS2ggYbl2vQe4crDF6TVyh0XXiQBG4
        ss5S8rh800CKWK9hwi+U0wJeugGipLwZxxyCjtuV03+sNxuggmOCQIyxEKem9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668793956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C9icFdV4kUTLB8nW3Zigy8SnuVAjyYCTdXQgDFSosuE=;
        b=FdYjwZwnAFRW1h/Ubj3nzbDUZEtdjsPGWErh++oqufh8pQuuwaxuI3REjqhyaZlSbLJwwZ
        z52rdd22A8W62QCQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Ensure forced page table splitting
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166879395396.4906.1394517398531168643.tip-bot2@tip-bot2>
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

Commit-ID:     71cfdf0c336fb20b0f2941ca9b8f6b23d8d6c86b
Gitweb:        https://git.kernel.org/tip/71cfdf0c336fb20b0f2941ca9b8f6b23d8d6c86b
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 18 Nov 2022 07:16:16 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 18 Nov 2022 09:46:05 -08:00

x86/mm: Ensure forced page table splitting

There are a few kernel users like kfence that require 4k pages to work
correctly and do not support large mappings.  They use set_memory_4k()
to break down those large mappings.

That, in turn relies on cpa_data->force_split option to indicate to
set_memory code that it should split page tables regardless of whether
the need to be.

But, a recent change added an optimization which would return early
if a set_memory request came in that did not change permissions.  It
did not consult ->force_split and would mistakenly optimize away the
splitting that set_memory_4k() needs.  This broke kfence.

Skip the same-permission optimization when ->force_split is set.

Fixes: 127960a05548 ("x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Marco Elver <elver@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com/
---
 arch/x86/mm/pat/set_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 220361c..0db6951 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1727,7 +1727,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 	/*
 	 * No changes, easy!
 	 */
-	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)))
+	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)) &&
+	    !cpa->force_split)
 		return ret;
 
 	while (rempages) {
