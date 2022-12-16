Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3764E87B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLPJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLPJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:09:09 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC72601;
        Fri, 16 Dec 2022 01:09:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opy9btm3n/x0a5xtiQlE2YXfmqRW3lOiuKC1k7XzKAZ7DaeGuZdkeuRG8pgUtinomlQ0DZcyottB0pckPGqApn8pCARFacALy4lfGW38MGPysKcoeJ4a1oB4yiOgKBs3sxhEcxwkO0oU/FWbG5nWN8xb+VvObE/1+cKssqU8K38vB7oVVdod18hRYdf1vddTpJIMXfakCWG46rvR/yJ7og87r0EQgStqVNLrb8UiUeQjnc9OsOvzK02cl/dAsa6QNoobElWSMNiDUWMgGCFGNvDpxMmt8U3DKW1gWKgfhOCbwZgnxai36HsAvOfzQswDlLqSl+6IzMGWMOak4tw0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAs8P5fUDnsra6LZT2WvbZ3S/4WL3QjrYzdbVJhQju4=;
 b=OLfGFcc4NlnrCeOSGPc0dcvKW+kqaeey+1CzzFiBTcncZdOBTtZWKS55aPBgRJG/gJcRBvtc6kOnRu8YCL9GkF8pOII0Jdf6FuXkwCbyCKzF/V/Ekq3QaQre79k6LHEiPxo8Wp4N+67o8EFOi2OnDHwtQ7O5m86lKuMg6koUa00iO3mYHie0B0olLR35AxvDb5fDRQZ7067f4YUy5RE1ASaMNq5/p9D3kBsDyvbiUiowpmkwI8iAPIvTyuP4BROFAdLv/TLekxwfM8IGHEVnty1sCijCtrE5G5Rjd9wqKi61FRUtN0ZI2LVfyq8gdKPSgwsPOJO5GIzqw+Qv4cdVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAs8P5fUDnsra6LZT2WvbZ3S/4WL3QjrYzdbVJhQju4=;
 b=ZhHAJbv0+sKC6m7gwKdiIS4iWzl42eD4hpNTDufOrnCdK/Z2+o4Pbtkac/ZG8vH5I0jLdZUuBdlOPeLhV0cxEvAKI/j2CowlpM5H4g+npXGD1MkqOuQ2ckluhGURypal24es8yXG4LOduN3DryZd1CVeg+d2nQPkZWcWjbLp4yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8665.eurprd04.prod.outlook.com (2603:10a6:20b:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 09:09:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5880.021; Fri, 16 Dec 2022
 09:09:05 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: v4l2-jpeg: ignore the unknown APP14 marker
Date:   Fri, 16 Dec 2022 17:08:44 +0800
Message-Id: <20221216090844.27262-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 349a5f02-68e2-46c8-50ff-08dadf452eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3+GhH0Y8ojP5M3Z/30ZoAU1GE9owqSD45ub+4Bcu2Fdgd1ZsvyUu7uhjnDOA19kuKWMG+cYub+fFvfMcMRsC1LzA41X+y1l42WTaqJRqdObGDlyRJJ4tCPFzDHLXoMkQWleerlUaDLEr9Cvw/pILOHgRYdMsEmSMS2dwAPE8GTw1VZMFSSIzrOPsZMW0S2Kpn6Di8Fyx3b891daDYtqJOMGXpOXHYjdX+DZ7bNcm0U0zqA0HyQ7/k6CCusVWUjRt4oSeLWO2ey5jilg6I3l+Sp7syjJAC0IiOjZPjFFeEQXuGcgrMAfE+xzJN/lG7fS5dsd6oLYjGh0gU//OHyT8a6DO2quGenyMBLqaHMDQ6ELoDPonLVAuIHZr3Zgw0dynQV3DbW+vhJh8QbSXFXCbGsxm0NAtA3weHVZmTBye/dUgIHwKGOoiHYiSznpcdNaClk65ghysHDRk530P0DINP9oyCiZ2efpETJyM3bu5HiC48awBxCrajx1iqqhPGL6I31iUNu1DOl4GxFnqnA6WLChJn1o7ZTVESG2UWV7BwBO++hMinmDr+u8ZTpaO94pKQjRp4+73VLvhwhDMumEVNCFxPZi7/qmcf6Yopr0YUshEvjKCslSyA/guddYwNpN7bT4hIGlBvdCVaL5l2XF4GKzJ9OsWYVknjbI+yFmeHXaSoTE6xYaXVI6Xo+KLkuRmEbntLVf8h8lqVtZ90Hw3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(6666004)(2616005)(8676002)(4326008)(478600001)(38350700002)(38100700002)(83380400001)(36756003)(66946007)(4744005)(44832011)(1076003)(2906002)(6486002)(316002)(86362001)(41300700001)(66556008)(66476007)(26005)(7416002)(6512007)(5660300002)(186003)(8936002)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mJHvSqreidpihMCXrMKMrbV0fTauY8iMLzvXBWqhd5b8cTM87C2HF8/9UGg?=
 =?us-ascii?Q?7Ft12q6XLXQdh4ZhOiikrZbnZeRqV1TGcnrZiRcmC2Jrxyo7vAFoaZkKuFd/?=
 =?us-ascii?Q?Ib9m1ORY3Ydv4cCyNiZCVJ8elzqzQejdrj3cJch7Sz3fVT4L+jqFyvyThcOE?=
 =?us-ascii?Q?LSfdJlWQYhWNUrqY/a/qeBhQh8h0VshAUaSYr6TlHAlQhVR40BF21xW0P68c?=
 =?us-ascii?Q?VA4JNNQUAo589a3gUBptMC4hU22+ZwU6cCSqUCbA+cWwEwHkbnXYM2BK5yAa?=
 =?us-ascii?Q?/lHv0qnDmsLVl1vw/TeP7qbQKGqsTeAJp0Yibqt2mfVIwo9jYNwP8UT4/VIw?=
 =?us-ascii?Q?PbMt/p0/Uj3DYNOHVYy/HILZ5RgDrZZ28jzv7PPrhRHWC+KZFziiNiQ/L5SE?=
 =?us-ascii?Q?S4qAD+Sg5aHGsG4zuQBK8cce49tK41zM1jL/PKk1KTlAQPbo66TM8lkGCaAM?=
 =?us-ascii?Q?wdZEaMOY4xxrVbYKALu0RUP5M+7APZgxb6iY5sPRLUIxVmxp/jSiBNPFSdry?=
 =?us-ascii?Q?HFYXycfOJNGGP+gEXU5hrbpnlHIdHZhsjI7EfoDghQRAvA8Vk/Ho93EaXM0y?=
 =?us-ascii?Q?izgIRf2CitWIyh2EX0NtuNKpwEBEseuCsgEw19/7PqfrDLrpXLP5ulXYHLjI?=
 =?us-ascii?Q?XES0q7ukPX4Wjz+l1OYxlpDsVocIur/DiU24POjSHbI6lt0GI3hH4rBIIi6K?=
 =?us-ascii?Q?AZcTKBKPn9ZGQFFg45y6gh11vdOtalNGLVgKUousgEY8tUyNjSwZzmar4dWN?=
 =?us-ascii?Q?MHa/la67FGnzwKnRxc5RMQUIpQaCLdAWmj5dfX8b6mqrVirWcgAUK/TWqbXW?=
 =?us-ascii?Q?249bVVYINDDEnn8srrN+SrjgVfiK3WRXCkXhbtB4u/WAFvokxWMb+/jyjabG?=
 =?us-ascii?Q?bogPSS3WKBcFI7VaTaleNpbHDTOhrJ2i/7cW4/mxUOgA5nfgcUPhVV3m0yFN?=
 =?us-ascii?Q?d3gUrZI4WHWtPmWfdV6qxTdL2icAV5dFSmb9ttB5fyZwaTnL4PVjDDKreNRm?=
 =?us-ascii?Q?wZjPZRlEyQ09ICRqwz+WsaVoHXhxBRBmw6yvnoPGbmaQDWHp7Q9TU9vXgiPc?=
 =?us-ascii?Q?ZM3rY4APZn/iUZHQ7Z8Bw5itf5ZBBFtzHMJvkmr/tcyGxkXyrBkAOEm/bHLl?=
 =?us-ascii?Q?hHYrxtB7dKsi4BJfvcC/WYFGUnD7OKYJflkW5/mrgWzXqiNIUv2FHhLyYHey?=
 =?us-ascii?Q?uubIPLw4v3hpOy5YKKE6Rq3mKsXEUIhpvuGEUwEruRYlWknjZMVkS+A5qYEf?=
 =?us-ascii?Q?baQMPJr3t20c4rPByfjRe34m8fbmOQ1VR+o5W2hYa3kykNT3BaKM+mcmHJXz?=
 =?us-ascii?Q?4DWF1rjHH57fwWI+fgEZN18UI7K6zjJ9x0LPkFZ/JCBtaiO9CGtvYTAR9sRu?=
 =?us-ascii?Q?JP3fDAhw9GCkN8bbza75seYZw0Ym2skBbLfJhT3yhWxYntb36I9nYTClaqfx?=
 =?us-ascii?Q?t+FIprPfEXZZ4Oo+SKNOvOT+apdfHWoLNqyIclHMKvB2qiBK3t0d9AdrG3R9?=
 =?us-ascii?Q?CrXbyQ1Guqknsq8T/3u9Tw1H6lpxDNkxkh7YklVeYfLtWmB6CLxkt75YWhkP?=
 =?us-ascii?Q?07nGJANnd89TBWDTn0bJlRZkAZhK9uEruOIHxKxI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349a5f02-68e2-46c8-50ff-08dadf452eb1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 09:09:05.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAntSE0gWTp1k5iLMucdiVlD7KUVsXNY5lGWCg6nYkBKS9nqQS/hyWQOT2DFbI0pivUG4JsUCp/sV9eRYFukfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legal identifier of APP14 is "Adobe\0",
but sometimes it may be
"This is an unknown APP marker . Compliant decoders must ignore it."
In this case, just ignore it.
It won't affect the decode result.

Fixes: b8035f7988a8 ("media: Add parsing for APP14 data segment in jpeg helpers")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/v4l2-core/v4l2-jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-jpeg.c b/drivers/media/v4l2-core/v4l2-jpeg.c
index 75c2af763d55..94435a7b6816 100644
--- a/drivers/media/v4l2-core/v4l2-jpeg.c
+++ b/drivers/media/v4l2-core/v4l2-jpeg.c
@@ -460,7 +460,7 @@ static int jpeg_parse_app14_data(struct jpeg_stream *stream,
 	/* Check for "Adobe\0" in Ap1..6 */
 	if (stream->curr + 6 > stream->end ||
 	    strncmp(stream->curr, "Adobe\0", 6))
-		return -EINVAL;
+		return jpeg_skip(stream, lp - 2);
 
 	/* get to Ap12 */
 	ret = jpeg_skip(stream, 11);
-- 
2.38.1

