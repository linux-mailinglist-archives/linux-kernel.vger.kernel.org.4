Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE96C2766
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCUBXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCUBXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7B19C52
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC88D618FE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8A0C4339C;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=xmxCrxSFeJnV6Vi+d9+/0Z1rnOxtf2t94FrsrC3fsdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSQPTzD0cZEcfhHAvEiQdzRB6JofW7+4FLVzBb9BHhMNbqKOe/XB94DVmgvzdy9cR
         w97p4f4Wfn7q7Kb6TUS3+M/29W+xA3pTjzKkpMxPJu3lwnN8BtXuZVsyrhRrOLy1w6
         dGU4h2vdPPvHeURDx4YKyxCJsfacQcukH/nXofU/0RG1oEIK417U8fL/vl+tHDFvN6
         cshDMZCt9MisYOrwyEu7bL35l6cUr8L1N5wIJtuvOYL3dMPDzijpFUc/VX+2J6VJpc
         j0MDsol8zTdvPOcNgodNHSoJow3SMH5ZOJUtGggyHRWp3KNZCHlkZ7ZU/S1pG3FNbJ
         XZFq7hyP6OPVA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DE9A9154039C; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 04/14] tools/nolibc: add integer types and integer limit macros
Date:   Mon, 20 Mar 2023 18:11:27 -0700
Message-Id: <20230321011137.51837-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

We rely on the compiler-defined __LONG_MAX__ to get the right limits for
size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler constant seem
to have been defined at least since GCC 4.1.2 and clang
3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to go with unsigned long on all platforms since
unsigned long == unsigned int on all the platforms we care about. Note
that the kernel uses either unsigned int or unsigned long in
linux/include/uapi/asm-generic/posix_types.h. These should be equivalent
for the plaforms we are targeting.

Also note that the 'fast*' flavor of the types have been chosen to be
always 1 byte for '*fast8*' and always long (a.k.a. intptr_t/uintptr_t) for
the other variants. I have never seen the 'fast*' types in use in the wild
but that seems to be what glibc does.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdint.h | 75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..c1ce4f5e0603 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -21,4 +21,79 @@ typedef unsigned long     uintptr_t;
 typedef   signed long      intptr_t;
 typedef   signed long     ptrdiff_t;
 
+typedef   int8_t       int_least8_t;
+typedef  uint8_t      uint_least8_t;
+typedef  int16_t      int_least16_t;
+typedef uint16_t     uint_least16_t;
+typedef  int32_t      int_least32_t;
+typedef uint32_t     uint_least32_t;
+typedef  int64_t      int_least64_t;
+typedef uint64_t     uint_least64_t;
+
+typedef   int8_t        int_fast8_t;
+typedef  uint8_t       uint_fast8_t;
+typedef  ssize_t       int_fast16_t;
+typedef   size_t      uint_fast16_t;
+typedef  ssize_t       int_fast32_t;
+typedef   size_t      uint_fast32_t;
+typedef  ssize_t       int_fast64_t;
+typedef   size_t      uint_fast64_t;
+
+typedef  int64_t           intmax_t;
+typedef uint64_t          uintmax_t;
+
+/* limits of integral types */
+
+#define        INT8_MIN  (-128)
+#define       INT16_MIN  (-32767-1)
+#define       INT32_MIN  (-2147483647-1)
+#define       INT64_MIN  (-9223372036854775807LL-1)
+
+#define        INT8_MAX  (127)
+#define       INT16_MAX  (32767)
+#define       INT32_MAX  (2147483647)
+#define       INT64_MAX  (9223372036854775807LL)
+
+#define       UINT8_MAX  (255)
+#define      UINT16_MAX  (65535)
+#define      UINT32_MAX  (4294967295U)
+#define      UINT64_MAX  (18446744073709551615ULL)
+
+#define  INT_LEAST8_MIN  INT8_MIN
+#define INT_LEAST16_MIN  INT16_MIN
+#define INT_LEAST32_MIN  INT32_MIN
+#define INT_LEAST64_MIN  INT64_MIN
+
+#define  INT_LEAST8_MAX  INT8_MAX
+#define INT_LEAST16_MAX  INT16_MAX
+#define INT_LEAST32_MAX  INT32_MAX
+#define INT_LEAST64_MAX  INT64_MAX
+
+#define  UINT_LEAST8_MAX UINT8_MAX
+#define UINT_LEAST16_MAX UINT16_MAX
+#define UINT_LEAST32_MAX UINT32_MAX
+#define UINT_LEAST64_MAX UINT64_MAX
+
+#define SIZE_MAX         ((size_t)(__LONG_MAX__) * 2 + 1)
+#define INTPTR_MIN       (-__LONG_MAX__ - 1)
+#define INTPTR_MAX       __LONG_MAX__
+#define PTRDIFF_MIN      INTPTR_MIN
+#define PTRDIFF_MAX      INTPTR_MAX
+#define UINTPTR_MAX      SIZE_MAX
+
+#define  INT_FAST8_MIN   INT8_MIN
+#define INT_FAST16_MIN   INTPTR_MIN
+#define INT_FAST32_MIN   INTPTR_MIN
+#define INT_FAST64_MIN   INTPTR_MIN
+
+#define  INT_FAST8_MAX   INT8_MAX
+#define INT_FAST16_MAX   INTPTR_MAX
+#define INT_FAST32_MAX   INTPTR_MAX
+#define INT_FAST64_MAX   INTPTR_MAX
+
+#define  UINT_FAST8_MAX  UINT8_MAX
+#define UINT_FAST16_MAX  SIZE_MAX
+#define UINT_FAST32_MAX  SIZE_MAX
+#define UINT_FAST64_MAX  SIZE_MAX
+
 #endif /* _NOLIBC_STDINT_H */
-- 
2.40.0.rc2

