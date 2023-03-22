Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669D6C4161
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCVEAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCVEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9447403
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20DB6B81AFA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E3C4339B;
        Wed, 22 Mar 2023 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457624;
        bh=vb0/E/xQnHYZirAzUsMS9BEEJ9l0yo4puA34UlEsHUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/6zCufXDJX0jYzyqmaYDnjYZANV3vCTW3je5V0JNsAqbwav52XjOmIVH7ItDH6Uh
         24ZVp6rHzdLHyIHYwXcBbkGR8UQhEdchmfLCL/FJm68Map3H+1+Nz/ffAEu7dYBiim
         pp+TklmKMf6pX3n61kSD3dPgpU2CTS8hxh3VMee4O0YgRRsLlWPK5SD8SJNjXV+e+B
         fqvpsXnlLPmGfhsa675S8VtpwJ2I8uB3aDpoj+QnBJi6W16hppSc79BtofGybFZKwi
         c4uAhok6UPaqpeYfhK2Mk52HFpLVuNBtF7iWvzGD7pXO6cxiH0mnP+wkuVRmNx5BjS
         EYIoEVnVsUhmg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/11] static_call: Remove static_call.h dependency on cpu.h
Date:   Tue, 21 Mar 2023 21:00:10 -0700
Message-Id: <252c12888b50482ee5bda8415a67cdc971285843.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninline __static_call_update() to remove static_call.h's dependency on
cpu.h.  This will make it much easier to include static_call.h in common
header files like <linux/kernel.h>.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 block/bio.c                 |  1 +
 include/linux/static_call.h | 10 +---------
 kernel/cgroup/cgroup.c      |  1 +
 kernel/static_call.c        | 12 ++++++++++++
 sound/soc/intel/avs/trace.c |  1 +
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..a2ca0680fd18 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -19,6 +19,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
+#include <linux/cpu.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 890ddc0c3190..abce40166039 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -132,7 +132,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/cpu.h>
 #include <linux/static_call_types.h>
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -246,14 +245,7 @@ static inline int static_call_init(void) { return 0; }
 
 #define static_call_cond(name)	(void)__static_call(name)
 
-static inline
-void __static_call_update(struct static_call_key *key, void *tramp, void *func)
-{
-	cpus_read_lock();
-	WRITE_ONCE(key->func, func);
-	arch_static_call_transform(NULL, tramp, func, false);
-	cpus_read_unlock();
-}
+extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 
 static inline int static_call_text_reserved(void *start, void *end)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..4f29f509d9ce 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -58,6 +58,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
 #include <linux/psi.h>
+#include <linux/cpu.h>
 #include <net/sock.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/kernel/static_call.c b/kernel/static_call.c
index e9c3e69f3837..63486995fd82 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -1,8 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/static_call.h>
+#include <linux/cpu.h>
 
 long __static_call_return0(void)
 {
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
+
+#ifndef CONFIG_HAVE_STATIC_CALL_INLINE
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	cpus_read_lock();
+	WRITE_ONCE(key->func, func);
+	arch_static_call_transform(NULL, tramp, func, false);
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+#endif
diff --git a/sound/soc/intel/avs/trace.c b/sound/soc/intel/avs/trace.c
index c63eea909b5e..b033b560e6d2 100644
--- a/sound/soc/intel/avs/trace.c
+++ b/sound/soc/intel/avs/trace.c
@@ -7,6 +7,7 @@
 //
 
 #include <linux/types.h>
+#include <asm/page.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
-- 
2.39.2

