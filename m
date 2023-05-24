Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280270FD99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjEXSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEXSQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:16:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1EE7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2TXowfxjGShoZLyM6WjPLOEMAxrL5f/4iOUbXoLIKtrde0VCqrRwshzrJuV7TCD4vL2a+JkvblpD12LuPLhO+WBmzSl4OXJ3MCjdE6DR9olPtBmOjA+v8sIhsQSOIB/qMvmYxplseDe3r1U1zFu3MrWQ69bYzdUzJCDRKtvRo4n8t0vwhEoFfAbOYeuFHf13FXphg4bCuRTA+EFUzzokt9MJSSyAfhbAAOXTwQty+xep6VpE7YnOMKvUb7IS+ahdctzloquvtb1egD6Uv6KdzjJYhyzJB8DDWqUAfYl6KM/LyDw57bqsteQRJpZMfY9NlsJREJuFdGcJHwgFNPjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9LLygHBGw6El97yTSnfTaV+qP3PU664dUqOIowiLFo=;
 b=kg45Ym1Kz6OJGx2PqDKWgOB4CuOpyqxLWS26NyCdswctnL57rwQMkybIMdj2lv7jT0V1CanbTPBpmRSO3/4RhVIokMFttF2qZ9ZnBniTL4t0e6Qq4vheOPWJkYtChy8DBe+jDILUC6jXKxOgaFfGRoKBuwDWCzQjq1xP4L8q7qfWL0WXQjrG/c3l/1HEiYLax9+2D0fw0Hv/WBOzNiFOGAOl+KUsx0ZXtcu081N4cDYFmcVpItdK33xX5CIiM3CqFqxc38m0MMPAqZFdkI3D8ZRTe4Y3Unb4jbXgaCcm9lqzwxj6MhMR7sOkoAYuhTwxSZfIV62BBy1jTu0IPqvDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9LLygHBGw6El97yTSnfTaV+qP3PU664dUqOIowiLFo=;
 b=eztom3GxF3bUhNYI8Z9lEHuX1OAiCtF9Eld0YHXCOOrU6VeqgQRwfxjmjpSZUc8OxU2gNBbI7v8lZ8oT7NSfiR3X1fzxeqWWnbfdcPuPdlRvJi36igWhLsfnb/HzXx1r4bT4aMVk0ZY4o2j/fGvXHWXsRJopuc8Xq8UNKE//ong=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 18:16:24 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::82) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 18:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 18:16:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 13:16:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 13:16:22 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 24 May 2023 13:16:21 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>,
        <gregkh@linuxfoundation.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v2] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Date:   Wed, 24 May 2023 23:46:13 +0530
Message-ID: <20230524181613.5351-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd9e798-c8ba-4c5a-6f42-08db5c82fbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMrKldXdJbCB2U2p7NMEbatvpFnhPripQ8IvKYW9hBQ20u1Ptkq4nMNvhV3oLJPR+APZCcpgS/jzpSFrZeSumNGMZOxp42MDDo2bkBLsuP71v+NAZjKNJYZRoSezaIHJTSRH3e/hTakqYirJsmh9xa646nRCuvdlrVdtrjGkM46oggknmiJBcPKKWWZdx/mEXa8GZfNmRvQ8vhmKdQ/WdTrWJciu8LXse427oXscj0vYto4luewWtIw54UJzMtNbRiwuhOONtjWny42xu5SqElLNOvFBxToTJUokHIi0Vc/NDwVW8U+MXIB56EsmSX3TnjCSizXapDkk+J2lhZ0VdjmsMMudAxxljzLCxP3yO8sfQx7SYLHy1AvUWQw4OKAFP1tPD4d2qoSu+ZePOESsoRQQVFnCzuR4zpB8oqXgCOzgFQRBynY6/vIkmn2G0jfbVoDuJD5OpBEIaFF2r+EsySrUj3YfJeHWs1NZn3zYq3r6h4ijvVSDI1Sz0NgvzEo6tZtRb3KQ9tE3rMP6c6MPHaCcRVPavzhbx8vqwJlH7dFzWXBiu005HIdaSSShpxK6puqoRr7Q344Wrg1OKSaPdkvBX6ubaEaSHQWKqyfBRu2aklrB3bnCfj6sINDnUpnOMZg8O+aKPJiinDCDAX/YS4dibk+5BfX/5NLO+NLwJiMXDVFkvM3B1tfKSVgghQ9lm7uixM5miiawJ4JBq4hKVbo5fEzXBVaTMeqwaxc4RXBawv0ZYCbjUVD3neGR6Fmf3iVSGuO9AR1ZFm8r2AFvZR0Bte3UAAZUUp9cG+HTEKIaDKCEtZvKkhTZxjqdu62H
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(41300700001)(478600001)(110136005)(316002)(4326008)(70586007)(6666004)(70206006)(86362001)(5660300002)(8676002)(8936002)(44832011)(2906002)(81166007)(26005)(40460700003)(356005)(82740400003)(186003)(1076003)(426003)(83380400001)(336012)(40480700001)(2616005)(36756003)(36860700001)(47076005)(36900700001)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:16:24.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd9e798-c8ba-4c5a-6f42-08db5c82fbd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCDI_LOGGING is too generic considering other MCDI users
SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
CDX_MCDI_LOGGING makes it more domain specific.

