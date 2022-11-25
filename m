Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2563838D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKYFl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYFl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:41:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E680220C4;
        Thu, 24 Nov 2022 21:41:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/ikzAx8cTEuyPlb/RsH3Ci0zSN77Ni2HSxf9fwruOU6VNLLkZ9NCkX/AM7lGu7fE3iR54z1Tl4mXZJ5VS+VSdO3KXGvxNyXNWP+M2dK8oU7cUF7U6Q5+XpLPKZoPBKM/D2xq3Z2WBChLlLLpJ9ZoaMdw21TBGys4dKd9tziCZWTHij5FoFdVgxAx9S2lYRDoP+H8RHSjddeGAlk0lDNrAwm7AYyL8AT+7anklBj74wIepgEBRmxbxpHTAObCCDUClTrou4qTfF6/Hl4vg5YdKb382jsC9EqcHB+RWmiF6r8arEwyfqSX1EjA/AbAhK57GLYO6EKLI+SbnQAHeA3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfuu/odHD0RxvCn2S9Hv0oR9qqnQkpla11gH7jXbCD8=;
 b=XrQR4SXFrZLne0r23ShC1LFoY0Gl2NNDl/v930uYa3CcwJ245Pq0n3dqmNxQNrOXBVC22ZZkIOUdXQXWLSFKr/6MWAAO2pnW/ShJnORT30/voM4fqLcLwtJ32zyLdxeDcFBy6Hx5duZ+t932h+Ho0druwzRW3zjmdHECZF+jZEX8kJILOXVZsTym/UX+RyW4yB9jpHqJHfgf5sWQ/mNH/0sfZ4iWRVabY37Wl+PGXrcM5MqRyAKZo2wo5AroEAAuL/VnmGW0H/56d1oAZNLvcMuJlb9cH1I8efae7ObhXCq4pgcSmTgFHAWSbDSPNQqv4xo/9yoxQMG362sTnT3B7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfuu/odHD0RxvCn2S9Hv0oR9qqnQkpla11gH7jXbCD8=;
 b=BHohGk6CNuQhdD+t91EdN7XfKc3L3JUlBeHo1/qIH0RcqIxP75quZGe7uKiaY3FlJhv8SMHyjA1kljsSAJsD10y97cbn6ClU0XyGh1964WKgTOaRQEnhPOtljX3zGPWWfj6fCXgNUO7Va8qCi7ke/WhsFRQ88Gp5nI1tumLJgZQ=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19; Fri, 25 Nov 2022 05:41:50 +0000
Received: from DS1PEPF0000E65B.namprd02.prod.outlook.com
 (2603:10b6:8:2f:cafe::8c) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Fri, 25 Nov 2022 05:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E65B.mail.protection.outlook.com (10.167.18.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Fri, 25 Nov 2022 05:41:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 23:41:43 -0600
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v7 0/4] drivers: misc: Add support for TMR Manager and Inject IP
Date:   Fri, 25 Nov 2022 11:11:09 +0530
Message-ID: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E65B:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a03c588-dbc1-40a8-fb75-08dacea7bf3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il8CZws5ofdB9CpUacqWCxA93DZXyJdIwqhuIabDVZPJWbQOPOPtz+nLe5egGX9PBVu9gu6cJk6VO8bTL4mZwZ1ofuseUlsycfPSyG4ZVB46HjIjU/FfA0QGiBJtC17nfjS6EfgJNPm2DgheMRPZlc3sR1aMngl7S7axJxuFIaSnVEZfRS46Z3EGGJqrxjK8ZN004ieRsEW4HL+ILyzGF/XVnF3hGil6Nj2dzB9towMvVt7u7HSScsoV06UrqMVeudh//R+rMaR+7teunGgHg7UZhEYtCGOz5a0XeGY4fZzjLJm+FbAlS/c+ZcLBYNiUotpz8FMZQcnOZiglLT+imSul8h238T1U6x6MApo2e/R8pe1vSq9q+zBdb2AXdPel2qYTTNzZVzNvyDyaMAhtbd0eEHIqJHE7wFZax76PguB61QngxisJMcfHmOAJRKblGAclwYa4nG2f6QQ/6uJBAwmG/qWKZB2CCMTCJ9zJNK3+4JgkdOPoudRXjV39kSkFU+9DpbxuVGborFwI+LAj9pXJaF6neIDyHel3f/B4H7feHYdLAndEviSFPQt7CZKecb8MLrw8cWraJsY82Apj+mzOnOnWjUwLnqWC5eXP6LmZlDVMwhIio8Ql3y7vZ12yUkdoXIrdE66xUNPglXzVZN8OnhYXT4cE93y0+b11FRXYO2eD5JSDzkslUZ7NqsE5d/q5b3q6VrWb/A4jaBhWkLUHUeqUN+hHRcDqgBz93Oray3POCb34OKBViNqS/nJiuC2NPV7ieUk7r1UVnCejAiU4jn1j9rCZEe0O4Pm+2wk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(82310400005)(47076005)(426003)(83380400001)(54906003)(336012)(26005)(2616005)(1076003)(316002)(966005)(86362001)(6666004)(2906002)(103116003)(8676002)(70206006)(70586007)(4326008)(110136005)(36860700001)(81166007)(82740400003)(16526019)(478600001)(186003)(5660300002)(40460700003)(356005)(41300700001)(8936002)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 05:41:48.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03c588-dbc1-40a8-fb75-08dacea7bf3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E65B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

