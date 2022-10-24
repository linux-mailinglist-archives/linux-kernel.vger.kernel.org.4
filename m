Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194B56098E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJXDcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJXDcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:32:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87D5F107
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:32:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwgW96VGCzmVRB;
        Mon, 24 Oct 2022 11:27:49 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 11:32:40 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 11:32:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm: memory-failure: make action_result() return int
Date:   Mon, 24 Oct 2022 11:51:38 +0800
Message-ID: <20221024035138.99119-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221021084611.53765-3-wangkefeng.wang@huawei.com>
References: <20221021084611.53765-3-wangkefeng.wang@huawei.com>
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

Check mf_result in action_result(), only return 0 when
MF_RECOVERED/MF_DELAYED, or return -EBUSY, which will
simplify code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: 
- MF_DELAYED is considered as success, suggested by HORIGUCHI
- adjust order between unlock_page(head) and action_result()
  after !hwpoison_user_mappings() to clean code more in
  try_memory_failure_hugetlb()

 mm/memory-failure.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ca0199d0f79d..3cfa1b9ac513 100644
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
+	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 
 static int page_action(struct page_state *ps, struct page *p,
@@ -1200,14 +1202,12 @@ static int page_action(struct page_state *ps, struct page *p,
 	/* page p should be unlocked after returning from ps->action().  */
 	result = ps->action(ps, p);
 
-	action_result(pfn, ps->type, result);
-
 	/* Could do more checks here if page looks ok */
 	/*
 	 * Could adjust zone counters here to correct for the missing page.
 	 */
 
-	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
+	return action_result(pfn, ps->type, result);
 }
 
 static inline bool PageHWPoisonTakenOff(struct page *page)
@@ -1856,8 +1856,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
-		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-		return res;
+		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 	}
 
 	head = compound_head(p);
@@ -1883,22 +1882,17 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
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
+		unlock_page(head);
+		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 	}
 
 	return identify_page_state(pfn, p, page_flags);
-out:
-	unlock_page(head);
-	return res;
 }
 
 #else
@@ -2063,16 +2057,13 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -2093,8 +2084,7 @@ int memory_failure(unsigned long pfn, int flags)
 		 */
 		SetPageHasHWPoisoned(hpage);
 		if (try_to_split_thp_page(p) < 0) {
-			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
-			res = -EBUSY;
+			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -2127,8 +2117,7 @@ int memory_failure(unsigned long pfn, int flags)
 			retry = false;
 			goto try_again;
 		}
-		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
-		res = -EBUSY;
+		res = action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
 		goto unlock_page;
 	}
 
@@ -2168,8 +2157,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
 	 */
 	if (!hwpoison_user_mappings(p, pfn, flags, p)) {
-		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
-		res = -EBUSY;
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		goto unlock_page;
 	}
 
@@ -2177,8 +2165,7 @@ int memory_failure(unsigned long pfn, int flags)
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

