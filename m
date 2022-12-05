Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FB642689
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiLEKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLEKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:16:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDF19030;
        Mon,  5 Dec 2022 02:16:46 -0800 (PST)
Date:   Mon, 05 Dec 2022 10:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670235404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61+hzAVOFJyLnP756gK5dY3fagK+vG6J+jByZXiS/dU=;
        b=pxGrNz2gpwWLmwKVZllVaE37wVIaVQrT/L4xrAVAoI6bmOwrJr8k2AMvV6G7fzE+Ny+sU4
        /JQqa7XtMBsfRxUdJxKTHPSGqgLdgDwWn/oDA4HqXl1nH8maLwFCg+y+1EY/8vndQsNATP
        nyG9e6wQivA2kP1o2UVC0WGRgg/iFm/kg5tMgxUHSrA81//nPFg4oe1BWA9mdC//qBWE1r
        APJ+OOM4M1c62owCLQwAHYb4Jr0FNEj6ewwbBuXBa2nIUD9uNaVTPz8HIIM8DXcP52NEyF
        YkRrX1D2AzvU5rEaD+3o4olrhvQ95mmdVd/0SaTt+o5LELtxippApBqusNlYdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670235404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61+hzAVOFJyLnP756gK5dY3fagK+vG6J+jByZXiS/dU=;
        b=Y83RZoF7SB8nLggYlalowwBpv5TeVyoF091YESBStFYYcl16F2Rtd5jGluCeiEWE3cRMRG
        vlBi4FVvuiX6esDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/pat: Handle TDX guest PAT initialization
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221205080433.16643-2-jgross@suse.com>
References: <20221205080433.16643-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167023540404.4906.9973783336476652949.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c11ca45441d56ed6d353548cad660e04f0b6605d
Gitweb:        https://git.kernel.org/tip/c11ca45441d56ed6d353548cad660e04f0b6605d
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Dec 2022 09:04:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Dec 2022 11:03:27 +01:00

x86/pat: Handle TDX guest PAT initialization

With the decoupling of PAT and MTRR initialization, PAT will be used
even with MTRRs disabled. This seems to break booting up as TDX guest,
as the recommended sequence to set the PAT MSR across CPUs can't work
in TDX guests due to disabling caches via setting CR0.CD isn't allowed
in TDX mode.

This is an inconsistency in the Intel documentation between the SDM
and the TDX specification. For now handle TDX mode the same way as Xen
PV guest mode by just accepting the current PAT MSR setting without
trying to modify it.

  [ bp: Align conditions for better readability. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221205080433.16643-2-jgross@suse.com
---
 arch/x86/mm/pat/memtype.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 9aab17d..46de9cf 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -296,8 +296,13 @@ void __init pat_bp_init(void)
 	/*
 	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
 	 * supported.
+	 * When running as TDX guest setting the PAT MSR won't work either
+	 * due to the requirement to set CR0.CD when doing so. Rely on
+	 * firmware to have set the PAT MSR correctly.
 	 */
-	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (pat_disabled ||
+	    cpu_feature_enabled(X86_FEATURE_XENPV) ||
+	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		init_cache_modes(pat_msr_val);
 		return;
 	}
