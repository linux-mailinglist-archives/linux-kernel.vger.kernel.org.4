Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9966E19E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDNB4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDNB4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:56:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA87422B;
        Thu, 13 Apr 2023 18:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi6yQXb0nTcbj+PBbLn21UJbLYQX0AlP+plWNQ6+lm1AllmDsdlx3mT5P5w+K+TIrEWurUTRC02e7h6CpI2qEO0tWbGSaFyQcD8lsqI9yiRg1nJSGaK4xwMS5+df6YlFWb98mamtY9tJkbBw3y0dAe8j8HbaUthS1zN0xKgTtFVf+35azSf0UYp2FqNUUXLIc4C9jLXfAsQTHAr8fcJns2OgItIhHdm/obzcp0eHV8w4pT6KpybexIClcoPcWJ1n95Fsxrlm0C+a+sZImJY3J1HyfNT2NfR5Hu8d923HWGxqayKLM2z3z6MwRD+nGtVLKyg8UIWU6fYI79sh5bdm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnsh4KseqxEHcfXw3FZN7Kh1AFr9UB2RR/wdGTQrsuE=;
 b=mKeRUYpyE5tuNs+/ASlwyTYnce49CE2H+l4wTookBLVK/VFiRzvfaDiuMc2seU34tKQtB5LYBMPhzzx3KmZPzU6d3Gpl50LQiG9aDt0hsT3tvOP785oQa6JLihZ0T70qfyQxPxKucF2J6YK+6FzSyvY52ff7i9JyfLCFWB5X0cYDpbpwwY91eXIcoEmCuLQRNlAdKXFqe8BP1KPLK8YXSKAbxR/uKgE5I7iMFptH8dVgmQPKX3XBfNfS8JEd7DMRG4pqV/GolqVWpoFu9YndV0eRMMQle/h3wsbDyaoGfqZQm8TkXmY/f9P0E8Wv+ohpLNtOv1R7PriMX+ELiDTQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnsh4KseqxEHcfXw3FZN7Kh1AFr9UB2RR/wdGTQrsuE=;
 b=WvnWTpSmXTVCGXApYn9yLuWsn1aXzGjpWEh9/ceiKSq48ba1gi6malyO0122bhxjlKSNZD2JDLk/wWhBctAlcW+R+GBH73xjuHmhAjgBLimww8agxnrqn6AH/E2SPJ4rq6UN/r73aBmxMnGPyy9w23omFSkxaKOw/HKTqS4T1gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by PA4PR04MB9342.eurprd04.prod.outlook.com (2603:10a6:102:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 01:56:12 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::632b:b1a2:25a1:d364]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::632b:b1a2:25a1:d364%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 01:56:12 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: drop repeated codec data for vc1g format
