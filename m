Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC87E6962CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjBNL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBNL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5123D95;
        Tue, 14 Feb 2023 03:56:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPZUmStpBL/KGm1PoymLq8bYBhlaPHzfQy45yP2NsKdEnn7Ri9alL/LlWUOb1evuJhq9D02VaoxOlV9OLkiaDwG5ES0HTrhqIyuwqaT+efDNsCOizqxvURP5teMM+2Y8ZLis53UyaCw5wYRXwALiaEQUvQYc16Xw/AR8PfAwV37gom4DgXAGg2ZkpEZsNpKph79+hokUQ1SrWZlHtX+I9EVZN9x4pI23yaMaEomdzTybhVAlvG3o8crIiQctOYiVo/3nEUfHe2WJHo67eB8QkLAkoRclJBzo5M+UcD9nKvgZLWRsWkwDFHwJtauUsYvYFcMPjeezKV/XmGSaTTcnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V3AjrDXIMTxZbOYicdS0eESYRx+x1aj5po6tKn8lyE=;
 b=FT5n4Z5dPXP1VtkUk0GPOHFTJirM5iyO6RiT2otC89sgjvpxXZyA05Hy8wvPm19kYERFYX7TDfav1BxVLDhWl95EnID97wcyO+0H0oI4NuMKspvmpyX4F+FH2O3Uvk6bYs0vB9Y4VnPz6lQUJhVc6eFQ2Lhxj69R31V3NXl6hS3KCT6cErvlN9zCCIW45kyyWSvVdRPUsnGN182gX5d7iygb6V8CzR9gio+2luKeEIhCC4NPCiQxD6vGXM3+QiVRBEN+FQ2VesyRhYaAcyXGbN93thOiiBrisMODDv6nBX0Lhsiyu0XUVP3FkoH1dQ7SvXXv1W/s7Z+fwh13xTqImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V3AjrDXIMTxZbOYicdS0eESYRx+x1aj5po6tKn8lyE=;
 b=trGBTHVUkAeGhNiZyNsZupEnpHdVC9wSZskEO0TOkIWOPh1DcrDTcoOxGOGa9TnXptlx+UPauATPsT7H0uAKReEMnMrrdMPWXkt0tv4GJIeDI46Rej1gICh6Be1oi46SWAkZJRYear6K0Wg8Y0LO6IGykLJ1Y1/HmdQ3bCF1HGdVyFyAuLfJjNKzJSZBiIVbuS/e/YHvSpeFoqep2kPD71i3ft3l7VR0S0qVNJPVmwns4wJlOAMFdAQL5LGmVCpucE9NIg7Zsa1moVHX8XoN5Kvio3CB/Xd90MHyJdITKY4fvsINgkg8ZaxEmb0xYYn/kd6gvtNc59up/VzoFF4TnA==
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:56:08 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::3) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 11:56:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:55:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:00 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:55:59 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 1/6] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Tue, 14 Feb 2023 03:55:48 -0800
Message-ID: <20230214115553.10416-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: e8151d54-2d6c-4475-eb73-08db0e827584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEAFDeODTnJBFAy5s87iIf2sZ6vZCw7fp/YExcwhbBWVACcF1ZbnA83JuCa5PufCOmwweyEV3eAPICsPUDign7MSywAZ0NC77hTY7E6q/yOfNJLQUv7kKDbgv/5uKkhZI5UkxoQ6G5GbTx0pKoMpcfgRywnS0FBlHn1+mltjsQ1ggSBM2OCiKC1CoOHeBKjIoTaDB5zbiEjBmi28cFVzTx999O1P7m7Da9gpgpOpDwQMStrgVnebESYmjzp3VqQMGl3fa23YTKBATRQiOMeNBRPCY1Tui+PZP/aK2OfcYaeoC2EMFHbo7eeYq9keuMKiIhahDkSmjMupg5zJkN4U6lvIXYLp8L6eas7GXDwct/GcSegayLmMB+VvUSnY+17qe0YTASmjav337+xpMIO8XKPaeKBrjxF8xxhpowL1lpe4Pnih28ubvZOBKElCvZ7fdw4cmc1JmD7yNSnpy5kBqATa32xUkUZ74objrokRw1MWly3OgrR7n6esWGqxEtkiub/B+Zwn58Jn8zbcNyIp1wq4G5qlc9bupUSkQcGdnXCu3k6aX+ZEKPaEKsB20xdZ6e14QytPF08LKVApd01tVraJoZjIv96bVW9BFOumhFqJOuFMNtt87s1fFLELaIblSdhYG/M8TGN4sATUHCIHIVK4W53qw04M45HtLDroq6yy1j5bE+/v4zmjFxuqffhlXdTH2FlatNIZU+r1Cfqs7irnwv1L7AWAj9R2WVhr++KWTynYr+64k/0/oIE+AMFlKQzo2rM/gkKqT1izhxrXqA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(36840700001)(46966006)(4744005)(36860700001)(2906002)(82310400005)(86362001)(82740400003)(7636003)(336012)(47076005)(426003)(7696005)(966005)(186003)(36756003)(26005)(40480700001)(356005)(921005)(70206006)(316002)(41300700001)(6666004)(110136005)(8676002)(4326008)(1076003)(478600001)(107886003)(2616005)(8936002)(70586007)(5660300002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:08.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8151d54-2d6c-4475-eb73-08db0e827584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index f61eb221415b..734c988a7f7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9533,6 +9533,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
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

