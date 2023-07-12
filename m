Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F9750887
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjGLMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGLMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:41:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1021718
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl08v44xbvl1XFpCDJyI3TiivYeF2okWfPiCYSNA8pIbt+UiLH4ri08JLDqFMbOaB9U0rSZjatBYkGJEiPfcztkLUzNTG2+vtFmn3o8XY+txM5EcXAZ7Vez8IYHxy+wPm71j0knf1OegE5hckH0A/Q9uznTgcApRkVyWqlbePmQxa/LYIcMn2W5sgx/t8CHEZIRL4nAPa8Lrrv5DQYIfl0BUZCwotBDM4MzbgoT2OEZzXF2MXkldNm9aNJNgRSs6IqVgAEhUiMePS2aC/AoZYAb0LfiyCmTNWw5ZLSKl1kAK9eUYHQaOB3jjJecdYs8Rxn9JHBGCFU+6Z85n5gmmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZDCloGUjNDPI3S37Q7QgmZb2HFB9bOqKxgOjgVLuwA=;
 b=TPIZ8mp2jxZDxpoXrAMm7y+mLhhTuyBH50DFw+VCHrEQoVATVJn5pGU2SXI5C01kSpOoYGz2RCy7gJLFE89M6O+7V6pAFv7NrmRJ25ZbvN3GZzxcI1HnY0Fu25LZSq8jQe095AoS2JGTiFy3vd3LyUb6OwcX974sxcNFFhZd1qIy8PcvcT8Gmffihiox0Hzw0A/Etfo3kGLGtxJOpP6QL1JOXKgI39kbdVjlCOoqKX0vpUpcVwcnoVEmgGp9HFl5L31SgmPwhRoD/CuHujnpBboBA2k1cxtF7hEvTj3X9c/YZMcLG/3vry1Wbw+ZjqmM/b7KOckchT8DGldozGK7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZDCloGUjNDPI3S37Q7QgmZb2HFB9bOqKxgOjgVLuwA=;
 b=kg1Zloq3/pSiXjFywwZcHex2T844LrPcRJC4mvVhcP7FmJjovIarH3tvmaKzupq0cMPSgitlErkS+FFS6v9c3z+WYmUZWyiiw087w4FojKY8UnvUIoWnVA5Ugrp64APiMSAHO7XPNPQdxrwWmXlJMj1Kvqfbksn/LcBlf9uXS/A7A7af7MRJQB2+rcJoU6Mv5tYZwaRRMItfkuRTxDqA0pO6JrVe5os4y8Z+BH5fwN66wGXWmX7NWg4RPgFDdrz28VAF+2th5/Da8Qygyb8JVEEdmC3Y14y/ATD9xDdl7nhEj8seqUaLu7Yk+MzF2VxmavZ/F7rQ4b1zHgTv7w7FdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB5347.apcprd06.prod.outlook.com (2603:1096:400:1f0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Wed, 12 Jul 2023 12:41:02 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:41:01 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Wang Ming <machel@vivo.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] ntb:Fix an NULL vs IS_ERR() bug for debugfs_create_dir() in tool_setup_dbgfs()
