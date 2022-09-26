Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6A5E9ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiIZKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiIZKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:14:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A133ECDE;
        Mon, 26 Sep 2022 03:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfUq/usdTDntj/VOvgYILpvEzLwhS3nCX6e3AnfhzfwknVU3/oLOUiCz6uktnCHSowETI5PBQgRqfcIY3s8uLEwYuYaQfZBStK2bIYPYPIfIvd00hsAh0XNlY15X/lsg/4UDUHJCumbNlxe5i9FQJPvc1S8ImbP/JInYj+6S2s0Ihck3cJ+1HEjYddyHR4+prZEGHfE10wUkYzHdALsKOvo53G0CBYNezWP3OSKS3/H+OYp9dwpXylswdlsHkW4MQbMhJTUrD8pmDnImHWCjbhcPwvcXXB4fNTjsrEu/XajPYoH+c4bJg5vmm/hf+rkLdGW8H7skC5NqRAPq99h/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnytHtO2V0sD8tJjpy85yxDon+eA/q1O2557yPIdYT0=;
 b=ga3woah0N5mZ+XOHmoY2KYR38O9kyoN3esggOCfkd9f/7PW5AoAUHy4fJLzhti/RKMU/KL31P9f/LJCM7no1eA6k+HFscpcS5rPmgThvWIVzKMMavKCuD4WXCs6lInFairvNkOI2sGJAbizVpS0pZwqLNeemue1RGrvquQ/ZytawrtQa7BLkP6yRkA7FFBIhPqnjdTpsPzETk2tIKtHx9e3XtZ5AgaW27qI4/06i5wl6+/nzFvI3okoLhjN7hefCVPQFQSJNlw8O6W7CZSLLIowHHYQQoxwg0c5HGiU5YrHYsqZjbpbNtTz3FAbW6GUDoeBtEsRN1PcNNx5+O4sWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnytHtO2V0sD8tJjpy85yxDon+eA/q1O2557yPIdYT0=;
 b=sytxAU1TFMQw1w1vWmmk61WSpO92FOIPwo6xJ47sFjLXNA396oggTEMmaZBp+cCpV445yoOg2Qon+nnKD+gxLXDIIOulpNUO8UwLCv5wfdbvS2bSZaVaKQKnFOXmlDAH9WEPCJwQw0cckHUxB8s1E5/cc4lYQxg2mce8piFjKwo=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 10:14:01 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c3) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 10:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 10:14:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 05:13:57 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v5 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Mon, 26 Sep 2022 15:43:42 +0530
Message-ID: <20220926101346.272720-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: ef900372-ddb6-418a-76f7-08da9fa7d527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1+FNN1Z8mH7XwaiHhaCZIdjZvIbgNLdC/k7RWJ2tg60Hwt+eVYdUPtarPZKy7HP8HEOA5+T6+vrQE5y6GYSpwJ+Q6ekX6XqDw6zUWmnXzkYHuvLgO2kwue4aPmtJQygtoGArADfcoE8CCHPmLIQitsTivnoPRxp0h1r0UJesexIvYtdd3EqnDrPMCYrvHJ54yxCZvlFTJiVxr2Y0fjIiyaLWNkDpRsvaw+lvnUQhXOnOtnmtULV3/hHVJkhGIRsaMbQ8segLLUXpZBTZrsbxx5wmvDlPaEXKcTEZYJziT/sB18H+hQsm++9h3L20q6WutEP48UpEi1kdARhTRWTlwsFRTWjm6sfdlkWs/jqxKgzrUc5SpYrw8Jywkcy02yuXCaHFJ+YsjDDQcN/VvIDJroUWNOO2gKtchuxTsCwfdZSOe7K0WtEjzVigoYx6yw2SxALhCAZpAWcJKSi82dPsqLE/i5/uANvyRFUf6mscgzHRpm29w+oEG+EkRC+xofOZcGimrnrqtfGp2X2xVTQENL2+aOyPLXPRfRpV4wbLev5ba5SKoPWD/77u6TNzKRZn3qroUmcurL8+epg81aiDfXDBG+Vhr1yTCXsCpiXhAofPpO0Y7gpJo02HU1p79lX8c0aAtYETch15++5JSyCySocktf7G8ApdD0g8okMzCxv9RPH43qJfhSKoALb0alSwyCxYD65xi0nfrWHGldjenNCxQD/9Af5wRFRY4t7aWMsRp13NZe85C4O0khabE9wwxgumPfy4065h72vVnmH73OPxJhZoCVz2vxlwHs+FdHbKaNW21awp+oEyGIbVQLFrpPoFHBSCd8WMo/aSozP5SYk1kobv6DLAyHBsoShAoQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(26005)(36756003)(5660300002)(2616005)(8936002)(2906002)(70206006)(70586007)(4326008)(8676002)(6666004)(41300700001)(40480700001)(86362001)(82740400003)(47076005)(36860700001)(103116003)(336012)(1076003)(186003)(16526019)(82310400005)(81166007)(40460700003)(356005)(921005)(966005)(316002)(110136005)(426003)(54906003)(83380400001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:14:00.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef900372-ddb6-418a-76f7-08da9fa7d527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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
 drivers/misc/Makefile                         |   4 +-
 drivers/misc/xilinx_tmr_inject.c              | 171 ++++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 220 ++++++++++++++++++
 8 files changed, 537 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1

