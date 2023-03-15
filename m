Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742B6BA8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCOHZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCOHZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:25:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB75AB78;
        Wed, 15 Mar 2023 00:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYhKEvbzKVbrhh1groHvZx+FIYC2tN2ptn0z/vjRXy96aq1nKmplSCoFkVkkStjsA6ttXnyDvfw/fwN5z1rTlcjGcenCu17YrYc8UPFrdednsDo1sXIelzNLc4XoYsS+0jhZJTpx47UzL1V+5vuVDDL2SYeGQ/syTgCWDb0J8KGep8hI4boFD1VUlZtGm0Uu7DfK/KrWUk5iFjPEF3tThSPq2klZAx5R2zOtiiMlq70ZTwyY6/ivUEGkhjRa2g5gTTBgHgpY3uAKzTT0FXIJ0OV0Up48dStzCid0CXNvxRJzPNt8uy9mGIRE2YVCYzvXdSo+Wn/pWIXl4FpTLCaG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McDvTNd/R/QTJ5vu5RiMuOJCnz29Pa8rpwoEhPekHy8=;
 b=L2mM14yNMTloT9svsMRwKAcRoUKlUetqGC8sGTYRdh4D79S9z9urJUqRlSnqil83pu/W7Ky9BofrJcIwBP2BhuZGmCkhVQ0ZGdtXq2/fT6E9eDNc4S7CATJalqFpwRUk3WXIE+wXTq9Szg4ynf8HEuiC5XnTq9Z/AINNWH4NOfrV6ljJB3+vfx3k6C7TjRO5GSpOy/+a1MOWuxhvtuhQ6tqVl2JaEnYB/5Lnug4e6cD9CIueOaOyypBDCA3zeBjW+8xpDZXEfNo87puybv+ZdsgQbxlorHPIEdwHqiZZW3L3fLR9tf3CXy4CQsJ5hOMupfZ05lfWPvJtXPXEPcyY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McDvTNd/R/QTJ5vu5RiMuOJCnz29Pa8rpwoEhPekHy8=;
 b=nZLGwXcw7ulWNODzU64I4o1RpCg7GF6sEGluoQzOzUB6p0yzNvPZw99ELNHhOYKnXMAkj3RuOOGzrpL3wiTpKyfcBN2LmaZ8mfeh/U/Ouqz8eBc1iWGHu8cFTsxGCiB6WEDvWXESfBNn+wbFiSaQ1tx4pulrU+ktnLEeBXCUspM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 07:25:23 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 07:25:23 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for serdev framework
