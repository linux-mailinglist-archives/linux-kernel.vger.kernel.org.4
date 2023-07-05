Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4F748107
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGEJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGEJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:36:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C31711
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcTCrC8tjDFTpQFAWPvIm4lpJj/nMqDuavy5RQ7M+tXDdjP3ZRfQlTzuF9J+Zg8YPb3BJMcGVbNJsRXZ3EN0eTiWO0mBa7OlFfq4AeleCgkuBSTrHUctGiOMFnZcq9YdYBulIBFQKGrkocOPFsvt077k7pXcjD59lE1uwIvcfQxjMp8H55XPpQT1l3Or2p044M5EpSpSwupM+aP3SaR8YMXYnxOM5rgLhU+RbDLmSOK2GWuXl0xXbpv32AW6dZ2KxdEdvMPlNtaiJtEcVorBjU7rzbxC7a1NkHURrdVAShuSyrEa/QHsGv64j/gCoIL1/qNTtkCAzbKA2RxJOeVGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+332pVCNc6Ejg+1tpRfgJR7IiVzh6HZ1aD7HzvxUBI=;
 b=ocamacofWbA2Bv5FgnCXfUixXkEuEwc6hrz7NyKZNpOARUAe+cvAkBW5ptCPiVicv0Kjgtx7JujHsTPQofYEg+uwzLuVNVOqdnXTLe0MdkMGlISSAWm/4kmeV0b7D2MBZnavQtKDkgsyXfsSZBYGZ0lo1+LZDnOz4gQr8dVIMKAju5JZ7Pdn77LVMeKRJfq+3LQ6K24IrVJmRZ+4Irt8CsjSg8iFzlvlvAlEas1eTtthvwfJsNJfSmFGcTnIAWpnjjfFR7/j8GZ9d0ZdYjAevlrjkYzeP4mPOih4Wfqr7dCPd0w0BguB6Td5HaIhTekabusgLTeBx8fcqTjk4mqr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+332pVCNc6Ejg+1tpRfgJR7IiVzh6HZ1aD7HzvxUBI=;
 b=BcpvHtHhfMdLpfDi8SS5dB+T/QTpYc4Hjnq14h41tDk6ts8LXFUXz+SZhe38sovg9M0dYmVqOBMwYmj4FN+q4tYD1xeGLK0tIZXqs0hohH1O/whxbCralxuJHwJzsUlPxVDOP/ZGSlqnJPxT6SZ/OufVF96CRJanaY8/nQ/T7OfvD/RCTV04QJqSp4bjyGUDFfURwV16DNP1qLJGc1uyeUiLR2DobQbgo6bVmK/hBD9sSe1WnwER+xWZTfTVrzMYf/sQvyT0XjrPUBWYIW0ekCjOfm7/EQLzcui842EBRiJy04qXN2x6pM3P0SN1VEAhVAfUdtLXaL3NBBwZbt1rBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6268.apcprd06.prod.outlook.com (2603:1096:301:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 09:35:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:35:54 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] sound: seq: fix typo in system_2p_ev_to_ump_midi1()
