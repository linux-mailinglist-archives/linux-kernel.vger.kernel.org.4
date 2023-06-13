Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF872DCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbjFMIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbjFMInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:43:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46710FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMPTglBgb6DyQKWww7L78aWCSDM3ETEugKCKePqyKA4cgxf6wQ48ZcXRI3uYxQdIQ0g6rSBUsSTvWAua35gop8MKeSNwEwUv/imciqgXU1T42lh0gbVlX0kC3XFDk5Hv21XfMfxvBAi6K+ZoEDERk0rHiWS7cgtVVPU7bA0OH/ZWazYBIXrZudN2e3orf4X1lZJBX1LfXPdJLpuY7vDLvr0sVqM3SnpufVXnHzEHpCtFV4DrXKCzEgHLQyybVUBPPCrLLypMYxAplbvYkJzgM03q0iSug5mxBwoa9XAf6rKH3tM1agkVJ5K0JQuxO7+62I+xFEe83fwoghiFjMRx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3npLaIMIdgHlns0tgY1zlVaVvzLUvK7FTHhuLgy+Bs=;
 b=C7YQF5ycCuLcv+fePHzWM2I1PLcJneYBN5kEH6AbTzEou4gwYL4X4yeZ1I9TelDqt8+aM/Sl0ceeu8uQ5RbsK7rCinh6m6TsCdtevilxTOsqL4XlVNbJxNGyhXuVhU/gA3SWO9fjQp/5E++cGyjkN6+nvsJMH3H6bFPYZI2NZxhYHwp33eVzUnQM8euIgJMy8zhdnZufMVpYfy+c321DNgUB8plirVP1Xami9kGFh6g3EkwVeHSx1LfDHFoIyy59XO9YMPTLzd9fHXen0BSC8JRoovOAXTDtfNyzZ81Mk7VrOG2mmPnEEwsOsl711RXElnxQK6aCXR8aU5OCMQ/WNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3npLaIMIdgHlns0tgY1zlVaVvzLUvK7FTHhuLgy+Bs=;
 b=RryoYCSHeTWTM6XVbwzGL3uCv7P3Gf9SlSbHS+56DCck0Q8lf+BeJkpGlF7sB8igJ20OcD0DvjYaH1/MRWa4XUnVW6QQdVJCfG6tf8w906C20AFMnamUXdT5Hk971ke3fAllQyyUxp8H6ph64H1Oc6zOkOxRLR1PKpB12lZ1fFM=
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 08:43:40 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:5:3b7:cafe::1e) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 08:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.0 via Frontend Transport; Tue, 13 Jun 2023 08:43:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 03:43:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 03:43:38 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 03:43:36 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>,
        <gregkh@linuxfoundation.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v5] cdx: Replace custom mcdi logging with print_hex_dump_debug()
Date:   Tue, 13 Jun 2023 14:13:18 +0530
Message-ID: <20230613084318.27996-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b4611c-1a1b-4594-5888-08db6bea4971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImDqwwo/AoQMJFFhyh3DwmvaxiAo92Jf8lc4Ln2QAKlJuG4ODi4ocCFzKLhHFLz0fcM//lMll0P62H/Hx1/52jnS8OvzDj8On1gfYTAZ53zRro47Y7Dn9dWfUzSlcbQnvmRp01fdu+9K6JcHQhdFzdxjaKNowk1weG0ExcTcPnMX0E4Urjetci02jUA3npPvR63Hfgd8/DK3m4yN90ur9ElDisBBvv0S6/9Yt1PUVrLXaUQxdrxc3u9OLXcJvR+hVU2VZ/G2gNhuuZ99q6h2OUf3zGXLTUbkIjLenum0MBRtuPVEKVshSahlxTOhyLAitNkHtY1JdWPfG6FWHfnO/X/aQLGX3FtJWmyFa8/X9xMBIlyr5T+tdOW69DQsNVLgD1EgX7/chnvry8NFRCcs3Hu03tjUkkWNY8DRr81WqczsWZHlq6IYLyzbB/44oVIylb/sCwGA/loqgoxclPJAqf8F0WJLlFeoQXxFrwpt1D7zOImBZaQkJcJGklqWPJ8N2zeFHoWoZfy5DgzTl7gkWLh/WTn03hPx4ebL4k3ZoogVGcBYDMji9ZF456tlQpjsNUcZLYlAfcAlmjhBvfi0zzmDwJk658UIrC/I1KgmhsnxeuDekwmW5QyAdVIpZsQOy8DLBsi+hfO8PWJFOtUtmRCgKdnbJbKIkIO/2LhJrnghK1UYca4qdK5KkM2iwETXZjMNQ5mdsMg7S+eRt0Fwk9WIPOR4GVPZHkvvRPJmqeF8e33Un88pc40XQzsANqAVxpsEMzyTgCANw5CjuD75NnajjZAzFVoX8TvyaF2ThRY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(110136005)(54906003)(36756003)(2906002)(82310400005)(82740400003)(86362001)(40460700003)(478600001)(44832011)(40480700001)(8936002)(5660300002)(70206006)(4326008)(356005)(70586007)(8676002)(81166007)(316002)(41300700001)(83380400001)(1076003)(2616005)(26005)(47076005)(186003)(6666004)(426003)(336012)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:43:40.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b4611c-1a1b-4594-5888-08db6bea4971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

