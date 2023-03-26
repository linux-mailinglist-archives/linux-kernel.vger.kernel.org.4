Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F856C95C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCZOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjCZOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDF5FDB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtYC7CDhj1hqanwK8bCci73ATKIRvLle84lxx0Dnn+3yVhpDEuZH+f+uuoNCvZTz7dk+iqMsNZLTJ2Lig/Etk/VkgUpDtum1PVOtpQgfGKZDCPAHFA9uUDIU+XwOxQA3KJAs+f3R8kFeX/mhMdYlPN5vbyvSeH/hP2xR4hlBqUsqiPiNNJg2brrL7sgdW0LJlxh9tgl039tsNcmmD9M0GIlXPsmfKH69KadFKPdKwuBOS6XOxNjv7zgJ5cU1Sdi7/4isrFh6rl5LcIb9z2lWDJB26a4RJchfLbPVMbcah5cmlJKJQQDhxEaR1Wo9KgyJZbnxEeNcjsSgz4RTg9qfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vKQXI/UcLoINMgy3KgFkyPhc0bu3CZ+oU0nhIZo/RI=;
 b=itJXOdD5xPuXlPlosnoptswPoPyyLXuxs1tezWo0RgLAKZkZrvpWkMhyACoFi7M8LXD6/kuFehncjSvjYNCf5aacYkNfrDX+pRLlJpgMvv4qxWwFhsD9pQIFLmPRnk3sbfxtpbP/ifP+N34ZWZzaacFn7G1cG5T3Ea2vUKDBw2YlqcRad8lOsZoyhWVXzM63XfU0LIgHyYKYlO3ODQJ+sp7cWXpPbqW3kACXtBEx9xXn6nXKXAHzJj4DFizYBAkwd+5m0BRRwwxFWmQPWl2yqcIoGWhE1CUP5MErFob1dOmBeBtD0w7u7Mypy9PcEi7txnCwtC5TZbyIRMCZugLYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vKQXI/UcLoINMgy3KgFkyPhc0bu3CZ+oU0nhIZo/RI=;
 b=O7h7teTIbNykqZRgBEZih8OBhF52hFhHlXP0xoVkOBBVGf4YzSTWZJNxhg3AF+tQ/hatqMeggK1Zvk98gnkIky3hdiNXX/dHMs7Nh1jWmShJ0o/CHCm6LBVMxIuE/Suh8XaKlH7YPRqk324aIFQmNQo7c4FHPnCWJceiQv8YfAo=
Received: from BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 14:47:36 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::fb) by BL1PR13CA0150.outlook.office365.com
 (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.15 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:36 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:32 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 04/11] virt: sev-guest: Add simplified helper to assign vmpck
Date:   Sun, 26 Mar 2023 20:16:54 +0530
Message-ID: <20230326144701.3039598-5-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f14eec-677c-4fc2-2eb6-08db2e090a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ0iOqcmYZXydtXhcMzg+i9ylLHiYgr3PbFIWZAb53ynLT+7fHXvMrECYVUq8svA0u2FlHT9BfUkHra+XV5fNIMCJ/ilRmhdi68weORL/rCO6m6qSK5b1EDWmFs1ojzt66gbrpFf9GL950lDHXF6oPStob+v+AhSmH0EprHcaMOaaH7+dh0Ipo995Iagwvuwet0Hr+eAxTg6Fc7Qx/5o/+GtPHnXYUo2cra7X3/IDmrnvXNKKMgnIOQ4wGYMmo9C+d55WSDXdep7LRTMDWfnG09Cjm03cYscFZGVRfr7zT9nITLsH4+ReLUrfyKbVXlBXp/+V+bkkWFzLubOpZFEthAeHTWnpzRkduTsJa+np7wvow/R6Fj/yP0GnRhz2ORZ3OZ1dd7FkH104g0PFmxd26Fhj3jL8dqOKmAajrL4vj1f1tKEKx+FV9RDVrAHupscR5PvEYArpG89HIR3wd0CQvgscsLVBRZBVsmKew64IUlz68YqWeZN2TCoZXhgZvN4pdr3MRWiFmX2rvPt2gemQxTqDVcgM7S4vnJEkzq6ftsrN/fVSXeouIKf9+OS3V9MXQ3Jdn2/4nA8N3QnQibFXmITN694C7aoOnu1KE0gMVVmgMXDr+pkre23scoNAQXYOhUQvjZ0sWYRLuPbZOHVbU2w6UAhwUYlDzFyPieE/C9P/smYIV0OpyhzeJq6UCrcdSgcKaFxjU5GQypzHRYZ8FZ3SBQKIdKn4571n8O+yVk72VRc/EoB2we0Nf3REf4D9l/OPgZknGyQ1yZ7xbgnng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(110136005)(316002)(6666004)(8676002)(70586007)(4326008)(336012)(83380400001)(81166007)(1076003)(8936002)(26005)(36756003)(41300700001)(82310400005)(36860700001)(82740400003)(2616005)(2906002)(70206006)(54906003)(47076005)(426003)(478600001)(356005)(40460700003)(186003)(7696005)(40480700001)(16526019)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:36.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f14eec-677c-4fc2-2eb6-08db2e090a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify get_vmpck and prepare it to be used as an API. Update the
snp_guest_dev structure in snp_assign_vmpck(). Added vmpck_id to the
snp_guest_dev structure which can be used in SNP guest request API and
will remove direct use of vmpck_id command line parameter.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 41 ++++++++-----------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index ec93dee330f2..4901ebc8fa1a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -45,6 +45,7 @@ struct snp_guest_dev {
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
+	u8 vmpck_id;
 };
 
 static u32 vmpck_id;
@@ -80,7 +81,7 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
 	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
-		  vmpck_id);
+		  snp_dev->vmpck_id);
 	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
 	snp_dev->vmpck = NULL;
 }
@@ -339,7 +340,7 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
+	rc = enc_payload(snp_dev, seqno, req, snp_dev->vmpck_id);
 	if (rc)
 		return rc;
 
@@ -364,7 +365,6 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	return 0;
 }
 
-
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
 				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
@@ -625,32 +625,16 @@ static const struct file_operations snp_guest_fops = {
 	.unlocked_ioctl = snp_guest_ioctl,
 };
 
-static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
 {
-	u8 *key = NULL;
+	if (WARN_ON(vmpck_id > 3))
+		return false;
 
-	switch (id) {
-	case 0:
-		*seqno = &layout->os_area.msg_seqno_0;
-		key = layout->vmpck0;
-		break;
-	case 1:
-		*seqno = &layout->os_area.msg_seqno_1;
-		key = layout->vmpck1;
-		break;
-	case 2:
-		*seqno = &layout->os_area.msg_seqno_2;
-		key = layout->vmpck2;
-		break;
-	case 3:
-		*seqno = &layout->os_area.msg_seqno_3;
-		key = layout->vmpck3;
-		break;
-	default:
-		break;
-	}
+	dev->vmpck_id = vmpck_id;
+	dev->vmpck = dev->layout->vmpck0 + vmpck_id * VMPCK_KEY_LEN;
+	dev->os_area_msg_seqno = &dev->layout->os_area.msg_seqno_0 + vmpck_id;
 
-	return key;
+	return true;
 }
 
 static int __init sev_guest_probe(struct platform_device *pdev)
@@ -682,8 +666,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
-	if (!snp_dev->vmpck) {
+	snp_dev->layout = layout;
+	if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
 		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
 		goto e_unmap;
 	}
@@ -697,7 +681,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-- 
2.34.1

