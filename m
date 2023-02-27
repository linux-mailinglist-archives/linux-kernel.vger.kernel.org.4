Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2E6A4A87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjB0TCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0TCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:02:33 -0500
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B91814B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:02:31 -0800 (PST)
Date:   Mon, 27 Feb 2023 11:02:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677524549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHDUyRP1H7IO03JJd79Eqkjl+gpzKiLWdjuhlvoeMy0=;
        b=IY1a2ciZUPs8cWMTUzjKna3TFiW+1GMhx0j6v9hkJtBAS4R/lb0066gShKpUwjtxjjviO2
        bAyqWHSergfm2UOWi0StxNrObmacB0C46ttLCBeEhGMBXcm7jDMkqWd3hQ3apPtLVaL/9P
        5gVWB37D6JzQbUoZaiLa2F/LoxkJJVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tkhai@ya.ru,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Message-ID: <Y/z+P5cgeunD6u21@P9FQF9L96D>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/2/27 03:51, Andrew Morton wrote:
> > On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> Save the above script, then run test and touch commands.
> 
> Then we can use the following perf command to view hotspots:
> 
> perf top -U -F 999
> 
> 1) Before applying this patchset:
> 
>   32.31%  [kernel]           [k] down_read_trylock
>   19.40%  [kernel]           [k] pv_native_safe_halt
>   16.24%  [kernel]           [k] up_read
>   15.70%  [kernel]           [k] shrink_slab
>    4.69%  [kernel]           [k] _find_next_bit
>    2.62%  [kernel]           [k] shrink_node
>    1.78%  [kernel]           [k] shrink_lruvec
>    0.76%  [kernel]           [k] do_shrink_slab
> 
> 2) After applying this patchset:
> 
>   27.83%  [kernel]           [k] _find_next_bit
>   16.97%  [kernel]           [k] shrink_slab
>   15.82%  [kernel]           [k] pv_native_safe_halt
>    9.58%  [kernel]           [k] shrink_node
>    8.31%  [kernel]           [k] shrink_lruvec
>    5.64%  [kernel]           [k] do_shrink_slab
>    3.88%  [kernel]           [k] mem_cgroup_iter

Not opposing the intention of the patchset in any way (I actually think
it's a good idea to make the shrinkers list lockless), but looking at
both outputs above I think that the main problem is not the contention on
the semaphore, but the reason of this contention.

It seems like often there is a long list of shrinkers which barely
can reclaim any memory, but we're calling them again and again.
In order to achieve real wins with real-life workloads, I guess
it's what we should optimize.

Thanks!
