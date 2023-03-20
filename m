Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4238B6C2382
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCTVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCTVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:21:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE22B639;
        Mon, 20 Mar 2023 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679347286; x=1710883286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ee0MocZZvuzZtMlJQpwzZ7fSZHmdq283DMPVpuyM/Bk=;
  b=oDjREvV2oqxkqRWffqQ+BQxUZdZZOPBgHLYmBgbTG5vp+f2olT0OqROW
   jTPbSei4aISrFR9vjHV7zYZ7Lj3J34FcKS5Ews2xriacxWF2aIcbyF4ev
   /7+enHvQXsBRJSmLHt4Faj1Dkll+ValyAxZQRX7BolyD2y3EmMEGjENL/
   2cACVeS5cQ6xXfO0EhsDy6jlU7+OIGJUWGkqbFpszsDOwpbNDueJMTk7V
   /vE7vAjt1Sq7JxkNqv9ZBBya4oDB2yjawtFpk2b3PBTA06+lJUnsCySVY
   l3csFbbscJq3wOzAPKM7GesCTOXurVOp4hWCg6JDCwiYip7EJV9s/nvCi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366507044"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="366507044"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="683583767"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="683583767"
Received: from jcardiel-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.226.30])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:21:25 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
Date:   Mon, 20 Mar 2023 14:20:19 -0700
Message-Id: <20230320212019.2479101-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Confidential Computing Event Log (CCEL) table provides the address
and length of the CCEL records area in UEFI reserved memory. To access
these records, userspace can use /dev/mem to retrieve them. But
'/dev/mem' is not enabled on many systems for security reasons.

So to allow user space access these event log records without the
/dev/mem interface, add support to access it via sysfs interface. The
ACPI driver has provided read only access to BERT records area via
'/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
and add support for /sys/firmware/acpi/tables/data/CCEL to enable
read-only access to the CCEL recorids area.

More details about the CCEL table can be found in ACPI specification
r6.5, sec titled "CC Event Log ACPI Table".

Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
[Original patch is for TDEL table, modified it for CCEL support]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Removed unnecessary parenthesis as per Rafael's suggestion..

 drivers/acpi/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7f4ff56c9d42..687524b50085 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
 }
 
+static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
+{
+	struct acpi_table_ccel *ccel = th;
+
+	if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
+	    !ccel->log_area_start_address || !ccel->log_area_minimum_length) {
+		kfree(data_attr);
+		return -EINVAL;
+	}
+	data_attr->addr = ccel->log_area_start_address;
+	data_attr->attr.size = ccel->log_area_minimum_length;
+	data_attr->attr.attr.name = "CCEL";
+
+	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
+}
+
 static struct acpi_data_obj {
 	char *name;
 	int (*fn)(void *, struct acpi_data_attr *);
 } acpi_data_objs[] = {
 	{ ACPI_SIG_BERT, acpi_bert_data_init },
+	{ ACPI_SIG_CCEL, acpi_ccel_data_init },
 };
 
 #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
-- 
2.34.1

