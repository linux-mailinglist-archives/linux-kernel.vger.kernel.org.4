Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ABA680CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjA3MF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjA3ME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3AB36089
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdbmskCyCZpJOTsrjMlqpJMAW3HA/e1cijd7rRp40fTPbSBRP3q3hKsLrr36TUBIh2e8mMRyLcfgDNSrpoQ/aEwinYEc+bLwltQ4YMzf/OjQ+MqFvW0Goufzq83iHtaER/EBejxgDo5qDRFucAknf9GGNSEEgLnXm5oNeUFQG6ZvjWP68ZzK8uY/rk1soWyMTihRGBd3bJG70nQaE/i23LIkpg3EnX+2mnb41gxxNZnsqpVSrgwpsuSDE2piZ/07fa/9B6IvqKe9zdtYNfkEMPxSUdgg1qG0i1qvKP/vDU/8hC27Dp/hm14bZWAyO0Zfnw1MGKldswlN2+Bw843PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCu4Gv+GeYTnajvjd0tGOmSIA3L57tYTcdpmSafCpWI=;
 b=EOj7j2eHkxpCCvDXR10TQAeYCdVRiZDI3k01g09zhOD96jvClXI05iATWBYJuI67K6agtxjnc7k/CpjTdGCq9/y0aLYrMWQt2MWgAk1Cgxntw4E8tJLvl3dqNihLcpmNrUZwNkOekTdTonwWwSua4xQfISImkLTwsBtyz3CWHR60HaJ2bXUWElNRhGOh2NevUY595qT5D0A+hSPnsRfXLxvdVstKBbjkhjS0G2oaIfuonAtgPnpO98h28/YyxmvATkCY1ii9WcV/ogfl35o8NhR5IJRaHkCS2Dkf1b5eicOVorHJ0UvR+cImnB4Nd2RDxpwBaiQjRrlzmmEZzuKG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCu4Gv+GeYTnajvjd0tGOmSIA3L57tYTcdpmSafCpWI=;
 b=OfqA1GNjzhMufFyiEkR5nqjiSqJ/OLHHBWzEAEgbBzompUUi5uCwRnBlLpYeyJI1dIOyfAN0/8YwAGq68ytYqNRBITSEvrTNfFyQSDKQ/Rj2ZVSsXd7VGxb0WKK6ow171xi/pni1iJ23AaKmVM3TLh8ZseH2sQ+k32UB57HzJuE=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:31 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::79) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:30 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:26 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 04/11] virt: sev-guest: Add simplified helper to assign vmpck
Date:   Mon, 30 Jan 2023 17:33:20 +0530
Message-ID: <20230130120327.977460-5-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaa6a65-ee9b-41f4-df7e-08db02ba24f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8BTZ+++Xc22RhB6uQkFWccF8suT2e6wBpogHfQB6hODfsGg+exDkW29m6HDwpMQNJi0bq5JV9fZGuUhEpZIfX1ZuSQLRAD9x9NT30NGSepkWbC5yIiV49UWq5f0CNZG/OTkHqnQ+tDiF1HTbbvZbkzFj3oVJLmXBTFaiQCZnbQ8794Z1aQ8vD3LzQpziFZT+t35lx40VYd9/RjNxx3U5O3gFo8EtAQjc7OEx9CIP6yzUyjIZdwCb9cBuUiDnE0cKmwT/T0qfQ24Yz00r8gfi+Uc1eLyQYFVT31pMn2JBwci5e745p2/gwnujXUXb/hIYDqZwxPs41Yp3W8WnUQgTvGZ8ZRKwmXpVbg2Hyhc9ICJ2ZSppiuJrygbfawgFW62zT7QmEBFiJCssqdLJMcMRKeBUG9lmgFE4Zx728wyWY2np3xqt2s5dZCBfAjuAZKSjqwigUa3wgXBANnZdhh1BHs1UoN7JlU0owPl5FbhotA56Mm3eVNEfcnWdedSYOGnU26vBs1a0J7eeuYLX52Jl4ehKKeZMVVxLLwOovw6TwkFRYXoYlzHOhbvg9Ji8OkyzBPE5yEV3wEEXmslh4G/sFtWEvDxYS9lLQsI/f089A19V/ihlBV6j8fgzKh6dpUlNK0wNfULbNFGuPhbBTygJlkEDnWhmPz7l/ITulGh8VChJd8iWPO4X1GusZ95NH/DlgkFWs8sbxoyvZD2epG9rcQcaeFWAc5QV8ZakAXt3eP8RJMm1Rt0yc/rYJI/wuDpvrGfsiKPUZef5jramvhzEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(7416002)(2616005)(426003)(336012)(47076005)(82740400003)(82310400005)(356005)(81166007)(2906002)(7696005)(40460700003)(36756003)(36860700001)(1076003)(26005)(186003)(478600001)(16526019)(40480700001)(6666004)(110136005)(8676002)(8936002)(41300700001)(4326008)(54906003)(5660300002)(70206006)(70586007)(316002)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:30.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaa6a65-ee9b-41f4-df7e-08db02ba24f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index af5b965c6c29..6eb2bd02a7c6 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -42,6 +42,7 @@ struct snp_guest_dev {
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
+	u8 vmpck_id;
 };
 
 static u32 vmpck_id;
@@ -77,7 +78,7 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
 	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
-		  vmpck_id);
+		  snp_dev->vmpck_id);
 	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
 	snp_dev->vmpck = NULL;
 }
@@ -253,7 +254,7 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
+	rc = enc_payload(snp_dev, seqno, req, snp_dev->vmpck_id);
 	if (rc)
 		return rc;
 
@@ -324,7 +325,6 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	return rc;
 }
 
-
 static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
 				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
 				u32 resp_sz, __u64 *fw_err)
@@ -585,32 +585,16 @@ static const struct file_operations snp_guest_fops = {
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
@@ -639,8 +623,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
-	if (!snp_dev->vmpck) {
+	snp_dev->layout = layout;
+	if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
 		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
 		goto e_unmap;
 	}
@@ -654,7 +638,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	mutex_init(&snp_dev->cmd_mutex);
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-- 
2.32.0