Date:   Wed,  5 Jul 2023 17:35:45 +0800
Message-Id: <20230705093545.14695-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::34) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 85be36d5-8fb4-4ee3-99db-08db7d3b3a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcdNaQeVq64CIDcO4qIAuXXs306uOJbjd5RmFZShUaKwlxqx1kqhvrFDPeetB/ZXs92U1PpZ7Qyjstm1/UO0+GDD2q6LBrhRDAfqfFCGS2ueXC/s5RbAiqZukzP4qISqUDNNLet7OwV4T3rlDx1OV29jcRyJjyYWO3Ih2xZACXXezGtYsrW7c4RESNDbm1a54qJXMhRghmdI3Z+BU3apApT6SwPwdz7wjtObIuu0hJBtFxN5CE34y/G1JNhTKvgGUuGkYz8wXoUCmQJKKLf3QeRJTngsjxAZC9Tp3lwymyvD2Gd9ym7XaDVedpxHPDVFD6RuP29bfI9Tj8Zh6Uv+KwR+T5XOUugiZ6CoGP0IpfMlVYLJOkY/EYP1FpgLKNiAasRh7glOafInZYMIUql8vxZnJczzbRuk6iXOOE3mXd+0PpZDnUDTeHqG+pNti93kvt9dAwsRw2TUa82cUTyum+OtLNWW5+S+7PMvtOZe17Z67nh6hvnYdwFWBVAs0LF1DZo93K5194ajWuwlZ4gvyysKbDvStj7JCSyCKih1AO9Pxf0osaun84c1AOtoOJL9f548ArTqwGXXdPHECL1IuD7dSjrQ/gQyhZL0pe5mDfYZ23sFWfVwJDGv5AiNnXHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(38100700002)(66556008)(66476007)(66946007)(4326008)(38350700002)(2616005)(186003)(86362001)(6512007)(6486002)(52116002)(36756003)(6666004)(26005)(110136005)(6506007)(1076003)(478600001)(107886003)(8676002)(8936002)(4744005)(5660300002)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEnbQS1HtfCRxAH2cy1qADCQsn057g1GOK2vdg5K+PWdME6NwMk+dh/iD05r?=
 =?us-ascii?Q?A3reDmtDS0hewZ828sTRoic2n3iv1E1bQXG1yTC9XMYHsEVriP3w2TczzI59?=
 =?us-ascii?Q?PetwWX6xpv0czH3068MLIcs2ZLFZ2xRizEReRrC5MnjLIRiMFgN3jPwtHi8N?=
 =?us-ascii?Q?rUBN71nX23UNLFCfNNO7wgoRM+wN1z5wkiGAMzouR/MbNBPkM6SJt5+UrXfj?=
 =?us-ascii?Q?hAxp9W8nmyzXPYbpk8M5D9h4ijUVOhoedkLJzaNEGTZMdvVhEH+qgxF2f9rr?=
 =?us-ascii?Q?TEtu7QcEwd9iNSG53VUS28CixhOV1WFSYRstiqhgBHfPGxO4KT99x85Mwyac?=
 =?us-ascii?Q?xVSzuLXvP0DmIuAGAqo5F1SJCcZ/MV1y8YSmv9Sgir+wdUKWinLXfAETuSU/?=
 =?us-ascii?Q?G0DthimBDpwxmvY1Dhwj8OuaVdvlCFH5aV2IjVIa05fg5eyoqFkMP8Ay2Vnf?=
 =?us-ascii?Q?uPSr+zjtwe53dLNXPcbjNnqQ7Zh4MFGRgiz0+DAdf/3tByZKBeKQRWkuYfem?=
 =?us-ascii?Q?RTjmNo0ZfhHrrWj9na66HTbiG5nLYlNAb16FYqwnMvX3q4EWiO8wp0UXTr15?=
 =?us-ascii?Q?eaYyVP+Wssvndq3TV583Z62tE5KKCS4fzfNIk21BGDrLOJtldyoSUWaPQlSB?=
 =?us-ascii?Q?9Unfyeo9TSVk5ge8iGNSSPhQv7/ztPkx2+8M5RARWT2GyLzhVLzOBpMEP9ne?=
 =?us-ascii?Q?1qXbt4FrGr+mL0MMjTXpzi3tvRVpZFzFM7UMn765UzAtEBRhu6exHUa+8Hdo?=
 =?us-ascii?Q?BDJx2JMNPAMPsByyBgQh/mlS/RwRKGMR8dvqy8vZeijk6A61dDyo/zWXTJvi?=
 =?us-ascii?Q?p1cyG2cq4MO9RVgti4/4l2XfFIciY4PUKIJSyzgYnhtjlxBz+iTUVvwuQoI/?=
 =?us-ascii?Q?CWZtFpCQxTcSbxpg4Yq1zlyqCtR0pjYWE3EfBhdpgTzyL2VjuaXR76CKZ4iW?=
 =?us-ascii?Q?tcgIa47oSdZ7KHo5npnNrnuFgZ1Vqsnso9ppn8CONLiSwge6RgNg+oBFG+Jn?=
 =?us-ascii?Q?wMWgkZ2oXUbNQXJzcXf5WHeJPFVPRUrxwCuM3qM8T4FwPclJS7qo1Tm6u5hh?=
 =?us-ascii?Q?eb01ul8f4gQImIDj8D84SK/KA4tLjQi57nskgW6eUb7ampo+RVYtS8W9Dhsj?=
 =?us-ascii?Q?8XTw+MqN6yUyRy7fOhys4HhixS7/YNxH+UtuYhtuRtlGh3G4I0yGmCagOxXf?=
 =?us-ascii?Q?fhsvzY1EaMNCypw51E5W3SMGSeQVueEMjNOSZ5vp8b7AtNk307GRZ5QR1HM+?=
 =?us-ascii?Q?QHhbUrFtdG/P8YZZuyvOAoeaRySiQ4TbRm9iFbMKFkEHLdMW0MPeaF04RnbB?=
 =?us-ascii?Q?7KbzPgk6oFoYa3/+qiUv7Y2/1H/rFzDvUiN+Y+vIUKw0PT0mFRL8+DoZjzdB?=
 =?us-ascii?Q?NxbhjGGxOtTUdBLokJQPRAUpVKSMN7CDKGiNq9i1Uo1xFZ2QT8tn3H65jBBu?=
 =?us-ascii?Q?fUZ5xRRt4FtoJ6mjtuaEwMO3Wwe8dakOwxTG8ZjEymJMh/pcAu56gF7lo50D?=
 =?us-ascii?Q?aM6clZsQLiYHoBvUQZZQyhWJfxi/L8QfZEie1moqNWNfSe/7XEDa5NXQrO8Y?=
 =?us-ascii?Q?TZDnx2Vh7s0usx7FzcEVJDf0tE6xsoz5nLbENYh+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85be36d5-8fb4-4ee3-99db-08db7d3b3a4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:35:54.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlxJNgpx1E+VWbCQJohG+FFLirbfdYWEFQsOW63zotwVK9KgBSlV3EHbwR+0Eu22WS/iSwOb2kMRFaR5wbdKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data->system.parm2 typo.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 sound/core/seq/seq_ump_convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index eb1d86ff6..7cc84e137 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -714,7 +714,7 @@ static int system_2p_ev_to_ump_midi1(const struct snd_seq_event *event,
 {
 	data->system.status = status;
 	data->system.parm1 = (event->data.control.value >> 7) & 0x7f;
-	data->system.parm1 = event->data.control.value & 0x7f;
+	data->system.parm2 = event->data.control.value & 0x7f;
 	return 1;
 }
 
-- 
2.39.0

