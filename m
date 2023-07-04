Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE15746EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjGDKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjGDKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:40:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB4184;
        Tue,  4 Jul 2023 03:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoVe+/FUH1sdHX/6ePbj0RuIVOlA8jKhQQlRLlLL2qFmuC2fKkYsDzPfNywE0DB+Xu0SqX6PHSIX+I7dHsx4B3P/zCp8mVpte0CiP0FbvC/RdJpAXAkxuwFZZJYk5wB6YaEUMjZOhSrKKrVWGQYZKJwjab1lxL3ZtiAcISsGVv0jRklnvkynFRBaA1k/SPT+uLOfsTOKU8d35reahUDED6xIViknIitNgPYXjZZSxqp5WfSswiR1os6KbO7XYn0w7/Awz5oT/RKjOTGqkZNgY3i5YHjmXWPQ6n1D0brDxlIwckeK772cw9sC3m4785wiDDL2uxhZXuskJ4gYTsO/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WMMzi/Y+r5VaOw8QrnTNS1fojKi/XKlYyt5lgbTCO0=;
 b=czDf1RQonJOb5qAMqns99AsO03Jv0OPJiqqCKha7oEi5nIa03BTzBZUKEWxQZKUqI0gNgpsD/LSGtrOwXqEuZp+YEI5Kz5YWrkFo8DUn07Cx8dPvdRt+X4fxP3IB4BZfGIRWwJ31Js8isCeAWmyervzqRRAxgfEWwOVFidcemmD7bN4E7jxGAMkfk3KQ/grjmd1qRY0fblUdOpR/urSeU4mpHMQ+tb1hbfUuzA/ZIc1oZrhDaMIMw9KROa32JRVeWMxMfOQAujJEFlNqVn2V9+vzBulPtvW2Zm2074jmKGleVtJHVAyQi9Lpk0cn1TasM4mr8BOhVfw2DJNqkexgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WMMzi/Y+r5VaOw8QrnTNS1fojKi/XKlYyt5lgbTCO0=;
 b=LB+S60dti1yTvFfBfnGmmkZc/xl7syoh/eN0YeEYztzPDLT64rE7BdnSiVgV7gZpJT4u7A2Nt4rKhdjFqgUw8+TE4VyEl46KbOzjRF6QSYH2EqLOlNvuOx4IVJL6uF1WJ+Z9ivTG/jycNdZxcpTb01EIx8dtVyt8AmoTT8qbrpk01GOPf3Szcl3Iba8dicSUpkxpn4yORM4AwRm99stcR2Na8Gw+F9I8gQ4XcyPxSW1H5C81XkMbu8tcZ/JP4lqST4rA8w28JSCTiUp5k3gx9Y0xHIg5Vb4eIefeUaMs1ajjDCe4zotc5PZqL6UXtOcxEKujHn9U4j7GqgUiIoe2Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB3956.apcprd06.prod.outlook.com (2603:1096:820:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:40:31 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:40:30 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:GO7007 MPEG CODEC),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: usb: remove duplicate logical judgments in if
