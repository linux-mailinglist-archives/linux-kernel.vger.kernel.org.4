Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD464E825
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLPIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:30:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F91571C;
        Fri, 16 Dec 2022 00:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIz69qFszSBFOlQ+AnM4br5QUK/ikJjStKvZGPp0FgGOycUDbwn6uSRQJBeB1NskhyICDqehRUBkh3ASWQRoqsBBX4ZTUtWkllJZNZo/qZMXozJbWPLdSKnKF6YL2JZuJMPH2EIJmtmZD41y2bkMVN87hF79biow+tSXOOQUNJr3eJc/J/IJz7BWwi2XpY+jg3SZGZ+0UmFIXoF0cEl1bi/P0mSxElOMBGeZGVJTPUyfUBVdPiQbQchJkbsmumIes7UD3Ov4Ipl6fFtoEfP9XuqiAe0TAvouypSS22JaYWsbPOUECh7Gy100Awf/CY2hZOoB3MJBZxCWeUUmbuG6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTAhBtLju44lgS78VMzrvhKzMYc8udsQPn5ib+YzXkw=;
 b=JWm4KaCJfwyYSS4voqpAjBYHgn0QiakPGdz6DkqvmTbEVWJOMVRo144dI5VfYkuPjEwnzBwOdkDASOVefCRAXyuVABnCUnOkwIcoObhGK50xdGxccZWvtrH32MMMzOH+qzVGkkwzvU6KHI0BP2NdY4JQ4PMssx2w1PKd1ht3D+0KN8UBa6r0bcLpriqYGANT+wfTPDayEm5wiq1w2DiKI90L4eCo9cnIZ0wZqK77c/G5u7W2uiQ3wpTx0qGHEPS6XEB+NnmHlPxetdzm1i8jm7AFLANGyxrPPJLMmkhiLbt1EgAjiQ52/hDYcF0gQITjuNpwLNDHjQlA72FkTqyHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTAhBtLju44lgS78VMzrvhKzMYc8udsQPn5ib+YzXkw=;
 b=r6TKzdMYLh7kUyLxQBgbcVc2OA4auuU45Q5knntvNZzA4/x1V3zaNGe59YXP6mpstdJ64nyh51vof+vPi5BgJyz1JAyQ6+nZUSiIDNLi5iwK6gD1gJLxfNcnpNiwpKuT4XaOMDzBs3m6bbmjX8LC+rd0mcgQ3Pfge4ShdrZ9q7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 08:30:50 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5880.021; Fri, 16 Dec 2022
 08:30:50 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: v4l2-jpeg: correct the skip count in jpeg_parse_app14_data
