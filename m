Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2DF6E5745
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDRCFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjDRCFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:05:48 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2034.outbound.protection.outlook.com [40.92.43.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB559F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeZ1qbUI/rwwIkC0rU1FVTYXSQJlUQbq8XGHnFBvkqrVykhsUvUEmHnuMfTHg7gaUvIZtnrmhqwtmI1+TFaYnAwmw09gdajSozCj01XLXRTFEJ+M2BmoYm3QMFGdEivWoNA9UVS/RfqdXdwVwNyt6g1ZTPB/AJn2e0ay65m3Kb8Pkbhe8EXoCOvgpbM9owQ/AmQwJB3vwoySSqNj029uvRgN0V7kZlD6/L/oBA8oFEroHV1N86EUN8Zf0AKt/IhQaRpf2/iXeD+NwUApvDX9TF3hBuDJQNv//WOHV42zMEyk81++R4HcQcrw/ejHsRam+PQOOP9q1hKAzTYrv/gWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YI5foHbQmRTcETVWa9s+DoJPs24xDsnVeHS2bn3zDs=;
 b=U3LEyW5lb8Yv20XO1nhsbIwAcpO+3z0YJ1zmglP7Qdhl5x8/kGJNtWJdC/Y93z6DFN7+6leF7/4TQLgN4SXeufU3tRNzF+T9n8NH6u/dy7qW5VoMhwEEWW/5P5MBVtViEl2FioF4ePzJ1qsHdYtTykbv8nrI+BEcU8To3AdbH0sF7oa3xGCxfIviTTpyvAVBElo0rbSxOHzEYqpkIDJx2+RbxRuy/koEV6jN4igPJOXqar4Ky26PP7gHgyJ44xfnViqsxoYV9EqxUMX0d1XYZaJ1qTDXRzlSsry9yr/OADOTt1ISE9N3jVjW3bI+DYgdWQSWNr0vnax0YByqkGphYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YI5foHbQmRTcETVWa9s+DoJPs24xDsnVeHS2bn3zDs=;
 b=fLqyIsTgwAZF9DrdUtCZNJUqJA4wEjtHJA5oLCao+97eON0LbjXTv4GUQSDaeLU6+6UGCcYv1fm//0UKJw5RoxlLh8C2CXqw2k428QLuHuxdIBZ1/OQeO890ImyoshDDhQq8lMekgJeookRFXdhPzWKHKk0TjCqEU5s6GzVAXpmZ8QXu7vy3xjZ07Fcd1L9cdkZpCeOb+kJMU4a0rU3MRBJkz7QqK5L2zVIQ+PFy7L9teNCpuY4iMqRrMBAQ9CYhp8+cG46Pp+Ms+VuU56hUIjVipvZi1UtdzdCudLmrroY0/Jq+uLInywUUYQAbWpUGYptXhSiJZ4FonHURLuyFpA==
Received: from DM6PR22MB1836.namprd22.prod.outlook.com (2603:10b6:5:25e::21)
 by PH7PR22MB3615.namprd22.prod.outlook.com (2603:10b6:510:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 02:05:42 +0000
Received: from DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c]) by DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 02:05:41 +0000
From:   zhaoxinchao <ChrisXinchao@outlook.com>
To:     vbabka@suse.cz
Cc:     ChrisXinchao@outlook.com, akpm@linux-foundation.org,
        bagasdotme@gmail.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com,
        zhaoxinchao <chrisxinchao@outlook.com>
Subject: [PATCH v3] mm: Fixed incorrect comment for _kmem_cache_create function
Date:   Tue, 18 Apr 2023 10:05:23 +0800
Message-ID: <DM6PR22MB1836E82FB689EE68B8065C47C59D9@DM6PR22MB1836.namprd22.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <24a0219d-b0a1-8b81-ff98-2fff107650c3@suse.cz>
References: <24a0219d-b0a1-8b81-ff98-2fff107650c3@suse.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Irbyp9mYYNHvokVT2q/OGzpn/2NHnZPp]
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To DM6PR22MB1836.namprd22.prod.outlook.com
 (2603:10b6:5:25e::21)
