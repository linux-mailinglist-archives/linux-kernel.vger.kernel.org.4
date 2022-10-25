Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E960C89C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJYJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiJYJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:45:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2065.outbound.protection.outlook.com [40.107.215.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0ED8ECE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxWFsGJX1oMUY81W2yR42tIKlv6l2sqkm4EKQW+YcUNGoJ5+OVvDf/nJslYII6TcJWw8SYhTG1FLCnCWqj0QeH97CwFo60279buoXaMSg4T+mgxxJZeRDScnISN3ffqxvyvHVF/rxbmd/gJkHEVPMbPUGqSN3OHszJecuv4Bd2U2o7X0LhLnaJRmw24diG+tTZs/kQKUAtcFRZF4S4oklADdiEPvkyZC/iVizIlUckaovXgLB8s43h4xjjr/Ah4exHIheNuHN1c43K3OofW9yrtiodTCUJ8imqoTgWQxBuRyaT4hheukBkQBXmBHRP/bwvSTtlQlkq+XMxlrDq7CmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eGU/XsMxjuJNUWGJXzbLOgaQ5GEFJ482dBFKE64vKI=;
 b=JYneApSxEPKutPWLdfhab6oLVvv6WkD38pofMWkdYd+6c2JpmH1wL9eFtYk5VJKtRZcKcrvPLVRdWuqGiXpex7XVW98qh14mFJrLG6W7+OX4GUbTTacifJt+XfH4uzQirmwM4YVE3giHUKkcwqil7uoMmNj6TwxDF3OqfMQkElC4Dpw3fh+CshF+zKXdPuy8nPFGAg4U5D7Ib59A8OQ1YkP05r6Ajw9+R9Ke8/yN8toR9BiSxJN3II9c2Rr9aQqOn93/ntRZP/SUhihjG1DkN7kWsKOqkDyHYKVJvtWUanbTHtJhqGiFfCZxpE6oybksSaIQmwxbpK/fzoTXJ98OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eGU/XsMxjuJNUWGJXzbLOgaQ5GEFJ482dBFKE64vKI=;
 b=rsym37EJly/T4Mr68NsB5E69ALoQD157lxTvdOS2gde3iqco2upYEeVWKa7p3gva79BBJ4AWNAGYllg9TrANtLI79TD4OReCEW3kWqRiuJ1CXgq8EJS77RK5dQC+o5TXmkANQFq3DsFw8uUb+IqACldzRhIHwt4p7aqU/f8hITk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5129.apcprd02.prod.outlook.com (2603:1096:4:15e::10)
 by SI2PR02MB5610.apcprd02.prod.outlook.com (2603:1096:4:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 09:44:50 +0000
Received: from SI2PR02MB5129.apcprd02.prod.outlook.com
 ([fe80::711d:e5bb:1951:139e]) by SI2PR02MB5129.apcprd02.prod.outlook.com
 ([fe80::711d:e5bb:1951:139e%9]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 09:44:50 +0000
From:   zhangdongdong <zhangdongdong1@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Dongdong Zhang <zhangdongdong1@oppo.com>
Subject: [PATCH v2] f2fs: fix normal discard process
Date:   Tue, 25 Oct 2022 17:40:36 +0800
Message-Id: <1666690836-388913-1-git-send-email-zhangdongdong1@oppo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To SI2PR02MB5129.apcprd02.prod.outlook.com
 (2603:1096:4:15e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5129:EE_|SI2PR02MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: b477eeab-1dd8-4fd8-b9ce-08dab66d8f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u8ETfCUUsdiFKp5iXvDqCyyXJ9CFjKz2dbFM5WVhANWfi2Cw70/j27x5PRub2u26pQeh2bNLWtHz78JnwDX0x2RntEMrphUzhYIJfK8EwqxqnAzHI0P6nWbomhrT5B9REC3k9eF0ICeFw976Knbyi425pMIT/5rrmmf+NMljndkzEaEJn1BEjKSEHSBBxNrkqm3e6ln87OCTbEqKQK5myVAP3AXpCIduBmMWQ7MyP8QJjvP9zI38qnaVn/yS7nBIDxKzrPjk9r4lKMmq+XJz/VGouvPWy7R52l1fCpUbCnz1JRw5a14v3Xp8Xzt3fV1OdSXopDHzYrR6x/21VhurwiX7IMFWJq7SOJWIYIwu+Xhh5jMSOUOBjDoA0e2x3RhZcGWdSCDrGGcx/XCweNfSM8HQ59kdBoNOZskizQYGOkoL1jll69IgEUw5v6QTd3M12cqbBzr3U/kNkq5CXt96WgtggDpNrvnTdeLBCSiQAxENnTd60fhhzu0ZsjidW60JvwBJ+boxA7+qCkZbwVkrH12ieL45wKey8cuxiouMILXBpsWyouumXayaAiH25WzufxWA6ayiq9H964/F4INdnRb/YMY89tzqT7Ta3d/8eHM/voZexHoBg/pN7w06kqQJBShajic8BpTYisPjMo9dKnGSQZM/Vg5Wy3o1d9N/nCJ9at3Sl8Y5PHOvQB5OxiSju/6guhhnD3arWnybzATRXykyjkVacIY24N7bFwcnpRpKD91wWHexspToW2DqtaPmXQz8CM/IGECtMi1/1D1bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5129.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36756003)(83380400001)(2616005)(86362001)(186003)(38350700002)(66476007)(66556008)(66946007)(5660300002)(41300700001)(8936002)(2906002)(4326008)(6512007)(478600001)(6666004)(52116002)(107886003)(26005)(6506007)(8676002)(316002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FW48K4pKFuC0rJz7sLSPB80x7Yll1JHp2WFrGmWXA+uzD25gGuoHikwECkqJ?=
 =?us-ascii?Q?QgmU8Mm/p6TXulNa5L2PplDO9rzdnkuCKAIxM21D3qlxPcEyoODcL1tsldKj?=
 =?us-ascii?Q?iu7QoqDubHreWbRnMsWkO09MdkxrD2wbneZK+dk4I33r/B96AK33z1E4N37c?=
 =?us-ascii?Q?mXVKRSDs0JUuZQF8aPfef3PqUYkhxsVxbfpceU5RV/iDBV6Aa1QurV8gmJf0?=
 =?us-ascii?Q?1UHWddNdG/V3hbizKhBrl3TgpYmoh5wp9EWfCM7kkL/+dUtfDR0Bw5AT/L75?=
 =?us-ascii?Q?+JUF4SP0oc2cUQND4+xkR2HOcWWpMJdVZoL07qvGJS9337ZSlif5DuoPuFdb?=
 =?us-ascii?Q?hVOO4s2u+yWY7dUFzuA8DKqX901us/Z3GwCJrsjA7jqppfwAI4oxN9WiScWT?=
 =?us-ascii?Q?3xaH7AThHElrm8tSgSumzP45GRVkM9/WRl9r/Q7ocJJ1EhBKiFr2MvEbBype?=
 =?us-ascii?Q?PWa0F6EKLk8bvzyB7wyASANBPGjB/lIN63+/6k/4VcOlC8cR4MGQA6643Gr+?=
 =?us-ascii?Q?p/+76OeMCzwUIh8kR68TxAnesn9Dm4PLerY2KV4t4EC1pJUEWH39cGOZT2L9?=
 =?us-ascii?Q?twHYd9DKQ58T2r4/buYAvn8rQhlbOdRswVzR6nuTxXgGerN9LfAiFTT/ifE5?=
 =?us-ascii?Q?PXYZgmg1E9TGWVUhLNpEa1Sqd12KZXvw2QD29rCCmBY2YEUqiLPB1T7cslpN?=
 =?us-ascii?Q?ctmjiaYRfAjUMR2KEj/SZZakouxGpBmrAtzxvD4WzEAmKlhtcTnz9M5EcsIz?=
 =?us-ascii?Q?m7s8eW6CWTHhnteyJm5o1z5RYNReWt41ai1KjjCiro5FZA+8HXvRk44nhX73?=
 =?us-ascii?Q?pw7XuY6zBSzloiXEMEA6WDSYEklTn10fBcWu7LnvvJRmJY0q54URSLw+5ZZ3?=
 =?us-ascii?Q?IO/SNEhOLt6pIWxUdnRLk2q7cD0z4NpGC3hE4tQzipNihhDhC6XJQy1fmJjx?=
 =?us-ascii?Q?2v863Fw0GxnGiQqierrvL1+duudl5N2fT0fH9812gedZwf6vjMcMkzSQpZ+6?=
 =?us-ascii?Q?w7Vp6Tk+WD4AmfuAY50HpbA3UMrVDO58EfHcLtkHHR3la7xiaTfA5LZGq3ro?=
 =?us-ascii?Q?h1rfLDvwTnpWkJZGu14ovWn1tEJjpomNw34FC9LI2ClaP7SkR9d1sPkAUKHp?=
 =?us-ascii?Q?FF2cXFIJ3ajsWweUPEjiyVEEy7fI2eF8w1fzecxVME+JVQrbUEBggCPWd1hC?=
 =?us-ascii?Q?8mAXvZg4/eQOr8QvkZh5+DFlDeLwBmqXM4q/3FUafmn/k8JnSSp2jW/1rgE6?=
 =?us-ascii?Q?Bh+h9S+3NV0rwxq1ygzqdXiIb8shdOA2zjIe/+orxyOmZivC4HfrU4uT8MnF?=
 =?us-ascii?Q?Y3pJ7HnP1AydB6EWk1TCVuGYq6gUb4xiAY+/mSE+ZC2lwG5iLUeU+6WRa2X7?=
 =?us-ascii?Q?r9GhVhNIG0UM/CAM0w4LQ/W99aPpc3jPeNqGnJWMjbA0MJY2h2bOqNBzBCdl?=
 =?us-ascii?Q?j0siQUE9ejlhV8u8wkpV++3EyWTaTbIdalv1NM0uamUdABzX0DF9uqyiRTpY?=
 =?us-ascii?Q?x1EKFtsrNnoBKRRKYa8kJK1e6POWUb4z04h9mtGPahyYFVQw+e/ImfKxrbQZ?=
 =?us-ascii?Q?TTYa/fRX0xMtlVI+XvBRuPAzuwAkmLzVedlLOGQJxpN2ZpEnDPoUazIxXU+S?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b477eeab-1dd8-4fd8-b9ce-08dab66d8f88
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5129.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 09:44:50.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTXfNQRQyAwyi47Td0cR66CandU5wH/bXRum1NuwWB98i1Zp9YKwXIftwEEGw2Mjfp+ll73YBeWPJe8MUQUTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongdong Zhang <zhangdongdong1@oppo.com>

In the DPOLICY_BG mode, there is a conflict between
the two conditions "i + 1 < dpolicy->granularity" and
"i < DEFAULT_DISCARD_GRANULARITY". If i = 15, the first
condition is false, it will enter the second condition
and dispatch all small granularity discards in function
 __issue_discard_cmd_orderly. The restrictive effect
of the first condition to small discards will be
invalidated. These two conditions should align.

Fixes: 20ee4382322c ("f2fs: issue small discard by LBA order")
Signed-off-by: Dongdong Zhang <zhangdongdong1@oppo.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3f..2fcb140 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1448,7 +1448,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		if (i + 1 < dpolicy->granularity)
 			break;
 
-		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
+		if (i + 1 < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
 			return __issue_discard_cmd_orderly(sbi, dpolicy);
 
 		pend_list = &dcc->pend_list[i];
-- 
2.7.4