Date:   Fri, 14 Apr 2023 09:55:43 +0800
Message-Id: <20230414015543.6580-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414015543.6580-1-ming.qian@nxp.com>
References: <20230414015543.6580-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DB8PR04MB6346.eurprd04.prod.outlook.com
 (2603:10a6:10:10c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6346:EE_|PA4PR04MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 983b9f94-7382-4d6e-6d8c-08db3c8b6c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRH+Fb6BaPyIEcQ551Y6xzTzWu7GVA6c1+S11wHnGf54yDMQwWa1L2CKYe8sccYjPYuh7SQEidlJ8520XQR4Umcv1k9KYJp7f3hk7qCeq5EiIFksCXixiYtbRIzugI21L6MeA02+y7u/6Xp233quxcexsUFCMyrbVNsYif/CKPnWWhU9w0DO3Ab+586FmOlp+xfzRKHY9OAgBPMXtI1NauT8Fq3NehRI2kDV6AUnJwg0ZaqxnTfpPWx/rdwXxqIQOnDPNgApifg0VozvyZIR6azeUwWTA7scirlvq6xBI8ovwlLGlTuoJxXmwBZm+yftm9jW71z+xy5DKLNqg0mUB8jWisSbbgvkHcilzYuf0YW3s8r4PcIQI88OEB4wTbTapt3UmH6gMPdpgAjTy3Rlm6BVbbF3E0QToxbxtiqXIu629gV5xT0iyo4zW27VaG4fARQHv6asl6vlnb7U5EzGhID7xwMKrpRGUNkcDyGXFuv+rhwxGwcs53fItdFY4Drkf+Kiounf4jXKNkSN9v3KUEpLXbLBnr3IRpQnRfGlfckV495YBvJAB/hO5PB7X67se4WIb38Ct2mim6Y9pc5DNNhbP3pmQGCD6fPojYSYrz7q0dKguvskyB3o3iJAXtYjruMNMNzIPYKXgUnFR3hcjXxnmSVnauJikO8OPIia238=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(478600001)(6512007)(52116002)(186003)(26005)(5660300002)(44832011)(6506007)(1076003)(2906002)(316002)(6666004)(4326008)(6486002)(66476007)(66946007)(66556008)(8676002)(8936002)(41300700001)(7416002)(83380400001)(38350700002)(36756003)(2616005)(38100700002)(86362001)(32563001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Zp/Wn5Rj33p/LePTPrh0yDX/wpLZw5G3bbGOxp9hBx9RHtSVVTfRrE3Cw0s?=
 =?us-ascii?Q?meF9kt1kUGl2PyRbTjCsyurAy+1pruQMIhNZp5JbbrdYjaddC5AhjVbXj3Ot?=
 =?us-ascii?Q?ebD4mmAIxnyL9XLq4u1pd5YZIGsLexw7/ijkdQOpX+VsYY4zq4gxwae7BVoX?=
 =?us-ascii?Q?mXzXi2tt2jbDzOPx3YESpToqAmxJhgP4xQk1M27Fias88F/sYn0Y5p9wb2+B?=
 =?us-ascii?Q?g30rZ7pcSRCysbtniioR8iv6HnTyg9QW33aIKHpQpvkQF0nqdq4BIpMKUeyo?=
 =?us-ascii?Q?tZltGD8glyYfuPHDK0pgUMjyQMFS0bHg25HpDbGxrq+ZyO6biyFMU8u+ksBt?=
 =?us-ascii?Q?dNILP416oVnFX7ysR7utqMoJadLzS5a4GIAnVI7iJ3H7jy60SkfkzpuhO9K1?=
 =?us-ascii?Q?DdxZBqIigqb3i56daHMbvCj79+hEnU4hY0FrWaJOCeO3j/WP9MiLzCdNOx8C?=
 =?us-ascii?Q?s83SJlgLm2EfFDhJG7eCzoBs6QC0INHsVRQz5ehfngJZHLcNX68mNI739GBF?=
 =?us-ascii?Q?sq/vLG+lz+iL4pSZbxcu1yzc53h3PQ85PiAaEQomIGbAGveudDZDcWjeTwFm?=
 =?us-ascii?Q?oLDqqbxayIRR6NBmXWUeT/pmpAaM52fm+J1XxAWndzx5RrQxVovUQqMoatKI?=
 =?us-ascii?Q?D/zSOE6AcDq8k2AFb6l2TNCQJjEtJTMaqTgZM5uhu2SN6gXNImuX2fUkl2C4?=
 =?us-ascii?Q?NoJKqqHiyhOaDbHAy1VyDo6b06pSP8FTdICOvf2pIDQFjOSm5qM9TfTCj28N?=
 =?us-ascii?Q?v4+HTxM2Z6zjcBxR0dwOK5sw4t2R4VdVgh41o2fiMD5wZWkBlyHXE75ECZtL?=
 =?us-ascii?Q?pJV2iWp3Fucctu7Gq6JU8Serd2gqx4Z0uVkSlki8E1y3hPfZnnZqMZ2zQDMA?=
 =?us-ascii?Q?hfkUpn4brw5Pf0s4QtU3aBCv+cqgqOw+EdtmT2owUk7s0bHqQVJ5GlyWgOrT?=
 =?us-ascii?Q?KvjG2edypofonMcqi1xhHIlJ1VlQknLfULeSC+GuM0vKvzydWm0LfnSphKs8?=
 =?us-ascii?Q?cT1yApQdRUOOBbUu0R6WwnjjGNzSIl2/i8Gyi3jXSYcuxwmUE/8LruIJLqS7?=
 =?us-ascii?Q?giGX5aIrtcZglQjY/XyyENZAVicRmeejTFcAZMHCtptw8i1+AGjbsieX5t/K?=
 =?us-ascii?Q?k40iyJNPxpdB1xtHXTrcKKI6KDQVTRe+QHe0N6ktwd4dZvqM4l+hbspECegY?=
 =?us-ascii?Q?QYuL3rKHYwLmqa2+euigjztrao+h4U6kklZDReCMcwO6Fw8tJZEw4XkYGQ0X?=
 =?us-ascii?Q?Q7ZJIazc2a/oNfyvgvIjc0DzsZGu2h+EYGO9eyG0bym0Z+x91LA8kEg8dCxE?=
 =?us-ascii?Q?0g30wo2yzU6bjN/j6gsj7Mti5GVvHNrE3hASZLQCzH8MRha9t2ucKoolc6xk?=
 =?us-ascii?Q?xXSq2+1GyJr5HCxzgieXmzgkozbPWBYF/7X5taMmyAd97PxF/jZEmLh94rDB?=
 =?us-ascii?Q?w0a1C3nMHEfZ7guQhorm0PDlHBwFrB7ixkHQUXf8gQglEcic+Vtm31ilSb7x?=
 =?us-ascii?Q?TingUf7FmQX7e1tYSMMtXb4rsOIqk7QF4Mk69TZbDPYsWo5bcCPzVVfMnZKJ?=
 =?us-ascii?Q?1N1eyALQbb7TrER0jKj63rigZxGMoE7anmXcjUaI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983b9f94-7382-4d6e-6d8c-08db3c8b6c68
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:56:12.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBTVlkROdYGhpezfNs6E+w8vcbkk9Wmk0QBfCE9alte9qcJkkl4KIqslNeln7fZy7dpkhmTaUSk8XRGlfYzkiw==
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

For format V4L2_PIX_FMT_VC1_ANNEX_G,
the separate codec data is required only once.
The repeated codec data may introduce some decoding error.
so drop the repeated codec data.

It's amphion vpu's limitation

Fixes: e670f5d672ef ("media: amphion: only insert the first sequence startcode for vc1l format")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Tested-by: xiahong.bao <xiahong.bao@nxp.com>
---
 drivers/media/platform/amphion/vpu_malone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index e96994437429..c1d6606ad7e5 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1313,6 +1313,15 @@ static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_i
 	return sizeof(hdr);
 }
 
+static int vpu_malone_insert_scode_vc1_g_seq(struct malone_scode_t *scode)
+{
+	if (!scode->inst->total_input_count)
+		return 0;
+	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
+		scode->need_data = 0;
+	return 0;
+}
+
 static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 {
 	struct vb2_v4l2_buffer *vbuf;
@@ -1460,6 +1469,7 @@ static const struct malone_scode_handler scode_handlers[] = {
 	},
 	{
 		.pixelformat = V4L2_PIX_FMT_VC1_ANNEX_G,
+		.insert_scode_seq = vpu_malone_insert_scode_vc1_g_seq,
 		.insert_scode_pic = vpu_malone_insert_scode_vc1_g_pic,
 	},
 	{
-- 
2.38.1

