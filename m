Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06157607226
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:27:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E2B1A4001
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:27:24 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtyBp6z82zVj56;
        Fri, 21 Oct 2022 16:22:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:02 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/3] mm: memory-failure: make action_result() return int
Date:   Fri, 21 Oct 2022 16:46:11 +0800
Message-ID: <20221021084611.53765-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check mf_result in action_result(), only return 0 when MF_RECOVERED,
or return -EBUSY, which will simplify code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ca0199d0f79d..3f469e2da047 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1182,14 +1182,16 @@ static struct page_state error_states[] = {
  * "Dirty/Clean" indication is not 100% accurate due to the possibility of
  * setting PG_dirty outside page lock. See also comment above set_page_dirty().
  */
-static void action_result(unsigned long pfn, enum mf_action_page_type type,
-			  enum mf_result result)
+static int action_result(unsigned long pfn, enum mf_action_page_type type,
+			 enum mf_result result)
 {
 	trace_memory_failure_event(pfn, type, result);
 
 	num_poisoned_pages_inc();
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
+
+	return result == MF_RECOVERED ? 0 : -EBUSY;
 }
 
 static int page_action(struct page_state *ps, struct page *p,
@@ -1856,8 +1858,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
-		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-		return res;
+		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 	}
 
 	head = compound_head(p);
@@ -1883,22 +1884,18 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		} else {
 			res = MF_FAILED;
 		}
-		action_result(pfn, MF_MSG_FREE_HUGE, res);
-		return res == MF_RECOVERED ? 0 : -EBUSY;
+		return action_result(pfn, MF_MSG_FREE_HUGE, res);
 	}
 
 	page_flags = head->flags;
 
 	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
-		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
-		res = -EBUSY;
-		goto out;
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		unlock_page(head);
+		return res;
 	}
 
 	return identify_page_state(pfn, p, page_flags);
-out:
-	unlock_page(head);
-	return res;
 }
 
 #else
@@ -2063,16 +2060,13 @@ int memory_failure(unsigned long pfn, int flags)
 					}
 					res = MF_FAILED;
 				}
-				action_result(pfn, MF_MSG_BUDDY, res);
-				res = res == MF_RECOVERED ? 0 : -EBUSY;
+				res = action_result(pfn, MF_MSG_BUDDY, res);
 			} else {
-				action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
-				res = -EBUSY;
+				res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 			}
 			goto unlock_mutex;
 		} else if (res < 0) {
-			action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-			res = -EBUSY;
+			res = action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 			goto unlock_mutex;
 		}
 	}
@@ -2093,8 +2087,7 @@ int memory_failure(unsigned long pfn, int flags)
 		 */
 		SetPageHasHWPoisoned(hpage);
 		if (try_to_split_thp_page(p) < 0) {
-			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
-			res = -EBUSY;
+			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -2127,8 +2120,7 @@ int memory_failure(unsigned long pfn, int flags)
 			retry = false;
 			goto try_again;
 		}
-		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
-		res = -EBUSY;
+		res = action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
 		goto unlock_page;
 	}
 
@@ -2168,8 +2160,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
 	 */
 	if (!hwpoison_user_mappings(p, pfn, flags, p)) {
-		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
-		res = -EBUSY;
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		goto unlock_page;
 	}
 
@@ -2177,8 +2168,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Torn down by someone else?
 	 */
 	if (PageLRU(p) && !PageSwapCache(p) && p->mapping == NULL) {
-		action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
-		res = -EBUSY;
+		res = action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
 		goto unlock_page;
 	}
 
-- 
2.35.3

