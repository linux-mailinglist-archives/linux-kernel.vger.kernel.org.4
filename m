Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8580D6A9B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCCQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCCQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:06:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85641B68
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:06:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEFB322310;
        Fri,  3 Mar 2023 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677859608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qUbas8+9LTlIYdmVN4CIX3YAxB/ippen+8fFcV4qE+4=;
        b=QZIoSjOo2HRjG0Cdn6eCrGfBs4cMpWhhDEW3UnqEAta3VbZm//lMRGjS5BsP91yKtQUVxS
        A7as5KjZZ1efy6qcJB/7MZgzi6PVIfnhCvfvs/8w14M5yohR84u9wBM6llaOdh6XbXby7z
        Km+Zyp2EweBoYFWX6WPwa3iwVHBIUv4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACF951329E;
        Fri,  3 Mar 2023 16:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qNPEKBgbAmRlTwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 03 Mar 2023 16:06:48 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: Do not shuffle CPU entry areas without KASLR
Date:   Fri,  3 Mar 2023 17:06:45 +0100
Message-Id: <20230303160645.3594-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area") fixed
an omission of KASLR on CPU entry areas. It doesn't take into account
KASLR switches though, which may result in unintended non-determinism
when a user wants to avoid it (e.g. debugging, benchmarking).

Generate only a single combination of CPU entry areas offsets -- the
linear array that existed prior randomization when KASLR is turned off.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 arch/x86/mm/cpu_entry_area.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 7316a8224259..f5e93df096fb 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -10,6 +10,7 @@
 #include <asm/fixmap.h>
 #include <asm/desc.h>
 #include <asm/kasan.h>
+#include <asm/setup.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -29,6 +30,12 @@ static __init void init_cea_offsets(void)
 	unsigned int max_cea;
 	unsigned int i, j;
 
+	if (!kaslr_memory_enabled()) {
+		for_each_possible_cpu(i)
+			per_cpu(_cea_offset, i) = i;
+		return;
+	}
+
 	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
 
 	/* O(sodding terrible) */
-- 
2.39.2

