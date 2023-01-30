Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F168057D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjA3FPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjA3FOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:14:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF223C68;
        Sun, 29 Jan 2023 21:14:47 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U5Ec03016191;
        Mon, 30 Jan 2023 05:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RB1IZ0eslA08J5XuZcIGmlS0kK2WBJ8M8zae1EMsJZM=;
 b=cmwE5Rm8zt0IYXk6GtsFVjgaDgY+7fYFUYqk9KrkWOsK9HV8rabSUxjiXqQRr0zxHCUW
 ndY8dBxwn1DcYijtIzuYUuqTEfqPkxAUnquPlGlPXoLhhBA3pkz9bUtl2LEspzoaw5pA
 CrcPkEP3zgY7o2ZxbFOXBgJXTZ4LwpWxTRAdgUyWqkfvJKpS/IKpcHqw0dZI/9mtDTZR
 bIinVDk+4gPWooT4VMqQBCCMY4oaIZM+15PTAeOdkE6Y7MdzY1MkKK86LGTkYfTpxwxB
 WjjlupYN+gwN4O4ZqogMs9P1gPbtL/pbkNQlSu/cLAeLzbaYSEKzoHR0gdavUKpdTQXb ZA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnyjvbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U5EbJi004492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:37 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 21:14:33 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Alex Elder" <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 2/3] soc: qcom: dcc: Add CTI-trigger support for DCC
Date:   Mon, 30 Jan 2023 10:43:56 +0530
Message-ID: <79ca9bbfb988445fda98ec23f4a63c562b07d04b.1675054375.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1675054375.git.quic_schowdhu@quicinc.com>
References: <cover.1675054375.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H8EoiKRx_WcQh0teTfqygA8g0k0BjFFg
X-Proofpoint-ORIG-GUID: H8EoiKRx_WcQh0teTfqygA8g0k0BjFFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTI trigger is used to enable the Cross trigger interface for DCC.
On enabling CTI trigger the dcc software trigger can be done by
writing to CTI trig-out. Add the debugfs file ctitrigger which
gives the user option to enable ctitrigger for a list. Also add
hwtrigger debugfs file which needs to be disabled on enabling
the CTI-trigger. Hwtrigger needs to be disabled for components
to be able to write to cti-trigout.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc |  16 +++
 drivers/soc/qcom/dcc.c                       | 148 ++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index 27ed591..6f5d965 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -125,3 +125,19 @@ Description:
 		on manual or crash induced triggers. Lists must
 		be configured and enabled sequentially, e.g. list
 		2 can only be enabled when list 1 have so.
+
+What:           /sys/kernel/debug/dcc/.../[list-number]/ctitrigger
+Date:           January 2023
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+	        This debugfs interface is used for enabling the
+	        ctitrigger. Ctitrigger can be enabled by writing
+	        a '1' to the file.
+
+What:	        /sys/kernel/debug/dcc/.../[list-number]/hwtrigger
+Date:           January 2023
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+	        This debugfs interface is used for enabling the
+	        hwtrigger. Hwtrigger can be enabled by writing
+		a '1' to the file.
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index 93e8f86..a75b9af 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -37,6 +37,7 @@
 #define DCC_LL_INT_STATUS		0x1c
 #define DCC_LL_SW_TRIGGER		0x2c
 #define DCC_LL_BUS_ACCESS_STATUS	0x30
+#define DCC_CTI_TRIG			0x34
 
 /* Default value used if a bit 6 in the HW_INFO register is set. */
 #define DCC_FIX_LOOP_OFFSET		16
