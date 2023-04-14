Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712B66E19E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDNB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:56:11 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8F2709;
        Thu, 13 Apr 2023 18:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6cILiX4wXF9K41Hkq59e83/ZEsdfzhIem+tEY5qpIF6pN14+4nu980lLP61xACkT/aVD1OYoxqHTTdc/m1lcKhubfreG6j6VMeXiZ7Xm/fSc3eP7Jt6KVnybHTj4w3iNoKbXMhVjhEgoBoiaJLadGyP3KX+po1zaLyOeunvvoyQua5R59uMN5xRJOt46nGhXmeB3fi0e7zpfYSIb2LelMMjuKbDKiFJQMpke1oOgCbEsat0NIDMXDotbrRGXLymB6j0p9FIUuN4OtwVgcgStnjwSQb/KT0lVorFyz5sZ3b/pDl5+Vfp7EgZQc9XwZhkaylSA9CkdZTHCdbtWDY/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk4IZ76MKU4M3xvdoZJ5jc+nIK0/ySTzVEZsnaSj4Eo=;
 b=LpqyWX4l5AZZLx3baF6vGhdsMDQVAYpPMX3H1ZNlPbpJjwCOmUvzG6/xK99SzLo40xubrNd1Hxlv2Wy8bIZC+wO+MlgSHFvTj9zl9+YikmP9YQbLEpANGx2vWSktzAVGv0eXyLHIa/mi3e4oK98lJcePnsLbWguOhPNJD6uumdCAfzBtO3Wqq+/ErG14jisj5fVRWRDPNnk1KRI/TC8nGmJ9wkbtCvDUVA5q4z3MzKz7YdyWC+E5SWTIlHZSHgeo1D2ECkAxY6PzrMNPwrtF920UxWrvZut6vjRtrTMSJbO2tvJ9E/AZ7ZadWSmf0+18ekwtEi0zwrNoan2cEqr0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk4IZ76MKU4M3xvdoZJ5jc+nIK0/ySTzVEZsnaSj4Eo=;
 b=RxAto07WQj8Cq3Kufz2JhgYOLcdsbG7l+MXwnVWpB3wJH+S+wwOZX7mZOoIDdhNCJ7x7xr+heCngGJRfIqJPuf5QOf4+V2gdC9rJLDSpDmAlprGBA9oIF/xd3V9TLRYBLP4xJpBTInOITmt8EZMJgibcMihlfOc3B39RfIxE8Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by PA4PR04MB9342.eurprd04.prod.outlook.com (2603:10a6:102:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 01:56:08 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::632b:b1a2:25a1:d364]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::632b:b1a2:25a1:d364%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 01:56:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: drop repeated codec data for vc1l format
