Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87136EB6F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDVDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDVDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:09:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17D2135;
        Fri, 21 Apr 2023 20:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682132976; x=1713668976;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=S6v3crgm10JIVgggizVtLcudusm6KM5ofCzlmoXRgmo=;
  b=KAfg+D39lZU4cD1kP0wftGRaawlGEQqtpfuPos/6fNiLeAQxDeyv+EgI
   swpAJWdZylLnJ9zMb3NB2Dsq1fyhnmFSW2/+nGsxlTHqS4y5iCWS7lLdV
   RJQEkDAosnxqfkM6GTL0XHi8HDRmHbXRI/Lkm93ms+UlKAXV2XixrnTCa
   H/XOPoc6ZdGJ5Zedirr/JA0lRddauQDs0DsXW7yyPgd66g0MbY4a9h5Eu
   Z8teDzEgvjK8Z2SM9y28FoQUZHYnHpxQWqV7iT+TJD+yO6nk+d99ezhXd
   8zuIjS46vaZBrI07shdnUn9K0VZPIjCyrmtE0WVXqhI4f+3Rz6ZTtFL4P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343609065"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343609065"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757092273"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757092273"
Received: from jwostman-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.111.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:35 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 21 Apr 2023 21:09:28 -0600
Subject: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
In-Reply-To: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=7635;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=S6v3crgm10JIVgggizVtLcudusm6KM5ofCzlmoXRgmo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCnO/m9VW4WCAkQvcDwsP5YaufuS4PkvE07ufVmzT/Hgi
 m3vU2qUOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRA7IM/8z4MxzVq+UfsNxa
 2s+zYssFnVnHZa8XPN36osciZN3V+x8ZGc6v9zxx64FUjMnazzYfKn+us2nqrb+wzlb6b8nfjSF
 OT1kA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 191 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9263b04d35f7..bc99cc673550 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -7,11 +7,14 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/bits.h>
+#include <crypto/hash.h>
 #include <cxlmem.h>
 
 #include "trace.h"
 
 #define LSA_SIZE SZ_128K
+#define FW_SIZE SZ_64M
+#define FW_SLOTS 3
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
 
@@ -40,6 +43,18 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FW_INFO),
+		.effect = cpu_to_le16(0),
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_TRANSFER_FW),
+		.effect = cpu_to_le16(EFFECT(0) | EFFECT(6)),
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_ACTIVATE_FW),
+		.effect = cpu_to_le16(EFFECT(0) | EFFECT(1)),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -91,6 +106,10 @@ struct mock_event_store {
 
 struct cxl_mockmem_data {
 	void *lsa;
+	void *fw;
+	int fw_slot;
+	int fw_staged;
+	size_t fw_size;
 	u32 security_state;
 	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
 	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
@@ -888,6 +907,88 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
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
+	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_OFFSET_ALIGN;
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
+	case CXL_FW_TRANSFER_ACTION_START:
+	case CXL_FW_TRANSFER_ACTION_CONTINUE:
+	case CXL_FW_TRANSFER_ACTION_ABORT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	memcpy(fw + offset, &transfer->data[0], length);
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
@@ -942,6 +1043,15 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
 		rc = mock_passphrase_secure_erase(cxlds, cmd);
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
@@ -957,6 +1067,11 @@ static void label_area_release(void *lsa)
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
@@ -989,10 +1104,19 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
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
@@ -1063,9 +1187,76 @@ static ssize_t security_lock_store(struct device *dev, struct device_attribute *
 
 static DEVICE_ATTR_RW(security_lock);
 
+struct sdesc {
+	struct shash_desc shash;
+	char ctx[];
+};
+
+static int do_sha256(u8 *data, unsigned int length, u8 *hash)
+{
+	struct crypto_shash *alg;
+	struct sdesc *sdesc;
+	size_t size;
+	int rc;
+
+	alg = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(alg))
+		return PTR_ERR(alg);
+
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
+	sdesc = kzalloc(size, GFP_KERNEL);
+	if (!sdesc) {
+		rc = -ENOMEM;
+		goto out_shash;
+	}
+
+	sdesc->shash.tfm = alg;
+	rc = crypto_shash_digest(&sdesc->shash, data, length, hash);
+
+	kfree(sdesc);
+out_shash:
+	crypto_free_shash(alg);
+	return rc;
+}
+
+#define CHECKSUM_SIZE 32
+
+static ssize_t fw_buf_checksum_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned char *hstr, *hptr;
+	u8 hash[CHECKSUM_SIZE];
+	ssize_t written = 0;
+	int i, rc;
+
+	rc = do_sha256(mdata->fw, mdata->fw_size, &hash[0]);
+	if (rc) {
+		dev_err(dev, "error calculating checksum: %d\n", rc);
+		goto out_free;
+	}
+
+	hstr = kzalloc((CHECKSUM_SIZE * 2) + 1, GFP_KERNEL);
+	if (!hstr)
+		return -ENOMEM;
+
+	hptr = hstr;
+	for (i = 0; i < CHECKSUM_SIZE; i++)
+		hptr += sprintf(hptr, "%02x", hash[i]);
+
+	written = sysfs_emit(buf, "%s\n", hstr);
+
+out_free:
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
2.40.0