X-Microsoft-Original-Message-ID: <20230418020523.18751-1-ChrisXinchao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR22MB1836:EE_|PH7PR22MB3615:EE_
X-MS-Office365-Filtering-Correlation-Id: 54577834-2f33-4b8e-955f-08db3fb169ac
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmofvZvLhntBlNaxIR7rLBomn77l1A8uQl7OdzufGCdp0iZXnQKNvC67c9jovCoYGyD1MQOjb1e9BuBODeRvo8jX1nxzmh3WGIQbZtoR4ERA3uBwFV4I6G7T3Z7DPRBtz+8noyHzR6FWawcizu1kqG2gRAK8nJzdJGCGBmgv5mEpXUmvqm+OhVi29kpIzbbzVonsFCARwy3KQqomZJK6iQRaFYgMYjquhbmKQWuPNNcFE3DCVqeahbhV92baVdcrx9T/FTD4kKL4qnHwRkJaN1aNkbY41NI+c/fRO8fhGncuoh+dS8seKCpGMGnTqGnO0iMmzyReKSKAR2Wy+UhUegG7vIqKDdR3fIy9wYUvmHgToEGtRYXZyUrfD9sXn3LSMK47VQrD+G+IvooG03vxIKC+jXZfG/gZ88sSRqA3IKyd0QnALD+JLMpL/E37VTivBXalbodYw9hLS17RZ1FBF0u6K6DhPxw/vtRsKC9b4e2R6toXUr/CNo+tWoZu9x0iLr2/96dHhUDOElbdCCj61DkwBw1htFjmFh9I+e6e6Tim0BADc6ggtYeWTn2mgKXeBnXQn47Lf2nv+7+bbWvpwSb/GAxgh2jXXDDlpW0jrH8c9vtMHh1mmzVrMW/Rlu7ID9uXXWaXIVCKeT439/iA0u7jCJiwqLTs8R5oWkBvHNR49/tCvFl68OXTX/q134J05EctZdquvjbU1+VGYB2DFUHZg7Qq4Wf/BuDRBVn3A+AiROSd5l29T3+g5g+7qhfK/yg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxZKgAayqWK1GwoNFn9ozelxrMYGD0riTBM0UnE9meYYnMhTtvHmXV7ockAiYyKIXaW9BsnbVTHUPOH4phyQwiE9Xv+DIrf+my8tI5+ZuYVPIyvbzFxzfLxKJLFQxIWN9k2VnnCHShSpmiFX2OZBGBmvGDc4uZAjbwzn/auPovcrRrQqsuvnlzAxyow6EztXVIVeyiVx8Hg0TIVCdkYvPSfz9AfygZ67cDATSGbuWsJpMx6ZPM6wm8Mu4BVjnsgo+H6JRSXGdwBKMBuNNhHzE0iIW+RvpnOIZ8maixiNHKFCjk1bVZFZF0qhdW7RF7awMHL1CMgI2wS8rcr5aGjlcTjes0wuGacF1S7MhNm6swFgCjLZh2VEGTBoGcfDT7g2FEsUpO7kw2MOrHHkoUF2of9iXUZOzK7SWjg8QrJROc+3PcTWaigQCjp7EQ3P69hYjdMGnR5mRrHgu5KWBWGSp+aGQRkWRnryafye3/w/h2sbFJumv3Zcq5J011XioJNDN8WVFf6z17WE8MSevECeOgYNlaW6KnqRQuPl+IAOgPPPsxXF34pFKKY2mTQmLh0dHcZv1li8pm6VMp5faak0c7TN//KjKTS5Bh8zwve1DOBaZyooH0SyrvBFBJ0dx1f1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lT5kewVICWJzJ411scFhWiLMjPhPuuHANhBj7rcCm/xjQfwM6T2tpdiUgHRr?=
 =?us-ascii?Q?M3VZ5+xrY4bLVga2n6pSZtsQnjCfLdZW+JaaFjqHBJMsx1qMAdm+Bda+2hCc?=
 =?us-ascii?Q?4xpQiHUUmILUqLT7NjcENzICSuFdI/b55ahw1KmX9QJ0pqfpvurJytJ0a4zD?=
 =?us-ascii?Q?AoBxLxv7kUjQ2tHs01mLTzJbaXMQ4p0qk2rCPDW7ZD8VNJVqA5Nm2RXzl/GH?=
 =?us-ascii?Q?/4+dZ/Ga+4ha4ksnZcDRTIAlxDOuRblmLxEgQ3FcfXr4J3z7dVJHQNNtXzMb?=
 =?us-ascii?Q?hGJOOLyKo4Hbht38jQAVcM41e+lVyqfUcGuuOnkrDZoRV6J27TeZTEUqk1rY?=
 =?us-ascii?Q?PHhhI69rcJBbhtJOycyJ+dl/+oZuFXHWkkZzBnORAVm5XkiKbXTJ2PyFySeJ?=
 =?us-ascii?Q?HLRGSjbeyM5eGVt9NafWvf+qCqZCg5MKkg/RBk74xOSYq+jS8JbFKjG85GhT?=
 =?us-ascii?Q?An2RnnZPBaOTLDHFYqdyvFTB4wT7RiJT9bUM35kdnQT9fQ8dzYHx97hkKBEL?=
 =?us-ascii?Q?uAzXlVDKngcwezU4SCsGhBi34+uKm9ck8+U+1uV/6st8ycX4Yg8jW7/E++Pl?=
 =?us-ascii?Q?9lrKruNn0YbnnfjbWVIY7GL9WBK8MQXm7qDt0xW7T0I63zhTux9evGJjaCnm?=
 =?us-ascii?Q?ZkdhaJkagb/PsaY0GQuzvufyHztcGyRDzcQ5KS4xR9BvtMR2qypowwBbXb/x?=
 =?us-ascii?Q?T2sDmrr/4tCvotXx4e0di1kDghNrqiwt7m6Bj0bT2NgAqiIra8ox54F2kBWk?=
 =?us-ascii?Q?ZUHqWvq+js7Z3GmDk1whqi4QhWc385ibK+wG89VTDVvEEf8C5AXBkhqSvFan?=
 =?us-ascii?Q?HA4Ug1FPUajbPo9iU6TsXdWF13X+GE7MLwYZYWn2nn97WidOdexIx8WPKUhP?=
 =?us-ascii?Q?ExcOR6Vog9yUn4zp5GjgvAFQXk6d45Ttyr9a827273awUaYVzUjELbrhIXiJ?=
 =?us-ascii?Q?y+GLp4oEnpYa/GHD6Pmswk+W525L4NQvLxas8EDBI7OUOPOh/BjxJ8QEKVjS?=
 =?us-ascii?Q?mf4vVvPz/ZF9fcSQc6npQ/enj1lboCMl9ka20Vuqkns7GbuHKakSM+wabuat?=
 =?us-ascii?Q?iM3H8qXUol3VMl7qXVcCh9aKdW9RnWdpBo55Ia1QGJJPAipRlw41KMMAubtI?=
 =?us-ascii?Q?kPSRNJuwOSb++uBniRRh7FX5jTZjY26jltmcvm9BXqpakCTXRgvp+cFuF6TT?=
 =?us-ascii?Q?tprDHSu3Xn9PRHCqpxxGc8eFQmMvBvIqGulI+dxlGG7peS7giFVoMPpwvUI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54577834-2f33-4b8e-955f-08db3fb169ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB1836.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 02:05:41.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoxinchao <chrisxinchao@outlook.com>

