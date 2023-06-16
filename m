Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5773386C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbjFPSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345201AbjFPSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:53:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9E3AA5;
        Fri, 16 Jun 2023 11:53:23 -0700 (PDT)
Date:   Fri, 16 Jun 2023 18:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686941601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8bt6GbZy0AVDBFsEt7a+yTKmNBsrum7dVB7lreI8D7I=;
        b=uOLoSFEhMiB6o0KB3odoVIpJ7PtKMKj23lrAWdjvbsDojANzr0ckETCVz3w13UsY2zWGiz
        co0BrIIOJk6YgvOJ0aPNygXqmb2jQs26Yqlzu6/8eEFpoOSy5pIirl5b/WJiIGVKoKyvsr
        Wcne8GA9jBJjKqiceRXdO4Ync+SHPKOwBgS6XoRKV+aAy1Bd33GXb7OBN+JLg7PeiFiad+
        0v32Nj/FYukYJiAYWTVS20uX7408oYBhHI7ZOhVouG+vgDsJSOcASCqZUpkiOZphp0dAsq
        B8zFIxrRMZIPfCVXfWxpGVIS84om4VZ5c+JpfpHTIIewiWOBG+C7Alsi1Hu3wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686941601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8bt6GbZy0AVDBFsEt7a+yTKmNBsrum7dVB7lreI8D7I=;
        b=O+2eFfmNGCjG7iHNV3zvBNjYblfyfKXyjMU/ag1VmkG8HGvyV0LZr1o8gtTIwTD9XoZilA
        PHomy39TRq6dMSAg==
From:   "tip-bot2 for Lee Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Avoid using set_pgd() outside of real PGD pages
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <stable@vger.kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694160067.404.13343792487331756749.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d082d48737c75d2b3cc1f972b8c8674c25131534
Gitweb:        https://git.kernel.org/tip/d082d48737c75d2b3cc1f972b8c8674c25131534
Author:        Lee Jones <lee@kernel.org>
AuthorDate:    Wed, 14 Jun 2023 17:38:54 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 16 Jun 2023 11:46:42 -07:00

x86/mm: Avoid using set_pgd() outside of real PGD pages

KPTI keeps around two PGDs: one for userspace and another for the
kernel. Among other things, set_pgd() contains infrastructure to
ensure that updates to the kernel PGD are reflected in the user PGD
as well.

One side-effect of this is that set_pgd() expects to be passed whole
pages.  Unfortunately, init_trampoline_kaslr() passes in a single entry:
'trampoline_pgd_entry'.

When KPTI is on, set_pgd() will update 'trampoline_pgd_entry' (an
8-Byte globally stored [.bss] variable) and will then proceed to
replicate that value into the non-existent neighboring user page
(located +4k away), leading to the corruption of other global [.bss]
stored variables.

Fix it by directly assigning 'trampoline_pgd_entry' and avoiding
set_pgd().

[ dhansen: tweak subject and changelog ]

Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20230614163859.924309-1-lee@kernel.org/g
---
 arch/x86/mm/kaslr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe..37db264 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
