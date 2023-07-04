Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29A0746833
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGDEBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDEB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:01:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F18BD;
        Mon,  3 Jul 2023 21:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRLCS80FmZ41R/YL/Qh4JKzgNvRpMe2l0H+4Tmaxh19MQPLJfnRZXkN+foCHBQI43sqvTNZSj0rh64FI7Z7BDwFUT0dLQ6LFufLwJ3y50RdKvPZERgD4yHmF9D2/zwyo+uUOcmydUI6+vKP9sGYaYkLZnCBrsCV/S9wjMkDRrogHhHETDw1jhBJgNS35BnEXJijnWqyJxKtbIoQy9H0OQ+F++1YMLeAuSFylh4eh6yMXyNrLnCMoXq+Axn+dNvfV6iUZG12xUsu5P1XGykFQsygkpxbtS2tH30G1w2HgJmrR61ojFprXkMlY8d6cchqKRKeZDmWhmXPYZKtsfL89cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsMM36UqzhKEjKgE2pwo9jHkKFQeeJqCCp6Gh6EQJDg=;
 b=MOgpWnxITQAcDC6Q1ycMRN2vFLiBuUvMMYkV59YPmmA1qjpgN4axE8DwMKyX04BU0ril4PxQM5LdzjeUUZZRzy5fiRHBWaMtxG/iT+yaD2SzpJksOFW932DUa+oEHLZo6b0INdM6qoR3DvFgbe4X2I1bgvhgbD8sUs6Ux4axzHXDxLy5QWexzhWtmy0gfqGS3MbNMYnTRW3QJxKsvEtsDtSRvRteMs/6UtnvVujJf2FBGq2jMxR8xLfo6qpQKJp3i9RP6iwJk3Fzba51FYy/6ip5EIC4VUj0IidXFekmGH0B6hBDtUS56Rbaq+6ZZwW5E0KR3wvnD73DhDI4XPy+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsMM36UqzhKEjKgE2pwo9jHkKFQeeJqCCp6Gh6EQJDg=;
 b=NMx2X7UpYvvAJ5/sJtLsAp99ZU4crk8Yy4cKN0E9OLP052ni1qpTzg/o8cGZNW/PmBwVI9xNKC9iADk0co+HrFmyzDlxTej+zK5BLCIFOagXe6aUAQ7IfA7+/21kfHNe6lC8qt5rgYcL9u5RGjmnZV7M3XIqRYZEWXQtu+r397M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH3PR03MB7385.namprd03.prod.outlook.com (2603:10b6:610:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:01:24 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:01:24 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, nicolas@ndufresne.ca
Subject: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run without buf
Date:   Tue,  4 Jul 2023 12:00:37 +0800
Message-ID: <20230704040044.681850-2-randy.li@synaptics.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704040044.681850-1-randy.li@synaptics.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH3PR03MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a6df36-b3a4-467e-659c-08db7c435541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cijH728WfPOr+C25UlKIftPHRp14FOtQi//uGPqyT/DG6+6czj+u/40b38tuR0ARBuc4e8uQPJjsqD8X5KxvYqA2BJOytcalch8fCs8U+FpOHh0Q8oyVev6SoerfTwPwy3nyFbcG2RIgK576lKZ2oxqBSfzFWW/AHnDVc8mMhqNWjw63mLnSG0eqW4T5QODgbqEPq395Ne5ly0pos1nlJyoi0I42AlKcD6JbZYgDq95hFH6fsn6putRmQWN/Agnb62GArnzcScbVhTP8sCsZc2syvJ6IHmNylYRan240NjoTSoo0iBV1zXTkmq4m9szgMWylF9MrvfuX6qMZtx+Sd6tau8GtiMeXYUi8bJ44dcS3YYwYQbt5V/j0PpdSAF3AbIsz7ywrU0uH3KHXjc+X8e/3Cgz1MJtUaa9pNAGUcGoOo/ZEGboeiJcxIOtcPVilD7UWYZnxIQB4C2BCNMQK3OzVuMlyupW0GBrCavn328V1Fjb1LL56TASdJ5i4nutXOGU+0LJYMW3Yw0EGEjQTaREruS/rSg20OfR1abBOMZmX+ub3ytPXmLIvVtI75CIB6GMqof6ifUrYtcHMPkm0+kHq5xQ80KtAkhdDKSUfI3VheJet88eE4w2uSJ8Nq1hK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(38100700002)(6666004)(38350700002)(52116002)(2616005)(83380400001)(6506007)(26005)(186003)(1076003)(6512007)(86362001)(6486002)(478600001)(316002)(2906002)(36756003)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(6916009)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S9c2e0EKXRY/Iw5cgaTyKy18ftWo2zlqdDbVyfz3M8YqfVtdVBBfSmwmeH8/?=
 =?us-ascii?Q?HPpkeLx9QrNfVpMQleixWE93dpmAGUDchETwh0xcuww7cmERmebmZoV5zzYh?=
 =?us-ascii?Q?UcRVMidJryUKxKAD/vvMQvN7XWQxcxFM2mkv6nuZaB/JaG3ICmTqzrLpQKp1?=
 =?us-ascii?Q?Csxgu/LYFiqpjDBOd6c5k+Tmgitr+zbjKT+qhwVYuvlhqdXRyr5MXzdjP6LV?=
 =?us-ascii?Q?XG/FCIQ/SVQkuFgsTkn/tM5ktXB99nVI/n5w0qyFbTbQwMKo3Sv3SUhcja/s?=
 =?us-ascii?Q?6rYYxC/bIDAJrVsQXgASs++zjG5BZ6OtJdgXCNCdLresSfVc8+MfIwW3fMo/?=
 =?us-ascii?Q?G+KIVHs4dMvysyhJTBs45tZr0LYKLBwL9kvzaQnd3CiEdZTUiK2XnEO+4SmX?=
 =?us-ascii?Q?UpAECqQYMR2XJ1KQvgiF07W9Je2ySj+fmcKAMH5hSwCb2zu94HPeePnZpq3i?=
 =?us-ascii?Q?RcwJUBbFGSNQZiKnKIrB4CuWB3+1S6Okpm9MVe7vJxSWnCwFiiQpkH9shRqt?=
 =?us-ascii?Q?FF1oy1NYT3z07RjliEX2Tw+EWRyqc92zjxpvr7fHICjjzxW3uGk6S9+GJsZG?=
 =?us-ascii?Q?J/8N9J4cISOjuYIl6Hgbc7qilgJsDHv/7P8xKUNzPwqJZkb/rarlq+LhFMeS?=
 =?us-ascii?Q?aVTT2nXCaRTJ4mPG9b+6mSAmCiMPuoK0c5APfO6iPuIM9enVWW+EYOKK/zPJ?=
 =?us-ascii?Q?TznDHMmupzJUkEoWBvGLc6iQAr5AZ3+OnfgHpruXDBaQNKpwWiRR7+LjVHjq?=
 =?us-ascii?Q?hDW82rAcbwapY/RZum3EKwdtv8H4tnHwT7GVPgMYEYGG3MCbrHv/Oj0Cm+6U?=
 =?us-ascii?Q?jMt3Z/T690uX6qAK8bwXX/uC+GgyFTZlKRfbSUdBAPw0zctNYGfIh05rRfqZ?=
 =?us-ascii?Q?ttJ0bOIfPVSZ5IBCN9r0Ls0qRxLU1Vf7brNphZtTKDC/AvgaoRy987BmecQ/?=
 =?us-ascii?Q?XLPY2r6PL4Atfb1A/OXyYeQY/LCdWXZY+bENZxwMaPgaCbiAFH1YhjOiVdev?=
 =?us-ascii?Q?4XJDHqTVG5auZsIRkUJP0nRJFL8klhbwAPlZUvfJU9xg0kxpKlvEHcdIn++o?=
 =?us-ascii?Q?3by2lwbNKiRp+Ku+fjNbUrt04VjPsFgeso641lz8AhnYEN67t9TkaxmF3saS?=
 =?us-ascii?Q?MsTfS/F7CCTPn0bYZJOhxGu7R9Dv64r7xOvfOmWfij9KPHu7ROLCy09xb7Wl?=
 =?us-ascii?Q?hxAzxgr0FhmKF67Epiim5/NhbentMT3qnIL3inL+15QVS9Rk20hPkUOJxeW2?=
 =?us-ascii?Q?JCM+Z1Jkg6qPeHdBIs7G9rkbWFI8wW8ZhVKkJvC9lvzPs7usspR1ChWMr8SF?=
 =?us-ascii?Q?J/UxUyhBFFle9p/9qiF/l/Mspy3hyyy75qUrXJ46DwyeYJLWh4APBLD8GkAg?=
 =?us-ascii?Q?jne8jZzk7wTh6pX95Ee37r8YKUgPKn3wvxJXZHeGvD7Zfn63JNuViXt/F832?=
 =?us-ascii?Q?DC62QajHO6kuBzpwlO5dFUPEzXujw6PQHIkTsUj29Cc3JOlGprNMnU6IQbLB?=
 =?us-ascii?Q?gIB8kpljWqN32fG8cyxH9u6d2wJ4pFkdlpMrDTo73T9gTFNNo5cc9nc74l3s?=
 =?us-ascii?Q?chN/+Ngurww93zBTcV3nRrq8Csd+CqkI3K0DUJCY?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a6df36-b3a4-467e-659c-08db7c435541
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:01:24.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcO32NesmgHI7SYnS8QSsuPZVTl1cE2JgonlTCww6ZGFWmH/RcorOSFd+Oe6Z9W3RpvqmwZiwPFbgSnUNTmhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7385
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Li <ayaka@soulik.info>

For the decoder supports Dynamic Resolution Change,
we don't need to allocate any CAPTURE or graphics buffer
for them at inital CAPTURE setup step.

We need to make the device run or we can't get those
metadata.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 0cc30397fbad..c771aba42015 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 
 	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
 
-	if (!m2m_ctx->out_q_ctx.q.streaming
-	    || !m2m_ctx->cap_q_ctx.q.streaming) {
+	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
+	    || !(m2m_ctx->cap_q_ctx.q.streaming
+		 || m2m_ctx->cap_q_ctx.buffered)) {
 		dprintk("Streaming needs to be on for both queues\n");
 		return;
 	}
-- 
2.17.1

