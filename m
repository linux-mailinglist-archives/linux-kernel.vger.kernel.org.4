Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFA5EC4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiI0Nph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiI0Npf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:45:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA8B6D17;
        Tue, 27 Sep 2022 06:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw0YEs948WSlQBLqqasufVk0znBUAgxL2rvqa40ZDKSS0asLm+8f5d9U/Kmo/MOCtuFECP2J1SurI6c8ioWF4fLhGK0bwVK/qxC2VaReXd0XqDeqe50p1v3p6yGG8zPwzHIcg6ofBTVzR+DfhiZHOiaHgBnFXRVprI6RnZPkGc0Mmrad/5ipTQYZ+lbXTQKswVg+YthDss33PgbzsTNR3mLycg8PePnsCs5LTEJK1aMZzSXrHmRZ4u2m4IO5U9mGo17ho9L4IQK+Gc9+uOqSTkfsg/V8w1M5VHyPUb+it42bKG3LNOVD50bpEndbKCwvHRMhtfSCaMN3bfcaWGYDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBKHW4cQRVzbZBcgs8Ikna7eEHjwVJlhtI5J1/zrAeI=;
 b=aSR9yKBzfAEo+6KdRklpbpOe5dAQMLlhxt/afzEcEdHQQi/UVP5OQMlVaKIiiX5tOfYNi3KycHxl4iWQrNrWI7Wh0YdKcKIzH9QFqOg3XjrTDd6ynlZQAE92I8nYgDLe3Qs1h2LCAjKVLt/ivs9IcsbiGEIzVlNIQYzHl5cvIuYUfJhVibzxNVqRZXVdGiOJu/wJFBb8BAZCx4JDMlxO/nn4hU8os+r4wDrMJXjgbq1qIamF4+KUZd5ua8c0ssc3A+3gNO+E3AD4pFc/1GEuf0RtUGN5kppwVyTYdvIgs7C7XOkDAxJJKhQNLo47A9N4ifeDUp2WtSgPv+GFf6/PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBKHW4cQRVzbZBcgs8Ikna7eEHjwVJlhtI5J1/zrAeI=;
 b=c2Zzj/I/pA8gXW8c7bBu6ANZmQLGKrzuXxa/7ZPBoHyGYcl3Zq9BE7VsGzODbSrZLrn0bl/1sWFbUyXlvLo505GBr0v5pmQslI74msPfYDgNk5EIWuVOUVFr2Zt8KXvOkbgwTW4PkNE1D6ujsZ1LK4BPE+TzAxMFcCgfR5rf9WS8DllFaLfiAK6PzgCOnuKcSANOYaSms1put00ug/CJqS4U6VooJIovQRrg8vAUVT2G3hlaOu6rWqfYCks1ikc+OlmKGZPgUi+SVqln8JaaYEs+Z9/U5xUJ+I0zG17xO7Cqoi1G7wADlZIx2CYdr6MTlclWrQ2yoJpgrn0iad1ymw==
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 13:45:30 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::c6) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 13:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 13:45:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 06:45:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 27 Sep 2022 06:45:16 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Tue, 27 Sep 2022 06:45:14 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <quic_linyyuan@quicinc.com>, <quic_jackp@quicinc.com>,
        <saranya.gopal@intel.com>, <tiwai@suse.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <waynec@nvidia.com>
Subject: [PATCH v3 1/1] usb: typec: ucsi: Don't warn on probe deferral
Date:   Tue, 27 Sep 2022 21:45:12 +0800
Message-ID: <20220927134512.2651067-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed6471a-ad58-4b8e-dd82-08daa08e8acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8MkxPJDoGQcQohfI0q6sxgEHAdRS9Ebtajg8E576jRXDfSxPSElrQbl8gvlDBbtnI1kv3ozGeLmGN9aFNCfx76xXe/Oh/gthTp0qAt0vWh37Qe9lzhtcBbcUo5C2zBWmxAiLB1faL6HcJ33fiOO3xnMmYxxsMnrIRMWHPne8rFPLSqAa05aibNK7tcD7VyRDkWOpg9gyuV2AeY1GDZ632eqsKpAtqmtr/4apcRhDV+lzDkfxq1sC9td/jitArcH5mgiL4EOWQMJuWo8yTe4yn5NNB9vDGLNSBMB77chkxhq4t32X8h9u4vVu4cm5aKd2PB4ybGlkVGom7H/10Q00Uh1C/BbxRe7frKCrstCY/c7GFYI+SjeOKoRg7ZePuXetPQpuFN35lSbHZOljwlDA/X/YEo69cJBhy/7jdOPKW3AykHkejjO85wGWbfoiHt9oC3iqOco6Or+/xg1qH8B/galX8RVZFubyHaeO537AEe/VH3++rW4bi8eEWP8O4wMCiLLQHYtMnuBmIBzVyKC8x7g5yT/Gux9LO1f+U09tIJmiagntMVIGy9b0lTtJJSneeV1XfV7ORXDly4EfscBi8Q3N68G56y3lEXcgy5asL2GwPUaPB4+Y6b5GnKYdb/w7yVr+BQCgBYLCoiuRwFDkHc094GuaAFkyE2bUyQZOEetl+GAYAYsuWGBXLoVzKbPE+hUyXozgrTOrT/X4F8zDNobAe+Ul9mH1X9+/Fy23vyGH3NXcnaQkpZcN8xa1Td8pOfwfpB67RYw4CcgEMwavg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(8676002)(4326008)(40460700003)(70206006)(70586007)(41300700001)(478600001)(36756003)(7696005)(83380400001)(7636003)(107886003)(54906003)(82740400003)(8936002)(5660300002)(40480700001)(110136005)(36860700001)(2906002)(66899015)(316002)(86362001)(82310400005)(336012)(356005)(1076003)(186003)(47076005)(2616005)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 13:45:29.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed6471a-ad58-4b8e-dd82-08daa08e8acb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for fwnode_usb_role_switch_get().
Given that the driver deals with it properly, there's no need to output a
warning that may potentially confuse users.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
--
V2 -> V3: remove the Fixes and Cc
V1 -> V2: adjust the coding style for better reading format.
 drivers/usb/typec/ucsi/ucsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7f2624f42724..e961ebecd7df 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1069,11 +1069,9 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 
 	cap->fwnode = ucsi_find_fwnode(con);
 	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
-	if (IS_ERR(con->usb_role_sw)) {
-		dev_err(ucsi->dev, "con%d: failed to get usb role switch\n",
-			con->num);
-		return PTR_ERR(con->usb_role_sw);
-	}
+	if (IS_ERR(con->usb_role_sw))
+		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
+			"con%d: failed to get usb role switch\n", con->num);
 
 	/* Delay other interactions with the con until registration is complete */
 	mutex_lock(&con->lock);
-- 
2.25.1

