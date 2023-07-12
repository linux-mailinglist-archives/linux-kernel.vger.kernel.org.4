Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D256B75088B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGLMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGLMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:43:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A09170E;
        Wed, 12 Jul 2023 05:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG8sYAr0tH+TDVcOCwGZaoLHMRRM/ALCzqoY4tYmmBzpg5jnCXhr9J4du8Xt/nJvWvTnKxhgaNmsStuv0IdqBpNb7fFHUg5ZzPv3slFcMdN8gnJc8VLA8dIwj8qytyLNnR7ZD0jtAngXwbLxjSlBY2gYCCuvMob7jHqzxydeyt1MA7DbQiD+TcaThKBUYIhah79WcFIg36LO/IcnT5bmnqFKilawzgC19Z6Tbaau0d2/s7bKzjVZcPadStwUP87h39vko0ZVwCbSfo+fQ2hvk1uD83jwAgY2OBNmY+l8lQeR1iTY3qeztq8jMcwadgs8EHU7khsNa/3NMCdLFR37Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EVOZKXMZxhfK9UpSac8+y7UzW/hCctbY1qEz2iOzRk=;
 b=Dmnvk7mQUdSUxkBN/Q7xrZ08CDc2FpJluQLdNzxH2asYVoMkJGOaQBff/RCbU5VZUml4xiMHEe+UQEwwARvs0Iyp7khQNEe8YS7TGdyXMUFwBIxDg+psWrhvDY4+Zo+IhC2+vzl7BbYxdRZqn8JDLqgEIybwtp4utdwftGKoHD9b1w6mW8TsTHorgFXizsWINsxn/CogCtsRzd9MemGtisClWaFWNnmYHdjaWwefTIXDlctqcbIUCxWBf+S5Xu8srDuHrCvL8k2cTQyHHCzb0nOs6/NZfzs45xDNogcDKOKYSjL1iT7mE9F6p6wXlQktspBS0D64XeApPsGXn3f/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EVOZKXMZxhfK9UpSac8+y7UzW/hCctbY1qEz2iOzRk=;
 b=djWXzpidAojFSqjaHyPFKQK/nQjn/G/3ryA/Qp4Xmr3XNIVsruQWgkmyDxiyTrI/G+qjhgZ5p2AGq8/wmlR9sA/VnNWZah9WTMo5yHtOQcfOzxCWPyeaeL7IxJ7gVRWFKp0SRR64Z++bi+8QdEuL+wE+mJJY5x6Cg3LgkSBDc8vGTs9cf2dE07okJU0/MBV7tZChHoL1QeluitgGPrdfdx/bI9Xlxxmkd9Vdp4TdVLntI1GpAxXifeUMpaHgZ1q+pp5uWvFXVtnRcdkKkGPk6WTHYZ+ntp7veW02RIwPHf/m0BfbBqsEcDTZTmYJcBtn1PpLSruUYpMuLPHHj0H4DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB6359.apcprd06.prod.outlook.com (2603:1096:101:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:43:09 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:43:09 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: wireless: ath5k: fix parameter check in ath5k_debug_init_device
Date:   Wed, 12 Jul 2023 20:42:59 +0800
Message-Id: <20230712124259.15096-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::6) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aa9fb8-3257-44fe-a19a-08db82d58c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TKKS/O9lmo/dWlDs0VNWGTlbmaERW2utaZSDRkIRgImW6wf6WvZmov6I0fEt5c+dhX+cqIMiD3PIjKUYsRBKksABSl/Ni3scRD11JT8NyzMgLVz11Ge4gJ5110yLmCILtNzTMeXzkeE0XxFhuYeQyLD0R+xQxWa4Szl6Jjejy0SLj4FDKG2DSO9aarGBVCPsqIWB+d1Hr7bm/fZ7cFlKhq/I+thANDRqc5qUtEaMplimpIQks3nYylddoZayhTvBJjhSGg+vZlAx1WPYqWQgUOz83WoDK3HrIJzUoQEIIEiQot3dfMt/mUjxi52ddikt6/iGe8KLBPDBhQzXiIHEkzZlkZmEpnSXuWFZmYwXC6/YsC28uU7hxw+5rBj0cepyKv2hDet4SW0YmeJmVS+07Jzc06mXCf+03hFnYWblzoC4vT1PFpDol1SMOISOHm1NI4GDoMn0zZHsYWmVUBSuw3Fxrzuu4XndfT0u1zKvh16v3kZuH3cGqIHfjRUBPPcPr2pIUpwJWLOwJOo4TM5I/VBiRPKdb97XtB8z/P7ynXVXngAGxwBvFhV3W9OX6pD2yGqBnd8y6w/9X8osJoOKrgyiaiPo7fTgbhKP1sIXxEgmo13HiSzBhRj/yde4z/06h1FAzbArA8mpQw2DFMU+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(6512007)(52116002)(6666004)(26005)(6506007)(1076003)(186003)(83380400001)(36756003)(2616005)(86362001)(38350700002)(38100700002)(107886003)(5660300002)(8676002)(8936002)(4326008)(66556008)(66476007)(316002)(41300700001)(66946007)(2906002)(4744005)(478600001)(110136005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSuGf+HYb0GXl2a5e1XIdg1Je7orM5qh4QGU0r/Zuv4DdR+xJNPKyCwFMhCv?=
 =?us-ascii?Q?A9O3dmzbU01Jl7BOcXNg1ZSf0FcPK6p479bFCQOwAhW+0zYHDUMdbLkwtKqt?=
 =?us-ascii?Q?bWAWpyXJjfC1wi3qYEKMbpmA0SG95zvi7ElvFmmTvURcRagSwk6BZ54+3L5H?=
 =?us-ascii?Q?d4XpTXzbIPZi6hEHq14rqGWq+pLSvViXvQzwqnmd/bFIyY24Th8b04EmEckS?=
 =?us-ascii?Q?jmkL/H/PpytG5zoKbDdtElK1fzWBcHKVKXTDe3SxoJkQSVkB/2Dn1XVwtbvq?=
 =?us-ascii?Q?yB5EXiLbYzeCS7QIM17InRz0TqHQuCGCLWr8ghiI+CoIjkiDaEBwvjzmZs69?=
 =?us-ascii?Q?CkGbTxhRkXMBibfUlTMNeSOBbhoXyTsaazG7Tp4OAJLxHPtR0D4GHaVHV3Kq?=
 =?us-ascii?Q?3aNnS01hLjUhD96cCfvQictpUH3cR5DAtBmHlwXML2ZRJEHuobAsINlOy3Jw?=
 =?us-ascii?Q?Hf0SNaLCbyDmEooBISFPbP0YXY70Y/RRMwbDJxPL51jZN/R5PDdZoVXrPj0m?=
 =?us-ascii?Q?z5liM/lNtjK5E/KzKu+8wNWe7V02e1qoGHb5TdMhSM4QSiV9Sur9ocpwUQT8?=
 =?us-ascii?Q?2ktENlbokQWqPqi8O9WKuKYv74CeH3a17k4zgAk5OVG0aaQwe6ga0Kg50HFP?=
 =?us-ascii?Q?Z567AUIZdenxdbDSKcQ/VUepodLmSi7ZQy9okGguqvz4Pz2OhEQy3jA9vshx?=
 =?us-ascii?Q?7L3JxNUHf8cn/HwNDwcS7Zute/Gs/gOGV07kEE3QbGOzmEKDSlSOPX498Esg?=
 =?us-ascii?Q?v+X7ENA2m26iAgOldWIG2QChsFjXq+D9JwId4s4EZYtSQ2Ac0vSRDPNr/vXw?=
 =?us-ascii?Q?1V1NPTEA10J66cX8XJee9znzSoTpHlUEKeMGfSAY3G6Y+3lBIKrv9xqwLuag?=
 =?us-ascii?Q?y+LjC9NNJLdfn5CBn5t6EeP7aOqAn7WQXOaknFWf3GKQVFGQKicf99k+vHl0?=
 =?us-ascii?Q?FwZwSR/Dm6q4FSfWP+PJTFtG2h9r4ADmrcEQRgeScimkPSknIEp7T5HJ4b7J?=
 =?us-ascii?Q?wmRKvUmEDl6qQAvhYdpqYLYomBtrhcfbvImqqVnT1+6jAAEt1W5jSTRgiEIK?=
 =?us-ascii?Q?iMBHTUtpvW5th356YjR4Ibr+ypjpf/WeNj3PSuGCv2PdkqmhyCSBfIB5H9hh?=
 =?us-ascii?Q?CbZ3N2BYK/8RZn1GuoBdh8mbrSDIHo2W6N/UacuqzhzMudybD1GKIQfy5zw1?=
 =?us-ascii?Q?BjAi6ZM9s87d5bd250T4508AbJLj6ahj1TPPN4IU7EjyU3gk7/19s4BLgYPT?=
 =?us-ascii?Q?ZLUPFRoWGxHOT3LuR7cpZkVD9rKhFndxidT8OAbp7qvXfkgcZHpP6gB144QX?=
 =?us-ascii?Q?AL6G1uTB7qbPKNKiQSG0ewb26uciK3jWNhbjA0bcuAAP6jCpBf4tnZozQCLH?=
 =?us-ascii?Q?i0wYTl51GtCOIm8vnZgG0E7MP0LD7DkcOrnHo8ny8KHtaSx3f05i7NB7Jmkg?=
 =?us-ascii?Q?8NuCE3Wy5XJrUO47Xrx0fHIUFHR6RaWxONVziAVMjvpGNbFr4U8Tqh7ngGDC?=
 =?us-ascii?Q?BMz8ALBq7HDt5fvOT8MaWPWcO96fu9KMnq15WGrTQMw5E+AmdQVkUtFhWz0r?=
 =?us-ascii?Q?mW4ds+KAz1A9OIcGUoqWQHW//8q/FGr0avkHJeY4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aa9fb8-3257-44fe-a19a-08db82d58c29
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:43:09.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2a/Z5iL7PEOjn/HN7lJiROMc1aEjuuu7vQY7muEcGOViReeARA0LxpdI3ZMOsCse2o8sNwjK8eWYvlBPIVe+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in ath5k_debug_init_device().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5..08058b3f7 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
+	if (IS_ERR(phydir))
 		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
-- 
2.39.0

