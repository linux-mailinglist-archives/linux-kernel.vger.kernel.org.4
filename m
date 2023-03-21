Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13236C2720
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCUBOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCUBOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD11A65C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21035B811C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55CFC433A8;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=dUA8VXr/zwZtcB1ONG//cuti16k8LCic/nbXiNW74pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEqjYdqj/0mVhZ/fu931k9kn+s9h2DjuQLdamLgus1f/aLmdScrkUBc5eq+m+sEfa
         23y4WMWBegRXPlugzy/lwNhO5IcUdhhLfeM2YAD/ap/LV7mwFH7MHv2ThzV/oJ9D3g
         MCFPZFYMstr5Tn4SlnH11/pGU8cgYGZayUMdtYzKho2KZqGeEum2kMYfcmJ0Icux+O
         4r8OSjSMWOk1ec18p1dA51wo8M6BPkYnvxfx8HSZEPlq9tbiyByAQU/hI45tNJJMbZ
         1xCgqcxLqa+EUEPWFtlmQKtPuHywFmLoAxAD3GLppNc3HudEOdYA4We9WH2KVGiRZK
         +sFe2UvemZeHw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EFFCB15403A1; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 09/14] tools/nolibc: check for S_I* macros before defining them
Date:   Mon, 20 Mar 2023 18:11:32 -0700
Message-Id: <20230321011137.51837-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

Defining S_I* flags in types.h can cause some build failures if
linux/stat.h is included prior to it. But if not defined, some toolchains
that include some glibc parts will in turn fail because linux/stat.h
already takes care of avoiding these definitions when glibc is present.

Let's preserve the macros here but first include linux/stat.h and check
for their definition before doing so. We also define the previously
missing permission macros so that we don't get a different behavior
depending on the first include found.

Cc: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..47a0997d2d74 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -9,6 +9,7 @@
 
 #include "std.h"
 #include <linux/time.h>
+#include <linux/stat.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -16,7 +17,11 @@
  * the layout of sys_stat_struct must not be defined here.
  */
 
-/* stat flags (WARNING, octal here) */
+/* stat flags (WARNING, octal here). We need to check for an existing
+ * definition because linux/stat.h may omit to define those if it finds
+ * that any glibc header was already included.
+ */
+#if !defined(S_IFMT)
 #define S_IFDIR        0040000
 #define S_IFCHR        0020000
 #define S_IFBLK        0060000
@@ -34,6 +39,22 @@
 #define S_ISLNK(mode)  (((mode) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(mode) (((mode) & S_IFMT) == S_IFSOCK)
 
+#define S_IRWXU 00700
+#define S_IRUSR 00400
+#define S_IWUSR 00200
+#define S_IXUSR 00100
+
+#define S_IRWXG 00070
+#define S_IRGRP 00040
+#define S_IWGRP 00020
+#define S_IXGRP 00010
+
+#define S_IRWXO 00007
+#define S_IROTH 00004
+#define S_IWOTH 00002
+#define S_IXOTH 00001
+#endif
+
 /* dirent types */
 #define DT_UNKNOWN     0x0
 #define DT_FIFO        0x1
-- 
2.40.0.rc2

