Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17EC5B665C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIMEKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIMEKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:10:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922D11A26;
        Mon, 12 Sep 2022 21:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGyNs1n3BHI7qxUDZqLVUFIIxkUivpM6jL8MIRd+TYLfTFDZWfS4b4a+/bh1a/oRYyw9+fPn9PgqlQ3nBM6GNso29pppxPoZTJBlLZby51AyFToPItTWV7hJNMHxgySoLo+YCrZQgUaq2qCuIYAHxc53Yc9WfTuwywTboSIhhYuq6a3V3pO2/TW+Z+nqwOLGKrtnEW1JzZwKtUQaGp6eUk7EoPB7GZ9JPNAuvBzo0UDRSEikJyK9cjubXtwelw0NtSsaerGdHKRWoZ7cE45Qf1mrZNxTHRRj9sC4LoT22K2RG88oPnRdmWxBPEaaoRDgsQEI//wXGuhDF9A+hcF8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvoLAO/pakU5YX7HKHoB6kleu5RNKKbJfmgsdQ3T/Ik=;
 b=QQr//Swmc5TLLyx43X8LvqiYOtuoCI+REK9jxQ2AS6yU1bxXv0aNkDyXczq8CxvJXyLLWM+5GhloBWHLzJvcQILpHKMIcaulZdaxj2rYYcbez9jNj2jhAh4SREe1Ham6rt0h5XUJEJHoHhFmGXqv20AEtpLHs4A9mRK3rr6sTCDz83d0aaMhwtMFTCak9C/czja6xsXgH5U/X9Qg65O/VL6vqAlEImnhXwtMxHecJreMdqmbQT2KYMsCtdUXbvPcBKtn2aRDnPiy2pCiZYMRnE2wG/M2OcLXkOfjFonQg1/urigYyqxr7YJpF9czjIrmlSHwxObwo4eJPUunpsCAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoLAO/pakU5YX7HKHoB6kleu5RNKKbJfmgsdQ3T/Ik=;
 b=HybUjKYk2STxXndL5nB7/XnRf5H61jOqxaeB3tBQOr1UF84sYkqaAwNkMu+nSfgdeSVxHghhHo7eQQGpH/Gsy87mA9XgJQfykGnNoTc8N/b33FO5X0QSjWOSgBOGvixioTb3Q5sFXv1S4aHNe7oyyNIEBIMPOZbcht1Jueg29r3LST9TWv/Xgrxyj3CAJv+qedIqP2CLxO/uSWUeujAPQxUc45qijE21r32o0lN+KYBrsSVEg4GXoUzo9wjqtB1mqM24eNdy4DFw4cRVAuKIlRdZUoeINo5KKzkjKI27sEwFIN0VfViML0NWBzbi2gqhq7FjKWEGpniPzqcDAUBEXw==
Received: from BN9PR03CA0805.namprd03.prod.outlook.com (2603:10b6:408:13f::30)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 04:10:30 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::74) by BN9PR03CA0805.outlook.office365.com
 (2603:10b6:408:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 04:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 04:10:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 04:10:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 21:10:28 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 21:10:26 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH] arm64: defconfig: build TEGRA SPI & QSPI
Date:   Tue, 13 Sep 2022 09:40:12 +0530
Message-ID: <20220913041012.17027-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4708f018-0d70-4f23-a1fe-08da953de555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGqFNbXly/nCNOI2oFbucRdXX14NAW2JfGhwWYJviJ6LdjALuHCop2x0/lXApOyYrNZYy/vOB29FFXy686X0zM1KoukUqYfM/TySIscQS4OJaeIA7pBn+jh3KrnFZ+Q3BSAwnwx/y8c/UFd7EuoP2fWvud5BVnYF2JEyBSb86toN2aSfyMktN5FLEWGiAZSnHl2YB8kFzBZ3k9X9bD6zUGDEVXMonjp9xdJ6eDdUSRVO4DDpI8sQhzfYrEplmaY4f3EF/hb4rsotOWfIIDwGFOuZQ0Tdec7ZL05W+2sTpgGNUi3THAJjobxxo5cbu6nzItIQhBJ7+K9y+qa6lVL61s85DC7ZNu/6MejGDI7STl466T52SUL4n78TwzmM0ail680NDD2ST+lyQDsrTTvvsHAsLquq3JTZ4D+y8spXmF2TqbvrvjBdOiWZlUtwlgDh2Gj/yV8HriazuTSZNsB9nH/1xgPHiuvPyifE7mNoMCcuKBu3goIrAbD1yu8FGqM/mPojbwO0qVgKLi30V98mvULumCHS/XkPXqmcHcNUOfMVa4RlwWIkN/rVp6L7WJ9e4RoIrfZ1WCqzhT6VAXT5EBEPK06bdFCRtzKEtxqlDfhDv4uqNmi7ORL0N7P2qZx1k9Wbq056hXQlLfqQfH0C0l1SVyUh2cZR2nQD4fFNcRlXv5HgFWqyPW6jgNC+rBnfpCx0+ILqth1FX6xzOzNNcf6qVJYgjzBnTwY6HtMYU7bjuRx+1fbf8NtgDhmnPwI26AatvuO00yuzMYuPCvE9mIHxVrd2KwlGOOnClhLFZaGm/gGjuinYQr6xsSr80m/O
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(86362001)(316002)(107886003)(40460700003)(426003)(36860700001)(478600001)(336012)(110136005)(5660300002)(356005)(26005)(7696005)(36756003)(6666004)(2906002)(2616005)(81166007)(82740400003)(8936002)(1076003)(186003)(40480700001)(82310400005)(54906003)(6636002)(70586007)(4326008)(41300700001)(4744005)(8676002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 04:10:29.7766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4708f018-0d70-4f23-a1fe-08da953de555
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jetson AGX board has flash device on QSPI controller and SPI instance
on 40-pin expander.

Enable TEGRA SPI & QSPI drivers in defconfig as modules.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index edff0f265c4e..e5cc2f94b71d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -492,6 +492,8 @@ CONFIG_SPI_QCOM_GENI=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SUN6I=y
+CONFIG_SPI_TEGRA210_QUAD=m
+CONFIG_SPI_TEGRA114=m
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_MAX77620=y
-- 
2.17.1

