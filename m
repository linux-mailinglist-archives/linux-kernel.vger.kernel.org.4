Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2569B83A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBRFjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBRFjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:39:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08525CF1A;
        Fri, 17 Feb 2023 21:38:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDz089RmtR1bSMTVczJvXpbTDbCYJLXUNIO9x8Y2JjPpztlnhBayqSfl8ArQhmevxc8VLwo18A7X/w2rXSN1XjR1jP9Xe1q4xW/f7zXdDmJ1kwHCfzKMxtqC+jFQSeyTwq9+BqZTiiKQVz+R936lq97aCba0u7vju+iGwJF7VnBhLLuqhidW4oiP3Gi3Qk4zuHhtUj3oxXxPFVBrYqB+wviiSv1CWv0tskYo4ZpJSWMjYQg4kUfbRJaXQwF401u5LUhRIguHC9tapC0Up+TyMUNlS1VSkHaRyCUv5IPJ30uYZIcQIM0XWyccTKhlrmPmjqEI4/we/ZXG5hSZVR4FPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z89+Ult3niz4FXpvOfFcRaV8fsyqoGbH9oQZF1UW/Bw=;
 b=OFPRO8Mh4CI8ad2NxlXAoQh9NxMFcvBBvWpCdaDcisOK+9V/hRk6I+rhnMvbBUSxp0vm9erJz2pPQU6xScr02hVo/RQ6jdpQ5xMfUawY4zVsnX4ZvpBb/04XgJnhfTENeN8o30eCu51ZjGj53WlX/UsnZTLSNB/+kyUIvA26R3ehaRG04MGtYaVFabofMlajZYebxbpS4JEoMGjRAKvcfJVnYBd0GvbcqajGmpqA/EShC+yjfBYtuyb6Cm4B8KBQGgsCRbppwZj+4FqlcSvTf3WxXgt6oWQSltZ2UN9LJJSko3mhRF3YiDcP2tS79q8bSRYCAhFgLfybI2pY3BRJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z89+Ult3niz4FXpvOfFcRaV8fsyqoGbH9oQZF1UW/Bw=;
 b=kGLkUYOxEIP/08Mz2Xz8B16ESvWV1R1uB9N9P+Oo6uWnkJRO3haDYntq+MwpwnvhtbF5BnUK/UaPXjTh0XqZgOTWEzHiEW68uAmsqqQnCa635g5qEpwwNWk+jQLdSe7JYnRvxcmwigx0TEXZIKQiSAsir34ggedqLDBbUL4RHw0=
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 05:38:48 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::a0) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Sat, 18 Feb 2023 05:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Sat, 18 Feb 2023 05:38:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 23:38:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 21:38:46 -0800
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 23:38:43 -0600
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>
Subject: [PATCH 4/4] MAINTAINERS: Add maintainer for Xilinx ZynqMP RSA driver
Date:   Sat, 18 Feb 2023 11:08:09 +0530
Message-ID: <20230218053809.1780-5-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230218053809.1780-1-harsha.harsha@amd.com>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d61cbf2-8788-4b10-d8c3-08db117267de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bs2TSEAkrzcyYS4en/Zfta2OvbgD2jHEWg/iwkFOWqsm+Umf0OkIP41MD/cK+sO85wMbTATZQfgZJtYQb5K/dstsXEA9QYQlQNI+jrBIGx/HP1TH84fO+7pekyhhvpgZEA8gYVyZtABG6TL988/7yO4nbSPb1RXGBftM5P3yxRAv6YX1piIk/oTyaDdwllXBlI1gmGzOtB/lWt5GhM8ciqdsoTcZ6TUYTGv0coxz8871u7+f9/le2YDAztPJ0KmKdXp44mWwvxUXI3H6cUgp+qbulG/E9KMD0Kv22Z6MfQq+whRET+wq7ezjfzatdu/q28QYfCVCobhlu06mTRvQTVQD91TjsRuaUOF1B+aZonRdlMOcg3QQXvGs8a7/2DDp3lGi10LaK+XI5l1kB68enlYx1BNDWEWUqNdepH2qWR12FJ+vpzXYgcIju1AAkO/DjLD4XK/+2vxoBnWgTOjbL4yKqoZjKuOnUB6KOYbT0fCByVpUXRsnLTbPvVQIHMMkJRUqcKmcCEQ8KhLhQqVv3wDecgtmvBunMBjZsgiCFmFpKtikAVmueRUTLlOeVAoW1NtEbVVohX24Y3+xnEpsSHSQJY0h7n7V50reXcjBz+SVUqmiyRy6D5OZDE5NR1A8otCpDCz4ckYYJXUyLktF2wCmwOWtJ2jPWTainM8UsjJ5sVAAfuvM7A/zvJAhr2zgROvmxXwbFetr4HHhNqn6ch/x2d41m1oLlqRDz0qZMO/NCjjJTEqz5IMzXgFZE3s/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(82310400005)(356005)(336012)(2616005)(6666004)(1076003)(86362001)(26005)(186003)(36860700001)(40480700001)(426003)(47076005)(41300700001)(8936002)(70206006)(70586007)(4326008)(8676002)(2906002)(44832011)(5660300002)(4744005)(36756003)(82740400003)(966005)(316002)(478600001)(54906003)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 05:38:46.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61cbf2-8788-4b10-d8c3-08db117267de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for ZynqMP RSA driver in the list of
Maintainers.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..c21d646cffb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22907,6 +22907,11 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX RSA DRIVER
+M:	Harsha <harsha.harsha@amd.com>
+S:	Maintained
+F:	drivers/crypto/xilinx/xilinx-rsa.c
+
 XILINX ZYNQMP SHA3 DRIVER
 M:	Harsha <harsha.harsha@xilinx.com>
 S:	Maintained
-- 
2.36.1

