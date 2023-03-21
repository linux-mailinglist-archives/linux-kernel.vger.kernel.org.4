Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCD6C2775
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCUB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUB1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61A10F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED9D618FA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C98C4339B;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=XGdz+sHye8/feWnNVQxyzEvBR9Xb7ks24e30cvZCpAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujOcALg/qWjsikMv5fDyavRGNNjO00WeYB0/NIyne1+Z1+aN+1ifgOUHPFQ370zKk
         iHEv/zoXP8b3Y+vRAeBgq1s7ARhjIQtUW6hRpUOdpChNAHS/aQL8zwMg8WjMn33HPC
         S2rybzeTsb6s0pVSywN7F/ZxBgfdMVDAOlpqSuK0y5+JYNHg/Ni125mp/t18FSR+HF
         uQJqhZF95slY7ze9lrXBa0xwvavrn53IF8crfxW6ubTW0vnmIPSJ6CNsO0eoQaEkbh
         gGphvHv7f7n+86Ynql++fEK1sneHQSsRULKPA+R62C3bE2HKOZB2CrxrtQPo8PakiG
         mw8U4oKovfk0w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DA983154039B; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 03/14] tools/nolibc: add stdint.h
Date:   Mon, 20 Mar 2023 18:11:26 -0700
Message-Id: <20230321011137.51837-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

Nolibc works fine for small and limited program however most program
expect integer types to be defined in stdint.h rather than std.h.

This is a quick fix that moves the existing integer definitions in std.h
to stdint.h.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile |  4 ++--
 tools/include/nolibc/std.h    | 15 +--------------
 tools/include/nolibc/stdint.h | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cfd06764b5ae..ec57d3932506 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
-             sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
+             string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..933bc0be7e1c 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -18,20 +18,7 @@
 #define NULL ((void *)0)
 #endif
 
-/* stdint types */
-typedef unsigned char       uint8_t;
-typedef   signed char        int8_t;
-typedef unsigned short     uint16_t;
-typedef   signed short      int16_t;
-typedef unsigned int       uint32_t;
-typedef   signed int        int32_t;
-typedef unsigned long long uint64_t;
-typedef   signed long long  int64_t;
-typedef unsigned long        size_t;
-typedef   signed long       ssize_t;
-typedef unsigned long     uintptr_t;
-typedef   signed long      intptr_t;
-typedef   signed long     ptrdiff_t;
+#include "stdint.h"
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
new file mode 100644
index 000000000000..4ba264031df9
--- /dev/null
+++ b/tools/include/nolibc/stdint.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Standard definitions and types for NOLIBC
+ * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
+ */
+
+#ifndef _NOLIBC_STDINT_H
+#define _NOLIBC_STDINT_H
+
+typedef unsigned char       uint8_t;
+typedef   signed char        int8_t;
+typedef unsigned short     uint16_t;
+typedef   signed short      int16_t;
+typedef unsigned int       uint32_t;
+typedef   signed int        int32_t;
+typedef unsigned long long uint64_t;
+typedef   signed long long  int64_t;
+typedef unsigned long        size_t;
+typedef   signed long       ssize_t;
+typedef unsigned long     uintptr_t;
+typedef   signed long      intptr_t;
+typedef   signed long     ptrdiff_t;
+
+#endif /* _NOLIBC_STDINT_H */
-- 
2.40.0.rc2

