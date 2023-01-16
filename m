Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE766C43E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjAPPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjAPPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:45:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A41B56F;
        Mon, 16 Jan 2023 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673883951; x=1705419951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCe0S1pP7gr66ZIU7rc/P1INm79GsfNMMBj/cbVwIds=;
  b=Uo6YTP3FxvTdgeHSZsYXqw+K/gGHPAmEtsJcnlOFrBlJErRKAnQ1yxcs
   2jtD2ScVpLRQ+WRI3jTPzVyEm1kp9LnaWmAvxBb9p/UPupNIWlOH7/dXz
   69Enh5k+pLqhN2S6efx65p6ww8IHltWNT21axEUfSqhUr4xc+76pQB7+/
   TBRymBIL19u+jWtnAuVOobNKMec4VAbrxdeXJDfDf4vnG0/iP2sRIpZRo
   4NnbMkYn4FaUB+/h9Hm4/6TP8rPXa2VnzVdNa5N9L20Z1c3n5/YLqX2jN
   9WwgKfqEMc/sUUKTNIfLy/12yxNMZwmEf3D5QLtkHeObraZezwXxmAMmA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323188292"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="323188292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 07:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652296811"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="652296811"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2023 07:45:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AE5992; Mon, 16 Jan 2023 17:46:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] HID: i2c-hid: acpi: Unify ACPI ID tables format
Date:   Mon, 16 Jan 2023 17:46:21 +0200
Message-Id: <20230116154621.16135-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
References: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify ACPI ID tables format by:
- surrounding HID by spaces
- dropping unnecessary driver_data assignment to 0
- dropping comma at the terminator entry

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 5e28da45e762..3a7e2bcb5412 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -39,8 +39,8 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	 * The CHPN0001 ACPI device, which is used to describe the Chipone
 	 * ICN8505 controller, has a _CID of PNP0C50 but is not HID compatible.
 	 */
-	{"CHPN0001", 0 },
-	{ },
+	{ "CHPN0001" },
+	{ }
 };
 
 /* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
@@ -104,9 +104,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
-	{"ACPI0C50", 0 },
-	{"PNP0C50", 0 },
-	{ },
+	{ "ACPI0C50" },
+	{ "PNP0C50" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, i2c_hid_acpi_match);
 
-- 
2.39.0

