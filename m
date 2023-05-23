Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795D70E97E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbjEWXZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbjEWXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:25:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F41BB;
        Tue, 23 May 2023 16:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeDl2hSzfjyz167QKLsrrdPw+M5QLRNCVzKJ37hi8Bps6tbLaixyh8ImTr+znCQ5+Vq+R6Cv9AcY5jAmDln+0lz5hANxafNfHdxHiNAmE3Oel6t1YRG77QNHukdEUhNqJ77EIwbGHzoQBWJS04IzTvWP6V7lxY9nUxJzugmZpB0xvr1SKLaYI1pRtrL1xyq3I1B+1GsJVSfg5QVKPlV3/+ojxUTDWXp+RJZANlt65VuQb68jskcseJcEQIzztoGeHgjcPzcZghCFrHP0bOi/fJH+pYyUM6aHV1QT7V4bu1iX4VV4l7es15mza9yRs897rzd9/ynE5mTKX1F+obZ8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99kSSiBZtnkXkhLJGyNHL2ZH8gyGsNcAyDN/jiM3uYI=;
 b=HiboZdzzMLhDKqHPzqcngo778YvfemZmI2ExfY9dF5N4im0Z547DMkD/rIGwhlRCM987pVxw4GjFayxS+szz52gLlLRDHyqC6yrUnb/v2n8TAxCjD5EoyVdO6bBZgv29CUw+X8BpU7ZdFFuz7h/sNkWXpLvn27E+J3H0irhbias+riYD/WaAr8ioEyzOIE2KL3WkFPKbHRBjoCncgfVpfkCrGYpya3Bno8zX0wrOUmJu3tCCVhvNWpszcDdRE9NnWZtXAuWMo94VOtFC3oA2QcGLOierIaWnB7X3SeR/2dWB82BnlXfMDZR6Pj4/Ea0OYG3Ho1ZRRLt6llzqUzOY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99kSSiBZtnkXkhLJGyNHL2ZH8gyGsNcAyDN/jiM3uYI=;
 b=jfzpgmdgXI7StwipwiA98WF4Fyzzigraqwk0tYo77hVk1jl00iNjGgec+aSJ5EnWFGcxyQcbHL29btRRdx5TOgRaXNAggZBHSvwTwn5NhtVB/PfWZwilulANBjvS4grz/2Myrmm6aDOpXNWst2S1IF0d5T9r9QI/JCfPudhDyEA=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:24:31 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::a5) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:24:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:24:28 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 08/23] cxl/regs: Remove early capability checks in Component Register setup
Date:   Tue, 23 May 2023 18:21:59 -0500
Message-ID: <20230523232214.55282-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: ae444948-3dd2-45de-1a6b-08db5be4db85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHo8P2heal+Eyr50ZDm9LAkA8+EviGwulsF2J6BDQb3TR2qtVfuyvS1dGYjhamu9/D/Az+Ph1SAenr2X6DThcap4WW+UfOudJcfPJ9py5atbDDpgPQLvieBwSs9rEqlqS052PkxlWKD70/FSeqeneocaKL0pZIyXFgdkIeaNXrXRMQbba7eOKDwWVF9UmbN2JLbL/ox5EyCWp0nyzErg5/jJVW8XZwEKIK8RCJNga7g/pyhNcwPjS3eRkrGiPWySAepOPjkMEwyDslg1xDsFle7DcAjca8/3ZGIzIazCeyN1ARTt0xrWxm9KHFx3Vvq7cRks2osoQR4rjvxAQsxe1rMfogXZRVLqcM+bYAnthVa05CIlj5089H3on0emfDnXZouGkzeZUQQPaqKrEkBH7F1eTBLW9nb4m1MpkOSPJzoyp7k+qQk38WjxxIKPr9mFkcfM+u5yAe+bvAp6odtEgl0OfQGEeSiVBcyLmj3dxvteMZZkpv4V+0+KMOPXxemFWz8mMiwEVgmBsLMc/wQ3UQ73XTkyu2JoMjimE0ZAU2Ei28OFs2h7tYO+81x5GF1XftPvXQvAzB81a3xQd+02OapuQQo4SqQQEM0xPXuCXyDWcX3r1A7LxnNHzPI7wM5CZTbzsoXwHKRuZXJsMEenOwpmAmJf4xqkUMjCwAxJzuWeAYKXKEDd00qxr89dgVjrVWQYT8fi13LuONSWo15hN1w+oYFQB+57XvsniuobTEpMBqQdJpvrupTPQV0NgvMvIjptx37EK4mgJEPozB1ZjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(70206006)(70586007)(4326008)(7696005)(41300700001)(110136005)(6666004)(316002)(54906003)(5660300002)(8936002)(8676002)(478600001)(86362001)(44832011)(81166007)(82740400003)(356005)(1076003)(7416002)(26005)(186003)(16526019)(40460700003)(426003)(336012)(83380400001)(40480700001)(2906002)(2616005)(36756003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:29.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae444948-3dd2-45de-1a6b-08db5be4db85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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

From: Robert Richter <rrichter@amd.com>

When probing the Component Registers in function cxl_probe_regs()
there are also checks for the existence of the HDM and RAS
capabilities. The checks may fail for components that do not implement
the HDM capability causing the Component Registers setup to fail too.

Remove the checks for a generalized use of cxl_probe_regs() and check
them directly before mapping the RAS or HDM capabilities. This allows
it to setup other Component Registers esp. of an RCH Downstream Port,
which will be implemented in a follow-on patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/regs.c | 8 --------
 drivers/cxl/pci.c       | 2 ++
 drivers/cxl/port.c      | 5 ++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index cb2a5b1c6db5..7e56ddf509c0 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -366,14 +366,6 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
 		cxl_probe_component_regs(map->dev, base, comp_map);
-		if (!comp_map->hdm_decoder.valid) {
-			dev_err(map->dev, "HDM decoder registers not found\n");
-			return -ENXIO;
-		}
-
-		if (!comp_map->ras.valid)
-			dev_dbg(map->dev, "RAS registers not found\n");
-
 		dev_dbg(map->dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ac17bc0430dc..945ca0304d68 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -630,6 +630,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+	else if (!map.component_map.ras.valid)
+		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
 	cxlds->component_reg_phys = map.resource;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c23b6164e1c0..e1c7efa9232e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -102,8 +102,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 
 	cxlhdm = devm_cxl_setup_hdm(port, &info);
-	if (IS_ERR(cxlhdm))
+	if (IS_ERR(cxlhdm)) {
+		if (PTR_ERR(cxlhdm) == -ENODEV)
+			dev_err(&port->dev, "HDM decoder registers not found\n");
 		return PTR_ERR(cxlhdm);
+	}
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
-- 
2.34.1

