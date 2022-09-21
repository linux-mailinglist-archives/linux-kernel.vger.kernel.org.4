Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87845BF7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIUHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIUHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:41:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673C38465;
        Wed, 21 Sep 2022 00:41:28 -0700 (PDT)
Date:   Wed, 21 Sep 2022 07:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663746087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wu+BruCALwUpD2lDrO0YO7yShipqAZGwJY0ERPsOUY4=;
        b=t8cD8SuSvSXXGZnw9H+BILREcgc+qggDovQeBCXDLqsPgVTJqu1g4ahLfz02dnJQHKRtgs
        KIB4TkkrJTl8LHf0kgXKQQ+MLtIhgjFhNsHGvivuZu+/jVuHFQCBXW0xhr8yjSHwWs4dV0
        2gURhneRzXx3BerMcKlBZxEkvJgS9qEhfmdosr+BH33scnrmUxf5O7J0lDcYfvEpNrt18f
        I+umE5orI/u5YRXNpvlBUGExREbdjI3OCByNRyIKaZObxxvjMoETv0JpfIfFZ+Ea4quAru
        8Y5rEOmJJy13jO3lgiPBJ3x9bkYTVS7SJIMLHvDI67sBBenpnrsFAJ4TO0BJiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663746087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wu+BruCALwUpD2lDrO0YO7yShipqAZGwJY0ERPsOUY4=;
        b=F/FK704gs6pyI0QchpM2MS3c2umoQwZ5K/EnbUHkXcub3JL/TQyp/SFasNPXmaMNfWSyeI
        f6dt44qItdxtHTDg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/32: Fix W^X detection when page tables do not support NX
Cc:     kernel test robot <yujie.liu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166374608563.401.6842745762071109491.tip-bot2@tip-bot2>
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

Commit-ID:     9377ad7b61bff3abfb375d307770d6aa454bc516
Gitweb:        https://git.kernel.org/tip/9377ad7b61bff3abfb375d307770d6aa454bc516
Author:        Dave Hansen <dave.hansen@intel.com>
AuthorDate:    Tue, 20 Sep 2022 11:54:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 21 Sep 2022 09:32:55 +02:00

x86/mm/32: Fix W^X detection when page tables do not support NX

The x86 MM code now actively refuses to create writable+executable mappings,
and warns when there is an attempt to create one.

The 0day test robot ran across a warning triggered by module unloading on
32-bit kernels.  This was only seen on CPUs with NX support, but where a
32-bit kernel was built without PAE support.

On those systems, there is no room for the NX bit in the page
tables and _PAGE_NX is #defined to 0, breaking some of the W^X
detection logic in verify_rwx().  The X86_FEATURE_NX check in
there does not do any good here because the CPU itself supports
NX.

Fix it by checking for _PAGE_NX support directly instead of
checking CPU support for NX.

Note that since _PAGE_NX is actually defined to be 0 at
compile-time this fix should also end up letting the compiler
optimize away most of verify_rwx() on non-PAE kernels.

Fixes: 652c5bf380ad ("x86/mm: Refuse W^X violations")
Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/fcf89147-440b-e478-40c9-228c9fe56691@intel.com/
---
 arch/x86/mm/pat/set_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1a2d637..20b1e24 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -587,7 +587,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
-	if (!cpu_feature_enabled(X86_FEATURE_NX))
+	/* Only enforce when NX is supported: */
+	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
 
 	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
