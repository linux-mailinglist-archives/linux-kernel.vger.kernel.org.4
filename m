Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE267284DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjFHQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjFHQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976D3AB1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86E464E7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6E2C433EF;
        Thu,  8 Jun 2023 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241416;
        bh=4AyorKc6MZArZRKOyajHdmyghV9EfZC2niVhRovD1GM=;
        h=From:To:Cc:Subject:Date:From;
        b=h0tXbLz4JQyLzU2/e7Ep3EAIU1Uy826FzPvIbpeC2yKVFp7cEpCgBC+t3L8DtmByW
         knSPxbsCUMLiWtuF10SRWo3ZVnU7XdkQz3oOV8RCQ9PN3OMf5n42IA1rnWl8k8M+F4
         Qc2u59avIWV3US9uI3G93388IQo/uAAS0sUA1YxwVsDvftYNM1oWN13l6Uj0p36wm8
         APCNjtKUuCoo6gtE6kckH+3sIO8EiaMp730wL4nEzZFmCUlvZ+C3b9VtEqaLgLxhOW
         rU+dnu8krj22W8hkLfm3aWmmBk9+ITNNq4iq3iWiTyQPMCPSQWnfKUkiYK5hgtEpmK
         QjFvMurVAvPgw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: Improve rate-limiting for missing __noreturn warnings
Date:   Thu,  8 Jun 2023 09:23:32 -0700
Message-Id: <185b1a78b42776467929ce9e7851e4dbcd0b55d4.1686241345.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a function with a lot of call sites is missing __noreturn, it could
result in a lot of duplicate warnings (one for each call site).

Each call site's function is already rate-limited to one warning per
function via WARN_INSN().  Do the same for the callee (the "missing
__noreturn" function itself).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05f0e5a..bb2ed34cb90e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4507,9 +4507,13 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
 			if (call_dest && !ignore_noreturn_call(prev_insn)) {
-				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
-					  call_dest->name);
-				warnings++;
+				if (!call_dest->warned) {
+					WARN_INSN(insn, "%s() is missing a __noreturn annotation",
+						  call_dest->name);
+					warnings++;
+					call_dest->warned = 1;
+				}
+
 				continue;
 			}
 		}
-- 
2.40.1

