Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052316C0E11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCTKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCTKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:03:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C324480;
        Mon, 20 Mar 2023 03:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0JJpWlugd2o5MpMTp3o2IJpUnrSIzflxoB91j4mHGHuFeao/ksye9qZGId79hSuRo5bljPkFDe41LQ0Z24U5HfiI1L7xCLJnXcJmWL3ff9ftNDboa6vCHJmSDedgOKVE3PgnWGYCGjaBPoaA5ZIkzLixWhK0W4DRAsV6/7peEVWNexupR2vNt+ihdkPOnp5CyHf3W3XckW7fawBEjWDSwTCLSVS5tFThVYR4JdiWqEe49nzLQws7mbNLIxhpH7uTcX42ZeN3ovGVSapL5GJ5EiEtdZxQH+xz1sFrB+R1WMzBwfPyKJfyse+5YLA9+6ti+sXRbuJdvMGSdbIh/uWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAylQW3sXI9FYnIiHQ8+m8MLuhX87ACJmo84RM2HKRk=;
 b=LSC9FTk0b3s+yG/UKoMn1J3itbOWAqBcyBmpR3plnn3qPYRc63yVWl3nasa0QSDeXug7Cgg9ouyeXI75FwrllR5xq03EeHtBgqSlHDJVqw4I1m/bQEbreKxSTmI/ketll5RHe7Pjg/0qoyprQVennufGbVDPeFXXo8oGGQQG/xItAKEkWLMkR6Oz7s/OSgH3mMkqKlJcS0q6wSguBD+2PPnFc2nEqZS/16ByiaSNgEnEhVh2U5l+vlDPrKQQlpXhEhvSRYKImEJDSg0UAIQzeLdrWnE4ytrp+8M7NCgrrexALv7hWccHg8OPxwry6IxqW4wwRwhBixUUNDoRIKVPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAylQW3sXI9FYnIiHQ8+m8MLuhX87ACJmo84RM2HKRk=;
 b=m636ffF9Cc3micb3wU1SM1Ws/D/EEfMSTFK8l3h7s6UZ+SMpgtYKD0wgK8YUNwrut3c+odRA33XQhjx7BRCurNvMajhk4r/6JzkVQVO7PuOAgBl6XhFk0g1ENW+WbmAvH4Na2Gd3Gmru8lf5NnLswEJxRBZk9Vtlhnzig8MoXcM=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:03:08 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::63) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 10:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 10:03:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:03:07 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 20 Mar 2023 05:03:05 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with Xilinx Versal DMA read
Date:   Mon, 20 Mar 2023 15:29:29 +0530
Message-ID: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: e4001432-3b3e-4b71-7aa9-08db292a4e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8SxvrwT6OaeFoTk4mQ74KkHPyouVRznr0CwNy8R/QahtGyPXRpZ9XHg9EfERU9Ww+TJ3a4qmLJaVF/JnJSMV6i0vYdnwQg+Kx8nfAe0imO1XmNymPX7t39CvEVIWaCFwiUiFzmGoO96SN/WoBizX41i90gWuB28F1SVpjxpyhD+kglVtdWx1NCFlQwLYVDkZY4EZ+QhjiZqKhXodYpBv/+Cc1m9Iex/LFSFoXSMuTS5++OZIOUEODVl99FnALOVJbT1oBCEjuTU9KeqOouVm7dECuQG76hBDkrDIiSErjo3+6G/RUQqOZRwRLv1AIhqEZgix5dpLb2EmvYB+G5UzpN35T8P71JA/rG7MfHiZahf3f/6A3Io4gQ8NXctx/QbEk3M0BRcSpXCtTBy+m6tZpsJsp7tq3aZMRFpTQMF53Ks509qetvO1YEYxdGxTSGeyS68J32s+jw/uy/GWsLxw1fmSIkQBTZcOPJ1TRqbvILtc/kjnTSSfidmJi9VSBoTWJjKPz5GCLOT0vX2LnJiuIsMo4C/Rm6Q5GAa+SbxqCPl1vEzYQtHLfza/a5wEN7k15RssuH/4phTNzYb3lA+aj/x/TRZHhAxaLxV9rliWebRdhkNlaIdwFlnKCFdzL9H7NF8tVYsvGgpnl/OfwuLSVBS1fapFyL6qJQaMQTBD5HCaaR5i+R9TNrdoquraXQuFVCTQcv6zFOQRlVgkd/17tJzoR5kP72wUNG9KEBoI9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(103116003)(86362001)(478600001)(82310400005)(316002)(54906003)(356005)(70206006)(70586007)(4326008)(8676002)(6916009)(6666004)(186003)(1076003)(41300700001)(26005)(81166007)(82740400003)(40480700001)(5660300002)(40460700003)(36756003)(4744005)(8936002)(2616005)(336012)(2906002)(83380400001)(47076005)(426003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:03:07.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4001432-3b3e-4b71-7aa9-08db292a4e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Xilinx Versal external DMA read logic to fix random issues
- Instead of having the fixed timeout, update the read timeout based on
the length of the transfer to avoid timeout for larger data size.
- While switching between external DMA read and indirect read, disable the
SPI before configuration and enable it after configuration as recommended
by Octal-SPI Flash Controller specification.

Sai Krishna Potthuri (2):
  spi: cadence-quadspi: Update the read timeout based on the length
  spi: cadence-quadspi: Disable the SPI before reconfiguring

 drivers/spi/spi-cadence-quadspi.c | 40 ++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.25.1

