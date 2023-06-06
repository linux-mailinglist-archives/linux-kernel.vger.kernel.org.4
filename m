Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668D72452B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbjFFOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjFFOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:02:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693810C8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6XA4BZotAMrmfzajWi40Vsz0BBST4cgb/GNqL1RN171ww5dx3xNhv8TGLCbMIl9SlxAwst/LGRLrACuAZX9h8qyKw7/ASqKGPrVBukv+YET+FWanYK5liNMd/fE1pXVdZq99mIl64oRqb9OpAvX2wCQGJvCWpdCF0FPeTiGtjUhnS7cDA5v2eapS3cOSdDQzLCfcQLMeqVZuN6uSLPrkJtwY/Dpe1qRaOG0yXcWnXQhSVazKkSz/Slau7ICM6uFo5rGKiShSSV9FR2/o0sCkByDRuGia4bcCO9sv3fN4bsFgwo0v5Abiun2mujlL7+mBoeGBZkwwIkTxH+B2C/iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b5FhXGpaGNul65XGoeMFn/vzzd3c1hxdgchBGq/aUE=;
 b=aH9vNbtey/eJr39y5WHfyLRW2N7m0RIhbt64cWOToDoxYJYO5zPCZtxq1qnn3z6DnK2aftn+kkidFs/DqWosddFll0dhPm3oJ3/9ueqSbX8peayasIayN76ToXz0qCa/1UzLzofP3wy/Ptb38hIv0a6O96Bucg2EkFinbnZCB+bwNK+8u9SugJBuRjQRVsSVWSDpKXvVFSENdH24MkGc6OH63g5VhdugMkGLsuYzLTHaUWRfwd4insG52oljsoFWVStim3a/FHeVdgquVVEjNXgyVqT9f1BBhYfzbyx6WfVyZeewnDA6kth7IVdD0nljUPncuIb6BtIiSs7VxPsiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b5FhXGpaGNul65XGoeMFn/vzzd3c1hxdgchBGq/aUE=;
 b=SJLlVsTz2UgkkHEYLVEyJAXtLc0XLp40x/WMdbvbXu4l2HDN8nNVSqbYgkAyWkNGagnY/OuflyEo7dEueA3PYtMgecvZXHCyhu4UKyigsQCCC3h6r5UGF6sEua7yoKWUkaMSr8w+IRnW+jbVXLPVz2F+ilAbcJChwK0XsNOnDdc=
Received: from CY5PR13CA0052.namprd13.prod.outlook.com (2603:10b6:930:11::34)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Tue, 6 Jun
 2023 14:01:52 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::1a) by CY5PR13CA0052.outlook.office365.com
 (2603:10b6:930:11::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 14:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 14:01:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 09:01:49 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 6 Jun 2023 09:01:47 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>,
        <gregkh@linuxfoundation.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v3] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Date:   Tue, 6 Jun 2023 19:31:37 +0530
