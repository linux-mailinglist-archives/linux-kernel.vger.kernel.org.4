Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C896C54A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCVTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCVTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:13:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D2C4AFF8;
        Wed, 22 Mar 2023 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679512431; x=1711048431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ptLcWk9srDFCxKrQ2KuZ2G9eHwppFRvlMA0y7UxLp98=;
  b=d67NLz1KfVVsT4bDqhm9aO6WAzMfZn3W49Q6h0dzRSPDt3GpGy/6YDx+
   6mCJKA/lwBzyzGH5RWhqTAMfA6gQD7TzXO3dvbx54gwqoIzT1Tnni7ofF
   x6QdLtZXfcCuG1v35vXc/oY8n0oo74auDub3pXMg8M369+k6ffe+CuvIK
   J39EdMo61u5rZRs+dYE5szotfMqZQWIIeu5MCo5++8HoJ7/+l9MOAPpsn
   5d4Ns2mfiQzs8VSGyWwuHeO7/q/Sa8wXdBGQR03DKSTdftUhycF9Uas9/
   67+9CVUxBSRx47dYB3V1B8Khfahwq712TkS0Hx/Ls1WT4kH00OAqiYC9K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="401881514"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="401881514"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 12:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682025126"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="682025126"
Received: from rfbarbee-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.1.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 12:13:50 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
Date:   Wed, 22 Mar 2023 12:13:13 -0700
Message-Id: <20230322191313.22804-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Confidential Computing Event Log (CCEL) table provides the address
and length of the CCEL records area in UEFI reserved memory.

To allow user space access to these records, expose a sysfs interface
similar to the BERT table.

More details about the CCEL table can be found in the ACPI specification
r6.5 [1], sec 5.2.34.

Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table # [1]
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Fixed the commit log as per review suggestion.

Changes since v1:
 * Removed unnecessary parenthesis as per Rafael's suggestion.

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

