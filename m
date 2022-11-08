Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7D6218BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiKHPra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiKHPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:47:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE11FD2B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:47:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id w4so8903619qts.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrmtWHF5svuELzO7ajcbneYYKL4MlzN5FNv548nxCrA=;
        b=Zgst8G0oRQ5ICrfogThsRX0A6nMRThBhTvSH3pMKfZSnjRFGCwPIhf02v9ntE044oP
         52AEgmD7hB5F5x64O7q38Q43rpEoKlMyYp98gpzJBVT584JtoQnSzRNzj9ckbTmhtfMr
         fbS5lGj2J7g/bU+t3Ls4RXAgoExcZ0NnzqP/cuxWxBurQEkKJxgZXe7BpQG3Hl8ZsfVu
         2L6spjh+RpXddGhJ/U3fkvcdsnP82/Fj2QP84AxHqqCV7LJxFkehnJm7ImOur3bCFqbJ
         Wv/DHdeTOTWO+ngssQFFhUg8ONiSOeD4SQ2b9r6SguZq5GbG8M1kF8kCtc/btpQzSWCu
         kyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrmtWHF5svuELzO7ajcbneYYKL4MlzN5FNv548nxCrA=;
        b=aUsIBcCl9tBb6VWt4I9mDYMtDi6zMfmPsMCsm2pL145eyuQL3ZRWA3d09tsziveAce
         7lnMNseHSeTqWMg0IN4sNFE2JwGltEOynFv3/TzEHYSKreMdC0t4eYX8frfyi+FYda77
         iFUkrZoYkilip6Q1FJJK5G7olrxWL/b/Llc3juYCEZv04eCPvVRu2V+7pGjzEOyquem8
         X3H/6pt5YJ7dxrz9rIQo6jrxDhFiHGZzt5GTNYJ9J7uo977WqEO+SXq6inFMU+sV/hhb
         WWGIiIXa0hSESEAxeATF8Ngryeps+UmxaV3XTESWlz6jvKCKP7qlClDiYLzX/yUI+aSW
         DbiA==
X-Gm-Message-State: ACrzQf3j3ba9J7IkCtCknX6paWN8mwht17pYlGQ0EeSE/rT8T4SGx1U4
        eKmbp4gegtYWb7kRMrkEeV25TA==
X-Google-Smtp-Source: AMsMyM75P96/HEXYrQlJIlj7Qzfy6nt1fsvtexwWn6NmpjoTeB5ppWCs2d7xZys/FZUJiDTFKg+cow==
X-Received: by 2002:a05:622a:13c8:b0:3a5:4cee:4ecc with SMTP id p8-20020a05622a13c800b003a54cee4eccmr24123780qtk.351.1667922446237;
        Tue, 08 Nov 2022 07:47:26 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006f3e6933bacsm9660665qko.113.2022.11.08.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:47:24 -0800 (PST)
Date:   Tue, 8 Nov 2022 07:47:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
In-Reply-To: <20221108135703.cthdmjl2lfpnairr@techsingularity.net>
Message-ID: <dc5548f6-00-8027-bf79-397d552ec338@google.com>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net> <97b7ae87-797c-4ebb-d2d3-9415975188@google.com> <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net> <486a93d7-4140-60c9-1aa8-8dafc8c66210@google.com>
 <20221108135703.cthdmjl2lfpnairr@techsingularity.net>
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

On Tue, 8 Nov 2022, Mel Gorman wrote:
> On Tue, Nov 08, 2022 at 01:40:48AM -0800, Hugh Dickins wrote:
> > On Mon, 7 Nov 2022, Mel Gorman wrote:
> > > On Sun, Nov 06, 2022 at 08:42:32AM -0800, Hugh Dickins wrote:
> > > > On Fri, 4 Nov 2022, Mel Gorman wrote:
> > > > What I'm really trying to do is fix
> > > > the bug in Linus's rmap/TLB series, and its interaction with my
> > > > rmap series, and report back on his series (asking for temporary
> > > > drop), before next-20221107 goes down in flames.
> > > > 
> > > > I'd advocate for dropping this patch of yours too; but if it's giving
> > > > nobody else any trouble, I can easily continue to patch it out.
> > > > 
> > > 
> > > Given that you tested the patch against v6.1-rc3, it's clear that the
> > > patch on its own causes problems. Having a reproduction case will help
> > > me figure out why.
> > 
> > Sorry for appearing to ignore your requests all day, Mel, but I just
> > had slightly more confidence in debugging it here, than in conveying
> > all the details of my load (some other time), and my config, and
> > actually enabling you to reproduce it.  Had to focus.
> > 
> 
> Ok, understood. If you ever get the chance to give me even a rough
> description, I'd appreciate it but I understand that it's a distraction
> at the moment. Thanks for taking the time to debug this in your test
> environment.

