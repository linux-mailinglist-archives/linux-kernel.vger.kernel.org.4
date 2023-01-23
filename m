Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E46782A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjAWROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjAWROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:14:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFF2313C;
        Mon, 23 Jan 2023 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494056; x=1706030056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+6/rhKyOwDW70Iv9nyCUCzqIJXspwIUmmViGKg5jXI=;
  b=EwTWsP9L3bK1s7K/FsVxeHXS9au6fKNUX47pfD2/0EWd84bCZRT4+3fc
   HVaNW/Zszgm9TFiLo4n127duyby6Qcyle1IP3pMx0SEShVPKtS8qJIR4L
   HDDU+lsz0T4pVmFp9Lem4lkld50AB1XYj2gOkUfXZpAqHG1VOvESKFJXa
   s5ZaQ+GUSqt5Tz61+miFN8etjXL1FwJGdw7wH9tLI3CwX4EdzvT/AQrdT
   Ib5Aop29pZnwbcILUABiri3NF9sqwIx+OUdGOukPnHcuR7LMdxxSdNhk7
   f+xNUNLOHnOCSBJBbQJXdY6KciFgfPF5vFhfwdARepiUbL1Kyx3k+Ckr1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324773374"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="324773374"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694006131"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694006131"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Jan 2023 09:09:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 536C2154; Mon, 23 Jan 2023 19:10:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 2/3] ACPI: utils: Add acpi_get_first_match_physical_node()
Date:   Mon, 23 Jan 2023 19:10:05 +0200
Message-Id: <20230123171006.58274-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are drivers that are using a logic that is combined in the offered
acpi_get_first_match_physical_node(). The rationale to have this helper
not only redunction of the lines of code, but improving the robustness
by properly handling the reference counters on the error paths.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c    | 28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  3 +++
 include/linux/acpi.h    |  6 ++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..052e263d2246 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -965,6 +965,34 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 }
 EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
 
+/**
+ * acpi_get_first_match_physical_node - Return the physical node of the first match of ACPI device
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * Return the physical node of the first match of ACPI device if a matching
+ * device was present at the moment of invocation, or NULL otherwise.
+ *
+ * The caller is responsible for invoking put_device() on the returned device.
+ *
+ * See additional information in acpi_dev_present() as well.
+ */
+struct device *acpi_get_first_match_physical_node(const char *hid, const char *uid, s64 hrv)
+{
+	struct acpi_device *adev;
+	struct device *dev;
+
+	adev = acpi_dev_get_first_match_dev(hid, uid, hrv);
+	if (!adev)
+		return NULL;
+
+	dev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+	return dev;
+}
+EXPORT_SYMBOL(acpi_get_first_match_physical_node);
+
 /**
  * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
  *
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0584e9f6e339..e62af2f71362 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -777,6 +777,9 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 	     adev;							\
 	     adev = acpi_dev_get_next_match_dev(adev, hid, uid, hrv))
 
+struct device *
+acpi_get_first_match_physical_node(const char *hid, const char *uid, s64 hrv);
+
 static inline struct acpi_device *acpi_dev_get(struct acpi_device *adev)
 {
 	return adev ? to_acpi_device(get_device(&adev->dev)) : NULL;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4b12dad5a8a4..29bae77d819a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -814,6 +814,12 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	return NULL;
 }
 
+static inline struct device *
+acpi_get_first_match_physical_node(const char *hid, const char *uid, s64 hrv)
+{
+	return NULL;
+}
+
 static inline bool acpi_reduced_hardware(void)
 {
 	return false;
-- 
2.39.0

