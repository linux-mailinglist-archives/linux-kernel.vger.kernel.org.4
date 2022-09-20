Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115FD5BE33D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiITKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiITKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:14 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09176F264
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:31:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id D42C4280B58;
        Tue, 20 Sep 2022 18:31:10 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/20] ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
Date:   Tue, 20 Sep 2022 18:30:49 +0800
Message-Id: <20220920103108.23074-2-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920103108.23074-1-jay.xu@rock-chips.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0hLVk5OQ00eSkNLSx4dH1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6MCo6Qj0dURw3FxRCLykf
        SQEwFExVSlVKTU1ITU1CQ0xKTktNVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhCS083Bg++
X-HM-Tid: 0a835a73a2102eb1kusnd42c4280b58
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some users interpret _UID only as integer and for them it's easier to
have an integer representation of _UID. Add respective helper for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/utils.c    | 24 ++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 5a7b8065e77f..febf9b8da3a0 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -793,6 +793,30 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
+/**
+ * acpi_dev_uid_to_integer - treat ACPI device _UID as integer
+ * @adev: ACPI device to get _UID from
+ * @integer: output buffer for integer
+ *
+ * Considers _UID as integer and converts it to @integer.
+ *
+ * Returns 0 on success, or negative error code otherwise.
+ */
+int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
+{
+	const char *uid;
+
+	if (!adev)
+		return -ENODEV;
+
+	uid = acpi_device_uid(adev);
+	if (!uid)
+		return -ENODATA;
+
+	return kstrtou64(uid, 0, integer);
+}
+EXPORT_SYMBOL(acpi_dev_uid_to_integer);
+
 /**
  * acpi_dev_found - Detect presence of a given ACPI device in the namespace.
  * @hid: Hardware ID of the device.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e7d27373ff71..bd0db916f330 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -733,6 +733,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 }
 
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
+int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..9434db02cb60 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -798,6 +798,11 @@ acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *u
 	return false;
 }
 
+static inline int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
+{
+	return -ENODEV;
+}
+
 static inline struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 {
-- 
2.25.1

