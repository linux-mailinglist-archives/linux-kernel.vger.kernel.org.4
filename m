Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCD6A7BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCBHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCBHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:13:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D01CACC;
        Wed,  1 Mar 2023 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677741227; x=1709277227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UdkTPsx3MTqmp7pHb8Bec5X8LW5Hn5DgBrG6bqKjGQw=;
  b=QM8M5rYOtgCNJiTyQSYgNvBHyvz7bqT4plRtJ4NkdcYDOSafLP9xMAog
   WGrZXZAkIbMMgKodRAAolFDIHsdzms0Qf6Pf7zQC9t6wW8BB2Jsooo4Q4
   9HX9R3xrCbEdUVpMMgruCih4WyaJXqW3Qe1fMps5WMW38IVWXdfNDhZws
   zz6hmJyf9YjGJnrgu4Dzle3+SpRWobDjvNEPUfj05tqU+CSBIQ+0+36Or
   JxZgKYbmw45r7s5H7TT/vs0tFlVkvibfeuwwmDh3Dwny2OCMmGN+CbT0n
   T5uysc9TjU/zowM98FCrS2yjWGF/GzOfBMinfa8uKlfpG3vuqIdyOxQLc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336937207"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336937207"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 23:13:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003999093"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="1003999093"
Received: from htchen-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.212.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 23:13:46 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
Date:   Wed,  1 Mar 2023 23:13:27 -0800
Message-Id: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/acpi/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7db3b530279b..afeac925b31b 100644
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
+	    !(ccel->log_area_start_address) || !(ccel->log_area_minimum_length)) {
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

