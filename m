Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D61686B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjBAQ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjBAQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:26:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C679229;
        Wed,  1 Feb 2023 08:26:36 -0800 (PST)
Date:   Wed, 01 Feb 2023 16:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jda8ZouveWhQ3kglM4IQHdfr7eRw0nMTEcZ4EPxiHAk=;
        b=kvflDRNfTf9pqh2czJOuExzbiBw7jI5xtv/XNaSVydbhBuUTlRz4HrU+iH9p4M0rwrHCYe
        tu4EQ6NNm54SR9AE82NzV5eLUmyYUfeENvlDwrdqSnfoQGHWltQVt4lnytYBIr/RnsS29R
        RfLDTo/4j4MgOiynAHyfLlZMP4F9IHa4ndn2YCblDDC1j9nMrsFdBtERQUHQrsmDbHJIra
        pjKV741vw1LL1l+iwsnwo1NBBGv1PuzLWJHV1RSJ9Oc8Gc6leIHVo8vUZj1gGSazOKQCyg
        iDH6qDyeGvnGzjm7Sq7QTalHBaLzG8YYAP8uKP33TeV12rAsumcV7PVDLbceDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jda8ZouveWhQ3kglM4IQHdfr7eRw0nMTEcZ4EPxiHAk=;
        b=J4ytH9eafIJ2QEg8a0jyMjOniDsU7K40lxWmneB3xMSdKnR3VAo3pEzyXY+lvpbFws+AH7
        UyDCCO5Do9hJ/rDw==
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Properly support make V=1
Cc:     Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126190606.40739-3-irogers@google.com>
References: <20230126190606.40739-3-irogers@google.com>
MIME-Version: 1.0
Message-ID: <167526879529.4906.12024408691779429634.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8c4526ca6a45e7ff915c2b33b54db6b773291fac
Gitweb:        https://git.kernel.org/tip/8c4526ca6a45e7ff915c2b33b54db6b773291fac
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 26 Jan 2023 11:06:05 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 30 Jan 2023 16:28:16 -08:00

objtool: Properly support make V=1

The Q variable was being used but never correctly set up. Add the
setting up and use in place of @.

Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230126190606.40739-3-irogers@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 3505ae4..d54b669 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -45,6 +45,12 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 AWK = awk
 MKDIR = mkdir
 
+ifeq ($(V),1)
+  Q =
+else
+  Q = @
+endif
+
 BUILD_ORC := n
 
 ifeq ($(SRCARCH),x86)
@@ -56,18 +62,18 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
-	@$(CONFIG_SHELL) ./sync-check.sh
-	@$(MAKE) $(build)=objtool
+	$(Q)$(CONFIG_SHELL) ./sync-check.sh
+	$(Q)$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
 $(LIBSUBCMD_OUTPUT):
-	@$(MKDIR) -p $@
+	$(Q)$(MKDIR) -p $@
 
 $(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT) FORCE
-	@$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
+	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
 		$@ install_headers
 
