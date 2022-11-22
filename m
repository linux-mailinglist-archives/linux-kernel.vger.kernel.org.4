Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52463322C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKVBc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiKVBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:32:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA226AF1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:32:51 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l15so8475642qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1WA2y8g5fhQuZnwMdhaIJwo0CEHJPMSKTSLaNEoLOM=;
        b=h8qYltXZdrvwN5p1AA9AAY9YC7IjoIPByGxTfBvZd7L1Cnio697HypHyozFeHG4sUj
         05blWC79g0AC1gIuZhplB56hjCYx0gqfq8mNMgulNtc6QsXEwFmmROqjqz4RJ/fMxOIV
         5KGAC8QEOOqFLRkQmwBFqsexDLlgxo8StA6E+q9mO9dE/LndqKX9x6cQVmJI5c7xcfNR
         1DeZoH72UQo3iP4ex1wYSb9Vm0bgBqMbDDZr63OKbS1nvojupZ7xHueGfEMpLVeCcCFW
         YQ0I7xuDdCh3hijs/pjvTTnfugtsC/883gqWnG83L4ZhfAOvykF9usszbQgR8pQC8LbD
         ar/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1WA2y8g5fhQuZnwMdhaIJwo0CEHJPMSKTSLaNEoLOM=;
        b=Ta2G4B7kmOhabBOW7xMTCxIh2L8ypVH4uaA5tHVvXIzwrUJBnOei4salt1RbGKos7w
         xuy4Oy6P9vVJaVpWW0QT9JvcPlrY0IMzwG4Zyv5izpRV0qhn8fFqxb2go9is72shMkrd
         vxLac3ocTxUp/VYI/WhteLXkc3dBMPvsOLtJV7g4R3gv2ZCP0tr/myGnX2WTI4z4B6FO
         NqJ92U6daQ+EiUbA0qe7Oy+E/RfbklK40QTv6Vni2nmjLuFB5lnByjrwrwz5p+uS3NDE
         XhGZfxpVIGLdTM5R+cSICope7LA/+6mYKXw9k9TlC+B0ct4QhQDl0qz4S0Ik/hjX7I3e
         hhQw==
X-Gm-Message-State: ANoB5pkBlg/6hMJ8xNeYTTloTpfAAahBETRXj9DgqK2df6Ra/xX8NhDR
        KD2eyxKipIeRU5FXZhEDXhgmBw==
X-Google-Smtp-Source: AA0mqf54wtZs225FHFwy4u2vNw7pAUL37boEkl/v7zKM5DRyM++jr9L4yfp17P5dR13GSwjWzHut/g==
X-Received: by 2002:ac8:1003:0:b0:398:27cc:8c31 with SMTP id z3-20020ac81003000000b0039827cc8c31mr6935732qti.416.1669080770069;
        Mon, 21 Nov 2022 17:32:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bw6-20020a05622a098600b003988b3d5280sm7557076qtb.70.2022.11.21.17.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:32:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:32:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
In-Reply-To: <Y3vI58VtjiAkorUX@cmpxchg.org>
Message-ID: <b6c842f-6656-447c-b743-3fe6629d2b47@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <20221121165938.oid3pemsfkaeq3ws@google.com> <Y3vI58VtjiAkorUX@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022, Johannes Weiner wrote:
> On Mon, Nov 21, 2022 at 04:59:38PM +0000, Shakeel Butt wrote:
> > On Fri, Nov 18, 2022 at 01:08:13AM -0800, Hugh Dickins wrote:
> > > Linus was underwhelmed by the earlier compound mapcounts series:
> > > this series builds on top of it (as in next-20221117) to follow
> > > up on his suggestions - except rmap.c still using lock_page_memcg(),
> > > since I hesitate to steal the pleasure of deletion from Johannes.
> > 
> > Is there a plan to remove lock_page_memcg() altogether which I missed? I
> > am planning to make lock_page_memcg() a nop for cgroup-v2 (as it shows
> > up in the perf profile on exit path) but if we are removing it then I
> > should just wait.
> 
> We can remove it for rmap at least, but we might be able to do more.

I hope the calls from mm/rmap.c can be deleted before deciding the
bigger picture for lock_page_memcg() itself; getting rid of it would
be very nice, but it has always had a difficult job to do (and you've
devoted lots of good effort to minimizing it).

> 
> Besides rmap, we're left with the dirty and writeback page transitions
> that wrt cgroups need to be atomic with NR_FILE_DIRTY and NR_WRITEBACK.
> 
> Looking through the various callsites, I think we can delete it from
> setting and clearing dirty state, as we always hold the page lock (or
> the pte lock in some instances of folio_mark_dirty). Both of these are
> taken from the cgroup side, so we're good there.
> 
> I think we can also remove it when setting writeback, because those
> sites have the page locked as well.
> 
> That leaves clearing writeback. This can't hold the page lock due to
> the atomic context, so currently we need to take lock_page_memcg() as
> the lock of last resort.
> 
> I wonder if we can have cgroup take the xalock instead: writeback
> ending on file pages always acquires the xarray lock. Swap writeback
> currently doesn't, but we could make it so (swap_address_space).

It's a little bit of a regression to have to take that lock when
ending writeback on swap (compared with the rcu_read_lock() of almost
every lock_page_memcg()); but I suppose if swap had been doing that
all along, like the normal page cache case, I would not be complaining.

> 
> The only thing that gives me pause is the !mapping check in
> __folio_end_writeback. File and swapcache pages usually have mappings,
> and truncation waits for writeback to finish before axing
> page->mapping. So AFAICS this can only happen if we call end_writeback
> on something that isn't under writeback - in which case the test_clear
> will fail and we don't update the stats anyway. But I want to be sure.
> 
> Does anybody know from the top of their heads if a page under
> writeback could be without a mapping in some weird cornercase?

End of writeback has been a persistent troublemaker, in several ways;
I forget whether we are content with it now or not.

I would not trust whatever I think OTOH of that !mapping case, but I
was deeper into it two years ago, and find myself saying "Can mapping be
NULL? I don't see how, but allow for that with a WARN_ON_ONCE()" in a
patch I posted then (but it didn't go in, we went in another direction).

I'm pretty sure it never warned once for me, but I probably wasn't doing
enough to test it.  And IIRC I did also think that the !mapping check had
perhaps been copied from a related function, one where it made more sense.

It's also worth noting that the two stats which get decremented there,
NR_WRITEBACK and NR_ZONE_WRITE_PENDING, are two of the three which we
have commented "Skip checking stats known to go negative occasionally"
in mm/vmstat.c: I never did come up with a convincing explanation for
that (Roman had his explanation, but I wasn't quite convinced).
Maybe it would just be wrong to touch them if mapping were NULL.

> 
> If we could ensure that the NR_WRITEBACK decs are always protected by
> the xalock, we could grab it from mem_cgroup_move_account(), and then
> kill lock_page_memcg() altogether.

I suppose so (but I still feel grudging about the xalock for swap).

Hugh
