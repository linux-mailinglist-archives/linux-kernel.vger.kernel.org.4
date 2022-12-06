Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD964430B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiLFMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiLFMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:20:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0728E3E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:20:39 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E54991FE5A;
        Tue,  6 Dec 2022 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670329237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ubehKMI13V7IpoDkqhnY7iW2vBl9bHhW3ygShDxfjZU=;
        b=fNE0Kyi7oZSf7QU7bvg5Wd3bjmzSRo7dddFUZS7bf0M6Pvep5NmvE3cSuVk3ExVU9S8I1Z
        9ysK78QuxkBeZ/tLa0co0Pxx+pWZutVmBiIxnIT5lM3MdNOa8pxSuKIqesIqj3aVwwShyV
        GGBwaXaACl3mgtb62ecUSiRl/sREQf0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C3EDC132F3;
        Tue,  6 Dec 2022 12:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0dqjLZUzj2N6YgAAGKfGzw
        (envelope-from <mhocko@suse.com>); Tue, 06 Dec 2022 12:20:37 +0000
Date:   Tue, 6 Dec 2022 13:20:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
Message-ID: <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
References: <20221206023406.3182800-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206023406.3182800-1-almasrymina@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim"") enabled demotion in memcg reclaim, which is the right thing
> to do, however, it introduced a regression in the behavior of
> try_to_free_mem_cgroup_pages().
> 
> The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> of the cgroup should reduce by nr_pages. The callers expect
> try_to_free_mem_cgroup_pages() to also return the number of pages
> reclaimed, not demoted.
> 
> However, what try_to_free_mem_cgroup_pages() actually does is it
> unconditionally counts demoted pages as reclaimed pages. So in practice
> when it is called it will often demote nr_pages and return the number of
> demoted pages to the caller. Demoted pages don't lower the memcg usage,
> and so try_to_free_mem_cgroup_pages() is not actually doing what the
> callers want it to do.
> 
> Various things work suboptimally on memory tiered systems or don't work
> at all due to this:
> 
> - memory.high enforcement likely doesn't work (it just demotes nr_pages
>   instead of lowering the memcg usage by nr_pages).
> - try_charge_memcg() will keep retrying the charge while
>   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>   making any room for the charge.

This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/

> - memory.reclaim has a wonky interface. It advertises to the user it
>   reclaims the provided amount but it will actually often demote that
>   amount.
> 
> There may be more effects to this issue.
> 
> To fix these issues I propose shrink_folio_list() to only count pages
> demoted from inside of sc->nodemask to outside of sc->nodemask as
> 'reclaimed'.

Could you expand on why the node mask matters? From the charge point of
view it should be completely uninteresting as the charge remains.

I suspect we really need to change to reclaim metrics for memcg reclaim.
In the memory balancing reclaim we can indeed consider demotions as a
reclaim because the memory is freed in the end but for the memcg reclaim
we really should be counting discharges instead. No demotion/migration will
free up charges.
-- 
Michal Hocko
SUSE Labs
