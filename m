Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44B68057E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjA3FPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjA3FOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:14:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9721943;
        Sun, 29 Jan 2023 21:14:50 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U3dHmx016328;
        Mon, 30 Jan 2023 05:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=k65g+eExnJdy0tTXGuv1aap79ovZjuYjX4MIDwcI82Q=;
 b=j/KRmJmqv1gi0WpPQObh0xCsx9pBovsbexGF8y8IyUriFyXsL5tPfmqopLXLbm2CUaoR
 s34SpKUQk+azZObA4+lMqNqxDRNVu9Kx31aZntizCh+jRW0osBO5XnBDbjNto+lhgfXZ
 EufzTTmJaFdiyRtE+4FN7vdNhqC4DzUQtQiYn5RdkyYLVYZXmcK/Kxu4mT1UecclhYsv
 zZVfiMXZZZScrEwtIq9KshbZJjp9knqrnQMygwLEUPL2Bz5lKEVVRPaaYgBWuDnHPYhL
 uLXFvBjixE2oLa9C9AiaNL0UQzpDhNiVP78AWuXXoDHFMTz7F+cyyHCiA7JwgvU0ZBp5 /w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdptyr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U5Efs7004535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:41 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 21:14:37 -0800
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
Subject: [PATCH V3 3/3] soc: qcom: dcc: Add QAD support for DCC
Date:   Mon, 30 Jan 2023 10:43:57 +0530
Message-ID: <8d9de5e2089b7fc0245a56f5457b443d2042977f.1675054375.git.quic_schowdhu@quicinc.com>
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
X-Proofpoint-GUID: 7BFsqGLBFBxm9X8uM7BZ6-w1mRHYVcXG
X-Proofpoint-ORIG-GUID: 7BFsqGLBFBxm9X8uM7BZ6-w1mRHYVcXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QAD debugfs file for DCC which can be used to enable/disable
the QAD for a list. QAD is used to specify the access control
for DCC configurations, on enabling it the access control to
dcc configuration space is restricted. On setting the QAD value,
the list gets locked out for a particular component and cannot
be used by the rest.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc |  8 ++++
 drivers/soc/qcom/dcc.c                       | 68 ++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
index 6f5d965..a3c4657 100644
--- a/Documentation/ABI/testing/debugfs-driver-dcc
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -141,3 +141,11 @@ Description:
 	        This debugfs interface is used for enabling the
 	        hwtrigger. Hwtrigger can be enabled by writing
 		a '1' to the file.
+
+What:           /sys/kernel/debug/dcc/.../[list-number]/QAD
+Date:           January 2023
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This debugfs interface is used for enabling the
+		QAD. QAD can be enabled by writing a '1' to the
+		file.
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index a75b9af..eeeaa8b 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -38,6 +38,7 @@
 #define DCC_LL_SW_TRIGGER		0x2c
 #define DCC_LL_BUS_ACCESS_STATUS	0x30
 #define DCC_CTI_TRIG			0x34
+#define DCC_QAD_OUTPUT                  0x38
 
 /* Default value used if a bit 6 in the HW_INFO register is set. */
 #define DCC_FIX_LOOP_OFFSET		16
@@ -118,6 +119,7 @@ struct dcc_config_entry {
  * @enable_bitmap:	Bitmap to capture the enabled status of each linked list of addresses
  * @cti_bitmap:		Bitmap to capture the cti-trigger status of each linked list of addresses
  * @hwtrig_bitmap:	Bitmap to capture the hwtrig status of each linked list of addresses
+ * @qad_bitmap:		Bitmap to capture the qad status of each linked list of addresses
  */
 struct dcc_drvdata {
 	void __iomem		*base;
@@ -137,6 +139,7 @@ struct dcc_drvdata {
 	unsigned long		*enable_bitmap;
 	unsigned long		*cti_bitmap;
 	unsigned long		*hwtrig_bitmap;
+	unsigned long           *qad_bitmap;
 };
 
 struct dcc_cfg_attr {
@@ -599,6 +602,8 @@ static int dcc_enable(struct dcc_drvdata *drvdata, unsigned int curr_list)
 	dcc_list_writel(drvdata, DCC_TRIGGER_MASK,
 			curr_list, DCC_LL_CFG);
 	if (drvdata->mem_map_ver == 3) {
+		dcc_list_writel(drvdata, test_bit(curr_list, drvdata->qad_bitmap), curr_list,
+				DCC_QAD_OUTPUT);
 		dcc_list_writel(drvdata, test_bit(curr_list, drvdata->cti_bitmap), curr_list,
 				DCC_CTI_TRIG);
 		if (test_bit(curr_list, drvdata->hwtrig_bitmap))
@@ -1245,6 +1250,64 @@ static const struct file_operations hwtrigger_fops = {
 	.llseek = generic_file_llseek,
 };
 
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
+	int ret, curr_list;
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
+		return ret;
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
 static void dcc_delete_debug_dir(struct dcc_drvdata *drvdata)
 {
 	 debugfs_remove_recursive(drvdata->dbg_dir);
@@ -1276,6 +1339,7 @@ static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
 			    drvdata, &config_reset_fops);
 	debugfs_create_file("ctitrigger", 0600, list, drvdata, &ctitrigger_fops);
 	debugfs_create_file("hwtrigger", 0600, list, drvdata, &hwtrigger_fops);
+	debugfs_create_file("QAD", 0600, list, drvdata, &qad_fops);
 }
 
 static ssize_t dcc_sram_read(struct file *file, char __user *data,
@@ -1447,6 +1511,10 @@ static int __init dcc_probe(struct platform_device *pdev)
 	if (!drvdata->hwtrig_bitmap)
 		return -ENOMEM;
 
+	drvdata->qad_bitmap = devm_bitmap_alloc(dev, drvdata->nr_link_list, GFP_KERNEL);
+	if (!drvdata->qad_bitmap)
+		return -ENOMEM;
+
 	drvdata->cfg_head = devm_kcalloc(dev, drvdata->nr_link_list,
 					 sizeof(*drvdata->cfg_head), GFP_KERNEL);
 	if (!drvdata->cfg_head)
-- 
2.7.4