Date:   Wed, 12 Jul 2023 20:39:59 +0800
Message-Id: <20230712124035.7981-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:404:28::25) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: b01395bc-a8a5-4254-b519-08db82d53fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSjUkDRsRIu24Hm4iEViSPrywNcKUGDXumEqzlFphCArHX83wwsHtEy6RYFVFfb96D3SeMDyrKA2Hfezql0u3l3uq0WmnUZQ3n90RNTxMsu4ooGS5UXVv41Ri6MGLRciyRq2xEJ36LR08DmZWxHqUIoD84iL3bzujjvT+23C27duCyekOmbfJXRcyNa9ws+iYFLhtYvaqjV2TaBYzr4zXaLj3c/2dDoONjP+Z/wuPeW75qq5SJCjV0Ha4g/lcoNITJcaHlXdtHwGuUdXc6dMrQVZour+9v7cO4xAFd9UtKSd4ZpMOTvk660pOEC0GhY7nrprIgtFouDtNy79LDAqMTCqDucK1d0E0l6mt0OiLzl5OUzspe/qWVg4qcH6nwsfE6Fuwj5g0ZZGo7MjJQ9Uk1uS1skHIzvWjNIK6UHz6wse7lKsZU21n9NTWdnjvjJpKOhJ6lPug+CfaimyNUbIBC2uImSHcNkAN32czNBW0CQfj1c/h1XtrOi3ze6q7Ie6fOFpLM2OpfKh7e0yWwMUgWpexkRyLCV4FyHJ2SDePtsEqwzzofFv3qCBHWeSAdKdtjqHz4paIDx2/GgANUYgM+J/MzbqRn2j8aQIAMVq+SbDhFwTc96GkahK14x//6JD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(451199021)(6506007)(38350700002)(41300700001)(107886003)(1076003)(26005)(6512007)(83380400001)(2616005)(186003)(478600001)(110136005)(6486002)(52116002)(4326008)(66476007)(66946007)(38100700002)(316002)(66556008)(86362001)(8676002)(8936002)(5660300002)(4744005)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/J4FYjVNrqT783BiIfTfkanqPkODS//UYcMdk6G/fVpBjBmPBhVbazXpUKo8?=
 =?us-ascii?Q?xuIoXtyDEUINl7RCBnMYTKgcFVVkzb4/GASiKKqKi3vR8OtTO7HXI0iYkbd3?=
 =?us-ascii?Q?aXtq0e8kH7AdcoSY5GQg2Wy+iliAR07s1CjFL0OCNvwsk/FkB3DOuFKbIzGM?=
 =?us-ascii?Q?iVqt3AWL9e9cGl3aB7UINWGT8jRpMAmhP54dDVz7TI6yPOdlbaE1DylbyYFI?=
 =?us-ascii?Q?klhTJuaKgUiwmHLx+Uya8RKxl61D/RGWBB1z714aL6lESYZgmIHxYN2+KRib?=
 =?us-ascii?Q?U1S8OQHV80ympSA51lhX9YNLYfTWqnC+2JDXpwC00xhgDUaHlyBwVvbLlUgh?=
 =?us-ascii?Q?oImBUCx5BAxAN6Tc9F12fBwcMD5pjfQmkII80oCOSMmtacBj8nG6r6s7QKvl?=
 =?us-ascii?Q?tYZ+peGT01rRhK1aG8+/M8Ne1TcVKU/LEgBzF4UhWg0nFWw7uK5eJrcvHVkT?=
 =?us-ascii?Q?l0kWBhlX2d8w0/tRhyVsyVzofeiIkWkySj2am7UkXLYwgIf1sJ91arRPKRF6?=
 =?us-ascii?Q?QBGQ+qsCnu+DZk1AiLI4hxhm4bOrEF8sd+Du0ykt79oCVllDWp2N0PSI4kjG?=
 =?us-ascii?Q?sETqPe4TA9vM69B8bWcRzshuaCRO4ItMbhmwkaPP9QrVihOTUjzLdiciIh1P?=
 =?us-ascii?Q?/I6mV0Vc0nBapCDm0lNRpwxtgJIszZ4mK05CKLxBAU8WI5UPFuWrczSShvis?=
 =?us-ascii?Q?Mlcbro6exvuyBAehUFKus7+Pv882Xn/e2qzrDJJB5lB63BFttIiLG7++jywP?=
 =?us-ascii?Q?W1O4+vKfOVV8kWql5+iCiogHolPVr1VHeRodUr5t59lWwCG82cZh2OcaG5E6?=
 =?us-ascii?Q?DChOCsQYm2gRVT8s7DZVP8NcUlYVeQK7NZ02xWoZ19R4DwZE+m3+NZKBrIEF?=
 =?us-ascii?Q?ZgAwFdMpnfu8W2FVCIfF7SBjh/Cjs78L9BPsx+7J0neYpg/zzNFSxIZXviOx?=
 =?us-ascii?Q?0ct5Cp/YzOYTQEX3trw8c6u4gW8H36C8MFQ75aAAn9emz7MZGYMltC7EuQls?=
 =?us-ascii?Q?FqpeW18FQ4/6iqOu/QtrcIlboR9a91yNgKNr44/QAbvzSsYyN6Brsqk8nOGY?=
 =?us-ascii?Q?zNmYyKRM2Z4RM7ZAEackk+5LNlKOgzhOEaoZpyehMwInNQggOWWFSX56Q+bj?=
 =?us-ascii?Q?XQmc9FGJHwcrZKojLEgn3Odzx72uOUTCSVTK8CPCJjnpNdo8iilgI02uEiif?=
 =?us-ascii?Q?G8ere2CMsByRHFrpj1tfvQxGp1to1N0wq1Ve7yIr32C5Mc27E9LoMUQHJeNk?=
 =?us-ascii?Q?rBQty2hImiJ/60U96erc8CNn4Gc36Vxy349JxEtLQB1lO5jh4/KS2K6K6Tom?=
 =?us-ascii?Q?L8CxEc3OoDRyoyoYxmLT/o8zYA9Guln4EVdYrLhDOSpEn+ufmJ1pBG1utJ2o?=
 =?us-ascii?Q?fmBg0PkwixyfVTCMgnkdVTwhe6zNtpzUc0VvoJuT3WJ1RNEON0v5PtEjWHdX?=
 =?us-ascii?Q?EdcVjU0tfinkdPLjdube1edv2ZVYfhT6Mdq0vB8dRAxJx42tXGxW/YtZyGLc?=
 =?us-ascii?Q?ZpbSzXo3qYj1Rr7tlLiR6Ju42oHhMW+KRW59nE2leSftR81vkT3+/uTZDbJ9?=
 =?us-ascii?Q?xXCjC7eIPrR6G1fOLqE911p8PrvehWZT3wl2wqL0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01395bc-a8a5-4254-b519-08db82d53fd2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:41:01.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ykpuu/XJzb0nO8hdoP7Z9HqQr4aLCwU9OladpeCDh4dws0ysYeqSaHlL5gsxnW9POn2hFBRwyc7/oFrg2tIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5347
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
but the one in tool_setup_dbgfs() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/ntb/test/ntb_tool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index eeeb4b1c97d2..4fa69ea4331d 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1495,7 +1495,7 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
 
 	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
 					   tool_dbgfs_topdir);
-	if (!tc->dbgfs_dir)
+	if (IS_ERR(tc->dbgfs_dir))
 		return;
 
 	debugfs_create_file("port", 0600, tc->dbgfs_dir,
-- 
2.25.1

