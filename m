Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4A6A7252
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCARwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCARwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:52:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EA3E098;
        Wed,  1 Mar 2023 09:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFkwhEAj99kMuz4ye8Em6A5i+ZSolo+e2J3zKQVWsiFG2okbQCCwm7gYWBvBp4eZ97c6+MOF5lMY/lXe3lqvgazVG30Uf+/IcLU+aGUTt8LD9QY/tVwP4H49ts3lua5X3r3NRMVKRvSx+hFhQYjEeZWy5eCHG3kG8hIyA77tTC0VwSE1ulxjYfL6cyOeb0ad2ipweuuesVReaRNfDEBw1pv8sYt6AB7XNM+5neJOfMLXq71UWTs0gO22cBqP3JmlUpbQYH753HUrH09P3wc9B5tFvSSqDkSQ8MEgS2x1ZtYaOPcbQaOySjHAzPL8+2dV6LSX5uIZCjYiFrOLxfL0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtHu3Hln1S0SoyywQdBSgTA9vOGhRhYxb315DTtMimQ=;
 b=AqxUtvMhzqrowbnwNF/TjOBG51nwBLgyNLWw3bEQBSwagOxRBFBo/VCvPvKpZ0x4au5kYYlCU9PLcKql5/efS7nRiXCTfja7owBS5IiVzlJTTCljTxiuwLxI893RM9S6jFperoebpl4qqkjxpua+EKt8tiWaAd+BRhRAPjbJQN1yCYhop+3zVsLoBS1mePrfMiEUO+IU+GzItFObAw6hxXGXSZ//Py10nChcjMTwJH9ivvvpovdI11DaLNO6lazHXJt+sI/F48iF5IE9pR1lsuYwmlYfysTjUtYBL2opWBR8al02O7uHZ3zHV4oSEM+tX4weOlaTOE72FRDLQVsdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtHu3Hln1S0SoyywQdBSgTA9vOGhRhYxb315DTtMimQ=;
 b=J3pJwEm2ctp6oGz5Na45c2jekX6WeKFrRo8HhRLW53F5zr6shGzYDSC2rjaZnPP7I6EMDHJBqnNBFkTdChGsfKUJFogAYFolV5FL7sSbaQztrYRJJKonD+0mRDzgs1gkiChZytLnjZTuW90ig6rBXwUifkA1OIZD19/KJjbZFrI=
Received: from BN9PR03CA0376.namprd03.prod.outlook.com (2603:10b6:408:f7::21)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 17:52:34 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::f4) by BN9PR03CA0376.outlook.office365.com
 (2603:10b6:408:f7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:52:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 11:52:33 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 11:52:30 -0600
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <wim@linux-watchdog.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 0/4] watchdog: xilinx_wwdt: Add Versal watchdog support
Date:   Wed, 1 Mar 2023 23:22:25 +0530
Message-ID: <20230301175229.342004-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3d3218-0c83-49f4-a409-08db1a7dbcb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQnoTO+SGGNS6SDgRz2MSfjWRwBhOxA8oh2cUntZ2MDmUC4cEKtWqVOED1jUHQdz9sUCYxuhFAOxTnmAGUMHNGlg4JHlFOK5GSypZRO9gzrYrZcMjmtKgRrClJO7nc+kvu8Fr/Wll7CrpCUbpfgOMDA+gLOQDRkwYySE6V3sFOFgtLuqhRjzwHW9zze2L7+j0xgknpozamRqS1vCaZic7Webq//Lo68I29uJ5AjJ0yLQ6V2RHAVX0+aXEvXz0M25so3aTVpB3ZGWb8fFaUhTvVtPe04rL+GNzr3USDX+oycSQjJqtPw+9gBCSfWHOKRu/XQS8w/M4R3/Pm+mbhGAEVrNb/rbiaj1vB4McrnH+zIRweYrn5ArD2vqOCYxiWAB1Oe5NCNsVen+AI+yoxMoC8zHEo8EDN4zKx0PQnj0GKcZIff8VlOHm5hqJfHSp/ZBwKnRq43plwFTHVsE9o4T4stBUyQk/OotVTp8Hhx2kRM4LhCvSlk82p1LxoNFoiyTSe1mxYTCftAy3E1exXuPDWHkQ/FpBOZiDaZZJwVE3w2GH5ev/j8wSMvkfS4S0EWyvU8MozqJ8pu03SjKaeNP6RhTqryVH3MK56p44am8O7QecxgK+m7K2bUDvgmqmnuKMHvLnsu3o5DzlvJ8jROpro0rCdIm1y7DMrbcWSEkqptisOfDjt9ycFBTG8G4o4pfkxmdXziz2sHO3+gBSB7u6k1WSY8g+GjYgFFEMKuX8Lo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(356005)(2616005)(86362001)(40480700001)(316002)(70206006)(8676002)(6666004)(40460700003)(54906003)(110136005)(70586007)(478600001)(36756003)(186003)(4326008)(41300700001)(336012)(1076003)(82740400003)(36860700001)(2906002)(26005)(426003)(8936002)(47076005)(7416002)(4744005)(82310400005)(81166007)(5660300002)(83380400001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:52:34.2261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3d3218-0c83-49f4-a409-08db1a7dbcb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does
-Adds dt-bindings for versal watchdog driver.
-Adds support for versal watchdog driver.
-Adds fragment page for xilinx watchdog drivers.

There was a series[1] sent earlier to add versal watchdog support using
pretimeout. In review it was discouraged to use pretimeout for open and
close window . This series is a new implementation of versal watchdog.

Srinivas Neeli (4):
  MAINTAINERS: Add fragment for Xilinx watchdog driver
  dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog bindings
  watchdog: xilinx_wwdt: Add Versal window watchdog support
  MAINTAINERS: Add support for Xilinx verasl watchdog

 .../bindings/watchdog/xlnx,versal-wwdt.yaml   |  58 +++++
 MAINTAINERS                                   |  10 +
 drivers/watchdog/Kconfig                      |  18 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/xilinx_wwdt.c                | 232 ++++++++++++++++++
 5 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

-- 
2.25.1

