Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB07667ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjALTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjALTN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:13:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5AE6382;
        Thu, 12 Jan 2023 11:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFjrTbLjHZfnMB4R3neyWIsGlU2RBh902Zadp9uYub9Wc/xZbsmdP31fm+WfNZpW34RZJ91dBz1Ope9eiTLv+952KKR5ynuBvD8hWZo0vI+LCFiUMdYkFRrgzO9vkmCBBHua93c+xCDoqvnxzSUDzo7QvbHOxGXtwhlIb5tAzuQa6rv/snFst3oc2RGVjqVJ5j18q5HqHw8aN6wiG5DnHxndun8Co2gC49IY+Mf01wG3vDDz7YUaHBpULh3tCAJjYXyjQqLeGtnJNYexbU2xjLaObOnTO/DSpnh4p2XhL9CGUHV9QJLDu+QNvBe9NQp8XvjOG5I2u7a9CUmC5zjhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcWz4bGvK7Lm8TTvYRIv15B/9fACHNrbCYg7PRki43w=;
 b=JqAF5c8FoLHlAkyXmnUc+IBjdsUfwy++5NGqEAoc3OR6Q0vkOdRsAnDmgMPbE6PmEA03BkBe1zQzZ19LKmj56cKRBl1qilgkNmbaAjDA+//mfEPSlK01kTZmPugIzaxP/nPVM434RntTs/6Tzcf/jagzHExTAybgRfcyDHVbcy+KN+eYvT6mpJSeoG5KHTmFuHXUgGwbRztGOiAdm4nKnDX3DvgB+Gos7usLHmOfs4EM9RNdYbWOSyWOcjwGnZ7arQRqq7A5i9+5MU5xOr3S4vJNWueQu+9/o58/6hYW3ZNhLZPqNseEcpRbnzgcA52g7fcM93WgxKRhXcHRaC3XyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcWz4bGvK7Lm8TTvYRIv15B/9fACHNrbCYg7PRki43w=;
 b=GXdxuKT3e8KNqU38Bnu9VpF2sjvuMmFR3g9TVpLMs/Uc8SjQRsQwbZAjW5P2zWxyWRakft2/P+sqcg7187XAxrcP1dXxwEcDzftePHeEKnlVLgnhiO0+fcLl6kBcVUPPaekLGe1wlErNPaxRzpZjTvpTuWpI0bvmcPcKCJGCZ1g=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Thu, 12 Jan 2023 19:02:10 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::dd) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.6 via Frontend
 Transport; Thu, 12 Jan 2023 19:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 19:02:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 13:02:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: amd_sfh: if no sensors are enabled, clean up
Date:   Thu, 12 Jan 2023 13:01:31 -0600
Message-ID: <20230112190131.24460-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a6b007-0e04-4da7-bb70-08daf4cf819f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ySzK8wWMq6iTykGT8EiJhwq6paDrcUJkx3S/M0wqBW0DH8zXGkPJ/HUIu5dWeIsLrgakYFkEVkNQD0/OAL+G4yU6AQP0NHp9A2HwClnlRSs2VPYyhHiBOYAuUhPEo74iJyOeC7gWRAaUx+5RPK+2LPDazRm5A3nlU1fn1Rp+1GzRvgkQ3wgmSoX+xy20EX5XuZUzLhjH+aCx/OEDDdME3mAxGo19nslWoQiB/mZ4yp/6ARwINyDiC1lnvQWnFvWJhiq6IUo2bs7Oo4cRVvs4m06DSLmd3twUDZUsEjfxfP6m6k0VTJN5eb+HYecQba/2EwDBB/9Dq8LBXLIjN39pcpmQRNJ9qj/aRooSD1DtzYgMd/yCE1DtdPaDe2BdH28csIW8GL+ZgMC1agL4nZyf+h938plkR5g3BIcq4DDikn8GUiL11SGWkTAORYaWbw4iwXqXWwmzGZaQ5iK/XZWx3RiDSc34La3EfNs7nhL8EUBeqp720IrN+bjnq6X3oJHHJlYxLEEwaYiYkjCaGKG0guUoMvt0a2T7lGq8uoQluoPusc2yNVmvZDTTFtBcaE9OI0Fpb33x6GH4RNngpePHc2DO0IGUuoFFymRR2VBJ6FJekuQp2rj9pjecN9u9c4suFqvUarV9zGYUUSj6tM0oz1tmAs2vK62HP1OB4pw/SUjarP1aNdbEI0jlpXrAs1/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(7696005)(16526019)(966005)(186003)(26005)(478600001)(1076003)(316002)(70206006)(54906003)(6666004)(110136005)(2616005)(70586007)(4326008)(336012)(8676002)(36860700001)(47076005)(426003)(81166007)(8936002)(5660300002)(41300700001)(83380400001)(40480700001)(44832011)(86362001)(356005)(36756003)(82310400005)(82740400003)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 19:02:09.5701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a6b007-0e04-4da7-bb70-08daf4cf819f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that commit b300667b33b2 ("HID: amd_sfh: Disable the
interrupt for all command") had caused increased resume time on HP Envy
x360.

Before this commit 3 sensors were reported, but they were not actually
functional.  After this commit the sensors are no longer reported, but
also the resume time increased.

To avoid this problem explicitly look for the number of disabled sensors.
If all the sensors are disabled, clean everything up.

Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115
Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Tested-by: Xaver Hugl <xaver.hugl@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index ab125f79408f2..7469691b4a633 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -227,6 +227,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
 	if (cl_data->num_hid_devices == 0)
 		return -ENODEV;
+	cl_data->hid_dev_count = cl_data->num_hid_devices;
 
 	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
 	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
@@ -301,12 +302,18 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 					cl_data->sensor_sts[i]);
 				goto cleanup;
 			}
+		} else {
+			mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
+			status = amd_sfh_wait_for_response
+				(privdata, cl_data->sensor_idx[i], SENSOR_DISABLED);
+			cl_data->hid_dev_count--;
 		}
 		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
 			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
 			cl_data->sensor_sts[i]);
 	}
-	if (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0) {
+	if (!cl_data->hid_dev_count ||
+	   (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
 		amd_sfh_hid_client_deinit(privdata);
 		for (i = 0; i < cl_data->num_hid_devices; i++) {
 			devm_kfree(dev, cl_data->feature_report[i]);
-- 
2.34.1

