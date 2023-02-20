Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D369C9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBTL0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBTL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:26:28 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DE9023
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892386; x=1708428386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5lXumQ8qCSEY6OU+rn431DpvEqvf2R0gCQDL8bf8zo=;
  b=TWAZaj8pOy/eaG9GPvYmTLZa7FOtzHjBesfw4GD6ACMpzeHjWcnjPoYL
   rOxfH0fEu0FYDU+PBl84qohJ6GORIYQrm8/u0p/6pJANvpEC/KFjgQdeX
   elG4xUsgwRN8SZi+b00Df3M+7JwamQDOzvEE58FR3QSJwggxRPRxIERIV
   ZqMlOjWxaKmlCVZelKadpuF7vHKCh5ruWqViZN9p524vLckNZ1lsJpTLn
   330lO9ZDW0BpDiaHYVcU4d91VrGercmYUQiE/CswaizfTBiI/1AshitY7
   DMOtP9NzA4X77eElhdcOR2YjfFIi1P8hSBnVB5KXVmNzm/bluWrREouCQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187430"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Feb 2023 12:26:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 20 Feb 2023 12:26:21 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 20 Feb 2023 12:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892381; x=1708428381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5lXumQ8qCSEY6OU+rn431DpvEqvf2R0gCQDL8bf8zo=;
  b=jb5RjXBpn8K9sH21Oowkqs/qpb55p2Cj94vKtbYA3fQrmEaGZEqvYE/7
   idwYGRL5iCaWcNitraM8NekX1IY/JDo2gYwNi69T3mwW/7gQJ6MgQGlrQ
   WJbxxEC4DxlWjKz2/FOAcws3FhwrlQdfEBR3QyLSdITTHzs4UzkzhIanf
   l3ZMPZO9r2jnNjwtu1IPlCTFeY8W1awtyQgFcbjcD8op0uPlpNGWKmvm6
   P75TKNvGH/hBQlVH6vXh3DwbTqVcyfLmHwBMOT0YNcoseRzrVHO9BvIiD
   PJ9RVQEu49qu3ur3alYLJGR+T5ugXvAukufTNwH/bGt6EbsFZ/VUun+wU
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187425"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Feb 2023 12:26:20 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 15149280072;
        Mon, 20 Feb 2023 12:26:15 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/3] mfd: tqmx86: specify IO port register range more precisely
Date:   Mon, 20 Feb 2023 12:25:45 +0100
Message-Id: <db4677ac318b1283c8956f637f409995a30a31c3.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers 0x160..0x17f are unassigned. Use 0x180 as base register and
update offets accordingly.

Also change the size of the range to include 0x19f. While 0x19f is
currently reserved for future extensions, so are several of the previous
registers up to 0x19e, and it is weird to leave out just the last one.

Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    v2: add Reviewed-by from v1

 drivers/mfd/tqmx86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 31d0efb5aacf8..958334f14eb00 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -16,8 +16,8 @@
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/platform_device.h>
 
-#define TQMX86_IOBASE	0x160
-#define TQMX86_IOSIZE	0x3f
+#define TQMX86_IOBASE	0x180
+#define TQMX86_IOSIZE	0x20
 #define TQMX86_IOBASE_I2C	0x1a0
 #define TQMX86_IOSIZE_I2C	0xa
 #define TQMX86_IOBASE_WATCHDOG	0x18b
@@ -25,7 +25,7 @@
 #define TQMX86_IOBASE_GPIO	0x18d
 #define TQMX86_IOSIZE_GPIO	0x4
 
-#define TQMX86_REG_BOARD_ID	0x20
+#define TQMX86_REG_BOARD_ID	0x00
 #define TQMX86_REG_BOARD_ID_E38M	1
 #define TQMX86_REG_BOARD_ID_50UC	2
 #define TQMX86_REG_BOARD_ID_E38C	3
@@ -40,8 +40,8 @@
 #define TQMX86_REG_BOARD_ID_E40S	13
 #define TQMX86_REG_BOARD_ID_E40C1	14
 #define TQMX86_REG_BOARD_ID_E40C2	15
-#define TQMX86_REG_BOARD_REV	0x21
-#define TQMX86_REG_IO_EXT_INT	0x26
+#define TQMX86_REG_BOARD_REV	0x01
+#define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
 #define TQMX86_REG_IO_EXT_INT_7			1
 #define TQMX86_REG_IO_EXT_INT_9			2
-- 
2.34.1

