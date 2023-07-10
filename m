Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3120F74D3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGJKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjGJKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:41:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D612BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:41:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEF4E1FE9A;
        Mon, 10 Jul 2023 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688985678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnNJMSnMxZmPiG5/FF+cISxUGMV48vxDdq7iSAZ7e3c=;
        b=pPiOe3kzc+MV1B4ej4dtqFT+rwMiHrGKr8HrphAj7MQ9hz6EI5KV3w6yjzaYQ8f9bTdIc7
        ljIVf3mN8QkCd3o4kpFdbMYlJs+L855NrerzwRjEMK/8JRsDTMXLrGwAidh3DqTvKp5Kqr
        lDRFn4qxVIjX2UOlv6zTZXWlvunXBE8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FCFC13A05;
        Mon, 10 Jul 2023 10:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9N+/JE7gq2RfSgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 10 Jul 2023 10:41:18 +0000
Date:   Mon, 10 Jul 2023 12:41:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
Message-ID: <ZKvgTTqwTnUXiY3m@dhcp22.suse.cz>
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
 <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
 <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz>
 <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-07-23 17:35:07, 贺中坤 wrote:
> On Fri, Jul 7, 2023 at 10:44 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Why do we want/need that?
> 
> Applications can currently escape their cgroup memory containment when
> zram is enabled regardless of indirect(swapfile) or direct usage(disk) .
> This patch adds memcg accounting to fix it.
> 
> Zram and zswap have the same problem，please refer to the patch
> corresponding to zswap[1].
> 
> [1] https://lore.kernel.org/all/20220510152847.230957-7-hannes@cmpxchg.org/
> 
> >
> > > summarize the previous discussion:
> > > [1] As I can see, Michal's concern is that the charges are going to fail
> > > and swapout would fail.
> > >
> > > The indirect use of zram is in the context of PF_MEMALLOC, so
> > > the charge must be successful.
> >
> > No, this was not my concern. Please read through that more carefully. My
> > concern was that the hard limit reclaim would fail. PF_MEMALLOC will not
> > help in that case as this is not a global reclaim path.
> >
> 
> Sorry for my expression. I mean the hard limit reclaim would fail.
> As i can see, the PF_MEMALLOC is not only used in global reclaim path
> but the mem_cgroup reclaim.
> 
> try_charge_memcg
>   try_to_free_mem_cgroup_pages
>      noreclaim_flag = memalloc_noreclaim_save();
>      nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>      memalloc_noreclaim_restore(noreclaim_flag);

My bad, I have overlooked this. I forgot about 89a2848381b5f. 

> > Also let's assume you allow swapout charges to succeed similar to
> > PF_MEMALLOC. That would mean breaching the limit in an unbounded way,
> > no?
> > --
> 
> Chage compressed page once, mean a page will be freed. the size of compressed
> page is less than or equal to the page to be freed. So not an unbounded way.

OK, this is an important detail to mention. Also have tried to get some
numbers of how much excess is happening for a mixed bag of compressible
memory?
-- 
Michal Hocko
SUSE Labs
