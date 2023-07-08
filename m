Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C774BB73
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGHCka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGHCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:40:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F25170C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:40:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyZHD2gyRzqTwZ;
        Sat,  8 Jul 2023 10:39:52 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 10:40:21 +0800
Subject: Re: [PATCH v3 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
To:     Jiaqi Yan <jiaqiyan@google.com>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <duenwen@google.com>, <axelrasmussen@google.com>,
        <jthoughton@google.com>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-2-jiaqiyan@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0be87971-543d-4d39-850e-3d9160ffa5e2@huawei.com>
Date:   Sat, 8 Jul 2023 10:40:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230707201904.953262-2-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/8 4:19, Jiaqi Yan wrote:
> Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
> are deleted from the llist. Correct the way __folio_free_raw_hwp deletes
> and frees raw_hwp_page entries in raw_hwp_list: first llist_del_all, then
> kfree within llist_for_each_safe.
> 
> As of today, concurrent adding, deleting, and traversal on raw_hwp_list
> from hugetlb.c and/or memory-failure.c are fine with each other. Note

I think there's a race on freeing the raw_hwp_list between unpoison_memory and __update_and_free_hugetlb_folio:

  unpoison_memory		__update_and_free_hugetlb_folio
    				if (folio_test_hwpoison)
    	  			    folio_clear_hugetlb_hwpoison
    folio_free_raw_hwp		      folio_free_raw_hwp
    folio_test_clear_hwpoison

unpoison_memory and __update_and_free_hugetlb_folio can traverse and free the raw_hwp_list
at the same time. And I believe your patch will fix the problem. Thanks.

> this is guaranteed partly by the lock-free nature of llist, and partly
> by holding hugetlb_lock and/or mf_mutex. For example, as llist_del_all
> is lock-free with itself, folio_clear_hugetlb_hwpoison()s from
> __update_and_free_hugetlb_folio and memory_failure won't need explicit
> locking when freeing the raw_hwp_list. New code that manipulates
> raw_hwp_list must be careful to ensure the concurrency correctness.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Anyway, this patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.

