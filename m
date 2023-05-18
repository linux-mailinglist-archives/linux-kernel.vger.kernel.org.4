Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1FB708B39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjERWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjERWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5DE69;
        Thu, 18 May 2023 15:03:18 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ePn0KlrcsrFB7qw1xjxMeBR7TjQc0vuEVBn3rXfEDX8=;
        b=K918CxpIa6nMz4ukgBt6iNjz18w8J07IhFsNUiCurwkFEZk2JPe5H9KFYfTzKvnjlfjRKe
        ZbsUrXiGQUWETpmtuFDv9gKiTSeiz3GvjkM6x3bsFTkaCP14d2K84FnwdZiCrcB5LZAY6T
        ZEHsE4i9sCeSZs1d8sVmx6f4I30/ya17LHCZzq8ljHkEdSPCa1zvHP26mmsmC4Ar9jh3To
        5GqIBjWRZA9mBImmjeGLdBt4Uwbn3BBksMpZmFo7vDg0mSDtwjBGyqRc6GGjt8S4+bzi8Y
        QvQY4wbpE7ztpGNmjIRjzCoTSVknszO4TYwI3DchoeY4vvCZfywNny2K97ym3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ePn0KlrcsrFB7qw1xjxMeBR7TjQc0vuEVBn3rXfEDX8=;
        b=phFeiGeuOBdFae/7J+BvwploeN69XJEYWeXNfq2bVOt4VrMmgO19zCQvaqwHG5YgNT7/5l
        ufk/g1xjbmC+rJAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ftrace: Move prepare_ftrace_return prototype
 to header
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739577.404.17746635284480437496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     26c3379a6912ab7f5115cea31123a57de8d2ce8a
Gitweb:        https://git.kernel.org/tip/26c3379a6912ab7f5115cea31123a57de8d=
2ce8a
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:30 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:01 -07:00

x86/ftrace: Move prepare_ftrace_return prototype to header

On 32-bit builds, the prepare_ftrace_return() function only has a global
definition, but no prototype before it, which causes a warning:

arch/x86/kernel/ftrace.c:625:6: warning: no previous prototype for =E2=80=98p=
repare_ftrace_return=E2=80=99 [-Wmissing-prototypes]
  625 | void prepare_ftrace_return(unsigned long ip, unsigned long *parent,

Move the prototype that is already needed for some configurations into
a header file where it can be seen unconditionally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-2-arnd%40kernel.org
---
 arch/x86/include/asm/ftrace.h | 3 +++
 arch/x86/kernel/ftrace.c      | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 5061ac9..b8d4a07 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -106,6 +106,9 @@ struct dyn_arch_ftrace {
=20
 #ifndef __ASSEMBLY__
=20
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
+			   unsigned long frame_pointer);
+
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
 extern void set_ftrace_ops_ro(void);
 #else
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 5e7ead5..01e8f34 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -525,9 +525,6 @@ static void *addr_from_call(void *ptr)
 	return ptr + CALL_INSN_SIZE + call.disp;
 }
=20
-void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer);
-
 /*
  * If the ops->trampoline was not allocated, then it probably
  * has a static trampoline func, or is the ftrace caller itself.
