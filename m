Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C58610CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJ1JBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJ1JBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:01:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E91C4EFE;
        Fri, 28 Oct 2022 02:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9IkueWX9L6Idof2Ejo/29l2effwmLircsbsXmcDH2z8bBjlcDXcjM1EGrWeck1Jv7hy9XYg0QbmsqZOws23GJgsPCsrdURgVg47J2Pwe0b6Kyfe7XfxXtI4ytysdJCzFC0mQ62kiFTiUzzSPF7oxr+ozGt/DCXpOy8yWcAuwI+b7urOtwESDl3BxwovX53uVkX0I9/6pN/NNfbFdeAM7HIWY6o7wPfrdIyJ8U7E1r6wlTYfK159zhtoAn9TO1EVk/Ma44Cvr3o0d/fexvyspZJ3mfmUrygYWcqmVDB2MtFt+cdDdJBfr+uYaePahXf+1YeiPaUEEONkbVmuSJXQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I31OyBuvAdSLahBlVjIF1Woo99oNUvyTUO/zr+MUxJ4=;
 b=e4NHkRdCBAv8i8H7omlRNMhaScIWdwsJ3YBxlaFtwZHuE5JJqedrNVAce+N0xEhtBcSyYlrP/2CgralYxkmjPt1VyqA171304VbzGbaK8xX6HOZTbzbNbvh//8PCiWyk/EwjpvmQfslXesFgC7F8m+eBb168m0ypT2KPDoV/dCigCJ9U8m67JHQeXH0zJPEFELN+AUcDm9G+QoYqXZ8itXkmIMLKVaJ8694xWZgwADr14RHlGW5dnSVc0kN31rcR3JYTkhtSP+VB26A+ioRL+GQa69Ll5XXlywTrFKkyY5SUJ3nS2Jw/iRr1iGYVxDiReDG677joUihIEIdVEkzmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I31OyBuvAdSLahBlVjIF1Woo99oNUvyTUO/zr+MUxJ4=;
 b=GM4ZfP0NoJ+YXbKK/sYXO1n6wp2ugkL0SpNuJFNiy2C2Hgya1zeI3BiVFVe8eo2bnP4Z8JeDHN2BpqbvL9mnS5pXZlv47g7xgVXeiQWubd8jPBE45gelOYZx6jvxj77dqGeTxmA9GmtWo7//qiwOWpD19xZFa1w97ox/83TE7aE=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 09:01:35 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::a5) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 09:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 09:01:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 04:01:33 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [RESEND PATCH v5 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Fri, 28 Oct 2022 14:31:02 +0530
Message-ID: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aca1945-658c-4790-5c12-08dab8c30412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/r69iEaGS68FlFl86vTIdmemaKiar3EsvDWBhyhWJjpyGz5ORySHXEqqIp/wkC8V67ut0Zeym8P5KqfxONoK7NE/EDKzOCnDVog7RTzGJ0+wclb0zCPn2P0Xl55aNtxU3DvQ+yC44/j7SL1kxO5za6U3iSthfI4TLtT+mFOEqQYeaJUU2wUGDPla+tCw/MgQBSG1fXQ4aZwBq3Jm2SDVWkJoxUIGyXl/Fl8rhxZBe7dNT5FNqFRtowgLMz+k5+UMkiZG5tjZNq9aL7KZkqM6YgMPF8C6byOAqpu8ecnu6GTWtFJmRJHHbZDOFtja13xkhkIbUWIwDtq3fh3c44mYOZ6ZpII7gJFPbkQ/sWbQ89Nmg/MPNyCuMaLLbzQKjbNIGb1YTSQm0wDcaIZIevVEO1D1qsQ52/hzWuVFPBVSfXladNg/BbTuaZhANvqGlNYpxk6KIw7XOYm3f6DQiz2XjhPaPObY5yWTM1cv7mnP51SoQTPXsbZi3gcxXYQaPrX2Miqu8qxGYSQ+qhHhqb6p7G702Lr9TlfHzb8Oc5tB0gKQUPzmxxMnulVcWtAC7tEnHXpAROWsQMgn11CAuNma1l9//JJgPqazNnCw2umGMKQGPAsJoiPznKvNThRuAUU2araXWdHMdayFr67dSlzs/esMuGA1tymnKljTwZGrCg7eoEsyoxoRGFJcUcsG6LvIwoFQKdWAb3gMFraZ7oB+nDe0DdfwO/pz9VtEj8qO1Nx+qk/4/2O2vnpdGyNwdhAQ1yyEaOihBnpqJI4qbPffw1UJBbSunka6zbXmeU/gs4/12PzUVJW1DuY1fa9J/LxnTS1eKPzUtrvjQ3Hucqm2K6WFO91n63CpYiw1EUY2Ag=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(16526019)(41300700001)(8936002)(5660300002)(36756003)(966005)(110136005)(8676002)(70586007)(36860700001)(316002)(82310400005)(26005)(478600001)(4326008)(54906003)(426003)(2906002)(82740400003)(103116003)(47076005)(70206006)(83380400001)(86362001)(6666004)(186003)(356005)(40480700001)(81166007)(336012)(40460700003)(921005)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:01:35.2479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aca1945-658c-4790-5c12-08dab8c30412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=0.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TMR Manager and TMR Inject IPs.
The TMR Manager is responsible for handling the TMR subsystem state,
including fault detection and error recovery. The core is triplicated
in each of the sub-blocks in the TMR subsystem, and provides majority
voting of its internal state.
The TMR Inject core provides functional fault injection by changing
selected MicroBlaze instructions, which provides the possibility to
verify that the TMR subsystem error detection and fault recovery logic
is working properly.

For more details about TMR Manager and Inject IPs please refer PG268[1].

[1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268

Appana Durga Kedareswara rao (4):
  dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
    Manager
  drivers: misc: Add Support for TMR Manager
  dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
  drivers: misc: Add Support for TMR Inject IP

 .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
 .../bindings/misc/xlnx,tmr-inject.yaml        |  47 ++++
 .../bindings/misc/xlnx,tmr-manager.yaml       |  47 ++++
 MAINTAINERS                                   |  13 ++
 drivers/misc/Kconfig                          |  20 ++
 drivers/misc/Makefile                         |   2 +
 drivers/misc/xilinx_tmr_inject.c              | 171 ++++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 220 ++++++++++++++++++
 8 files changed, 536 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1

