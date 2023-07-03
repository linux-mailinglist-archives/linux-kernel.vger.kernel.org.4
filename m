Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E77462CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGCSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGCSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CABE73;
        Mon,  3 Jul 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410347; x=1719946347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7YG+rldaGnIVAOwR04bpca61wVV/LIPBDGMSpPP1uE=;
  b=kQdjEqQORu9F5FZGwszkvMck9/fJHKZYaJcwb9dKq+bTWEPkTWr8SMHj
   SWs2N5jxGj0FlYMLBiDq8oHDabcrhNFNWptcBkit6LfObBfYST+rspO5n
   LCqckO75JTZJrbYoFrEpykW+albNmeQHWFTXohY29WPxmxAZwL9x4hh4p
   e5IdLLyAFzpfzQuD1BkWdYrSyIdibU/KW0KjudECHDcx/cDaFb+Up8Bjo
   WXxjPTdtBn2F25bLKT115oxuwpHYexbBWg2NylULbokzqjldwZwqGTCyg
   +Lb7KBZf3S3akd9xw3iVBmvUmgjXhWdNhwhLBL2b7mOFi3Uu8sdE6M3ZE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347736200"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347736200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="842743323"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="842743323"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2023 11:52:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 337E0177; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 02/12] HID: cp2112: Use str_write_read() and str_read_write()
Date:   Mon,  3 Jul 2023 21:52:12 +0300
Message-Id: <20230703185222.50554-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_write_read() and str_read_write() from string_choices.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 27cadadda7c9..37ccf4714ad1 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/nls.h>
+#include <linux/string_choices.h>
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
 
@@ -532,15 +533,13 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	hid_dbg(hdev, "I2C %d messages\n", num);
 
 	if (num == 1) {
+		hid_dbg(hdev, "I2C %s %#04x len %d\n",
+			str_read_write(msgs->flags & I2C_M_RD), msgs->addr, msgs->len);
 		if (msgs->flags & I2C_M_RD) {
-			hid_dbg(hdev, "I2C read %#04x len %d\n",
-				msgs->addr, msgs->len);
 			read_length = msgs->len;
 			read_buf = msgs->buf;
 			count = cp2112_read_req(buf, msgs->addr, msgs->len);
 		} else {
-			hid_dbg(hdev, "I2C write %#04x len %d\n",
-				msgs->addr, msgs->len);
 			count = cp2112_i2c_write_req(buf, msgs->addr,
 						     msgs->buf, msgs->len);
 		}
@@ -648,7 +647,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 	int ret;
 
 	hid_dbg(hdev, "%s addr 0x%x flags 0x%x cmd 0x%x size %d\n",
-		read_write == I2C_SMBUS_WRITE ? "write" : "read",
+		str_write_read(read_write == I2C_SMBUS_WRITE),
 		addr, flags, command, size);
 
 	switch (size) {
-- 
2.40.0.1.gaa8946217a0b

