Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6293E6179A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiKCJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKCJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:16:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172A210545;
        Thu,  3 Nov 2022 02:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8EYzHFUG+CgSy0Lr+vZCMSK9c1m486U0LOepjxq7JUcYq4MmfZgItWxKTZiH0ymuvbbNmf5oeH+NTIoz/rgoKgLBAgwjQIQKOjuXcE+4j6h8KPQNwy+RRdqsGf/NaMTFSu9SWDNf3ra8mOLgMaUzpXUf3m2bxm+onbLn/HdCZeDnbG3C1w28ryU+VXgNE4pgByfBFq8rXL3hyQ7i6+zvQlDgW28Dbf6lR9Efq77GF0ZdqP3rCDovyFxEOQDQ1l86iWZGXlQm3TDLwhEX8HxR0fYK8LtAVVJRG7TjXwvhOggPVo3R8kzljmdoi8YuOQR7QaZqipvl5VAjBiHS55QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I31OyBuvAdSLahBlVjIF1Woo99oNUvyTUO/zr+MUxJ4=;
 b=VBahry5IRm/SeAN2Y+yziaJMaq3yvcJqWpxOEKm8zzEVypEffzqm3efVAoWfJi33/nBYY8tocFVsSBmDTQcYqEIsVarbuU0mez4Q2Oq+knttqBIWOAiHMsXHsBPbm9iTHtChW/CR0uv3ZZ8Fp6Zj1UvxNie4KA4z+zJdCUqwfllBHwxbcRvOvIAFOrQzKruVmS/SoXuUVzzXmwInJRRN8+cF7VWfylw7yzphBGYIFYOkiDG3p3QzdWO6qnOJC9gHcD6uHbuUuL2LA1a/hGrRM8uWRYcCgn4ymDmoxi0GktoXfJCtAbsPU/69LCotehS9eV/iZbqoU3deHBJfeCYgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I31OyBuvAdSLahBlVjIF1Woo99oNUvyTUO/zr+MUxJ4=;
 b=zTrmYHSAUPUj9UN1cNMsBFCw7MBqFmtzkQ8PswnsknFc/qW6LZ7t689MbZspRkUWMuzpNkHXGJRHfAjuhWp9XbE2yhpkUZnoZiPPPrg+kkIsNhs0Dy4WhJOJJaRPdtOpTObAOhUvCUbxhlFtIykvT24vD1YBTE16XwyWO6OPkW0=
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:15:07 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::28) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 09:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 09:15:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 04:15:03 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v6 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Thu, 3 Nov 2022 14:44:56 +0530
Message-ID: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c06ade7-47ff-4230-212b-08dabd7be665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6waqXi9SuldWR0vvPAN8gsFDVvsYcP1Gu7ZeHNSGJEXM30nFpqDQzNy6b46lMq/VNK3NfoSh/Hl5ZklAMeMyy2QMSz30tYPkJnA1pOxfOJ1Leoz72Z4m4TesryGvpLidNEm5SQ0btMglKeLisxvfFYIVOkYdcWT9a/l8Bf4vDPgOZ6i5EFJPweGhrliigMjLjz3bpqd6n3gS0noAFnqUUGi81o29LnGl5U6vfKu+GptaNz7/nrdsKd95Xf6zux9jXdYmua5MUKfOvkAvbC231I7Iz/LE9UMRkytOdaSAd1GdEXLgHWUVi7fcWnrNwjrg7cdnLnm93H/szPqT+eFvAgke+hdlds+JWteq8gRLP9fSMow42ga4NDKzWTzZzouT6TG6Jo2HmAkU6WOHYC5ma6mi2YQUTNL3UDDok62hdcBGaCT2+6pXGOTJip/ZoJDSrmTJiGi0o4CuO8IISvled0JM5KkHf9XggRMhN82p+z+HDxm8UyxWl18UKAZyzONEPDOSNMtAWvvf43PUofIqHZOPq+mqNZUZF7juYV8L3dMzsSSFqzST5cLMdtwwvRlbF2lxINtPy6qhr6qNwcx8H3aPWv+lbBxikQzFS3o4RjjhlBmIGf+wLwWj8p+9BNaMe7sGCkjG/2MUDRNhjAgxr8DBuDWepD19D6UVhTmWhdPKplgFISkdYdI2bgYzS54Ey8DwmIclZsZm60bljkg7C0KeBc5qChi7kbU8nnBgNRmD9P3I2ApBEKEot3VVKCMRfbOyJHjltT71BjraivhydA8eKmW7rx3Q54PZXBPZ5c8nxHif3sQ/qsMMLvuS6KOt87uUgTpL+91ZmD1mIoKdjL4TkYp835XXQQTzDr3kGno=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(103116003)(36860700001)(81166007)(356005)(921005)(40460700003)(2906002)(82740400003)(47076005)(426003)(16526019)(186003)(1076003)(86362001)(336012)(83380400001)(8676002)(26005)(478600001)(2616005)(110136005)(54906003)(70586007)(70206006)(316002)(4326008)(40480700001)(82310400005)(8936002)(41300700001)(5660300002)(966005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:15:06.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c06ade7-47ff-4230-212b-08dabd7be665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
X-Spam-Status: No, score=-0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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

