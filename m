Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9462B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKPK3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKPK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:28:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9D2EF5C;
        Wed, 16 Nov 2022 02:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X979xd4Hq1mmkezi/El7l3RPsmzA7sjtdKvImeBIRDtD3G/HjmYC+M/0oJm0jn1SMf/HbL0BeL9aPlVbJ/rvBZXI+m618na0QTh3ejvyFP2gBAiNRom3NcuMAblHVkxvy+ScTyUy529o8p6EmV7+jH35Ft26/GagvOEakLunMrTTpxukS3U/e2hZyypY1L/nSi82sSDXB09gwvZKEinb3DWr8HoDpdYf45x2hdu8lLn03NdEsl+tJUjJyccrM41c/AI/OWnK2ijV/+TIcMMYuu+k66/ovtSMmweUygaaIQlPXsoGTicr1UBhM4fVW+BdcSBqilHaVPt7kSvR8nq2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2MoIz5NJQ5KJbrkdYu0dE4oB0rnYISwErrJkRdV++I=;
 b=MqUQc3duvPiwG83JAVOwwdJPN3ubo6EKcsmT3nk1ErfxWD5RhoiAA9Rq4lL4tImP96sbAM4c1QpuJZkILz7chFSpUDKwqN54tLJ4M2vWGf41QztHFypesQ/+AVGupU82kUwUHa3CquoQQpITldcI4NmTHTGg9NKyDWsBDEPt3KG7ON1gWezpyS3ylTE6cNpWcWnc1TTi8iuowkqKja/vBUGigMxLOsHGMihIehXkRFO0X9z7iwhRvoeN0L0ROTUqkk3EZHrR5vlqcxfk96vTKX97wPMPeJFqwp+iOecVnqPDyuVE0F4dCZsp1WphA74JJg+BPO6DhHSmJOQDDBrLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2MoIz5NJQ5KJbrkdYu0dE4oB0rnYISwErrJkRdV++I=;
 b=tHyxfZXZSHKSEoECnSpXz3Nvm1k2adecBJTn45u1a/M4j689fQDQNpyxIx/c93KBtkoH3GcZOWyIz0pT0FvZ7bmSbz5gZXObi4R/sjcXuVa8luaraeltpZBvwpSXYOTRwAtgSPeL7WP1dq+/8zoNBU1um51gWy49WKJgaqkECpH25gHJ5ZTu9S0lAzYkciuzHy4AHKbQf7bpuhfMVCZCuKZItkhHE+2hQ6+vzY/IPf3zUP03nDSmZYNVwlEuWnVO3ip7UqdKDfOdqtvL50kXIY0+1EaljYMqs8LSocHlr/8U6pWPO4WogEF45UjTQvaA0JfabNUZ/EXG6MEDr4cHrw==
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Wed, 16 Nov 2022 10:25:04 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::6b) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Wed, 16 Nov 2022 10:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 10:25:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 02:24:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 02:24:55 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 16 Nov 2022 02:24:53 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH] memory: tegra: Remove early boot SID override programming
Date:   Wed, 16 Nov 2022 15:54:42 +0530
Message-ID: <20221116102442.28194-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 3771bb14-eaa2-45ca-0ce6-08dac7bcd3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCUJvEPquQXNYuu3QKwcSu1ztDzv+M3I63jsKILduhGU8Q+L+jKQ786LeSvCxu1l/qMwINDOrhWOISY/RfkylLJWeAqkszMw4+jJFpWYw3prgTVw8gg7jvkDZHL0Mga97VYuclgWbfQUaVWF9Eqm1b8thbnIfX9d36jvOEzOMsr9RFgnn/MJQrWurxHcS6WJ9vr2UMLoNfg/6dGL4FbtQ2fQUVsjeM9pYbzX/qp65lciqWzT87L7UVzoJTCcKEBo1LTzCBAOc5hpPzd/eLHPJZTR0DFa+LbqrrA7TsxkBUCOaCVSW18gj8fzo3wjlSMUeWJ2p86qwVtsT/LKqkAnhunSZ963OHOnBbX4Qg0rcwbSONzXN6gixEkx42t61vptKqIbQ1BWyqMMWqdC7iN88Gs04yDdT50fMKMn6Q510UbD1cvGvE9puwLKYVKyYKjgAQWX/Vx08QPU+Owwuls2POglbmTdAasSEmWch0XmLDoKUWH4YqtbNzNj1Dq++qCw7EjF0ynbaaWNA4tzOyTvQgCNyxY39zbDZ/uDqcXO8ft0hXKvSyzywC6crxx9cs4NJXlW64WvbvYILt87RWeZDhNNSUh1gZjBRkzSajMwZsC1bGbTerQ7wbNk9+GGyaNFcUw80Rvy6Bfd4ZyCM64H3TXKe5aX3fb06Vz5oxYm3J59gXNor7+QiMlA/xmF10x1WPhWiUrC7sViVAhU6zfEPtcV2uRsM6M0OefNxULxT/AJ4RyYaDNBHDbJXT6KuLtK7lcPEjLhWaaRsUv/vXrv+g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(83380400001)(86362001)(7636003)(82740400003)(356005)(36860700001)(82310400005)(2906002)(336012)(47076005)(2616005)(40460700003)(7696005)(26005)(186003)(426003)(6666004)(478600001)(41300700001)(107886003)(5660300002)(8936002)(40480700001)(70586007)(70206006)(110136005)(8676002)(4326008)(1076003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 10:25:04.4315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3771bb14-eaa2-45ca-0ce6-08dac7bcd3b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SID override is programmed on-demand during probe_finalize() call of
IOMMU which is done in tegra186_mc_client_sid_override() in this same
file. This function does it more correctly by checking if write is
permitted on SID override register. It also checks if SID override
register is already written with correct value and skips re-writing it
in that case.
Also, on newer Tegra releases SID override programming is done by
bootloader.
Hence, removing the early boot SID override programming of all clients.

Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 62477e592bf5..870273d343d6 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -85,8 +85,6 @@ static int tegra186_mc_probe(struct tegra_mc *mc)
 	if (err < 0)
 		return err;
 
-	tegra186_mc_program_sid(mc);
-
 	return 0;
 }
 
-- 
2.17.1

