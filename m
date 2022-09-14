Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157D606B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJTWq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJTWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:46:12 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC422C47A;
        Thu, 20 Oct 2022 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Subject:Date:To:From:Resent-To:Resent-Message-ID:
        Resent-Date:Resent-From:Sender:Reply-To:Message-ID:Cc:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Sender:Resent-Cc:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nm1iJXuUdZU2uB9PpQSX83/wN9IfcihizUePEGEMhZE=; b=Ls48i0jeumE8G9rGzpu/zgItj/
        EaMT057HE3YesF+z7+yW4TyCy84/7Gl6uQjF+BDPbeW6a8q0PLglUn7p39PLdMOc4L4b3zKOVgqjy
        EcuLIQQGE/Ww46xi2sKUtvMmh6cDBNEB9ONcUBoXVakd61O6JOuiL6FsGJMcsfZALpsY=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oleII-009OaO-Sl; Fri, 21 Oct 2022 00:45:42 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 23:29:09 +0200
Subject: [PATCH 3/6] mtd: eject cfi_interleave code to its own header
In-Reply-To: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_MID,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S230030AbiJTWq2/20221020224629Z+5246@vger.kernel.org>

This fixes build failures for stuff that doesn't care about that, such as:

In file included from ./include/linux/mtd/spi-nor.h:10,
                 from drivers/spi/spi-intel.c:13:
./include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support
   62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
      |  ^~~~~~~

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/mtd/chips/cfi_cmdset_0001.c |  1 +
 drivers/mtd/chips/cfi_cmdset_0002.c |  1 +
 drivers/mtd/chips/cfi_cmdset_0020.c |  1 +
 drivers/mtd/chips/cfi_util.c        |  1 +
 drivers/mtd/chips/gen_probe.c       |  1 +
 drivers/mtd/chips/jedec_probe.c     |  1 +
 include/linux/mtd/cfi.h             | 75 --------------------------
 include/linux/mtd/cfi_interleave.h  | 83 +++++++++++++++++++++++++++++
 8 files changed, 89 insertions(+), 75 deletions(-)
 create mode 100644 include/linux/mtd/cfi_interleave.h

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 54f92d09d9cf..efbf06fce95b 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -34,6 +34,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 
 /* #define CMDSET0001_DISABLE_ERASE_SUSPEND_ON_WRITE */
 /* #define CMDSET0001_DISABLE_WRITE_SUSPEND */
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 67453f59c69c..70d00c3641d8 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -37,6 +37,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 #include <linux/mtd/xip.h>
 
 #define AMD_BOOTLOC_BUG
diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index d35df526e0a6..007e37faff56 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 #include <linux/mtd/mtd.h>
 
 
diff --git a/drivers/mtd/chips/cfi_util.c b/drivers/mtd/chips/cfi_util.c
index 6a6a2a21d2ed..608315032f9e 100644
--- a/drivers/mtd/chips/cfi_util.c
+++ b/drivers/mtd/chips/cfi_util.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 
 void cfi_udelay(int us)
 {
diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index 4d4f97841016..8703890ff20e 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -10,6 +10,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 #include <linux/mtd/gen_probe.h>
 
 static struct mtd_info *check_cmd_set(struct map_info *, int);
diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 6f7e7e1b3fe5..88a979bb59bb 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
+#include <linux/mtd/cfi_interleave.h>
 #include <linux/mtd/gen_probe.h>
 
 /* AMD */
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index d88bb56c18e2..4a8ddb51afee 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -8,87 +8,12 @@
 
 #include <linux/delay.h>
 #include <linux/types.h>
-#include <linux/bug.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi_endian.h>
 #include <linux/mtd/xip.h>
 
-#ifdef CONFIG_MTD_CFI_I1
-#define cfi_interleave(cfi) 1
-#define cfi_interleave_is_1(cfi) (cfi_interleave(cfi) == 1)
-#else
-#define cfi_interleave_is_1(cfi) (0)
-#endif
-
-#ifdef CONFIG_MTD_CFI_I2
-# ifdef cfi_interleave
-#  undef cfi_interleave
-#  define cfi_interleave(cfi) ((cfi)->interleave)
-# else
-#  define cfi_interleave(cfi) 2
-# endif
-#define cfi_interleave_is_2(cfi) (cfi_interleave(cfi) == 2)
-#else
-#define cfi_interleave_is_2(cfi) (0)
-#endif
-
-#ifdef CONFIG_MTD_CFI_I4
-# ifdef cfi_interleave
-#  undef cfi_interleave
-#  define cfi_interleave(cfi) ((cfi)->interleave)
-# else
-#  define cfi_interleave(cfi) 4
-# endif
-#define cfi_interleave_is_4(cfi) (cfi_interleave(cfi) == 4)
-#else
-#define cfi_interleave_is_4(cfi) (0)
-#endif
-
-#ifdef CONFIG_MTD_CFI_I8
-# ifdef cfi_interleave
-#  undef cfi_interleave
-#  define cfi_interleave(cfi) ((cfi)->interleave)
-# else
-#  define cfi_interleave(cfi) 8
-# endif
-#define cfi_interleave_is_8(cfi) (cfi_interleave(cfi) == 8)
-#else
-#define cfi_interleave_is_8(cfi) (0)
-#endif
-
-#ifndef cfi_interleave
-#warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
-static inline int cfi_interleave(void *cfi)
-{
-	BUG();
-	return 0;
-}
-#endif
-
-static inline int cfi_interleave_supported(int i)
-{
-	switch (i) {
-#ifdef CONFIG_MTD_CFI_I1
-	case 1:
-#endif
-#ifdef CONFIG_MTD_CFI_I2
-	case 2:
-#endif
-#ifdef CONFIG_MTD_CFI_I4
-	case 4:
-#endif
-#ifdef CONFIG_MTD_CFI_I8
-	case 8:
-#endif
-		return 1;
-
-	default:
-		return 0;
-	}
-}
-
 
 /* NB: these values must represents the number of bytes needed to meet the
  *     device type (x8, x16, x32).  Eg. a 32 bit device is 4 x 8 bytes.
diff --git a/include/linux/mtd/cfi_interleave.h b/include/linux/mtd/cfi_interleave.h
new file mode 100644
index 000000000000..03d94a6d11fc
--- /dev/null
+++ b/include/linux/mtd/cfi_interleave.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MTD_CFI_INTERLEAVE_H__
+#define __MTD_CFI_INTERLEAVE_H__
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_MTD_CFI_I1
+#define cfi_interleave(cfi) 1
+#define cfi_interleave_is_1(cfi) (cfi_interleave(cfi) == 1)
+#else
+#define cfi_interleave_is_1(cfi) (0)
+#endif
+
+#ifdef CONFIG_MTD_CFI_I2
+# ifdef cfi_interleave
+#  undef cfi_interleave
+#  define cfi_interleave(cfi) ((cfi)->interleave)
+# else
+#  define cfi_interleave(cfi) 2
+# endif
+#define cfi_interleave_is_2(cfi) (cfi_interleave(cfi) == 2)
+#else
+#define cfi_interleave_is_2(cfi) (0)
+#endif
+
+#ifdef CONFIG_MTD_CFI_I4
+# ifdef cfi_interleave
+#  undef cfi_interleave
+#  define cfi_interleave(cfi) ((cfi)->interleave)
+# else
+#  define cfi_interleave(cfi) 4
+# endif
+#define cfi_interleave_is_4(cfi) (cfi_interleave(cfi) == 4)
+#else
+#define cfi_interleave_is_4(cfi) (0)
+#endif
+
+#ifdef CONFIG_MTD_CFI_I8
+# ifdef cfi_interleave
+#  undef cfi_interleave
+#  define cfi_interleave(cfi) ((cfi)->interleave)
+# else
+#  define cfi_interleave(cfi) 8
+# endif
+#define cfi_interleave_is_8(cfi) (cfi_interleave(cfi) == 8)
+#else
+#define cfi_interleave_is_8(cfi) (0)
+#endif
+
+#ifndef cfi_interleave
+#warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
+static inline int cfi_interleave(void *cfi)
+{
+	BUG();
+	return 0;
+}
+#endif
+
+static inline int cfi_interleave_supported(int i)
+{
+	switch (i) {
+#ifdef CONFIG_MTD_CFI_I1
+	case 1:
+#endif
+#ifdef CONFIG_MTD_CFI_I2
+	case 2:
+#endif
+#ifdef CONFIG_MTD_CFI_I4
+	case 4:
+#endif
+#ifdef CONFIG_MTD_CFI_I8
+	case 8:
+#endif
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
+
+#endif /* __MTD_CFI_INTERLEAVE_H__ */
-- 
2.37.2.609.g9ff673ca1a

