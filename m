Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D56A7B43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCBGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:18:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3D4228
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:18:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8/o3FKnWXx5/gI0oP6XqTVVRgGMpTKgIB8WrGY6zGQMdSw4uFURjYdbs8f3WIu2vUO40UowyTz96E/Sl5iQA2Uud3lrNG25c0iZJVe/q1mwmf+j2jNt5dg+ahEjTZD6CJ5txucqK3GIFM9wY6vrm03gu7EIKUkgErTDXWorI+TIhobnpWnCZgDJTltidM60AP80iJJXJVprsXLMKHSfz5yxo1M3YKT6ZdFdpI5Rxx7f5dDwONzyDAs9m3gGQZX/kRZdppXuRSjWlgzZtLuJzCpT+Nq0TI3Hxowv1xaFv8unnqGqLABTaaLYxkB0U5p6TQQGMCdFGzdGrHwWIQ/GVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=ce1VSyT2Q9up/aXyu2vSwrPm+hIlSQwZlSQWQmOqqm91DlH1jDalInQfHUUn45VBf1aYrX1OQqlOAmxhFmNiKZivjXsYWNKwlpcioUt+GX034keTVYao3Ym7vtxhMcpl+IxZCPZ0gxDexYvxGEY08M13/ola6aJavhKYXCw0G/o/Amzvfb3+F68krmkyMKZEpxd38eyH4UXGbKWKv9VxRl6b0LSfbYyIlCDcwGPNLStMGH0poUdXuia79J+xYENU5NzTMMpYMlQ9cIzmXDq2pkOWQEmYSxbecM2jkVN+nnuTl/Pvxo7OaqCmo6BJFfvx9xedTCAieWBH7X7nFBcEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUrMAhuQVof+ju/n9q/rmSwMNJzF/yYd0v9PWitn7Oc=;
 b=2Nvotz9DI0fZaiWt1GjkcpZ5hNrfGaSD92jLycSrYmN+ifEkkNoqCGW73WZ7M0RwgESQ1shAxJg/TeKhsFaH5mESsRCxwK0sXCcbbjRhI3UEMQxjezhaZj5yEv5p+3j/p4LZSs0xkM6RxR3Wfzf3d1UdjeCnPWqNtHKv3R37P2c=
Received: from MW4PR04CA0212.namprd04.prod.outlook.com (2603:10b6:303:87::7)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 2 Mar
 2023 06:18:32 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f2) by MW4PR04CA0212.outlook.office365.com
 (2603:10b6:303:87::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Thu, 2 Mar 2023 06:18:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:17:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 22:17:04 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 2 Mar 2023 00:17:01 -0600
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
Subject: [PATCH V5 1/8] soundwire: export sdw_compute_slave_ports() function
Date:   Thu, 2 Mar 2023 11:51:00 +0530
Message-ID: <20230302062107.207845-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
References: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 13818eaf-fc3d-446b-a42f-08db1ae5f27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 372cou+41Ly5IcMLl9bZ0rXn0/GDBFPhTL82QKY8/mfGGgJk7xN63aP90ga6IpugglkUupZ/1F+ChMcoSFuvNmpD+5kSe4+kS9ailjC5pGPOi3ltxyxw13V5YdM+qCx3+24j0/QHVk76GY5qWIrW3e8CWjj6sY9YkWx/dVuCJKUIT8uv1wmnLoTiJp8MraI4zjL5rDpieCoV/mjfQ2hCwy8t6csygAsWbQbkFhyzZ8O/sOXSOg5tY/QftHql9UcRmKS72ardyU8onyKNt9alvCRInfocW2NNBbwRZjq56ByEQJ26L7tv3nctLCOixzGcmTzxiObIOIrkgVCnN45Nylu0HNScTH57MT2D/bj5ay/2d/nPpSp7cgCpA45UdePEj9HKdz5PDA1ZN0bEVt9T3MUuvhsPd9N5c4kFBNoqi5TmDBRt2PJssXAXYORwtc2D0dnPw4eKg03X1qle43KrfMedStOk46UIgrCrKXARz7UPDbKRZ7y1KQhE4KQyQfWoniH+Bvjx+/FnNKTLMkWlwdorVGzrRdl7cWbvpntRQokXVNNxpzCtKVBw0WEzWsaZKVVNjRdHgo8on3ytcPo2+Bh4Xqs7Ajr9J2kFCBE8WvfU9Leag4CGB3np2zF3hzgIJZMBsCnRTxeyfbwGOpZNdHPOgfG3vZoyMphRmgH2YRJhMDdsSD2KBV0/pfLMF1MK4f9H4jzMweyMwZGbNzfJ0FtgFok1+vRLCt8CZIluAsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(1076003)(26005)(40460700003)(70206006)(41300700001)(8676002)(7696005)(356005)(82310400005)(70586007)(6916009)(40480700001)(4326008)(8936002)(36756003)(86362001)(5660300002)(2616005)(966005)(82740400003)(186003)(336012)(81166007)(47076005)(426003)(54906003)(316002)(2906002)(478600001)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:18:31.9713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13818eaf-fc3d-446b-a42f-08db1ae5f27e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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

