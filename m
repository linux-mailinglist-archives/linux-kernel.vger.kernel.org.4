Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942C62D3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKQHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiKQHDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:03:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09812A96;
        Wed, 16 Nov 2022 23:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMwzlzAo/yTuyEOFh/ziZdMHbki1uTYWRlP+hQb8fkPGk5PjKHwsWXH32tiq6fiRurQqB43DFC54ybFU/yJMVgkq6kS2IqS2rddJpYNRfW51jF8rImM+YmpdXLQRTPazts8MSNdctoKE+nQWQlrHIdWXi7geFn7F9kbGfGdnAZwqcsaarle49KZb+Pa3IxNoFAG+17tPhm00MGGlgr8O9KaExE9UbneHde/BFk0O9pC17wWoi3NndFBhBHDVWTzgcldIE5UtWKDqT/Gwl4t5o/xy1TejIeRhkcLv4FE4CG62Vx7Rxvohdr4LbyoVYNc2jegOuTYKQhhsbCr8QodwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op1e5kB+fSeUycWnw+irb1W1dDzkzNzHg0ECZPTy8gs=;
 b=f7a+9qMfOVPic0RbJNHZdH7TqwrnLDWFqXPvPIfkL5/Fmo2rZLNmG8n+z04dGmj6wsa3CouQ6WI6IeANfk81f6tiR4HLz6eNprB6EJByIKV1gsmsgsFSTVykf2e1dXHAzDn8qR/d249B71lEEEmuhwHSrnqNyJmw+y5Ozn9q4grzNqTqX/Fe9M94Bap9NRc9dgWBGQf3kELT3VfB4we0NhAB96mZ8cwm+grO60m9MA4yrARJMfV0pwyVqLZGrc+Nmo5A7wdcnApMwI9UzZQWTgjGA51vytMeL0Z41wQJ0ateVsmbBJa0xxSD286RqXcttQ8XTcWMP+PTjOQsntM3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op1e5kB+fSeUycWnw+irb1W1dDzkzNzHg0ECZPTy8gs=;
 b=IThXvVx4HrVoAUX30ErYudiFjtP7PSEcvZAR1GlpjOppGDhs7YvL1DQ5O32VnH1Uq4Uc/siWO181Ip69RYxrYW3ihpa4Bp+P4n6xTNVwZehoHgUtoA2pZhI9JUfz0nmruQw56eVnvcFb+eGTFuVowbtMVGIfNkNdrd7jKXMo6ap9iQQLJchqHz+8ngoiKLAGFe8i1HOtQRiYhbhnSHK7g1kSJQgySXjrQQSyFXOmxAmxc+Xg46hZpNCLnpL0RtQfhvvbTrxWcVsIG7quI5gi5cEe+F5dtHd3hTw2KiZ0Ro4qES2s0NGKzLrz0j/bwLHRdA02qQJ8CqQS7w4iC6IS8A==
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 07:03:39 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::35) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 07:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:03:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 23:03:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 23:03:28 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 16 Nov 2022 23:03:25 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH] spi: tegra210-quad: Fix duplicate resource error
Date:   Thu, 17 Nov 2022 12:33:20 +0530
Message-ID: <20221117070320.18720-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 7145c5db-8645-4668-2e46-08dac869da6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpTyD6qcebebGjSgJ+Q/cdV/jJmRP3nIbonf6/Z9KYq4zhbL2jjqmbKnTSAE8icY6iWvPrDvC9HruG1ScxcCReXpgu6JshahJWv7oQj7K5t28svJfFSAhDbZMhUzq0LzkmFpNvbCkkq+MBqVuoWnTbdaULRxNChsuZ9QCInsJ/QM1eygj9ulQbIVn0k/AlnT5KMfxkEvDajHDAYhoGb3ikVsE0f5Qr/SDsAurTEFG3Gl10QBZr70Sf+YxbjWsyNNgkHlaYluWqSX6TCgJfJqQ904/EyVC3yPzBBsLCb+cl6euPpqtH3o2rLxLdaIUcVLzxq0RaYSG7bfK0nR1xw8RsorWQL76rMarfnOXJwen7ig5qCK4m9qxx+ycZEZXA0nEok6BFPXNW/DOPCRqXmX++XVIv0T99135SMGQaa0OQJmjp6mYOaQvmPJKwBgTmZEF4rLu1/MgUFatAbaZFELQpfa+RWA4h4/hlduBS7lU1FYWfhY4s2CUNLpho8ce2Nft/aLoZLlrqFjFUXfi3aXGKJRglIHjjEVj204e9p+Iwm4BpEIcxLSSH69eEpIQlKLsrutbp/iduF1x8zi371+dGv7W7drDWnzpXKTlhYhqg7Lu8021hfEte89jj0hkPGzHRlvsBY6T8lgtmbs0ELgGQXWQxNG0kZ3C1ceTF6Xkul712MbuTR2plp6vhoskyx8xahCgrQVu9fMf3ZXRv330w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(36860700001)(478600001)(5660300002)(86362001)(82740400003)(7636003)(40480700001)(7696005)(186003)(1076003)(107886003)(70586007)(4326008)(110136005)(6666004)(70206006)(41300700001)(54906003)(336012)(316002)(8936002)(47076005)(2616005)(8676002)(2906002)(26005)(356005)(40460700003)(426003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:03:38.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7145c5db-8645-4668-2e46-08dac869da6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

controller data alloc is done with client device data causing duplicate
resource error. Allocate memory using controller device when using devm

Fixes: f89d2cc3967a ("spi: tegra210-quad: use devm call for cdata memory")

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 10f0c5a6e0dc..9f356612ba7e 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -924,8 +924,9 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_qspi_client_data *cdata;
+	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
 
-	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
+	cdata = devm_kzalloc(tqspi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
 		return NULL;
 
-- 
2.17.1

