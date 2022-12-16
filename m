Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22D64EF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLPQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLPQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:27:51 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2128.outbound.protection.outlook.com [40.107.7.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2681115A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni2xM6eCCk0+eVjtd/07h2HSQjN7jtGMdQi1fm6S8Pi2KQfne635tzO6bjFHwgVPQ0qJnZHras9NeMAJ58MXnEhdvwYWwXTSyLqhtWCn+YjYM4HiwVNptvH3updFZdKN2kY3u6rhaFMCQY1QXi/iRt5EV0OXEif6m3i1AmBE9+K4zK6VWdHYDsKIQ3oUjMY/wKiOqj2y3/S7ap5g7dmds70OXje/ctUJlIMwmOvTK8xJS5VE42jem46ZNPkSZtLkcA/WyLDLSB1lW0ty3MUHnC7YcGXkA8BJKhF1XBxdlB3N44zLQdOC9ZHAROt3HOQ3pv3IUsS/keQv0nsclsaCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7HKxaEpfxnYm/d+EE1iC96ukGVrWNKOi2No3unnNr8=;
 b=j2dr7/vnUk9MZ/dIjPTKK4HyjZ7xm3mZgMY+TQmEhAHQNVfdWtXxAqG8Tqrbg1VUf0quX4RMe5PNC7+wuP9StjAgYwwxD9AH5XH7ZJzzVTv4SiPWMjPHtLUFsQzXbiRhlaQpaDx9N4mF6zS3lz0NYfYeICVq5+1l1rWJRig+0ymWzDdYR1QWzZIVVmHyvjrXYWBPzhasJXXztgFZrcpnHg2NUiPPhuZjFH3o8guqRpxb3HqvQQIVmX5gPQRMsmZhVnqklDHslU/cwTcxMl20iDfxakuK0hyhbEu5dMig/HQgEA3skqn8F9QBC4GiySXIB7YZo4e0XEip8muJ/PeRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7HKxaEpfxnYm/d+EE1iC96ukGVrWNKOi2No3unnNr8=;
 b=pqE3NN8XpW2eiCPC7n0hXrH+Aw/7jR3J/bYDuPzUIKgJGn8LKLbqB3z3nEFQldUKM72iyPYiahyMWjg2Tp6oO5iMUdY3jtbluQIaATTs6SXhQ7TWGItr65F7geTNlqIuWThMmE5aGesO7R6xc138WGZ3VDZu5ifgDUJEprPYIig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS8P190MB1936.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:521::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.21; Fri, 16 Dec
 2022 16:27:46 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 16:27:45 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Aviram Dali <aviramd@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2] mtd: rawnand: marvell: add missing layouts
