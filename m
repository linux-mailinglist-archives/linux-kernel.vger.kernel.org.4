Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1E6B50A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCJTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCJTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8B1314C8;
        Fri, 10 Mar 2023 11:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inJ/EwR3hijHUUCtMHwxFW+aQVHsHvsTCQ23QgYHkJW5gfT6iE+3Q65q4X+zlSgX7ZaabCrmELBNgT1ULERopbF7oMsqChxete1ippeIjALs7annfPB6WUGhXYXM21i7Srb4Lh4cYEEwhzT9xzR0h5sW0TmAsW5YAnLy+786tPNREKCngymuTbwdx9pDgWjZk+ES7UbrCchs0LsgHz9rbd49azQ2OdpyQWUqB+qHaHVzh7JbW7h6mYlr7x3sfZJ6HfhRR56Dxyb1pV519bTweGAZ7Zl8wo25Xuv97u8jMccCh2Y1Nfa85gRH+1jX5X+dZ9qmOfPtYjIyeVKYuDQvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=gYuAUmLLYo59+GIYa91u7ODKK1ImnY34iMUTBAw5EC4/+W1GvVORoGvc/qbUX/YupeHWPNsHqHD1VUdeK2IvjrIYw8bHvGtA9tBD2phv3aAobVwbkz0sjvwXxg7bLU1aU2aUDLPt4ko3YOk+6+leZ/007ahJgdc9ak6WxvjOcZDIk370M5csfFeCLQ4IhgkvRWaMuFvbhBeIgZwiqD/LaLrrx8Hq0TU/85dhmGSuakWezsJaN6R7sk+fUfCgNxrC/YlqHVxAbAoR5WlvgVR5/NZqSEqW5RJKYStpTMvrY9AJf9pi11kaDCIqb57bZwqX33Mp1DK/kfclEA3qGooqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=DeWTnhAr8KU2+nl3RT15XaQmsKf2uR/QO8QZa6Nh/xPVa7LhZlT01cbVuZ+sIohPRewmLLaNJYhNYOR6yyyNZVsCc6VggDH9SKhtavqmLIdYef2D5it5qafivXuR9eCrTcjjNEgGMJUKvjte+yng9a6eQdtapiqBoUi227JS7b3oZ2E7DEOsfj5jV+pLbra+tMPP7mvgR5qpVMAZi3tAR1WT6dhQpS1MUXi7JIbouTJDa6MSCdA8Pb0StnCiCGZUyjFQ6eDTklOUET0zH9u5qoHuKz2ST5AFQ0r5zVOIe4VB00Qn2gFD8XDLRLPBsk3ZpCy9uauG0gJR4oxYpWqxTA==
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:06:51 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::79) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 19:06:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:38 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:38 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 1/6] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Fri, 10 Mar 2023 11:06:29 -0800
Message-ID: <20230310190634.5053-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230310190634.5053-1-dipenp@nvidia.com>
References: <20230310190634.5053-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: fce32ede-6c9e-44fd-61c3-08db219a9afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6IkMX4Z4rCliHBntxboqwo6foFLKsZ5RbI9/a/HtPOx89DKpAhuKjrcrVhp0IgUvkxKjChuz0dBmIG1oFOS1jtcCXVm7ZMT07nemYmVDoEAENwlixrzKPN8W4md3MS2HQN4ABs1bF+m9Tkwumexe7fV7WZeCseKXe7DBRJj4FWQM5k9NGDBEG23hvB3pRBKtSryOyKuFRGzbm6CxufP7f6RMPAQp/I7A24N1GCdO2E9R2DWCLyzVLOwlHSLwWhZGdV6wbBCa7XwFyXRiOTQvZYFtJUKejHXXlmk/t3MoAl77KEkJ7QRplRclUM95jGRH3vjvB6tKQ4xw3b1PVsjd0liY+CxDagCfkapWOeb1tem+5ldXXCSpYbV0QbHgVtQKEO/aIplmU7mOLycmvB6nGWTirKWAXtunDT9kq3M9mFGEJa4at6vOWvr1K65zjcX6zO+JatMH2Ta0UApS4bgF8kwOHIMWdHdiVUmKBopNPX2I7o1ChOKeoQPrxHSWjs2s3MH85tlVSQrVEGXcuaoASCfNBxeIblrsecGrtL6el2kLqY1jpvIqOo9vIv6swlboBsmUisYBotG9El1jp96piQzIJEJjNLS9fIj+Kk+OPA0A3B/jM8a7n6R0/JapYgghT3qzICqbz2Hh/2q0pE0iRxxwxqJ6tL8LdSf+ekRm2WQWeQzp4vM7eyHT1xsA3kAXP+d9Z69Tro7iYxsDAk7Da0thG2P/oeArQA5MWuTQxbCQaFVvo75kcrrPPjavm3mSy2iAaJSimZpK4dplWKpiGqXlC3J2pj00vThNZhKusa+cGW97uapIaI+dFoWvOJSNDmxaWGqnDYl6CuKKsgvGA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(186003)(26005)(356005)(921005)(2906002)(82740400003)(4744005)(1076003)(2616005)(7636003)(8676002)(7416002)(6666004)(5660300002)(8936002)(107886003)(36860700001)(47076005)(336012)(4326008)(426003)(41300700001)(86362001)(966005)(82310400005)(70586007)(70206006)(40480700001)(478600001)(316002)(36756003)(7696005)(110136005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:51.0471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce32ede-6c9e-44fd-61c3-08db219a9afd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tree, mailing list and patchwork details.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..65b58963f0d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9425,6 +9425,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
 HTE SUBSYSTEM
 M:	Dipen Patel <dipenp@nvidia.com>
+L:	timestamp@lists.linux.dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git
+Q:	https://patchwork.kernel.org/project/timestamp/list/
 S:	Maintained
 F:	Documentation/devicetree/bindings/timestamp/
 F:	Documentation/driver-api/hte/
-- 
2.17.1

