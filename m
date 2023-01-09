Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53E6622F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjAIKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbjAIKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:16:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CDF109B;
        Mon,  9 Jan 2023 02:15:34 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3097gBjm023783;
        Mon, 9 Jan 2023 10:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kRaoQJK8KYop87jY7BEaLbrpAp5gCNOfrxBZWKBW1wQ=;
 b=YRsE0JsvDTObxQbpu4/l8+3JM+lMKsdiZenrIrp2MpkCjsyuiSGjfcxGBSgWB0NiCJfJ
 d92bvwvaDFSFtcgx9opyuejmkegFl0BKtM1beGX47Tmb7yjnMtaEWhbf3XAfAhTkzfIq
 XUbNIeCmAcHR+I6ZTA8jx8YohtZS95BfRR0WN28RNchezBVp5BEmge7wirOZ6K9CIX1O
 gEpbVT1/vomEq1HVRm6iv5xzlI6vqOe1FjOp1snWtCzt9KlV7lIamvJn4nz8ybTsAEPf
 DjXFo7Mi8eBIBByeFykMQvSjcDWt9aD39F5HyEVvDnfoaqHrbwP3LJBvBZQXpnI5FSR/ AQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxx3w30jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 10:15:20 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309AFJ6M030984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 10:15:19 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 02:15:15 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V0 1/1] soc: qcom: dcc: Add QAD, Cti-trigger and Bootconfig support for DCC
Date:   Mon, 9 Jan 2023 15:43:44 +0530
Message-ID: <8337e5672559b197a13699d2c0ee69f18f6167a6.1673247689.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1673247689.git.quic_schowdhu@quicinc.com>
References: <cover.1673247689.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tttclr8vNc1xdB0ech5nCzP1h5QIcwTb
X-Proofpoint-GUID: tttclr8vNc1xdB0ech5nCzP1h5QIcwTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301090071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QAD, ctitrigger and bootconfig support for dcc driver.
The QAD is used for access control of the DCC configurations
and can be set or unset by writing to DCC_QAD_OUTPUT register.
The Cti-trigger is used for the cross trigger interface, on
enabling it the software trigger can be initiated for dcc by
setting the cti-trigout.
Bootconfig support for DCC is for configuring register values
to dcc at boot time, this is needed for debugging crashes that
happen at boot time.
Add the debugfs files QAD and CTI-trigger for each list folder.
Also add hwtrigger debugfs file which needs to be disabled on
enabling the cti-trigger.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
 drivers/soc/qcom/dcc.c                       | 281 ++++++++++++++++++++++++++-
 2 files changed, 301 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index 27ed591..f817a9f 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -125,3 +125,27 @@ Description:
 		on manual or crash induced triggers. Lists must
 		be configured and enabled sequentially, e.g. list
 		2 can only be enabled when list 1 have so.
+
+What:		/sys/kernel/debug/dcc/.../[list-number]/ctitrigger
+Date:		January 2023
+Contact:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This debugfs interface is used for enabling the
+		ctitrigger. Ctitrigger can be enabled by writing
+		a '1' to the file.
+
+What:		/sys/kernel/debug/dcc/.../[list-number]/QAD
+Date:          January 2023
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This debugfs interface is used for enabling the
+		ctitrigger. Ctitrigger can be enabled by writing
+		a '1' to the file.
+
+What:          /sys/kernel/debug/dcc/.../[list-number]/hwtrigger
+Date:	        January 2023
+Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+	        This debugfs interface is used for enabling the
+	        hwtrigger support. Hwtrigger can be enabled by
+	        writing a '1' to the file.
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index 5b50d63..e3d2710 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -6,6 +6,7 @@

 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bootconfig.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
@@ -36,6 +37,8 @@
 #define DCC_LL_INT_STATUS		0x1c
 #define DCC_LL_SW_TRIGGER		0x2c
 #define DCC_LL_BUS_ACCESS_STATUS	0x30
