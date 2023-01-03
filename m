Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799CC65BB1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjACHQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjACHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:16:33 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9751E9FEF;
        Mon,  2 Jan 2023 23:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OifeMZJv2Wrarp3sVYt2qoqewd/NNyU4tqZR06yW+Ktnoan/XnebD0+8BkgN0AK4q0FtgFgaru8yJr0+OAcSCbAIqAlqWu3vBTHY8juC3OQcfusmI3CbZ4jpa9ZUdyF1T94LO2r5n6chGlIUic+MG53uEENHZCRd8+K8GyIOJJVrP4JgS0zoNtoNHxr7L+/czKgHRpya/+40pTRpx6Y4M+SIwb24AvP7Uvty09Yfk0529U8JjuCP257cZCPekYDAkeCRV1s6xcEBRsRl/pBYKZFvKt4y/2rwLCWDumrdg68B71yz/SWJGBon0eFfJsGnLDHYitJrs4w+otbVEfzeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbpI+qaKR5rhVAxXuimNt0NGEg1+MxeOhCO0hO49VpY=;
 b=oQzG1ZDQF1/V0kF8LtLdft27cGBv+wxWbRT3yoIEgZh8S2akMPZX7yoxSqEa+tU2N0UuMt8sVjAhKJxf3s948VAgI97iapqYw+aw7uBf53CVeJDO/oul6L0qfX9o6LNvsyRlmZYumA3pe51nuhB0lFKxXhSDgmjiVKIN2bL9zzBaXYs/hOxnjukV/HNjAdkthsJ5ZocHzpnkV4mpeHnY0yjQ8ckU3p5H8TnCglPq60EmJJWZtaC96nwnDpODXMwSa0DyxtEqG+EkDnqCe0nRjPfqUiQjUT7LcYiu6SfcRMuWFaNs58BvUQJMJGCjvEh4uEFqO2z6uLJloJVRbfsolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbpI+qaKR5rhVAxXuimNt0NGEg1+MxeOhCO0hO49VpY=;
 b=MmJLk2mWxBXaSp4yUb9NxlbHrKtymd9ITGnraQNq3p4VQYcX2yPnpBTg5FW3hHQg9u6mMBd0W/OhUOI4TgvkBLqZ75xLu/7Wo2a93IPNVg8l65ns/VC7gPzzklZUUCnwxBzkhBkojD3QRZsVPE7D7JBA8TdCJkRQo3HwOTaazEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 07:16:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 07:16:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] media: mediatek: vcodec: adapt headers only flag for V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
