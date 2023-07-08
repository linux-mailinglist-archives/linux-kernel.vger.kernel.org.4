Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472774BB7E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjGHC5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGHC5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:57:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567181999
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:57:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QyZcQ2khxzPk16;
        Sat,  8 Jul 2023 10:54:46 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 10:57:01 +0800
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Jiaqi Yan <jiaqiyan@google.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>
CC:     <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <duenwen@google.com>, <axelrasmussen@google.com>,
        <jthoughton@google.com>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com>
Date:   Sat, 8 Jul 2023 10:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230707201904.953262-3-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/8 4:19, Jiaqi Yan wrote:
> Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> hugetlb folio is a raw HWPOISON page. This functionality relies on
> RawHwpUnreliable to be not set; otherwise hugepage's raw HWPOISON list
> becomes meaningless.
> 
> is_raw_hwp_subpage needs to hold hugetlb_lock in order to synchronize
> with __get_huge_page_for_hwpoison, who iterates and inserts an entry to
> raw_hwp_list. llist itself doesn't ensure insertion is synchornized with
> the iterating used by __is_raw_hwp_list. Caller can minimize the
> overhead of lock cycles by first checking if folio / head page's
> HWPOISON flag is set.
> 
> Exports this functionality to be immediately used in the read operation
> for hugetlbfs.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  include/linux/hugetlb.h | 19 +++++++++++++++++++
>  include/linux/mm.h      |  7 +++++++
>  mm/hugetlb.c            | 10 ++++++++++
>  mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
>  4 files changed, 60 insertions(+), 10 deletions(-)
> ...
> -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> +bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
>  {
> -	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> +	struct llist_head *raw_hwp_head;
> +	struct raw_hwp_page *p, *tmp;
> +	bool ret = false;
> +
> +	if (!folio_test_hwpoison(folio))
> +		return false;
> +
> +	/*
> +	 * When RawHwpUnreliable is set, kernel lost track of which subpages
> +	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> +	 */
> +	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> +		return true;
> +
> +	raw_hwp_head = raw_hwp_list_head(folio);
> +	llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {

Since we don't free the raw_hwp_list, does llist_for_each_entry works same as llist_for_each_entry_safe?

> +		if (subpage == p->page) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	return ret;
>  }

It seems there's a race between __is_raw_hwp_subpage and unpoison_memory:
  unpoison_memory		__is_raw_hwp_subpage
   				  if (!folio_test_hwpoison(folio)) -- hwpoison is set
    folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp_list
      llist_del_all                 ..
    folio_test_clear_hwpoison

But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory couldn't reach here because there's a
folio_mapping == NULL check before folio_free_raw_hwp.

Anyway, this patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.

