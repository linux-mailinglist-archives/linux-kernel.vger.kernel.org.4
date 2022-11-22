Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7563446E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiKVTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiKVTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:18:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88FD28E1B;
        Tue, 22 Nov 2022 11:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669144690; x=1700680690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wCUPllZUwt3RNiQWNSRhSsZ3MYzfpI1ZWxBokU8qb/8=;
  b=iSvD5VY+1TvgGeSbb078p91/09IQZj9jRCJZK/LqCsdZsJS+NEXD4kmx
   GaWFsY0GMCWaFWLCvl5au2Ekj51A224XvkR+fCjU1aJcV5e3HuybzEZdF
   E593ikxhFuCM93DbsO7pxaxnF/tbkiVrpuZUdf0NGtEOgS4CoPwn7SUT2
   KWF1kkYAfV8w3p+XoRfUic6W/GVKOc5Nd+bbSuT52UpbaDf+eaDCMK8/2
   Axn++MCLDwHi3thMtusGDYXSVoqJGWIeNXvSplOiOgINlGfcXlkAFVFvo
   codTYsHO3GV1BzQ407C6fjylEkoeO/b2DSmY3GyonMdLCNMW/htAlHTvm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315716804"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315716804"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="730515666"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="730515666"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2022 11:18:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52E2212B; Tue, 22 Nov 2022 21:18:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 2/2] HID: i2c-hid: acpi: Unify ACPI ID tables format
Date:   Tue, 22 Nov 2022 21:18:21 +0200
Message-Id: <20221122191821.18076-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
References: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
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
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 661a87dbd584..37a03411e785 100644
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
@@ -109,9 +109,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
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
2.35.1

