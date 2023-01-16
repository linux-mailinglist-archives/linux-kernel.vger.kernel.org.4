Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558566C235
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjAPOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjAPOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:32:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92F2D14B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QytSTJ2fJQ+m1O6mRhCFAz8dVMROcvIlgigXAp1M3cnnc+R+W23P//RuKLwDw3nxoJw6cAMZiHZJUnSnhRBUExVMUsCcWMxOScx59SScqG6Tig9q/MiK3O2jRMAXWUuHkjCs9BnjESMsauQujamnE8u7SMYG6KvuF1gXCxnLMLC5K6fMhebqYgbfwmhRlx7/29v85vsZc1bqG9ruH5jrmOPTmb6oN4qNsQnrJNyrrob8I1PIUdAXVaAL5YD3E66DBJoaYry8mLOftVyT5sJXx29mpRUybLw2gXgAmJbA0AoPKo2BkkH8rVGNCOT7e2FXS+iIb2vCujWZ+bkL4FGWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb6iXDGPAlL3TZEXbmMuRTp2IIEdxjSqzG7DS95kCpo=;
 b=cMH5gk5CTvbMMX2XdO9+A+9Y173lLguZmTffaAqI/2F8OaNVwrA6Q0ItCvhA0wUo1F2awjVkrA9CPhUrv3OD/D3T9lIS4lomrvDW34mcsTrtznIxL7xBJ5PWvTwu/m5YYdLAcbEn80m8cvjhRQRwFZlqmjl/HopJ1iXThWrq6azDLBBzyl8w92aOWeTFgORNqVWeMg3J3yLDos0g25JBLEc9RD4ejGIQ5mMZv/oBgTSw8nmpcsaNNbL9iWNChdvgDagqpekm+EvNMhf5c5MSNGxSjOORVzQdFBOGgzSzHTcjOwGo9WW3L9ngZmovqj3MYAJtmPJiFhJ3PdHqzGo5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb6iXDGPAlL3TZEXbmMuRTp2IIEdxjSqzG7DS95kCpo=;
 b=m0ZupkRrTxxuHy/LL/VVH1VOwKjy7X2PqKwGDn/8pHUAP4pvN/bm5LcvFjIOYg2TCvcEBDaDfEvoSUIknK4KbXwOKP5zfIztX4gL/BtD6IBJF+263l0BQQJKQON+InkcMYp0/Ey9/R0JicSog7bXPJBgII/qBMyoLOatFPlo65TPJmaLitlJFjOF7vVEWQOY9C2vRjwfH8YEDqqGuQkT0swWX3ECwiiinM21sYiKb3GQYG9sp9AI7cENZ163n5zg0kiMX1Ln5Q3ZArLrm7s1WeeBYI0Xj3Blf60fv+d9q3nW0MMGbPOPB8jHrkWyfbVyxYP6TtjA89peDspHi88L+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4457.apcprd06.prod.outlook.com (2603:1096:4:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 16 Jan
 2023 14:12:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 14:12:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix to show discard_unit mount opt
Date:   Mon, 16 Jan 2023 22:12:28 +0800
Message-Id: <20230116141228.43239-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: e91521c3-511b-46ee-227a-08daf7cbb84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKHzXoHRCM3Iz2M3rfg4t3Lu/4bm1/tXqK6MN/z0hKN/FA3ZjJz9Gus8qVsa5397XoQaBU7wHAryaXH2K8ixrZF3b7mwpkqPlUmW2yFxAADa6G2LLfH/5uiNgCrFi4+bLr4EeqaDMx2TMnoZk+Am72K9mT0/DMwljba2pKnmTqAKUH/KPcmnpibhYSyTwRJDsbE5+l9qA24k3bAFwLlLjT0wR/qrQgNPj8C7KaEx/4JjRlKtaHAp66lteO9AxlnRzW6e2cwNgxpxt1c5cCZtDsvLiuUOvVsOA1lB8+t5vaqoYUKCQQyBfGnG0gxiaO/o+nprKFBnfkaNIlXQ5JiYlFCL0bp2ZXPAqDXxXHQTJtjBCrPMkKWiP7bOD7S91oju4SBHgmdyI4PMM5d7+rF4jekfNx8sZVBfHLjSi0txQ9H5t1bvK0bX4ttcplAjDwX7rVreJpGjvZRaWxhRWpkUsG+1csBUZGuSVZSYahVvM9TRuMBhlKoK3UKKPzQLqGO5Owv3PEC008YsNiXaBN/qNi4q+OytnrjgjIIkR9sA+zKemkhj+se+04LY/c2EY/X8lMQE4NQLlK0vJso/pLmX3s6N2OWyEagZCT3kJeYaWq0dC/ifbkCjkmyLBBx+gW+g6NOc4NU6N7Ar+cCHxhunY5Am7A2HbC/87KosB6kaaPxoEhcr9PS9TIJ57uu+w+6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(2906002)(316002)(5660300002)(36756003)(86362001)(8936002)(66476007)(52116002)(38350700002)(4326008)(26005)(66946007)(38100700002)(66556008)(6506007)(83380400001)(41300700001)(8676002)(2616005)(6486002)(1076003)(6512007)(6666004)(107886003)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GbHQpTlKIi6i9ni7auhBn2cOk6tw5YmoftKJg6ac0ctGaZiPNaEJ5Y4FW3M7?=
 =?us-ascii?Q?EIaEduXH0Ga2EHS/8fbQZX7BNeJq9z/qx+v5KcERAx447hlVKOVKTtKyOd6J?=
 =?us-ascii?Q?5YdjZALA4M47x0Ab2QSTY6u6mG2kiHD+CZty25hyw80krFf0+CRQhz2+YyfB?=
 =?us-ascii?Q?sl1ULPsZkHp1H659UXpdplRMc9lesVDIOI7mB4FqcRDPf8aYYxOedkp0PcVn?=
 =?us-ascii?Q?lQLGO1FhvHpUENBC5LJMPbk31Heb0VkmW/VOY0gNNV0KmuSoj/ypWBLa1XCl?=
 =?us-ascii?Q?0fV3/o0rJy4immTRibCHSVEzyHwLEE+GFaqYLZFKArewkfWdzR2FApcxVFdv?=
 =?us-ascii?Q?zPqOrJh47oCfkxnMSlH/6y/pHfjVez+aylKtVDxbS80MwHkC2gZNyI+9SeHc?=
 =?us-ascii?Q?nLq2JLQc88aTaFq41NUXZ1+b9zWtbNgYs/yFnSt5+6tXP0XgQt1ToctddPHG?=
 =?us-ascii?Q?ooovPgZmVswegLoCs8MNNrEg0NQgGNJirwy4TzQHGs/KXbrfklUxilmG+R4n?=
 =?us-ascii?Q?IDFxr0Xts+6lpLZr/xRA/fun4Qzi2uAAWXKJe5PZjrAFBX275lexEUbkHIo0?=
 =?us-ascii?Q?3r1/ZN06yWCmFJZk1u7I4HfAigJPPSXHFVG2L6hA4udRZXuRyMWWKM+o9W8U?=
 =?us-ascii?Q?RHqiWgKtQn0dhOONpbOlZErwD5vBu75rgj3Q23cJEL8TR4aWtRW6c2rhDZbA?=
 =?us-ascii?Q?B3RGuhHVPY5W9zIodRXRxzsDtWJruAWWyRI4Tv0hdP9Z4fSNuo9jeUEHdQqg?=
 =?us-ascii?Q?LCECZMdAdSpzcFDLIIfTs8CGUPbFeL539Kori69lf3tAK9htpXLMwaeQIIi9?=
 =?us-ascii?Q?o9Zox7XZXMTWsTpOW2CEKnFBagdkIk8nzr+GTdRjnsfkrLAn9skLjQvavaW5?=
 =?us-ascii?Q?ERXQvlgxMmmTHpG1o7b9HYZuluQqH7GywhswfUO0anYbjw6eWBM1irQXZ5Fu?=
 =?us-ascii?Q?3asL554GNy5xP7vXNEHO0fi8oq1s21Ilcz6aSt4J/WKXY9aAObS05+olktmb?=
 =?us-ascii?Q?meZYxoNWm513e11WfQBxWrR3JVoj4sRt9xw3qAbhWpET6xSFLvgCEzuPxSvp?=
 =?us-ascii?Q?Xw5xskxWHiqIyajfToR3bv9u1A3lFfgqJNxgIwGcNG9XyX5UXOJCOolR2ELY?=
 =?us-ascii?Q?kFTBWHa8lf1WJAP0Z3lG63S9wfgjXxW5zBw0nSeKNPksI6540ld5giDuMgUr?=
 =?us-ascii?Q?LqcSA0DEuCgGYLkAoikI6LWsl9Vp/x/Ktid+fNH7LckpQCfLoL7Hk3TwuZDF?=
 =?us-ascii?Q?LcrokbuOjfb9vfOFSVGJ/6WT3w9c5dzguYVImNN8EPAvvgIShJriXaBS4nx2?=
 =?us-ascii?Q?9C/I/x+ar0ywDY2m7Xz/tUSJ16WdasqfVpGYazx2UoiOEBs/vR+7lzR7C90n?=
 =?us-ascii?Q?I50yvPTK0W6+NYjhPc+UpXwNgtPe9XzLIDfcsxEstJehviEJ1dQMTR4+rLim?=
 =?us-ascii?Q?slLTwXYuPtNQBqaAF8C4LyCkpdw+MJwnyhc8a516qEWY20v3Xc7QTxXRN5rI?=
 =?us-ascii?Q?ccTRochS2RnbSCYu0jrrxDKuDTjEPPzbDw0m55XHX8hs6MGHRo+VMTWW9Hak?=
 =?us-ascii?Q?g+Ds1xya3dQPh6U9XUZJYabh9oZ+dIzWYx0ngba7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91521c3-511b-46ee-227a-08daf7cbb84b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 14:12:36.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW7MZFBHjYMG8Yg49zSsEso2ixOgfmcqY7oF/+YBUqnF5V63I5WzKpJ7OBvSZ+7GhC3YOPwyaIiDo5uY4ArxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to show discard_unit only when has DISCARD opt.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5fc83771042d..ab8a77ffc1f4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1908,10 +1908,17 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_roll_forward");
 	if (test_opt(sbi, NORECOVERY))
 		seq_puts(seq, ",norecovery");
-	if (test_opt(sbi, DISCARD))
+	if (test_opt(sbi, DISCARD)) {
 		seq_puts(seq, ",discard");
-	else
+		if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
+			seq_printf(seq, ",discard_unit=%s", "block");
+		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+			seq_printf(seq, ",discard_unit=%s", "segment");
+		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
+			seq_printf(seq, ",discard_unit=%s", "section");
+	} else {
 		seq_puts(seq, ",nodiscard");
+	}
 	if (test_opt(sbi, NOHEAP))
 		seq_puts(seq, ",no_heap");
 	else
@@ -2035,13 +2042,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, ATGC))
 		seq_puts(seq, ",atgc");
 
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
-		seq_printf(seq, ",discard_unit=%s", "block");
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
-		seq_printf(seq, ",discard_unit=%s", "segment");
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		seq_printf(seq, ",discard_unit=%s", "section");
-
 	if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_NORMAL)
 		seq_printf(seq, ",memory=%s", "normal");
 	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
-- 
2.25.1