Date:   Wed, 15 Mar 2023 15:21:43 +0800
Message-Id: <20230315072143.7815-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: fe970875-cd82-413a-1eb4-08db2526707d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TzByJBy0fYNFgFAfJy6InFS++4Roaspk9uBUWpfpv3tRQcIEkwXaLxDnw3aLFisdGqh+HQFIoo/lWQFQD/Jxd5fNoGhnx8b/l9sqli0DTUP06zakHOh/wmdVLiI/1iQ/nMbMq595wS239qBqj5a9KBhzydyGCk4f3aSgJXiNt1keLByaYHgbKUsWwpTrwb6LCjx1nJPNF0uKJzRJ5M8JiUFPRdN40F5HkwIXvzhsBaGJeO7HIDfSQHsgu7xShKRtT0vrlcpvJN7faXLXq3nIj52ua4Dk5XLFXccD6qrQU3nZxJmfIMm0dlH/VVz9KC/IvS+aWVURvJBPYg2PJyFqkBLPJGZ8N7VUAIcSG7v+k1QQLvJxMez9TzoT0VJn4Nfg3af0Q20L+mnhU+LFNeiRR12JCB+uMZ4FoLOxcn+h/K2Vfx16WjkzL4vocLE7ASPESjYQRSEUzgXqQwssZYwaGws9yQQCIwuZT3EP+BY4cNHPHB2WubFVto1YyMqcnknQtki92wMu1MG6gw285bGosatP1POJ8V8X907+IUy6yYu0+uTCuTyRjpfANeMygAs/Hy0cjY0uOWk2x+re0k7uAwBEHYtoEjg4tg/N21C11VbrtMeq/11KeF0D/YAC88jM+88Mt7B7JVH55G5+8sOrZrvgg27ITvekKZy8i8RAMek+Um76OMAIRm/vlMZ+7W/pCvp0rTOqcN43HJfUU38og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(38350700002)(478600001)(83380400001)(44832011)(6666004)(8936002)(6486002)(66946007)(66476007)(8676002)(4326008)(38100700002)(2906002)(5660300002)(316002)(86362001)(52116002)(186003)(41300700001)(36756003)(2616005)(6512007)(1076003)(66556008)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4oRCuCFlnc5oDCVuInkEdm177PXFC+5wcz0CSZ+YFzGajSo9GTE9lng6F2f?=
 =?us-ascii?Q?2EnzKUlHOyJwg9Pv9xRMBdSOZ5SNDPOn0kWqy9FICP6JDDUEiLJ70H4MS5Gg?=
 =?us-ascii?Q?EisHqMS7cN6/1dPLZzMJVdMhX19r6HoYY9tiX8/7zesFjAlgpdW6xtSwY+sE?=
 =?us-ascii?Q?cxjuVrVtv669W5juyDoYxzWYcCQkSIaIgDXuaCSlS8pcbEHrGpyFhQf8ZRiu?=
 =?us-ascii?Q?B4zHfY/wPUNd6RYCrCYgMLhT+AXh7AyTMl6P4mXdvEN6ZmiZA92Ef9/A9yA7?=
 =?us-ascii?Q?XgN8GBAt1eiJGVhNPqajUqUgZG+rko0DrIdKkQp+BG4zHMa9splSpzWjwSEH?=
 =?us-ascii?Q?dSw179jQB0w915wSucjfZ+VK2QoZH/YgiCmHiK0DQIddGKHPNsMpeXeL1wC4?=
 =?us-ascii?Q?HF1bPZocKaTGvje/j86O+a9lvWnauuhMEsybLf7uPO8UeiZEvWbh1ZWipJe+?=
 =?us-ascii?Q?DhUBEWrPZNaQriggi2EolzloDVJta+R+ymuUv+bHSEBbWbcpcEnE33OJBsVc?=
 =?us-ascii?Q?PNaE6wfeA5VHvveNPBC6zGfoivleiNj55zWB4eJP7Zy8BxcBAZp9tyTyfiVc?=
 =?us-ascii?Q?+s1NxGSAcexQK2TY6xeQmnzhccib9P4/ShlDk9k7IDyUDBUyQJYYTLeuzmaY?=
 =?us-ascii?Q?JyLJzisxcOuKSJZOCpT3f2hQB0qTrbATgRlEREzPYGsGde0rVztbhpz2/YLY?=
 =?us-ascii?Q?4y9rr0H9Ycu4vOxlVBdCfPetGxxbPILW/++5KU02EqenaYD5YjAdIe8BjYZH?=
 =?us-ascii?Q?67+EsBYhBmzjwewB4zi8Vb5iIVsK5e7S6UHN0xPVV0HOWjRKWCWM19Y6UFwM?=
 =?us-ascii?Q?7UFMnvXo/0+XlYbTiyKQfkHOPuvRIhlS44j7jfz19M7Nt73BIYqHuk+7kvmd?=
 =?us-ascii?Q?xoyANuHMQhFrNNt1Nwe6sUTsy1IP0kH+7SvmrWaVIUOGH0geYvPlTxn+Z6BX?=
 =?us-ascii?Q?lFOVwSBDCWXa+NTtkCDoYedjCPGicIrYYIHgVIEWAjL1ujT4OP1vGkZZfAu+?=
 =?us-ascii?Q?AkmRJgsUOmg3WfXCHKXntQ4klezQnCpRAy4CY6QKDnbQusNnkVB1YqvZDXSk?=
 =?us-ascii?Q?mhLYLbARZ63RkpAh0Ja7pA/MwGhX8Z1HtxYpPSitfPEjpnPBTtoKSXlnAsnU?=
 =?us-ascii?Q?L0Y7/P+obdU4UZHwTQikkR7aPtQnUeBtogD0MjMj5kenTu5SIl0d0sdzHKdu?=
 =?us-ascii?Q?qvpOLehCDPhl2sXmWsDN2vBqNc0pztUXIQLCLHcAuJT5ly1cFjFZ9j4NEhE2?=
 =?us-ascii?Q?7S89h6uk5QT5UG632Vb1TKtx733EIdZVFYzyDfYmYUqYvo1SCICET4a0/+Kl?=
 =?us-ascii?Q?Jb2Q0iQ2Hp4ZvjWawQUs12Y0z+ws1UUMeRYdnvhayu6CfMW8JpbzYAe4eMpK?=
 =?us-ascii?Q?x4oHDuZiFCoBARUImKfxEjgvC4eaOAoLrRVaS5qOd4izyVUDfsKcDI1A1POi?=
 =?us-ascii?Q?k9skXulxKCn3titaMxhKXN1qkdeesqDyYkJGwEOufP0MYaWOff3oM3Woefw/?=
 =?us-ascii?Q?YDanuFZTOUtTPem3RvSv5++iQQJIJxtkvffkC3EEEEiXktvF/jgBFjvNXHUm?=
 =?us-ascii?Q?GwiPBmBbb8bBpo0FI9zfyme3406IZ7f5htZDGZgk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe970875-cd82-413a-1eb4-08db2526707d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 07:25:23.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZDmvIy+ocCeVLAHOin0dLEcCeFqUD2mERWabPzV6ez64RU9m3vwncOJLFj/bujQat0DQTMW0rw/CYi1fim3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttyport_open() calls tty_init_dev() to initialize a tty device, but
tty_get_device() cannot get the correct tty->dev for serdev tty in
alloc_tty_struct(), because serdev framework does not set tty_class, so
class_find_device_by_devt(tty_class, devt) may always return NULL.

For serdev framework, we need to assign the correct ctrl->dev to
tty->dev.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d367803e2044..bba37ab90215 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -112,6 +112,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
 	if (IS_ERR(tty))
 		return PTR_ERR(tty);
+	tty->dev = &ctrl->dev;
 	serport->tty = tty;
 
 	if (!tty->ops->open || !tty->ops->close) {
-- 
2.17.1

