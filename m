Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA569531F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjBMVgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjBMVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:36:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3C22009;
        Mon, 13 Feb 2023 13:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ0+UTTTXwvVsViFI0MxAx2m98I3Q6EbajZLpHquLUlVSTGI0wcpWOzQjTOcbkBjHhWrMr/WsrknkJASz3Y4i6aEsnoiWORQfYKkorco41F4ns8wxaspcVDCYGSojxvHHGUN+llU+hbHg5oRDj6W7Arp4X9tHs3JqfzGYS02RbYGcnkGUh7CD5exuOPEs3uxLR6XpYA/arC5ZFH0OxLR4qI5to3M5pNUIQZNMESuWxf1wLbfh9HnKg+O5F4+RWKIf7z/SzEjf2Rdo80a3MiAfbssqUVn1qzDwG7a2cfydMwq/WFeeloLUEpnmnhnVt9tVIu55BXuygwEtWg+8159VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1bXrn9H3Qeo4vgmh9bVjO/jqvGKEPxn9PsYB1oQUas=;
 b=IN5ijZGAkifejimNiujLhvplbyiWmwdbI4WsiOBdMtOEPkTw7wIajbE0TVq4Wx7P4BiiZcXMtRnuLlS+qf3KckiPha/GPALAHPLq2OmUj6JL/Rwk/oglAbd8YcHWkZCqD6GPxS2Bvlqk7hIXMwDhp9YRQqdoAB1ZoEK56jnEGhks9g/4ytwOeJ+yTW6mHXio2x5K6xg00GZvkH25aHBXBMvaY2o1ec6I8swgLM/pTzcRL8nWMNhLRrl9Q3TOPORdGZRntlihptshxjV0NXE5P5M4JxYfChnrCQF/2oASwcnvjRO1WSwsPlbt1/6gwDDnBzYdrR8pK2AbKLyUb7iJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1bXrn9H3Qeo4vgmh9bVjO/jqvGKEPxn9PsYB1oQUas=;
 b=414T4DgouXnQi68gCIa2n4KLzvC5UJTkB0jr96tFKr96fKyRdheaTFW9W0yZbSMjIcUsBYyV8/QLFQWMNPhQ8TGvhV3oacJPPtDKEPQJRRWd/5IZbcbdz+vUPZ9t6r3UkmJ7sQzQ+EzozzfoYdvksf6X1TxU0mkGwOPr5sIqz/I=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:35:51 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f1) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 21:35:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:35:48 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>, <dbilios@stdio.gr>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing StorageD3Enable
Date:   Mon, 13 Feb 2023 15:35:36 -0600
Message-ID: <20230213213537.6121-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213213537.6121-1-mario.limonciello@amd.com>
References: <20230213213537.6121-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaf9bde-6204-438d-93fb-08db0e0a47a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8n7hnMhPWPtiVEKM8Rnjlr8S0poztRcFpEvv+wxafwdKSAa6hTfp2DleoQmu1nLV8k82t1fRkldNEywGl7bgHL1Ewq0f7Y6mW1IoYZ/9zVla43v+keKEGvOR8sF88uhtYulZf4xho1N8fUIlilpoEbLKr648VtswAzbm3ouZcPEy+ihb3Aa3wpnccLzQuX++1scCem9kKr17nCxSqzDeCSbX5X1ie0qsYg4rk/L35sNG0MSH0ygam2txy/xt/+sOWPhbMaj0ZjTIhZi6KmaObhrOc7fx1rD1Ez31y71xGqWVNQ+hxmJE9vgtEjLzeLB4B2Z65X5E6gWH/LDof+Z4epz8KzJRNxkjPJ4Vb/lZZ5cyPxbHe2jFj7EQz+1FjSDpIiVgpQfpIFKkyTjJ3b/5T9/e/YGIqg3h5Nr/Ls00oVk6dp/ZtQJH6ph1nt7eTKF7gdKPRVJdhUBCt1XwpGqdTOIK1UJDBA+Wr6FQqf7fY3HD/3GK2UEDSIcO8HGqJuSbhZu8op3NmqfoxmWAVtqlhAafwOynrfhYP3lEm+xTXM1jyTJq1ExIcg1CFNJycNukwqBw8mQUEg2lDGLKR1zLt1EvNNsfRBQy62/Q3eWlrbznuNTTv70rYQ70AdjImkR72D0TtCrD4KOkbhLmBKHLJfXsPrP+JXWV0+JgyFAEiXi/ZbrDMF4L3Fu7PWWAADZe3Kc+ksgudxvKMrDsv4mUQzEEtuwShXGpIwr32UsBl8UqZKIEl6MjpgE10r5QIYi93Inny4OdIv0Kuh1uPXngi2c25CkRxq5qDv4i7bqip4pTwoEK6okfpxUOUqHaa7x
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(426003)(47076005)(26005)(186003)(2906002)(36756003)(44832011)(1076003)(110136005)(82310400005)(86362001)(41300700001)(478600001)(40460700003)(6666004)(966005)(7696005)(82740400003)(81166007)(54906003)(336012)(2616005)(16526019)(36860700001)(40480700001)(356005)(316002)(8936002)(8676002)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:35:51.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaf9bde-6204-438d-93fb-08db0e0a47a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
for StorageD3Enable") introduced a quirk to allow a system with ambiguous
use of _ADR 0 to force StorageD3Enable.

It is reported that Vostro 5626 suffers same symptoms. Add this other
system to the list as well.

Suggested-by: dbilios@stdio.gr
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217003
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 3409ce6513afa..b1d24718f73d7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -214,6 +214,7 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
 		 * but .NVME is needed to get StorageD3Enable node
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=216773
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=217003
 		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
@@ -232,6 +233,12 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
 		}
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 5625"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

