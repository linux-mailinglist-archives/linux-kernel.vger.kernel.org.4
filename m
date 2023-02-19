Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030A69C155
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjBSQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 11:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBSQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 11:29:09 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF8CA36
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 08:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNiNiyHf9npPwATPvvX6VJ1MwkOvyW5KWv2tHMMgDI/SkByS7rKBolWHQfllPXHpg1CbwHLms7k8NhEfjaUhthQx6BlUrcFltqCmWkkpIsi2TTYt3B68pcz58HOPyr0ZMhkTGXlPd0ZEio4QUlkXrK2SFu68S0OMvtdUYbn4Km+HHr85XN8EhESpFpYdEWaomtRPUFgQyaf6zOoLJdj7FNlaYENgTaj+1fZsvUESCstrZMLZVzLBt3/mS8YN+tfozj8y2Nxn3uO45Wyppjuish4s+R1SwuC46bUJGUsnt/1NcU4PkLFra737Zh8VNvw/21EE9J4vKq4bz/Zue4s3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF/Gp2tqi7QK3FUMfJ2DfKRSMD/bqQNxGdWGyyXBTVE=;
 b=dxY8NjFValrprHf5AyJDht+66tEdJ+kJhXfAlFi7Bh0Hcv10s8d7ERG7FnfZ3W4hcC90POcdcVSfQfJ0X25eQ2CqT+5vcjOIQyVUCFzDjLsdfBrcN5pV38H37DYBv6SF2vdkcPq0jvDOe6I8u8vfp+x5yjeJZbRjJxqt5C/EQb3F8FYqjvLgz59UVXjEBsSHPJ5PpK0Tgp8vX3lBjxylk4yHD8HhmAlEI1lCVFrF+15x5vcAca+X0onyFB8QOqfWWmlfFnn5myksub3juyAVWYd5EoiM53DM7jAR4RZQr0ipAzIsQUt50nIukpQKMVNwbvbICFTNxNFhdRWZ6o7gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF/Gp2tqi7QK3FUMfJ2DfKRSMD/bqQNxGdWGyyXBTVE=;
 b=IIiZebi9IMXusfXGSrLuSSST5QBtQ5xfNKJL3RcEX/3BQE23raCJVy017/ypUMwqAtJcCyLqTQOBtnQo4A60VbrbPEydAYTi538gmhsv9eoLWQI7s9BwPmcaeu50GVr6zpGgiSisUHLO9Tduy4PcF/0Ar2zup/8Oi0XsULDrHynKwnsd3GRNGj52PJTFnNRX8fkpho4+hkRvn4YH21u6yoEd+/k+GVENURq75VyfpN05vhEPiXg4589Nabw3ndMrJgJMBFMmPUUHEQZ+JaNgSNuxZfCe0QShoBY7WAxHqohbrnh8szDo8j5bXjyy445znlhJ5p6kDKwzUdS4X51mUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.polimi.it;
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
 by AS4P251MB0775.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:507::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Sun, 19 Feb
 2023 16:29:04 +0000
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff]) by GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d332:f1b9:334f:eff%9]) with mapi id 15.20.6111.018; Sun, 19 Feb 2023
 16:29:03 +0000
