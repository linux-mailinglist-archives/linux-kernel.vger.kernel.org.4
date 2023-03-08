Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D96B0C13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCHPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCHPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:02:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDF8C95F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:02:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E0881FE46;
        Wed,  8 Mar 2023 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678287738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qke6c4FNpksj98MCMFsMjlwbe2riF8y0VuNVU0Y/MjU=;
        b=pazgCUjazbs4Pn0ATSbRP0d4O3WG00T3SQO0LceNi0FbAJ9o5rbIhi0Ux+5uJApBvSfuGW
        +j0d7mt20XSh/2/fGzaW/XYKej3slnF0LktaTFiZi25jH/UqaMJNHCokFwOLIMbK1Q2Cou
        4ZkeF7qlVD2iIB/uGxL9JMLAIodsRPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678287738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qke6c4FNpksj98MCMFsMjlwbe2riF8y0VuNVU0Y/MjU=;
        b=KzBly1+kuo4cnGUeDfenR6tqsLrdgvw+e1Cwam5hXM6MYxkqYmLx1PoXuCGU/RN9/IRlqa
        jqdDJikUI++wZZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EA1B1348D;
        Wed,  8 Mar 2023 15:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N51BCnqjCGSnAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 15:02:18 +0000
Message-ID: <e9159c12-3aaa-430e-2c99-d1ee2640dd28@suse.cz>
Date:   Wed, 8 Mar 2023 16:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/8] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-3-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 07:55, Qi Zheng wrote:
> The shrinker_rwsem is a global read-write lock in
> shrinkers subsystem, which protects most operations
> such as slab shrink, registration and unregistration
> of shrinkers, etc. This can easily cause problems in
> the following cases.
> 
> 1) When the memory pressure is high and there are many
>    filesystems mounted or unmounted at the same time,
>    slab shrink will be affected (down_read_trylock()
>    failed).
> 
>    Such as the real workload mentioned by Kirill Tkhai:
> 
>    ```
>    One of the real workloads from my experience is start
>    of an overcommitted node containing many starting
>    containers after node crash (or many resuming containers
>    after reboot for kernel update). In these cases memory
>    pressure is huge, and the node goes round in long reclaim.
>    ```
> 
> 2) If a shrinker is blocked (such as the case mentioned
>    in [1]) and a writer comes in (such as mount a fs),
>    then this writer will be blocked and cause all
>    subsequent shrinker-related operations to be blocked.
> 
> Even if there is no competitor when shrinking slab, there
> may still be a problem. If we have a long shrinker list
> and we do not reclaim enough memory with each shrinker,
> then the down_read_trylock() may be called with high
> frequency. Because of the poor multicore scalability of
> atomic operations, this can lead to a significant drop
> in IPC (instructions per cycle).
> 
> So many times in history ([2],[3],[4],[5]), some people
> wanted to replace shrinker_rwsem trylock with SRCU in
> the slab shrink, but all these patches were abandoned
> because SRCU was not unconditionally enabled.
> 
> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
> the SRCU is unconditionally enabled. So it's time to use
> SRCU to protect readers who previously held shrinker_rwsem.
> 
> This commit uses SRCU to make global slab shrink lockless,
> the memcg slab shrink is handled in the subsequent patch.
> 
> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
