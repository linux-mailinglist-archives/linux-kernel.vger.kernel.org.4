Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66909686B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjBAQ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjBAQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:26:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD86D5F7;
        Wed,  1 Feb 2023 08:26:36 -0800 (PST)
Date:   Wed, 01 Feb 2023 16:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmdamTuDP6l77sVdfkHRgvvFG9rXjxNtOUL05uqXM78=;
        b=mCsGICOo1ElSm6plGMRfRshjtm/srGoXpbZzKy7xUwEbhUEuq3GEAT+VgZh0CuF7T/jPYv
        Qf8V16wWx1tTsTrkge3J31DW9Ubn2Jw3s+0iA+MnqJyq1GEgm1di8i+V5BhiGVoQFqzfCD
        cqOOn3ao+JuYvfLphuv3XySYrgV0p8TIubFAJZqej0Xg/aoARrR/EKLTu2kdIn3HlZmhl/
        AP4zN8kTS4zUeLWjVsighxo6uVewrYRGEzkkjx36P/2wNb+N7lwnvcad9nFXZiQWNgWqoc
        7aSLuN/84r9O33TMzur1fXC+6sT1oRla0w+Mr4CYjAu9BufnqXSIWW1afrFXeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675268795;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmdamTuDP6l77sVdfkHRgvvFG9rXjxNtOUL05uqXM78=;
        b=CyoJjvir38hXJFuFIilIw/63RfuBov3oGgrtSOZlc8kP1FBUF6/9z5QOxAyRsHeP7OzurC
        p2nm9pA7sadb4sBw==
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix HOSTCC flag usage
Cc:     Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126190606.40739-4-irogers@google.com>
References: <20230126190606.40739-4-irogers@google.com>
MIME-Version: 1.0
Message-ID: <167526879495.4906.2898311831401901292.tip-bot2@tip-bot2>
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

Commit-ID:     93eacc15687a491a9cf829f94b6891bf544084f3
Gitweb:        https://git.kernel.org/tip/93eacc15687a491a9cf829f94b6891bf544084f3
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 26 Jan 2023 11:06:06 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 30 Jan 2023 16:28:18 -08:00

objtool: Fix HOSTCC flag usage

HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
happens after tools/scripts/Makefile.include is included, meaning
flags (like CFLAGS) are set assuming say CC is gcc, but then it can be
later set to HOSTCC which may be clang. tools/scripts/Makefile.include
is needed for host set up and common macros in objtool's
Makefile. Rather than override the CC variable to HOSTCC, just pass CC
as HOSTCC to the sub-makes of Makefile.build, the libsubcmd builds and
also to the linkage step.

Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230126190606.40739-4-irogers@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d54b669..29a8cd7 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -2,11 +2,6 @@
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
 
-# always use the host compiler
-AR	 = $(HOSTAR)
-CC	 = $(HOSTCC)
-LD	 = $(HOSTLD)
-
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -34,13 +29,18 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
+# Note, EXTRA_WARNINGS here was determined for CC and not HOSTCC, it
+# is passed here to match a legacy behavior.
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
-LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
+
+# Always want host compilation.
+HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 
 AWK = awk
 MKDIR = mkdir
@@ -61,12 +61,14 @@ export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
-$(OBJTOOL_IN): fixdep FORCE
+$(OBJTOOL_IN): fixdep $(LIBSUBCMD) FORCE
 	$(Q)$(CONFIG_SHELL) ./sync-check.sh
-	$(Q)$(MAKE) $(build)=objtool
+	$(Q)$(MAKE) $(build)=objtool $(HOST_OVERRIDES) CFLAGS="$(OBJTOOL_CFLAGS)" \
+		LDFLAGS="$(OBJTOOL_LDFLAGS)"
+
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(OBJTOOL_LDFLAGS) -o $@
 
 
 $(LIBSUBCMD_OUTPUT):
@@ -75,6 +77,7 @@ $(LIBSUBCMD_OUTPUT):
 $(LIBSUBCMD): fixdep $(LIBSUBCMD_OUTPUT) FORCE
 	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
 		DESTDIR=$(LIBSUBCMD_OUTPUT) prefix= subdir= \
+		$(HOST_OVERRIDES) EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
 		$@ install_headers
 
 $(LIBSUBCMD)-clean:
