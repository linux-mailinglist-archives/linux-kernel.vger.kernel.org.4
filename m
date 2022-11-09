Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914E622CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiKIN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKIN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2F1902F;
        Wed,  9 Nov 2022 05:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1PIthNnvRFk4zpXbFfuCdNfOLXVYH1cqLAI091gr/5Yk0JCY+PxmPvw23KWLoArQxoiBISTCexUzp9Sq9lInOCZJPx4pVb24lkKRJKFNz6gYBES3BZNfMZctL39+n2KyisVhYzspKiIpaaSs2iExPVGfkcN3bN3sOa+kPe3H5yQQ92VdZfgz1rWgoj/AoFlV6DZ1lnx7KoMt0IWh/O8peUw8ugj/WmXZFSkapTNu7j/utg7mfonClvC8Yq43viveRtVQ7FePDrvaFZix/zdttHyxeTU2s2E7e3iwSrg0F1BxtKWes0PNpJSnYO6vJs2IToDZ0mPZgwZYAPBbk+mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9RlA3tFg+blNCNHIlg+bLgQn+L/zJY2OAH8Chbcr1A=;
 b=ZQvAPQIZ9vW8h7AcbfySOloSZWywdQu+Ai4C1zt1bB45tQx6i+A2+Jpw17DR/Y6d0ogLgCL2rShk/6QeFQoWHvMXjpFf4xNuQy1XwwgU3zMbPXnEQWeloKpQvwC4nQtz+DqHodflxI6jx9wH88sXWqrSmzvztcxaK6q3o4m3A4ajiICXQfqr/k2GX+u9VJVlKVcwyTFO/IgpdB3M1esRdp+v3u7j2bZwg98n45EcpyybPThajTS6uhnq62eIri5zVlTijkVs5A322Nk5AdYkU3352EIH//K/61QzQljvxRZxH3bUEP7Cjp10lU6EFS1VxjGZaz+utWIRy3fxCDYHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9RlA3tFg+blNCNHIlg+bLgQn+L/zJY2OAH8Chbcr1A=;
 b=MTR8HSwCCHHb64yqUXvlUejjPpDyPUPZtnm2UqBHPrLQMGcJu1IZbRdPw7EidV818C09+Z0/0v6ERD8uHdiwZZOkPh6G7a89HE7jZbuNZzM47Z7aXl4mwR7G2dKl6nsv4QyCpJTCZPNv9c8DxguL0jqpg3Qevsv/WC9Prbsxt9Lq/lfz123/plyNygWpeP2t1eIsvL2zpLbz/aPzdVtr4dDcSbs69od+K/t4impxQ+g1jU+GoZRu9ElzzB+v1JgmVGfAdX2vJ98Kg7f2aOuYHUfT3U/gO9Lx43zdqBIIMlt1MORJ4E73xd6XN/MBOW/aGvDJPmz0GeFmbnWCHpKC+Q==
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 13:57:31 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::75) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23 via Frontend
 Transport; Wed, 9 Nov 2022 13:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 13:57:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 05:57:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 05:57:23 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 05:57:21 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 1/4] soc/tegra: cbb: use correct master_id mask for cbb noc in Tegra194
Date:   Wed, 9 Nov 2022 19:27:14 +0530
Message-ID: <20221109135717.3809-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9c0f1c-2e88-45ba-d6d6-08dac25a589f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VIR7ZfUk4+VlRzBZmV9ZpmK5vmpEX436+a5tHW7FeIPysXPRlx6qgbGHUkB3tunuu4C92XMxgIFrzK8pkdkrePpliJb8ccWhP6Bp+OZTb6DQnPVs1ihVKq/iE8FUJgi057lY5eSkPjvSDIH6nqGYa18aVZFIVPPPPdilho5ENfnLRD0mdC1wXhsrS72ORv3hPK4c+X+moiaBWeyr617URAyHs+9m7F/4rO4EMFABXpnZ8NZ60tV9aPv3OBKiU83qPwOm32HW15mNOuT8R3GBVSPQO83FzA694MWJv7Kp2L0QGKFbZsdYQtjokNZkdC8lDyKdmLgHySInCnHHZOB14BQsuIID/UH4W7gPQiXrKqoD55UnWQ1RVB2TarFR7JCcjFl/pT620mfZ/jYO++Ao3PWJsDdw8Uvw80O1ZvGCGSz26Q+95asOjQn/CnAJXWFKg2Mg3QmFJQPK5mxkkoCsBo5rrp6jIKFyeQpVo7vkbeqeIPtDH9WEhDFo/XgnFvqZwgbmhYdfjw381yy4TWq2+8y7qkOVa9hY90FdcxBB/R8ZxRjt4wmJLnZPG2Wt+F0Q3GKbUKBA5xtGDpxu75NjWWQpR6GH1ikNx0JKQXnCP+n5uHJlMrfxg4/LlaEHlf5wCGrrLnertlUdLi4gAu3FjM9yGHy0PqfoWq9MuEtgHaV5UjGngi9TtNq2Hk6IckT8ybSDPZlwgyfZX/faWIh+L62h+2/yE3BEPIS8aiSrqApJsE25/6wvo4DscrnnwSOQwCie8ndlhlyciLphmvpkg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(82740400003)(7636003)(356005)(86362001)(40480700001)(83380400001)(336012)(40460700003)(2906002)(36860700001)(6666004)(47076005)(1076003)(426003)(107886003)(186003)(26005)(7696005)(70206006)(8676002)(4326008)(2616005)(316002)(450100002)(54906003)(110136005)(82310400005)(70586007)(8936002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:57:31.5124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c0f1c-2e88-45ba-d6d6-08dac25a589f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Tegra194 SoC, master_id bit range is different between
cluster NOC and CBB NOC. Currently same bit range is used
which results in wrong master_id value. Due to this,
illegal accesses from the CCPLEX master do not result in a
crash as expected. Fix this by using the correct range for
the CBB NOC.
Finally, it is only necessary to extract the master_id when
the erd_mask_inband_err flag is set because when this is not
set, a crash is always triggered.

Fixes: b71344221466 ("soc/tegra: cbb: Add CBB 1.0 driver for Tegra194")
Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/cbb/tegra194-cbb.c | 14 +++++++-------
 drivers/soc/tegra/cbb/tegra234-cbb.c | 13 ++++++-------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 1ae0bd9a1ac1..2e952c6f7c9e 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -102,8 +102,6 @@
 #define CLUSTER_NOC_VQC GENMASK(17, 16)
 #define CLUSTER_NOC_MSTR_ID GENMASK(21, 18)
 
-#define USRBITS_MSTR_ID GENMASK(21, 18)
-
 #define CBB_ERR_OPC GENMASK(4, 1)
 #define CBB_ERR_ERRCODE GENMASK(10, 8)
 #define CBB_ERR_LEN1 GENMASK(27, 16)
@@ -2038,15 +2036,17 @@ static irqreturn_t tegra194_cbb_err_isr(int irq, void *data)
 					    smp_processor_id(), priv->noc->name, priv->res->start,
 					    irq);
 
-			mstr_id =  FIELD_GET(USRBITS_MSTR_ID, priv->errlog5) - 1;
 			is_fatal = print_errlog(NULL, priv, status);
 
 			/*
-			 * If illegal request is from CCPLEX(0x1)
-			 * initiator then call BUG() to crash system.
+			 * If illegal request is from CCPLEX(0x1) initiator
+			 * and error is fatal then call BUG() to crash system.
 			 */
-			if ((mstr_id == 0x1) && priv->noc->erd_mask_inband_err)
-				is_inband_err = 1;
+			if (priv->noc->erd_mask_inband_err) {
+				mstr_id =  FIELD_GET(CBB_NOC_MSTR_ID, priv->errlog5);
+				if (mstr_id == 0x1)
+					is_inband_err = 1;
+			}
 		}
 	}
 
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 3528f9e15d5c..654c3d164606 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -92,7 +92,6 @@ struct tegra234_slave_lookup {
 struct tegra234_cbb_fabric {
 	const char *name;
 	phys_addr_t off_mask_erd;
-	bool erd_mask_inband_err;
 	const char * const *master_id;
 	unsigned int notifier_offset;
 	const struct tegra_cbb_error *errors;
@@ -525,14 +524,14 @@ static irqreturn_t tegra234_cbb_isr(int irq, void *data)
 			if (err)
 				goto unlock;
 
-			mstr_id =  FIELD_GET(USRBITS_MSTR_ID, priv->mn_user_bits);
-
 			/*
-			 * If illegal request is from CCPLEX(id:0x1) master then call BUG() to
-			 * crash system.
+			 * If illegal request is from CCPLEX(id:0x1) master then call WARN()
 			 */
-			if ((mstr_id == 0x1) && priv->fabric->off_mask_erd)
-				is_inband_err = 1;
+			if (priv->fabric->off_mask_erd) {
+				mstr_id =  FIELD_GET(USRBITS_MSTR_ID, priv->mn_user_bits);
+				if (mstr_id == 0x1)
+					is_inband_err = 1;
+			}
 		}
 	}
 
-- 
2.17.1

