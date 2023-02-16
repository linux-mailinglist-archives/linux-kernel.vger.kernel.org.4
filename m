Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C2699787
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBPOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBPOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:35:01 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D06311C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676558100; x=1708094100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPdQihjWkNxzMPXyFqFbJJTx7NrvoFC4LkIxbhTqvdg=;
  b=T7e88bVF8ycJVBmLMN4Ywta4ZsGKqu0KOiM8h7u3goJV3QwzUscga/2o
   25WCyVQ8qiqv2Rr4+uFoZ/EXfdhGWxXiIe73aRquIvx1yYgXM1SdcHKhs
   CzpFiPuH/L9Qt+4YVxTHwZw1Plw+3NcLI9NF5dizCS72lwPoyNKNUKUHd
   ZG0LtrCDEwklczBd4VH7hCtdSHZNm7SDCBnTitQHKJJ/zIRXekWNOdBol
   DdfPr2sANSfHNW4xAEGQ/417IttsohDgdObwVStqEY+Ze+tkeyaAtjiGp
   NPnzq4odkSijCKbHZ2CjKHEfkxXxF4sZRrDHI8GpBgnS0cDdxTw0OHMe/
   w==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669071600"; 
   d="scan'208";a="29134874"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Feb 2023 15:34:56 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Feb 2023 15:34:56 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Feb 2023 15:34:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676558096; x=1708094096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPdQihjWkNxzMPXyFqFbJJTx7NrvoFC4LkIxbhTqvdg=;
  b=GW8Qq5QXjVf8xfwiIVl1i0Ip1L22JCK2neIk362JOx73yMK54vx8xZGY
   KIc/YGc0enQdLkDrj4wqzgpH1SnD9K4Nc+EZSRq3NNiO9Ie4OCBCFyu0y
   KLdpxyztcXQ94pKNeqYYkobw1CgxEG8kpakIMFFZ0+abivowaPouEqc4r
   PBJ8XD8S7pACQ3uOopfxIUDUvCNndTC43Uyx9ckLtv2cUemcEYeRnLH0G
   xcNDE7cNhkxrG5QqNyIfj0net8Il7G+qDRS50XqMka9kG7ksBqkoocWFi
   xLdEuLVmE3IBePZF4rt6V2rjqrmxvxEMtncYdbBBs1HQ7DuryzLQWwJrC
   g==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669071600"; 
   d="scan'208";a="29134873"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2023 15:34:56 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 749D2280072;
        Thu, 16 Feb 2023 15:34:56 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/3] mfd: tqmx86: specify IO port register range more precisely
Date:   Thu, 16 Feb 2023 15:34:23 +0100
Message-Id: <ac7875ea1e3a650b223622457faab79fed5addbe.1676557968.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
References: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
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
---
 drivers/mfd/tqmx86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 8dcbdafa88f4f..1957db881c3a1 100644
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