+#define DCC_CTI_TRIG                    0x34
+#define DCC_QAD_OUTPUT                  0x38

 /* Default value used if a bit 6 in the HW_INFO register is set. */
 #define DCC_FIX_LOOP_OFFSET		16
@@ -131,6 +134,9 @@ struct dcc_drvdata {
 	size_t			nr_link_list;
 	u8			loop_shift;
 	unsigned long		*enable_bitmap;
+	unsigned long		*cti_bitmap;
+	unsigned long           *qad_bitmap;
+	unsigned long           *hwtrig_bitmap;
 };

 struct dcc_cfg_attr {
@@ -148,6 +154,18 @@ struct dcc_cfg_loop_attr {
 	bool	loop_start;
 };

+char *replace_char(char *str, char find, char replace)
+{
+	char *current_pos = strchr(str, find);
+
+	while (current_pos) {
+		*current_pos = replace;
+		current_pos = strchr(current_pos, find);
+	}
+
+	return str;
+}
+
 static inline u32 dcc_list_offset(int version)
 {
 	return version == 1 ? 0x1c : version == 2 ? 0x2c : 0x34;
@@ -201,6 +219,10 @@ static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
 			continue;
 		ll_cfg = dcc_list_readl(drvdata, i, DCC_LL_CFG);
 		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		if (drvdata->mem_map_ver != 3)
+			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		else
+			tmp_ll_cfg = ll_cfg & ~BIT(8);
 		dcc_list_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
 		dcc_list_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
 		dcc_list_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
@@ -577,6 +599,25 @@ static int dcc_enable(struct dcc_drvdata *drvdata, unsigned int curr_list)
 	/* 5. Configure trigger */
 	dcc_list_writel(drvdata, DCC_TRIGGER_MASK,
 			curr_list, DCC_LL_CFG);
+	if (drvdata->mem_map_ver == 3) {
+		dcc_list_writel(drvdata, test_bit(curr_list, drvdata->qad_bitmap), curr_list,
+				DCC_QAD_OUTPUT);
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
@@ -1103,6 +1144,168 @@ static const struct file_operations config_fops = {
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
+	int ret = 0, curr_list;
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
+		return 0;
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
+static ssize_t qad_read(struct file *filp, char __user *userbuf,
+			size_t count, loff_t *ppos)
+{
+	char *buf;
+	int curr_list;
+
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	mutex_lock(&drvdata->mutex);
+
+	if (test_bit(curr_list, drvdata->qad_bitmap))
+		buf = "Y\n";
+	else
+		buf = "N\n";
+
+	mutex_unlock(&drvdata->mutex);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t qad_write(struct file *filp, const char __user *userbuf,
+			 size_t count, loff_t *ppos)
+{
+	int ret = 0, curr_list;
+	bool val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+
+	if (drvdata->mem_map_ver != 3) {
+		dev_err(drvdata->dev, "QAD is not supported\n");
+		return -EINVAL;
+	}
+
+	if (test_bit(curr_list, drvdata->enable_bitmap))
+		return -EBUSY;
+
+	ret = kstrtobool_from_user(userbuf, count, &val);
+	if (ret < 0)
+		return 0;
+
+	if (val)
+		set_bit(curr_list, drvdata->qad_bitmap);
+	else
+		clear_bit(curr_list, drvdata->qad_bitmap);
+
+	return count;
+}
+
+static const struct file_operations qad_fops = {
+	.read = qad_read,
+	.write = qad_write,
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
+	int ret = 0, curr_list;
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
@@ -1126,6 +1329,9 @@ static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
 		list = debugfs_create_dir(list_num, drvdata->dbg_dir);
 		debugfs_create_file("enable", 0600, list, drvdata, &enable_fops);
 		debugfs_create_file("config", 0600, list, drvdata, &config_fops);
+		debugfs_create_file("ctitrigger", 0600, list, drvdata, &ctitrigger_fops);
+		debugfs_create_file("QAD", 0600, list, drvdata, &qad_fops);
+		debugfs_create_file("hwtrigger", 0600, list, drvdata, &hwtrigger_fops);
 	}

 	debugfs_create_file("trigger", 0200, drvdata->dbg_dir, drvdata, &trigger_fops);
@@ -1185,13 +1391,60 @@ static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
 	misc_deregister(&drvdata->sram_dev);
 }

-static int dcc_probe(struct platform_device *pdev)
+static int __init dcc_bootconfig_parse(struct dcc_drvdata *drvdata, struct  xbc_node  *dcc_node)
+{
+	struct xbc_node *linked_list, *node;
+	int curr_list, ret;
+	const char *p;
+	char *input, *token;
+	char val[30];
+
+	xbc_node_for_each_subkey(dcc_node, linked_list) {
+		p = xbc_node_find_value(linked_list, "qcom-curr-link-list", &node);
+		if (p) {
+			ret = kstrtoint(p, 0, &curr_list);
+			if (ret)
+				return ret;
+		}
+
+		p = xbc_node_find_value(linked_list, "qcom-link-list", &node);
+		if (!p)
+			continue;
+
+		xbc_array_for_each_value(node, p) {
+			snprintf(val, sizeof(val), "%s", p);
+			input = replace_char(val, '_', ' ');
+			token = strsep(&input, " ");
+
+			if (!strcmp("R", token)) {
+				ret = dcc_config_add_read(drvdata, input, curr_list);
+			} else if (!strcmp("W", token)) {
+				ret = dcc_config_add_write(drvdata, input, curr_list);
+			} else if (!strcmp("RW", token)) {
+				ret = dcc_config_add_read_write(drvdata, input, curr_list);
+			} else if (!strcmp("L", token)) {
+				ret = dcc_config_add_loop(drvdata, input, curr_list);
+			} else {
+				dev_err(drvdata->dev, "%s is not a correct input\n", token);
+				return -EINVAL;
+			}
+			if (ret)
+				return ret;
+		}
+		dcc_enable(drvdata, curr_list);
+	}
+
+	return 0;
+}
+
+static int __init dcc_probe(struct platform_device *pdev)
 {
 	u32 val;
 	int ret = 0, i;
 	struct device *dev = &pdev->dev;
 	struct dcc_drvdata *drvdata;
 	struct resource *res;
+	struct xbc_node *dcc_node;

 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1247,13 +1500,30 @@ static int dcc_probe(struct platform_device *pdev)
 	if (!drvdata->enable_bitmap)
 		return -ENOMEM;

+	drvdata->cti_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(drvdata->nr_link_list),
+					   sizeof(*drvdata->cti_bitmap), GFP_KERNEL);
+	if (!drvdata->cti_bitmap)
+		return -ENOMEM;
+
+	drvdata->qad_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(drvdata->nr_link_list),
+					   sizeof(*drvdata->qad_bitmap), GFP_KERNEL);
+	if (!drvdata->qad_bitmap)
+		return -ENOMEM;
+
+	drvdata->hwtrig_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(drvdata->nr_link_list),
+					      sizeof(*drvdata->hwtrig_bitmap), GFP_KERNEL);
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
@@ -1263,6 +1533,10 @@ static int dcc_probe(struct platform_device *pdev)

 	dcc_create_debug_dir(drvdata);

+	dcc_node = xbc_find_node("dcc_config");
+	if (dcc_node)
+		return dcc_bootconfig_parse(drvdata, dcc_node);
+
 	return 0;
 }

@@ -1287,14 +1561,13 @@ static const struct of_device_id dcc_match_table[] = {
 MODULE_DEVICE_TABLE(of, dcc_match_table);

 static struct platform_driver dcc_driver = {
-	.probe = dcc_probe,
 	.remove	= dcc_remove,
 	.driver	= {
 		.name = "qcom-dcc",
 		.of_match_table	= dcc_match_table,
 	},
 };
-module_platform_driver(dcc_driver);
+module_platform_driver_probe(dcc_driver, dcc_probe);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
--
2.7.4

