Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0156A8730
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCBQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCBQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A967497E4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4042B8121B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C19C433EF;
        Thu,  2 Mar 2023 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677775628;
        bh=Bfaxg0viKwM69JDI9XacTFnWsfSPRHkmBeTe0jCJjhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGmuCBI35YMYdj1qVKjiffrckevG0q4jBIGfhm3EB5st05tld1r7r/+8Ufq0To4Vb
         HnvW2i0wvozPC7dbaBrgO+RLpdgSIaVGLOcrXnrY/sB5ONOar5qnpu3XNZHGz4SugF
         kxxzQJEePbcEFKG53xu2/J03kt8cXBkzT/RJRSxsgT7eW3dPipwKFHNoMwWvEcHlt/
         qmugQgBHieDf/EBVSfDaFKK+GU/QlD1u/QPxlf1drG5mu9noMM5aatTh1cbx0xvpHJ
         wyKCidm72tG42CB+y/k/m04q9B6PyE7XeLdj3dD4SuXl3uLZfBF9r1tZwPGluZ+n1y
         j7fDEjh+dmxCg==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH -next] mm/damon/paddr: minor refactor of damon_pa_pageout()
Date:   Thu,  2 Mar 2023 16:47:06 +0000
Message-Id: <20230302164706.85999-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302144926.40012-1-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Thu, 2 Mar 2023 22:49:26 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Omit two lines by converting if(!folio_isolate_lru()) to
> if(folio_isolate_lru()).
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/paddr.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6c655d9b5639..a557f3c9300f 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -246,14 +246,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> -		if (!folio_isolate_lru(folio)) {
> -			folio_put(folio);
> -			continue;
> +		if (folio_isolate_lru(folio)) {
> +			if (folio_test_unevictable(folio))
> +				folio_putback_lru(folio);
> +			else
> +				list_add(&folio->lru, &folio_list);
>  		}
> -		if (folio_test_unevictable(folio))
> -			folio_putback_lru(folio);
> -		else
> -			list_add(&folio->lru, &folio_list);
>  		folio_put(folio);
>  	}

This looks ok to me, thank you for your effort!  Nevertheless, I don't like
increasing depth as much as number of lines.  The
more-than-3-levels-of-indentation[1] warning is not always right, but this 4
levels of indentation is not making me so exciting.

What do you think about adding put_continue label and using it, not only here,
but also above part?  For example:

    --- a/mm/damon/paddr.c
    +++ b/mm/damon/paddr.c
    @@ -239,21 +239,18 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
                    if (!folio)
                            continue;
    
    -               if (damos_pa_filter_out(s, folio)) {
    -                       folio_put(folio);
    -                       continue;
    -               }
    +               if (damos_pa_filter_out(s, folio))
    +                       goto put_continue;
    
                    folio_clear_referenced(folio);
                    folio_test_clear_young(folio);
    -               if (!folio_isolate_lru(folio)) {
    -                       folio_put(folio);
    -                       continue;
    -               }
    +               if (!folio_isolate_lru(folio))
    +                       goto put_continue;
                    if (folio_test_unevictable(folio))
                            folio_putback_lru(folio);
                    else
                            list_add(&folio->lru, &folio_list);
    +put_continue:
                    folio_put(folio);
            }
            applied = reclaim_pages(&folio_list);

It omits three lines.

    $ git diff --stat
     mm/damon/paddr.c | 13 +++++--------
     1 file changed, 5 insertions(+), 8 deletions(-)

[1] https://docs.kernel.org/process/coding-style.html#indentation


Thanks,
SJ

>  	applied = reclaim_pages(&folio_list);
> -- 
> 2.35.3
> 
> 