Date:   Fri, 16 Dec 2022 18:27:15 +0200
Message-Id: <20221216162715.3230766-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS8P190MB1936:EE_
X-MS-Office365-Filtering-Correlation-Id: b116f3a7-7cd9-4c6c-a31a-08dadf827675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNmPgRhCidS1gfkE3D8XZBHAwnDTeBGZxDdleRhSs36bJS/KjmwqM75yvDuW947wq+rUPYHfUoyFIKhR6cAqszXN6yfuZNe/3iXcQGZ9sRToIZbQXkJj31cWYBH6v0TsELn3diprw80i2KVJcA16nvZhRAS6Bq9FVEG9mk0LdP2zFNaQRWFMs2iTiqqoVuQXRb74VM5qpGNBwlGtBFvaIBWpOj9E/n5ju5zShWiNsyWx3qkb7YGf2SiLZrq04uOamm1QWIuMIkJ8gLgLlRE6zXYb1FVZ6C39fm9yQ9e4Fyfs/4drnwhVCt0D8sjNXlBhJ24KO7yWZfeJos7DzXaLkaTaQmsWwFWmX476BhW5XLfCNzYUuF+RO0GUVu1r/3yB56pFbixv6BdheFDQQOcRQVbdAPY1TdRvltt9KmMmUctUrXxXiAhbfkmwBLIDr2wm9v1sPOtk1/rwH+EuWIna+ufQWmr1qua5IgcDiUtel9AwJQgeYO6HooXm054lhfVlQSgeywysDCz+sLICdVCWQMVyPW7J5qhMs76Pe0j4Ux8M3LncXo751cbOL5bZyIytf7YLPDi0UUnVl7tZ4QS3Wktim0A8ZIpAbLAFIbw1IoZDn+GU3SVRdRrV7p3yoowu+EsPBIg4qs/Yj8irIU4VHzucnVIa4J2nzpfQEZQjzPwRQqSV1FFhoLFBjg9ie+0lu+qTHQ+my7/NgAKN08qp0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39830400003)(346002)(451199015)(186003)(36756003)(86362001)(110136005)(316002)(478600001)(54906003)(44832011)(6486002)(2906002)(66556008)(66946007)(66476007)(5660300002)(8676002)(8936002)(4326008)(41300700001)(38350700002)(38100700002)(6512007)(26005)(52116002)(107886003)(6666004)(6506007)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUbyG1VIfAvHeDvbtJBw1rMZK/Akf5o5UEhTEo3dNQS9ejFRyYz1fwGmgH3k?=
 =?us-ascii?Q?4JuwHrtQtY9ZBDqFbeRZ0+hmhA3obaYbzoJ3CPwD0izRPK487oaFxWEMbmjS?=
 =?us-ascii?Q?Xmk+VdBHpWutJ2codMZKkYTcbOfek7iQ07gCzIozk8ZpniIb5hvc8Uy1kHgD?=
 =?us-ascii?Q?YBECXu1wVoLYw61H2ia1VLRBE+GevvVIkTo47kYehqZiUUJbp1RZG3aBYU2Y?=
 =?us-ascii?Q?A1bOfaAf9gFnVxMm2xktsjfakJqiT7g6LsyLXU9FI7UHnh7UxtBeCu4HC21r?=
 =?us-ascii?Q?8cMgRRwliLqCdiRE/a2QZ9tgdvHo7CYviWLFLMD25bjvUsrrNyEdscXqfWsT?=
 =?us-ascii?Q?KY/mcM4Aqj7tmJUl7zrXwEa3Q6+/q8ynWiy4Z0pt50/jXjV9gqzWR8/or06Q?=
 =?us-ascii?Q?EQNHS/rpo8DIa5EljEXf32DwFR+6SdxPHu+2PVZroZ758hJaGm82yDI5Xk12?=
 =?us-ascii?Q?u2Nv3gaZ2louRokuNotIlVXSsmdPccnZy7QQ5SiSIyPKrZE8u6PFwt4yf4z+?=
 =?us-ascii?Q?CG21VJx4it904d1dzWr+g9zZlWLuWMCxypEP+ZQ6Zca8pa9Cjnl8K9JS2EIV?=
 =?us-ascii?Q?5Er9xo2FWeGkxe6/J4J+N+Y9d7WYpWzmXDGWZ2DSxLPrtDQRyUtmtTPpVvGD?=
 =?us-ascii?Q?DqArTva3x3n7EnLfGwLyfxqg1PyDNy/cgFi4fesbL9UjrpiO6kM9AIVBxp3L?=
 =?us-ascii?Q?Av2W6Ay2elAn22vZ4KmPvmSH95Yi5Wvygnj/OX3PdmBv+nkp2qUgzLlYSOu+?=
 =?us-ascii?Q?x9MTgZ/EnzCJvrDSSjaI+6IJtMaG7e5aQlc5CpmizVwCpsE5ZjLmGTfCqBu7?=
 =?us-ascii?Q?xtMsvv/b9dfp4jYsHRvTJtDhuE3RGb1S4P+V5y+e6vLq81uSplSEvNWa392x?=
 =?us-ascii?Q?+DvVH+hfrFR4GV5HwJ5FldMOrmSpNM7cE44gBYfoSfaudUnBpmAfBoav7evg?=
 =?us-ascii?Q?vVaSldI2XT7xJT5IkPSICnkIATGn/38BcUw3XZImzslHyX1PHbs82LxQCksv?=
 =?us-ascii?Q?ldROXBFSAoOWg7ezB74N9vQLWj//ouRVH6/RlUdwVgRHzn/zbRJ19nBaV+QW?=
 =?us-ascii?Q?FGHECugOi9SCZYdqRh5Km5494gqLczx8SytiRapkymqIpFkYWvV/uLYy04ki?=
 =?us-ascii?Q?YSaazfw4UuaiCmG7daqST2z+yXjGRl1ZfG0C0kgWWFCJyfLGhGzvHUdh1ahO?=
 =?us-ascii?Q?ix8ca9jG0agxu8EIG36GKl0jU3TA4xPhzBleJwreLRp0Pix1CBcbsnlYpqBO?=
 =?us-ascii?Q?UrLeCQC4M+8lUEiBn4LdjuLQxTEBXAwqhNh5uT3+tp1gGXS2CQYRIePQe6nG?=
 =?us-ascii?Q?juvZldvb+NmD4D+aR6LyeS1LR9ZJNo3tfo2JZ1eTVUFiadreUBScTMPNp9r5?=
 =?us-ascii?Q?SE3JyNcSTEFBzpG1e9zPd/TBkiRvwTIE7/YlaF0zWUJpqnaO9+V7Ks3uog+9?=
 =?us-ascii?Q?xMr4mFV9wnD9wn5tmV1KP5MTY4QYQ+WFCXkUdnfTYL4pU3XsrVkA9zP9wWFR?=
 =?us-ascii?Q?qCWqdLzrDxG8PV3hIhBPRiSlTMydE7a6COs/dnf+Nkquv7SlJqr1DnRGwrEQ?=
 =?us-ascii?Q?wemDMmjmmf4/83Dp6lRGgZHOEvCEzB3C8RuSL2E9jQQUTODD1iTt1V0pwm9U?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b116f3a7-7cd9-4c6c-a31a-08dadf827675
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 16:27:45.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1N5BooK5VGDEtBewCvuYcSFvpcSiP+/Xdmu49vkL/w/tFtPiXoWPhb30jIok+kUTqqN7kyHMOgYUcYqJAvC+zkJB6v1SR/tYlquPoUFuuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aviram Dali <aviramd@marvell.com>

A missing layouts were added to the driver to support NAND flashes
with ECC layouts of 12 or 16 with page sized of 2048, 4096 or 8192.

Usually theses are rare layouts, but in Marvell AC5 driver, the ECC
level is set according to the spare area, so we may use these layouts
more frequently.

Signed-off-by: Aviram Dali <aviramd@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   Altered array layout to make diff look with a real changes.

 drivers/mtd/nand/raw/marvell_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 42c64dcea767..3034916d2e25 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -288,10 +288,17 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
+	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
+	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
-- 
2.25.1

