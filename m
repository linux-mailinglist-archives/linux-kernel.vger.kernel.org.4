Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3514D65B6F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjABTYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjABTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:23:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11DEB7EE;
        Mon,  2 Jan 2023 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672687423; x=1704223423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gu+Dt/OpMWKrwg8VxAt76Mz52M2Dfk6IjKqn21EscSM=;
  b=cf/yVat8r7Cw12YKdWEiFL36x91ZlTuON6WXYwtyU48GbZ6JtXUV67FP
   Cv6TwvUgLtxF5uWK3xXGx5qzJ8naIDbRrZCgxOPk0Zv1RQ9luGFSR0bMF
   RVYdc5q4szYx6D7AE0jb9FED/q7lU1FbB5qRr9WSzUx+o4EMr8txrHe25
   yUhTW7jy/JDdkrWHImNsymbvGV8LC0VaKLtXmNzALSKazMp36Zltbjj8e
   w6NYCW1FRlNdYu3iDhUAxm3JiMR/nDKjdrWzPpffXj5Go6zf+Z92eqq7k
   N5AjMsx9RCM4N9dHd+6OqNHhv6De6dGrMIkAK1BkgYgxSQaqUO7E1J5ez
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="305040242"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="305040242"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 11:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="778638990"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="778638990"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2023 11:23:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6438FF4; Mon,  2 Jan 2023 21:24:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] thunderbolt: Refactor tb_acpi_add_link()
Date:   Mon,  2 Jan 2023 21:24:04 +0200
Message-Id: <20230102192404.88076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert while loop into do-while with only a single call to
acpi_get_first_physical_node(). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/acpi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 317e4f5fdb97..628225deb8fe 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -36,16 +36,13 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 	 * We need to do this because the xHCI driver might not yet be
 	 * bound so the USB3 SuperSpeed ports are not yet created.
 	 */
-	dev = acpi_get_first_physical_node(adev);
-	while (!dev) {
-		adev = acpi_dev_parent(adev);
-		if (!adev)
-			break;
+	do {
 		dev = acpi_get_first_physical_node(adev);
-	}
+		if (dev)
+			break;
 
-	if (!dev)
-		goto out_put;
+		adev = acpi_dev_parent(adev);
+	} while (adev);
 
 	/*
 	 * Check that the device is PCIe. This is because USB3
-- 
2.35.1

