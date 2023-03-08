Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D736B1585
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCHWsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCHWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:47:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912DD1ACD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:47:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6938219EE;
        Wed,  8 Mar 2023 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678315606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7LeakoGyD3yVjPgAa69ZvLabEJu/VqZA8a/dYrxfxc=;
        b=koWtB/4D1ryptHKQON76m6fQF7XjMxOf2oMmzfCXjndNnPdjMm1sIbzREydRQCiBqEgjC3
        +Y9wL66I4WqtFxv67mkJG0p6/t2NAOiKHWmDOQmQhqTfxw/ADyx0LhIEfTTsJvHrlqasbU
        2dGx9LoE1OYW6BJAnJtZccF+4W3gfTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678315606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7LeakoGyD3yVjPgAa69ZvLabEJu/VqZA8a/dYrxfxc=;
        b=c9os9A7D0Qhs9u7xoDGGglxFSe+zu3ibhjGMb2YRjOkcerTaBMT+Ew+u6vKAsvO7HVXuB+
        /+dhJVgKsC4h8sAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 677A51391B;
        Wed,  8 Mar 2023 22:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id npeFGFYQCWQZbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 22:46:46 +0000
Message-ID: <a5a07356-048b-562b-6748-d6d5b99acddc@suse.cz>
Date:   Wed, 8 Mar 2023 23:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/8] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-4-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-4-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 07:56, Qi Zheng wrote:
> Like global slab shrink, this commit also uses SRCU to make
> memcg slab shrink lockless.
> 
> We can reproduce the down_read_trylock() hotspot through the
> following script:
> 
> ```
> 
> DIR="/root/shrinker/memcg/mnt"
> 
> do_create()
> {
>     mkdir -p /sys/fs/cgroup/memory/test
>     mkdir -p /sys/fs/cgroup/perf_event/test
>     echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>     for i in `seq 0 $1`;
>     do
>         mkdir -p /sys/fs/cgroup/memory/test/$i;
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>         mkdir -p $DIR/$i;
>     done
> }
> 
> do_mount()
> {
>     for i in `seq $1 $2`;
>     do
>         mount -t tmpfs $i $DIR/$i;
>     done
> }
> 
> do_touch()
> {
>     for i in `seq $1 $2`;
>     do
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>             dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>     done
> }
> 
> case "$1" in
>   touch)
>     do_touch $2 $3
>     ;;
>   test)
>       do_create 4000
>     do_mount 0 4000
>     do_touch 0 3000
>     ;;
>   *)
>     exit 1
>     ;;
> esac
> ```
> 
> Save the above script, then run test and touch commands.
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
> At the same time, we use the following perf command to capture
> IPC information:
> 
> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
> 
> 1) Before applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       454187219766      cycles                    test                    ( +-  1.84% )
>        78896433101      instructions              test #    0.17  insn per cycle           ( +-  0.44% )
> 
>         10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
> 
> 2) After applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       841954709443      cycles                    test                    ( +- 15.80% )  (98.69%)
>       527258677936      instructions              test #    0.63  insn per cycle           ( +- 15.11% )  (98.68%)
> 
>           10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
> 
> We can see that IPC drops very seriously when calling
> down_read_trylock() at high frequency. After using SRCU,
> the IPC is at a normal level.

The interpretation looks somewhat weird to me. I'd say the workload is
stalled a lot as it fails the trylock (there might be some optimistic
spinning perhaps) and then goes to sleep. See how "pv_native_safe_halt" is
also more prominent in before. And because of that sleeping, there's less
instructions executed in the same amount of cycles (as it's a system wide
collection, otherwise it wouldn't be collecting the sleeping processes).

> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Other than that:

Acked-by: Vlastimil Babka <Vbabka@suse.cz>

A small thing below:

> ---
>  mm/vmscan.c | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8515ac40bcaf..1de9bc3e5aa2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -57,6 +57,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
> +#include <linux/srcu.h>

I guess this should have been in patch 2/8 already? It may work accidentaly
because some other header pulls it transitively...


