Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A763BDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiK2KW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiK2KWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:22:45 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331765E9;
        Tue, 29 Nov 2022 02:22:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr4+DXXdpUtMsVgLvAAbw2dNCMIPlQsCCl4qWL/f+kdhfl9HexSs080SYjgxwJMvCTPsJLfswT+KZcZiI9bfqSfTFmIOJDe2BzhL3blKG1cvfmuhdpFbUfHAJl5ZUV7/Q0aHLZ3uSd60mTQBPlDAQ/XvfJJrW4iNipKXE7Pqpjqmell+s1zmGtCRPzJ8CVgDyjWVAxdVZowgzSQ/WdI07namxVsEjuFb5ZXY3MBRjv2AD9BN1WxRCKGy/tveeWsswZmIKaUWoLyzPt8jgN8ZRX4ctP9Vq/4lgmTONx8cv3iZ+w7Xeojp0NwZhkHBGyJb18XFlQ/59R4468to7q/2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWZuR2WeRKjmsGd5C/OLsOiGQdetXeYRc4aUZjpAma4=;
 b=Dw0d+/XWS1xN0xk6BK2ecfUhD7mYnTtjEnmog1M1oYp3AOmylujIzY5jCWXZ6Q89RqELkf16ZU2zyjUydasatwjKhSC7mdhdd4DxDDWetw0k3IKA6MN47eMR4rr6eHeFYi4nS2voR2MtLespfvTsbqfPP0R4qUSdsrOAnNi5dVTclQu/SnzHAiw/pF5ezjlSb/aQlDHELSHpzwje9W++AjP8JWzNM0yUCxYb6x53J0WtoSnGqs+3PRtaNooO+EIQUKCS5y/tI8ExBH6mqa3Qci9Z7yfpDDvUF51Xxud2wFzEeHe3zC24GVcuCdvKIN2Qs0lLMZddqTnwuRkiZxZhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWZuR2WeRKjmsGd5C/OLsOiGQdetXeYRc4aUZjpAma4=;
 b=qAygaRFyJTiRe8B1uP04VTRoHTCyvsxTJmpsyXvPBNaMtNZLIBiHsS61OVefM2hscghSLX4ME0MaCHQseoQwugB7mP+04yVkCnvjFT4kH6LH1bGPv5yC8lubPbUUNJPdwk/esLWaWLhJCSotumUIlqRvklOfSTCbmVErJz18Dmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by GV1PR04MB9215.eurprd04.prod.outlook.com (2603:10a6:150:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 29 Nov
 2022 10:22:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 10:22:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: remove redundant check of colorspace in venc_s_fmt
Date:   Tue, 29 Nov 2022 18:22:17 +0800
Message-Id: <20221129102217.30710-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|GV1PR04MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 614bdc8c-5e8b-40d3-5fcc-08dad1f3a430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3k0T/vixJx2uQ8c9COYqXc+Go5he4h2Br9XQVXMCvvqejv7K7U1hDjE5ODrJjyQkZdGwufeZpiKRhhUCp61eZIIAu2G/5USSz0BhqQCNMNjztOY0FDDZc1u5chte7uAtZzKtzpOymEURt7OpBMEDLN87DOtsQ4K9UAqAUc5l7sdYHdGb9NxT3WwhLcACfdJG6qadQh9+v7asZNpjZIXxhAyRPw6z6aL05t0hbpR30tiPvIOG4EJF6fQvjSPO573cP0yk0aGmjYKiNfGNO49bBpBFZLfNc+nb4VOdgGqAdRMB9+zwdnhnRw0EQOZ+mvjDl+y/dfcgPOg9lARwYgbSfsudSygtsq8574xTISU/6B8l3e5vD+/gbxXB1uP5q1nGnKgXqcDyr945Df80713PLfj53iBT9udMll3JoVLf7i/zKoryJuzFQKeFoZh+EO5dH3mZEvRy7I7C5lH0LDRcu/MuU1NYVJ+ceTGiFgkD6i4QVtZxQOc+8xjVO6SCoFNvuPS721/LD8Lvx6D8MH5F7wNx3ZGcDHRfFD7PjkUC+JK7Z/hxe5socVMu6IJjIbUF+99darhOTT3EHjPFABdEYDWetuD3DleRk1sbXpizVB585SdDS1FDyDDrXPVZdcAC9+T+gYUTI4C+81FD3ey875stUPo9FsksjfKKk6uZS6+OvpdH4c2JpRhDf4t6ACYQ3BmJs4RgPAXYlTqs1d6yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(6486002)(478600001)(6666004)(6506007)(41300700001)(44832011)(6512007)(8676002)(36756003)(4326008)(186003)(2616005)(1076003)(5660300002)(7416002)(8936002)(26005)(316002)(52116002)(83380400001)(2906002)(86362001)(66476007)(66946007)(66556008)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ctCev6hh0b8A44BsHlHuvPtyfMAjZxteHl3Q3zWwKUSHBQiS/Mf73RW2Q6A?=
 =?us-ascii?Q?wbFBFMCxlz7pVVkKexIvatyl9/QPUfBs07yOodtvI7rHDyg0iD5mleb0uumX?=
 =?us-ascii?Q?mjg0ynrg/b7K8golvSGRYKFgEXgtqQwh6g6Vkt9brBh+bKd+vQ4XfHg/Yz0y?=
 =?us-ascii?Q?1Vay5yq0DaIY+GspHC7+8jezKuSxtS70E+n9YiPycJItjk1WgTI1DekZt7iY?=
 =?us-ascii?Q?JjNbdqg22twz2WEKturv9AddegvnOE+AUo08yOPW4e856lK5yFSELmYK6s/A?=
 =?us-ascii?Q?aD7bySCiZzzW7S8USLWJq0+odgEF2KlnDpT0KhZXSAHuObe2QXyD5YPhCJJK?=
 =?us-ascii?Q?jg4h3e9ll1m8Xi8ouIGK6Rw6Iqb64r2FzRyMgSN5/Iu+y9HptxTdxHgz+o3P?=
 =?us-ascii?Q?QrfsrlZDRP2nvVrvV+j0YlCEaQ5YtriZth9dKNOA+/WHO/3AxUff7JM2sC3W?=
 =?us-ascii?Q?uBDWkznRVMH0URWvOAi8lL+UnaPEQk00rfajZhR4VmSNy5zBhknox44kx2vG?=
 =?us-ascii?Q?u9yfUcNovwcuzP2fQrYr71HpiAr30ik+cz9fmt1RHADTIwQe3/XA2hA41+A8?=
 =?us-ascii?Q?pGubU3KVxOwFUEYjVdMZ/6COAq13jDpYy/VIhIWghBZIHPX12BvbqvwhGAIK?=
 =?us-ascii?Q?ApopHYJNfpDy5nn/iHupfqlqvnGS7dxn2GhOW1qDbH7E4HcfNAssCgVjEHZk?=
 =?us-ascii?Q?6634zbOorbcfaUUv2r8a4rxUXKuICxBYmJBxG7h7wLxa38qBEHJBRgaE9YCx?=
 =?us-ascii?Q?5d3PsVsAE+zFfKynHloou0xwFE7YwitIGG8XWdlv7oE/GD0R/q1SRW8DbGhh?=
 =?us-ascii?Q?8059Pa+JQK8O5Q1kqkAJ2xB5oLu7nR0UPYkxvQCgaNyWJ2DXCrvX3dP0CuF6?=
 =?us-ascii?Q?oLV1RTqnoOo6HAGesc1ZgvyAZNS2tPFArpEMG8pEJ37TJGrpzS6HRvhZFwk8?=
 =?us-ascii?Q?EVqCrOtjcpd6UeCYn9rC9rxf2SQTheU9GMNCTspi80cxhlDEDW3HP0yguJeT?=
 =?us-ascii?Q?dcS782J5rUKSFS33vPFdLr1FRkUBG6X9+MhSzqsJBoPcryFTET8K66AwlHYe?=
 =?us-ascii?Q?3SYKfa5NeEVDjDOQCSBy2T/AkTurw1xMUSv4ePs7sO6OUGn2qSHD+zrHnAKC?=
 =?us-ascii?Q?LWz40XPKvK5iNP6CUs2d8O84fkfeF+RrWucZwGFB95/xap6kET9DgwsCqgK1?=
 =?us-ascii?Q?FjzwSFHR8tymVQKMX5Mg/RGUQy7NxFub/LAUGKfj2QQ46Q1xntTR90i9UIoP?=
 =?us-ascii?Q?o2pstBji1eZbuhIYkqjMDNQcRcdPxMbONTwPaMG2/j2NtbmNOUOfX+dV78GG?=
 =?us-ascii?Q?sBym4UcdMM6jr2bEmaP3yGknJUzEzBP9KJfaDth9ahJo2B993dy/W1FkNTUv?=
 =?us-ascii?Q?CFQnh++IHVcRzsizUAgDYis0Y9u5rsJ/Qfqs+ddQOJJ8ihuFSuPjdPMywVO2?=
 =?us-ascii?Q?Fl1vnnweCJehVBBDCds72mjCjmIi3NNlYNwBpwiG1wYguaQOCoPDzK1b7FUF?=
 =?us-ascii?Q?F/FWCNM6vR84vPJGEnEQr+W8LoFeGwJRSo39MRlgMcu6RzUZsRKMpCi3uEVE?=
 =?us-ascii?Q?qiFTLmfmGSk4SONGXSo+r6HO4sXqZGSb6dHrcbid?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614bdc8c-5e8b-40d3-5fcc-08dad1f3a430
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 10:22:39.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6AwDKJm20x3qxuYPbmDAqahZ4b8Nqi8PSQlxUTlUZyvTaOmUfMo/42NXVuYAkIA9L3Codv7hRIfw90aF6/x2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

record the colorspace set by user.
if it's not supported by h264 vui, then zero will be written to vui,
but don't modify the user setting.

Fixes: 0401e659c1f9 ("media: amphion: add v4l2 m2m vpu encoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 3cbe8ce637e5..e6e8fe45fc7c 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -250,19 +250,10 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	}
 
 	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
-		if (!vpu_color_check_primaries(pix_mp->colorspace)) {
-			venc->params.color.primaries = pix_mp->colorspace;
-			vpu_color_get_default(venc->params.color.primaries,
-					      &venc->params.color.transfer,
-					      &venc->params.color.matrix,
-					      &venc->params.color.full_range);
-		}
-		if (!vpu_color_check_transfers(pix_mp->xfer_func))
-			venc->params.color.transfer = pix_mp->xfer_func;
-		if (!vpu_color_check_matrix(pix_mp->ycbcr_enc))
-			venc->params.color.matrix = pix_mp->ycbcr_enc;
-		if (!vpu_color_check_full_range(pix_mp->quantization))
-			venc->params.color.full_range = pix_mp->quantization;
+		venc->params.color.primaries = pix_mp->colorspace;
+		venc->params.color.transfer = pix_mp->xfer_func;
+		venc->params.color.matrix = pix_mp->ycbcr_enc;
+		venc->params.color.full_range = pix_mp->quantization;
 	}
 
 	pix_mp->colorspace = venc->params.color.primaries;
@@ -1281,7 +1272,6 @@ static void venc_init(struct file *file)
 	f.fmt.pix_mp.width = 1280;
 	f.fmt.pix_mp.height = 720;
 	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
-	f.fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
 	venc_s_fmt(file, &inst->fh, &f);
 
 	memset(&f, 0, sizeof(f));
-- 
2.38.1

