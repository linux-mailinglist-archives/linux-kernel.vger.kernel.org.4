Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B556A4648
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB0PoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0PoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:09 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2394E060
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0pNs49CQ7Uoa1fCyIcTjikkLtx4xrjs3A+E785tqnk24e6YiCRqIQYtJL13CiCQv2GBdALWK9nScO5zSy2tHg6V7C04Yz7fC7xGGSdpaHlPANJgiMGSgigbqSmJtXNiXoWthiXAL9V4aPsP1KblfBhGkrawNjPFyctxHkl1HgWUiccEF8axgIeFQT8ySburBQ9uUTMbSJWRtx8M7GHqg74KQnbUIPJdlhKBEWy9AIpqadRnLktFQ15YaouLVx/CFuRblUbDu9bAVvVyHrlzLwTx5S1tdjDY8jAv/KCtV648mP9a7GlM/2vuIfYGCDux47tLMCPSRgoOL/R/2bcZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=ZW/RbS4G94mf+hdy5/4+FQ1HsTH2iXgs08V384vax1WCsLDJWT6NzRage0xKYho0JMapuTgJr/fL/dUJO9WXU/Z0IsSa+r0ON8Xs4PQlOsJ1iTdZ5sMyoY/rG3M1CFkOSs9cZ14WYJ1L776VcsY6P9XPH09gmy1VvgJRKpS4Ir2JhbDRbEHtrEqwTMjbhqE7EQ4oCBUQnRF1Ykph0tfTtrA/dm1U7ieAPCx2B+duS6JfCz14ORPRsx9DKhoxCJBog/cEjFxCoJcD0UpGSAaMvur8sL5xj9sioyD3AUxCZWbBJwAoEOTqHR7IYW63VEJWS+Czieol1a0K3lAzizJ9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=tfgET9Y97/UHGD2z9e/0f3QF1CFhr63SDJVCrKjb273KkpPWDdgjI1YRDlus40o5LPmVZYrSFTnO47SveNxQIVWyhrZ25pzHpuEvnSOXh/TPNGKuV3uOgVk4MSEfX5DEYZ889VKJEk8sDFauCYBnIe1uuYscHUPMLUnjg81fdjk=
Received: from BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 15:44:03 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::50) by BN9PR03CA0039.outlook.office365.com
 (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Mon, 27 Feb 2023 15:44:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:44:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 07:44:02 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 09:43:58 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/8] soundwire: export sdw_compute_slave_ports() function
Date:   Mon, 27 Feb 2023 21:17:54 +0530
Message-ID: <20230227154801.50319-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 16501565-2d61-473c-2a41-08db18d97413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGNPJHdQuc10/FAOR/uyAvEy8SSM3/6xF1b3dGyiwwi2nLbttnJ/vhV5SLG9wVfx+fKbZe+L0t5qV9JpjtYRlAwCQKfFzbNlm5RHNQeIzvv+AsqnCV9XEgqZ0S+BUW9vZ8w5W3A0vweE5XvhmqD+hx+va9K0SgO4TeocCfDcmqgJ9lSA2TsDkGxv6ma5vycDVVbHylSIqPjF5cr6yq7BmRNSyD4bKKFCE6mcNx0HAoHHE/ByWlbMYhU+VDBzm2K8xoy1yfcttlf8hg1j2S92G8DIt20Ujom53KHu2AtX8CVGIL5xFHQ/WDC2kt3nOIGci5sexcVyhIOR0XqsgFc75oiy4a7T3axR2bI+Dn8MN9GD8isrm3Tr/8wYWm6lz5bet67SVJhoUNoC2A7ZE1vfvV/5mUvjMo0wvyN4DbvX/CbT7PuiTFe9iJrGq3PtjWNesROPStdQjLsJm3Gg0hHosPNzg+kiXivoRPOFMiNYGSqM8hrUkVSuBYsOHICENaxo46Zw2pIGYbMqDJepvh4xA3dpkRTE5zaQC42jp3t9XP7qwzVEzP6VhCPzlOBIGUwSMifmj0Czk7shm3UsgvzoWzOngYS4cc1VmVldRGnVDVWx4XQSOzkQQWvnXh/RyagoPeFdZ/B/uqtzRJna6UNh+sszqFItAzzN88vPQSIzOYQhMF5lsM1gZTCqDlRhAr05jMnuATcqdVdCRnkwqcne4ye1LzFHhXe/SGzDaxnJkww=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(6666004)(36860700001)(86362001)(83380400001)(82310400005)(41300700001)(356005)(26005)(426003)(81166007)(82740400003)(54906003)(1076003)(40480700001)(47076005)(40460700003)(316002)(186003)(36756003)(2616005)(2906002)(4326008)(8936002)(7696005)(8676002)(6916009)(336012)(478600001)(5660300002)(70206006)(70586007)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:44:03.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16501565-2d61-473c-2a41-08db18d97413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export sdw_compute_slave_ports() function to use it in another
soundwire manager module.
Move sdw_transport_data structure to bus header file to export
sdw_compute_slave_ports() function.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230201165944.3169125-1-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/bus.h                          |  9 +++++++++
 drivers/soundwire/generic_bandwidth_allocation.c | 12 +++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 96927a143796..0ea0412842c5 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -144,6 +144,13 @@ struct sdw_master_runtime {
 	struct list_head bus_node;
 };
 
+struct sdw_transport_data {
+	int hstart;
+	int hstop;
+	int block_offset;
+	int sub_block_offset;
+};
+
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    enum sdw_data_direction direction,
 					    unsigned int port_num);
@@ -212,5 +219,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 
 void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
+void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
+			     struct sdw_transport_data *t_data);
 
 #endif /* __SDW_BUS_H */
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index f7c66083a4dd..39543048baa7 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -28,15 +28,8 @@ struct sdw_group {
 	unsigned int *rates;
 };
 
-struct sdw_transport_data {
-	int hstart;
-	int hstop;
-	int block_offset;
-	int sub_block_offset;
-};
-
-static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
-				    struct sdw_transport_data *t_data)
+void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
+			     struct sdw_transport_data *t_data)
 {
 	struct sdw_slave_runtime *s_rt = NULL;
 	struct sdw_port_runtime *p_rt;
@@ -85,6 +78,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 		}
 	}
 }
+EXPORT_SYMBOL(sdw_compute_slave_ports);
 
 static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 				     struct sdw_group_params *params,
-- 
2.34.1