Message-ID: <20230606140137.1216731-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f567363-ef0d-4e57-4f86-08db6696941c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKGp9g/vD97w8fC+M1PwCMaG+k0CJV1JWuoknKPHdpWRXLJnLKYOzyXJ+jYxgLs7BFucfSyYVnEwn7Vv7kYKpbqxmr0bLwCx3s+I0Y0hNI0suVOqQkJRuLTmO3EV9qBbPZJBkc0OqJ1nd5+iMcSJsS5/IPagNDedoyroWgVSJtKMzHz/juFIWOUS0Oho7bSbBL/aBKAP2bfTDGAU47BBP8k78aRiztC0TfxAuSyRH3qYRDRuCeLZqdbpFim2zwjNivax5ANcj6doxKVWTqpHkr15ocMYiDMr0eHkClsaxk7sfICLw/238hfsj3QBnIPcaM/DWlNKOUphR6nzDGcJoNGFKRlFS+IiNsGBkbu5L5GnimX8Z17hzrdTzE+FIv0rI3r9HR2EbEzNW/XC8KcpMlYeQBfWd8SuD+dCf+A9mrkJjDg1dODfweNX5FI22ZucF3K4JIBlNqxGZuvrOQwX53c0xa7XYF274Aq3/NlzdL9NRI3oBvJVqr3TKm6v4biHcwLkyqhg8mlMJBRk5nXia7rF6xpqtValkTWnDSVhgMibHCBxQcVmvi/evCeS0f9LjAGSTVvlHCtjzGd/UJavW7gkTB2t3pclFkxs+nKRXe2dqb1L26d0N1zuxmd62soEZdrj9IvVMpszSlOFfaVNs8HnMyYg2xylzbJdXcHF4k4czMJ6FOKQr6uu6UO56wdmZE48FNfgSggxej9994/mhoY9vXwzK1Eizz56Cktvo1rHD8npakIFEzy5wo0krzJxUTUgiKHCOom0B0O297vPUaa28zJlKjLow/J3LUs6J7HV8bISch+4/Jncpbf0WCe9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2616005)(8936002)(966005)(8676002)(186003)(41300700001)(2906002)(5660300002)(26005)(44832011)(1076003)(47076005)(83380400001)(426003)(336012)(40480700001)(36860700001)(40460700003)(478600001)(110136005)(316002)(54906003)(6666004)(81166007)(356005)(82740400003)(82310400005)(86362001)(70586007)(36756003)(70206006)(4326008)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:01:51.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f567363-ef0d-4e57-4f86-08db6696941c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCDI_LOGGING is too generic considering other MCDI users
SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
CDX_MCDI_LOGGING makes it more domain specific.

Also, move CONFIG_CDX_MCDI_LOGGING to header file.

Fixes: eb96b740192b ("cdx: add MCDI protocol interface for firmware interaction")
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com/
---
 Changes v2->v3:
 - Dropped sysfs entry changes from v2

 Changes v1->v2:
 - Moved CONFIG_CDX_MCDI_LOGGING flag to header file
 - Added sysfs entry to enable/disable mcdi logging

 drivers/cdx/controller/Kconfig |  2 +-
 drivers/cdx/controller/mcdi.c  | 41 ++++++++++++----------------------
 drivers/cdx/controller/mcdi.h  |  7 ++++--
 3 files changed, 20 insertions(+), 30 deletions(-)

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
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index a211a2ca762e..5a2d1fd46478 100644
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
@@ -118,12 +116,14 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 
 	mcdi = cdx_mcdi_if(cdx);
 	mcdi->cdx = cdx;
+	mcdi->logging_enabled = !!CDX_MCDI_LOGGING;
+
+	if (mcdi->logging_enabled) {
+		mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
+		if (!mcdi->logging_buffer)
+			goto fail2;
+	}
 
-#ifdef CONFIG_MCDI_LOGGING
-	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
-	if (!mcdi->logging_buffer)
-		goto fail2;
-#endif
 	mcdi->workqueue = alloc_ordered_workqueue("mcdi_wq", 0);
 	if (!mcdi->workqueue)
 		goto fail3;
@@ -136,10 +136,8 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 
 	return 0;
 fail3:
-#ifdef CONFIG_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
 fail2:
-#endif
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
 fail:
@@ -155,10 +153,7 @@ void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 		return;
 
 	cdx_mcdi_wait_for_cleanup(cdx);
-
-#ifdef CONFIG_MCDI_LOGGING
 	kfree(mcdi->logging_buffer);
-#endif
 
 	destroy_workqueue(mcdi->workqueue);
 	kfree(cdx->mcdi);
@@ -246,15 +241,9 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
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
@@ -281,10 +270,10 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
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
 
@@ -300,18 +289,18 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
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
@@ -700,8 +689,7 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 		resp_data_len = 0;
 	}
 
-#ifdef CONFIG_MCDI_LOGGING
-	if (!WARN_ON_ONCE(!mcdi->logging_buffer)) {
+	if (mcdi->logging_enabled) {
 		char *log = mcdi->logging_buffer;
 		int i, bytes = 0;
 		size_t rlen;
@@ -721,7 +709,6 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 
 		pr_info("MCDI RPC RESP:%s\n", log);
 	}
-#endif
 
 	if (error && resp_data_len == 0) {
 		/* MC rebooted during command */
diff --git a/drivers/cdx/controller/mcdi.h b/drivers/cdx/controller/mcdi.h
index 0bfbeab04e43..f9d90dfa19dd 100644
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
-- 
2.25.1

