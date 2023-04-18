Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98A6E6645
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjDRNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjDRNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:47:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DDB9;
        Tue, 18 Apr 2023 06:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJfW7U8ObXB5eY5lolX6Akv2t4EdJ+2GRmgyfOVzdxPghLlic6HGhFVfOVeKIsrBL29ZzjJSr4+ZR6Wr+zwpp9Wa4AY3kV+dhOxfcbNqkO4+Qmd7Ten5n93eZ1ZGCd//t0wC1MqwN+5YkfrGomKKmZdFTGoUmaaW56aT24BlD8wiPr0MYmmgG8/Gsh8TzcISGN6uVJqdxXaHtRcCj/Hp80rk1yIewahZbQOiF/+EmZTVaF42CIC2+Miq+MJr6RThrTMEmTyLNX1Yla8QFM0EYRsNIcTXByLy6lYjZbAmxGOSEaBMoPh90cDnkLQQjPLXplcscdSWNkwN+VojZk4l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoiUEuLwJBaGNKKBFPinJs4NDz9oT7ftjB8+kMxrtE0=;
 b=InDYUqLJnme4wc6momCqJMcI8n5u1BTiIpya8KmrsrjbXr1TE0tLRuFyvdOPg86qMINv2SFngxUfgffSUBXdcsVaWt8zFfHfKsqetJNRwi8WvwxD3LANLLWFRsAymHTqWNNhAZgy0SmF6CKj0dDxfufKtIJnt6rythxI0vKJ0guaJS7dTLhk12npYonAAIEU76EAATssG5OXb2C2LBUX6GjFgu3oKZgSmOWraURaws0Xdt+GlaKBYj8gB5Lkc24aCm1aST3E5zqKKDOqzWNzHiQzdu5z/J/MP2toYSCMlMc/zi1Ixto/KZOs6LpgiStlR14S1XUwdDfcRSBsdL4eDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoiUEuLwJBaGNKKBFPinJs4NDz9oT7ftjB8+kMxrtE0=;
 b=bs3qvbKKZ8MvQKeafE7hU2L03JB8ImcTfJsMA0bD9/+VBM+IzrSIBCbVAEFHOo86NCOa1dSl4+XFD4/7ELGfo6G0sM4TUMfFKTqyiWlNBNKYqp1gqK0ZF+3yS8Nw27uPyCtP7MLvIaqvKe/C8j6MBWOY383TjGkUu19Rll7yXhA=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 13:47:13 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::e5) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 13:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.16 via Frontend Transport; Tue, 18 Apr 2023 13:47:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 08:47:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 06:47:09 -0700
Received: from xhdvnc205.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 18 Apr 2023 08:47:08 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH v2 0/2] spi: spi-cadence: Add Slave mode support
Date:   Tue, 18 Apr 2023 19:17:03 +0530
Message-ID: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 06821ab8-fb5a-4d42-2421-08db401369fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7+v35TvOomleIvoGxiilAyEpV1MO88lBr+Hu8iU4YLj8FRxaJFMlP7QRYSRePhL86qDzJkayxCkcHBcDEueGwy5gj+0FFYZglh1eHrbFoiTCKKpLkeC/B+qXXSndq4OTN9+/d9IzA7yXZ2GW4jzQF2NsuP/zUaI9na7U1NC71n0FmamzXzxyMy/UI1r4WGCd0UUu18+jT54JdQ4NwLWfuLzHR9eCdxAyH2bYwLgebqCYxNcJT7wePYlRPkPwu6aE8IsWF88XMWltBrAyCH2WW54DJwuaD2oyMZcD8DICWsLbeqEc9zN7Vd1KXYIDTm21bQXqhUNxcUCFgY7L1DUTgb1n8FzelWzJpQpJOoXYq54nnm+kuGsrSw/dcVWIIXas/8rqXtqRNC+g4v1T+Eg6YHbyaqkCbVM72+euzJ/JMgcnrLCeM29W01efwP/IPJmRskMZ+jfRKie2+577iiutFC1lYTqH/aqVtbag+ZEqXnIssr4HQVu79St3B9FaDU3hbs3pyjP5SaAg/qAZefGPU8ADjfcArVcGwsslPuMuIeoTh/SAPLx3TYQCXHe4LTWGoQlEM0/tftEO7Z10UVdkM4a2DWY1j91/Mkd0Z9OFMjd31GkkQ9yUD5CrlbPJon9K9zCfQy/+H4PcSyULq1Ioqm5gw2+9Z+LIuu9Z79DkvfNLfcWWDjllEhCTSHyeztQLlJSdQwcPXhLrqO6pHrldMttZxllYqrqR3XfCDLbja0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(316002)(4326008)(70586007)(70206006)(6916009)(478600001)(54906003)(82740400003)(8936002)(8676002)(5660300002)(44832011)(356005)(41300700001)(81166007)(36860700001)(186003)(426003)(336012)(47076005)(83380400001)(2616005)(6666004)(966005)(26005)(86362001)(36756003)(82310400005)(4744005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:47:12.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06821ab8-fb5a-4d42-2421-08db401369fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spi_master structure with spi_controller structure.

Currently SPI Cadence controller works in Master mode only.
Update driver to support Slave mode and also Full duplex transfer 
support in Slave mode

---
BRANCH: for-next

Changes in v2:
- Rebased the patches on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
---

Srinivas Goud (2):
  spi: spi-cadence: Switch to spi_controller structure
  spi: spi-cadence: Add support for Slave mode

 drivers/spi/spi-cadence.c | 324 +++++++++++++++++++++++++++++-----------------
 1 file changed, 203 insertions(+), 121 deletions(-)

-- 
2.1.1

