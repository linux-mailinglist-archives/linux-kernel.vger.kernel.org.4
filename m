Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBA5B3346
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiIIJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIIJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:15:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FB7A76D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/UyX8OHkw9mo8iZwcGY/a61Wxf0M/BoJ58zmGDGtoukVowuw8hb6OQSYSkvmjjADhhbfQ+9SE9jcy11kheOtN4ZzEJdlSCwpufhMdO8gxXVqc8134DB4dy/XlumT8MrBDBgqw88sj9sXZ0AEn0/mVzWAcRCGwqyA6x8CArakGrpwPteClqiMkE7ZF8ff/9ridUiW7oxx0CF2JkhqvVL9myGyi7/ttjG3QIVbSsL2Z3g+zu3UBXeF6JBLxnmk4c6s/RZ1bzXQ3fVbArwz1Vf+VqWtJzSH64inX1mVBkQuTJFEPb0xoEgVTvAmExP6mJCpAUUYxyeHSUVoEd2IkZjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpqlgFBh7OWSMfIXxBz4YTXHeNN6zLLWA6zVMcGwA8s=;
 b=IR4BGTEOI/G4lkans1WLrFu1d47YkNz/9golxYgoDvzbRAYOCMzQ+KhzSrKmfmrqvG1sbrPdx+KOeqHPUglS7DHiqKkz9XKTW1qrI/STftSmpEsJQDmsrXHFnAMVRBAUu8hbIhLC+fB2pyGxcYtUfrJMSx6I+0fWF04BWwpt2c8kHPyjPkvENSJ4fMimZNIVcvqnMsx4Tu06XzCw3hYq2DbW8TPwAJimbW/TcwUmQRV0Sym69LhRgRHv6ooY2wAxm6Pz2eaTjQvLG5F94aJz+pMR4q60L4eN3+Nzp8gPi569Vdku1r9krT+wgGgCyzGUqRASNIwEFYOaoyFguVrm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpqlgFBh7OWSMfIXxBz4YTXHeNN6zLLWA6zVMcGwA8s=;
 b=nh0/lvLI56uaNAf7gTUSiYmEJNlyQ7zNjURWuoyjgAqu4IvvmD6jbpznJ0+nA/z4jlTOI430v56GK4QXWqhfCSemCidnBAeMxWoYT+ebQ1vTrYouBzzeR/PmRYGGtuVu3rbWCGZT5crnUvAwKQvSKGtlfPFLyGhRHOKls4DcpxckU4jZdivJXreDdk0oUNM8Z0fEhN70+IZ3OvadhOUxdJx/544Jgam6MDK4WrgoWVXzqGesabBwKJ/AH3M/KPXpL8g51yqwW1hXC317AsDACyG1HfGdNHXxuxG/HX5x8Emm5iW4QmPix9iq4m6nuQBZZ6J47ZpfwbZZr9dgVGIHJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SI2PR06MB4315.apcprd06.prod.outlook.com (2603:1096:4:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 09:15:21 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b%4]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 09:15:20 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] mm: hugetlb: Remove duplicate include
