Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666464240F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiLEIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiLEIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:04:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84763140D7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:04:43 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1513B21B30;
        Mon,  5 Dec 2022 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670227482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9UFnWEsICEtCyId1TzW8C4ccar29YwckOATn38tDiw=;
        b=pO6y6QFUlTqijBrInKYHUEnIhEnSLLUc9IenM86QzWIn/AAPg95/z1L9PMUW/1jQHnkYXi
        GvuTTYnkXCfdpt4b+UqyQtJwhCKaji1r7Q3IHxcfKHO5pGMZSoqv9AeNAOq+KzBDbm1oBD
        QS1qlxF2qkQRFKYw1WHIhU53Z/oTulA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B99EF1348F;
        Mon,  5 Dec 2022 08:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rxn4KxmmjWNCNAAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 05 Dec 2022 08:04:41 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     kirill@shutemov.name, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/pat: fix TDX guest PAT initialization
Date:   Mon,  5 Dec 2022 09:04:32 +0100
Message-Id: <20221205080433.16643-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205080433.16643-1-jgross@suse.com>
References: <20221205080433.16643-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the decoupling of PAT and MTRR initialization, PAT will be used
even with MTRRs disabled. This seems to break booting up as TDX guest,
as the recommended sequence to set the PAT MSR across CPUs can't work
in TDX guests due to disabling caches via setting CR0.CD isn't allowed
in TDX mode.

This is an inconsistency in the Intel documentation between the SDM
and the TDX specification. For now handle TDX mode the same way as Xen
PV guest mode by just accepting the current PAT MSR setting without
trying to modify it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pat/memtype.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 9aab17d660cd..4e50add760ad 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -296,8 +296,12 @@ void __init pat_bp_init(void)
 	/*
 	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
 	 * supported.
+	 * When running as TDX guest setting the PAT MSR won't work either
+	 * due to the requirement to set CR0.CD when doing so. Rely on
+	 * firmware to have set the PAT MSR correctly.
 	 */
-	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV) ||
+	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		init_cache_modes(pat_msr_val);
 		return;
 	}
-- 
2.35.3

