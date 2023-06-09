Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F457294F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbjFIJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbjFIJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:24:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906DA7287;
        Fri,  9 Jun 2023 02:18:53 -0700 (PDT)
Date:   Fri, 09 Jun 2023 09:18:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686302294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xZRhkDtTSeZgnqu7N8XwI7ct33rW0W+QqL6s4Ga2BxU=;
        b=d53OvKO4aVNs1Bv7j7EpoJmcL1pqH5I3Y8S+hc9ma/xNXtUskgj88c2txhxkJXQ6YMppXv
        UnUjVscJ8M/KOPkCjnXkg60XWrY+Vi1qDZzG6LekBTeY7VtLNFx3ZyFeq31c7t9zgo+cce
        Z7YS3RjMHcaHtJeIsFOn0HvlBgHNXFOR6/o8DDQbRN+hPhUYb75iGP4tqRXKZ6UFoIdoUJ
        QQBg6UFKloTImGWC/GXepogCoCN9NCQDApp+ueSeGjO2NiC9GkoxXTXLAdklzE4Leo6dKU
        g/2q5V00y6Y2r1X19fdc4c1CwVozNWxvhIKRvEA9mOTSEyoyFeo4QKmjfHsYmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686302294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xZRhkDtTSeZgnqu7N8XwI7ct33rW0W+QqL6s4Ga2BxU=;
        b=WSnfe8lI18zPdZWsVuC24ZigkrV4oE2SgHYb0pf2q44d567uGc+e1lofwhPCneBlngV323
        +Zjnm+V4Kzaq/2Dw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/orc: Make the is_callthunk() definition
 depend on CONFIG_BPF_JIT=y
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
MIME-Version: 1.0
Message-ID: <168630229338.404.8674192988459787200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     301cf77e21317b3465c5e2bb0188df24bbf1c2e2
Gitweb:        https://git.kernel.org/tip/301cf77e21317b3465c5e2bb0188df24bbf=
1c2e2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 09 Jun 2023 11:04:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 09 Jun 2023 11:09:04 +02:00

x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=3Dy

Recent commit:

  020126239b8f Revert "x86/orc: Make it callthunk aware"

Made the only user of is_callthunk() depend on CONFIG_BPF_JIT=3Dy, while
the definition of the helper function is unconditional.

Move is_callthunk() inside the #ifdef block.

Addresses this build failure:

   arch/x86/kernel/callthunks.c:296:13: error: =E2=80=98is_callthunk=E2=80=99=
 defined but not used [-Werror=3Dunused-function]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/callthunks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 8e0a9b6..fcb8eea 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -293,6 +293,7 @@ void *callthunks_translate_call_dest(void *dest)
 	return target ? : dest;
 }
=20
+#ifdef CONFIG_BPF_JIT
 static bool is_callthunk(void *addr)
 {
 	unsigned int tmpl_size =3D SKL_TMPL_SIZE;
@@ -306,7 +307,6 @@ static bool is_callthunk(void *addr)
 	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
 }
=20
-#ifdef CONFIG_BPF_JIT
 int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 {
 	unsigned int tmpl_size =3D SKL_TMPL_SIZE;
