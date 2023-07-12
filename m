Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF17975080E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGLMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGLMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:21:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2629B;
        Wed, 12 Jul 2023 05:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoXnJsGgJyFJrFFbFjTiQKxpPklbf8lQRaOUjyAhuHOMJ3vRRfHzkB7KEJY8YRxUQ+nRojfrSH1JFEbm009uyoYCtaNQrmswbeKIfYna3AVw5Z0wUe8lo6hnQko0Gm0YaQasVez4rFyEh5RfqhW4bw4LxyLHFK6fxBe6sJ8eUzRICfpGFrihluynivVxFgaREDiEws/uUKHETHOaQk4douP4tsQu67OFX9MmgpsAtzKQll4s3sPOveQXyaXkFELnlw67hIIb98+JDxRHwb9XepVzD4EkxPAa6b4ERUu13QiPy2s/nBa/bFvbRRu8XPTg87oN67w+bk4Y226I+0aTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S+TFdjPSevPjaaOxtZlrwgMXajCENZswHAc02DhrjY=;
 b=bUobeeR8mxVUoTck9Bpflr53tHpeIbw4JmCXaE+HVYt2/LkewyzmG9JrUn1dcu6/P9ZfySQ3TCco8/BBsKsSRkcTJWlSw0C7uWXJVSF7DnuJ+kWXLiEsXUah0ilRbTkWKyn1MpFjGUrE63OZvnvj4TIjFag7oKUCIGW0PTICMRUZJ9OzCe6EtVysXBeAj71YORf7TmCNlZ38SCY+w8i6A5Fs9/Ay9UcSIkp7XJcbFC4SQTvZ7VWn4k4ECHKRwWwnYDJu8a8Q+b04DlezD5weBANTzd13yv32w8C/XyHI7Xb8JIUb9DFyciV/w9bOgsOU06X27mG2rfl4cyIxNMwKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S+TFdjPSevPjaaOxtZlrwgMXajCENZswHAc02DhrjY=;
 b=SxGhj1/YvMYk9AYClF7//WcjYr3jyBtRhycJhxvaEBfn3vw7jnrMhqiZ31Fo3dTUiRPH5RgG+052w0LrgR2wp1euOelg1EP7DQDT9VH/Cc3Z6q59EPpL3n8ToIduyD57cpmKBqeyp4DkWxfpyo5NecgWtsnmX4i7PPYxru9NvSg=
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 12:21:14 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::d7) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 12:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 12:21:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 07:20:49 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 0/2] can: xilinx_can: Add support for reset
Date:   Wed, 12 Jul 2023 14:20:44 +0200
Message-ID: <cover.1689164442.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=563; i=michal.simek@amd.com; h=from:subject:message-id; bh=1+QhGE1RSmOv+y7+BhtDNFIGzu2+LwmNdEnPp+aL69Y=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpR1s2Z3mfJZFX/TODXt5++5ShtF2+R0OEpiPt8uEv9oo q7Jvp21I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzEQIJhnn5fucz5tdpi29JP bCtJuCY/cZvmNIYFM5Rq5otu2M3Z0Vbkl6U2kX3Gr5frAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca42918-0b90-43fa-3e3f-08db82d27c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccbbZsYESL7BDHi5HGq5ioFscx+f/zi2hJDJjp7IM1IVy7tP0MqvOIgms4FlnZG7Tw8yJaCwPQplP9PIzZaZwAxpDd850L8hpQNE+qxhZFMEqhWhkdtMndS7pafwvX2qKjP0UWU2R9+Jfa2Oe6dco054/HxEc21BK5mVV2S7+tz4IASNbC0T+IyzSZi6eWkvkQCqc5BcCAJNMiYro2j8x4EmWnabRBkQUJBatF4GapFfGNOXznkAEOrU7J4010OU127C+1mrc0x7iY5aBP9H7I8uWNnpcQXrQaFRF/SDOmeNfm1Wu29E2p42TBMv/JevrPmPqBc99cRRJB08NqDA7XxMT3BMIkcotgpJGgYiIZWyKN84nUwoMfuBaBgA2NcSqib1s0mYWpt1smFuO/c29n/UbUKsQpnERMcxKdBB5ekZrc+Q3ZTFP2WbzyaueoP0CvWi2YmSbr/eYpBxChtDRdVvPQlDA+BHST4f7j4Rw4suyU2+TvvmxDXbQQW5wuVkA3JHhT5ubYtiLhdKlG6GgULbgN2oydLqgs/QU9ORXMjaOXOSznajtEzAKA9mQLavObsW7VHRE2zopYfH3ic1Q800acH4G6C923U459HSROudlyNGuvaYMeD4sL0DKOnwxbfLOx209fa9P9SPWRWobvNTRfsCJO2FM7NbHuT48KIEDLXiGyumHucbt2uqavrhrg7Gq0NFGy4Zg02YGD/71PmnjQMcl/8vR7j6NH+0jiggltICIX3TraONgEXjozwE6XUgUw/cWZjr5H6CyxsQeWNxnaP0EzU/4j83WuvGBQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(41300700001)(54906003)(110136005)(6666004)(40480700001)(5660300002)(7416002)(2906002)(316002)(44832011)(4744005)(4326008)(70586007)(70206006)(40460700003)(426003)(478600001)(36756003)(336012)(186003)(86362001)(82310400005)(16526019)(356005)(81166007)(47076005)(82740400003)(83380400001)(2616005)(26005)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:21:14.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca42918-0b90-43fa-3e3f-08db82d27c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IP core has option reset line which can be wired that's why add support
for optional reset.

Thanks,
Michal

Changes in v2:
- Add Conor's ACK
- Fix use-after-free in xcan_remove reported by Marc.

Michal Simek (1):
  dt-bindings: can: xilinx_can: Add reset description

Srinivas Neeli (1):
  can: xilinx_can: Add support for controller reset

 .../bindings/net/can/xilinx,can.yaml          |  3 +++
 drivers/net/can/xilinx_can.c                  | 25 ++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.36.1

