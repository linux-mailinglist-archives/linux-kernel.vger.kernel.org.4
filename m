Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3A743DED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjF3Owc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjF3Ow3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:52:29 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0A1996
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:52:28 -0700 (PDT)
Date:   Fri, 30 Jun 2023 23:52:17 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688136746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvLbC96VyN5eisvKhg3EHjlXU7OR/vXWQBGxVJFAJRM=;
        b=P901hNCVtCyn5iINIZhbUguRjZh1mux/fD+vcNpq706IRkR62tdZB3/aNzAwbMINXmJHsL
        Xmr/fmID9O5jcigfHHZHpsDqjuSsAmnlfllKoNpbgHbMAaMd3sYxcfAb8+2mQ67L9MTumi
        jDNsQEc3p+JVpT3dhImzP2TGqnXYoqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
Message-ID: <20230630145217.GA2213127@ik1-406-35019.vs.sakura.ne.jp>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-2-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-2-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:40:12PM +0000, Jiaqi Yan wrote:
> Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
> are deleted from the llist.
> 
> llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()s
> from __update_and_free_hugetlb_folio and memory_failure won't need
> explicit locking when freeing the raw_hwp_list.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

(Sorry if stupid question...) folio_set_hugetlb_hwpoison() also calls
llist_for_each_safe() but it still traverses the list without calling
llist_del_all().  This convention applies only when removing item(s)?

Thanks,
Naoya Horiguchi

> ---
>  mm/memory-failure.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 004a02f44271..c415c3c462a3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
>  
>  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  {
> -	struct llist_head *head;
> -	struct llist_node *t, *tnode;
> +	struct llist_node *t, *tnode, *head;
>  	unsigned long count = 0;
>  
> -	head = raw_hwp_list_head(folio);
> -	llist_for_each_safe(tnode, t, head->first) {
> +	head = llist_del_all(raw_hwp_list_head(folio));
> +	llist_for_each_safe(tnode, t, head) {
>  		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>  
>  		if (move_flag)
> @@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  		kfree(p);
>  		count++;
>  	}
> -	llist_del_all(head);
>  	return count;
>  }
>  
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 
> 
