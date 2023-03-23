Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542A6C64AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjCWKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCWKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:18:20 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5B91CBC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:18:15 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id bmJC2900G1C8whw01mJCyA; Thu, 23 Mar 2023 11:18:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pfI0g-00EKqY-0O;
        Thu, 23 Mar 2023 11:18:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pfI1M-00CE4D-7v;
        Thu, 23 Mar 2023 11:18:12 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-sh@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] sh: Use generic GCC library routines
Date:   Thu, 23 Mar 2023 11:18:07 +0100
Message-Id: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
arch/sh/lib/ are identical to the generic C implementations in lib/.
Reduce duplication by switching SH to the generic versions.

Update the include path in arch/sh/boot/compressed accordingly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
v3:
  - Add Acked-by,

v2:
  - Fix silly typo in subject.

Tested on landisk and qemu/rts7751r2d.

Note that it also works without the change to arch/sh/boot/compressed/,
as lib/ashldi3.c can be reached via both include/uapi/../../lib/ashldi3.c
and arch/sh/boot/compressed/../../../../lib/ashldi3.c.

Palmer tried a similar thing before:
https://lore.kernel.org/linux-arch/20170523220546.16758-1-palmer@dabbelt.com/
but initially it broke the SH build due to a missing change to
arch/sh/boot/compressed/, and the later update never got picked up.
In the mean time, arch/sh/boot/compressed/ was changed, so his patch no
longer applies.

Similar for the other architectures, I guess?
---
 arch/sh/Kconfig                   |  3 +++
 arch/sh/boot/compressed/ashldi3.c |  4 ++--
 arch/sh/lib/Makefile              |  4 +---
 arch/sh/lib/ashldi3.c             | 30 -----------------------------
 arch/sh/lib/ashrdi3.c             | 32 -------------------------------
 arch/sh/lib/lshrdi3.c             | 30 -----------------------------
 6 files changed, 6 insertions(+), 97 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/lshrdi3.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ccb866750a884643..892903dc74990c36 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -20,6 +20,9 @@ config SUPERH
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_LSHRDI3
 	select GENERIC_PCI_IOMAP if PCI
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
index 7cebd646df839b48..7c12121702309e8c 100644
--- a/arch/sh/boot/compressed/ashldi3.c
+++ b/arch/sh/boot/compressed/ashldi3.c
@@ -1,2 +1,2 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "../../lib/ashldi3.c"
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "../../../../lib/ashldi3.c"
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index eb473d373ca43a4b..d20a0768b31fa2b6 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -7,9 +7,7 @@ lib-y  = delay.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
 # Extracted from libgcc
-obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
-	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
-	 udiv_qrnnd.o
+obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
 
 udivsi3-y			:= udivsi3_i4i-Os.o
 
diff --git a/arch/sh/lib/ashldi3.c b/arch/sh/lib/ashldi3.c
deleted file mode 100644
index e5afe0935847427f..0000000000000000
--- a/arch/sh/lib/ashldi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/sh/lib/ashrdi3.c b/arch/sh/lib/ashrdi3.c
deleted file mode 100644
index ae263fbf25383b70..0000000000000000
--- a/arch/sh/lib/ashrdi3.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high =
-		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/sh/lib/lshrdi3.c b/arch/sh/lib/lshrdi3.c
deleted file mode 100644
index 33eaa1edbc3c0656..0000000000000000
--- a/arch/sh/lib/lshrdi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__lshrdi3);
-- 
2.34.1

