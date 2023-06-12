Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819CC72BB38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFLIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjFLIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:52:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB3109;
        Mon, 12 Jun 2023 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686559920; x=1718095920;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3rej1/z6cKyA2TVrH+5R9/jUoDY9kF6jAMzOdlkY4Xk=;
  b=c9bmlI9CNm4a435tDmrGYz893HRNiiaOWMg+203Ci2za3lJzrVwTd3JI
   1CTLOXIln8/w3WjfkGg8DX3uBvqURedYPcKF3HXP8+XHLnoh+2HC9pTpP
   w1YYIF6WTXRyJ5uIu6iFPPv0bGSISqUX5EvlqUqfH6AyqArN/IPoegEpA
   r2ohnAi0Zc7xyOZ8J0sEVq+BTg0F3uX2bC4g77F35IdaiqMX58KW7Cvkx
   Hn8PryjVaTQlChoCGw/JSkRvxg9LJCfwaI+a7JIWNxjXjmzyABBMeHBrd
   1YjQmW+oGWKrnWfwbX3a6vqTY04ELwVEn7zr/w/Vsja+K6NCWFJ2GZOm5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347613316"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347613316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835365324"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835365324"
Received: from apeer-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.251.3.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:22 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 12 Jun 2023 00:55:59 -0600
Subject: [PATCH v3 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v3-4-869f82069c95@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=7763;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=3rej1/z6cKyA2TVrH+5R9/jUoDY9kF6jAMzOdlkY4Xk=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCltB6dkRbo8Mb8g/KPvSOgVh+nTu4tqxRd7fz7mMG9B6
 Voho+eTOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRqreMDM9rk15GMWXtnLta
 dWpoy+/uNwJFRw5rXkg8k1V5mPXpbQeGfwq9t84aHngs/fnwc7ZLXJO1tjN0lFnN2dW/z+CWHK+
 mFQcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 160 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 68668d8df1cd..1166f470e0c7 100644
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
@@ -1128,6 +1149,87 @@ static struct attribute *cxl_mock_mem_core_attrs[] = {
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
+		return 0;
+	case CXL_FW_ACTIVATE_OFFLINE:
+		mdata->fw_staged = activate->slot;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -1194,6 +1296,15 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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
@@ -1209,6 +1320,11 @@ static void label_area_release(void *lsa)
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
@@ -1241,10 +1357,19 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
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
@@ -1286,6 +1411,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	rc = cxl_memdev_setup_fw_upload(cxlds);
+	if (rc)
+		return rc;
+
 	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
 
 	return 0;
@@ -1324,9 +1453,40 @@ static ssize_t security_lock_store(struct device *dev, struct device_attribute *
 
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

