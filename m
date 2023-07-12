Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF974FD50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGLCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:54:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98911E69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I57AjPowNobuMKm8Kxcfngw1SBzzcnDTMWWnu+EV97rvwSJzwluKfgcfy+2XNkYYzeWDj2TxeZQ7nzQaanvPyyvSjbbHFOqF2QksEq+SYl0Hk72QvCh5ESX7jN1ymmlr7I9WLtjnWYiMRmXVAToWOFTKwLb76iWkcSmrIJC521WxLro4zK0FHAlDQ1XONJZM3OvDHwVoKE6gHWiKseWI9tM2fSE4LZyczSL7m4f2arJrhDCDzUPJZwu74sqcDrGrANWUlF/QYHQKlfCJeUNnQm9YNF7uNcFrn0bcOAvmQjajO1/yV3ghJ725CNz+DQYH8ZA1sdFlPLCsrASSx5J7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSJKffiU7AbJEa+zl8Mdi57IBmF1H96Og2EV7GT9KUI=;
 b=FT562WzLrbjhwhHVQ+7nIUJHBpuxAmdVsrt6E24qoQssULhhsMrbBX1gktAjAB4EG+kzUmizgzTRazNIw3yxNVYSEjOy59eGPBuL8NrkXFGzdx3wstXrEiyXRUpHiWZz8d+a0JGhrgK0GfvT19aHkS93nmwewY6K8nO/QKDg7/cGwytluAHE65dI+1wCaX9VQm7HePfnbI4hcc9EurfpzemjzJ2mG4GQZ0ot2bGfEChqY7USlG93pHhgTncG6TwIu6XG16bPSsBe9IO6HQngSG+8ZB9HMidUteGEnP25oLUdFVY0Lzadfe/ZAWh7DRLBRHY+pfXQYeq6czai695bPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSJKffiU7AbJEa+zl8Mdi57IBmF1H96Og2EV7GT9KUI=;
 b=ab9yqN9UNccf75Aors7Yv2KM9Nf8sS4+jvzyDS+vhfA+s/UiO0AC6PVzqtkoK3D8Mt8LprW4XmmbtOt8Yd4jMxrwVNMlYO24sTlO4wFMv66gdeN+5/18hT30dfCXGEDgSrSd8GAsLEo/60FlO7yz8tF5MrPFOk8G9tpERb54mUIoFn8mpIEhNV6ausCh+L8ReQe05aKcgq1I37GMSj71ICLTBQ2jOxgxnB0+IJlyC6te8XK3gnh5GlMYrzCG+L4IhY+uCAXYIrOiqK56WI9kgQmeRt1Mj//T/nkgy+BrWoMpTReY04/jPzc6B3rokHjRtldUSD17EeCVl1jfCB9LGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB4094.apcprd06.prod.outlook.com (2603:1096:400:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 02:54:04 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 02:54:04 +0000
