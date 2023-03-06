Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C706ACE21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCFTbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:31:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42372026
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:31:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1154321E34;
        Mon,  6 Mar 2023 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678131107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v4lIRT5dTzL9UnegIXyhyP78C6AopA969E0hoJXW+hw=;
        b=qsEnY8jSZasVQr8h0ZwP0pzOdSopHMM8piQPp8vqt+EdcVWEmTug//6pSX+HkPiGsPIWbF
        IY/F4wjYiOkdIzDRJlbve4HgVdoJ/AE5Llwlm2XRJaK1ZgFvD2xQDjtzMNOyWVlDASf4uA
        q0j7xYYCDJMUGZvx6AV/ATWmKuRDEWA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDB0213A66;
        Mon,  6 Mar 2023 19:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J5GuMKI/BmTEMwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Mar 2023 19:31:46 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/mm: Do not shuffle CPU entry areas without KASLR
Date:   Mon,  6 Mar 2023 20:31:44 +0100
Message-Id: <20230306193144.24605-1-mkoutny@suse.com>
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

Since we have 3f148f331814 ("x86/kasan: Map shadow for percpu pages on
demand") and followups, we can use the more relaxed guard
kasrl_enabled() (in contrast to kaslr_memory_enabled()).

Fixes: 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---

v1: https://lore.kernel.org/r/20230303160645.3594-1-mkoutny@suse.com

Changes in v2:
- s/kaslr_memory_enabled/kasrl_enabled/, commit message

 arch/x86/mm/cpu_entry_area.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 7316a8224259..e91500a80963 100644
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
 
+	if (!kaslr_enabled()) {
+		for_each_possible_cpu(i)
+			per_cpu(_cea_offset, i) = i;
+		return;
+	}
+
 	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
 
 	/* O(sodding terrible) */
-- 
2.39.2

