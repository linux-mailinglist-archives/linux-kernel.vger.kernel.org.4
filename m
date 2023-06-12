Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F172D10E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjFLUuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbjFLUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4419B4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D359862F1E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542E8C4332D;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=fEUn7QI6ZM1/RSV/3DLiY1bJ6vwD3honS9s4B5UVY1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nypZtV0mt3yn7CvHpsUwcJHJWaFRW4DnjvUp81bNqkgoRZ7CYwp9qjxSNxAr2l4rZ
         PAx+Z6ZZ4XQGoOHBvYUyTIqtpagyBS5sBQ1a/VmEQ4QPp7l95VKrMDCIXIW4w8IpkL
         pRYYkXyI+5Sm0Aug/Q2PuCB5J9Rz3+XaNtke5If/56SPZ8IC8O4YhpZr7lUWiIR9Oo
         SUkBbIFaBLezxgJu9Jq7QUgI/Pzd+JbBUDunJ4JTioRnlVXtRZgaAfc8GeWAYDduYW
         fpDXWOGu4MGe3ePrUnxLbGD/asj3TJVBP/2Ce2NAz1o9jYPoo55YZhX7SICjDmxsyV
         /NKfU+Ngxyycw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1B79DCE3A8C; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 45/53] selftests/nolibc: not include limits.h for nolibc
Date:   Mon, 12 Jun 2023 13:45:06 -0700
Message-Id: <20230612204514.292087-45-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

When compile nolibc-test.c with 2.31 glibc, we got such error:

    In file included from /usr/riscv64-linux-gnu/include/sys/cdefs.h:452,
                     from /usr/riscv64-linux-gnu/include/features.h:461,
                     from /usr/riscv64-linux-gnu/include/bits/libc-header-start.h:33,
                     from /usr/riscv64-linux-gnu/include/limits.h:26,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:194,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/syslimits.h:7,
                     from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:34,
                     from /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/nolibc-test.c:6:
    /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
       28 | # error "rv32i-based targets are not supported"

Glibc (>= 2.33) commit 5b6113d62efa ("RISC-V: Support the 32-bit ABI
implementation") fixed up above error.

As suggested by Thomas, defining INT_MIN/INT_MAX for nolibc can remove
the including of limits.h, and therefore no above error. of course, the
other libcs still require limits.h, move it to the right place.

The LONG_MIN/LONG_MAX are also defined too.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/09d60dc2-e298-4c22-8e2f-8375861bd9be@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdint.h                | 14 ++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  4 +---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 661d942862c0..4b282435a59a 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -96,4 +96,18 @@ typedef uint64_t          uintmax_t;
 #define UINT_FAST32_MAX  SIZE_MAX
 #define UINT_FAST64_MAX  UINT64_MAX
 
+#ifndef INT_MIN
+#define INT_MIN          (-__INT_MAX__ - 1)
+#endif
+#ifndef INT_MAX
+#define INT_MAX          __INT_MAX__
+#endif
+
+#ifndef LONG_MIN
+#define LONG_MIN         (-__LONG_MAX__ - 1)
+#endif
+#ifndef LONG_MAX
+#define LONG_MAX         __LONG_MAX__
+#endif
+
 #endif /* _NOLIBC_STDINT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dcb0bd079d15..7d4b8d12050d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -2,9 +2,6 @@
 
 #define _GNU_SOURCE
 
-/* platform-specific include files coming from the compiler */
-#include <limits.h>
-
 /* libc-specific include files
  * The program may be built in 3 ways:
  *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
@@ -39,6 +36,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <limits.h>
 #endif
 #endif
 
-- 
2.40.1