From:   Wang Ming <machel@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] powerpc:platforms:Fix an NULL vs IS_ERR() bug for debugfs_create_dir()
Date:   Wed, 12 Jul 2023 10:52:35 +0800
Message-Id: <20230712025250.6512-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 956633eb-2767-4ae2-3828-08db828340d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFSrjLXnnflVzj6EV6BXCIolydqyiJf3cf2VcjRjkm270QDLb9uqDOc/d3Pajy0vsMz1MlJEIb1AGR59SX3T0NUuD3rpENvfWjiPBmDO442ujSQ7yxHXfTFHfk7wjn6SYTmZ5sUVAd6OFHQLw3eRA+c8ZZKPMRfY/RTwRvoaqdbUzQ2ZkN0mHyO79FcFBZ1ooGfqIrl4i3LOXBq9Bh0ufU2OTOpWj6SUymKVx8stG07tEV6yxvlKDlhjI40/xhjvKqho+yfyncLVStT++5I2wNNxLHxGqHCByC+VBFuB38Pg9bqWPF7mzYS6506Lmowl1reW01NN2BEkk9P9X0iAR57hcSVW66rohHMK8zS5JzIH92EdTUot+MjX1ocYiHlAmE1YgvC2QpztQhoTPjH90ym5E35hGJxHBrucZ0Tz4pPgIAQStEFYdbOD/LzvAbCx1WCaQlziwGM9VDQRh8UsOSYKazVw24A/CPG3Veolmk+hQLpcB2M7h9ujudPTaBHW0QRREbIHHp1ryNxeUqX5a+1c6ChGKBgLDqVGzvXOg8LKag7Csp2FKZsfyHCZTsADU7O1wUJQ8VOH2uj2tSP0NnzjHLUMQjhvJ8vZ8mUUE5So8kVj4OfZlSM5lt2oPy22
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(451199021)(478600001)(6666004)(52116002)(6486002)(83380400001)(86362001)(6512007)(107886003)(66946007)(66556008)(66476007)(4326008)(6506007)(26005)(1076003)(186003)(38350700002)(38100700002)(110136005)(2616005)(5660300002)(316002)(8676002)(8936002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANI+PgFdbZefOKuCy4XJX5LeEeoUF/NUDtJEGOwBHmoosHr/tuThR92cbG3m?=
 =?us-ascii?Q?siil41ltTCM+SnzSnvkw0bJmSTrJn18wW62yuaHNJOkcFGtDuJiQ0e+OJ7W+?=
 =?us-ascii?Q?0/NZbVHTNZ1edlClsCD7KUhASkuZQ10lXUX1x4jqSMzJkqQH7HRRqx9r8Ka3?=
 =?us-ascii?Q?eGy5HJKG5rAudNGQsnDX53kbO2YVvRQTqU5yZ5zG01Uq9rjCHSb5P2jhdzjG?=
 =?us-ascii?Q?ixkdPQyzAPY27v9tNobrtUI+C9Z7n5rFQdifxZ4NYzXjUAqOxGaUOrKh+NUI?=
 =?us-ascii?Q?mR0AdGPZBV9WVVJItGcLJ8HV/cCTDhk/11rSWrFDccm2D/FTl0cqQZIuyCov?=
 =?us-ascii?Q?WGAvuW92N9GGSilySoNOGaXWD2gZ/Ewso9MhNE6czNVgLI6Veb/et2NoquC0?=
 =?us-ascii?Q?uUctKM8AUab6aJ7iqNLyTd+twWqZDiSQf6FXnwK2hEV2LabPZbST+GAqp9wF?=
 =?us-ascii?Q?gbw9yT+fBxqrnfsA2lkMBtqz2tkgxcvdl0PIpO/DkyE3TyUV5bnsXtPkCGwx?=
 =?us-ascii?Q?Hej3I5HO9RzwCbRWZMUpAQmXnkaNzz4z0++1QMpHgGS//23SyHEmK1R553k/?=
 =?us-ascii?Q?5lf8GETbG8HomRe7hfl/y/IQlaX/9Hn7xMAFMTJCP5w491HU4536NtWIVpA1?=
 =?us-ascii?Q?H01iu7e5NfKO8Mrvi41X6sxmPBBbcooVEeridBs85g0JbfJZfz5sKx2aYejX?=
 =?us-ascii?Q?5VZxb2+kyVwoBcsdDU3wedg3g6QEktTj4TmqQRMtUUKzzi7v8/whQwxN0yj5?=
 =?us-ascii?Q?nFmWVW0SVLH1gSgtuoy8lOBjOLFoxBovXwgMrJE0WVWBSTX01IS+WBcMAbSN?=
 =?us-ascii?Q?ah8O+T8F91JEGP3E+UKsmnLh1DgYP9E6XG65LIliDMjb9snbcura09uPxz7C?=
 =?us-ascii?Q?Srg5HuyG3y8eEItdpaPQhr48QVkH/M1M4e3iq5l1N7XuCkufgQA9JdK+jLeA?=
 =?us-ascii?Q?cUhkzJeYtRhSDQqvVN6JnUBk3cXslP4twH3UZyd24s+ICQ2+saqyMB2bT+y+?=
 =?us-ascii?Q?b4lzYN/0Z3dhzJrJmEtOIioZVCeflESKmY4J372tFlijQgq0MMOicjmmFGCI?=
 =?us-ascii?Q?JGsCPvXEnMuf1Fo/8IERZ96fLEO/qBLkRrNJSIjLo2J5gy1xGxFj53D1//rs?=
 =?us-ascii?Q?CG41RBEqdWrEJyORZ5cFAy+6Cz3Ha3TpMI+f36y5k5MFsj/cJVwZNDWhZl/7?=
 =?us-ascii?Q?5KmiOLiqxXsXFy9cFwRPdGXPDGKR70weGUIhPDA3Z/NMpRVT3bWS6rdNhJ6m?=
 =?us-ascii?Q?Q+m2fSS1cUDC6UoXYrLp0+q/AJpelFbBu6ALYbFAn+Cnj2hc25/mmubTPuVA?=
 =?us-ascii?Q?Sbq/6e9xq3wC8rVHrvtMH6eqqFqHq+0A9laIfmXzb+ctvuumvhU+QEgUc3+F?=
 =?us-ascii?Q?NakrSwXoKtMMNL/PNd58NNq4FrYrUR/MfA8IYmMP3owJDrOJoV9RCZFC4mzo?=
 =?us-ascii?Q?ORwvr6zU5uXBjHb1/BUVOCLMWRmG1aGfq66KJxqLBj0L3ccaZ/nwFDfqBrbP?=
 =?us-ascii?Q?xzbVuhvK3ISqi4rkCQCPnYkt6cSdCA7Q75qJ0qYHrbEsd3u+vUT+YY8KFay6?=
 =?us-ascii?Q?JC6E6CbHBMR2xikyFV4O527scoxSTcxdyfBKBtIS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956633eb-2767-4ae2-3828-08db828340d9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 02:54:04.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJzzC2fkUsddyOxT67RoZY+0WeP2poOfHrXcIyTNLO97MKJ5yrfjqifNERaBwhVqPJ7EV2CS9S0ub40p42IPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers.
It never returns NULL. Most incorrect error checks were fixed,
but the one in scom_debug_init() was forgotten, the other one in
scom_debug_init_one() was also forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: bfd2f0d49aef ("powerpc/powernv: Get rid of old scom_controller abstraction")
---
 arch/powerpc/platforms/powernv/opal-xscom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 6b4eed2ef4fa..262cd6fac907 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -168,7 +168,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 	ent->path.size = strlen((char *)ent->path.data);
 
 	dir = debugfs_create_dir(ent->name, root);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		kfree(ent->path.data);
 		kfree(ent);
 		return -1;
@@ -190,7 +190,7 @@ static int scom_debug_init(void)
 		return 0;
 
 	root = debugfs_create_dir("scom", arch_debugfs_dir);
-	if (!root)
+	if (IS_ERR(root))
 		return -1;
 
 	rc = 0;
-- 
2.25.1

