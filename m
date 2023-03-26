Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6276C95C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCZOrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjCZOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA6B46AC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi9P0Ivsyh+976CwprI0wsXEzUXMlaTD0SEfOYzyvdZKsSrKYJYZWYaQtYr7QILMY/dtUZx2fDNw6q+G8zemw8vf/j5SXKzjkz8p0zcLyC4IgmVM1oXX5sAsS+79qdgNHkK3BV3TfXYA9WoOqeCW2yvPWhemEUwrV/ibzHS/O9BTrus4TSrGCl1NGt0MEJElgxWzmKIl1aZdp2bsyGE6fdIBkD2MUNrSzrdfYx5SaBvLX/BCMEIkpZnrtXmfwgblOkCW/duh8vtJfAuFN3PQZonFVJEwp1OjtZc3ORwYb8doyQPIR8clKH1/1HI0/pu3XpRrBqCRC6VQ+irvRjIDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l9l4MSPMGVG3GgDFqDSeKfsbvGphG5pxVBc850DdwE=;
 b=a8dmZQ7pTLPF8udRZ6VZwKdojuROMV2rmHmi+uQnyLlcPkfbhG2kVHWC4IqOGE9yOysyFbHjBrmNCX/VpZfzdr7bDSHGGKA5GLhoFmirfIM9vwnqtTAYXNfi5dcU3r9L+RQax8mDz+edGfSR9UAJCPjMVhIRKt3FC0cecO9fJ6cIQ13c5buhmA0DxEYm8uzo9CNk7zRewnXJyhU4FK+13kYQPnHglY3XELAisGtjQYDEoa/E/FzRiIjbM2zeeQh4P6kpE+6N0erYn4LXsUQ+wgogoOGb3xghO6GqbVRCn+bYhe1n25HVnXS8EA2WRDYLk5j/0pgb+DtXcSLUbtYePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l9l4MSPMGVG3GgDFqDSeKfsbvGphG5pxVBc850DdwE=;
 b=jDtUFSbYz3EA95IykH7+XBlWmF8pW1gbWJMZdiuJjflB7EjxAQ1MOBQtxVCfZIWTSAMgChh3VzH3OopPtZTbJ1bBTvNis4HV6irV74Rk1uerrmOP04lJ9YvJxhUFp6GLfiC1cJ+ZLm+CW1OvG89HMZlk2Tm9evEruBvgDETd++w=
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 26 Mar
 2023 14:47:29 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::c9) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.13 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:29 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:25 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 02/11] virt: sev-guest: Move mutex to SNP guest device structure
Date:   Sun, 26 Mar 2023 20:16:52 +0530
Message-ID: <20230326144701.3039598-3-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a8e165-9efd-4183-35f2-08db2e090606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIZpMFk6O5PoyqBtURbTp0n2pQs0/l5UJfVfJBSdM9nAL3OpZoMVYU1FTOSYZPFYDn741sQzmlCN9kVGYKMxK1kkRxlmsAec9E8a6J6W5RgqRBPJxbCVZaZj3H0TCTjlrKnjzkAKcwcvLkrI+aJs0IhGQo9YIAz7BgHROA5JAvAddtjwkRQeWElPnKBJEDMimLG2j2qiy7B9Sg8IaCuJmjv2YJL39OdyLFffQjJoLvmys3RfBsj1pAKbKXlK+tNfhzzXIwENHEHKmqQZM3OKCFzuztsNsXGz585776/AnhmGeFDAyGJqvYZNdiHqSKK295d0mAF5IVPVja5DaWdmWQKzdcP2Crnb8f6pRlxlE8BftUqP/KYB6/UWa4malh4tubP7XwTYHitb8v3iT7ADQSwMwJIGCyqLh8FtRmtJsZQcrFOnu3TVUoqvDrIa34Uut+sRflEyR0a6QedzsKZxt3DRb2e9NCWMrZaqBOi5FFvV263kxATJYFvi7dFvknIwq0i+NG6GQxDZdGj7kdTXyN//iDWkqXyqZLSbGurS9iuscxexUezi2vbngs9Jt5ZlOMJtLbHRFnOXMHbHOpn3bR1YIzhQqz7iWfFXcg5uTRL0sVDsnLmBVPH3NxVCIjskH96cDgKNnmaDq2M5vafRbKjfr0ZyWPn0R8yhUR3XAS098gc5aIRUVgrEjsyq4xfTqvbuB8QAHjg15VsYRdZkkoth7kZTpwEGI54EEpuJgUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(36756003)(8676002)(16526019)(356005)(316002)(40480700001)(70206006)(54906003)(70586007)(5660300002)(2906002)(82740400003)(81166007)(26005)(36860700001)(8936002)(41300700001)(1076003)(6666004)(47076005)(2616005)(4326008)(426003)(110136005)(82310400005)(7696005)(336012)(478600001)(186003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:29.3398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8e165-9efd-4183-35f2-08db2e090606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to provide new API for sending SNP guest message to the
sev-guest driver, move the SNP command mutex to the snp_guest_dev
structure.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 57af908bafba..6ae197b57644 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -35,6 +35,9 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	/* Mutex to serialize the shared buffer access and command handling. */
+	struct mutex cmd_mutex;
+
 	void *certs_data;
 	struct aesgcm_ctx *ctx;
 	struct snp_guest_msg *request, *response;
@@ -48,9 +51,6 @@ static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
 static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 {
 	if (snp_dev && snp_dev->ctx)
@@ -99,7 +99,7 @@ static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 {
 	u64 count;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
 	count = *snp_dev->os_area_msg_seqno;
@@ -377,7 +377,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	struct snp_report_req req;
 	int rc, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -417,7 +417,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -456,7 +456,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -541,12 +541,12 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (!input.msg_version)
 		return -EINVAL;
 
-	mutex_lock(&snp_cmd_mutex);
+	mutex_lock(&snp_dev->cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
 	if (is_vmpck_empty(snp_dev)) {
 		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		mutex_unlock(&snp_cmd_mutex);
+		mutex_unlock(&snp_dev->cmd_mutex);
 		return -ENOTTY;
 	}
 
@@ -564,7 +564,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		break;
 	}
 
-	mutex_unlock(&snp_cmd_mutex);
+	mutex_unlock(&snp_dev->cmd_mutex);
 
 	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
@@ -683,6 +683,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 	}
 
+	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
 	snp_dev->layout = layout;
-- 
2.34.1

