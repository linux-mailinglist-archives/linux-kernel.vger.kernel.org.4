Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F271F846
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjFBCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjFBCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:04:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77C13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:04:12 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bb1f7c5495dso681868276.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 19:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685671451; x=1688263451;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCcxbg1bQzNzz4zV3L4CYnjxVJDn7WF99eWd0RhC9gQ=;
        b=uZEZ9I4SLH1dlvMbX8X232jV2a6mEUAYnYF9uDPjQM+PANZunW0QZTTyUw8u1T3YWG
         4cBtg02hKcb7r/AuZoRbGwOEcWVfxG4lTX3udWSzd1xlZKxiTaO+3DVyGmR68d6/scx7
         hYEfRGkahyTeJtFQt20JM0GjK8qjSJWf10R9NDnYDqrJeAAgoRuh5Wv9h+McDCj+ZS8o
         LEV4frNQ0AXm6IAVZRd1ykIyACwgZz0y18fDssxBrzp/xt1ajAUDW/iWeAYw8JUZEUFt
         8AYDseWC3qGwtP74WZcToJI/3BDRRctR9GL5sdFZ80I0y/hJZ+FTX3FHx0TFlFbZf4QJ
         vVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685671451; x=1688263451;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCcxbg1bQzNzz4zV3L4CYnjxVJDn7WF99eWd0RhC9gQ=;
        b=g4l6t0m7n965Gx39GFUp9PLWf/PYB8JTYuY8atMhThcf/lBwGQvAWCa2RKjTid+JCo
         y9c12aLSHoxpLKqSaXiUjt/6O/p349Zq9tTnjAo4VXx+tL5+zf0Ufis39EnUNB+iu6tv
         pRDCR23aqyct84wbQ3X0jzO6DZ6frNp26HurBR8edCwS4Bj5/FOu8WJetsBq/kDYHywR
         FjsR72wPlv9k0pzXI7GpFTAEsN5qQf6dQgOtSlgB1XTSzV3sgUhAc6Yb+aK+LeMs+rmJ
         r7ThNOEYrzqievEhhWt+B0SyU3JPi6r5Iw7SCBeGYFrn8ceI/aYx1Qspkx8jTG1+SSgO
         ogMw==
X-Gm-Message-State: AC+VfDwvnfJre4yg28DiH/ShUzo+WxDO5B8GRkjfIxFFs1Vd42T9io0w
        agVjYGynKXzEKuIBu8QoPS7aFIVITAuqVep1jpYHFw==
X-Google-Smtp-Source: ACHHUZ7cSz/3Q2+GAwI7pileTRngRCvmiyPZ4KAtjKHKH/bCRZY+qRGiC3qltSr+oaCo8G9RsBDLMw==
X-Received: by 2002:a81:8a85:0:b0:55a:84c9:e952 with SMTP id a127-20020a818a85000000b0055a84c9e952mr10644248ywg.17.1685671451359;
        Thu, 01 Jun 2023 19:04:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l16-20020a81d550000000b00561e2cb2d3bsm36258ywj.23.2023.06.01.19.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:04:10 -0700 (PDT)
Date:   Thu, 1 Jun 2023 19:04:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Wupeng Ma <mawupeng1@huawei.com>
cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        hughd@google.com, n-horiguchi@ah.jp.nec.com, jmarchan@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH stable 5.10/5.15] mm: Pass head page to clear_page_mlock
 for page_remove_rmap
In-Reply-To: <20230529123705.955378-1-mawupeng1@huawei.com>
Message-ID: <25befa-bef0-467a-3e7-e331131d011@google.com>
References: <20230529123705.955378-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Our syzbot report a mlock related problem. During exit_mm, tail page is
> passed to clear_page_mlock which final lead to kernel panic.
> 
> During unmap_page_range, if compound is false, it means this page is
> seen as a small page. This page is passed to isolate_lru_page if this
> page is PageMlocked and finally lead to "trying to isolate tail page"
> warning.
> 
> Here is the simplified calltrace:
> 
> unmap_page_range
>   zap_pte_range
>     page_remove_rmap(page, false);	// compound is false means to handle
> 					   to small page not compound page
> 	  nr_pages = thp_nr_pages(page);
> 	  clear_page_mlock(page)	// maybe tail page here
> 		isolate_lru_page
> 		  WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
> 
> Since mlock is not supposed to handle tail, we pass head page to
> clear_page_mlock() to slove this problem.

