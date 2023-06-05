Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B172247E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFELYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjFELYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:24:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B4EA;
        Mon,  5 Jun 2023 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd+zEJMYfEb88bm25iwmEHSAuZekPxM6ugTVvGhEdGRUcekiHVLM6kkmFB5z8qKb+WiHmLe18MvwJHKOp3mSkAhf2N1M2OGf0uYT5Q7eyDOxriK6OgPQdX+58qNzBppJL+8hkt5GuLutFpp+tyqBIpVDPpYkMUYtsr1caf/ZJtAs89HyXjRBBG/Ejeq6pEm3TdfQKA/a7e0qeaXiMdzvGaI026sHhwd10jOxKDkObu54d9QjTg9p4f3gbTOJpON9HmKuyH0L0oJze9vm9XUxEeO8o+chUuTDFZZJonv88Y+mGk2sRSOjGhusZw+IZgsfZuHKnszipgraM8xA03vIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9IfMW9Wb8lXcRnDo0SY1I0Phx0iEfo/RzwYxM9pMGM=;
 b=CudDDZ+pwED9FNf9HJJGw+LsBH8erdL3hBaQjIqv6Tnp+rbn9WIeTBv0fDRV2KE6TwsaZEAC5PQeu6OssgG/z39Ri7w9nBQQwhNjWd6RmZLA8AOYFMz/4fvR9Kx7TnMWziSV+hbQYO4WKcM3Y2RN/TVkvuQpgtHA6eG7P8F7LuvR0KMQeExCqjTR8ASzhWZZ55hQHttmkgiHXeqrrSmAJ9+xYGyrsJTmxZgtsALaeFowxaFHY/qAIDZO90Fuarcb+VmBvyQjpP+PiIQeWNUUMyKiinQyGmMZKluABvUrKZYhp6JF8A74AC8ghxTi6fC9nA1+A1dCSjJ2EbHXsbJSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9IfMW9Wb8lXcRnDo0SY1I0Phx0iEfo/RzwYxM9pMGM=;
 b=frRGGHKaL1Q+kDgi5vEbw4Z85frSQVQXYZXikYh1wxTn0bAfNguTFqLfbBCP3KzBdKxh5OSmaJAVQA4GpH/Qh1eTYoc9bcsg07gslSQglo52+7q7BqkkzkKED+x2+cBYmYS+Fo6JTrTHNI/k79d0Q1uLK5owFLFtf4MBbGIG3DI=
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 11:24:42 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::35) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 11:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 11:24:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 06:24:01 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/1] arm64: zynqmp: Misc zynqmp changes
Date:   Mon, 5 Jun 2023 13:23:57 +0200
Message-ID: <cover.1685964230.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=michal.simek@amd.com; h=from:subject:message-id; bh=ExAoccWAoaRFQsAo6gJT+hg5NRnjbplpAi4wlzIenLg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTao8fZH/B2/d1z/VLyZuudy1ZvZLP3zGtU1PXsq4g4/ eZYne/2jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRuRsZ5soccDyxUvZJwQHj K/k/D1kdPKz4WYdhDs/Orafn2f6fUzx7/U/vcw94a/xLOwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: e87b74f0-ebe6-4b5e-c952-08db65b77531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5yroPk1ecz3q6ZByEs1EQf7GL9qG+Yl3IPnG6s1aPrRGpeavbfEwJPyN1ySGnFVRq8Sfkh4V9ZsbLWLvTs7Tjvqf0i1rEObNOLx7mal4GPRXAIQR0DhmUli0pAUYp2PACXbB4321C9yZSshcYon0++g3VjLHOanbVQtflv2H3j80wrIcZU6v7Jd2oyu5H7Ao4L5wYE7wekix/jWXalpWta/LrL4BPukFPrsRZ0Kr5QFKL0yG2TJBrQpmmcdQreQQW+n7CzhDL1B283nSLlpf5Xew0Hhcjfj6ZPgBaw+WVeg/H63W0Pv+MVJWNJ7mhDtFHB71Cl951jwK60s7VU0riZlnyPnrEX9vi4DxZ3gOIviP+HH3m34FPGzfhmJLElWiAE2bvnf4UkMv3jWFOY+KBjNG8VhwEiyl13w+2gUzdKYsKomzTNXKk1Xi66hW4vgRbsVs5szItiheCZ97QvwfHNtPRiMpprd7pbCswg2P1DHKygXp4aFT4Nxu1S56s8YB4me4VK8K+04SmjA7fVSNlnJyFu72NkNTLldKlWHuAcVC2m5gzzjKmNpmYO/M8VdGW5Ro9SEgLwPZG88nVxmBIV8hk7TVzOKU0xAEh8sXmVHr32XUWcmnuVMa0DBi3QlwGwD33g6n45JCrDhF3ec2hqCxtYGtmR5oSH5PE+Uu/XRR8VtHwpV3HC8/mLz5oUcfgVs3fnpgrg7+JLGbPwA5a7pA6i/xSqwKrOMyjPWqKy++YCSbu0aSj5qx3ZKwdNvrYhmJvq23MUK6iIrJYRRRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(8936002)(4326008)(8676002)(81166007)(82740400003)(356005)(110136005)(70206006)(70586007)(5660300002)(7416002)(44832011)(54906003)(316002)(36860700001)(478600001)(47076005)(82310400005)(83380400001)(40460700003)(426003)(4744005)(2906002)(2616005)(336012)(40480700001)(86362001)(6666004)(966005)(36756003)(186003)(26005)(16526019)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:24:42.2206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87b74f0-ebe6-4b5e-c952-08db65b77531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the series is syncing the latest dt changes based on board status and the
latest DT schema.
The patches are based on
https://lore.kernel.org/all/20230321070619.29440-1-parth.gajjar@amd.com/

I have applied patches which were reviewed already to have smaller series.
Patches can be found https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt
or they are in Linux-next already.

v1 is at
https://lore.kernel.org/r/7d034b9e-e4e6-5d72-8b37-78e25918aa59@amd.com.

v2 is at
https://lore.kernel.org/r/cover.1684767562.git.michal.simek@amd.com

Thanks,
Michal

Changes in v3:
- Add missing cache-unified

Changes in v2:
- Update commit message to remove Linux part - reported by Laurent

Radhey Shyam Pandey (1):
  arm64: zynqmp: Add L2 cache nodes

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.36.1