Replace custom mcdi logging for send and receive requests
with dynamic debug method print_hex_dump_debug().

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes v4->v5
 - Modified commit message

 Changes v3->v4:
 - Custom logging under macro CONFIG_MCDI_LOGGING is replaced with dynamic debug

 Changes v2->v3:
 - Dropped sysfs entry changes from v2

 Changes v1->v2:
 - Moved CONFIG_CDX_MCDI_LOGGING flag to header file
 - Added sysfs entry to enable/disable mcdi logging

 drivers/cdx/controller/Kconfig | 10 ----
 drivers/cdx/controller/mcdi.c  | 86 ++++------------------------------
 drivers/cdx/controller/mcdi.h  |  6 ---
 3 files changed, 9 insertions(+), 93 deletions(-)

diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index c3e3b9ff8dfe..61bf17fbe433 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -18,14 +18,4 @@ config CDX_CONTROLLER
 
 	  If unsure, say N.
 
-config MCDI_LOGGING
-	bool "MCDI Logging for the CDX controller"
-	depends on CDX_CONTROLLER
-	help
-	  Enable MCDI Logging for
-	  the CDX Controller for debug
-	  purpose.
-
-	  If unsure, say N.
-
 endif
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index a211a2ca762e..1eedc5eeb315 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -31,10 +31,6 @@ struct cdx_mcdi_copy_buffer {
 	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
 };
 
-#ifdef CONFIG_MCDI_LOGGING
-#define LOG_LINE_MAX		(1024 - 32)
-#endif
-
 static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
 static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
 static int cdx_mcdi_rpc_async_internal(struct cdx_mcdi *cdx,
@@ -119,14 +115,9 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 	mcdi = cdx_mcdi_if(cdx);
 	mcdi->cdx = cdx;
 
-#ifdef CONFIG_MCDI_LOGGING
-	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
-	if (!mcdi->logging_buffer)
-		goto fail2;
-#endif
 	mcdi->workqueue = alloc_ordered_workqueue("mcdi_wq", 0);
 	if (!mcdi->workqueue)
-		goto fail3;
+		goto fail2;
 	mutex_init(&mcdi->iface_lock);
 	mcdi->mode = MCDI_MODE_EVENTS;
 	INIT_LIST_HEAD(&mcdi->cmd_list);
@@ -135,11 +126,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 	mcdi->new_epoch = true;
 
 	return 0;
-fail3:
-#ifdef CONFIG_MCDI_LOGGING
-	kfree(mcdi->logging_buffer);
 fail2:
-#endif
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
 fail:
@@ -156,10 +143,6 @@ void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 
 	cdx_mcdi_wait_for_cleanup(cdx);
 
-#ifdef CONFIG_MCDI_LOGGING
-	kfree(mcdi->logging_buffer);
-#endif
-
 	destroy_workqueue(mcdi->workqueue);
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
@@ -246,15 +229,9 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
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
@@ -281,39 +258,12 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 			     MC_CMD_V2_EXTN_IN_MCDI_MESSAGE_TYPE_PLATFORM);
 	hdr_len = 8;
 