Date:   Tue,  3 Jan 2023 15:15:51 +0800
Message-Id: <20230103071551.17775-3-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230103071551.17775-1-ming.qian@nxp.com>
References: <20230103071551.17775-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9df800-3ce5-442f-7a3a-08daed5a6f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11tCR0zJHbzd2vMhtLOrBh68vHBSQ+agHDMzp6hkOhfVLPDtZB+gWM3UG7fpid03KEIqt6Cy+YOIebxUCS1wrA0/q2/OB91bqTCICwbv9OFjLCcLZ1w0IeW9Sm7qLlEMexOhwCp34vE2ESKOjMCO4t8rE+KiMXlPtFscm/mAd2uMXThNHczKO7iM37CmunHkqX180yl4OMnyJy1erupM1s5LwdQ85CqiwewlRqZDzd/ftzLcr4fCadQi15u8z/4kMOOQCRO4agLMZQI1ayU3vxwt91HhVHEPt6gr68I0c7O+/IILa9+boF78w/CPXGxo7mBdoagdVTf1fQi5qEs+xK9V6pV8QHAED++m8SeRhGX6V+2qYSh7SHMFw1fd4wK1T7+BzHYez1FJGWSs1Q6gNAvUXEHfiOTaTeNz+F7isygvrrYULkjo0Awkc97Ktb5ULDAfGm61+2vbJkNHImJWXIJXQorTqR0mcPMnusf+W4PkeVuQdZOFSW069lUx9qNicewIZ6FY97+++3Ch/wnA6amEzlLBI479210nAsyY2S/WyTAruXdnJLqFuR1UVbUSIfo7oEQ/SEYXzWsBnHY8HjzdvofwYq1mLcLE2RksTOklUr0NyWSZoBXOt1NT0VgXpHCheUgtM7f3qV0OaTApXul/tIKnHAyf8IdxLFO1hTfgJt0pGMz1OpXkFxUfJ2U9blif+LYlxR/TwCiQ4Krv597mlOeEfj4oTIrByGK0iKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6666004)(6512007)(26005)(52116002)(186003)(1076003)(2616005)(6486002)(6506007)(478600001)(66946007)(8676002)(4326008)(66556008)(8936002)(41300700001)(66476007)(4744005)(7416002)(5660300002)(2906002)(44832011)(38100700002)(38350700002)(86362001)(316002)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuUhikoxNnEFUyZLezezmD8IpUw8WkTZy/pD0u1AcuYRYLvTEoNkDNMdllM4?=
 =?us-ascii?Q?+z1NcuElp1SQ0mY6gPRxoGSx/JnvQ2XLXvObdvQgw2Xu6eRS3uhtdCWEx025?=
 =?us-ascii?Q?bpN7nZ0KsQwBtQ9UwMT4Kjk+Ybx2YinZiEYb//TNkwmoCZWQBEhWpGOiicne?=
 =?us-ascii?Q?hK6MgWpKCWMXbHU8xsjhEDRIYg73Qd9vpiK/lSR0HrJmx58O43wikRUeFV8m?=
 =?us-ascii?Q?vnO0mmGwYAv1lHGi9d3cC5paYeakYiDEm6lupNZdSgfPxu873lfWhvmdQ1jg?=
 =?us-ascii?Q?xYqY3zg6A+DCcRpLWiORa3BvskJNMpr8AzV6xvLCEUlIDOh59cSMlCDNgzjz?=
 =?us-ascii?Q?NV/x5ORCwHv1CIw30xLuv6Bv2da4WwgxqzpFrKX1/jRcVjxSxRoJ4G8M9wTl?=
 =?us-ascii?Q?AgINOmfDcYnaEvaVPmcixrKIYOKo7wAwThuIz3jrW0q/Ab7e7n1R9xd3C0ry?=
 =?us-ascii?Q?6X0OWTFiFjq0pEAVA195vlX6DVqd5UyGTePWc3VmKLhjjygBkZ8VU2Y8g8RW?=
 =?us-ascii?Q?3AkztLei+VOPQ6CoyEqL7SE4HNyGBo61D2qfCy3Q91VrrvDcKoQz/Jh/9qPw?=
 =?us-ascii?Q?Exr3tLLrCjg74FFDEl2Dsaq8rMICvdS7c0EipmRcIA1u3hMcoE1r3qn7cmv5?=
 =?us-ascii?Q?hiVPKBc26O5X9b8hyiNpmKSn8lTxaz1J/kzbgqKdsN4QfxDPQE94nQJZHqZe?=
 =?us-ascii?Q?RhKQxp96o79sD51sKTM4tS7/QIQoLt3zEgey3DVq2KmoXbFvNX/tkuT++blo?=
 =?us-ascii?Q?07QCq/62/UEC6ZGG5J08+opYoKNj3wLzXsNxhaarQGFKr4n0C8QcTuhyGio/?=
 =?us-ascii?Q?Bd9cR3HV7y5L5FyTgID/Azhd+t5im6f3eXcNwjd7+2ev0cJ1ioqK93UczQBt?=
 =?us-ascii?Q?rWwpDxP6AkYoma7QB0ARhxAvhn3kXPbkabmIhQcfIVLfUHz0Hty8hxpVvqEx?=
 =?us-ascii?Q?HyM1kze74OTWE460jjpoUKCQ0NajDja8SqfpAVw72iSvVzeohYbIfNTQ/UPQ?=
 =?us-ascii?Q?7DeoCXk4lIDmPZ5wQEtAbcArFU4pXPDcMvLUXZNa0BEnY62wr8d4wWQQgCBX?=
 =?us-ascii?Q?rsHzPwW75J5w8niOdhsBHvMmkA8RrAFYAMutfkbrlOIbSQ5jnioaBobT6e6T?=
 =?us-ascii?Q?mHz96YUq1VqZOwPSVUiN/Vzudch+xILXMxVA9klhNhvKWnKGJt+EFl+MeQgV?=
 =?us-ascii?Q?JCoKMlZuIV0HgSBjESeiCDXvGaeyTBqKBFuR/1s3b7ATcCoz2ZabK9A2qjEs?=
 =?us-ascii?Q?NVaaWLoIvKzjW6J4fW3W+IDf4a2mjjKzx7WYj+AYFg9fQBlqR5tEJ3Qrk/Vk?=
 =?us-ascii?Q?0OBNUTW3TEYb4jG5nUfSfTzCHzxtukIS4xa/4u3IA/ZPnEQktOM/I0B60EAt?=
 =?us-ascii?Q?bFIJ6j4VH5P8GS+zrfbyL503c6pglfahoM3t9tpYMzMgTCWUv/0zebkK5IGZ?=
 =?us-ascii?Q?bUfufJCC7WWpjWDOovZAMzugwFtQkCrwvK7BKKFWRU4cywKabJUOTXZt3ezo?=
 =?us-ascii?Q?nVLU2WzwrpQpC+ha00wIpUdLDrryHtXmS4pELihkulTqcdblOvk/5ye/lB95?=
 =?us-ascii?Q?hHf4xNZcO81LL2KI+lTHfwYdWq4SqtEDt5vcaPG8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9df800-3ce5-442f-7a3a-08daed5a6f40
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 07:16:29.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FyAdfU93kMWr4kfJwL8sjHO6yONPSsFo+aMkdL2HMkranUywpdz0j6azkxxdICIy+PJ8bsOgbReTgGipUHU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE is chosen,
the first buffer only contains stream header,
so apply the flag V4L2_BUF_FLAG_HEADERS_ONLY

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index d65800a3b89d..0563abceb858 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -1090,6 +1090,7 @@ static int mtk_venc_encode_header(void *priv)
 
 	ctx->state = MTK_STATE_HEADER;
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_result.bs_size);
+	dst_buf->flags |= V4L2_BUF_FLAG_HEADERS_ONLY;
 	v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
 
 	return 0;
-- 
2.38.1

