Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B86FB1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEHNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjEHNl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D719917;
        Mon,  8 May 2023 06:41:52 -0700 (PDT)
Date:   Mon, 08 May 2023 13:41:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683553310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJZo66bmNey3lT9jFnB9bUIzDEHCyi70FsJKZ/DnTpA=;
        b=wn8f6IfTaN1+x8oBnYVZP3TBh2OWfttD89smYptRexO0AncSv/VyMEDflQpxmj9P36qc0L
        kCpTI19vMEzK50QkfHvm5+dlbm8Gnc1bL/ZaHD6gGvyGSp1GONFoxDqEF5u0XqA6+oOL4G
        PDJRwbXOzebmIHjnm8p1yRmp9u3iCjlHbTOtOQQcw2Jjvl8foy0i+D9Qm5UWLbI4W/3R9u
        Rx1ENacm8qfviqvXo/nECUkyADnsknlOaOjPB1crAUTcmAskton6ndGgRckfxNBw7sqnRa
        1Nu3qSl9y4VAffQAmHOmtUMaFQKcAjI4OFqTfPniioJkRy/4BD59N94ifO7UEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683553310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJZo66bmNey3lT9jFnB9bUIzDEHCyi70FsJKZ/DnTpA=;
        b=ftuWG76R8UhgbnE/Us7FgvMELMoTWNfVaUcjHLC4Tj9xh31xnUUOtciM2E8RiLlMaRqJu+
        euOtYLLwOCmZToDw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>
References: <20230306123259.12461-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168355331020.404.17123011230047801582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0f88130e8a6fd185b0aeb5d8e286083735f2585a
Gitweb:        https://git.kernel.org/tip/0f88130e8a6fd185b0aeb5d8e286083735f2585a
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 06 Mar 2023 13:32:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 15:25:24 +02:00

x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Normally __swp_entry_to_pte() is never called with a value translating
to a valid PTE. The only known exception is pte_swap_tests(), resulting
in a WARN splat in Xen PV guests, as __pte_to_swp_entry() did
translate the PFN of the valid PTE to a guest local PFN, while
__swp_entry_to_pte() doesn't do the opposite translation.

Fix that by using __pte() in __swp_entry_to_pte() instead of open
coding the native variant of it.

For correctness do the similar conversion for __swp_entry_to_pmd().

Fixes: 05289402d717 ("mm/debug_vm_pgtable: add tests validating arch helpers for core MM features")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230306123259.12461-1-jgross@suse.com
---
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 7929327..a629b1b 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -237,8 +237,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val((pmd)) })
-#define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
-#define __swp_entry_to_pmd(x)		((pmd_t) { .pmd = (x).val })
+#define __swp_entry_to_pte(x)		(__pte((x).val))
+#define __swp_entry_to_pmd(x)		(__pmd((x).val))
 
 extern void cleanup_highmap(void);
 
