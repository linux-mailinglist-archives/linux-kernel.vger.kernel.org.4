Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471837250E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbjFFXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjFFXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB701715;
        Tue,  6 Jun 2023 16:38:20 -0700 (PDT)
Date:   Tue, 06 Jun 2023 23:38:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686094699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K3gxL2oHsP6unnFhP1ILU8/kIkGe90RdmIY3FkII8es=;
        b=DQ6MX+ixqpWNhXYXfaemd004VbaBEbaSDfUMaNqEY07Fn9mWWSqrQHyTOKiWDgTnuJ3uMk
        yyvdF66GAhVuC5iuwHaf53A74FczIOtUXvJMBjezvh9RKV98x5DIpptNGx8R9F2qVdtIVB
        63FrEDfRlxUF3RVPO5oSJK5MGKuzqcjBWHD9HK9VEY8HJkJAOpQ4zbaWAWjcM1qtgEsQH5
        P4pqfjfb37wxA8FzEok0CWM1ujm1QVzZBSTJlhufHzSZ0rwrpZlleYZss396yHqEhM2xBe
        /x/bwhMFqO35MVKiHaeLUN7gkDbRdm7dqCmr2KIX4te2xNzQHk1x6Wfm/Des+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686094699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K3gxL2oHsP6unnFhP1ILU8/kIkGe90RdmIY3FkII8es=;
        b=QrYN/40e2kJiYZtkAI7MTazyn79E6F7a+Otl0gh0PRJWxXevuplQcaIeojlFBz2jR9DDRF
        uDUArnvc0fN66rDA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix race between set_memory_encrypted() and
 load_unaligned_zeropad()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168609469867.404.8097595708928822034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     195edce08b63d293377f615f4f7f086715d2d212
Gitweb:        https://git.kernel.org/tip/195edce08b63d293377f615f4f7f086715d2d212
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 12:56:21 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jun 2023 16:24:02 -07:00

x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()

tl;dr: There is a race in the TDX private<=>shared conversion code
       which could kill the TDX guest.  Fix it by changing conversion
       ordering to eliminate the window.

TDX hardware maintains metadata to track which pages are private and
shared. Additionally, TDX guests use the guest x86 page tables to
specify whether a given mapping is intended to be private or shared.
Bad things happen when the intent and metadata do not match.

So there are two thing in play:
 1. "the page" -- the physical TDX page metadata
 2. "the mapping" -- the guest-controlled x86 page table intent

For instance, an unrecoverable exit to VMM occurs if a guest touches a
private mapping that points to a shared physical page.

In summary:
	* Private mapping => Private Page == OK (obviously)
	* Shared mapping  => Shared Page  == OK (obviously)
	* Private mapping => Shared Page  == BIG BOOM!
	* Shared mapping  => Private Page == OK-ish
	  (It will read generate a recoverable #VE via handle_mmio())

Enter load_unaligned_zeropad(). It can touch memory that is adjacent but
otherwise unrelated to the memory it needs to touch. It will cause one
of those unrecoverable exits (aka. BIG BOOM) if it blunders into a
shared mapping pointing to a private page.

This is a problem when __set_memory_enc_pgtable() converts pages from
shared to private. It first changes the mapping and second modifies
the TDX page metadata.  It's moving from:

        * Shared mapping  => Shared Page  == OK
to:
        * Private mapping => Shared Page  == BIG BOOM!

This means that there is a window with a shared mapping pointing to a
private page where load_unaligned_zeropad() can strike.

Add a TDX handler for guest.enc_status_change_prepare(). This converts
the page from shared to private *before* the page becomes private.  This
ensures that there is never a private mapping to a shared page.

Leave a guest.enc_status_change_finish() in place but only use it for
private=>shared conversions.  This will delay updating the TDX metadata
marking the page private until *after* the mapping matches the metadata.
This also ensures that there is never a private mapping to a shared page.

[ dhansen: rewrite changelog ]

Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/all/20230606095622.1939-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 51 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 15569bd..5b8056f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -829,6 +829,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					  bool enc)
+{
+	/*
+	 * Only handle shared->private conversion here.
+	 * See the comment in tdx_early_init().
+	 */
+	if (enc)
+		return tdx_enc_status_changed(vaddr, numpages, enc);
+	return true;
+}
+
+static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+					 bool enc)
+{
+	/*
+	 * Only handle private->shared conversion here.
+	 * See the comment in tdx_early_init().
+	 */
+	if (!enc)
+		return tdx_enc_status_changed(vaddr, numpages, enc);
+	return true;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -856,9 +880,30 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
-	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+	/*
+	 * The kernel mapping should match the TDX metadata for the page.
+	 * load_unaligned_zeropad() can touch memory *adjacent* to that which is
+	 * owned by the caller and can catch even _momentary_ mismatches.  Bad
+	 * things happen on mismatch:
+	 *
+	 *   - Private mapping => Shared Page  == Guest shutdown
+         *   - Shared mapping  => Private Page == Recoverable #VE
+	 *
+	 * guest.enc_status_change_prepare() converts the page from
+	 * shared=>private before the mapping becomes private.
+	 *
+	 * guest.enc_status_change_finish() converts the page from
+	 * private=>shared after the mapping becomes private.
+	 *
+	 * In both cases there is a temporary shared mapping to a private page,
+	 * which can result in a #VE.  But, there is never a private mapping to
+	 * a shared page.
+	 */
+	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
+	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+
+	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
 	pr_info("Guest detected\n");
 }
