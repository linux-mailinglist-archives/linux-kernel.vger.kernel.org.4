Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3787E6E102F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDMOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDMOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:51 -0400
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96675585
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396556; bh=X9rNsbyg8P2zc9bEIgObTak89L4pwM16nNASnZu43Cs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WOd2wAMW+qWyWk2cozpwKyj07x00lw52yUR5HaZdPGBbmkRAsTWGwqtV4xojlHTRU
         lrn2hlJ0NoQXTg/RXGrmpXYosF0+ezrHGt6IvOMYzpxxh0gWREg8Exc5Ll4cgJ6QpN
         WFuOLwbBjXRATVVksmR+4UgxmIFNurKRNZax42wcu13DClam0KAovkAc4dbIb7KIil
         5evduAa7H3S4EyyGES25mPnXNjuR+FY6LJ8ALnPYP7zkmHkoswxvMea3Ln8HZsqRad
         WKV4ZpV7JX8ZnLUOwJg1kHzSuSNFoUeuPsyIi1ziiNT7RjrJR6CrMg+Fhcrcay2kYH
         V94yuCgc8bh/A==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 2010B18065F;
        Thu, 13 Apr 2023 14:35:50 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 4/5] slub: Remove slabs_node() function
Date:   Thu, 13 Apr 2023 22:34:51 +0800
Message-Id: <20230413143452.211250-5-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
References: <20230413143452.211250-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kXvLyGF-H8usFLhMixCBzmU7tdwWLDs3
X-Proofpoint-ORIG-GUID: kXvLyGF-H8usFLhMixCBzmU7tdwWLDs3
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304130130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

When traversing nodes one by one, the get_node() function called in
for_each_kmem_cache_node macro, no need to call get_node() again in
slabs_node(), just reading nr_slabs field should be enough. However, the
node_nr_slabs() function can do this. Hence, the slabs_node() function
is not needed anymore.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d897df8fe7e7..33b4fec6bc7a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1344,14 +1344,6 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 	list_del(&slab->slab_list);
 }
 
-/* Tracking of the number of slabs for debugging purposes */
-static inline unsigned long slabs_node(struct kmem_cache *s, int node)
-{
-	struct kmem_cache_node *n = get_node(s, node);
-
-	return atomic_long_read(&n->nr_slabs);
-}
-
 static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
 {
 	return atomic_long_read(&n->nr_slabs);
@@ -1722,8 +1714,6 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 #define disable_higher_order_debug 0
 
-static inline unsigned long slabs_node(struct kmem_cache *s, int node)
-							{ return 0; }
 static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
 							{ return 0; }
 static inline void inc_slabs_node(struct kmem_cache *s, int node,
@@ -4599,7 +4589,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n)
-		if (n->nr_partial || slabs_node(s, node))
+		if (n->nr_partial || node_nr_slabs(n))
 			return false;
 	return true;
 }
@@ -4616,7 +4606,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
-		if (n->nr_partial || slabs_node(s, node))
+		if (n->nr_partial || node_nr_slabs(n))
 			return 1;
 	}
 	return 0;
@@ -4829,7 +4819,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 		list_for_each_entry_safe(slab, t, &discard, slab_list)
 			free_slab(s, slab);
 
-		if (slabs_node(s, node))
+		if (node_nr_slabs(n))
 			ret = 1;
 	}
 
-- 
2.30.2

