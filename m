Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9468A5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjBCWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjBCWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:11:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399EAF507;
        Fri,  3 Feb 2023 14:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9ObeiM/jrOY2JKkR4ne3LQjCrULo8MLpeOjZvkhUjPrsXV0lRXaV1pq/a4iZF1i7HCOtt3BrEqqNlU1cLPUvMyetnIsMhK40c+5hBK8+ynOOP+So6MEwJ3wZ+/EqJBx+IqiAHotJoxGK6XmRh4bP370TDR6MNe2Yw31njw1ZyWjnFPV3RUJy93uwAMthilL/TxSnp4QP8gCdLp9P/iyWe7TbRbb6DkXmz9eLOAB5l7ttoDeDv9Tq5XiCfIvF3tBCvqpARmz4LO9Fb9beeLezgTl1YcIsbNX2kIgrBXM8QXYV4ZKhjfGmGKIiIVqJ9oMCS0Q3qaU500flDcyYhcq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+x5ccW4x02WYaNJ9Rz0NmnKDMIdRwcX3LDIqsLWlcA=;
 b=icz8RGGyRqoXnNyqHXj1g7YLhWJFtAy8dPVcgtsruwhSRkG3CWYX0FDVC0TkyMHKL5av+6Sg9Zv89PiHu8aZksIYGHQkTi5MslZ74A1VZe0Mn6XZFVzp1tqD3o3b1FDCKwoxn/hMZeydCjmylobLVFYwPYxBgi8pQE5PvdHOR3b0ptcfNQNXA0ktp2+xoi9dC4vZOAiudqVwXdygK4s+UP+6myFnjTwPPoOceGae98vDO5JQiczjnCVw/Xk6Y7+e/sbQG6nBrvvixMDU2tk1IKCl/s21F8XOE584uL6yJyVPTxN7UmKpI9oPROuno+G5GVTtT+7jNekH+KEezl32vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+x5ccW4x02WYaNJ9Rz0NmnKDMIdRwcX3LDIqsLWlcA=;
 b=PsriZny04PqwRMUhtee5NbiZRCgmSFTqO3Ogmmss0By54pppOkzBA9B2XbaZtiNcR4v+yxJM7TV7deu7+GqV3wBjenuh18oCSaq+1XRICZ6IQHpbG0Dbp6IRPpfvoAoJAkSo0WlZ6/fYbW64CYAYPxckTPymRLhuSSPQc7QvM0U=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Fri, 3 Feb 2023 22:09:03 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::38) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 22:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 22:09:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 16:09:01 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] HID: amd_sfh: if no sensors are enabled, clean up
Date:   Fri, 3 Feb 2023 16:08:49 -0600
Message-ID: <20230203220850.13924-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2324cf81-8c83-4350-9430-08db06334230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43UiYRG5ji2S+ebZfxkPdEgP12qnXSYu7Di8uggOabPaP/6hP7G8RWvP82AMtQllClRAzjebJ15C4ltlAZLYj5amuq68i2UfaGFX1YcvijhllI3dX/Wwf9npMGMP36dUS/Peldh5QYgiD6TOP2Kw7RBwwQhmq/RLR/g/O+9zWBs73ziNtT/yIf7QW0FA9JyWf9OXDv71GBfeArlJdMJ9H2rgTWlGvVThuR+B62eeVjea5LfQlOKyzDZAqt7bpKw0doFlJ/kxWNVnP6UmcGWSn42/mrWll6KoNy6uCpwF1n4dGFVDHT4bw77RbhfH2EP//oPQ0PaioDDjOHEsoxdOFNuLFQxWV4gNqlUDOBtZ5CvyhGPe5VrYhvhhgWjN12/a0UuwIeBZvo5rH/uf3IVpqk0H/ClkvXo6eAZn7+/aXt8hza/CxvyzN4ee1mveDfJJQrbFWaO3cnLr1gjRP9wBrhFnnVp5EbgBkQezQzuyt6ZVJ3IsTXMpnMPwLlcW4csKJs+2e8Z2vFF+v/FSehXOuhH6wPrM4w5wMSJqpg1YXu2YVFV6Hm50jACm+qRBH9k/Vx9CNwMKYvQPP2Jgn4C3p1E4twmbb9w7fTFi735JRVb631BvtMyGSu0vLhi/1OOVwPGKbqSxAb9mAmw1VAW3/kKZeiMTIwDJi8jYbwUzzw2ds+Tn4EC6LQK+/mOeZS3t
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(336012)(6666004)(82310400005)(316002)(47076005)(83380400001)(426003)(54906003)(44832011)(36756003)(2906002)(82740400003)(110136005)(5660300002)(70586007)(478600001)(26005)(40460700003)(7696005)(186003)(966005)(356005)(8676002)(16526019)(36860700001)(41300700001)(81166007)(70206006)(1076003)(8936002)(40480700001)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 22:09:02.5698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2324cf81-8c83-4350-9430-08db06334230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use a boolean parameter instead
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 13 +++++++++++--
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 1fb0f7105fb21..c751d12f5df89 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -227,6 +227,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
 	if (cl_data->num_hid_devices == 0)
 		return -ENODEV;
+	cl_data->is_any_sensor_enabled = false;
 
 	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
 	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
@@ -287,6 +288,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 		status = amd_sfh_wait_for_response
 				(privdata, cl_data->sensor_idx[i], SENSOR_ENABLED);
 		if (status == SENSOR_ENABLED) {
+			cl_data->is_any_sensor_enabled = true;
 			cl_data->sensor_sts[i] = SENSOR_ENABLED;
 			rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
 			if (rc) {
@@ -301,19 +303,26 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 					cl_data->sensor_sts[i]);
 				goto cleanup;
 			}
+		} else {
+			cl_data->sensor_sts[i] = SENSOR_DISABLED;
+			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
+				cl_data->sensor_idx[i],
+				get_sensor_name(cl_data->sensor_idx[i]),
+				cl_data->sensor_sts[i]);
 		}
 		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
 			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
 			cl_data->sensor_sts[i]);
 	}
-	if (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0) {
+	if (!cl_data->is_any_sensor_enabled ||
+	   (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
 		amd_sfh_hid_client_deinit(privdata);
 		for (i = 0; i < cl_data->num_hid_devices; i++) {
 			devm_kfree(dev, cl_data->feature_report[i]);
 			devm_kfree(dev, in_data->input_report[i]);
 			devm_kfree(dev, cl_data->report_descr[i]);
 		}
-		dev_warn(dev, "Failed to discover, sensors not enabled\n");
+		dev_warn(dev, "Failed to discover, sensors not enabled is %d\n", cl_data->is_any_sensor_enabled);
 		return -EOPNOTSUPP;
 	}
 	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
index 3754fb423e3ae..528036892c9d2 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
@@ -32,6 +32,7 @@ struct amd_input_data {
 struct amdtp_cl_data {
 	u8 init_done;
 	u32 cur_hid_dev;
+	bool is_any_sensor_enabled;
 	u32 hid_dev_count;
 	u32 num_hid_devices;
 	struct device_info *hid_devices;
-- 
2.25.1