Date:   Sun, 19 Feb 2023 17:28:46 +0100 (CET)
From:   Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
To:     rppt@kernel.org
cc:     remckee0@gmail.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add tests for memblock_alloc_node()
Message-ID: <59d4745b-7b2-bf6-7b8-f6571d78d336@mail.polimi.it>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: ZR2P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::13) To GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP251MB0767:EE_|AS4P251MB0775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a87fb09-e589-4e5b-b4a6-08db129669e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6Ld+FAgjxR8ZdkronhK1mlPI/75GCjS6lT5lWwDnY0Gd9dv2dGyaoG0SODi8YvmJtj74S3NO1AQLX2Wag65obVKEOSs1AlV38c4rWUgH1NEPh+x6AondRLpd2SskNvLPmsv6I6DhMTIMAK69VyUp5TXdw2Skd7SK+Z35LzngIAsnB+0D3fgtSf4K2kgiI2uwdaTEkUdUS9HFQ5q8u0WGlDmLXp3r933sIYviclkWEU84nhL1RRmQdafIri4COhZI77ImgRQId1GnhTdLJD460pj0oN6UcOLIj9R2Oa1e1ToYJYfHX4v6tBEY6ZKa3S+1scRjZhQS/TzHzWhXvJdZ1yEVTIg0kRvziDqLUqc1u3HmWG1IXHxbtFowqMj2cwrYJ+InBHfkrZ54CGV60wttB9Pr8hmBDIWtDUg0SQ1qyKj+1PCCzKC2rxHV7XquXO4fVaeKN/0nPQ5ijyvVyGYJ5c7O4frR8cfdv/rToINdcj1YymfspBxNbp1EY8vMeBnNk+TxV+lCtjQRWf0YW3zVLk5WUCyJEYIO1xK5RX00HV87xm7A10N2fxZf94RZeAha/XH2CQsqzLOSoVPqimQ9a6tVW1JDVWbGqXGB58Hud3XQvkNR5mqAO2H6qRBp1+HjtQSBc//zwxVHj1uW5TwJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP251MB0767.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(2616005)(83380400001)(44832011)(2906002)(478600001)(6666004)(6486002)(186003)(26005)(6512007)(86362001)(38100700002)(6506007)(5660300002)(4326008)(6916009)(41300700001)(8936002)(66946007)(66556008)(66476007)(786003)(41320700001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1YTsPddnXDj7gpA9/zzInAFAoZmqq7KBbIJXLhMxy/S+Zt4TtC2GHibGFtK?=
 =?us-ascii?Q?joGJn7OIaqLVD7X7A3OdVk5CNa9zgHBAdO3Tot8fBdxx45yrbFQ7x4BECsoo?=
 =?us-ascii?Q?MwkG0cDhkxpcxpFb5SMeRaGcT7d4pd2powR2395/wkpiSQiYBCTpyJb4Vyhx?=
 =?us-ascii?Q?wbBZN8dooPvFiX5RpNBtLBxNSvfPoKGpht0bL4T0LouqK59Wl8utRogP1fxW?=
 =?us-ascii?Q?C1ytr5M4gmRrwI0Miab8rObA1fChqDDJRPJ35dvsaFlwb33UE/EaIlqAbnU1?=
 =?us-ascii?Q?elcH05a7m2UsSBw5sGvDpflRAZT4dJHGDhzeBhGt30F1DDT2o47Cfy/EovLi?=
 =?us-ascii?Q?IYe5a4KxhYTjEjcNP9UjA20uw79NI1PXB/2th/Zby0NIJXvK2X+c411LWbJZ?=
 =?us-ascii?Q?EAr9q9gjrOgxRGD4qatu1ld7F828P3JmWqKRLD7yBT8jCQZNpxQC0P45MbfG?=
 =?us-ascii?Q?7hXE1Vf0qZOjD2dVL6fPZgj2iCOX4cYgYlh4d6SVCr7rDacRxblNON2/07nM?=
 =?us-ascii?Q?roVfZ/qsyQd04mEk/iI8tiTKFineoP5z9RA6pVI/6xIkpcEyS5pp/IHGbePk?=
 =?us-ascii?Q?MqXZUoSaITiSsykVWaBe7MRP6Y78QI9CWI/kl29FsxcnlnECiFMHGm7rkZCG?=
 =?us-ascii?Q?yR+w+ZcAswuz1wzI6TBty69JgOgPDqHCv1OKoSOOK+amAs0TXwXuWZBd9g63?=
 =?us-ascii?Q?4Ub1AVSE88hHFOcPG1f4eubAe2bb8AwysbkxFCLvByr+XQdgnN4koZj8dMn8?=
 =?us-ascii?Q?7hYbEF22J4de4d97eq2vZxcDDj6FFHQjytmsGwPjqIAylgAD1xvbTTYtwAh0?=
 =?us-ascii?Q?YZJRk+l9YrEcA9CAlEALeM9TUP/U+cSg9eNlfNfWwChqxIIS948pPiB55NSW?=
 =?us-ascii?Q?e8ufgOnUaNJ0jYTeHxPu+CMSmKJYeMWf1Eafmwc8IS0Bex2Duz9q5qYgnGCU?=
 =?us-ascii?Q?yLQkWKw1rwN8/cFSBVk9VFGkgS+Yw5M5gs7mBllNGZjFYghnL4NTwj0QH4ry?=
 =?us-ascii?Q?x7Qql5K4BhtHwNRAhMlC6XeLUD9oeY35dTYmgVwslHA4RrnWIiqw7BwdE6CU?=
 =?us-ascii?Q?OaKvtxjFCxk3E8lUHtsdLvP0FJZGC4yY6tf4Mwuw5v4qe0hVQ+kFpMF0s3Hs?=
 =?us-ascii?Q?vfUnfj/kC9s1lH1PM1E8n/QgR4YKpd9fKrL5EgZ3f57fmA+hUzKvE9Eih5Yu?=
 =?us-ascii?Q?jZlj+YwJpNm1vbenRdUAh3ecIaf9O5m67pNX3gx6OPUnWRMivQaWLAWKQBHj?=
 =?us-ascii?Q?ZzYSqSFwzYLbXShcsZPrDLo/5at8C4eeZpBMFa2vjG81a/biIfAtfhM4S061?=
 =?us-ascii?Q?92t+cImN2nXZq9VGLvZn+bwulfGnEA8HCL9leLmZzQQRN38jnM5DssWdoWvs?=
 =?us-ascii?Q?x1OsPlSZ85IYn30CYHVddxah5t/YPCgxW1alt7pcP39d1B7UWQLEAXiwwu//?=
 =?us-ascii?Q?oCwcW6Sd7GL7ybJfI5M1TJfW3pWGaNErsUSMH3Jb5XFIsbgxaaAIHk+wQlgO?=
 =?us-ascii?Q?XSJrfMAkgO9/+3e050lEUmeqwzFViFvY6zknukJDK4oh8cr/vxMG8ICoLZ/2?=
 =?us-ascii?Q?WOUr9UlcUCcPGcr3Hmau7uaYDsxtWq5jmdsLu5BI?=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a87fb09-e589-4e5b-b4a6-08db129669e1
X-MS-Exchange-CrossTenant-AuthSource: GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2023 16:29:03.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnVzX1Zr5Xved7E3m/pBzXCu35mzeWfNfLh5YZckehPnY4OUdhrbKI82oYJE/nVYYsY4MuaFFnPnuZ3YHnKvkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0775
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 	- Use the memblock_alloc_node() directly without mimicking it

  tools/testing/memblock/tests/alloc_nid_api.c | 40 ++++++++++++++++++++
  1 file changed, 40 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 49ef68cccd6f..975a5317abf3 100644
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
