Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02828737584
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFTUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjFTUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:01:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C37D7;
        Tue, 20 Jun 2023 13:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeB9Kw8f3CFlRVrXJDTQb9Y/cUeeN9kC/VFQKGvG4E4hpoIpQlx2dzglosqbQfUhcPvXUCkZjPuqWt+Z+HKzGKK5wQgc4ryMVsn+9Qhfm8REefoCWB58fEfwV4EO/Np9opGiZkXlWL4o3z5ahVr75Y1YtBsH1SSoBaVhkG9b+UqBXtnDVwFMw5KAJgUJ0TmahJc+oq4CWgknEqyiPI8DhK/V7GRy6qr4mXNss6U4tO/BKeI2Hv4gG4FEMtlgYHYbiLAqetE8gLFZnQ+cGzjrTs4cWdi2siA54fI54+ZwMbMNFLS+8Ps/aTrrIwIAkZ1p3RbzcEP8gobhKZ7rPbvW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF4Wawj1HTYVsxNIGL5RywAPAHo5TOghcaMEK5WK1xo=;
 b=HA0GJ6GJtb4jbHUIBjEHsIE2snmd3tUvQoXG9fOHO/VbAw2uebF+ixMhCFpd1g3UPvXJHaxCb0c671C9ZPmtF5Avkc0UqR1CKPuUGNjPqs9ZyYGqzeLg2/ZK9XNCRD+Ru9AbO8dDg1xpIsipHg4sQcglC0rpAgGn5uJdG2NeYa2Q3i20BWDWLrjGp7DqXtI2bgLL3uhBAW7mE/628O5Y1YPPt3mWdzdaq7jSdLXI/lqBega/9Hs1I5WTYQliw99pDGbLiQXWJ2i/XOql+WtjzkGdNjko17voHjKlhCIRwh2wYOgTrqBFQwOPtFjCpC/NE5rhqFps2QRGIa0VjKBvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF4Wawj1HTYVsxNIGL5RywAPAHo5TOghcaMEK5WK1xo=;
 b=YTey2bSxEFQN5JSOYy/0w+FN5rbdwCbF/Pjvjl/bkvLpUPgcTrG1MINoVVvW8uFgMgWq9hC1Quwu6ulfuCmxlBSRhCHME1JcJlsIcX1xhxgINiPCvVkIhcmKCmnXJc4t3wmqP9JIaVGo95rM+Apx4pFihqEadylGM9wERFECEr8=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 20:01:33 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::3f) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 20:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.38 via Frontend Transport; Tue, 20 Jun 2023 20:01:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 15:01:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>,
        "Linux regression tracking" <regressions@leemhuis.info>,
        Haochen Tong <linux@hexchain.org>
Subject: [PATCH] HID: amd_sfh: Check that sensors are enabled before set/get report
Date:   Tue, 20 Jun 2023 15:01:17 -0500
Message-ID: <20230620200117.22261-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d93acfa-2b09-4183-7f98-08db71c92597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0SC2HaK/DvrvNknZ7UDUyiMqVp6NsmELO3eo+t29vioCYjx5uKzz3Q+tGwXkbCwBY84RBZHAbGlLun25SOvtw4UuBRKKgzgTyDwDKRlpncTUZQSaKWHCENRC/IeyUvLg8hiaZccvQKo4p0z3VFmpM2XIluZNBUHp6vOIPaIRwxJlx9piMBTARiAuv30Dsv6w/pneXr9NzN4+iwOqXaW42Muv8PYoCHgxJMQsl+8EoWsZkq6mwWPqLsdJPIPb03YcebcGqTeBQ2GEIeoSnaH8cBlkdqbnWf80L307pc+GvHjN1cEVlXK/x6QWdCBPFQVsvJ8OsDlegYWm1eijaNBwRs/+0VDJlzJRXP0uiVoawsd7Hi9qHl3EKYVevu7tVdGB/mpkDm35kJS4PvWIfQ29+5gua9gikbzOv/FN8kO9tPEUKGkq7CeDOIKJBBVDkmVJ1U32gHAy87wXUu26IcOmiPweSM6slrbGqCHrH7ZcBXSCPO3V2d0915mNBSFYIHEGP2xzFwhVAxfxskTxtxMskL6jI2WVSPZ0rx+KqngPpeHRaWmNenn/WuC4bIwpd1OJkgp33uSj3nNGBDdWoWg6fLbfdIOwr+o0zexb5jQxaGBMJO+JdNG6XWp0v3hCBYIgF+VJ7buItdcXkWE+kg5wdP3fOvRIV0ASivxQ6Z7/qEXskiqxV50x1LFzmv4rUNwr5LiYGynRdboRx2cFxlR3EZP3DsSgUl8ivONey5QESHKnCN2mzZ1hH9dhdh2NWR6ORDkXIQi+hMkHX9s+Wb07w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(36756003)(8676002)(70206006)(70586007)(41300700001)(4326008)(81166007)(47076005)(356005)(40480700001)(2616005)(426003)(336012)(83380400001)(82310400005)(316002)(86362001)(44832011)(7696005)(966005)(5660300002)(2906002)(110136005)(54906003)(8936002)(40460700003)(1076003)(26005)(186003)(16526019)(6666004)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:01:33.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d93acfa-2b09-4183-7f98-08db71c92597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

A crash was reported in amd-sfh related to hid core initialization
before SFH initialization has run.

```
   amdtp_hid_request+0x36/0x50 [amd_sfh
2e3095779aada9fdb1764f08ca578ccb14e41fe4]
   sensor_hub_get_feature+0xad/0x170 [hid_sensor_hub
d6157999c9d260a1bfa6f27d4a0dc2c3e2c5654e]
   hid_sensor_parse_common_attributes+0x217/0x310 [hid_sensor_iio_common
07a7935272aa9c7a28193b574580b3e953a64ec4]
   hid_gyro_3d_probe+0x7f/0x2e0 [hid_sensor_gyro_3d
9f2eb51294a1f0c0315b365f335617cbaef01eab]
   platform_probe+0x44/0xa0
   really_probe+0x19e/0x3e0
```

Ensure that sensors have been set up before calling into
amd_sfh_get_report() or amd_sfh_set_report().

Cc: stable@vger.kernel.org
Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
Fixes: 7bcfdab3f0c6 ("HID: amd_sfh: if no sensors are enabled, clean up")
Reported-by: Haochen Tong <linux@hexchain.org>
Link: https://lore.kernel.org/all/3250319.ancTxkQ2z5@zen/T/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index d9b7b01900b5..88f3d913eaa1 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -25,6 +25,9 @@ void amd_sfh_set_report(struct hid_device *hid, int report_id,
 	struct amdtp_cl_data *cli_data = hid_data->cli_data;
 	int i;
 
+	if (!cli_data->is_any_sensor_enabled)
+		return;
+
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			cli_data->cur_hid_dev = i;
@@ -41,6 +44,9 @@ int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
 	struct request_list *req_list = &cli_data->req_list;
 	int i;
 
+	if (!cli_data->is_any_sensor_enabled)
+		return -ENODEV;
+
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
-- 
2.34.1

