Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A566A2B38
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBYSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBYSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:07:28 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04hn2215.outbound.protection.outlook.com [52.100.18.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6279193EC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0L5SQAc8tayxWzV6huI4xNsjQRuhVaz9NwUnlWOwmeAdnIGOfmogZoykShpABd7/4hymwcGGntf44Ka6QJc1QjKv/9w6DxCwBLxPAf9aojsNQ6GS39V3crrKMRzlyorUK15A/xW0QOwdGRA6CQUb52mVo0Luus8o3IBLsTmZfy4xU9lZefkB+A3+PfiK47jmorcE5lS7xMnQXb+Iu7fUJ6h2AKPm07ETQRauiwgvG5TATVgOvu0TgviapmqBKRPc2KTVjseP02/hjizzsIjUIuAWB0JJJJslpRmcmXeY2IR4aLSGlu+4pJusl6OsrJEo4ZGFDPFjJZQNah75mNdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4o/xDcDPcxaZ+88usxincIJ1qaFdmIOowDB2w5WWTc=;
 b=Jeh5vU8U9bIlnH05nAdF/AzpFiVIfrYb0WONMcH4hwPo4hUR6aG0OmZUGot45ri+sczkdjlDQgjb/CW8CuP6VaEYpBdwFbkG0arC1HEzsyckAK7vyg0ujC6l8Xq/fAQFdCMABZ8Dvzts5sXmlSZweRMa+XYqVJvgdsKJ6B3eSN+p/c/PTj0YF9MNHIlv+exwcOVwzyqn/L/JXhdF57zZtIURh833tmshPJC6ojhQjJ/GGj5Dh3G+qKHE6sVmmFS29n13HK5Yr4ZL5nbsqzDw/CRL3ly6GKP9vKLqrV6TVhv4Cg+k06nxPDaJmHn9jJG62mcxQMg8y9bq7qNeuvwHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4o/xDcDPcxaZ+88usxincIJ1qaFdmIOowDB2w5WWTc=;
 b=a7+03H+8VYeU8Nop9lEFKIMHHRLE7NKS8LPnqB7TdP9Hla9eeYmc3b9zNAGtTb3ahx+g+a1xlX1ndffNv/UBaWSSDaQqj/SGtxsU9/u6lrw4wqRj2XwwewooCYzHHqs/zc6XE3KxR5f51ckv4+ORnow7cKbe/tEaK2qV4VRXn9kjuj2WivMMwVq5ivF1sZJ3iwFXSXeIsS1WiiooAd0a24iwxTQz6ED5U5Po2ALcnyRpJ7OC2eJVGxuE6e9Wp6c37jDc1tWN+p5LHUNcNa49S8c8xKG6g3nUOMK54gfskS3M4GlxNVilqF1Ndws2dL8v7PHmqGVV1qYR8U42WAYlvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.polimi.it;
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
 by GVXP251MB0766.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 18:07:21 +0000
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff]) by GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff%9]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 18:07:21 +0000
Date:   Sat, 25 Feb 2023 19:07:11 +0100 (CET)
From:   Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
To:     rppt@kernel.org
cc:     remckee0@gmail.com, david@redhat.com, shaoqin.huang@intel.com,
        karolinadrobnik@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add tests for memblock_alloc_node()