Date:   Tue,  4 Jul 2023 18:40:17 +0800
Message-Id: <20230704104017.9535-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:404:42::14) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB3956:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fe0428-c205-4a6c-c959-08db7c7b1647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19CQR3bS9Fnu30TIDsSdUlfE5HaR6n0CwLEkKfNximxJfAW+eWZYPDNzeIvYfVGJMvjX/RUi7IvnTcBHP/W0/sqgZ+cf8TvSszE/FYbXmeKIC96qNkMUXi73N+2f8Hig2mnESSPmwErZno/vDwhLMiWhsKcor26UJkawhtogzwoywvHQNTGJIw+lyEMdAxBIIcTr86L9KM+HQfsjCSi9mWocjf44l+g6ABYN/1Jt0Eent+QLAk/t1mb8Lwf+5VMVgYrD0Tj5jtLfou+X0SF0DNl6n2ycql6KRZZPrSP7pYb5moW99+uBcJ3Ryiq6vFnXud6KkpaNQxmbcnTl78IZwSUpQNZyZsUWoRWz82ButwxCZL9RxL2TK2Qjn4XJzZkhIhL4oiuAhPcaLwySc8gWFw3Ia8Cuf/mPUHjq0DWL1AQjDZ5LgQGuXF6fTGlfe7Y4c1YIckd3sMnUj6/BmKR0RWC6igExJWAgOB9tR+dkPSAMTsu233PS+0PrOwau2hh6QsWN/+0ovaDTX4egXBJB1HEZAv85AZywrGUvhHfw4eGPGUYP4vBXGgt9RY8bqbovmGCTfQH1Moy6jG9IvpVyp7jP7/Xcg0LlwaEA40EfzCpmyWNPM1yRxOe74Yb3rFZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(107886003)(26005)(478600001)(6506007)(1076003)(6666004)(6512007)(86362001)(2616005)(186003)(38100700002)(38350700002)(4326008)(66946007)(66476007)(66556008)(83380400001)(110136005)(52116002)(6486002)(316002)(8676002)(8936002)(4744005)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPcmbQVbMuZ9lt23GpNYkJO3MZigONJ7CA0HpUXJPhI6evYRoDpTCtLLDEmM?=
 =?us-ascii?Q?lkYzsb5f3RAi/8S3qpkSUJEHS0xl6ofJXSkSEi8Etbs3EVdwPWEfRwEUR0Hq?=
 =?us-ascii?Q?tNmlTLpBTktE8+VsNUpDltPe2k0FrqGsgdawLS7JY1oNDD1hnfWnV15WeZC9?=
 =?us-ascii?Q?Zh/+lsXoHiMUEaAMp8+wnHKz1RcIo4yxOy5NGEQHBEvoKcygj4qckdNIZn4n?=
 =?us-ascii?Q?F+xFxyczow7/01F20l+PqM14fPYY8qOcTQWeEmjeJmuOxJOTYF4YaLJn+tyC?=
 =?us-ascii?Q?ljzEKCsqpYfQYEmphhgrP+fz2YTrcieXiVjQRuzpme5J9kWOyanZIhN9HlHt?=
 =?us-ascii?Q?AGEQBU1LJ5zqPyKwWJqj33/3IBjLKxtixtnahgc5lHM4kZk8/Gq3APb5dcI3?=
 =?us-ascii?Q?bLHEiSOHxPobSrefugX4vpQt12Jivp1u1/jFEFsv/V631LBbvuzExwwkcZ21?=
 =?us-ascii?Q?0qyTF2LQUH5L5xabS4o6MaJEJRJ3gDH+4b7gn5JQQW9YPUgianIozkPtAKXs?=
 =?us-ascii?Q?4NapP+OD0OqeuWVmkcz30nWMM422zjvE3wB0/aX8mHG0eGP5K+x4rhb/0bOg?=
 =?us-ascii?Q?aZwsigrIlbVh8/DEQqF3K/sJYdwL2i3mhcUawUyxKxFRQQTTACAGabxAQr/V?=
 =?us-ascii?Q?g7xc2++7bw0zzhzVWvDeqi7e9hKXoIVSCqB3Hcl4I3NY1rTkDOuc7ByAhI+v?=
 =?us-ascii?Q?ckSVlOG7S851pmdoWWYOmwth1ZlEqWFt3D90XgGQ6n/rEZhQC5C7+NSu44ZK?=
 =?us-ascii?Q?2SdFQ3ahJILGXRMzGF5s4j/7tr+T6W9OkPeqTSwiyOtPfjQrAHp0FsLTg3fL?=
 =?us-ascii?Q?BgO/8eGTTzG65vYaKJpi6Uu614zBRlRuIiWJX4NV8cddHGiTWmoh2hq67n+Z?=
 =?us-ascii?Q?gdrRSd+BnPzUqvzJQoAbxdOYRN24FTFYThtmJfvX5yT9elVCFLAMJ7wyT/M8?=
 =?us-ascii?Q?aswq7r4COP4isEgYMRKg6n5s69+81M5Wh7ZC5ZqMPeRhSz0X7tgY6y4q+pzW?=
 =?us-ascii?Q?twJIjE7WXlC61RkKaWR+XDssr085C/S49gomkDimVyioZl6XEOu9rP0oGQxt?=
 =?us-ascii?Q?u2D+O5GjNWCjFjLZ0BbTfXX9sE6FWXc94CIZaP+8yrT2x/8FpSG58CxTfPZb?=
 =?us-ascii?Q?Z1zd/vy60w9nCdquypCUuyImcDq3TZ6n3VZzIe0F0y1WPFdlF8lTfHYizg1h?=
 =?us-ascii?Q?o3/x7QCML2pAzTa6IdzZSRZAJMeIGbuoCymrGD7F1IeA38G1gziTt86QxTCK?=
 =?us-ascii?Q?RuPnK0qFOPcvLC+7yWWLfps+4UUQwvtl8UylSIFC1Oh/dymSrLBJa4KlTP7K?=
 =?us-ascii?Q?vxsjFdLUoko+E8pS7VRLvAfRNLgfFTXB6R1vkVY9jEymh9d6x3VnmpP3LKbZ?=
 =?us-ascii?Q?dAye02xjKa9DSJSU9m+q+HaVjmn4aBXtcbyU009iluDeK61pJnWkgGGXjJXW?=
 =?us-ascii?Q?ROMF4e6C6IEyRDP2H81GIZCW2KwPlCOO3jW3QA5qOPgjbriKoKirCftiys8X?=
 =?us-ascii?Q?qNTyk90YdeL/MFbxpefyKt7pHNw1/PWEKacfi9ISURLgOPtvAvuTFkrb+Qvl?=
 =?us-ascii?Q?v0ne+fRHxVltq3FVWdfSdXt5AnNasjok0X+RD9iN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fe0428-c205-4a6c-c959-08db7c7b1647
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:40:30.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMFALRk/j5z1uT2vLNDyP0OFqxp1OY3qCum2p0jjf8pQunC8PYvB61Lf5s7rNZtDJKBhPhZyRrObRkbSAwE7HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: delate duplicate judgments
Does the judgment content of this if
mean requesting confirmation twice?
I'm not sure, Could you help check it out?
Thank you!

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/media/usb/go7007/go7007-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index eeb85981e..c85e48e16 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -653,8 +653,7 @@ static int go7007_usb_interface_reset(struct go7007 *go)
 	if (usb->board->flags & GO7007_USB_EZUSB) {
 		/* Reset buffer in EZ-USB */
 		pr_debug("resetting EZ-USB buffers\n");
-		if (go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0 ||
-		    go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0)
+		if (go7007_usb_vendor_request(go, 0x10, 0, 0, NULL, 0, 0) < 0)
 			return -1;
 
 		/* Reset encoder again */
-- 
2.39.0

