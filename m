Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D969C829
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBTKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjBTKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:01:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF215C87
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:01:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSq+aO3duKP9AhrxrqYompeOq+q/gYoZKW0DwJafnaCErYFUNW1bnil4+11joBR3Tfnd3hodumTUW62Bn/EXH4jwq5pAAJ1H62WEnsqkjPYJUS+1DjFRBSblwncjFnXcoWjj36wwgJeaH1POge+8d1z0IhctDQvV9hurjQBTIDGq+Q4oNQqrfM1DAlPZKpyiYB9udhOWhg9aJQjOtZo1nx2XjW4WEo/FZq8A+1aLnD5hM8gfiWudjMJ6ssZxYDOIQecgOAFS66Hi7pOY7C73X6k0klF3Y71e6Zg1fKNNKmvTDu4TtU0xQz6nj063UhpLHvsLP8XiircDePklKUTJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=fvJM4T64KNR6vctUAzSAp417J2hgzzcJwdEfVT4gJ2FoqqO3n3P5caZexdxKUeLc+S855yXK+1HdLyynVzo84rtnCJBbU50+dgYMVbMDjCiS1jCGQ2MxkZD1FJ4LSqk0jSJMV1J9LnIDlMgqaCNjYv5GUGOhbP0cwk7FRCPT3PiLwHSo8E4uZEWwAcCkLUav+NdjefdrRSL+3AM85gP+EM0+RtTk5n40KpJqXWJZUDActLuYEDNvfGZMA8DxuKmulanoDawwoU+U1xmVYHBv7Nval76mcEPoBIIRUlEAfC7hE3aUeDHTfpd6yRoKMSGFmMtnKJDsc7ShFAD0SOR3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=1p0ZqUY9EjCoMssGVwlWAssgQV46XbzCtZklQDr2BsVdHRKKHnG0MvltkFKldGJsysalLgo6YnMO8Zkeub4VRi5BGXGOQUn5ghkIU+ZmEhj890QDvUbdu9522bpYCd5bXsWnAygupHwQaTWGNL2clbuFt7GPG60geRVvL8pE/C4=
Received: from MW4PR03CA0194.namprd03.prod.outlook.com (2603:10b6:303:b8::19)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 10:01:35 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::57) by MW4PR03CA0194.outlook.office365.com
 (2603:10b6:303:b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 10:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.20 via Frontend Transport; Mon, 20 Feb 2023 10:01:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:01:33 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 20 Feb 2023 04:01:30 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>,
        <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/8] soundwire: export sdw_compute_slave_ports() function
Date:   Mon, 20 Feb 2023 15:34:11 +0530
Message-ID: <20230220100418.76754-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c8e596-d42b-4050-bab8-08db1329731a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgKXt3z1shcQS8a7drTYUeX73kDx7TbsKXnYeCdzZYdceKUCP8gTp48z6f4/21dHNnsybTlQNm/ANlLjcrBC+M+XvVAirOtB2Etjt92M/hTC3MoxgwbxF8f+nNAy5DCo3iCSw8VEETh3FFE8QsT/k8i13ppvZjMeka3ki85KXUDDFHkcBxUIj6x+tVguOR5EedtQAXCOIz3rKUDXGMvNgoByLcmFOt4ai3eo8I7mZo9sguv2T5SyDUhQgMT+o02OtJ25ohA3dx+kprBRdgHxBZrqRTZE+yFdY1fj/y96bCx7BiWOkBlzpdSolsQljm4FB/I+o/2Whib1XmZTHMCCkNVZSElgZjWSjKQhLh9Ego2YHMNnzOK2GLGXPbGhd2dbpLyXT+bwe7wF2P8kVs7Xkc9p16CzfSOXbKMY+8ydQNev9x9xX+JWDSBiMhdrJgnMRFkVNgZ0SiuwB2tU4l3XC2OOPkCquRWOUYcsfSDyxUDngxzyVSMtYEo630zBroptbh1PtH7sf+z2Ey2FuAgm/60kHFNxbYP0nKCM7n60YqsamlfGWNkzgouawCgUt45fCJq91aD/a0k1el6Mf4+KvTQxasBHIKYBVhvVBVLALcgqQOJB1OaBcGAHBKer/79bvXvcfW1tBbfdMSjUrbBGedb3XNV2mKMUqUfzUiYpPYM3FeyPPGIhCdcXFsZJ8kO/55vVUlQxuVOtNIbWMEmTvY9UDdmerDNh3vY3Aoy3tb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(186003)(26005)(41300700001)(356005)(82740400003)(6666004)(81166007)(1076003)(5660300002)(2616005)(36860700001)(8936002)(478600001)(316002)(40460700003)(966005)(86362001)(70206006)(70586007)(8676002)(6916009)(336012)(4326008)(7696005)(82310400005)(47076005)(426003)(40480700001)(36756003)(54906003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:01:34.7056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c8e596-d42b-4050-bab8-08db1329731a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

