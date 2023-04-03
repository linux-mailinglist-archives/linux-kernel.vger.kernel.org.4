Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113C6D4457
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjDCMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjDCMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:25:21 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6ED10274;
        Mon,  3 Apr 2023 05:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAewRp/zFlubBw7KW2bYTnZehUBTUmJlk8m3eat+NG3cVmv+B3YbZa3tvR/ckcZCmYy/H0udkfz9//9l4X14wR96bWxDHrraoMZkAqZpThS/Cwd077HAnoNrSMmVe/9/CluJJGEqbyTJREiwjgBRQlT5UAcWKlEip8m+ifPY0b7Z2gyjwWc04HVMs78KkvtDMA+3L6/BJuJydbUvde+g6snm6yHSAuvt//7XKX343HtTsefKIBtsuKFYDXhn51BtQtdfgFazVqfNACFy+lqgfk515DqUlYmPGBhGEK95N8os8YcMKHVGf63d+aSQ9foEE6MVJ+eL6QgjFPgsaxwiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTH9p/vbB0wsRTbvarI6e8LPlvUL5HBeb7lVOfwHiCQ=;
 b=V5s//vU0C/vKqaHyol25KQ5j3FBEex8QTXv2KwUJO8zqGG/BpAUI19aYCZM0Vqu823m8F3IoBrP+aWMKVhwYU70PxPx9K1f3OfJqFALKHQtlyJ3uCmvxtAl+V9yMO0AKgR44e/OwbuUiaKiTcLyFbbIodhdJmw4Zx/PEsRyecNeWGkyf5pIe1y1+PuClZ8vfVBMBQrX99S/07hDLreh+hyAh9nh71+PvXocbn1kDN9i+rwAf+t5xiQwB23Dht1hKBfT7qFAAm4IubwScTdBhgZbIJm2nLrmEZFXf0u4Wzode8Mv7Bm5cy9Qgb8fTph/nGC809l34mX1dOaXmR5lsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTH9p/vbB0wsRTbvarI6e8LPlvUL5HBeb7lVOfwHiCQ=;
 b=JJSbvkUzIEjYOCCXvB10EbsU0Dx95NiS8LP21g7wpWruwZVUhcr8bLLyl6J1cmBG/ZL2PoNIgftviKcMpP9GxXFwUeUzeIgF7mlF6BZp+8FGNjAVNi7QeLvHj8WSTz8MxfmwCWaSDsLHgv860AJcw7N5oLJ0uEyDzgBEcCwdjfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 12:25:17 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:25:17 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Deasset UART break before closing serdev device
