Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD486A9F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCCSlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCCSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:40:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79336CA3F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8764B818F7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA85CC433D2;
        Fri,  3 Mar 2023 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677868767;
        bh=36+kEvSJeBiUlpNBhd6ZwIz+6aGArhfdJdUvPOwybOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTwfs1Y4oppNchmdXTk0x1fbjKInybQafPdgm4lcOZBZ9Z8434cwj3WqdHaU7ftPM
         faBmxklDElDTzu90emvaI4k25GIT6PpUFLLAhpruObd4YKelT7lZoIhv1F3RLGux2Q
         cImLi+jaCCFfkoWw85+0Kdi842UuD/Cy+yAcJOqQ47aPN/0YStqSAh9aw+EBMfB29d
         YiglP88TNaE3yI5jbyAMXZ2ANWyKHA6uAz/gBRTVH03B+UK0iZb74ZwGB+WjFIgjvL
         us5xb6GYlwdjsrHoWC2TUIZNGdW60vAibIuVENMS/tpuPrLWHpTpe3OSfmMqN5yNV3
         0HiuZBxzE7icw==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Date:   Fri,  3 Mar 2023 18:39:25 +0000
Message-Id: <20230303183925.113520-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303084343.171958-3-wangkefeng.wang@huawei.com>
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

On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Omit three lines by unified folio_put(), and make code more clear.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/paddr.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 3fda00a0f786..2ef9db0189ca 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
>  			accessed = false;
>  		else
>  			accessed = true;
> -		folio_put(folio);
>  		goto out;

Because you moved 'out' label to not include *folio_sz setting, folio_sz will
not set in this case.  It should be set.

>  	}
>  
>  	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
> -	if (need_lock && !folio_trylock(folio)) {
> -		folio_put(folio);
> -		return false;
> -	}
> +	if (need_lock && !folio_trylock(folio))
> +		goto out;
>  
>  	rmap_walk(folio, &rwc);
>  
>  	if (need_lock)
>  		folio_unlock(folio);
> -	folio_put(folio);
>  
> -out:
>  	*folio_sz = folio_size(folio);
> +out:
> +	folio_put(folio);

Before this change, folio_size() is called after folio_put().  Shouldn't it be
called before folio_put()?  If so, could we make a separate fix for that first,
and then make this change on top of it, so that it can be easily applied to
relevant stable kernels?


Thanks,
SJ

>  	return accessed;
>  }
>  
> -- 
> 2.35.3
> 
> 
