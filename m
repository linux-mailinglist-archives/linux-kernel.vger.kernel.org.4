Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FD6A459B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjB0PIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjB0PIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:08:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1793C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:08:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 834A760E9E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E830C433A4;
        Mon, 27 Feb 2023 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677510525;
        bh=A4GC9qpKEzKIujfpTB17KrXszHgOinHLYyEqMxiUgU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8QNMHyRQ7hOWsOHfSzhLk0DE9NdtWxKjjPdoxktGf7ITel8dmVeNWswbLmKiLTjZ
         WgAysQDQg6GFG3uGUrL+/A82VN7NkFK/lwQuwQfzf6264Zt0EpiK7PxcO8SYM8+0Yr
         8hur4UE4aHyKZGrUmePTc6fUPF8hQwgj6QfhrwsA2TjUiUpV+cP2gE7Ghr+3Io/+sS
         oF9YSBH/w6Pge8T1oX8PU9sO+gqsHgFZSeSblHffo7uHn/1snvFht3b6TDUwoybV4k
         J9CosbYx8byXhidNCW0yocu5d5nnhU2ya/YOFrf4PdhBbf8YzZ+JMlD/bish1ngoMj
         3qGgvUPk2rK8A==
Date:   Mon, 27 Feb 2023 17:08:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tkhai@ya.ru,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Message-ID: <Y/zHbhxnQ2YsP+wX@kernel.org>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/2/27 03:51, Andrew Morton wrote:
> > On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> > > Hi all,
> > > 
> > > This patch series aims to make slab shrink lockless.
> > 
> > What an awesome changelog.
> > 
> > > 2. Survey
> > > =========
> > 
> > Especially this part.
> > 
> > Looking through all the prior efforts and at this patchset I am not
> > immediately seeing any statements about the overall effect upon
> > real-world workloads.  For a good example, does this patchset
> > measurably improve throughput or energy consumption on your servers?
> 
> Hi Andrew,
> 
> I re-tested with the following physical machines:
> 
> Architecture:        x86_64
> CPU(s):              96
> On-line CPU(s) list: 0-95
> Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz
> 
> I found that the reason for the hotspot I described in cover letter is
> wrong. The reason for the down_read_trylock() hotspot is not because of
> the failure to trylock, but simply because of the atomic operation
> (cmpxchg). And this will lead to a significant reduction in IPC (insn
> per cycle).

... 
 
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
> 
> 2. At the same time, we use the following perf command to capture IPC
> information:
> 
> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
> 
> 1) Before applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       454187219766      cycles                    test                    (
> +-  1.84% )
>        78896433101      instructions              test #    0.17  insn per
> cycle           ( +-  0.44% )
> 
>         10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
> 
> 2) After applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       841954709443      cycles                    test                    (
> +- 15.80% )  (98.69%)
>       527258677936      instructions              test #    0.63  insn per
> cycle           ( +- 15.11% )  (98.68%)
> 
>           10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
> 
> We can see that IPC drops very seriously when calling
> down_read_trylock() at high frequency. After using SRCU,
> the IPC is at a normal level.

The results you present do show improvement in IPC for an artificial test
script. But more interesting would be to see how a real world workloads
benefit from your changes.
 
> Thanks,
> Qi

-- 
Sincerely yours,
Mike.
