Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907EE6D011F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjC3K1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3K1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:27:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CE72A7;
        Thu, 30 Mar 2023 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680172063; x=1711708063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsso8X59jkwfS8FUc+qT+mBVmfIXBVin+KTPPha6LF8=;
  b=h0yHz4lMGE6+yemI1twXONAwf5J+Ls+iqorfH4gisWaVW9fULVhuWBcg
   dzqtzzoFongDoWSVQEANyJNkTVeByc6NisOnM/cRGgRotuhSru7/61Hgg
   4pNUu/BGbF5OILtF1oKVT6DDFmLW7TqV2El/c1LZd3n8BrRO0LM7WeHqS
   wnMZs1i8lP4MGBwNZ5NbdGVE3pJpEKAU4soowpld8QMeqcz4OUmtrYz+1
   qTPk+v/3GgPx8nCRfm4XmPJpqv/WXj37exUgqcVjN3g0xe2VHxHuxjBTh
   1nwyuidinAWrqTa0H9K324UpD19x3zXApT28tEhMZ2p4s6C4qVN/tUILn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368909798"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368909798"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634831399"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634831399"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 03:27:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AF2D80A; Thu, 30 Mar 2023 13:23:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] thunderbolt: Introduce usb4_port_sb_opcode_err_to_errno() helper
Date:   Thu, 30 Mar 2023 13:23:42 +0300
Message-Id: <20230330102342.44090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb4_port_sb_opcode_err_to_errno() converts from USB4 error codes
to the Linux errno space. In particular, this makes the intention
of the repeating usb4_port_retimer_read() call in the
usb4_port_retimer_nvm_authenticate_status() clearer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 41 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 12355929e586..485b6e430686 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1303,6 +1303,20 @@ static int usb4_port_sb_write(struct tb_port *port, enum usb4_sb_target target,
 	return 0;
 }
 
+static int usb4_port_sb_opcode_err_to_errno(u32 val)
+{
+	switch (val) {
+	case 0:
+		return 0;
+	case USB4_SB_OPCODE_ERR:
+		return -EAGAIN;
+	case USB4_SB_OPCODE_ONS:
+		return -EOPNOTSUPP;
+	default:
+		return -EIO;
+	}
+}
+
 static int usb4_port_sb_op(struct tb_port *port, enum usb4_sb_target target,
 			   u8 index, enum usb4_sb_opcode opcode, int timeout_msec)
 {
@@ -1325,21 +1339,8 @@ static int usb4_port_sb_op(struct tb_port *port, enum usb4_sb_target target,
 		if (ret)
 			return ret;
 
-		switch (val) {
-		case 0:
-			return 0;
-
-		case USB4_SB_OPCODE_ERR:
-			return -EAGAIN;
-
-		case USB4_SB_OPCODE_ONS:
-			return -EOPNOTSUPP;
-
-		default:
-			if (val != opcode)
-				return -EIO;
-			break;
-		}
+		if (val != opcode)
+			return usb4_port_sb_opcode_err_to_errno(val);
 	} while (ktime_before(ktime_get(), timeout));
 
 	return -ETIMEDOUT;
@@ -1814,12 +1815,13 @@ int usb4_port_retimer_nvm_authenticate_status(struct tb_port *port, u8 index,
 	if (ret)
 		return ret;
 
-	switch (val) {
+	ret = usb4_port_sb_opcode_err_to_errno(val);
+	switch (ret) {
 	case 0:
 		*status = 0;
 		return 0;
 
-	case USB4_SB_OPCODE_ERR:
+	case -EAGAIN:
 		ret = usb4_port_retimer_read(port, index, USB4_SB_METADATA,
 					     &metadata, sizeof(metadata));
 		if (ret)
@@ -1828,11 +1830,8 @@ int usb4_port_retimer_nvm_authenticate_status(struct tb_port *port, u8 index,
 		*status = metadata & USB4_SB_METADATA_NVM_AUTH_WRITE_MASK;
 		return 0;
 
-	case USB4_SB_OPCODE_ONS:
-		return -EOPNOTSUPP;
-
 	default:
-		return -EIO;
+		return ret;
 	}
 }
 
-- 
2.40.0.1.gaa8946217a0b

