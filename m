Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5455B2EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIIGTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIIGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:19:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF1E6C;
        Thu,  8 Sep 2022 23:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUWM08eTd4MAIXWzorYsFc7cYHBYnewYWyxBuH+OEB5I6Ou6S0cXbPdgoU4HXyuzSfm7AzsUWymPD66dIh7eFNsCpWx4EWeB0lA5oRhYuJ8YiPZ+P0MXdwAJkowQ95DnMf0s8CHmlql4T5DiuvFbq4riquLpBk6PJYw/2EonX4kYLfYDAF/usRpTwH61kb/HXzrdk+CsLQ9vAmdX/5O8Vbv2ftIgISq/w1x7HVOd2VB2IJl/Mh9+MM05ioAW1K6Hnld3SavC2jGPKdFXW1wMjRLVs0dPRgvFivmIdNha03h0go8oJoaOFE5iOOnoFLFtItfqAWRZNBp7ODDSYL9pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0TobY9GxSq/WyvnmoLg0s9rusrR/3otS3Xw9Z1eUOg=;
 b=l0xWaicnkj3ESuQPCRNUBdaR5wZsFQ1W3hDoFI0bTT43OL8+i647MCpjfHxBWSHwZIoFNSGQeahb/RXa37J/aks6JIBrgA4W5QW3uXP8h98hkwiAOsUIqhIEwV8URu2tq1GzyE7/JA9I/Zfi2+OMfhoMjcfQMkHboBPaWdfJ/V8O+n2MojSPYbwX4qaZlaZ9b//1K/TgoEgoM2T4cLJeSpNrbMyattZHXVL01bmu+zZ9oXWL6T5UGjRHKe8FhXzSIRtztmhtC9U6MyE6i1BzuuKzbLYb1C0338ZnrWOgQX1AZSJuGm1qarMgZ6Y58GFCFEzCTmcN8vrsyEVAQX8d4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0TobY9GxSq/WyvnmoLg0s9rusrR/3otS3Xw9Z1eUOg=;
 b=0rDzzYdJ/S+aVAmdUMuYEM5QlH0XSFrVPPtFUm8f8uReD2aL8a4S5qcb493e4l16AdP8MveaCZPKuP9XacmjEbEFre6l1LzTMUnhbN0C4jrq0NGKtI0HT5MuqnXBfzn5Y/m4rSkRLJJ/ioe8/TkPz/yU/yYjpGgK+wZKh5tQRGA=
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Fri, 9 Sep 2022 06:19:21 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::a2) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Fri, 9 Sep 2022 06:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:19:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:19:19 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v4 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Fri, 9 Sep 2022 11:49:12 +0530
Message-ID: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 836ee55c-35e9-4518-8cf1-08da922b3bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxvtbG/owhGClZ/Sz3w/j8hijMoaYK52V8E2RzGG6ap3MxRVBeUOLb5/WxYQtxVf8xVv1o0fdhHTq82FSjzncBd2w/tfi+N9/WJsBtCR60ji3yonb2Dz8Dd4JAPF6jGTQHAKopdd/Ajk9c1P2nZvkWEE3xgPA9ykVjhnjitj5c4SHpNlScqYjnkL9vxwfyKUd7g6ckSW7WKxe4RAKDXCl93YXQP1EX3oRU+FHYs/PGeVaeSFwdObileO8F0qeKg7uU81h51izroHZavU4QLY5W4ZDHKwHuYYqPoYH9xpcgO8ybydOiocPpUjVXZSJk9KcYqUbhrwgGrGa5kO3yTZm6LO5dxzKUVfanT1Pu4lGz/NUYzeuqU0aOaNDf3TzvLGUkjIgMAb5wAtvtSBuy6sa9jsf7uDGPOlVKlMK66WOuUq0uFGJj7n5ALX12PNMn/O1mnvdFmVx2zP0ppvOsQ3xcOllcNEucO30mvq1ii59B2b8G2SxTDZaGwqQfgr1qzNQo+N8O+zwrRqVbp6ZfVhRSHp2VTiSwhX9Ztleh+O//g5mi/yv3UA9+VQfOb14Zi4tTYZmRWUaHqDqWiC6XofCjoCYVRE6F0SteZLDw9BkDvEs/uiHaEsHILbWmBKSo9QQ03OTXIDx9HOPznQtR8qzPlE35HgU04XTVaU+JcZQqzRvl30Mc6gPEdbRgFlOIuBlmTFcGJx4BqfCKiPyXQdeZPkhKxEG4pRmYSKL+xUVWjlGwWM/g3MHlXjQjja5mgv97SzUgaWG+8GDoKiujrpJEiNPj+577fpT3SAJv5TAPc+RKS8fh5b/ejHMLDjNEUb+5JpX9qe0gjlBB/fn9sGRb0NY3zmIERqbshxIg/EJlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(81166007)(356005)(921005)(86362001)(40460700003)(82740400003)(4326008)(70206006)(70586007)(8676002)(5660300002)(6666004)(8936002)(41300700001)(54906003)(110136005)(966005)(478600001)(316002)(83380400001)(336012)(16526019)(47076005)(426003)(40480700001)(2906002)(26005)(1076003)(186003)(2616005)(103116003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:19:20.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836ee55c-35e9-4518-8cf1-08da922b3bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 MAINTAINERS                                   |  13 +
 drivers/misc/Kconfig                          |  20 ++
 drivers/misc/Makefile                         |   4 +-
 drivers/misc/xilinx_tmr_inject.c              | 173 ++++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 222 ++++++++++++++++++
 8 files changed, 541 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1

