Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9768D04E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBGHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBGHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:13:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476524C88
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkKNCLKYAzCJHHxf1jPRmx6i11rpydmGnlM+USVTkmwW7pzRdncaDSx8OyPUYAu9pd0CsXCTmLcV3CmU3ys9TuIkHKJmWL6zeArXDWJ3Pt7ABWAmWLQtwyAk715UGJwXkWJYRdujrMhZogjTExdivCClScLmM2u19LxIFZ7x8ga3yiAo1brGX5XygqoKdHfQdIAHHjol/O5ltApsnkNxCS+FaIVFRjq+8PVFxdMmZHJXlt3eRlxfZ69aFv1P35fpGakaFljgLFF8hoEvysN8Cj1xGMeXFGRZaBco8E17lEuPMRRG6pttYDacTy0Tg576BQ/c2L7x7kulOcCEyRLAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThjrIk1AmcpUcepBcD8FfoNqcnyKYININc+4TCz0DVM=;
 b=IJS/3rN1hDZBw8OwTWBfQt5TiA7jxZEKuA0rauP/+ex5LnnFCnOjmFcDAtI/8hgTkph9IVY21tWPFl3oQUJBXew2ri+hRyop1OEFgUatnp+FvSwG3PT+1fYHQ2UXJ5rX4BrjuEwGMuQ7CQmTiDHNK+OTkIqhbOd9lPrR9kCFNfcjvCAYdDfbaBjKVMHtddJbHBWIM1MEmZLSHZljiqnWzlWzD2toMPso+1Go/iRF/Cx0AAo8Z/eD7xkqPeYfkHCzAAlaigdf+1JTF8PD5mRngWAhYQlsGE5IYqScYuZlvkSulcGNI0CnjpCo5xdFVdbr9YOUbz2gHNSqBQtjWHMFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThjrIk1AmcpUcepBcD8FfoNqcnyKYININc+4TCz0DVM=;
 b=bPXp1/tt0nwsfn9z36DgGxwT5L5WpWyD59p9Ki7QkslkWGSAVi8RVO0cix+62veYAvE4+Xfxa30UgxVedoLaT3qCScWWHm5pb+13X9S1N9LMjJN2ON+r/h+XKhlt1tvf3MxN5ZVbgHfMoU9GnTlNT9m3rJAFWSkKH8mjJ7b9+Ts=
Received: from BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:13:41 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a4) by BN6PR17CA0049.outlook.office365.com
 (2603:10b6:405:75::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 07:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.32 via Frontend Transport; Tue, 7 Feb 2023 07:13:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 01:13:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 01:13:39 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Feb 2023 01:13:38 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] soundwire: export sdw_compute_slave_ports() function
Date:   Tue, 7 Feb 2023 12:46:44 +0530
Message-ID: <20230207071644.3757-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ee4bfe-f557-4c3c-e5fd-08db08dad6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9ERvBpFCf8T1imtDs8zUZvLULJrJAH4Qxor/9DgT4UP028RSLgvRxAl2QIPiYuyldP56e813ISy/a9jKW17XkT4H/Ty1F2IRf2BHwGkiHJY4cXOMGV+jYwGRSBAp1GSzqvsUkZZy9umRj0V2FFniNp6lE0y+mf0bi01wS4MsA0xSmOAbua8hd0ClZhy1E/4grRajquAQD0ob2QnvJx8eMRMBZSyP10K7GkYgY/kzeGCHQxwvw6gB/PJRnSJ62254BHEu48GIAqH+TOMDe4A+s2IGjhODO1zj1syoRu+LVlYrlgTqRbuwPx25xFfvTIlQdv7xuxMZDpMBKoH8Qqr+g7EeEOnzv9ktZxv53Q5rPDN/xJDYxZppLRn6ypZdmnkt5Vw01Ylo1mDmJs9qYZ1Iqx4Z4Wg7MtjA3lH1F2hHs9L0npjfZBjJY+1DAaI57RHFTFhRAvQ/rb1ONI95NADF4xEW9rCHPXtzhzocp2kHeWmbn7Gfbpi739ly65ZL/6PgHRmlFi3kLuphjxP89XQkTxVYg27/J/G7nhVPkmbn0pPICfWwEyHcyQGGdPs8tikoruzmDA0UBItoTq6e2JA+lRsxE2fwaxamwOQr6vMLnlFNTCi1JLNKmduLM3T1VrE4OZgxbyxHKZoLX+PTGEM6yDT3SXocZp/pWJdD7OaVJXseEaKeMyxRnrN0l1NMhpBE+uCXHKGhEbpio50XOyOQTuF/bTMFWDzThVPFJ+uxcs/temkIkU0epSrBLMVgbxTiw+HOokGlJlFLRiXotbebg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(7696005)(478600001)(6666004)(316002)(54906003)(4326008)(1076003)(966005)(8676002)(8936002)(70206006)(2906002)(5660300002)(70586007)(6916009)(26005)(36860700001)(82740400003)(356005)(86362001)(40480700001)(81166007)(426003)(83380400001)(336012)(186003)(2616005)(41300700001)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:13:40.5666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ee4bfe-f557-4c3c-e5fd-08db08dad6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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
index 7631ef5e71fb..141b99ac58de 100644
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
@@ -213,5 +220,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 
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

