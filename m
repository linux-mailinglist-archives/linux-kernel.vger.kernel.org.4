Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A06F5A02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjECO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjECO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:28:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81341FF6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:28:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75178b082a5so131339385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683124128; x=1685716128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmZ4DsDKrMe1S2UiM4lF3iPDDNQLVdB3fN/nPm0O+pI=;
        b=xOFe0H29iDHpimotgJRcaLX6/SmYqAhUgt7QykkIwaN5ArFrr67+xXLlpVVlQMvSm1
         RPn5ONAVfnr8xMJvUZgHIsgicCh2NlpHkZzlbotmQg6XyHJqN7GmMCOqgT9QEq8Nk0DP
         6XQSoE+g/zWIZz8yvYHylhmN5XnjZ8zEB0Dl9ALOgHd+jkrXz5ToigDNZ+eabCcyxBr4
         duYN1MXQv6CJKolySvtsT3waS1hGoiQBI737dGIe+txiceEkohRDoMTQuKYoAh5GolMY
         y9RKrb4aUP/zDYZBwSqZuOcVknnLVFmCgmjVsnlBTLxd9dXRHcHEs8SKonvX5HVljRV6
         aI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124128; x=1685716128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmZ4DsDKrMe1S2UiM4lF3iPDDNQLVdB3fN/nPm0O+pI=;
        b=b6gFqM8kdNBQnB3VRQyfO/+nfwWZmzor3pJPYf2u+y+UenKI31VQCnfpLFTspUha69
         fLmBQ77UVOPB1C+qpe6Eo90roSYlRyOMchAEh63YdoowVjJsI5ENIm66GyQtHMLwLFt5
         cqPgcKTAwmWCzJ1sDWEXZhAn0e80YoUwbKA1Rg3QZZm6XaoChRo57lXvuP6twSdt3AaA
         g7zp8c6qXdWIw/VnMgAW2eQNmoUsgBb3a2QrXpTHRb9jfUAjZ+V/QjqILUriebq7l+gS
         tp4wk08KYwbRPGnB97MpOgQng4AsKgiHkV47yhpSHsLlwjK5RUS9LiRnOkdd7QiVSuf0
         pwrw==
X-Gm-Message-State: AC+VfDy5KNubW7gAxQauIKr+xOlstDNMlZJlcZcIHlDXWVW3bbwtvcPc
        Xi9pZAZdAFEm5SNyh2hTis6a7jV1XWmnBTAQFHA=
X-Google-Smtp-Source: ACHHUZ4M0zjk5FZ8yY3AGVchtAjIIei756Ls/aUGKZtURl7Hx24TrnOkvYA+7uqlcYTFCcYv46aGAA==
X-Received: by 2002:ad4:4ea6:0:b0:5fd:7701:88c5 with SMTP id ed6-20020ad44ea6000000b005fd770188c5mr11763060qvb.6.1683124127795;
        Wed, 03 May 2023 07:28:47 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id b27-20020a0cb3db000000b005e750d07153sm10588375qvf.135.2023.05.03.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:28:46 -0700 (PDT)
Date:   Wed, 3 May 2023 10:28:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix zswap writeback race condition
Message-ID: <20230503142846.GA193380@cmpxchg.org>
References: <20230503132148.9682-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503132148.9682-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 03:21:48PM +0200, Domenico Cerasuolo wrote:
> The zswap writeback mechanism can cause a race condition resulting in
> memory corruption, where a swapped out page gets swapped in with data
> that was written to a different page.
> 
> The race unfolds like this:
> 1. a page with data A and swap offset X is stored in zswap
> 2. page A is removed off the LRU by zpool driver for writeback in
> zswap-shrink work, data for A is mapped by zpool driver
> 3. user space program faults and invalidates page entry A, offset X is
> considered free
> 4. kswapd stores page B at offset X in zswap (zswap could also be full,
> if so, page B would then be IOed to X, then skip step 5.)
> 5. entry A is replaced by B in tree->rbroot, this doesn't affect the
> local reference held by zswap-shrink work
> 6. zswap-shrink work writes back A at X, and frees zswap entry A
> 7. swapin of slot X brings A in memory instead of B
> 
> The fix:
> Once the swap page cache has been allocated (case ZSWAP_SWAPCACHE_NEW),
> zswap-shrink work just checks that the local zswap_entry reference is
> still the same as the one in the tree. If it's not the same it means
> that it's either been invalidated or replaced, in both cases the
> writeback is aborted because the local entry contains stale data.
> 
> Reproducer:
> I originally found this by running `stress` overnight to validate my
> work on the zswap writeback mechanism, it manifested after hours on my
> test machine. The key to make it happen is having zswap writebacks, so
> whatever setup pumps /sys/kernel/debug/zswap/written_back_pages should
> do the trick.
> In order to reproduce this faster on a vm, I setup a system with ~100M
> of available memory and a 500M swap file, then running
> `stress --vm 1 --vm-bytes 300000000 --vm-stride 4000` makes it happen
> in matter of tens of minutes. One can speed things up even more by
> swinging /sys/module/zswap/parameters/max_pool_percent up and down
> between, say, 20 and 1; this makes it reproduce in tens of seconds.
> It's crucial to set `--vm-stride` to something other than 4096 otherwise
> `stress` won't realize that memory has been corrupted because all pages
> would have the same data.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6c89049cf70..d20d60266bc8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -995,6 +995,19 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  		goto fail;
>  
>  	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
> +		/*
> +		 * if the entry in the tree has been replaced, it means that we would
> +		 * be overriding the swap page with stale data, let's not do that.
> +		 */
> +		spin_lock(&tree->lock);
> +		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
> +			spin_unlock(&tree->lock);
> +			delete_from_swap_cache(page_folio(page));
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +		spin_unlock(&tree->lock);

I think it would be beneficial to explain the exact race in the
comment above. That our local reference to the zswap entry doesn't
exclude swapping from invalidating and recyling the swap slot. Once
the swapcache is secured against concurrent swapping to and from the
slot, recheck that the entry is still current before writing.

With that, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