@@ -115,6 +116,8 @@ struct dcc_config_entry {
  * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
  * @loop_shift:	Loop offset bits range for the addresses
  * @enable_bitmap:	Bitmap to capture the enabled status of each linked list of addresses
+ * @cti_bitmap:		Bitmap to capture the cti-trigger status of each linked list of addresses
+ * @hwtrig_bitmap:	Bitmap to capture the hwtrig status of each linked list of addresses
  */
 struct dcc_drvdata {
 	void __iomem		*base;
@@ -132,6 +135,8 @@ struct dcc_drvdata {
 	size_t			nr_link_list;
 	u8			loop_shift;
 	unsigned long		*enable_bitmap;
+	unsigned long		*cti_bitmap;
+	unsigned long		*hwtrig_bitmap;
 };
 
 struct dcc_cfg_attr {
@@ -213,7 +218,10 @@ static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
 		if (!test_bit(i, drvdata->enable_bitmap))
 			continue;
 		ll_cfg = dcc_list_readl(drvdata, i, DCC_LL_CFG);
-		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		if (drvdata->mem_map_ver != 3)
+			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		else
+			tmp_ll_cfg = ll_cfg & ~BIT(8);
 		dcc_list_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
 		dcc_list_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
 		dcc_list_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
@@ -590,6 +598,23 @@ static int dcc_enable(struct dcc_drvdata *drvdata, unsigned int curr_list)
 	/* 5. Configure trigger */
 	dcc_list_writel(drvdata, DCC_TRIGGER_MASK,
 			curr_list, DCC_LL_CFG);
+	if (drvdata->mem_map_ver == 3) {
+		dcc_list_writel(drvdata, test_bit(curr_list, drvdata->cti_bitmap), curr_list,
+				DCC_CTI_TRIG);
+		if (test_bit(curr_list, drvdata->hwtrig_bitmap))
+			dcc_list_writel(drvdata, BIT(8), curr_list, DCC_LL_CFG);
+		else
+			dcc_list_writel(drvdata, (unsigned int)~BIT(8), curr_list, DCC_LL_CFG);
+	} else {
+		if (test_bit(curr_list, drvdata->hwtrig_bitmap))
+			dcc_list_writel(drvdata, DCC_TRIGGER_MASK |
+					test_bit(curr_list, drvdata->cti_bitmap) << 8,
+					curr_list, DCC_LL_CFG);
+		else
+			dcc_list_writel(drvdata, ~DCC_TRIGGER_MASK &
+					test_bit(curr_list, drvdata->cti_bitmap) << 8,
+					curr_list, DCC_LL_CFG);
+	}
 
 out_unlock:
 	mutex_unlock(&drvdata->mutex);
@@ -1116,6 +1141,110 @@ static const struct file_operations config_fops = {
 	.release = single_release,
 };
 
+static ssize_t ctitrigger_read(struct file *filp, char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	char *buf;
+	int curr_list;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	mutex_lock(&drvdata->mutex);
+
+	if (test_bit(curr_list, drvdata->cti_bitmap))
+		buf = "Y\n";
+	else
+		buf = "N\n";
+
+	mutex_unlock(&drvdata->mutex);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t ctitrigger_write(struct file *filp, const char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	int ret, curr_list;
+	bool val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	if (test_bit(curr_list, drvdata->enable_bitmap))
+		return -EBUSY;
+
+	ret = kstrtobool_from_user(userbuf, count, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		set_bit(curr_list, drvdata->cti_bitmap);
+	else
+		clear_bit(curr_list, drvdata->cti_bitmap);
+
+	return count;
+}
+
+static const struct file_operations ctitrigger_fops = {
+	.read = ctitrigger_read,
+	.write = ctitrigger_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t hwtrigger_read(struct file *filp, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	char *buf;
+	int curr_list;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	mutex_lock(&drvdata->mutex);
+
+	if (test_bit(curr_list, drvdata->hwtrig_bitmap))
+		buf = "Y\n";
+	else
+		buf = "N\n";
+
+	mutex_unlock(&drvdata->mutex);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t hwtrigger_write(struct file *filp, const char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	int ret, curr_list;
+	bool val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	if (test_bit(curr_list, drvdata->enable_bitmap))
+		return -EBUSY;
+
+	ret = kstrtobool_from_user(userbuf, count, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		set_bit(curr_list, drvdata->hwtrig_bitmap);
+	else
+		clear_bit(curr_list, drvdata->hwtrig_bitmap);
+
+	return count;
+}
+
+static const struct file_operations hwtrigger_fops = {
+	.read = hwtrigger_read,
+	.write = hwtrigger_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
 static void dcc_delete_debug_dir(struct dcc_drvdata *drvdata)
 {
 	 debugfs_remove_recursive(drvdata->dbg_dir);
@@ -1145,6 +1274,8 @@ static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
 	debugfs_create_file("ready", 0400, drvdata->dbg_dir, drvdata, &ready_fops);
 	debugfs_create_file("config_reset", 0200, drvdata->dbg_dir,
 			    drvdata, &config_reset_fops);
+	debugfs_create_file("ctitrigger", 0600, list, drvdata, &ctitrigger_fops);
+	debugfs_create_file("hwtrigger", 0600, list, drvdata, &hwtrigger_fops);
 }
 
 static ssize_t dcc_sram_read(struct file *file, char __user *data,
@@ -1304,18 +1435,27 @@ static int __init dcc_probe(struct platform_device *pdev)
 
 	mutex_init(&drvdata->mutex);
 
-	drvdata->enable_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(drvdata->nr_link_list),
-					      sizeof(*drvdata->enable_bitmap), GFP_KERNEL);
+	drvdata->enable_bitmap = devm_bitmap_alloc(dev, drvdata->nr_link_list, GFP_KERNEL);
 	if (!drvdata->enable_bitmap)
 		return -ENOMEM;
 
+	drvdata->cti_bitmap = devm_bitmap_alloc(dev, drvdata->nr_link_list, GFP_KERNEL);
+	if (!drvdata->cti_bitmap)
+		return -ENOMEM;
+
+	drvdata->hwtrig_bitmap = devm_bitmap_alloc(dev, drvdata->nr_link_list, GFP_KERNEL);
+	if (!drvdata->hwtrig_bitmap)
+		return -ENOMEM;
+
 	drvdata->cfg_head = devm_kcalloc(dev, drvdata->nr_link_list,
 					 sizeof(*drvdata->cfg_head), GFP_KERNEL);
 	if (!drvdata->cfg_head)
 		return -ENOMEM;
 
-	for (i = 0; i < drvdata->nr_link_list; i++)
+	for (i = 0; i < drvdata->nr_link_list; i++) {
 		INIT_LIST_HEAD(&drvdata->cfg_head[i]);
+		set_bit(i, drvdata->hwtrig_bitmap);
+	}
 
 	ret = dcc_sram_dev_init(drvdata);
 	if (ret) {
-- 
2.7.4

