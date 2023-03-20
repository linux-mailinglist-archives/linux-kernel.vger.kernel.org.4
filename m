Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD96C1C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjCTQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjCTQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE7158B0;
        Mon, 20 Mar 2023 09:41:06 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5cGVY/C5/GTw2QxGZXT/kH59jUc0ASCRsxXTUboMuAU=;
        b=ZYNgxA1rK8mK6pV5O30zXo0qWp+Xaw6fxlow/i9S2a4oNHYScvg/UHsRZ8UTeB96Ekoo4y
        3zDp3kvzOsikd8p/S2xltwWqZKDJ+8Tmte4QkKLxC4ILxHqAdQZOXuSfAK+CWOQ8ESRnV3
        xJ+VC+I23bryubQLRJD/amomwlN0oUYaOFlFiLoUK45NMRRX9ICJCust0NNIUhRvpg1FQZ
        muUkDL2aPMe8rklC3HYnnPJLCWdoLDvdLrSNeos6nyoBqcaDTc69//RA5/KXhDrg4w0fwj
        dYWevTzKf4LRA3ND4LMFfDv9gzMowmp5iEV+fdO36/akGG4nEXrpru5BEhK9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5cGVY/C5/GTw2QxGZXT/kH59jUc0ASCRsxXTUboMuAU=;
        b=/CrI3fPHbadDahVN5nGqj/aITu0R5W+yXWdAF903994Z/kdz3EpkdlWKgKrAzyIKy7nIzP
        6ihl4fQoLYUF0BDw==
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036663.5837.2737081602720638979.tip-bot2@tip-bot2>
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

Commit-ID:     5b541538cd8c86cb3a8f7a049a0b4a4ff1bd462b
Gitweb:        https://git.kernel.org/tip/5b541538cd8c86cb3a8f7a049a0b4a4ff1bd462b
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:12 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

mm: Move VM_UFFD_MINOR_BIT from 37 to 38

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Future patches will introduce a new VM flag VM_SHADOW_STACK that will be
VM_HIGH_ARCH_BIT_5. VM_HIGH_ARCH_BIT_1 through VM_HIGH_ARCH_BIT_4 are
bits 32-36, and bit 37 is the unrelated VM_UFFD_MINOR_BIT. For the sake
of order, make all VM_HIGH_ARCH_BITs stay together by moving
VM_UFFD_MINOR_BIT from 37 to 38. This will allow VM_SHADOW_STACK to be
introduced as 37.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Peter Xu <peterx@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-18-rick.p.edgecombe%40intel.com
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af65244..a1b31ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -377,7 +377,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	37
+# define VM_UFFD_MINOR_BIT	38
 # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
