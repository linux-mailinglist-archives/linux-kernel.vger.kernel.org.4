Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F272311F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjFEUVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjFEUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1EE51;
        Mon,  5 Jun 2023 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996454; x=1717532454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=W92jXIm9Uj41TzT4x8llGd5p8AikQXwJ1DpwOqr+LHs=;
  b=Zzy1dbl8dNMhdUpB8s10P2KvCa2O7ZDBGmgvkBSOTqbm1NMKPxW+6XlA
   kK+l6Lp/0KwKXPNBt1mGq7JURI9w7kcN4V2WfC4U2ZDOBIdAnMeHl7L4m
   TDvD+u4AvwqoLy/SXzPej5yQyqA6AdNcErBNC9uGMqnfohcdlZlTssuhV
   EzfV+P6zry2LCmKvUIXEhwH9o9MLD9PLkh46r0Xz/q5VkwCQYOqj8QguL
   rVlOQ4nhJZxxv4XXp2W5Z7KW4Y4oA3u+RIG0te4HKKSDt19oay0MV0slE
   QPI03VZ250htmlYnWzIWfJn8ucXHeSzRB3yrwOv8KY2RFmh/ESEBACZeD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336093140"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336093140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832934200"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="832934200"
Received: from kmsalzbe-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.52.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:52 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 05 Jun 2023 14:20:25 -0600
Subject: [PATCH v2 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v2-4-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
In-Reply-To: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=7722;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=W92jXIm9Uj41TzT4x8llGd5p8AikQXwJ1DpwOqr+LHs=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCl1zos0+5ui7005OyfXq+G6unGt8o8X1ge7lqn7ZuTNX
 e4cfvl2RykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACayXYXhn+lp84nPhW7YvHyQ
 /a9Ia91/72kbPfUba896uARIM33+3MnwT1/n47X5sxlXnn0Z/IGtcYfce/kjUpyLFy/PN0tVa73
 pxgEA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emulation for the 'Get FW Info', 'Transfer FW', and 'Activate FW'
CXL mailbox commands to the cxl_test emulated memdevs to enable
end-to-end unit testing of a firmware update flow. For now, only
advertise an 'offline activation' capability as that is all the CXL
memdev driver currently implements.

Add some canned values for the serial number fields, and create a
platform device sysfs knob to calculate the sha256sum of the firmware
image that was received, so a unit test can compare it with the original
file that was uploaded.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 162 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 68668d8df1cd..70cedeac0a49 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -8,11 +8,14 @@
 #include <linux/sizes.h>
 #include <linux/bits.h>
 #include <asm/unaligned.h>
+#include <crypto/sha2.h>
 #include <cxlmem.h>
 
 #include "trace.h"
 
 #define LSA_SIZE SZ_128K
+#define FW_SIZE SZ_64M
+#define FW_SLOTS 3
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
 
@@ -72,6 +75,20 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
 		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FW_INFO),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_TRANSFER_FW),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
