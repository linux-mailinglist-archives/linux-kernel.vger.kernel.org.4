Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302C72E50F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbjFMOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbjFMOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:04:44 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6D1FE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4HrQwboJzoFggRYzLn9sEl3iJKJSghrCK0UyVzHc4TsPV1fveD48uayLnkEBsx4CQRkYxK28QL6EfeTZd8WjsUNry1gqYCigrptrumj0EH8171MiAS3E2G6KalupFx0FYMGeHQkHUC6E6f8Fa5WNjAoxv1JrwqU9QeLlQUmTt5ujRb0sTlJKtAw3qRxCvbD6fsYWLEq/WDp2Box19LaTCFy7cFZSMJObMA56fmtDzmueo1RvwtMNc5vmMxb7SL3ryC5414dxpbJsTwB9KAo7kYCFnyzNajrMn996uNwrH2iRf2TSRD445gWpFbmplOepJ4s1Mx67RV6qnT67UAIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O853PUmSbzIY+hSxTHouJeVQTKMfa1e4rD2vhoG+3WY=;
 b=mRv+mNok0BZlogs6DtcgO+8gqfSTuebF3B0fh0axEr8aCDQGF5kZv/4OBHqwK7SVuy3Mq0wIo/4OTDy16skIuvr2o+D9MwtR1z0F77KHiSVTFK8Yg5OEfoOiKUxmRudTnJRrPknyHXLMdDbrBqjz4FN/htfQmf0nqfqhBggvAcE4IZMIl7MmqcHQcdKBExSK7PAJQ6ZoBGBkARnqroKcEtyHoEGkLIRAW/9htEunVW+VtEY99UPGbGB7zN3baHbk0WyGxpLJjafpKdf/GUnaoUHYD4+6i7b8aI1d7KI2vp0iUixLTSAo0wLatxBXmbJqsxYpZ36R/dV9tLa66U/iKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O853PUmSbzIY+hSxTHouJeVQTKMfa1e4rD2vhoG+3WY=;
 b=ME5l30/lnF3w8UJT8R4WuZFUUqIQWF7o5A3O0EaiFxzOh9aMmqWLXrf4XEBeE+quD1AYeYahBOMhW0CI4LzjuyJbhPHsZ0rX0qhd/bN2I7Ij54Jz1HxsK72hqflD2GSLQnkUoUjuz34SPlUaREKSAgvA++nLVbZE8PwudpaFbAI=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 14:03:41 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::9d) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 14:03:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:03:15 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 13 Jun 2023 09:03:12 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <anurag.kumar.vulisha@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <michal.simek@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 0/2] phy: xilinx: phy-zynqmp: dynamic clock support
Date:   Tue, 13 Jun 2023 19:32:48 +0530
Message-ID: <20230613140250.3018947-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f44b917-392b-4dcb-c280-08db6c16fdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXS9iIIvK4zS0Si0+iTD6fx3UYwVHCOAVFay7ar1LHDWY1lt2hOk1o+fZXat1lKSBXUfXi6JBFslJQIx2ACjNw5YBLjHKr0+wHec1QgurPup5cLUr3+PjwOHw8LbpCD08IF4LKiCSYsEiIfwJUUVdBNl32+oW+i9wVC+mqhQGrQhXOl4VaE9soaOOLVWWbinCkrjGzeFu53sTZL0PtRrvkj3DcKliIY2ogvUSrs7zK/gXaKQ4EJEouQBVS1zTnCcitu8tNl6tdzknn1MpdPyL7k2MgJz51qRnhiAuNssl4caS47lPQazVouz14ECX8mkMva5iJSOnTE+whF1Pf8eEf2eyBKqtNiLdOofufUmXQv8qnP483Wla87wFXAexXMbjtm09rTGAEZ7Inrap9ltRZcXUSp3i0ylkmFVtud1An7+cmGLXuUAjTEXBC65f/haUUihO+awyQ+rPP8FFPG35tFQtakCS2ZFvrxgOUARJZxF3bz85rzX0sgfTsXPENzXTBf0bZtmBOQm3VuvX+7VtSNFkT0QceDm+NOWaM8VThDsXm7jvn0J7TIEPpRbZ9EKrx4Y6iglry1dCneZrNFxXKRefqxhc6jDURy8G9/gy/Hvj7SdmwiceLmkap4NisW1Xcs5afmN6eWlfOcvhiWsRU/2lzwuzYLVr64QZaoIN6bs2VnNx8UhTYdZ4h1v7hWmcrr6DFZ0kkSk+NMDNtong5+0fon/4OsjnD3rtF996Fg18JbSxjGTqMD07pmkhQd7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(83380400001)(36860700001)(336012)(426003)(44832011)(36756003)(478600001)(8676002)(40480700001)(8936002)(45080400002)(70586007)(86362001)(316002)(41300700001)(82740400003)(356005)(6636002)(81166007)(70206006)(4326008)(5660300002)(6666004)(2906002)(966005)(110136005)(82310400005)(54906003)(186003)(1076003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:03:40.5476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f44b917-392b-4dcb-c280-08db6c16fdcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
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

This patch of the series adds the following supports:
- Runtime PM support:
  Added runtime power management support to power saving during the
  suspend and resume calls.

- Dynamic clock support:
  Current zynqmp-phy driver, by default all the clock enabled for all
  the lanes, that consumes power even PHY is active or idle.
  So, the dynamic clock feature will be enabled clock only for active
  PHY in the phy_init and disabled in phy_exit. Clock enabling is not
  required at multiple times. Activation of PHY depends on the peripheral
  DT node status (status = "okay";).

---
Changes in V2:
- Addressed Vinod Koul review comments:
 - Added runtime PM support - "DEFINE_RUNTIME_DEV_PM_OPS" MACRO used.
 - Updated commit message for dynamic clock support.

Link: https://lore.kernel.org/all/MN2PR12MB43339B1089E1CF552152DA2D881A9@MN2PR12MB4333.namprd12.prod.outlook.com/#t
---

Piyush Mehta (2):
  phy: xilinx: add runtime PM support
  phy: xilinx: phy-zynqmp: dynamic clock support for power-save

 drivers/phy/xilinx/phy-zynqmp.c | 90 +++++++++++++++------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

-- 
2.25.1

