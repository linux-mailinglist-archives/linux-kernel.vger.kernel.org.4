Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613F6D1F20
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCaLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:34:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9515FC5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PddGbR2SdEJOtbAsV8P86k8LT0FIdtmngIe+KcmcvtOFdaxLTL8dOkWbBFRA88lI+jlOzzBxpJSYJ0PKuPEkyJQ9AG8MeT/U/y4Tcn8FYygnZnG2MIyrSNwOdLilYJH7flDCfhovVuBGAz0DeB65en9Le60b/8Lqc93AK7SLP6B7U6JLJHV9NkAZba+Jr1BR3EyBMA4/JraVGOc4sI2q3ZMV7OiK9jh7uJbQoZT2A/B7xXAed8ZhD5JQfqyxW4HI9CV/evejtZHpw6bcAOcpXB8ZuyxZ2MjyQ886Pqa9R8cbaJwSUyyRFXkl+bnzSQ+t0MYKJwlfoDrih4GOFLazpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGSITIJrBWwIZ7Nqw5Ue/DsjkECv6uOpDsIe6hFOqRU=;
 b=OrCXg0I1floCZ8MwFvRo8GtPlZlFQURlIyl6lHUL4YHgxTj8piz9FtSjMiBy6e3Jb/t8s7g5nyjSMpFLD9tYFGPVHSEue6ZAa1SJ8p0/FcBwZXJpaSbLlB35aGmwC4qOVO3Zd/ms53KjivQ1ETPJqSmR45opB/top9WDlPr95Ycf/e1kV7wAd8wY7xDltJTPOlNj93Tjh1+cBxs8G488ABnK+jJkskh3bisQPOEBcnx90g1zrIUi/QYGFjQd6RVMtMs6qgAKDud9XpkVI40CpyUtO+5qzlpNJDRYCZeF2XoP8cx6RwNB75pQvXA9nk4KRyAxJqudSdpzTQvMFuQ6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGSITIJrBWwIZ7Nqw5Ue/DsjkECv6uOpDsIe6hFOqRU=;
 b=QZy+v6f7mWv/kkcfckIljzC6+zgOaG5e3IhT5L1pmZx/728J9Y963IzFDLbGIx7va9rojN8qDPCBqtqcDFfzCwFZUxVTZpS9QlzFAUN1lxK1Nfnwu+zq6GSG+8QNbm4uUnx0UbGqcE+Tg20LZpkBvIRNqWNj4xtK02Rm5M8RyjzcVNNlMUUWgfjw2yqnnL4NnKvJQiq6bV5w3NK3jhorvcNtWtY6GIOQi88kY5MHr0G6zk71aBdcoI+6zHg0NRhpGtNciBEY7XmutQqog6tnxWeaQAYaNLLmank0Ty1DnezoBs0Oq6PgZ/SMsPa/BXLCYQ5SA7FJ4B2oXC6gYg0+jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB3958.apcprd06.prod.outlook.com (2603:1096:301:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Fri, 31 Mar
 2023 11:33:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 11:33:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: convert to use sysfs_emit
Date:   Fri, 31 Mar 2023 19:33:05 +0800
Message-Id: <20230331113305.77217-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: 891097a4-7903-42cc-3a04-08db31dbb90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYGiYENh61tB6XfD4z9WFkl/ZxP+er4YO7U8FN1p9LUbIb28WPoq+nv8qFAuGMidqYXj1Mhf2f+oBJR/AiXbBmgChG5d+GvhEHma3/9nRJnobLcmb+V9giTaIWjgyV6YhDC0+oDrJhJwHxiZeHR5AgZIalH0MIbBARDHoLOCgX87bP2iYSSRzTgSfqIyCILibH6vR9IQYNb5dPaRfpz030f6aZjyYsfZ8aEfyN4rg2fpilDpvEhl66BcZq3BQPbwZMsTPaQ8jXbWD3WA8JWGGH0HQod6nytLFYBBzWixevZZ4Af7QVjxmOjiUd+eEbM1YVYK1XYiBojbbRdqBSaomqS+UHZ32wpi6DL3BPf/ya0bpAyeqpLo9VP/JlU8vUTFI6CnLkzuDSIwKQEBkNVoFKBV6rGtbmWfXwjX7JJDlGyXG+LBaqCZdqggU84d22mAoEzSjg7gqfh/wB9+gNFuUE719QkE7S+xVeDJd77xKJoS0i+osEKO0sQBoyEdYlWtk31ruW826Dj7BQVkLCSI+bbJJtqly8Xng4/8O4V1bsdcOenJg68P8bnUubstWWamxh7di37fTkHqZU95gCi35orfZx9dqKzia5oibTINzvf5DFPJBt4wUr/SeS1Wow6V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(66476007)(8676002)(66946007)(66556008)(4326008)(5660300002)(316002)(38350700002)(8936002)(38100700002)(52116002)(2906002)(110136005)(41300700001)(186003)(86362001)(6666004)(6506007)(1076003)(36756003)(26005)(6512007)(6486002)(83380400001)(2616005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5gims8J94d1e4/LFr4imnx9UVUuRDuyWJK3/03i3PGWW6yUkd9RHxnbquCGO?=
 =?us-ascii?Q?2Dx2qa5NjSMV8QQ60EqzfOhI/eKcQMg9E0Wt5S4DtHyHPLkKhEk2PgNcfNG3?=
 =?us-ascii?Q?jyoDMUlO/G5JwsT8RIE4K4I9wLTi9JvFR682Sicald/ASBjXqN5ecHXhLyim?=
 =?us-ascii?Q?RcLBV56wniYpNcNkRfvFY85M56WF0XgeU7Qk2rCCL4aT61N8Uh/9aPtvyJA2?=
 =?us-ascii?Q?itzD8FlaVbX/EpzGwItGmWQTK8HIRxRf5SgUyVpeWwRt8UfpzVNmuXK8zQm7?=
 =?us-ascii?Q?MZuk7Kt4yPTXQTqFDSoXp6phjPG9H7cVQNdaRJtYCMSaCiLLqJxkZOKBnVIy?=
 =?us-ascii?Q?g+hrc6scPkhcpOIMMuxXJN7cw/fhnGTkqv3apeEscdYhS3bYXoy6DPUcMwDP?=
 =?us-ascii?Q?ATz0fBCrz0OSimQZ7dMZgP+JzYteZ1CZHgkkRP4Vs+3m63jw2IBqCsgPw5Qh?=
 =?us-ascii?Q?H/SbY3GeSF39KoUK4XmyyEwTf4Dfn4hCOmFdpQCpuixcAzdxG7lAzKPNuQSn?=
 =?us-ascii?Q?kGtrD0Qs/LN1XZaQdxE7Ao7tWZvP3+CId16Ng5jOKT0+im1D6MSpghwvfug2?=
 =?us-ascii?Q?HO4yQNfVwSAATlwuV6gyI6yD5el8hHxbxSM02nWnl4OqUCFIQAgh/8vcGfK/?=
 =?us-ascii?Q?mv6Q9ZnmdxGxaVc1Fg4sUxJmv1r2cYnuRzehkKnjLxgOpBms0RKuX6wbiWz2?=
 =?us-ascii?Q?p+bdcKkQ3xgORJARXqDXdR2Uqw4/KtEjPuWYSUIk4qPJRqwCoODMubi1To2n?=
 =?us-ascii?Q?CLhpnn5ZlSV6dmICUXh497LTVmj5MLuaiVq+P7MVlHKFHMLj3DycH2lvo2dQ?=
 =?us-ascii?Q?Bn5RXXR8Zn5Ws9S539RH404iq4E0G+y9G7i9yzZaUWomV826kBcGuaRkGMg5?=
 =?us-ascii?Q?BWxLfY9fnIsh1Mxnp7Arc3lzPj6ty1jsd3U2J+Y7cZPzL9qufvFpJ88K2YoM?=
 =?us-ascii?Q?Jr315WT3HbmEj52TFw0ieHbXF3NevozghXquVmh2YOGVtwTlWNLnGeIKZhAB?=
 =?us-ascii?Q?mf5W4g3xgOYp9TyRJEVkvWYlTw8f5qKvVqU4I3MmqtfXuhUwxYuch1YSZZMX?=
 =?us-ascii?Q?g0a3kplY/0XmUD5E0ARKBeCZLOeH4a2JVnSEPJlp/w35kO0+Zm+Yta8wMM+1?=
 =?us-ascii?Q?90Gjjsjy3Ety2vI7UC6vbsxO4lp7mduiCoTaYMeM3r5S067c2SYykb/krz95?=
 =?us-ascii?Q?PI1U0DefGk8fZvK/DeDJe1YcngHR1CALyrKbdeiVbI7NT85gk8xLY9FP5H8x?=
 =?us-ascii?Q?uG671zLb7EF+yhv4LywBqTZKh43BzaKWYA4DLyWcfk9bhxTnFUHAfvYBaPT9?=
 =?us-ascii?Q?xhRaMrvidAN2FiMrvaINEngR4HYKW9irxY4JL5LFSUOqVFQPdZgi7Nlhm2fD?=
 =?us-ascii?Q?XUgof0vGogMuivN1s39ef8FzeBBItg7JoWoqh+6ePC0aBfxfi9tOcGgXP4fE?=
 =?us-ascii?Q?4LpvxoE+0ok5wDGFIUilLZ2mlWm1Ff4jbF6v92aVUPo3/brVfhgJWJcr4CAH?=
 =?us-ascii?Q?Cr75oenFYtTIcPCcYbcIaIi9u7LdcBt5m10v/TPPfkT5bwZ2kV8fIN/v9qbp?=
 =?us-ascii?Q?sA/dvMnXMOuWGTYDFd3fMVDxH4MU8GL9PdAwXG1N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891097a4-7903-42cc-3a04-08db31dbb90b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 11:33:17.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNGwQo+TaachPIFPXLHXCfKwpv+a+01YIfGrdLdGYwCy90MvciL60eEX99IJ0lAtPVy8iBvc5ydPvhgrwMzdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3958
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use sysfs_emit.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9ddc6ee19433..2c0b2cb05a3a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
-		int len = 0;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
 		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
 
-		if (class == IOPRIO_CLASS_RT)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
-		else if (class == IOPRIO_CLASS_BE)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
-		else
+		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
 			return -EINVAL;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
-		return len;
+		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.35.1

