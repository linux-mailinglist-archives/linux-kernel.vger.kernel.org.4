Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13C642235
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiLEEOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiLEEOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:14:05 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DD11175
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 20:14:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z17so4108543qki.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 20:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2yyNbetbS0qbzVX5dV+z/0AIbsCnurFCllU0nYxCjc=;
        b=HZCbRjSkuXiBGqBtWJa3EuEztJGkEWL9Yeaatgl7bZd1n+ncQdemo3fa4A/89GEjof
         u0bJBruWENUfl5G+uU7uej6kQUzMyp49vnjJ1Cr5la1qmOO0Ww4RAPz5A8KE/Ij0uFAy
         DQsxBDbRU+1HH7wKV3PzMc7h0qlYqDc/GlIpek0Osu+91fxhGYCIGi+8eYwJP+bguJvP
         Lx6efxOrf2ffQSEmatifPjhGRymKPsP+JCBjfMZw24R9SsSYgnq6Qa/+X1LWcJyaOKMt
         d0gyXtlWNLpqt9qx2sq+MKK8UAmqLH7UZInOTROyss7WoT8LqdF9EbRo+2hf3CfDBewG
         aBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2yyNbetbS0qbzVX5dV+z/0AIbsCnurFCllU0nYxCjc=;
        b=HEi1lLEoI5VLM9PwCsrv2cSuTFukrUlWFd7xBOUf1n551yyGgcO9ma1yxR4XaeRbGb
         l7ohKb/SQ0dw2OjLFXLwTdRCZ7RvPv+CrgD/HeTYS2of+OC0y3AA1zzJSee6HLbfTCUa
         6QWGorMimj2ttDs4UQVKtIzI8rlf25n2hBp4TkFk5F6wggHdACu1QR/Ch5wokdYCt9og
         wWD22DuS984F/C4JpWQiGXN6DQQOdsiwKcVkdH502lHvU4FS+lzgr+3LfgsLFi1IUOdv
         ML0MJcjI6v+lFrcLGsdIMrPMnHaDaFmUD8eprWYxgsvAsw0JcacclvRn9hCwA5YgmgNM
         0jpw==
X-Gm-Message-State: ANoB5pliUE1pimRM8NOMj56P2JojwJ8S8YmSzyHet2q6lAoTRcB5qO3V
        4DgE4b6qGEhEgCQqGwFSfJNgdg==
X-Google-Smtp-Source: AA0mqf60OvsWnDT0Ks18P3nr2J6RQqzohP44r40EE93Yn3jMwj73azchy6wLiM45vZUrfmJN7gjMmQ==
X-Received: by 2002:a05:620a:1116:b0:6f9:fea2:833a with SMTP id o22-20020a05620a111600b006f9fea2833amr73773783qkk.659.1670213643722;
        Sun, 04 Dec 2022 20:14:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o1-20020ac841c1000000b0039cc82a319asm8947073qtm.76.2022.12.04.20.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 20:14:03 -0800 (PST)
Date:   Sun, 4 Dec 2022 20:13:53 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Chen Wandun <chenwandun@huawei.com>
cc:     akpm@linux-foundation.org, shli@kernel.org, hughd@google.com,
        arnd@arndb.de, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swapfile: fix uncorrect statistical count about free
 swap
In-Reply-To: <20221205024726.3111808-1-chenwandun@huawei.com>
Message-ID: <c5c36749-d59a-345b-e7c6-925fdf17e2bd@google.com>
References: <20221205024726.3111808-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022, Chen Wandun wrote:

> The counter of free swap turn to negtive during swapoff, this
> phenomenon can be observed in oom log, such as:
> 
> 1226 total pagecache pages
> 47 pages in swap cache
> Swap cache stats: add 119633, delete 119814, find 26832/82125
> Free swap  = -31796kB
> Total swap = 0kB
> 1048576 pages RAM
> 
> Subtract the size of swap partition from free swap should put behind
> try_to_unuse, otherwise, it will result in negtive counter if swap
> partition is in use.
> 
> Fixes: ec8acf20afb8 ("swap: add per-partition lock for swapfile")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

No: it is intentional, and long established, that the count goes negative
during swapoff - that helps to inform you that it is in swapoff.

Hugh

> ---
>  mm/swapfile.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 72e481aacd5d..5b9b695be84b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2316,8 +2316,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
>  static void _enable_swap_info(struct swap_info_struct *p)
>  {
>  	p->flags |= SWP_WRITEOK;
> -	atomic_long_add(p->pages, &nr_swap_pages);
> -	total_swap_pages += p->pages;
>  
>  	assert_spin_locked(&swap_lock);
>  	/*
> @@ -2353,6 +2351,8 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>  	spin_lock(&swap_lock);
>  	spin_lock(&p->lock);
>  	_enable_swap_info(p);
> +	atomic_long_add(p->pages, &nr_swap_pages);
> +	total_swap_pages += p->pages;
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
>  }
> @@ -2444,8 +2444,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		least_priority++;
>  	}
>  	plist_del(&p->list, &swap_active_head);
> -	atomic_long_sub(p->pages, &nr_swap_pages);
> -	total_swap_pages -= p->pages;
>  	p->flags &= ~SWP_WRITEOK;
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
> @@ -2500,6 +2498,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		spin_lock(&p->lock);
>  	}
>  
> +	atomic_long_sub(p->pages, &nr_swap_pages);
> +	total_swap_pages -= p->pages;
>  	swap_file = p->swap_file;
>  	old_block_size = p->old_block_size;
>  	p->swap_file = NULL;
> -- 
> 2.25.1
> 
> 