Also, Move CONFIG_CDX_MCDI_LOGGING to header file
and make logging variable as a configurable sysfs parameter.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Changes v1->v2:
- Moved CONFIG_CDX_MCDI_LOGGING flag to header file
- Added sysfs entry to enable/disable mcdi logging

 drivers/cdx/controller/Kconfig          |  2 +-
 drivers/cdx/controller/cdx_controller.c | 21 ++++++++++++
 drivers/cdx/controller/mcdi.c           | 45 ++++++++++++-------------
 drivers/cdx/controller/mcdi.h           |  8 +++--
 4 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index c3e3b9ff8dfe..e7014e9819ea 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -18,7 +18,7 @@ config CDX_CONTROLLER
 
 	  If unsure, say N.
 
-config MCDI_LOGGING
+config CDX_MCDI_LOGGING
 	bool "MCDI Logging for the CDX controller"
 	depends on CDX_CONTROLLER
 	help
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..e5b1a2c01b87 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -124,6 +124,23 @@ static struct cdx_ops cdx_ops = {
 	.dev_configure	= cdx_configure_device,
 };
 
+static ssize_t mcdi_logging_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct cdx_controller *cdx = dev_get_drvdata(dev);
+	bool enable;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	if (cdx_enable_mcdi_logging(cdx->priv, enable))
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(mcdi_logging);
+
 static int xlnx_cdx_probe(struct platform_device *pdev)
 {
 	struct cdx_controller *cdx;
@@ -154,6 +171,9 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->priv = cdx_mcdi;
 	cdx->ops = &cdx_ops;
 
+	if (device_create_file(&pdev->dev, &dev_attr_mcdi_logging))
+		dev_warn(&pdev->dev, "Failed to create sysfs file\n");
+
 	ret = cdx_setup_rpmsg(pdev);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
@@ -181,6 +201,7 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
 	cdx_destroy_rpmsg(pdev);
 
+	device_remove_file(&pdev->dev, &dev_attr_mcdi_logging);
 	kfree(cdx);
 
 	cdx_mcdi_finish(cdx_mcdi);
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index a211a2ca762e..9afea22c38ee 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -31,9 +31,7 @@ struct cdx_mcdi_copy_buffer {
 	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
 };
 
-#ifdef CONFIG_MCDI_LOGGING
 #define LOG_LINE_MAX		(1024 - 32)
-#endif
 
 static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
 static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
@@ -118,12 +116,12 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 
 	mcdi = cdx_mcdi_if(cdx);
 	mcdi->cdx = cdx;
+	mcdi->logging_enabled = !!CDX_MCDI_LOGGING;
 
-#ifdef CONFIG_MCDI_LOGGING
 	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
 	if (!mcdi->logging_buffer)
 		goto fail2;
-#endif
+
 	mcdi->workqueue = alloc_ordered_workqueue("mcdi_wq", 0);
 	if (!mcdi->workqueue)
 		goto fail3;
@@ -136,10 +134,8 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 
 	return 0;
 fail3:
-#ifdef CONFIG_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
 fail2:
-#endif
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
 fail:
@@ -155,16 +151,25 @@ void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 		return;
 
 	cdx_mcdi_wait_for_cleanup(cdx);
-
-#ifdef CONFIG_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
-#endif
 
 	destroy_workqueue(mcdi->workqueue);
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
 }
 
