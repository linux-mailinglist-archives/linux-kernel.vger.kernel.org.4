Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887255F1C1C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJAMWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJAMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:22:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61D7F11E;
        Sat,  1 Oct 2022 05:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djUscCqTh/Hkw4CUXHU+MWFm9jo+6zNx504SStFUdlSLnzDTWobme8WBL3enJEiGQOlC+rt2PxWC45J6MAPpB/Vux85nFXUr5xaQxlwRAA2RITARCy3WKV6OJxzYBpHEVYqT35uAhFKO9U13qy75RKuBvymywkpnaT3xXmxOnHZqt/vG2yXZuHtn5rwSgpkiDELMK9We1UzpMUm4NyTL3HbXBjEZ3xyZ4b4vW00+lZFCGxdnXmXAxdzGjUWJkEjU03BFR5dFtQBrnTWjs1zP+MtMcMlDhowkTQi34gQQJVx52E6Bls13Kjv6eRJEzpGtSg9WYZVUI+bfr7A2eO8Aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbO5yj+dPGPY6BQv35O7BK5FDzLaHrR/GPL72uJJEVo=;
 b=U3SPHBPnLmm7GTqLJD72KyhbrSGkKuX5/+xuh/N1ahEWM4Mg1I84//NqrpOXZAYSu7jivpizkYxH9R/zYNgKyOVJwP7PXkQkZw0YqdEigOx4vF/WApjTzAfif4FRSsAwhjiN52fP+R/l4C7fQSDTdR1Rbwh4eH6nhlHOYCUNbgsVhwtS8C0/TIpMuwDdCAgaa4/83FbeaWDl+82O9bJSmPIW8x8UzcvJvoPJRLZ+2JxTm8pJ0ET45Nevay/aWEyHGNTkpbkzAxM5hljG0RQspOGshViQO7wo+tyzDHP2sh1KhR93t6AoDma7k4/cz8WsbmXymYZbEWsGjbMxmRpvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbO5yj+dPGPY6BQv35O7BK5FDzLaHrR/GPL72uJJEVo=;
 b=aqTI/x/scCzlHQxvaRFXTvRRV9THTq2jY4TpWR61RE9F+IBMdZ6SM1xhd8xM1Q8voyRlD8SkGgZETtm0kBr9OtjiuJ1ApvFkMHgA8UdLlkZEma6UlGW1s6cfMCVoEt0CY9HxImcAO8saGnVLjyqaE0Nc0/CsSv7Dvmduh0LldtRxtO4MbWAAzmh9+yh3IA+1JXSPX3OsJu3+CrkyODrLUyoWNPCZsHhPG5Wj4vdn5uHOGyTR/2rVCPK89fVwgMdGQAC36OlsW5Yp+J990hv+sIm1bUOZeajpnH7jGmB4IVlX+6/XQdEnm823/ApYhb65h07f1rm47RqvWdsM0M+G5A==
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 12:21:58 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c8) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Sat, 1 Oct 2022 12:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 12:21:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 1 Oct 2022
 05:21:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 1 Oct 2022
 05:21:57 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 1 Oct 2022 05:21:54 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/5] spi: tegra210-quad: Fix combined sequence
Date:   Sat, 1 Oct 2022 17:51:44 +0530
Message-ID: <20221001122148.9158-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e4d427-c6b8-4e31-eb43-08daa3a7895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQTVoKTDeeTmnz1vdietbeGAKPkusQhdtG1xwWO++5osn8DkDcGIKvo5+Iv20uhq+no3CeUNPZLy9PNGRdpomvfzjico4IhWD4JYj/oriIVNBJ9EiJL/LeDwZRqLS9A9IukXNW1Rr+ESXYzugga9CXySbFJ3hb/tjNimBK6x4wgNJeaQ+0y8obJWkSKnp+Pt38y0C1nvj/Dv7SI+pLPc0gUqBqfp52/p9/DpZqI+I47bDz3FYDaKDIU8wODMdRwRRqmOGaGO281d0uFqpr6cBi7UMCBlBDAdnXYzZrQfQfQdPAoazEczUZeFqezIPTiFE+wUAOUEije/oJ1railMwPw2h2g3cVYRaWfl4dJsNr9HyW571Kt6brwsxdGxWoATE8Hs9AjR8/OPuR6g3axvI7rg0DDqNJ7Ky95j36BMw9awAhCIvY7EOeWS2b7xZLLUveP7ckV+kqAp2S/UYUFOt1QxeOQVpHUShSz2kkoIQnwbOJtzRJtFwaurk/yxP5DLFjxbfzXmTtjmyTNYBqGu4H4K5ef49Vojwj72Cr+MTc217/otx8tDyyGAhjBrH8p+8oR7NA1ZSW9cKKp7raFxIPXqwRg4rXQoxu8z9q+C+mchkiJ7Cwb96VJIJkMc1RpAz/mVLQc5xJ1gJ1O7TlGhYCXazhlfRd2pjtbl+2q+Mp8MhfarsPujanEcJMMid5BhqEikmeLTwLklxNQ75D55vKWwnIgYOVcvKlmVf0GaC7Mk1O6JkMCUmoGijBfrBUl6IJSJLfW9YBs79/dyhL8NOA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(426003)(36756003)(336012)(2906002)(4744005)(1076003)(186003)(2616005)(8936002)(7696005)(6666004)(107886003)(41300700001)(26005)(5660300002)(356005)(82740400003)(40460700003)(86362001)(40480700001)(82310400005)(7636003)(83380400001)(47076005)(36860700001)(316002)(110136005)(70206006)(478600001)(70586007)(54906003)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:21:58.3683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e4d427-c6b8-4e31-eb43-08daa3a7895b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value should be updated to zero in combined sequence routine
if transfer is completed successfully. Currently it holds timeout value
resulting in errors.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index c89592b21ffc..904972606bd4 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1157,6 +1157,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len;
 		transfer_phase++;
 	}
+	if (!xfer->cs_change) {
+		tegra_qspi_transfer_end(spi);
+		spi_transfer_delay_exec(xfer);
+	}
+	ret = 0;
 
 exit:
 	msg->status = ret;
-- 
2.17.1