Date:   Fri, 16 Dec 2022 16:30:33 +0800
Message-Id: <20221216083033.7446-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c7ff79-dd8b-450b-4d11-08dadf3fd652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvuM6pff9NOcZiq+NGOcYCLuxnOV3+mgvTB2vQ5IcmhX+3f3C/2otArJpgCa8ZJpbVWj6f3sFW9PCGZ2QSMLeOiQOSFegRLQESVWhufbpXz7VeFtoxGAm96BAkC1jikCVDPMEj87eS0rIATe+Dfii2gS7ZyeqcwSeOpoweJEb5EXk0pdVHmVhb/Wn/pGZQOnVOOZ9noDS9tDNp8qHYQ/oEn0P58kChS0tjo1S8omOIUfCUo5IkMcHkQTHmvOdyc+1B5dOYuR1bzwPNYlLh+zdP9PiX063EO3hTAuEsh9/rdqhuiUjRxnkcLPWi8oZVdTiSv13MI+umxlTE7RtOMP9Ih6KneKWpI+v4Oqv6YjT3WOao1InF0VRiQh91nRmSVtRKIJaRE+u0Gl9/bhSrK+36duO4DTBqKjq4IDa2gk+3fzIefR6CUvsMER7WLIeRlm+Whn6ZcwwdSQKlqsdcYezSC2lIeC11Dkfly2b6Y07R3Wr4RzV2LUzH1n4IrtjttqKbo5Ojg0ILW3CaBEfv1WwmViSfg5PWnbf0mGk8ZgxbBQFp1XDKHgBEDpQHWk1xoiyFJbSHNOHqMQwCPWv4eO6HwKczsl8q+yw1Z7EGJJjuauG9kGQWY+kfcX5+edV2PH/yw1LQ36E+gRWvrgBjOUf5jbX5LaifpaY7uEGkgbNelRK72GabdE7mtCrcDhJFQzYq5nQPX3qrrtY5OtF40Uaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(26005)(5660300002)(44832011)(6506007)(6486002)(6512007)(478600001)(6666004)(52116002)(316002)(186003)(2616005)(4326008)(8676002)(1076003)(83380400001)(8936002)(41300700001)(66946007)(66556008)(66476007)(36756003)(38350700002)(7416002)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8edhVkx5fuXiiTd3pgqJTo8SZExolszD/zNnpJ3AoFm+L3Qh8IY3LKBKGZGh?=
 =?us-ascii?Q?9IjmEG1t5xvjC8fDdEghn4hbzoBdAK+YGCdfPhY8NUs11HLc0zl23kl/oMnQ?=
 =?us-ascii?Q?eMHimVawu488O/oXJ/afzLbErKdoItr2ulS5tYKTDQR+h3YAIzIRd4hSuz9q?=
 =?us-ascii?Q?dAs6UYMWsyKiLs1cMy9OZb04jK+U6cOcrEADkTF5cPzkDnDoJRflU3rlAxx6?=
 =?us-ascii?Q?1JD3rttyOpXWPjlf/BgUqGuGz1YqbHWwFEzQ5OfCsuPq/w8svJ0gTrBBfx7/?=
 =?us-ascii?Q?ptPIWqqkr4cO+GEIlwsrNldQw5wq+Mzagilr6giHvXn8t7aNNsZmwn8fczLR?=
 =?us-ascii?Q?tKeNgpbprNiHqXDN8GBgsckSCOOM7qKbp4JFHwmiBi3Lex9DhbVCRcq3zWMf?=
 =?us-ascii?Q?X3i0qjEyax13cMeBFSL47c16LQ6Iiu9yNv1A9QfSQQErCWPU+bzSyJ6yrGlu?=
 =?us-ascii?Q?lt+SqlEfB4mikUE7YGtutYQlPNZuH5JJi/P/WcRbQSaRoHIPqGvj+ba4Mtwh?=
 =?us-ascii?Q?WMEbv2DRMPFaESFhRJAJ+lEMwXr6j3S8r8jRlPQLkBeRT4vQ3P5DeddjZgoZ?=
 =?us-ascii?Q?uDOgPFbG/PEG1jln2hxziMVPZaPP9rxdPMidQXdNMarcv79fm4xmmzja4QVC?=
 =?us-ascii?Q?0Ae+rb3Yc6Mgc7TAZEs5Eum0VLnNgQHF+P6m5o2I+hfFzTdbcGmjgepjZsap?=
 =?us-ascii?Q?bVdhb9haC8W+tRr8rJYnkJZX1u4nkiJiHiPAW2KB2eWBqNLNxprTrh7ZMo3h?=
 =?us-ascii?Q?+Bv0oFyjeEnzHnud0qMbNkzoN5LYVM8wfsCuDIQBLsGPYYCYHKKmjTZ7VciK?=
 =?us-ascii?Q?ey5ZuUZn2IwA+n6JrSlSowO0L+UsLU8lGv8gLBZd85mNtalIcrPLk6nKb9Vm?=
 =?us-ascii?Q?E3W3BtFgKqalennAqfbagUoob07uKsLqBRmix4Jii5t4dxHvwzCm6zn3nPgN?=
 =?us-ascii?Q?f6x6kR16BgdS7HAgWeRokqnEP2ncO+JlOxo1mk4E4styd3lhqMfC7GLu8xtF?=
 =?us-ascii?Q?/bTMEEy2Y1/B+uyuqT2+w/A3TapVt59ijRPgGWrQsLuG8LACmDgcYk97QvlL?=
 =?us-ascii?Q?YuhumZ83GfLfbgTQZxaUG2+8aWFA6sv/m3sEFcHhzYtH8UHyB8hldv+qex/p?=
 =?us-ascii?Q?3gMyFTVkz/z3dzH9GcA0qp6LPPc6+V/Nh2KCFaTcYV6maONPSw59ywnlxlSK?=
 =?us-ascii?Q?3D5AI8lXdPCI3d0kE4oxmsttSrpkCLmh2et6iIiDsQ6AwrzQaPzGBEgiM40K?=
 =?us-ascii?Q?lUKH3x24l2fTfCS50VhUCVtVizk/ROXdK7vuOKENYrhBPDiH18thXLx4N0mb?=
 =?us-ascii?Q?9Qu7ZQzvVKkqHdbC6ZDSQ9pdDdduQgfbRXD43C4hMI7d4pvNjrz4feZiFbzp?=
 =?us-ascii?Q?qrmKEtHaDPIcXs2jIlK7IxLYB6PZ4cNyz5iqWxq12yAin9WOR/sUCtDASs/D?=
 =?us-ascii?Q?01Q28puBNVcEILqqwyzKDP6YHqrHD4tb8xeIEDy3zNi9TQbfDvR9i9pLjxih?=
 =?us-ascii?Q?ie5zv9jqhhOhV9wt49z84LeautEIgJZC9C7utW4jXQndFCDgT7RBkNB4zSq7?=
 =?us-ascii?Q?Ass45ouc/A2JSpnUIxp3TRcapjG4FlQavASbcCBQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c7ff79-dd8b-450b-4d11-08dadf3fd652
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 08:30:50.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMW4+2UDO1frr5OyNXsj0qi0NRGQBg4OfEowlXzRgCNrIBDrEnrMErFGp8FVNME5W+GKVWwyVONU50yAz8jVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The curr pointer has advanced 14 bytes in jpeg_parse_app14_data.
1. jpeg_get_word_be(stream), it goes forward 2 bytes.
2. jpeg_skip(stream, 11), it goes forward 11 bytes.
3. jpeg_get_byte(stream), it goes forward 1 bytes.

so the remain bytes of this segment should be (lp - 2 - 11 - 1),
but not (lp - 2 - 11).

if driver skip 1 extra bytes, the following parsing may go wrong.

Fixes: b8035f7988a8 ("media: Add parsing for APP14 data segment in jpeg helpers")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/v4l2-core/v4l2-jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-jpeg.c b/drivers/media/v4l2-core/v4l2-jpeg.c
index c2513b775f6a..75c2af763d55 100644
--- a/drivers/media/v4l2-core/v4l2-jpeg.c
+++ b/drivers/media/v4l2-core/v4l2-jpeg.c
@@ -474,7 +474,7 @@ static int jpeg_parse_app14_data(struct jpeg_stream *stream,
 	*tf = ret;
 
 	/* skip the rest of the segment, this ensures at least it is complete */
-	skip = lp - 2 - 11;
+	skip = lp - 2 - 11 - 1;
 	return jpeg_skip(stream, skip);
 }
 
-- 
2.38.1

