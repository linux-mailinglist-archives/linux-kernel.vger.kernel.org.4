Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6691B732B47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjFPJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbjFPJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:21:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F110F6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHDTYt6l6y7JO6HjvkcW91vxOaD/QjI3ExL1xtQrAoLu3pt/KemfbeEvMxduya+lwQmUxUtYlVQdkiZHP7SQUC7Ow1GjTqXAwyfdNpLkCAovh8SqQVEOqzHz5YgrEm0VX9V6E5b41cqygx9axDq8rISQOhTsXOoeBD77jdim6xbKw+45PCAKatfhUrjy5kq4yG6CFe29ggZ3DosmOPndWE1b0EdNG0QL2HLbJ3ipzoOJKsb4WtpOxVNuXmK2JVwsUJM2s5g+JMAa6OvAPnPLsqpI//r1k1v6qGdGT0ft6J9iUtCnqnHgYdWakPHblC5snj3x85VRoDFeS2DbkwA29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZhdpleADvYfdQ4LJsVuanPOs0fucwZ/KKlfDsrJ0sY=;
 b=lK9Yw1FlOJG6rxqAMKcKSdpD8+nZZnE57toPyJgDSc339L91VR9swLVWBP2Kk1u+U0l1JGbRc07M/qdB6sL/P25NGn+B+U/Y0zV59ZxmeXndz+/UKixGxBUuigEnXHTy7NHoESJnmAPcG0jl5HWEt+UU9t0SSr6az80YoW2niB7iiEWi+xuEwtpXvrPyb0LRoufZ27epjXVDwGBk6PQPhyGRXbbrZPVG9WLOVN9pVxeuriz2Y5jsbbCrpr1LxvfnivtMMcrwrsbrP1Mv6YuR/DfDJR9dQwgnRElijMul3DDqwP/XV0+W1aCR4CJwTkGT6jx27t2evY03xe0ONO+2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZhdpleADvYfdQ4LJsVuanPOs0fucwZ/KKlfDsrJ0sY=;
 b=LOAln3DuSdzhHAGtZXv3sfRzd0QUYFWTjH4T918uCLHiSLe6C62eD8IkpKnzt4wVE4J18s/KGClIFkTJ94fRmbWnwVt6Kdp7GFlv78V/vkHpFnECdOJPETy1B2VrGV3EysJi/LpIp/w/NUdn1we7WouS3AYT/rDV8IhsZcwiR9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEZPR02MB6158.apcprd02.prod.outlook.com (2603:1096:101:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 09:21:23 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e%3]) with mapi id 15.20.6500.020; Fri, 16 Jun 2023
 09:21:23 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        surenb@google.com, gregkh@google.com,
        lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm: vmscan: export func:shrink_slab