Message-ID: <ea5e938e-6b74-b188-af59-4b94b18bc0@mail.polimi.it>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: MRXP264CA0006.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::18) To GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP251MB0767:EE_|GVXP251MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e630f05-f6ba-4192-a180-08db175b23c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KX+x+wxAtJCoTmHwc3qLpoPeNZdEbZCVk0L11NLfBfzNy6MAgIbfcn7F35TX?=
 =?us-ascii?Q?mjRNrBF/KK2qFWXaB/klIEAwFSYaJZ0YpXb0Rds8St9BEuhUZHJaZvQSCBYV?=
 =?us-ascii?Q?2D0nq5cNNtJ2FCmh2OKvga28JDf12AXEGV6lZbcz3j7awYDBDej849G4qtVG?=
 =?us-ascii?Q?X2RTT5ZhmsIddTmXL9PajUInwlXzjm8dws7XyKrM1a+wP1Q7hxacxVQIDQV2?=
 =?us-ascii?Q?0hjWQbP9pSxtO3Su1ElH9oydH9RD2umel946HHQ4XaDZhyYnb1rhTeNn0AIv?=
 =?us-ascii?Q?8VsOx5qA1B39EYtavyf1JsSbhN4czcCryjGm0eA4gJlFxWMvCjbP/BlLuulN?=
 =?us-ascii?Q?S2hJioolM/HMqpJk1la+lMIodTtTDQvnr2mHDOrNmD7VJXePvTYJVsnaY1Hy?=
 =?us-ascii?Q?wwPurAl9p3fHYIHvTV8pNunlGvacJsEBxQfOK8zO/Ffn3EKEqL0dW+X9jjZE?=
 =?us-ascii?Q?T9W95sdFBgofR8cCZhbTITgzQYnxtQpSfs2fNPJiNJP9YKFOCXzNSpD57STA?=
 =?us-ascii?Q?+JZY0GnwYl2fNcAfxOjzolNadBy2uVsyEFPuwEiTOb6HX9ePbvBm+ynycpKu?=
 =?us-ascii?Q?ztb5SpD3hKeZMKofflnUsdubF94/jYAzcrGUdmQ+i9l3Pi1HYXQ7pslUm2+A?=
 =?us-ascii?Q?eSCM73PlPPrg8EE2TRboxHx4XzvKSCAFnpq1Uv1KRnSvbbaFb2CyEcQQPjIp?=
 =?us-ascii?Q?X/DZ1nYDvNSl9vBNHmza3TBcpiG0s1WNsjbgEDEc4hy4XlmwelLovzFPVv0g?=
 =?us-ascii?Q?JTH3y+AB07f9mgak7TdqzpTVqthqamQb+/R4hmvBmaiLYyqbuMDfoZl7s6Rd?=
 =?us-ascii?Q?xVNKN4suDRtt8sW6mX2LL731ctzDR05QlVg1MjnJVHYy/B4BrmMRlArHQHFM?=
 =?us-ascii?Q?kNjUVToEBkPVOgO2i/ipWnRFUDk+Im2xu24tDb15ihrN+twvrl3ly9Z43/qU?=
 =?us-ascii?Q?17N8FnbaawAOlKd+nTo9hN14GB7KoZ/LuXl8oQQ/zwIfepNj3MDVoAnz4X9b?=
 =?us-ascii?Q?aYRgX/JqCQS1PhCsx3DDkhwQS36FfGL04vG4lXeLTTU8Nf9NgRkpbxk74I31?=
 =?us-ascii?Q?wlrZgKPJyjkjFNyB/1BrDxz24h+OebhjhU63WtIXz9qn328ND9d1xxb06CD3?=
 =?us-ascii?Q?W4BFWtRoTOYg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:GVXP251MB0767.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(13230025)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199018)(786003)(316002)(41320700001)(6486002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(66946007)(66556008)(66476007)(4326008)(8936002)(6916009)(8676002)(41300700001)(6512007)(6506007)(478600001)(2616005)(6666004)(186003)(26005)(38100700002)(58440200007)(45980500001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YGABH7QyhfFRv87zUgKhzyTKB/0bBBPC9a7n+BEENBvO4EmFxWMFz0CrpZMx?=
 =?us-ascii?Q?T5SwoES9mckcJ+e4biY3AXuy3gwD0d1QpBe95afrYD0ZgAi0mRGg8kzN7Lid?=
 =?us-ascii?Q?enhxjz8Y5EyZZLI/GUtMf1Y41VFMJDvrL+BV1VdE/LnPEWOcGmdl47iwcqCT?=
 =?us-ascii?Q?OEo7TLOpg2BPI6GWYOaPXXuyxXRmDW9BLTBFNDMTlCZPgsOlECqV19WyHteG?=
 =?us-ascii?Q?qrlVVMUulLlDcN4C2x4TQLtOqnbZSo/vLJjN3IknjnU5xX1baLFKRA6ps5yd?=
 =?us-ascii?Q?aa4hi8d4VEjFg23Mv+wBVgjHXB+6q0LXx+FO5mMNClhTdS2mI/AYt1jVzUkS?=
 =?us-ascii?Q?dOi6WL8Wy3sX6Fbb6t6KkGwwYFdeXW/OQiNvLVrt+5imGtR5eHKAWBbnop8g?=
 =?us-ascii?Q?0cgZkGNkoBZrxSWPtQbZd1CR9zP+mlyj7kIEl/GW9uO0KjKcb7iFbk50pdD3?=
 =?us-ascii?Q?LKyTYaP6iIt5416rvwYH4BYNBmE5Zh3qMtTcpPzAFBRhaZM/nTRWmWUwsKr6?=
 =?us-ascii?Q?s7AorM/Ql7rz03hlPMCwUh/V4RCpmZz2EM/FmLYl04oiCVs/3R9fTgug+RQ8?=
 =?us-ascii?Q?Fgy2joezbQvzfsj3DFpnGMofKIDbmetC1f3bkPDPGe+kWS3I5I4+Bb+H2LnZ?=
 =?us-ascii?Q?2moGxRA1xCxhXy3t93HDoau2x7EqCKfAYxUhKi6F2nhKef8WjRe3bTEaBUX9?=
 =?us-ascii?Q?CX/XhyPhbWSAvzLKoBxGVMfOwu5QAxsyl7tI5mW/qTLLj//mwQWy+U7p/Vy1?=
 =?us-ascii?Q?Xs5Na+Q8Xl+rXOyfVOzMKWVOplheb4U2fF8+R3vYDEZRThJ/5yXCY0JwN5Gq?=
 =?us-ascii?Q?T/a0ZcQFvLfeu3tk2h0sQ1K0PTcNI33IFx/V7ZhXABeQZRDYvAouiALJpUE/?=
 =?us-ascii?Q?t60Bdmq0APBZdjUY8pIGenGqSuP59AydRPrZLhF1/tQBjJTmc69F+eQ0zg69?=
 =?us-ascii?Q?e4t1/uHZV0tN8Lu6hpxpAk+oBntZ2GdYAwfUsRZWJ1nu6vabNaDECRSY+s/e?=
 =?us-ascii?Q?MKhnSpgYsl7bhU4in647BQl7EOD9OLB1y1bWsF9dKounIEuYcVC6l+SW5YfV?=
 =?us-ascii?Q?dVNAGTJEBgVWNSFjHhPYJiEfNG/JIIQZBkvr8m0eLwQ/5Ru/ohHQ4AJ0jWqB?=
 =?us-ascii?Q?6u4kiGgHjQPDEFVld09RAQO4/60Jh5sRU3zWx5gs70G+B9FGdtFbthvvt0vr?=
 =?us-ascii?Q?R6Tq66OCwLl1fKprRtHAt/cBJ31XcEY3nucG1Yzepe2lqy2V95SRea6E91Bq?=
 =?us-ascii?Q?neSlKMxMLPQZpyXohJACpZlSyLk+gCOl0iUysrw8q6DQUmNA9u+qs7jYw1HI?=
 =?us-ascii?Q?otrPuBQSMl4356N3OnaC5r8sx4VIni5+VRh/WY6eBhaWhgCvC/Imd6KOJj0v?=
 =?us-ascii?Q?2fFzO+p5RqsJxzR8KMS7+SwPfdwxO5ro4GUIUF/w4RIsJf5GX93zn+S41wUZ?=
 =?us-ascii?Q?CM8r7ewGDswwvq6vq8NyTiHNi3XHWUgEKk/I9J6x2xPdmlCYks/rzhs3DhH3?=
 =?us-ascii?Q?i8jJl0eiloiqneYvZCqFu3BY3fa3/eQs9q09aPljtNF3DSBChPqbRgiwQaJt?=
 =?us-ascii?Q?PNhm7QLs3cuL2yRyFSYONa7g7UPPkaOuqRb6hpa/?=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e630f05-f6ba-4192-a180-08db175b23c4
X-MS-Exchange-CrossTenant-AuthSource: GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 18:07:21.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bQqveutlrUJMYYOpW7tKQ5+HJlmuDpa+FIzVNPJ5BLQ3Zh/Ka1OQ7Xp5IoiLHv2xnhOb+yFme8nfC8dyCKRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP251MB0766
X-Spam-Status: No, score=-2.0 required=5.0 tests=AXB_X_FF_SEZ_S,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test is aimed at verifying the memblock_alloc_node() to work as
expected, so setting the correct NUMA node for the new allocated
region. The memblock_alloc_node() is called directly without using any
stub. The core check is between the requested NUMA node and the `nid`
field inside the memblock_region structure. These two are supposed to
be equal for the test to succeed.

Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
---
Changelog:
----------
v3:
	- Fixed errors related to "<stdin>:188: trailing whitespace"
	that caused a failure when applying the patch
v2:
	- Use the memblock_alloc_node() directly without mimicking it
---
 tools/testing/memblock/tests/alloc_nid_api.c | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 49ef68cccd6f..49bb416d34ff 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2494,6 +2494,35 @@ static int alloc_nid_numa_split_all_reserved_generic_check(void)
 	return 0;
 }
 
+/*
+ * A simple test that tries to allocate a memory region through the
+ * memblock_alloc_node() on a NUMA node with id `nid`. Expected to have the
+ * correct NUMA node set for the new region.
+ */
+static int alloc_node_on_correct_nid(void)
+{
+	int nid_req = 2;
+	void *allocated_ptr = NULL;
+#ifdef CONFIG_NUMA
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+#endif
+	phys_addr_t size = SZ_512;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	allocated_ptr = memblock_alloc_node(size, SMP_CACHE_BYTES, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+#ifdef CONFIG_NUMA
+	ASSERT_EQ(nid_req, req_node->nid);
+#endif
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_nid_numa_simple_check(void)
 {
@@ -2632,6 +2661,15 @@ static int alloc_nid_numa_split_all_reserved_check(void)
 	return 0;
 }
 
+static int alloc_node_numa_on_correct_nid(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_node_on_correct_nid);
+	run_bottom_up(alloc_node_on_correct_nid);
+
+	return 0;
+}
+
 int __memblock_alloc_nid_numa_checks(void)
 {
 	test_print("Running %s NUMA tests...\n",
@@ -2652,6 +2690,8 @@ int __memblock_alloc_nid_numa_checks(void)
 	alloc_nid_numa_reserved_full_merge_check();
 	alloc_nid_numa_split_all_reserved_check();
 
+	alloc_node_numa_on_correct_nid();
+
 	return 0;
 }
 
-- 
2.38.3

