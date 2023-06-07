Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BC7255DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjFGHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjFGHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:34:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC91FFB;
        Wed,  7 Jun 2023 00:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIAhoCVtyGcKPkUKz5Hw8bIwrBnRqNi4TtmrDbYUKICMS5NbpekFUnxzpITAEwdSOq8+mPjg/9ehdbHKUi0XCW0eJzWmDknoCxPZGOff0nJU+Z+Xwx/G1dKc4zm5BS0pWd841n6htOy554Y2xE8AXajAZU56bClm22Kt/cZZ1R27JrUecilnM79NlVJ/qpp2gFMUo6Wixd5zxowmlehG6B3SA/DlKGwUVfY04vRxrCVb5LtoWa5yrcE94P1PtSvYG34XaLZVaz4nzehHHJ/9dqPdOdso710SJd0NyqqYF60D61MNCH4yLlMzXRDqoZeekwNWm8cUsFTbykgcBwoA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaVA7oT6nA8jGaAAuqZjypl5bmUtM+ge/q2crgX09oM=;
 b=FQyAQLWRFOzLTcaMk/9FicobDfqGFPB7o17MffBj05dveErjVbvPzLfAF/6+9R6sF6KNcOxCldTrUTSNZPTZJS/SyekoOrhxZyJKUsSXjceNuIqk+t/9pzXj821uWKEOP1sIgQ6r73JmeJEenonwA/hA1lOhbkZe5oBqh2vFd63oBS8bG1zEVNQtGo94RsQ7VwRj72+CVMmrPBg3YqbPuJm6tI1NUYRupTDggJhnyzA7FCMTS3KI115KWPDS4fsbKb/NVhvk2IIXhMRKbJuLd9QvpYkrQDwRadQd9ErUG1paAJC2tatbtyQMVgEjfDzcbesX719mrAXGo6VydxvWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaVA7oT6nA8jGaAAuqZjypl5bmUtM+ge/q2crgX09oM=;
 b=WGEW5AlwuF5pyLEybJP8DRqD+RzL9QvGmqMicBJNzSg7+tA3VBl59okXFKH+PbVvP/b1dX6U4AnJtBmDp3Y1EphURspQ8/XVApf4HabDJdkv+09YBxtW4C8i21D8dii8eSjBcdaDxCyKdtxPWxd9vv8r1mXGWT6CT3bcvJVk40o=
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 07:30:30 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::36) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Wed, 7 Jun 2023 07:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 07:30:29 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 02:30:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 00:30:28 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 02:30:26 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <linus.walleij@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: gadget: udc: udc-xilinx: Add identifier to read_fn function arg
Date:   Wed, 7 Jun 2023 12:59:59 +0530
Message-ID: <20230607072959.2334046-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: aa88ff5b-8f3b-4160-f577-08db67291243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Db9GQnDsjzFJpX7ti4XjNiRGOtKNJw748hvhLS4xXyPZwosuAzHrF3TBfN/VMcz2z5nEE9d99ZqJkNLDQh4akGWVIJXxmkIkKCsBJ4MKhEH+AGGKi430zCngqI71pARwixYCpJLq07lUsvL+/Ot8N2xwyUBVz8uSxdvf6P9nORLZpSltYj7egLjiWaRack9UPSgpqO2mePbaQOeegmUTFlYwTTW8Q12WI8vWBHsJ4vciRECR50KudoZ5vi3frSZY79e5qUTRMoht3hafL0qRn91fyEs7Sm4kxsP/aTIbPOl8pkTZpX6/iFoBW3d30BEv4LXB5ztKDF0CwYBJgb61hDxwDYAtVlDsfh2SgSLvy/6RY0x6FG9cBPR8fK27anzuvCvKH2v1oODjJAnV0Adw58r5cpEVLqGKtO/Sy+P1eA/I6xhJTMF/AOv1NOZHYdWtlY9zj57t14b+GeooXzcqVU0dumMIHO8R/nR2c7f03S0RJMhFgaW2Dp6OFjktIcfvtT1f9SQw3I4VGf3XDdSeibJ4LMqZS+Q61IKH5r6AbN1Nicrb9kHGRfY6DVKHYHGGnW1VKI5I7ymPZhBDBEI/9cNtS63IfWc1NBszPBVdBkTaEYJI+hrIUkb5hcE88gqJlA1CxOw6L3i9yDdNEj93eA0mWY9Ag/hbE4I0U1DXSDopwZ4AEj+3S4ynyaJUJIJyqt8dZ61qh6CLHblPcwx+HR2yN9XW+kineiRl2v3HUo/ig6XKBF0txcKd/GO5cFfyHS8kKoPFgpdzJd/CbtskWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(36860700001)(82310400005)(36756003)(2616005)(186003)(47076005)(336012)(426003)(83380400001)(86362001)(40480700001)(356005)(81166007)(82740400003)(26005)(1076003)(40460700003)(8936002)(8676002)(5660300002)(41300700001)(44832011)(4744005)(2906002)(110136005)(54906003)(4326008)(316002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 07:30:29.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa88ff5b-8f3b-4160-f577-08db67291243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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

Add an identifier in the read_fn function declaration because based on
commit ca0d8929e75a ("checkpatch: add warning for unnamed function
definition arguments") it is the preferred coding style even C standard
allows both formats.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 4827e3cd3834..609f7e30cf2c 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -192,7 +192,7 @@ struct xusb_udc {
 	bool dma_enabled;
 	struct clk *clk;
 
-	unsigned int (*read_fn)(void __iomem *);
+	unsigned int (*read_fn)(void __iomem *reg);
 	void (*write_fn)(void __iomem *, u32, u32);
 };
 
-- 
2.25.1

