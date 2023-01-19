Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753EC673970
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjASNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjASNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:05:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748B7ED43;
        Thu, 19 Jan 2023 05:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lafcwe6ON+vqqxY2VzqdznyCpIzS7sU7C5uiEhzlHEk+onbwdlSZ3f1IegG33VrGdjEspAjD88UwSV+QNvbp/AlUOyg/1K4J57798HF5w3FJQdRbJUHbHZspDXSoEb87TUd9xsVOp9S4Tkt2pL2QIQXQJdepxnMUm7aN8ZNNkTZlkyPzQRs6mJauWhvPLQj95k4sY5pS7c+qg66FWjrWrZ32bcWWgCLj2Ni5R7sVONnVImIlFwpBxCbAijtSQT3oeojvM5OxCOSiAAO7dc4pXQZqP8IAsthZXYSQx/DjZIGNo+WcZ7BXlmVeLR1JnHlD4MTDab3DnWaKdcrYNcpAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I80IDrMETKSFhfzESFRMZXokS7MwFUuxK4/Sk3mH6eM=;
 b=O7zgvHqaxbKWLEmBUU0XEZgnmoT//tufpbwa1lgPRoZQZIgrY6+hwW58ZkMyEVr5YPzL7cZPiqBnHm95oE0qyYpsrqVqSqhskYCtocCP6evcR5YYN82ZXPNQnJeUwBRgPhbcSEpJ4Pka1bnrwRW8SdlthaP1s7htPkyqlGfx4NuzkYrNLUT03jBMiQ0rTqZXF8AdcKUJ9qJ6M+rjxvvFIZACq6c0fO0JTCuHqyg/Ewm8zCNxUXeMpQGoctalDlTv9AMR21QZXZPOiLoQXbQxqFtpqbQ5DWT+HXGPVO6mNVTOhgqBux0jwWPJpcvi2IU+cxZTsyt4DkJBIrz3+qn05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I80IDrMETKSFhfzESFRMZXokS7MwFUuxK4/Sk3mH6eM=;
 b=AQmN4DV3kGjNJeCoKqfocMFTabp678x7leb4J1Ze7YA4+STJDI1raHXFEKwAscSdZdWhQWJ76M93LL4pyOz5LRiC25dcJt99N7ZHX7+XO4hTUEfSXUr2AuXmYLjSgmrOGNLCP1Twv4Sz4FT3zdTKwOkcFzBUj2NFWSPlKYsd67s=
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Thu, 19 Jan 2023 13:05:13 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::8b) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.17 via Frontend
 Transport; Thu, 19 Jan 2023 13:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 13:05:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 07:05:11 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/mbox: Add debug messages for supported mailbox commands
Date:   Thu, 19 Jan 2023 14:04:50 +0100
Message-ID: <20230119130450.107519-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb196b7-3c2c-45a5-665b-08dafa1dcda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06PrbHP4lKtNtev7P8KOcjkDAGWFHC2VsVll8iLVCcsetqoYqgSa0GRf2Q7xUAccyu4LUHCQ6d00h3gB4kDdvTsLVegb9SuwAQ+CEFg8Szc/g0UmL/7yWFpAax65vwHQth7i4QfoHj+doOVvzY1Fos4ZgqTbhHVr7huZFRIvtLBFZW8iFnm05Bpz5dut+FdiJ5hO14CRIZ4BCl8gX38WioPzQpNS2NGZ8z8xEwgnjkH5kUZIa2SuCATK51I4rZlL2XJ+S2/ZPObqlHT1AKRseBRscoRq2uVYXQIceC8Vk+Ya/rRXB3s/M3Q79u0gqfS9pntDcuyjXCDX2smpFjDMJhziEGrYHKGR9Otxo+DvFzr3oR/JNA6xqpNCKOul2Vv06kJZkztmoTDNBMt5dQDYdDaIIrbNmeW7a86jXILL4dB5S31/zgsuCU6KnsSdSKjrKEIjkBP+r+zY7NKRJNxIui4Oyn05cUBbDlYRP8RQQARnFGtjqOTO2oSM4SWNOUIDu2nJ+5lMVOPw4WmNoNOLjZQndMFBllKz7daLxzKBReQXV2fHuuYwjT6AluHDNSIBLY0yqvKHrXQHkie2in8q4jvVIM9Uu75+m1/FgAhfgy3lkGGn1nvw3TGJE07efTbxBVkwmEcujh8WG4oGYcuGadVeDiSyrrTBVNXco/tHjAJxsN9ov+/mc7B9q3+IzKLhiWnRR+yQkOsAC7BY9+nr6RTGGCbx2FvEiEgcGgwUWBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(356005)(70206006)(2906002)(15650500001)(4744005)(5660300002)(8936002)(82740400003)(81166007)(36860700001)(70586007)(316002)(47076005)(54906003)(6666004)(110136005)(426003)(478600001)(36756003)(82310400005)(8676002)(40480700001)(4326008)(41300700001)(1076003)(16526019)(336012)(186003)(83380400001)(40460700003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:05:13.6729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb196b7-3c2c-45a5-665b-08dafa1dcda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only unsupported mailbox commands are reported in debug messages. A
list of supported commands is useful too. Change debug messages to
also report the opcodes of supported commands.

On that occasion also add missing trailing newlines.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a48ade466d6a..ffa9f84c2dce 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -629,11 +629,12 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
 
 		if (!cmd) {
 			dev_dbg(cxlds->dev,
-				"Opcode 0x%04x unsupported by driver", opcode);
+				"Opcode 0x%04x unsupported by driver\n", opcode);
 			continue;
 		}
 
 		set_bit(cmd->info.id, cxlds->enabled_cmds);
+		dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
 	}
 }
 

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

