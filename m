Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5C724D64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjFFTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbjFFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C610F8;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqSqEwPJuDt1WK2o2t/lGp+L4pTgMcN83XPVaActu70=;
        b=FqyYwHDafVFtQd5uDfrpXufYlC42OC5dbO5RFIu0dHMYkcinvSDXvpVe9NnE/YYp7R93OC
        ay2uC0bk89dizlpK7RANllm7yDEUt7EFfBazYsMhuHfAdMPJ0PHv7chknIDLOHbr7tvUeD
        a65BZoVS4W4fYOJ53gtKRQi8iSS+qKbOzh7QY3ehcFOiEQVgEBs5vSd04lJXLamtyeBJvc
        h/cVJTR1Qa6myYmMv7fs8Ks2GcYTc32lLJy0/vmoZgSwvFrHncZTfXUG+hHVqjeTyDtTG1
        Z+7VYhOyoTdRkSC2zOe5RBjQk5yNqp/V32U8hPfloYfnI1ifUVxYq4lYucM0Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqSqEwPJuDt1WK2o2t/lGp+L4pTgMcN83XPVaActu70=;
        b=mRO2HkFs+ZniRHJO5dct14pL3ZtBiMFTzbYlDJKOIE0W5deEuMJwTYTSJrc75H8UotTJbm
        Q3TeEmofTsxnzNDQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] efi/unaccepted: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-7-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608055917.404.9213090219412182829.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     c211c19e80d046441655e372c6ae15f29d358259
Gitweb:        https://git.kernel.org/tip/c211c19e80d046441655e372c6ae15f29d358259
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:34 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 17:27:08 +02:00

efi/unaccepted: Avoid load_unaligned_zeropad() stepping into unaccepted memory

load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
The unwanted loads are typically harmless. But, they might be made to
totally unrelated or even unmapped memory. load_unaligned_zeropad()
relies on exception fixup (#PF, #GP and now #VE) to recover from these
unwanted loads.

But, this approach does not work for unaccepted memory. For TDX, a load
from unaccepted memory will not lead to a recoverable exception within
the guest. The guest will exit to the VMM where the only recourse is to
terminate the guest.

There are two parts to fix this issue and comprehensively avoid access
to unaccepted memory. Together these ensure that an extra "guard" page
is accepted in addition to the memory that needs to be used.

1. Implicitly extend the range_contains_unaccepted_memory(start, end)
   checks up to end+unit_size if 'end' is aligned on a unit_size
   boundary.
2. Implicitly extend accept_memory(start, end) to end+unit_size if 'end'
   is aligned on a unit_size boundary.

Side note: This leads to something strange. Pages which were accepted
	   at boot, marked by the firmware as accepted and will never
	   _need_ to be accepted might be on unaccepted_pages list
	   This is a cue to ensure that the next page is accepted
	   before 'page' can be used.

This is an actual, real-world problem which was discovered during TDX
testing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230606142637.5171-7-kirill.shutemov@linux.intel.com
---
 drivers/firmware/efi/unaccepted_memory.c | 35 +++++++++++++++++++++++-
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 08a9a84..853f7dc 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -46,6 +46,34 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	start -= unaccepted->phys_base;
 	end -= unaccepted->phys_base;
 
+	/*
+	 * load_unaligned_zeropad() can lead to unwanted loads across page
+	 * boundaries. The unwanted loads are typically harmless. But, they
+	 * might be made to totally unrelated or even unmapped memory.
+	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
+	 * #VE) to recover from these unwanted loads.
+	 *
+	 * But, this approach does not work for unaccepted memory. For TDX, a
+	 * load from unaccepted memory will not lead to a recoverable exception
+	 * within the guest. The guest will exit to the VMM where the only
+	 * recourse is to terminate the guest.
+	 *
+	 * There are two parts to fix this issue and comprehensively avoid
+	 * access to unaccepted memory. Together these ensure that an extra
+	 * "guard" page is accepted in addition to the memory that needs to be
+	 * used:
+	 *
+	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
+	 *    checks up to end+unit_size if 'end' is aligned on a unit_size
+	 *    boundary.
+	 *
+	 * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
+	 *    'end' is aligned on a unit_size boundary. (immediately following
+	 *    this comment)
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
 	/* Make sure not to overrun the bitmap */
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
@@ -93,6 +121,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 	start -= unaccepted->phys_base;
 	end -= unaccepted->phys_base;
 
+	/*
+	 * Also consider the unaccepted state of the *next* page. See fix #1 in
+	 * the comment on load_unaligned_zeropad() in accept_memory().
+	 */
+	if (!(end % unit_size))
+		end += unit_size;
+
 	/* Make sure not to overrun the bitmap */
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
