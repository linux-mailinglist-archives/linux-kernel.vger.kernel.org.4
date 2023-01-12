Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EA666DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjALJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjALJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D895AE48;
        Thu, 12 Jan 2023 01:06:46 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673514405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IL5ZIP9DYWv2XGsGuDCylsAv4oLuc8Ydy6IeN3eeYd4=;
        b=gMBriOPkAjWzM9xfLa3A64Yd5U4lcLMC6VczYi2ZjqqZYkEBXE3sPgQtkvi/N7O2tH19yP
        sJJSaHpdLvFutSM33EimXj9jtprToVStt7CTkF23zTrFHxMpLk3dmpJvpDiwjRSqk5YLdg
        qP3fQsSWCDfF3nohundfiOeP+OS7e+xyng1CBYjRLDkTI90r878h0sw1pKjKbDwhF3xgv7
        LBFF8xnDN/6HgPljCm7VcWTdMe5RLPL2qPgN8YqCY9DvPsf1soY9aFLkSvDoZzHpgsLt1e
        E9L5tBSi8JZcGrhy3dqAOWkd3CfK8hdNWyOBhloe/3d/fO1XTwvf4Ns6YYdRPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673514405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IL5ZIP9DYWv2XGsGuDCylsAv4oLuc8Ydy6IeN3eeYd4=;
        b=6Ithw1n9crRy+7vgHkI2hSAbatOvGxTYOQlxN9Qvf71fFnacFl2sJukVIW/ib45gdbUQfP
        OJwXYT6mmX9m+KDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: fix poking_init() for Xen PV guests
Cc:     Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109150922.10578-1-jgross@suse.com>
References: <20230109150922.10578-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167351440417.4906.2133498085196807325.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8a6b240fef388e9c2c40dcb72d142ee781f6432a
Gitweb:        https://git.kernel.org/tip/8a6b240fef388e9c2c40dcb72d142ee781f6432a
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 09 Jan 2023 16:09:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Jan 2023 09:48:02 +01:00

x86/mm: fix poking_init() for Xen PV guests

Commit 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()") broke
the kernel for running as Xen PV guest.

It seems as if the new address space is never activated before being
used, resulting in Xen rejecting to accept the new CR3 value (the PGD
isn't pinned).

Fix that by adding the now missing call of paravirt_arch_dup_mmap() to
poking_init(). That call was previously done by dup_mm()->dup_mmap() and
it is a NOP for all cases but for Xen PV, where it is just doing the
pinning of the PGD.

Fixes: 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230109150922.10578-1-jgross@suse.com
---
 arch/x86/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d398735..5f8ba53 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -804,6 +804,9 @@ void __init poking_init(void)
 	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
+	/* Xen PV guests need the PGD to be pinned. */
+	paravirt_arch_dup_mmap(NULL, poking_mm);
+
 	/*
 	 * Randomize the poking address, but make sure that the following page
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
