Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4667AD14
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjAYI6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:58:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BEE29159;
        Wed, 25 Jan 2023 00:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoVJMDhDADSAjh3DpAw8jhWK2qxhDws9aNqQJQGIjKYo1Lbsp5i0VMtrbqwQRU82JDtlINrV1c83cnFHLyFnaJ6eapWSg7w3Rr3DF/wKEiDO6sVFnUbS8e/HzxE5WCXQPR6Xnv+ST7BfpObm96EbtAG9zz6arV1xZRMnElcKDeRt3F/8LQU6LyXAZYLQdoKvNdx1oyTJltX3tsefRQLh6TsdO2+NsesPVd7U0IOuczRE8C80ppVTZiqrSUL/mPD1w6sHt8Uicf0V/ewIkn5tGPy9aeC9Zl25X/sfyTmmAylXJ3uyfOrXNBONAgfb+MTD336FE4Sw73DZtxvhOO/YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QtO7hO449bahb0egpuEwBt9Uw6IhzMbo72xTEehkwI=;
 b=JuaDJ9HMNiZMrkidSWkyIs9mni1yNST/GmpGl3z0r8RQK4e1jfLusfVyYBPVSusK3AhD409pR7moGOp3FljdNc7yD0LLyuuk8WO8HFH/IJC56mdQY2LDo+Uo1vwuQ1lt+oTA7qrVppo0bMuuUen0QjF84QzCbwOORFGugTSJi8ofFaiHejo0AkFSiValBv1fwDyfoxYcr69qAllCUi3Y/XCBCdXbrWl6o64GrweD0cJu8QQ1bUXh+WEdc5KMVwc5Z7IdJG28zostbFNwvPBWCoHqDMXLDTN4DYp//B96vhUmCE45gW9qoY0cJmU4UIBDpF2U/OVpRRG757ReZJTg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QtO7hO449bahb0egpuEwBt9Uw6IhzMbo72xTEehkwI=;
 b=Fw4cz7AGgk961ihrweXSOVudO34wqAR2Zct82N/2iFo51gkBPbUZA/gGrnHec1h77IJwJP3qjvs0nhLVRguApIvJDapey8gTjUSIwq2Ws+jQOSqWEtjlNEFKh538emMfiO8cxuD1GFEccMHQ3xGS0p9B7VKLLa4EYzU/prNgwgM=
Received: from MW4PR03CA0178.namprd03.prod.outlook.com (2603:10b6:303:8d::33)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 08:57:54 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::63) by MW4PR03CA0178.outlook.office365.com
 (2603:10b6:303:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Wed, 25 Jan 2023 08:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 08:57:53 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 02:57:48 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl/mbox: Add debug messages for enabled mailbox commands
Date:   Wed, 25 Jan 2023 09:57:28 +0100
Message-ID: <20230125085728.234697-1-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|DM8PR12MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: c729c05f-87c7-445b-e092-08dafeb23e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fXdd9LNAfU5d2wdcIekKMdT7UGzECGPofsL94nbhLAvMoOwBkfIMH38n7VLLH7r6VNaiAgzgRMvcBsUlyTapsTN3aeXkWpTuRDfe0uD9J0aUxqjwrMuxhBKPV+QqyPH35RUwg0OL2gLkzUV27V/11RvsunKfSui25y+Ld157qUJZJ48uN1nt5JnXEyKHwWpjYITRyKchO33d0Mkgrx3uiHw1G7nW5ZtDVOj3zeYnQrvOKetRRe+e2GMGdlMum8aTJxwt4KktZoCr1IihsOMT3xrWwERvtYEa8qxTs5myXUru2phYZ8pRnrpMDSKYszzgT0ZJn052lI1TLHENrgjOQtJmgVi33R7IlHAgg01GJcD1JirCRrO9jh8ViyM7lrXN6EarL/0BDN41fnar3QHSgEQVwDUkzHpw7mOvkjWJWz6Ueazjq/EtBqHj7Q5Kl9dycbgBO22j9e/rF+lJPBPffL/6j1PGIhBPcRqQIbxby4TpKLTPMW4kWpgpo25g7Mo3kC+bulGb7/JBvzrxEd+k5SCG+N6hJA8ViiZcTV8MUtsjOouRkjbXWB/k9d1sNOBDRoVGKydBV3scdoHZQM8vVqrm620VI0KirRmQsfKi0oT29kYd5tSlb1MFyj2+7rkl5CrAUP6+qC0V5lLqmhLZ/BWilxhGcMhihYmmut1dVlHXgmAcKSW9gh4otTyxUYRjPUFUwGTM7G3fuv/esOLGaUMM3c8t3RC/sQ+qrAquTQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(70586007)(41300700001)(4326008)(8676002)(54906003)(36860700001)(110136005)(26005)(316002)(70206006)(2616005)(336012)(8936002)(356005)(1076003)(81166007)(5660300002)(15650500001)(82310400005)(40480700001)(40460700003)(426003)(2906002)(16526019)(83380400001)(6666004)(82740400003)(47076005)(478600001)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 08:57:53.2125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c729c05f-87c7-445b-e092-08dafeb23e8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only unsupported mailbox commands are reported in debug messages. A
list of enabled commands is useful too. Change debug messages to also
report the opcodes of enabled commands. Esp. if card initialization
fails there is no way to get this information from userland.

On that occasion also add missing trailing newlines.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2:
 * Changed message to "Opcode 0x%04x enabled\n". Updated patch
   description accordingly.

 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a48ade466d6a..202d49dd9911 100644
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
+		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
 

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