+int cdx_enable_mcdi_logging(struct cdx_mcdi *cdx, bool enable)
+{
+	struct cdx_mcdi_iface *mcdi;
+
+	mcdi = cdx_mcdi_if(cdx);
+	if (!mcdi)
+		return -EINVAL;
+
+	mcdi->logging_enabled = enable;
+	return 0;
+}
+
 static bool cdx_mcdi_flushed(struct cdx_mcdi_iface *mcdi, bool ignore_cleanups)
 {
 	bool flushed;
@@ -246,15 +251,9 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 	size_t hdr_len;
 	bool not_epoch;
 	u32 xflags;
-#ifdef CONFIG_MCDI_LOGGING
-	char *buf;
-#endif
 
 	if (!mcdi)
 		return;
-#ifdef CONFIG_MCDI_LOGGING
-	buf = mcdi->logging_buffer; /* page-sized */
-#endif
 
 	mcdi->prev_seq = cmd->seq;
 	mcdi->seq_held_by[cmd->seq] = cmd;
@@ -281,10 +280,10 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 			     MC_CMD_V2_EXTN_IN_MCDI_MESSAGE_TYPE_PLATFORM);
 	hdr_len = 8;
 
-#ifdef CONFIG_MCDI_LOGGING
-	if (!WARN_ON_ONCE(!buf)) {
+	if (mcdi->logging_enabled) {
 		const struct cdx_dword *frags[] = { hdr, inbuf };
 		const size_t frag_len[] = { hdr_len, round_up(inlen, 4) };
+		char *log = mcdi->logging_buffer;
 		int bytes = 0;
 		int i, j;
 
@@ -300,18 +299,18 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 				 * The string before that is just over 70 bytes.
 				 */
 				if ((bytes + 75) > LOG_LINE_MAX) {
-					pr_info("MCDI RPC REQ:%s \\\n", buf);
+					pr_info("MCDI RPC REQ:%s \\\n", log);
 					bytes = 0;
 				}
-				bytes += snprintf(buf + bytes,
+				bytes += snprintf(log + bytes,
 						  LOG_LINE_MAX - bytes, " %08x",
 						  le32_to_cpu(frag[i].cdx_u32));
 			}
 		}
 
-		pr_info("MCDI RPC REQ:%s\n", buf);
+		pr_info("MCDI RPC REQ:%s\n", log);
 	}
-#endif
+
 	hdr[0].cdx_u32 |= (__force __le32)(cdx_mcdi_payload_csum(hdr, hdr_len, inbuf, inlen) <<
 			 MCDI_HEADER_XFLAGS_LBN);
 	cdx->mcdi_ops->mcdi_request(cdx, hdr, hdr_len, inbuf, inlen);
@@ -700,8 +699,7 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 		resp_data_len = 0;
 	}
 
-#ifdef CONFIG_MCDI_LOGGING
-	if (!WARN_ON_ONCE(!mcdi->logging_buffer)) {
+	if (mcdi->logging_enabled) {
 		char *log = mcdi->logging_buffer;
 		int i, bytes = 0;
 		size_t rlen;
@@ -721,7 +719,6 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 
 		pr_info("MCDI RPC RESP:%s\n", log);
 	}
-#endif
 
 	if (error && resp_data_len == 0) {
 		/* MC rebooted during command */
diff --git a/drivers/cdx/controller/mcdi.h b/drivers/cdx/controller/mcdi.h
index 0bfbeab04e43..3a22c71e2f31 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/drivers/cdx/controller/mcdi.h
@@ -22,6 +22,11 @@
 #define CDX_WARN_ON_PARANOID(x) do {} while (0)
 #endif
 
+#ifdef CONFIG_CDX_MCDI_LOGGING
+#define CDX_MCDI_LOGGING	1
+#else
+#define CDX_MCDI_LOGGING	0
+#endif
 /**
  * enum cdx_mcdi_mode - MCDI transaction mode
  * @MCDI_MODE_EVENTS: wait for an mcdi response callback.
@@ -170,10 +175,8 @@ struct cdx_mcdi_iface {
 	enum cdx_mcdi_mode mode;
 	u8 prev_seq;
 	bool new_epoch;
-#ifdef CONFIG_MCDI_LOGGING
 	bool logging_enabled;
 	char *logging_buffer;
-#endif
 };
 
 /**
@@ -193,6 +196,7 @@ static inline struct cdx_mcdi_iface *cdx_mcdi_if(struct cdx_mcdi *cdx)
 
 int cdx_mcdi_init(struct cdx_mcdi *cdx);
 void cdx_mcdi_finish(struct cdx_mcdi *cdx);
+int cdx_enable_mcdi_logging(struct cdx_mcdi *cdx, bool enable);
 
 void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len);
 int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
-- 
2.25.1