Actually __kmem_cache_create() returns a status :
0 is success
nonezero are failed.

This function has three return positions. In addition to successfully
return 0, the first failed position will return - E2BIG, and the second
position will return nonzero value for setup_cpu_cache function failure.

Signed-off-by: zhaoxinchao <chrisxinchao@outlook.com>
---
 mm/slab.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index edbe722fb..ebd326f07 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1888,14 +1888,17 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
 	return true;
 }
 
-/**
+/*
  * __kmem_cache_create - Create a cache.
  * @cachep: cache management descriptor
  * @flags: SLAB flags
  *
- * Returns a ptr to the cache on success, NULL on failure.
- * Cannot be called within an int, but can be interrupted.
- * The @ctor is run when new pages are allocated by the cache.
+ * Returns zero on success, nonzero on failure.
+ * This function has three return positions.
+ * In addition to successfully return 0, the
+ * first failed position will return - E2BIG,
+ * and the second position will return nonzero
+ * value for setup_cpu_cache function failure.
  *
  * The flags are
  *
@@ -1908,8 +1911,6 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
  * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
  * cacheline.  This can be beneficial if you're counting cycles as closely
  * as davem.
- *
- * Return: a pointer to the created cache or %NULL in case of error
  */
 int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 {
-- 
2.39.2