+				      EFFECT(BACKGROUND_OP)),
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_ACTIVATE_FW),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
+				      EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -123,6 +140,10 @@ struct mock_event_store {
 
 struct cxl_mockmem_data {
 	void *lsa;
+	void *fw;
+	int fw_slot;
+	int fw_staged;
+	size_t fw_size;
 	u32 security_state;
 	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
 	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
@@ -1128,6 +1149,89 @@ static struct attribute *cxl_mock_mem_core_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem_core);
 
+static int mock_fw_info(struct cxl_dev_state *cxlds,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+	struct cxl_mbox_get_fw_info fw_info = {
+		.num_slots = FW_SLOTS,
+		.slot_info = (mdata->fw_slot & 0x7) |
+			     ((mdata->fw_staged & 0x7) << 3),
+		.activation_cap = 0,
+	};
+
+	strcpy(fw_info.slot_1_revision, "cxl_test_fw_001");
+	strcpy(fw_info.slot_2_revision, "cxl_test_fw_002");
+	strcpy(fw_info.slot_3_revision, "cxl_test_fw_003");
+	strcpy(fw_info.slot_4_revision, "");
+
+	if (cmd->size_out < sizeof(fw_info))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &fw_info, sizeof(fw_info));
+	return 0;
+}
+
+static int mock_transfer_fw(struct cxl_dev_state *cxlds,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+	void *fw = mdata->fw;
+	size_t offset, length;
+
+	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
+	length = cmd->size_in - sizeof(*transfer);
+	if (offset + length > FW_SIZE)
+		return -EINVAL;
+
+	switch (transfer->action) {
+	case CXL_FW_TRANSFER_ACTION_FULL:
+		if (offset != 0)
+			return -EINVAL;
+		fallthrough;
+	case CXL_FW_TRANSFER_ACTION_END:
+		if (transfer->slot == 0 || transfer->slot > FW_SLOTS)
+			return -EINVAL;
+		mdata->fw_size = offset + length;
+		break;
+	case CXL_FW_TRANSFER_ACTION_INITIATE:
+	case CXL_FW_TRANSFER_ACTION_CONTINUE:
+		break;
+	case CXL_FW_TRANSFER_ACTION_ABORT:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	memcpy(fw + offset, transfer->data, length);
+	return 0;
+}
+
+static int mock_activate_fw(struct cxl_dev_state *cxlds,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_activate_fw *activate = cmd->payload_in;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+
+	if (activate->slot == 0 || activate->slot > FW_SLOTS)
+		return -EINVAL;
+
+	switch (activate->action) {
+	case CXL_FW_ACTIVATE_ONLINE:
+		mdata->fw_slot = activate->slot;
+		mdata->fw_staged = 0;
+		break;
+	case CXL_FW_ACTIVATE_OFFLINE:
+		mdata->fw_staged = activate->slot;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -1194,6 +1298,15 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_CLEAR_POISON:
 		rc = mock_clear_poison(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_FW_INFO:
+		rc = mock_fw_info(cxlds, cmd);
+		break;
+	case CXL_MBOX_OP_TRANSFER_FW:
+		rc = mock_transfer_fw(cxlds, cmd);
+		break;
+	case CXL_MBOX_OP_ACTIVATE_FW:
+		rc = mock_activate_fw(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1209,6 +1322,11 @@ static void label_area_release(void *lsa)
 	vfree(lsa);
 }
 
+static void fw_buf_release(void *buf)
+{
+	vfree(buf);
+}
+
 static bool is_rcd(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -1241,10 +1359,19 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mdata->lsa = vmalloc(LSA_SIZE);
 	if (!mdata->lsa)
 		return -ENOMEM;
+	mdata->fw = vmalloc(FW_SIZE);
+	if (!mdata->fw)
+		return -ENOMEM;
+	mdata->fw_slot = 2;
+
 	rc = devm_add_action_or_reset(dev, label_area_release, mdata->lsa);
 	if (rc)
 		return rc;
 
+	rc = devm_add_action_or_reset(dev, fw_buf_release, mdata->fw);
+	if (rc)
+		return rc;
+
 	cxlds = cxl_dev_state_create(dev);
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
@@ -1286,6 +1413,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	rc = cxl_memdev_setup_fw_upload(cxlds);
+	if (rc)
+		return rc;
+
 	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
 
 	return 0;
@@ -1324,9 +1455,40 @@ static ssize_t security_lock_store(struct device *dev, struct device_attribute *
 
 static DEVICE_ATTR_RW(security_lock);
 
+static ssize_t fw_buf_checksum_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u8 hash[SHA256_DIGEST_SIZE];
+	unsigned char *hstr, *hptr;
+	struct sha256_state sctx;
+	ssize_t written = 0;
+	int i;
+
+	sha256_init(&sctx);
+	sha256_update(&sctx, mdata->fw, mdata->fw_size);
+	sha256_final(&sctx, hash);
+
+	hstr = kzalloc((SHA256_DIGEST_SIZE * 2) + 1, GFP_KERNEL);
+	if (!hstr)
+		return -ENOMEM;
+
+	hptr = hstr;
+	for (i = 0; i < SHA256_DIGEST_SIZE; i++)
+		hptr += sprintf(hptr, "%02x", hash[i]);
+
+	written = sysfs_emit(buf, "%s\n", hstr);
+
+	kfree(hstr);
+	return written;
+}
+
+static DEVICE_ATTR_RO(fw_buf_checksum);
+
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
 	&dev_attr_event_trigger.attr,
+	&dev_attr_fw_buf_checksum.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);

-- 
2.40.1

