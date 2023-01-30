Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AC6807D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjA3ItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjA3ItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:49:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD072D162
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:48:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFCEE21997;
        Mon, 30 Jan 2023 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675068525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXyDoTfU6hdnTdx9ExC32v0E+ObyT7qdgHW8rtvC/34=;
        b=qxvAv7Bs/YNKKyRWOdbRlKzQJTroMZaL70vQK6XQbia8Qi7IVSEvSNqQIyj9ct62A+HKd6
        MvYZDoNN858gkPaMOBKKYmDNaHabQJeC7cTyKanSKbd9MkiE6JDme0ObW9tlk0LFhlXbXs
        F/0EkSln8G2GYHT/6LsLuksmDc0d4Jo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF83013A06;
        Mon, 30 Jan 2023 08:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IgUVKm2E12MXWAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 30 Jan 2023 08:48:45 +0000
Date:   Mon, 30 Jan 2023 09:48:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ma Wupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in
 mem_cgroup_track_foreign_dirty()
Message-ID: <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
 <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
 <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-01-23 09:16:13, Kefeng Wang wrote:
> 
> 
> On 2023/1/30 5:48, Andrew Morton wrote:
> > On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > 
> > > As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
> > 
> > Merged in 2017.
> > 
> > > hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> > > could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> > > occurs a NULL pointer dereference, let's do not record the foreign
> > > writebacks for folio memcg is null in mem_cgroup_track_foreign() to
> > > fix it.
> > > 
> > > Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> > > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> > 
> > Merged in 2019.
> > 
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1688,10 +1688,13 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
> > >   static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
> > >   						  struct bdi_writeback *wb)
> > >   {
> > > +	struct mem_cgroup *memcg;
> > > +
> > >   	if (mem_cgroup_disabled())
> > >   		return;
> > > -	if (unlikely(&folio_memcg(folio)->css != wb->memcg_css))
> > > +	memcg = folio_memcg(folio);
> > > +	if (unlikely(memcg && &memcg->css != wb->memcg_css))
> > >   		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
> > >   }
> > 
> > Has this null deref actually been observed, or is this from code
> > inspection?  (This is why it's nice to include the Link: after a
> > Reported-by!)
> 
> It does occurs in our internal test and report by wupeng(based v5.10),
> 
> BUG: KASAN: user-memory-access in
> mem_cgroup_track_foreign_dirty_slowpath+0xc0/0x480 mm/memcontrol.c:4708
> Read of size 8 at addr 0000000000001000 by task syz-executor.2/28325
> 
> CPU: 2 PID: 28325 Comm: syz-executor.2 Tainted: G        W
> 5.10.0-03333-g48e46a146cbc-dirty #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  ...
>  mem_cgroup_track_foreign_dirty_slowpath+0xc0/0x480 mm/memcontrol.c:4708
>  mem_cgroup_track_foreign_dirty include/linux/memcontrol.h:1880 [inline]
>  account_page_dirtied+0x9a0/0xa90 mm/page-writeback.c:2436
>  __set_page_dirty+0x1f8/0x4b0 fs/buffer.c:608
>  __set_page_dirty_buffers+0x3d0/0x550 fs/buffer.c:668
>  set_page_dirty+0x158/0x500 mm/page-writeback.c:2575
>  filemap_page_mkwrite+0x3dc/0x490 mm/filemap.c:3224
>  do_page_mkwrite+0xc4/0x3d0 mm/memory.c:2786
>  wp_page_shared+0x14c/0x980 mm/memory.c:3118
>  do_wp_page+0x930/0xbc0 mm/memory.c:3219
>  handle_pte_fault+0x5e0/0x630 mm/memory.c:4570
>  __handle_mm_fault+0x41c/0x910 mm/memory.c:4690
>  handle_mm_fault+0x25c/0x484 mm/memory.c:4788
>  __do_page_fault arch/arm64/mm/fault.c:440 [inline]
>  do_page_fault+0x3ac/0x9d4 arch/arm64/mm/fault.c:539

Just to make sure I understand. The page has been hwpoisoned, uncharged
but stayed in the page cache so a next page fault on the address has blowned
up?

Say we address the NULL memcg case. What is the resulting behavior?
Doesn't userspace access a poisoned page and get a silend memory
corruption?
-- 
Michal Hocko
SUSE Labs
