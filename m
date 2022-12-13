Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39F464BCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiLMTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiLMTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:14:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B211028
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:14:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D27B815B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33585C433EF;
        Tue, 13 Dec 2022 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958865;
        bh=+A016sYxaSG/q1QGBoJdS9q5imi3Rt/lWMe4htZ9ico=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amY2ykOojrQ4Jx8/+f2rWFfU1kM8bAQ0G2oCuTiZZm3NYNh8y4h7/aSo/lYlxfmNo
         1ApivF2IWFWlPLlSBb5Zsl3yF0ePB0SPdIqM5f/ScGaoSwzz3PQ81HuTPdI9n1oINi
         jxi+c13+rg2O9Zp5hgJTgt+vJez04N1+3ycjA2+31veH5L/TUuLWcVuFR6vTqHADzw
         hN4ohCP1dbKZC/xo0TXWopoN/Ex7SEDKjeOzSc4Q7ezaf5tuF8bDCryduRRFHYmZiE
         8p3KWT0/ggmALc2HIClROyatr9C9ehvCrzCibhLC9+8k2zl4VzBB2EKlk/biPzwWon
         P90JhLcN53DTA==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        vishal.moola@gmail.com, willy@infradead.org
Subject: Re: [PATCH -next 2/8] mm: page_idle: Convert page idle to use folios
Date:   Tue, 13 Dec 2022 19:14:22 +0000
Message-Id: <20221213191422.138595-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213092735.187924-3-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 17:27:29 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> This change and rename all page related function to use folio,
> which save many compound_head() calls and kernel text.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/page_idle.c | 91 ++++++++++++++++++++++++--------------------------
>  1 file changed, 44 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index bc08332a609c..38641f94cf49 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -19,34 +19,33 @@
>  #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
>  
>  /*
> - * Idle page tracking only considers user memory pages, for other types of
> - * pages the idle flag is always unset and an attempt to set it is silently
> + * Idle folio tracking only considers user memory folios, for other types of
> + * folios the idle flag is always unset and an attempt to set it is silently
>   * ignored.

I think this might make future readers confused, as the code and comments will
call this subsystem as Idle _folio_ tracking while the user interface and the
document calls it as Idle _page_ tracking.

>   *
> - * We treat a page as a user memory page if it is on an LRU list, because it is
> - * always safe to pass such a page to rmap_walk(), which is essential for idle
> - * page tracking. With such an indicator of user pages we can skip isolated
> - * pages, but since there are not usually many of them, it will hardly affect
> + * We treat a folio as a user memory folio if it is on an LRU list, because it is
> + * always safe to pass such a folio to rmap_walk(), which is essential for idle
> + * folio tracking. With such an indicator of user folios we can skip isolated
> + * folios, but since there are not usually many of them, it will hardly affect
>   * the overall result.
>   *
> - * This function tries to get a user memory page by pfn as described above.
> + * This function tries to get a user memory folio by pfn as described above.
>   */
> -static struct page *page_idle_get_page(unsigned long pfn)
> +static struct folio *folio_idle_get_folio(unsigned long pfn)
>  {
> -	struct page *page = pfn_to_online_page(pfn);
> +	struct folio *folio = pfn_to_online_folio(pfn);
>  
> -	if (!page || !PageLRU(page) ||
> -	    !get_page_unless_zero(page))
> +	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
>  		return NULL;

As Matthew also mentioned, you changed the behavior.  It looks like a right
behavior if we call this function folio_idle_get_folio(), but it shouldn't.
page_idle_get_folio() would be a better name in my humble opinion.

So, unless we're gonna change the behavior of this subsystem (which wouldn't be
the case as it would break users), I think it would be better to keep the name
of this subsystem as Idle page tracking and avoid unnecessary renaming changes.


Thanks,
SJ
