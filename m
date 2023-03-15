Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2606BAE54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCOK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCOK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:57:26 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A537FD51;
        Wed, 15 Mar 2023 03:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Y/SL6g+r0UWrMdAnthIV/hqqpT3XaYRZq3iXNic8kg+Ljd3eLTfUFTfqO1LNl7arjtFlAWlIzDcHfv7LN5EmHcwr6urD310+JUUpIdXSScI5kUW0ARL3M6c0HwbDF3+XmkmAUQXQdEoii/jJjiQhtohBRDXpwmzf8HMMmmWssrscE1bDeJ4VNmDRawYotzhVlMxCCaQ6b7l1m9bk+PgWHWqjHRFBz42SboeWYfzLx4vmnSIKgoycxSccCy0lF8KiHaoMuHXfXloRwGGmW4KVsEgo0lTdepfjklErXcOZql/GM+XuO9FHyKRDOhoisV37tDWUbRsXxeLaCILsXp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP8wSlLZUZNLfoCz/QYATrIvPkwpSUidNR5fT3E5Sto=;
 b=IJx6iOFYQyfY/djZ06ohcmWHS5FktDDO1rqGs/I+RBm1jBsMIjVNaDINmIdcjxRlrIOaiR+JBL4gXTgzeKQi65NvMH6dxUeyfN3XAFTa47N73ozNvc+JOh/GHzOa3D0PrE58aDUFhzB6bo8lwqILALefcKu4D29hEuzyBwguE30t019DeFruVhTIYTzFZRW1o683S2dJIiS71QJLWbb4DIunQ1pcGrkgKSgZ+DFaNqGECNTkUQgozsB4e21K1xog0gnqZBdCS9Xttioe62XhJsirdCKKTghDB0sqa7hmZ1j0csuRUjVemJjXql8J8BF19k5p2/48SVsD+zxMH0gBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP8wSlLZUZNLfoCz/QYATrIvPkwpSUidNR5fT3E5Sto=;
 b=ZagLTd/xgh0nO4F1PtmC4ckZjlauTC6/+bFquStCAak792rL7jALZpHyABMe4QPNXgBpOWEbwwKcydEa63v8DwVLMeRFZ23Q4zLhEkuBqQOB6TkcPUbZ5M1Xop4F9jhJh4WBhM8L8M3gfZWXYxqAzM9rIAiOqc0YeFcexw9RFJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS1PR04MB9263.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 10:57:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 10:57:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