-#ifdef CONFIG_MCDI_LOGGING
-	if (!WARN_ON_ONCE(!buf)) {
-		const struct cdx_dword *frags[] = { hdr, inbuf };
-		const size_t frag_len[] = { hdr_len, round_up(inlen, 4) };
-		int bytes = 0;
-		int i, j;
-
-		for (j = 0; j < ARRAY_SIZE(frags); j++) {
-			const struct cdx_dword *frag;
-
-			frag = frags[j];
-			for (i = 0;
-			     i < frag_len[j] / 4;
-			     i++) {
-				/*
-				 * Do not exceed the internal printk limit.
-				 * The string before that is just over 70 bytes.
-				 */
-				if ((bytes + 75) > LOG_LINE_MAX) {
-					pr_info("MCDI RPC REQ:%s \\\n", buf);
-					bytes = 0;
-				}
-				bytes += snprintf(buf + bytes,
-						  LOG_LINE_MAX - bytes, " %08x",
-						  le32_to_cpu(frag[i].cdx_u32));
-			}
-		}
-
-		pr_info("MCDI RPC REQ:%s\n", buf);
-	}
-#endif
 	hdr[0].cdx_u32 |= (__force __le32)(cdx_mcdi_payload_csum(hdr, hdr_len, inbuf, inlen) <<
 			 MCDI_HEADER_XFLAGS_LBN);
+
+	print_hex_dump_debug("MCDI REQ HEADER: ", DUMP_PREFIX_NONE, 32, 4, hdr, hdr_len, false);
+	print_hex_dump_debug("MCDI REQ PAYLOAD: ", DUMP_PREFIX_NONE, 32, 4, inbuf, inlen, false);
+
 	cdx->mcdi_ops->mcdi_request(cdx, hdr, hdr_len, inbuf, inlen);
 
 	mcdi->new_epoch = false;
@@ -700,28 +650,10 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 		resp_data_len = 0;
 	}
 
-#ifdef CONFIG_MCDI_LOGGING
-	if (!WARN_ON_ONCE(!mcdi->logging_buffer)) {
-		char *log = mcdi->logging_buffer;
-		int i, bytes = 0;
-		size_t rlen;
-
-		WARN_ON_ONCE(resp_hdr_len % 4);
-
-		rlen = resp_hdr_len / 4 + DIV_ROUND_UP(resp_data_len, 4);
-
-		for (i = 0; i < rlen; i++) {
-			if ((bytes + 75) > LOG_LINE_MAX) {
-				pr_info("MCDI RPC RESP:%s \\\n", log);
-				bytes = 0;
-			}
-			bytes += snprintf(log + bytes, LOG_LINE_MAX - bytes,
-					  " %08x", le32_to_cpu(outbuf[i].cdx_u32));
-		}
-
-		pr_info("MCDI RPC RESP:%s\n", log);
-	}
-#endif
+	print_hex_dump_debug("MCDI RESP HEADER: ", DUMP_PREFIX_NONE, 32, 4,
+			     outbuf, resp_hdr_len, false);
+	print_hex_dump_debug("MCDI RESP PAYLOAD: ", DUMP_PREFIX_NONE, 32, 4,
+			     outbuf + (resp_hdr_len / 4), resp_data_len, false);
 
 	if (error && resp_data_len == 0) {
 		/* MC rebooted during command */
diff --git a/drivers/cdx/controller/mcdi.h b/drivers/cdx/controller/mcdi.h
index 0bfbeab04e43..54a65e9760ae 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/drivers/cdx/controller/mcdi.h
@@ -153,8 +153,6 @@ struct cdx_mcdi_cmd {
  * @mode: Poll for mcdi completion, or wait for an mcdi_event
  * @prev_seq: The last used sequence number
  * @new_epoch: Indicates start of day or start of MC reboot recovery
- * @logging_buffer: Buffer that may be used to build MCDI tracing messages
- * @logging_enabled: Whether to trace MCDI
  */
 struct cdx_mcdi_iface {
 	struct cdx_mcdi *cdx;
@@ -170,10 +168,6 @@ struct cdx_mcdi_iface {
 	enum cdx_mcdi_mode mode;
 	u8 prev_seq;
 	bool new_epoch;
-#ifdef CONFIG_MCDI_LOGGING
-	bool logging_enabled;
-	char *logging_buffer;
-#endif
 };
 
 /**
-- 
2.25.1