I have sent it out two or three times before (I prefer privately, so my
limited shell scripting skills are not on public view!): later in the day
I'll look out the last time I sent it, and just forward that to you.
No doubt I'll have tweaked it here and there in my own usage since then,
but that will be good enough to show what I try for.

Wonderful if it could get into something like mmtests, but I should
warn that attempts to incorporate it into other frameworks have not
been successful in the past.  Maybe it just needs too much handholding:
getting the balance right, so that it's stressing without quite OOMing,
is difficult in any new environment.  Perhaps it should restart after
OOM, I just never tried to go that way.

> 
> > Got it at last: free_unref_page_list() has been surviving on the
> > "next" in its list_for_each_entry_safe() for years(?), without doing
> > a proper list_del() in that block: only with your list_del() before
> > free_one_page() did it start to go so very wrong.  (Or was there any
> > way in which it might already have been wrong, and needs backport?)
> > 
> 
> I think it happened to work by coincidence since forever because it was
> always adding to the same list. Even though the temporary list was
> thrashed, it is always either ignored or reinitialised.
> 
> I've made this a standalone patch which is at the end of the mail. I can
> change the Reported-by to a Signed-off-by if you agree. While it doesn't
> fix anything today, it may still be worth documenting in git history why
> that list_del exists.

Yes, worth separating out to its own git commit.  Just continue with what
you already have, Reported-by me, Signed-off-by you, thanks for asking.

> 
> > Here's a few things to fold into your patch: I've moved your
> > list_del() up to cover both cases, that's the important fix;
> > but prior to finding that, I did notice a "locked_zone = NULL"
> > needed, and was very disappointed when that didn't fix the issues;
> 
> This is a real fix but it also should happen to work properly which is
> less than ideal because it's fragile.

I thought that if the next page's zone matched the stale locked_zone,
then it would head into free_unref_page_commit() with NULL pcp, and
oops there?  But I've certainly never seen that happen (despite first
assuming it was responsible for my crashes), so maybe I read it wrong.

> 
> > zone instead of page_zone(page), batch_count = 0, lock hold times
> > were just improvements I noticed along the way.
> > 
> 
> The first is a small optimisation, the second addresses a corner case where
> the lock may be released/reacquired too soon after switching from one zone to
> another and the comment fix is valid. I've simply folded these in directly.
> 
> The standalone patch is below, I'm rerunning tests before posting a
> short v3 series.

Great, thanks Mel.

Hugh

> 
> Thanks!
> 
> --8<--
> mm/page_alloc: Always remove pages from temporary list
> 
> free_unref_page_list() has neglected to remove pages properly from the list
> of pages to free since forever. It works by coincidence because list_add
> happened to do the right thing adding the pages to just the PCP lists.
> However, a later patch added pages to either the PCP list or the zone list
> but only properly deleted the page from the list in one path leading to
> list corruption and a subsequent failure. As a preparation patch, always
> delete the pages from one list properly before adding to another.  On its
> own, this fixes nothing although it adds a fractional amount of overhead
> but is critical to the next patch.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 218b28ee49ed..1ec54173b8d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3546,6 +3546,8 @@ void free_unref_page_list(struct list_head *list)
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		struct zone *zone = page_zone(page);
>  
> +		list_del(&page->lru);
> +
>  		/* Different zone, different pcp lock. */
>  		if (zone != locked_zone) {
>  			if (pcp)
> 
> -- 
> Mel Gorman
> SUSE Labs