Date:   Fri, 14 Apr 2023 09:55:42 +0800
Message-Id: <20230414015543.6580-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DB8PR04MB6346.eurprd04.prod.outlook.com
 (2603:10a6:10:10c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6346:EE_|PA4PR04MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: b34842ff-afb8-4866-e5b9-08db3c8b69cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iR1HoQh9A8SoG0YBN864NZt2FCh1bTP1detjICHUqWw4IVNwC4kZpjM6WkKSZhioe9V8PpnsXkJEuhHClCNOKM5HT3RwWHwcns/uwTrsKVYbPSNGq2rXsSUDyIL2stGLWCmrjWoJ3aeboG7Nmia2eGq+NJ+lyR36Uva6r4Rz1Ps3Fj5Es2y7p8wzCRbfrbYcfL7YUW1ouZ7AeMomfRKfYT/EnFe+VtPiLtSujREkorW0twX9eNIwWROUoNsYML9G/oTlFZjblp/N2b+h15h6r/IpwgWvRu6U+WR3ow4SyQSBDTpj2Y/yuAu21i7PHg013aSdMFVpp6iMe1fZsDGbf1WUKyyebYxuE9IGnHLKqWzIYucKbYDz+sHuGHEl4qZx1zYnQ+ou2XjeLKHhRgQqAbn+3HxFY97SBVDKzEtsBRnwqyNhPSK3WjQkLMbAsVU06HxAokAlWsDX2qWIL6TdeL0IJ/xpebhX2Ezaex1hhQUA1MM6Z10ZqsJmr6gPtxnlX7zwCeAGkqC+GBES5M/GpsfXbf1HXO+LNoGyy94awshZIkZAEeTCi6TGWybYZsSj+spaYiVKhkGuw+CSyqX+5gQ1xU09iBW9nQGuD7nSvSsWoOYbdQPCh/bR5TveiwZohg+AMFUM54Z1vaPaGq5ZYiLtt359jnQ/ivPJKhQ3+sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(478600001)(6512007)(52116002)(186003)(26005)(5660300002)(44832011)(6506007)(1076003)(2906002)(316002)(6666004)(4326008)(6486002)(66476007)(66946007)(66556008)(8676002)(8936002)(41300700001)(7416002)(83380400001)(38350700002)(36756003)(2616005)(38100700002)(86362001)(32563001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNaL1GAFuNVud+L4Nh24cZk7DgIVa2/S36s1WDnHzFKxQs6qWdUXATpoXrrg?=
 =?us-ascii?Q?962qEq85CpiJvVAgTuAhiYlj8IJJ3IEKO7VbkOoxwx5ZprqBCntBXHhCSD+i?=
 =?us-ascii?Q?QSkDw8VfH2HX1ispBR/NOICazefYdZ0NuiMaDAMxXMEzbYhaAn6AoxGJkoyT?=
 =?us-ascii?Q?P15jYewfRHUVSeRDcT0eHnU4QWwLxvv4mPoS7+QMtICvy0xsJHeTB5h2WJUP?=
 =?us-ascii?Q?XLb9HjbEU6l2+evCaE1qK4F6rFy/CpjwYHXIEVIZFAK/JmGdVYrFihnMteYT?=
 =?us-ascii?Q?RTl6uAQfGiNpyiiSnBk/D/o3zmqrbzFbGmKVKBXYF3+vqp19iu+PmoqyaZRe?=
 =?us-ascii?Q?YTiryffH/rQaa6rZRS3EbvyXE3fczqxZ1MQjyICyQ4Z/TZtvrX+XhcdW5RSZ?=
 =?us-ascii?Q?jyuAFDUWCFyrlUDeWWct3KQFRKDycoirYbLbXqLqzu8P0azG7CEqS/dYDkHF?=
 =?us-ascii?Q?NnqtU2oW9ukcv9p8g4i9WXqlpIuUNtM+ry32vo0JTOkCxZHDfxtXXiZzIXaV?=
 =?us-ascii?Q?JCaHmnYU76186+vgHuHxlmKcdhtW1KBNG6aW7IAki5MXhBECO3v2WErGapgX?=
 =?us-ascii?Q?Jl9y0UwzU5kD7gdk51s0kIKbxlkhWRTllKMSgJwbW/BijT+FAC5qlKV/wPpi?=
 =?us-ascii?Q?f/uxaMDuHUDTrAA1FrqWAhd0GxpHqUyFfNqDOYIOnc9A3xrzFYUHcosCamwh?=
 =?us-ascii?Q?uUX7pYmnI28SvLhziuLzY4/RaOVdnDdHRS3ekfLu2qSSNM6G+sAD8B4tT6Ro?=
 =?us-ascii?Q?adp8V/696dXyFOema51MHg/yDDI46tsYfFONAx/ibmzkKpIycMSOSKH2ibh9?=
 =?us-ascii?Q?dDdeu1Ah5zdgAGgb9JUXJ0rd/IcE7JcDoPfXFY6hg7mkW2Rr3VGD+0SBui4j?=
 =?us-ascii?Q?S5wTJoHf4hrgNO7swCfmDFJXRwfhnyQQ68Lw744r1OW0DFtpnwqAqpsAvK0p?=
 =?us-ascii?Q?KZvKBuk+MikdOkrmS1EAbi2OLmyC9StoKsvDyzfIRWKZca5yel1ozDkrW0re?=
 =?us-ascii?Q?b4PgJmp8Z7LNNcmuLPjmYMoX6oSTtxKaLu5OHW5gdt+B61BfOfEOsgzyHRus?=
 =?us-ascii?Q?WxEnEx4uWJ2x8FjAcS/s6D7FN4C/17WHAicbazpCY6zzRbGj/sBOYZebyQJi?=
 =?us-ascii?Q?fJv+khu6aByFJf/jOhqljZEC25exVZk7nsYagwAwpR7nqMkIEEdJmPKeyymt?=
 =?us-ascii?Q?C5djNPeblRIJ8vgJGroIgjuEjVJbIvSTt3Iqf9qh+AFzh1N91YNAr6Y5x9PK?=
 =?us-ascii?Q?Qn5Fxz7Qj5XbFyzrPMYFKCmzXLinV9pTLeI6IzXIeMk3oknE2QPkzq8+xtIM?=
 =?us-ascii?Q?sbkUOl2yliN6UVrQ3V6baMHcxPdIkGDcABMRrg6G3moozYlbmZl0UWQuqjGL?=
 =?us-ascii?Q?vtLw3HvzjOjSxUnNWf0M1tZ8O4pdxXBK0HuufjHGCzufcRiMkxX3UjG1pqtd?=
 =?us-ascii?Q?PbLhXIzwlgLhWFBO62t4kZmZZBsuX1AYPcKwL78NDMAIQrF/yAUPwrGDB1VV?=
 =?us-ascii?Q?AaqwbKYQrnRAvRby5VJF0fkaeL76u8aTuJ/KtM70RP8xrLUsrSI6NKF5EcW8?=
 =?us-ascii?Q?bwZxOveCs+1+9Y85KEDlWsbVDnSypTS9r/gdU9Tr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34842ff-afb8-4866-e5b9-08db3c8b69cc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:56:07.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32VLx44TrDgRQc+JfNysFFIsVL9WcAJLO0uUSxkojMUtL63cjAgScPJBkVy+65U9XJs+wJqqnIQmFP/2l5WoZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For format V4L2_PIX_FMT_VC1_ANNEX_L,
the codec data is replaced with startcode,
and then driver drop it, otherwise it may led to decoding error.

It's amphion vpu's limitation

Driver has dropped the first codec data,
but need to drop the repeated codec data too.

Fixes: e670f5d672ef ("media: amphion: only insert the first sequence startcode for vc1l format")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Tested-by: xiahong.bao <xiahong.bao@nxp.com>
---
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index ef44bff9fbaf..e96994437429 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1344,6 +1344,8 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
+	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
+		scode->need_data = 0;
 	if (scode->inst->total_input_count)
 		return 0;
 	scode->need_data = 0;
-- 
2.38.1