Your patch looks plausible for stable, and might even end up as the best
that can be done; but I think you have not root-caused the problem yet
(and until it's root-caused, there is likely to be other damage).

5.15 and 5.10 were releases with the PageDoubleMap flag, and the intention
then was that a compound page with PageDoubleMap set could not be Mlocked,
and PageMlocked had to be cleared when setting PageDoubleMap.

See, for example, the line in the old mlock_vma_page()
	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
before it did the TestSetPageMlocked().

So it should have been impossible to find PageMlocked on a Tail page
(even with PageMlocked redirecting to the head page to look up the flag)
there; so unnecessary for clear_page_mlock() to use compound_head().

Since nobody reported this problem before, my suspicion is that a commit
has been backported to 5.15 and 5.10 stable, which does not belong there.
Or perhaps the stable trees are okay, but your own tree has an unsuitable
backport in it?

> 
> This bug can lead to multiple reports. Here ares the simplified reports:
> 
> ------------[ cut here ]------------
> trying to isolate tail page
> WARNING: CPU: 1 PID: 24489 at mm/vmscan.c:2031 isolate_lru_page+0x574/0x660
> 
> page:fffffc000eb7a300 refcount:512 mapcount:0 mapping:0000000000000000 index:0x2008c pfn:0x3ede8c
> head:fffffc000eb78000 order:9 compound_mapcount:0 compound_pincount:0
> memcg:ffff0000d24bc000
> anon flags: 0x37ffff80009080c(uptodate|dirty|arch_1|head|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
> raw: 037ffff800000800 fffffc000eb78001 fffffc000eb7a308 dead000000000400
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> head: 037ffff80009080c fffffc000eb70008 fffffc000e350708 ffff0003829eb839
> head: 0000000000020000 0000000000000000 00000200ffffffff ffff0000d24bc000
> page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled())
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24489 at include/linux/memcontrol.h:767 lock_page_lruvec_irq+0x148/0x190
> 
> page:fffffc000eb7a300 refcount:0 mapcount:0 mapping:dead000000000400 index:0x0 pfn:0x3ede8c
> failed to read mapping contents, not a valid kernel address?
> flags: 0x37ffff800000800(arch_1|node=1|zone=2|lastcpupid=0xfffff)
> raw: 037ffff800000800 dead000000000100 dead000000000122 dead000000000400
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(((unsigned int) page_ref_count(page) + 127u <= 127u))
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:1213!
> Call trace:
>  lru_cache_add+0x2d4/0x2e8
>  putback_lru_page+0x2c/0x168
>  clear_page_mlock+0x254/0x318
>  page_remove_rmap+0x900/0x9c0
>  unmap_page_range+0xa78/0x16a0
>  unmap_single_vma+0x114/0x1a0
>  unmap_vmas+0x100/0x220
>  exit_mmap+0x120/0x410
>  mmput+0x174/0x498
>  exit_mm+0x33c/0x460
>  do_exit+0x3c0/0x1310
>  do_group_exit+0x98/0x170
>  get_signal+0x370/0x13d0
>  do_notify_resume+0x5a0/0x968
>  el0_da+0x154/0x188
>  el0t_64_sync_handler+0x88/0xb8
>  el0t_64_sync+0x1a0/0x1a4
> Code: 912b0021 aa1503e0 910c0021 9401a49c (d4210000)
> 
> This bug can be reproduced in both linux-5.10.y & linux-5.15.y and maybe
> fixed after commit 889a3747b3b7 ("mm/lru: Add folio LRU functions").
> This patch turn page into folio for LRU related operations, all
> operations to page is turn to folio which means head page after this
> patch.

No, that commit is not likely to have been a fix for this issue.
If there ever was such an issue in the 5.15 and 5.10 trees, it would
more likely have been fixed by the munlock changes in 5.18, or by the
removal of PageDoubleMap in 6.2.

> 
> Fixes: d281ee614518 ("rmap: add argument to charge compound page")

Perhaps, but I think an inappropriate backport is more likely.

> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 330b361a460e..8838f6a9d65d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1372,7 +1372,7 @@ void page_remove_rmap(struct page *page, bool compound)
>  	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
>  
>  	if (unlikely(PageMlocked(page)))
> -		clear_page_mlock(page);
> +		clear_page_mlock(compound_head(page));
>  
>  	if (PageTransCompound(page))
>  		deferred_split_huge_page(compound_head(page));

And what about the clear_page_mlock() in page_remove_file_rmap()?

Thanks,
Hugh
