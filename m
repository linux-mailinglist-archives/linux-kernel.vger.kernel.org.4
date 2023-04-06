Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6227B6D8BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjDFAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjDFAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11B19A7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582396423A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6002FC433D2;
        Thu,  6 Apr 2023 00:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680740725;
        bh=6c1LaWzyk6YfvJoEsJoYWLQzSo+xjO1t1nhuP2xZrV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTgSUMJIsOPgtGY0XpPKzu8KFDMJx1WeVIQEFBuJ5ed75LzSfLiDPMI/pEPLNsFo0
         I8jBVJM8eyoFvkBFTP+6zaB7OswT4rW18s6ozMQoD+x3rCgzB8jR5A6gHQZgQEcZ4k
         ILEvgveQRI1D7ICLmvCFGNL4fURMqOjc3mV6DcBk=
Date:   Wed, 5 Apr 2023 17:25:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     jstultz@google.com, tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, hannes@cmpxchg.org, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
Message-Id: <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
In-Reply-To: <20230406000854.25764-1-jaewon31.kim@samsung.com>
References: <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcas1p3.samsung.com>
        <20230406000854.25764-1-jaewon31.kim@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Apr 2023 09:08:54 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>   free_cma:200844kB
> Out of memory and no killable processes...
> Kernel panic - not syncing: System is deadlocked on memory
> 
> An OoM panic was reported, there were only native processes which are
> non-killable as OOM_SCORE_ADJ_MIN.
> 
> After looking into the dump, I've found the dma-buf system heap was
> trying to allocate a huge size. It seems to be a signed negative value.
> 
> dma_heap_ioctl_allocate(inline)
>     |  heap_allocation = 0xFFFFFFC02247BD38 -> (
>     |    len = 0xFFFFFFFFE7225100,
> 
> Actually the old ion system heap had policy which does not allow that
> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
> bugs in system heap"). We need this change again. Single allocation
> should not be bigger than half of all memory.
> 
> ...
>
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	struct page *page, *tmp_page;
>  	int i, ret = -ENOMEM;
>  
> +	if (len / PAGE_SIZE > totalram_pages() / 2)
> +		return ERR_PTR(-ENOMEM);
> +

This seems so random.  Why ram/2 rather than ram/3 or 17*ram/35?

Better behavior would be to try to allocate what the caller asked
for and if that doesn't work out, fail gracefully after freeing the
partial allocations which have been performed thus far.  If dma_buf
is changed to do this then that change is useful in many scenarios other
than this crazy corner case.

