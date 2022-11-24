Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081486370FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKXD1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:27:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF97C5B58
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:27:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmt/eWaECopy1X2SQlz73Yd1x6+cW9D3PRtfrOzmg0p/1925IC2/F4j9upNMr7r18Be4rdb249IJJ+5A1nVet1Rk+iACb1MdCg/JC/5TrlkFrCi3Y8JXLxTVOnqc9GWkWMjoaPuDNEjBSzzEsD3QuDi//s8FegfZ8GODN4+1syMuglTxYlTGFS8Pv6CdHitxA/0jhcNDqCBalSL34NDThJoGVnyinNNCIZiWKD/Ohw304yUBOCgYZNMw99fNNe8NcPlyfNbAOnke4jWXTw7+qvIUYHFJMZm2WGUDj+NDITUa4NUvz7zLWucFpMaWhWU61Yy3sg2SedLMyi4LiQukOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oBE70hLOli5DG6+p+fwqpwvUvoJuv4jQkKE/vQGp3Y=;
 b=ds+jTuGInOEYYk5zZS2enNMou0wu6cj5HPl0ckFK7RP2eI6OUGCxOAJ3p50asoeNxTxsKf2yjLx5ClXBYe8RScY83V+x9hWVRyVokA6R/XozE5/ERiu5DZBaj0NPq0oP59dY9QTysUR2RaZt4DpZj1nkD2BVxJy59r/F8fE0s5rqpFw+jX4FHK5z19ffjY5kUTtkZ0ZtDnHp4JgCeohp37OhsUWYEj6KW3O3QujeLUrAwa9BUparYPCHEhd7b02NcuvtT2RG1WPVLyZQVKsKMA2ryGpsq5Z+YMIeRkBPUc/muB99kbHtq6ZucsUoggc41SMXHhxuX8UkMJOy58XMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oBE70hLOli5DG6+p+fwqpwvUvoJuv4jQkKE/vQGp3Y=;
 b=SAhs1jpudg78gAHiLsNlSVh09CU4RLYT3UvGLht+fiSppQe7xjE3C54tqP5kap2wff5h1iQK3D0PGMXG5pXH613NC7Ux8QcO19VHZIJixYBvzRupFZskqSlZcpO9RBa73AlWE/P8YHjAf+k/C53y0NGa75W49NR5aUT+CrTE9FvZJRKTGl38tMxco9rE/9HuMTLmiTgl7uuhsGYzcHwKqNn8SGI/NuwczfDPGAnVAF/gU8wu/8XiWMT2gJ1zWl2KRj8vYp3qQoTwIZFyEQoSGK4jrPhsnvNd9blOk8v3ocvyDy+PrOQkm7IZtDx/LthAJdWnMAUaFFiwsGjXU5oQjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com (2603:1096:300:62::16)
 by PSAPR06MB4086.apcprd06.prod.outlook.com (2603:1096:301:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 03:27:17 +0000
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::db9:4dcc:e011:3ade]) by PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::db9:4dcc:e011:3ade%4]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:27:16 +0000
From:   "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
To:     viresh.kumar@linaro.org, Tushar.Khandelwal@arm.com,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Cc:     Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
Subject: [PATCH] driver:mhuv2:Fix data mode rx startup problem
Date:   Thu, 24 Nov 2022 11:27:01 +0800
Message-Id: <20221124032701.2163-1-xiaowu.ding@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To PS2PR06MB3432.apcprd06.prod.outlook.com
 (2603:1096:300:62::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3432:EE_|PSAPR06MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 0726c644-beab-4de1-d6e4-08dacdcbc932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8GgySkG4ESonChnRp98sMmlf9jlMbnCoobhBkRyuVyP3Pa/ynVlnaeKC1/KXNFtRa47zIeriinv3xlwv7eANNRRRhOqlDUv5qCWGUrmbJCPUp5GUExWGdAlzLAuw74vQ1880A6qhvozaxMW28nIwPNe7nxxjLUGPi71PZVtIUqIbu+AvoWBZIw9UxXhe0xw+Vlwu1NfE3SA6Wya/tqwX3GIZLgKIIqdBHPnM/u71bDLaCS+E+KkJJts8yd/1lbYKPSHRDDZL13BrPjAbR7M/Hz2PaKnSiJqPvwPpPFdCEi0YWm1CLROmjIR6w3HPLUD7kiGo6cgoD0tUTgFCOJGLSsRWBAm27qfi4iYRzpRbJHwK/zlhMRqcWHhEyx1wWCiQZfrhM6VAdGf7JHY5Z9S7De+V+OAoiqcV5H13YsqNipd/kHSsA3lWVDi6aj11A84aR/9q/0yZoDHpFH8l7qd6pytz+b58ptviUOw3xuDpYuCrcxMU+q9z4dqUGBsYsQ+we1fki47Axoyu7ocCa1+xv2h1ET7PPWMNhFt+RA0xluwiFnzQxmBpBdaNPOX2U/mwl5hBhoskUoNSjExB5p2WqByQfO9ANvgtkPdzD1zKQ66QNWaCRgZxU0aoqHJPrZcphb7O4dHAfD8YuQyLYPHb9ncTacvpvwAkkTbQkwrMbBmd/j8EYCAcTIDPMYjWJTPiStE/qVLpsERcD++7J1nIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3432.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39830400003)(396003)(366004)(136003)(376002)(451199015)(478600001)(6506007)(52116002)(6666004)(107886003)(6486002)(8676002)(4326008)(26005)(316002)(66946007)(6512007)(66476007)(66556008)(41300700001)(2616005)(8936002)(5660300002)(36756003)(1076003)(186003)(83380400001)(2906002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MeVOQxm+dqYIPEXPUGScg1z2DZVGqqULtdtQ//IGrGaVL1QOJ3BXtI/9JQVf?=
 =?us-ascii?Q?f9NeT5rwtdjfFBwHy1o7Vt+2IkxOpXi0tH2+ouBvh9IEeLZgjoEzY5DJYFm0?=
 =?us-ascii?Q?srsL//A8GGTAYcC2Ycr3uenO3quFY4U4wKuLC3XTzgmhnY5PIU/NpcvI5g3G?=
 =?us-ascii?Q?Q5jQtpeEp/U0CihR/p49d0rrpXcNKnvQD1vbtIJEjyasqz5Hh+4tjMELhGeW?=
 =?us-ascii?Q?iWGM7Etity0gUdvvCNyyKOXUDgQlpHd03BKsQiL9GcgDVRlAcvSe+mhk/z7+?=
 =?us-ascii?Q?ydK0Dg99+njdCwfw30bRct43nORT8uEpWa+Z/yHey1P3K/EdVuYMx74Ee/LY?=
 =?us-ascii?Q?v/M2ml4BBL48B13ffxFozE5I3dH6pkMI4Z+mEbVsGGF1o5LAA4w0P7/uIepA?=
 =?us-ascii?Q?rRACVR63M+9pWGH3uC3WHBbB1+yh0ka+W/+b9KbQXkmI1ReUykPj84GTYMER?=
 =?us-ascii?Q?GQI12C380HPUUK6ERxOgbcKk5wrRH2PFeNPf7EEJYwsRGDQHHVPliXnn4kUq?=
 =?us-ascii?Q?AygGlrgfp0tRbRVItpW8VkRQzVRhP7Cb+tman9cfJ99FFgGnGeT2Gonja1Qb?=
 =?us-ascii?Q?DqDUV9+m4MjMt8osy1rHRRmRkpk9UdV0GWwf38Avw/vSVn5MAsYP7b9TW+Ya?=
 =?us-ascii?Q?iPxDukPNyz8UhnmpnnohBgL+v1oAu0lFDgw84R5keLS7G6/AfiV5DndHw6Fo?=
 =?us-ascii?Q?X9ypL1SpNvMwSVdqxY9b1S7ua/adkbWACQfRfoKp8bMnYpHzp+53JynTBTgu?=
 =?us-ascii?Q?ZekqRwW5O6biIzaM8dLquvZGHq94ukmES/37wwBJ5sv1XXQLfb1gwR5KnWTe?=
 =?us-ascii?Q?IuJX6517zh/sfXXBwcZFSsTUOQvXzw74gn+ukFhy69MSuMxuZy5wmvIHMnHN?=
 =?us-ascii?Q?agyz76lBv+3a8TRS1CGfbGqFVyxfRyae9AxExRxaiZrbEK8ME25ivfeO3m47?=
 =?us-ascii?Q?fezzEyiF+aDwU4VN8fVpZZk/opISU/tlcSC6e1LNZJq7IDlYMM0cG6eixaQr?=
 =?us-ascii?Q?desWHe+Ja88IaXLUMZSsX18Zb1RiefV13D76lbxe7qpGm32GFOL7Y4VqyKYQ?=
 =?us-ascii?Q?phCn/lcgE5nGwsMnx36Cca8zXxXXMFusLb0ZzBZIGEWJFCLBDHH0fketfeoH?=
 =?us-ascii?Q?b64NHRumoJP+WB5Z1y828Frs7cexxBh1o4dZKxa8G6ST1+omhZ6A36izUPe8?=
 =?us-ascii?Q?CnbSjYEPL8jsQymFCHmezxjearGVhEzTPH+XTzZlI9W0shTh9kFhU4JoUUeA?=
 =?us-ascii?Q?IDRM4sAJJMgH+usp4i1OEy0EuFHF/vhCWofTv+Bf1bUD2heCqza5kMiEx+9M?=
 =?us-ascii?Q?r+ggP2fWMdwZwVlKpPduAmhtLOHt3MntQvj4tq+r7IzZ5pqiqjpvDbFIxRoy?=
 =?us-ascii?Q?cYloR1YJvukvLz5KQfvi0P5JvNR/+W2MMWaXikSlqaMh/LUaHjpg/biwrA/h?=
 =?us-ascii?Q?clZkfe6JPnnDwIZrmB3sgngH8zarbqrk725xl/QIOsBsj8lLhAUeVevM1XAs?=
 =?us-ascii?Q?KsOlVM5y3FWKLWGyYiUA3r8UbVF1nzeJ5sps3FCaroKOai4cZ7hH01xX13Z8?=
 =?us-ascii?Q?sH8dDlzS0qTaldcuWVgYBOLGOtASkRqqhXDn5LpnWb9b8nhyDJBqxqK4WFF0?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0726c644-beab-4de1-d6e4-08dacdcbc932
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3432.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 03:27:16.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeR8bOv4DpySuty7hoLkh5+LI6ulcVoIqIEBGdLTidn2gGq8vzJJbDnNY0l6pP7NXwFFptKpqyi2mi2wrvjprFFHC90c5pLC1R4UxVod7Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>

When using the arm mhuv2 data transfer mode , sometimes the sender can
not send data anymore ,and sender will blocking because of receiver did not
clear the stat_clear.

The test scene:
A is sender(poll mode) ; B is receiver (interrupt mode)
When A send msg to B ,but B did not have register the mailbox . The B will
miss the message ,and will not clear the stat_clear. So the sender A will
 be send blocking status and can not send again anymore.

So the patch just clear the stat_clear within the rx startup function. Just
Drop the last message before receiver will not be ready for receiver .

Signed-off-by: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
---
 drivers/mailbox/arm_mhuv2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index a47aef8df52f..7aef458f0b18 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -327,6 +327,14 @@ static int mhuv2_data_transfer_rx_startup(struct mhuv2 *mhu,
 {
 	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
 	int i = priv->ch_wn_idx + priv->windows - 1;
+	const int windows = priv->windows;
+	int j, idx;
+
+	/* clear the rx stat_clear */
+	for (j = 0; j < windows; j++) {
+		idx = priv->ch_wn_idx + j;
+		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[idx].stat_clear);
+	}
 
 	/*
 	 * The protocol mandates that all but the last status register must be
-- 
2.17.1