Date:   Wed, 15 Mar 2023 18:54:00 +0800
Message-Id: <20230315105400.23426-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS1PR04MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cf8f53-2066-435e-0238-08db2544055d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbHb5YG7ndKGvNsfWomtMcOEmp3Bul+Mw359qoG+J2Fh6QM5qzDts9yBslEWu4nm4EFeHyktqdKxN8On7JVP7J7A1AfOiSyR4w+pXsjpBr98VH7cYT3m6ch2EeWQ9qxyvMKAIllpbcHP/3Ii9w+xLE3CXaQ429L9E9j9vmUSiEXaOC/pcz9idQtVQRV4qqXqEpDD2QshQyBj1IO1WSWKHFeQOx0GSZ44M6JVet4PUs5KF75e+nCfOTYq4dOsTlrWJb7r1Lyk7wHI8gnamN2TOD+YU5WPcf7Ug3ovyFDLMgrLOzVRHv8qxF0QGIJxYtm05Aw7DPYLU+a/A8z0Fq4PE3u7Zde4AXNC5x7TrtyqE5Y82YouQjSsEB/Goez4AY/EtqkWOuk6wrPJkHC+WuGAsc5knSbH+w/CZodNrJ5O+ILJW/sEMSDjMrPzomFvikcHYu8Wpl1gGqY7vHC0hVA3zkickIAebKJpz154dAf1v5JrgiKMh3F3KeG+6BhtMjFf6k7DpNULqSauuQdJcQVy1m9OnzkBfFf8DOEwoMmhDONLSheVp5OIHj0STqGoNZA298KrzGZmidEHP8WOhptYNjDUrxEX3L3Dn8FGOJ/qCIIMbWTvHDljCElM6+/IbNo5aifE5+PMZVDfry3HFIcs0Sa4JEwFXQzg5GnEUwyQDJtRKKQi2+bvjCxDJo+4IdlA3oSfeX9HhIIG2E2XD5EEkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199018)(2906002)(83380400001)(5660300002)(6486002)(6512007)(52116002)(36756003)(1076003)(26005)(6506007)(44832011)(6666004)(2616005)(316002)(186003)(86362001)(41300700001)(8936002)(66556008)(66946007)(38350700002)(38100700002)(478600001)(4326008)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUL88jz6qWz9urCKea+Envxim2EOdWsD9G6lzud9zL0BYTc42sicBjnKjxUv?=
 =?us-ascii?Q?Cm7PRweEEZWoWliId34+AIAKY8tVjNS0QVFzQXVSFOERdhBVO3NmyVS2jNt6?=
 =?us-ascii?Q?ceGkDaX9+eWwXIbxGQPJe80eIljNfW/Yfjgo1OS9Lv6ZjpBiI1lzhU31UlZb?=
 =?us-ascii?Q?fTisZT7aHEVSbSa8G+FCR9dMCrq12Ws3OhPu8KeuruhD22sH/64QkAkkRisy?=
 =?us-ascii?Q?fHVriMdB2nf1zGatYFEWgrGGAkHU+v5JOXk8W6syzIXOLzN2Zszq475Rm0XK?=
 =?us-ascii?Q?4YVRGpvfC6ZpNyq8mCBG6ENknvpXdeVy0CGwFirq86TH9EAdedNQDTKterZF?=
 =?us-ascii?Q?8BBP8iMyi2qBCdQq9F9vmuYsCQJ2uLs74Ihc8M3MCv1h47rthrynPH3fxE0b?=
 =?us-ascii?Q?twxtbP7RgHs3a9sufNLagT79cU0ouCqqasaq25y9U16Fpgcsq6012Xc5Xm62?=
 =?us-ascii?Q?d9ysKmJkDvwlmm6VFEBXWRXPlT6q+sgWCMdMbYrUguFVyTRqvPnm2/ho2+n4?=
 =?us-ascii?Q?Sgq5+udAkfd8rDMPDTfB9ADttfBwtWreETS5tICfIXZ9Vux/ujqy4dRy2xCY?=
 =?us-ascii?Q?Q2OknH9+VPVwdD0vNYP3fQxXgxocWbLL4W9Ra6wDzCuz03jx8mQQ47y/GAKR?=
 =?us-ascii?Q?VQ26a0PB1SmEeqI9D+aUU8lMrmBcWBgkUvKLdKdKo7/NzXfUENPnA2Mn+RXk?=
 =?us-ascii?Q?CfINHRNmdmlLXr5DpZVUl6VVNIW2SycX9KtSJfucjf5IeAU18FRg5hAx6KWN?=
 =?us-ascii?Q?L9M5ChAwtf7FXmNK6oz7NvUP2clsZX+X5FtmNGMrrMlHdy41l7zNDxeG0UPM?=
 =?us-ascii?Q?/GcwSzdnjqxxJzXW18B1S6Lo+y/wrAOzuAlEPo6ZKhteKF5OCIWXPu8Lseoa?=
 =?us-ascii?Q?J0CIGjivBnA3veltRTFEgnNmF3w/hlatV4jPVU+dvh0XG6Y1gUJQkN8J4btw?=
 =?us-ascii?Q?ZcX9mdZFlhhHKhXginVr3mpBilVVTDtoQlXIz/rGcu4nKCQCUzaXOivKUdJA?=
 =?us-ascii?Q?/YuLwbRkKceHstS/GQ3+sL47wWEhRn9R7ozXyz+NYp+0wmhxkPfgEKPxBgcO?=
 =?us-ascii?Q?OzrOHWraWQQ93RgPlANpTAD8gSOrPACi5SE3FBChzP2c5iqW8YQgJlG1CmSp?=
 =?us-ascii?Q?aBaKzgNR2M917EFsa2IZZl1Kzm4PS9atT4N6D3e+VP0OwCXLnxU4Ew1g1MZW?=
 =?us-ascii?Q?fxN5j7GVNXoUdMm+t0Itxj8+sUcOLstSk/fxErUbGXdqY2R64qe4BeuKAyrM?=
 =?us-ascii?Q?zmOYn6eVgdNc+oobSU+6hMSDu/3BPz0lX9+9sVpxN3qFD8NYC3vQKJK68V/F?=
 =?us-ascii?Q?z6CeM8Svha6f5TiywpJzsk6E+vnxdwQYf5qevraq3eRe62VE9scrLt/JSRwd?=
 =?us-ascii?Q?ZWmnmUJ12eKZBBa3KT9nY2T9LcWnqy1GvhO1IFkGu571IYP9BbO1aGAqO4BO?=
 =?us-ascii?Q?SaJgTkwH79R22mn0j1Btc3RwOmCqobPes1DKZukt5p37z/YSFsPmtzPexgv6?=
 =?us-ascii?Q?hRhv3xR3v9c34BOrd1r4wg6rhZDhs/xTBHQQZb43LMVyQt6uzNmLSmXWss2O?=
 =?us-ascii?Q?trKyNygduP0u8iCj3H+7Xayk/eLz4odthQVSFxSf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cf8f53-2066-435e-0238-08db2544055d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 10:57:08.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1jWeLxnwscOEmeIrpiTxhLBC4Jm6fLzFW3Lyt5T3wzVknsCPGj5Rd15E64ZZKr1XCfDF4Pqpym6I+LTG047gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For serdev framework, the serdev_controller device is the tty device,
which is also the child device of the uart_port device. If we don't set
devt property for ctrl->dev, device_find_child(uport->dev, ...) may
always return NULL in uart_suspend_port() function, which prevents us
from properly handling uart port suspend, so fix it here.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bba37ab90215..c58af8141380 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -268,6 +268,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 {
 	struct serdev_controller *ctrl;
 	struct serport *serport;
+	dev_t devt = MKDEV(drv->major, drv->minor_start) + idx;
 	int ret;
 
 	if (!port || !drv || !parent)
@@ -282,6 +283,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	serport->tty_idx = idx;
 	serport->tty_drv = drv;
 
+	ctrl->dev.devt = devt;
 	ctrl->ops = &ctrl_ops;
 
 	port->client_ops = &client_ops;
-- 
2.17.1

