Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A60680CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjA3MFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbjA3MEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C116ACC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvKJbOcWqiDzVidQGjzd1UvbBUN+h90/v6zp7bnp9axClhI5kcuyomBhN4N89kEYL8ImjU+Jn4aJnZudkoGwKx0Hlj/CcfE186qBJzc8wabnPuufiCDehINl0Go0QXkFc7zUeRac+jMfYwjj2aBkzeHpyr2VUyr6YOcbWdUaGgSCVnNoFClp6vir8YEfg/FXwq6qZyj5QX2HYWz2Cnhht+heap976J8K7UBzupNje8AQXzfrAQRmYRXB07bm67D8byHqaazwJ0GdH09qyCl12fblSfuoXb1JlhNyJQG9P1zKwGaD7uSx4s0j5hdOWhN9jfiXS2wS7qaUOKD/G8ghZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hbmhsj6QN9oUc5s/7AXRc1KCTYc+IHf3ZAA3v398fQ=;
 b=gcFqfYxkIvkwH8xRrViB4ybLnA2zHolnL6ZNmaj6w+xsuV8EAES9PwAL05t7/TR+w80EYut7ej6quzHCAaDTiJSjinBCsyfyl1ppfjzNz/7C4GIIOEXTgw+YQcU2w/GpzZG7rKbjJ61hxWWgZnuUC0s9LnJ0KVlZvJiuYlEd92mjEa+rWpV4v0P9J0aRXmrVLt4d8Xk4x26c35AYhKbHULD73d+c5ZJL7brxHnlQ9P4fnDMeayGyPzakR4z5PuMX5cwmbD66es71EuUZQUtQ7JY6C9cs1zsL/L3qXsJyvC3XzS5TNAfljGX7RPBZScEYj9ZFwtptJW4JAmFKZ+Q65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hbmhsj6QN9oUc5s/7AXRc1KCTYc+IHf3ZAA3v398fQ=;
 b=WhEELR+5Cv5RqgYKEA2SrbtyDuxY4NODFGVY3QPnTaItSafarV7h1THSy/igcjcx7LFpHhIIAo6mFi7xFHaCsbhk3wL6/P+nrGGZuedfiYwdgNTxsMyY1OEmWMDEZVgAes9NVeMSVNt4AjD/XzTrYvgRO6GSiaIJlmj0iMD3vxU=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:22 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::45) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 12:04:22 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:17 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 02/11] virt: sev-guest: Move mutex to SNP guest device structure
Date:   Mon, 30 Jan 2023 17:33:18 +0530
Message-ID: <20230130120327.977460-3-nikunj@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230130120327.977460-1-nikunj@amd.com>
References: <20230130120327.977460-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fbe543-fefc-41e5-ab74-08db02ba1fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLvWovYfZcA3hlSEzWeLr1gZXgu4Vo8qatQ3iSVxmnb0S+07csARdFrfbZPlXKVc0b+Cv/F7VzjCAQC61u/ZLch6tUrorSPQ6JE5H9dgD0Iwef2HNf1YWFtodAA7+HGwUF9Tt8BxzUIerlbIrL0fLUjW2yeoi8hDcgbVcWntA+DbpNLu3SCLHd489qfgS2tKXEw0p1mL8Tn4Cj6vSLTmeNa7iRQ4ptlr0Z2LryPB+sHj7ic5iHzJdK9c/zWDsF6a0UhCPHA5nuJbiF0gvdOMUprz/DXTfWUNhcGJQOVllUKubgi9uCQhLFhAyay07SQQTC3dQUCpBgpqew6fg+hBtyh3EI5caBgCJn8N+5pN77m+rhO6N4ZPm/RTYiovrz7JyR71t6x7uauxb+3kWDcmWwBDk1uTzhbnvbD9oGRjaUM4qV2Kw5J0bctU6gjZtEHE0J67iM9WwwB1m1kwmCPjxetwZxmEn22LnWCzzI8VQ437w/OD5Ypy1Vd3jvcrbDqZo9X43gB1FNyMjB85WHoyXyCC8/SkNEUPU/PMBEZu9ZzkjkQzjcfalLgOJV4Cr7Q4Z/gcoS5m9ll6QpH9Ym/QRfv/0mmFsVOzoSdr4zgYveIXvxlBFC2vOJ2Npcpl6qWZDmCxWNBNtlhivIWDMZMvpGJQEldNIozdEwtoZ3JebL6bsGWQomJEOvLvh7q2JyRpISK7YnWwPNqqSXq9JnSm/RFWLdSvIqeHYg7TLl/hdFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(7416002)(8936002)(41300700001)(40460700003)(82740400003)(40480700001)(36756003)(82310400005)(356005)(81166007)(36860700001)(2906002)(336012)(110136005)(54906003)(426003)(47076005)(2616005)(186003)(478600001)(26005)(16526019)(7696005)(1076003)(316002)(70586007)(4326008)(70206006)(8676002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:22.3288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fbe543-fefc-41e5-ab74-08db02ba1fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 20bb38242018..106cabce1ccd 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -32,6 +32,9 @@ struct snp_guest_dev {
 	struct device *dev;
 	struct miscdevice misc;
 
+	/* Mutex to serialize the shared buffer access and command handling. */
+	struct mutex cmd_mutex;
+
 	void *certs_data;
 	struct aesgcm_ctx *ctx;
 	struct snp_guest_msg *request, *response;
@@ -45,9 +48,6 @@ static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
 static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 {
 	if (snp_dev && snp_dev->ctx)
@@ -96,7 +96,7 @@ static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
 {
 	u64 count;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	/* Read the current message sequence counter from secrets pages */
 	count = *snp_dev->os_area_msg_seqno;
@@ -338,7 +338,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	struct snp_report_req req;
 	int rc, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -378,7 +378,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -417,7 +417,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
+	lockdep_assert_held(&snp_dev->cmd_mutex);
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -502,12 +502,12 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
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
 
@@ -525,7 +525,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		break;
 	}
 
-	mutex_unlock(&snp_cmd_mutex);
+	mutex_unlock(&snp_dev->cmd_mutex);
 
 	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
@@ -641,6 +641,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 	}
 
+	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
 	snp_dev->layout = layout;
-- 
2.32.0

