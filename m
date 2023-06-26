Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C973DFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFZMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFZMzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:55:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEED8;
        Mon, 26 Jun 2023 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB9fqNt4pKjdod/QkBU52fP23hob6o3qSXt5kU1FjvpT0ZgCP2tHkz6uOziRrrmo6iSO0YRuZpKEBPM5oyDPGErzHL2qrj1Kvooymqc7yvK2UKv095IJTg/C1Yiaaq/+11CpusjD9J1/CgcewILdeZs5j5TDuswBJRCI+jE72YrMNnJJM4WeZSE0Hm6fQa/IB+56uUmt69pjz+8nRjtUCkvOKAO7Vn1gBtZygSk4SW8UilXXJfq24KDmQ1eBPXJrwFbtU3ehGLgk8yASs+uYnq+4eWNxPJR5DeahnzFMX+oL3pVK2VcJktVIoI7ClJ3Rd3eqiAme+TaiFNIkvkueiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lqpjmZVffUlgEPT3QBsipRTfKSLabUIdo+4UJjAbeQ=;
 b=FiNJzD2atRPaeCP+6Vbtc5t1Q+B4xE/dIRw+gP3h+mnkyUcWpkHgWJ+Y1JiUxl2mKU1ub8M+s1o5oHAG7noOM694fRWv97ioReBrA6SafHCiAw9avM7EvNSqmU/6vghG8L0L+OdTmk/+Hjcbu1rLOPGhc2qSsVyz6zA90fo4HPlPtdyXjHHcorT+GUApDcioPXVQwVrLY/KqpqJweGYk8LKShkY8lMdyFvXN8RocCMQwDJ/pgm/1UYavNkds084Cmac6iesPHLCRpC2ToA+s0h5AfBsASJx1y+PYDPWgpQjDHn0fJvtUMv/u9sBKoLCHzaeZ/7v1WiB8HN6Q+gn8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lqpjmZVffUlgEPT3QBsipRTfKSLabUIdo+4UJjAbeQ=;
 b=hrql88WEuFLqz9zLwt9fiYCGhFGMcv/+bmnrDYVg9C2yDK4nLdkvitXeCNG4NIm03zK0gBN9C322wjX2szgNFlPGrkHaTlQvtBZQhl/rm6FtnoKKzWqIWA7VErI/qj0W2X8Lc2uZYLaNToEqQgUqiXmOhBxM4gwyaeuEPhSwkAvux1g6wWb52riErS8pXSA8AEW8TDocu8Nzn/1UMlda8uuJfl0G/2cNzhg3e3DO6lvon6bwhzv195NCkqxqgMieiq5LOhMqxl413d+/R0i7MJu4BJWRmv/jg1s5Er2xpKa9dT4GCeFXpM5QfMRQQ0GjZqVoGr/3i5h3m6ZiC5ODsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB3956.apcprd06.prod.outlook.com (2603:1096:820:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:55:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:55:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/sun8i: remove unneeded comments
Date:   Mon, 26 Jun 2023 20:55:15 +0800
Message-Id: <20230626125515.18830-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB3956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdec005-ff72-404a-6969-08db76449da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8vGPndBsRGTpe24cFTkwSU4G8FigPp0vF7fig5LDzEdAnCKKwvmbVEvb6CgSuV3PfB/dpWU1AczNXkhbRLzKTaluMopO1H+OibSzBopky7FcPQjeccVHw3Wg4GqqiAcDTjt6hsVV951QBdrx4/E3RDdSY/NkmA0x1CQjv8o/UsJHwK28yO9lc6lkb/x1hmmQl6+QDDsQPvb3NHsul6XyK84+Wes2TXeurT+1KXuQyZc7gpaERv5ChUdiWY08varxNqgGizn19ql13Dp0VDmuZXETYdczNujOuTmUaJE62zCD5qZ5nESfvMBKtUIm8DjLka0MLqLk8alp4ojxSimhJ2cAjSZx1ZKjVD9J5W1Vulkm0XwHT4NlkuwyRbYDReCAFyB7Er6ZgHhrcS5X4vJVjmWDUyv/1Oam3YA+V7RZhrbo9c+sfmMle5NLKLWBMY+xcxHAEpPxos4AoRZeiEXzpI682DAqPfKRZ72zlxKhy/lsq32mfZVEABnIw3DESeEdtkoh4wMNgeWVGZxoGNJaU0APJ9jDXxHL6WseRzXHgSbkYwftY72Ep2nShNFDF66DUE0uX9+3cpTBjGQk7shhgr2/+6TayrU+VTXPg31vrmGYp9xp4tNVw8D0Umbxmzz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(478600001)(6666004)(6486002)(52116002)(2616005)(110136005)(83380400001)(26005)(186003)(1076003)(6506007)(2906002)(4744005)(5660300002)(7416002)(36756003)(38350700002)(38100700002)(4326008)(66946007)(316002)(66556008)(8936002)(8676002)(41300700001)(86362001)(66476007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3mN1rPSTeDuCSNAP+yQQ6YPp4epUe/kyY6sqZXRB0386o8d5lA31EuX1FYe?=
 =?us-ascii?Q?lyEeqHTd3aKCfSOKV8qSHe0teeWLzZkol1E6kMQ8g2sg5Ps5CE/ylB77nYEd?=
 =?us-ascii?Q?wEGTLjTobeoyi3TFwlaQFvC41IVf+TS+fZe+SZtAYQost85njvorEcmqViqP?=
 =?us-ascii?Q?UIb/QuJeuYuEREjk/ZFzTi8+oQrSKH0WYd54Hm3Y7gS2nGks0XlQ5YGIu+jR?=
 =?us-ascii?Q?rgwKhHjLpGLGel/UcZg2Q9vUbrt91VFCqUEwiWdM/0BjemorZP3D/r3L+UXp?=
 =?us-ascii?Q?+YgEP5b5HHEsaJhlemCvhcuKgjpw5V8oU/gwhSRcHiCPQFWxLAIRrQTpE3BB?=
 =?us-ascii?Q?0w6/bLby51rbaHNzj7mh6t0RSZ3GenrYoCouh5sD4mNjDprO3gb2TqdHIjeO?=
 =?us-ascii?Q?M0kirrtiqQdc+BzWrCmYSjBpxMHLAxCJ3DsSFhTV+97VBBBpA5ZKJ+FEw47h?=
 =?us-ascii?Q?UWN95cGHpPX2oPrGHAwurw2p+XDhjQYk4FnCQm9Iw7xUh9PMmMajW4EzaCPX?=
 =?us-ascii?Q?/+xju6VFwN6RIqxMTHGjEwP3j7h7WWgSYUY2dXs79HTc7Epe6vtcqJRGivHH?=
 =?us-ascii?Q?uMZX9RZ9vjY0boAwg0p27/RMDcwzDkGUWUly/SSLvXD2c++8M/a0YZDS8dIF?=
 =?us-ascii?Q?s3kewhfgDX4YX6R3Ya0Ofns3AAle8oBEBToULNHAkOYhO5yufX0/y9YA34h3?=
 =?us-ascii?Q?Awk14EpO8b0ZVPNz4T/1xDhHclOJMKZEQdbXD9Ogy68rw5YbMJu97Olh+SRB?=
 =?us-ascii?Q?NvufspJ8Gn1snhH1QNwSf6+byan1cKTEWKeU1Ol1TZN7qWr8NljpM4xOzHg+?=
 =?us-ascii?Q?EqUcBDYfiAO2f8FHfzUMbBStGpNXigUgPFMiB5DM/pejS6IahptdTSZzrS+g?=
 =?us-ascii?Q?pAB2MkdfnCpMJTB3imaqHixN7Onz88qKFOIoIEQBWmEhCBr3OQEHlA1tq1pA?=
 =?us-ascii?Q?FyKk8eR6+sgw8Ua3OIvQpOPsQ2ym4fn94qSXGYfqGwBZtAj7fjrpWDk15ORs?=
 =?us-ascii?Q?csuFnMZwihFS+DRtFJHe7vc+xtAdTitIWphI2/ydQqG941tYFwlVXb9Pmk03?=
 =?us-ascii?Q?+ycHiniyuZQWpTtiM5ViVBSJEsDlTHi0OqmdC2JJwH7p4AeKg4yWdRc52LS+?=
 =?us-ascii?Q?txqTt8qXugQKCNBYs9GvxN71Y6+NIn+z6x+hktcFjMEQDTjAhkcO79RerQYa?=
 =?us-ascii?Q?w3tNaN9FSbfJUZ8i3Ly1uPX9Gw94NQ5EDGBLhtU76M5s2UHcIGlwFBrJdkbw?=
 =?us-ascii?Q?llZWOYyZzidiQdbB7ZiJxRJry8dCPIP+lCf0PCwtZhjfnW+taAv7ypSxbED7?=
 =?us-ascii?Q?8HzsmrE8OsJdNkRVUDfUb+etotCCBcIGIr0jurPK75Uw5gwRh2dCCIxQuzjp?=
 =?us-ascii?Q?BcLVLegu+t3jCa0lkiYIk2ioeGzsjGc0obmsUxM+q/FP44l3n4h7/gmmS4+t?=
 =?us-ascii?Q?SYc8bHwd2tYR7oHC0RHbK7mT+AhjTpod8iVNmDMYYzS2BjIDVTYFNwG4gqIH?=
 =?us-ascii?Q?rm3BEk1k28DsJ/vohwDGU+dbKebBk55SvI/SxNg/7rx6MfLzOiBSYF7BfiKF?=
 =?us-ascii?Q?AEHiqcULGdhgFfU1MUOvh/9/ZzK6NQYHzUgjIFOI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdec005-ff72-404a-6969-08db76449da2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:55:27.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxHaY4kGMKhyEL7n8uksUoYdjW0LbcPc6f/YAliPnWItvkSzTOIOz+M0aDZQrkw2lQyssRGXoMt3cZ5xDRyJUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's redundant, let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/sun8i_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..2c82bc744a24 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -56,8 +56,6 @@
 #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
 #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
 
-/* millidegree celsius */
-
 struct tsensor {
 	struct ths_device		*tmdev;
 	struct thermal_zone_device	*tzd;
-- 
2.39.0

