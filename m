Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B66B2039
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCIJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCIJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:37:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA5E190E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:37:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA1B51FFBE;
        Thu,  9 Mar 2023 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678354618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8NIcv5780RRyRa6ne8YnEdCf9uS/eBiHg6F8AAKbOI=;
        b=yXqExYf0BlKo63vBhA2lInCQg4qzbkCFiaAiC6pEtc81vMNr3juYfeAiH41/4YZbjatpc2
        Um43Y4Upd/HfPvbYKongEHtqEYieJhz20qxZjSTpho2mVSjjBve4dOJEDbAzu0OLj0IsVo
        ZaCfU9QuEhBfSl34dzU29GZ0EroXkNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678354618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8NIcv5780RRyRa6ne8YnEdCf9uS/eBiHg6F8AAKbOI=;
        b=qPZnRRNOgVpup3KvPXxpNTZB/ovzlS7e6UsH+HxPCfYp/mWeBHmOyTUhHSKV+xbIKqEBW6
        rXcJCJmtUjFwMlDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8556E1391B;
        Thu,  9 Mar 2023 09:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U/LwH7qoCWRYEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 09:36:58 +0000
Message-ID: <3056542f-5598-9c60-30fe-4949400dd39e@suse.cz>
Date:   Thu, 9 Mar 2023 10:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 6/8] mm: vmscan: hold write lock to reparent shrinker
 nr_deferred
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-7-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-7-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 07:56, Qi Zheng wrote:
> For now, reparent_shrinker_deferred() is the only holder
> of read lock of shrinker_rwsem. And it already holds the
> global cgroup_mutex, so it will not be called in parallel.
> 
> Therefore, in order to convert shrinker_rwsem to shrinker_mutex
> later, here we change to hold the write lock of shrinker_rwsem
> to reparent.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9a5a3da5c8b5..7aaf6f94ac1b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -451,7 +451,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  		parent = root_mem_cgroup;
>  
>  	/* Prevent from concurrent shrinker_info expand */
> -	down_read(&shrinker_rwsem);
> +	down_write(&shrinker_rwsem);
>  	for_each_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
> @@ -460,7 +460,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>  		}
>  	}
> -	up_read(&shrinker_rwsem);
> +	up_write(&shrinker_rwsem);
>  }
>  
>  static bool cgroup_reclaim(struct scan_control *sc)

