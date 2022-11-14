Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B0627CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiKNLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42FA443
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B278D61045
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37ABC433D6;
        Mon, 14 Nov 2022 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426260;
        bh=IHoKQKrRrTt+P5k/IAfDdtfWsTsoL9pAz/rh5KwFgsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPJIeLVKEPphF5Jd/ZBtMLYLlwXq2jNC6yM/rnlSjD/oEDQPHp1ZE7kCqMJrdANgg
         OYx54IDoHISHcJxw3pc63Qs2tcOYxTtRHcTJ4W9F7HcoW5/trhw8vxeyyBHq+m/Pis
         eVp7HVYPXPjZu/8kvjDRf+wsLTPWpFOJXSIB9ygDzr+QGCKYC9YzaiJGp+oM9zBEML
         XaRGFyOztx/UxUgwt2iThXV+acWKlYmMWdcI+N5dtWuxNIMlKfJRSY9V6c/13B3Uj9
         OBttxZPrsD3xy5aYX5kXeCwCk+/s7m658Lv3c+TMu6DYODrLIFZWoGZ5JMdKyP8xcJ
         WYpEU/+a4AW3w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/46] x86/alternative, lto: Mark int3_*() as global and __visible
Date:   Mon, 14 Nov 2022 12:43:09 +0100
Message-Id: <20221114114344.18650-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark int3_magic() and int3_selftest_ip() as global and __visible.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/x86/kernel/alternative.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..05e5eb9cbd51 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -823,11 +823,12 @@ extern struct paravirt_patch_site __start_parainstructions[],
  * convention such that we can 'call' it from assembly.
  */
 
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
+extern __visible void int3_magic(unsigned int *ptr); /* defined in asm */
 
 asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_magic, @function\n"
+"	.globl		int3_magic\n"
 "int3_magic:\n"
 	ANNOTATE_NOENDBR
 "	movl	$1, (%" _ASM_ARG1 ")\n"
@@ -836,7 +837,7 @@ asm (
 "	.popsection\n"
 );
 
-extern void int3_selftest_ip(void); /* defined in asm below */
+extern __visible void int3_selftest_ip(void); /* defined in asm below */
 
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
-- 
2.38.1

