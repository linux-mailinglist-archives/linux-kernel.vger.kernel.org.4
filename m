Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2923A678B12
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjAWWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjAWWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:53:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619EB11147;
        Mon, 23 Jan 2023 14:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuUjV6/hEMZrnIkl2ZM7ui+WC/P+1MsVGRRutGj2AHPhEu34Mujs89U4gUFkeyMlHjZhl1+sJ9QP2pNJBpggPhWxHyXxE/3GygbNzcrCHwJP9L/pa5C5puYerg4t0IBzPyQzvr0dlT3ObbIo5xNd0YcpL4RPv5bz5ZE59TGYPAqli5IhlXFNe+roRFGQOVvPyKggntmbyYJbj8jURA/4THgtQzpAYyGOlkvy8LIXZu6XYUxP2++M48p3WzYBLG+cRka/JYPR9/ZkqIWra0r9jE71Wk63jmdSN0eF7mWtMfVhdGm+0VtsKgxlnNlO1GmgTxPqeh/vB9gngl39PmTuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naQNuDTj0fcUv20yHTVYowxJI6jP8jAE3q5VfVHqBA4=;
 b=DwvkcHz30roazdOZ45h79pdQQhWPQIxIaQ1161lX+s68Oke2hAYbP5D5wtLmeBB3P66x7gMm/83A2ruB4yv9SR90UI8tWyFe+Yf3PSU2g5Y3wX+UuyRcpXOdLu7mtthXbwrhih8xW37R8vE9lJFcc3I89JHEOSa+KJpqESc3p1LNL0pr+f1NwvfwHZrW4h13m+Fx2iBH/8uqht5Jq1YA+3e0xaxaIL9CGzdIxEDnJA/czC+4XgJXzcGi/tZwGKY6a47DGhrjWWSqR2+Lh8DNTENyAvUBNR/gi3yGmZuP/Z+Jau3T908hrOGgXYEOAKTLtHgtmjlMMxYKDFECZNxwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naQNuDTj0fcUv20yHTVYowxJI6jP8jAE3q5VfVHqBA4=;
 b=zSAhhuD3v90fhgD+SWKxYnhaQZ61XzYbyZGZKMo0cca7rJDgyiS3SNG2Zyl4BK8zXRw9u0ojrk49Vb9UeOrwS8LcVqrbpCCmwMieoCAIxiRFWwMpD0CEe+mxi7D1hlzDeAp6zdVPup49Gta8Fz5/YjFjGW+cB9LLPT/6SgGfRig=
Received: from MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::22)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 22:53:20 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::f5) by MW4P220CA0017.outlook.office365.com
 (2603:10b6:303:115::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 22:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Mon, 23 Jan 2023 22:53:20 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 16:53:18 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>
Subject: [PATCH] crypto: ccp - Flush the SEV-ES TMR memory before giving it to firmware
Date:   Mon, 23 Jan 2023 16:53:08 -0600
Message-ID: <9d112c35bf613a42453e05c69ec0c96a32ba6078.1674514388.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: b92010c5-1d5a-4f3b-6188-08dafd949fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfnmPQJRuNQQtkRbxVEXjHnrtjNB2Dzjm7qolGBqes5j9bWt3z6je4dVcF5Sw6kl/AjU//4Cs3gLvRmd9B2W2xt/ASSa9nF4MI2Rms42wSFj9bZ/hSPILdh4adpvsYyJX6vG4E1cvnLu8jj4WMKCgvrZK9p5oBzKh+3B7U16JK8v1b4I/Nxjo25PGZ6G6pKEUsRa38K3qWDK9KwFbCYSf7iK/7IsHBSXFXWPpLgWwIxbbV8tmD70AfZpokST6DZ6omh8RFJZM4wNZE6iiB/24SXsXqrP+p46ag3LkSj2pV6rK4YzuvNrluLvfK0Rtbb6l4P7nfUfgXCwBOIzkdtJPr8qPTi7Doq+gxZodz3zWaXKtBgSRi5lxVY2MnqHQjbJq8tfNOuCxBnvUhgMa8HKTbtKmZqVWSNr2QxbgQqVsb0jigCgQ6/2pvlYQUNaPIZQIQqTM0Exc74GSAqDnBl554QX049JayFXUYiYiia1E6NrK/a6zPIwiQI/8r3/iIAAByV9wd60n9QewsCVyGrNIyHC66lBH1V+jNKPax6JDmAyN7PBI+lvP2YGUrnKXh9k+7SFJqOfqsOagvPudeUczR9IN3R04S3qkOrvZvoI2WgVVuN3f6cDSaX2mB6cO8n3dfUiVty3SLxnipj0eGgBMGOLdEowzpF/GiTYWGp/K8cP7BaWAAnHqT3R8xNwhmLATHdCY2t7o8JyA1OGasC2J9tFZY03N7F58ZQ2Ra5LiTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(2906002)(6666004)(5660300002)(36860700001)(16526019)(478600001)(26005)(336012)(2616005)(186003)(8936002)(426003)(83380400001)(8676002)(70206006)(70586007)(4326008)(40460700003)(47076005)(316002)(41300700001)(86362001)(82740400003)(7696005)(54906003)(356005)(81166007)(110136005)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 22:53:20.3357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92010c5-1d5a-4f3b-6188-08dafd949fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform a cache flush on the SEV-ES TMR memory after allocation to prevent
any possibility of the firmware encountering an error should dirty cache
lines be present. Use clflush_cache_range() to flush the SEV-ES TMR memory.

Fixes: 97f9ac3db661 ("crypto: ccp - Add support for SEV-ES to the PSP driver")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..04059b705db4 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -26,6 +26,7 @@
 #include <linux/fs_struct.h>
 
 #include <asm/smp.h>
+#include <asm/cacheflush.h>
 
 #include "psp-dev.h"
 #include "sev-dev.h"
@@ -1327,7 +1328,10 @@ void sev_pci_init(void)
 
 	/* Obtain the TMR memory area for SEV-ES use */
 	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
-	if (!sev_es_tmr)
+	if (sev_es_tmr)
+		/* Must flush the cache before giving it to the firmware */
+		clflush_cache_range(sev_es_tmr, SEV_ES_TMR_SIZE);
+	else
 		dev_warn(sev->dev,
 			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
 
-- 
2.39.0