Date:   Mon,  3 Apr 2023 17:54:28 +0530
Message-Id: <20230403122430.1024235-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: b62f2bcf-eca2-42df-a99e-08db343e7bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dCLW/ysPkTeJgGABvCsNDuVIpAgt1fablY3aZOliCJmrE3j6Hs5WJP/hATBZc0p+lvMXmt/tOZc9gvH6l+Pu16HMZ2+hG+WLHdIRloRIOGTp0ERRe+4Gf/c/G/I9SEkrHpeMwjOIh9ZZaK+bwx9AWs4trA0ylp4kLtE6dS2C3tm96fdfnTxJk1erTiWTZLu8UTnj0GKlHMH4lAK6AYqntpizH73Bwrw+3HjX0vJZT5tstCmugSb1u2l0Ev8MqUWa2ul1ibS0GgtwSKSjw0kRs5zto8OUDt6qDrnIESerDtKuRjIYAOqwGUVacXlitHc/jXiUfZtm/KbKuDyTDaj+eGwkzwNdXnKQrJ/qcRoMHpaZ0D64wF/M/D07pwjpC6/MXsp0sDQ9c3m2OoGAetIlrN3bPfPW3d89f+i2hEilqaM8hOdvhUMH0DN0wDZbCCCc9jL86yGM6jfeNJteEx90cnJhcd6S4wMO1prBz7f1jxv3yAlMxr/M1WxHBPZyHpddhvl4ounaHC0yhowT5BDsbrg5C0Urt9+zyODsSG4mm91B+jjlg+r8M1UHM9CYCgJ1OKyx9gBdx+U/b8o4Pys0cMxctBfKDamnojIvhvhHGt37vuClo3GFYrxxb8xBDYj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(8676002)(66476007)(66556008)(478600001)(8936002)(66946007)(41300700001)(5660300002)(4744005)(316002)(186003)(6512007)(6486002)(4326008)(26005)(1076003)(6506007)(2906002)(83380400001)(2616005)(38100700002)(38350700002)(86362001)(36756003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YE78QimwR+GYgt2dd12pQyrioSXg6Lo4miwuN+UN7o0QayRCx2EKJIei5rrP?=
 =?us-ascii?Q?HtnraCybicPEj1fxq1Bo8Sd10tTtO8J/jOvdy9BLTPWQ2kcbBixOudeL8n7x?=
 =?us-ascii?Q?1WZg1Wj3/KrleGIFgdz2SeDnWI4BhqANgSsmMjV7S834CKjyQUAjYLBT3Xic?=
 =?us-ascii?Q?mijmrkIHIaTKX3Hl3jog9MSa3jOwuZcjTooaVAkxwGNYSvxDJeeo6NkTxGJr?=
 =?us-ascii?Q?mfS9gcbajWcYrAJmaR+1GYHOqqSfvDmZmCjH1xKuaqBBw5B0RnhHe4XTr6De?=
 =?us-ascii?Q?5jz0BdzpqZs1eqJfYQDw9h12+l4yd6+ROXZdjfdK9b9Qj/Bb1Gj47F3ajvb2?=
 =?us-ascii?Q?ec83EGDS1dAVO2yfThGwkHa9OedZoO+iBW6Y+dDQ93ED1lnwhjkIRJgJJTDe?=
 =?us-ascii?Q?I9u42AAz9rKKt0JVrsp9lOj+wlnQDlgx7lYcqVWX8bRKnYABTwxWv3Bo2yl9?=
 =?us-ascii?Q?/ZOjJEwQEJXbtBl76qc6v02nv5eJA/ZnLMbcTLxPHgvoqFvvvN8H6GM4CufN?=
 =?us-ascii?Q?ypCoZ547ETaQse0QgHG4Bd02XI/knlirr2lmRj1fFFAEizNERjDf4Bsktwcr?=
 =?us-ascii?Q?FjxelxXS9qMOpoA5T/XTaftVQz36FID5mxYAuMkZik/pT88x1+nhWu2uZLrc?=
 =?us-ascii?Q?+rjhrcN28OfS++n7L2WsQyfE99PES0jymaDvUWsE9PVt8LHswJWiLfZmaG/Y?=
 =?us-ascii?Q?rFdO2zZrFIzYrxI2EZjCZu9Ucf2pF+ZQ9ipV0+h7ku9+NKfBGeivbkCxo4IU?=
 =?us-ascii?Q?f6jIpEURq4TNBO11QBvHvB4yAUZDsXa8PD00PAIGDTjNRbWXHrc8CZEOnBPi?=
 =?us-ascii?Q?+otF+c7Jca3JrYY7qKjg2NuT4sSJfUKHsKskP0d3wvHpOUYcMNJlDGi7HgKw?=
 =?us-ascii?Q?TqRWaNXgtCz/rvbP087t5HGarLA7fM3D8QO+mhuSk+xZ7wQ1QKbu3sIl8I25?=
 =?us-ascii?Q?z9ISpHaEUTQA5AxX0rIExwKpbEISC6UNUHrnGgzIsqSf4Uard4s2fxParvuU?=
 =?us-ascii?Q?8Cp2rBwx2QIK1wdUrnE+w25Qn6U2HkRhPSydTV5l2SKlUxppwdSPVKIJbHCC?=
 =?us-ascii?Q?LxujkrsLAnLvwjPfIwQ2mroR+7d5c/Y4+jregrdEf98JgQ2ofRobEbvCZBxS?=
 =?us-ascii?Q?GJ6yNQ7qWMCLxXJ0nGT9Kfqrm0r4PHICzKWsLqSvsdl2B57HC77CaAO32lJ4?=
 =?us-ascii?Q?I8lKUhxxikowOGbZUL3ktuutsRZz1VlOVI+VYXoGPcy7fPwgtH0ohFq7oI6w?=
 =?us-ascii?Q?veJSa3JPJOzeOMCaLRKfmfMkg5nRjG7wEwZvfi9q5oHKewSwHTgIKxXjBcx6?=
 =?us-ascii?Q?13TcM+esdBjnh4eG+0UYvL5IGAzP/TSc9fvR4K7GgESiMQrub9CHhZpXi9cK?=
 =?us-ascii?Q?7rcxaMfwDIgKhpkKpb58Z92Wmo2O32TlIqxGiiJcqiS7UwU8b4Jg0zWF9W6N?=
 =?us-ascii?Q?HdmvkKt4agdtLn9QA0yC9sGSTah5jpLWHfpLs/pbWRvQ96LXCnJ+K0EbGs9v?=
 =?us-ascii?Q?54rCez62GjjdRdxmCwqOTC/mITjQ44+LY3JhOJSp5OnJA2/oWrUogkHjuIMa?=
 =?us-ascii?Q?JZ/xDmX2bZwzfLxnkJgx1E0BRSze3mrUBH1wAHZZUqyL3h1s+s0DKTgot+wN?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62f2bcf-eca2-42df-a99e-08db343e7bb0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:25:17.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBO+INSmWYq/YLSZX3eGLN6M4FXzG7MpxmMxrdWWq8+PZEiI1nHD/PaZAvsXpoIsqpJpfiqL49JsiKUG6+4UCgm7Q2IU1knj/MuSUTgPfM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a call to ps_wakeup() before closing the serdev device, to
de-assert UART break.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 34f44da9ef4d..ad9e25e0c350 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1167,6 +1167,7 @@ static int btnxpuart_close(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 
+	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
-- 
2.34.1