Date:   Fri,  9 Sep 2022 02:15:03 -0700
Message-Id: <20220909091504.4255-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4173:EE_|SI2PR06MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 671cc2a3-46d3-420a-dc76-08da9243d1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iuq/ZHzTzuhbtxFj61jCeoNwJD3PBgkd+mfyxGXicL9fjEieMZMrMbrxOxOF9U/tUvEXHnjIUHCHPMf9utjfT6T7BUg77WOs/KA7NFnf25Myi+bSWiiHIle+1A3DA7/EekSVser6SczNP/4x//VGJ1JSbX9aWCaIjR1dBg7mVL2qGXK1R1m2+ZHAJN4b421TomMBnQvrTJ5eRMgr9cBhEpqxV4+DcMUFZhkff7meAJfY2RPi5sI9yivd/2CjOFsFsxkovql5+kwTSyYmTaSQbbAd4Qox3sf2qEAqaiFfVkgw0WUmmII+mTV2zJG7we9JCpDoD6IfUg6LaT6dM8PWNe2ohR3JPoMNBzOyoIMWVyJNrcs8QZ3tie+vhebnBBLirk38dQaDVJlrP3YOHthzB8gCglz9UQbEAZtxjYMvBKeozsbmSwQqxGc4OnWJYdFG37NS1Ydn6VdN5udeK3f3bx25BI2wozqLv/NrO7NslSrNkog+xiclYHpHE2Uxm5vURK7aLDcYAu68lEuYVon1CipxD4rcs8+DkGClYydBrtALj6s0CWz1FNhLpuQAAAdXP1Ufz5gTRhyZGFZpIEigB1dqyby1BjyC5HaBXtxRDHEWs55zrAcDsvDaFoPkVkoRXysb2FfK96z9pD5Y+28sLawN3xLLINBf+GlaOp+Bi44juKloggkz6APJCPkV6XWuXgcYc/Fl4ACo13mPnkmfDkNGWDQynpz1iHMVOzp76yH3KqLePSr1rbWGUYlE17WI+chVpvltMunvKyGS0h61Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(186003)(2616005)(1076003)(83380400001)(2906002)(5660300002)(4744005)(8936002)(107886003)(26005)(41300700001)(86362001)(36756003)(6666004)(6486002)(52116002)(6506007)(478600001)(6512007)(66946007)(4326008)(66476007)(66556008)(110136005)(316002)(8676002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glYPJgQ4ZjGC82SmPQMdVbeIsvdApEYDbVravHTmknU84OkfFSsoUcm0Dvgr?=
 =?us-ascii?Q?GoGeSRaWCYLxqBTkiZUTmTHtzwYHxUhXw9bJOfvdd5NrFN5swIjodXwevgfN?=
 =?us-ascii?Q?Fd3jOPsdanwTNK+88ciVecvPAEmh97prUU7hW2FRQ8hQAXn8pQsp/aC9MjOh?=
 =?us-ascii?Q?wE+cAuQlOOhjCUhQYzXAIDRusguAXH7Bx+g4cJ7RxkX/yRzif9CP/xIDf3K1?=
 =?us-ascii?Q?lhuEFq9QIzigoBmAQw/NBJ4Igzr4sNtLcRdivC8ATUsCg+OF97gJNyDZry69?=
 =?us-ascii?Q?M04NLHW+i3JYPOuAOW43ue+2OZWnzAEO0PqA62Ze1ayRqnDN1tdZN6L3Fw9C?=
 =?us-ascii?Q?2WPiAXOe3KTpR3HhnwQ8S8kSccfVV0IrM2EWw3gKxaZ83cr++0kUQsiB+wXi?=
 =?us-ascii?Q?ccEGh3EYBLIzD1IqfOqp2H6gD/2m2jd6VKBaMMcBT6QkiFdzawhLDqNVVROk?=
 =?us-ascii?Q?HOP92Gknx2/Q7e1RdgDQ1nocvk872uaDeYapPlHryoZqzI3to+KwlrCFv8m/?=
 =?us-ascii?Q?aYzpEukU33NNHUUBLcZ2p3B0cs3Fu178tG4tVtZgqYKJDftDSWVvJwNZE4dU?=
 =?us-ascii?Q?1hnxPnUHeGAM4ROZuGZ9UFVoT4zRaLVbSZ5qZwZk0L/dqUu/EC8LxLS6NsjF?=
 =?us-ascii?Q?JOpWpXYpxAeem7y9AtBoZZVsmjv0HMO7ZVvehFRYt1JwwNl8KY/pt3O0k7Ft?=
 =?us-ascii?Q?iH63ua4Wf4M0xeBwaQ3668JFTd+LW8sj+pLlzp0gdP9Ng1F3IGIeaj5XYDGI?=
 =?us-ascii?Q?McrDTWoNmI5oBWnOFFtcZsE1jdSNH9+oDcOdRCvq6215k6akmr0BUw4wQ6VG?=
 =?us-ascii?Q?NBz3Bgq4XvLhmu8+Y3gYuwXvek5/5dfdymZfFt8XJohB5D8+jQ43C5N67tWq?=
 =?us-ascii?Q?UxRHvZKs14ZcKj5m7kOt1B6Ne6ucAShkibV4TgKwl29+Wqovy4QjSMAr3e6/?=
 =?us-ascii?Q?1HNZq6YLxGOYLucQo6ouTHjX6rCh4TsT3saIgllSRtkdLiQuO98CWfGGmeEJ?=
 =?us-ascii?Q?nHsQG17VQdeBMyw7aEjdDxKoGuA1ztzeX025feK4J19jKz5Okupb1QLZZKF/?=
 =?us-ascii?Q?bT+RPvdYAY+fPwnOzXmNsSe+zymISjEiwZyyiJGTsPoWQKP4MrXK7MpYeJ4s?=
 =?us-ascii?Q?xLqOZWLUObrnnL3pTbDP406CP2kVS6wZwZnV8/hr09XX+gg4uvU7N+SLwyT3?=
 =?us-ascii?Q?UcLT9hsEexyktuyHilCgmolLxJ4TVk7ZyCOn0QHa7v8S7BjKAWaeBiEUePJL?=
 =?us-ascii?Q?EKdTgn0i13ip/9guhvfFUQhWOYKqdPzf3dYXmNYL436BbuCUd4VOnsrZ/OZ6?=
 =?us-ascii?Q?Unt3kZhb1/T7HBtfsGFsP/uMix64MRz09lCiCzearj7nh+TUZb3KyavbdjZp?=
 =?us-ascii?Q?4yyj7nCM3GFPj9ABf6fOc2pmJfotJbCD5yWDaTOmVnGYn+JXUIN2kPVgUMhi?=
 =?us-ascii?Q?thVfMGs++z3HVoXlaxlgz5vDVRwuPRPzdsjr7MLtDLqH3M2WVYuU3u8tn3AM?=
 =?us-ascii?Q?g85L+E+w6ieaidX50vEVnnrcJpZ3gfV+gMFBBWiCL0OnEUbJf6zxcvDpO68H?=
 =?us-ascii?Q?M9huF2Y6QCUXgGvpUeRy8YGKCeEKOs8ZzmQfANtb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671cc2a3-46d3-420a-dc76-08da9243d1cb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:15:20.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMI56Xn4qGJc1Hzitqj+eAt+OeEEF99bLb4dcND27X2lqICk886PuVPkgqEB0pGuvxbtNVeIxwB+o3AbpuRw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkinclude.pl warning:
 ./drivers/base/node.c: linux/hugetlb.h is included more than once.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/base/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 80b1e91b9608..cf115d5a9b8a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,7 +20,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
-#include <linux/hugetlb.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
-- 
2.17.1