Date:   Fri, 16 Jun 2023 17:21:12 +0800
Message-Id: <20230616092112.387-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SEZPR02MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 313220d5-dcf2-42f0-52bb-08db6e4b0dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpRIuhgnivBBYrjMcfsHF3plsXEgdkpsm6+3CmRAC7URbILYBJ+0u0svds/s0szX2SQlWM5GsGL6VbljJQoAVEmIagAsyUWJq9Srq/zI9Gc0LdRQON6Jn5HXx4kzscED3aW3i8awu7YYsa1vFTRPvSe9Jo4qxLzrKUb4X58t3TozemaEmRwvlZzTo9CdCBUao4o0duS9impuqfay7mSEzCQaepGlvaqcQAyYkBdg2hlYo3AYvzuClaPKp4KXgDWebMJ8CqbqQnz0Qt+8qyr8CxvizjFFNHwD/bEBfNgLaBXBLSuaNcMva0TWucicw5L5Wzv4WUAXyD+6NBLPG5pcIfREFBZILhfr3JbfTKz4nHN9yU1MPZXeLkbFsR2PAQTCfLCpgIiLaMkvW6wwp3gsefQL/ehRyedEK9EN7ncIDDDOzRsIMPDEtgc+hIy1i3LHOJtE6eZq/R7ceEr/XLPgAxQ/J8rxjMCXz3Qx4Ql+H0URZLrM736SIFwBRIAasjK67MyidbVsrUgCIKACQ5Eh3ACOSp4l1neEBro8MOK7tJq8bqDIRe4y+K+57BoOSHCXS7hO0pjCXS71ttyEQGyDQgzgarezmuI4igDnJJtweamra+mYUN/8/WqrK6JsmLZy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(6666004)(478600001)(8936002)(5660300002)(36756003)(86362001)(8676002)(2906002)(4326008)(66556008)(66946007)(66476007)(38100700002)(316002)(38350700002)(6916009)(41300700001)(9686003)(1076003)(6506007)(6512007)(26005)(107886003)(83380400001)(2616005)(186003)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AYRli7U/vl7HwTMvnUY97Obj53OtDsiURlD3wxlmtikFqu0H62Pu058eqIBm?=
 =?us-ascii?Q?3uf7MawDYgIVnkDu05zQiIQ/9unlerSZkn/M+y1p8SII0PXjDjdvQOGY+wo3?=
 =?us-ascii?Q?5QxusO9GRdq7dqjakx4HWo754kHCCmEJQ/vh63yKzAQOazH/lGALs4qU/VCu?=
 =?us-ascii?Q?jji4Mxw+e081PEsXQYK5WAdrJyMNXGDZsgt9h5P4XYq/fAC9z6nHvmfEkK/5?=
 =?us-ascii?Q?93cPRlb3cfzQ1vxTn5KemGqEb21rG3BY7L7yoqGJKiaokDc8Nnxs08KcqvvU?=
 =?us-ascii?Q?etNUIyQ8M1y8iQ6C+DrzOBn6S7tuLVlYoFfT46K/IBe8JAZ8b0u0KUB9rd2C?=
 =?us-ascii?Q?Tu7Yz6iz7Rw0DQvu/kNtmWeN66gjIdRxn3GcjNya1si4QRvkIb3C1l0XX1fd?=
 =?us-ascii?Q?dwYnV0G/HI5Fne843PICJfKpDkQCs9S7J2D1CqLDLh6SxUsCMrJnhcbIVCOS?=
 =?us-ascii?Q?YGox0wHfyvpB6heF6rjPvScv47jrhgPlxdXyi5oYCTahZqjcANAxtPLZBgM4?=
 =?us-ascii?Q?iwZMh6D+V9OyxpSG2OI4AbLrQmV3iZ1fk2Pb1eCas/pM21qifmwUFETi15A7?=
 =?us-ascii?Q?GMKaQ69tt7qkqV17DQ08h4lV9WdOCjAUB6rr/hXlyQElvQXtgMbHC8MegGzt?=
 =?us-ascii?Q?gQ4Cnb66mYu5oxEDynJj8slIlIOhX5CJZBdoZq/KS6BJXGGhNwdrmhWYe9ch?=
 =?us-ascii?Q?MXZomYNtVpHG7zYEZxO1+MrXRSNCvAgoYQYVgKWiP45LOOraMvfQiWK6L3DJ?=
 =?us-ascii?Q?31iRnaHFCGMi/ECd7UfAU6dnLwIe592XxrAm/YmwUgz753kjLJLaluyUtTCC?=
 =?us-ascii?Q?qXRXgt/rM2njrM7LOKHPDTzrTRggCqjFbKgTqVvJY6MZOqxXF4wLk49MiK+b?=
 =?us-ascii?Q?ak4Z+w+lsjXL3mt2RHR1yYbcouLsaisPzCCq2KK2XEcDp0Rd49LcgyqcaVjZ?=
 =?us-ascii?Q?pygu8jR597xLH7jHNGtpqmiUFa4i8IU8uHTaZiYW0qwTg4+QAHg/4fQZervR?=
 =?us-ascii?Q?26xNHjivNBzK/PJsa6TQoL2mFTMOv/PpFZzodxmSQjAwdFHAmarAPNS4uzFF?=
 =?us-ascii?Q?XFyYzxQ/X98DhsA4uwYUahKvunGExWG2sGzX4QFlVGDb6zaY6exgrL7VpPJB?=
 =?us-ascii?Q?hd+4HUButl5Qv5gUshx6TWRAfVhZZnNHgVqD+AJ0fW/fGjfEDP1aXsZ9X9yO?=
 =?us-ascii?Q?Lc3PimFzNKfEPySrOSHQh9IsS+NfzAif1/CaQd13QOETE3Ug9KdcIELQ+fsy?=
 =?us-ascii?Q?TYHqhJfHCDhvCPtgMIsLCDGM47e6MgESksLLVUgwYOr31bkCb3uQACs4Z8bo?=
 =?us-ascii?Q?ppTstKzTj4/AMKtPtL77zj67DiX+qneE0MulN8DKkCe75dMwx2W0AD3czK+6?=
 =?us-ascii?Q?0RKPHsxoUS0qwB2/O6NXpOiql+a5ZTr+r8NHMjDacky3nhztdGf1xmmr5MoU?=
 =?us-ascii?Q?1BetgbYrFjT58LDBf6MKp+sxyRRmGR3ir6aICGXLHjgy1bH1/LxoRLdvMUiy?=
 =?us-ascii?Q?H6IP5P58DnPq0C/QugsRxw66u/rxtTlYbqXnfJxocuUpw88agBosb08TKJ8W?=
 =?us-ascii?Q?uSF1hLA3fnB1amb2CdpbpK1vbEsqdqk6logXCqNF?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313220d5-dcf2-42f0-52bb-08db6e4b0dca
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 09:21:23.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdPfr97+M/aKQL9jYXhLrs97NWR218o4tBHG50Gdqug6G7rimBHcH0XKGG+OpKU2zDfm+W4djL1J+RsG3reoKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lipeifeng <lipeifeng@oppo.com>

Some of shrinkers during shrink_slab would enter synchronous-wait
due to lock or other reasons, which would causes kswapd or
direct_reclaim to be blocked.

This patch export shrink_slab so that it can be called in drivers
which can shrink memory independently.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d0cd2840cf0..2e54fa52e7ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1043,7 +1043,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  *
  * Returns the number of reclaimed slab objects.
  */
-static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
+unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 				 struct mem_cgroup *memcg,
 				 int priority)
 {
@@ -1087,6 +1087,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	cond_resched();
 	return freed;
 }
+EXPORT_SYMBOL_GPL(shrink_slab);
 
 static unsigned long drop_slab_node(int nid)
 {
-- 
2.34.1

