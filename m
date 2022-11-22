Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A88634B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiKVXcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:32:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C861F9C4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:32:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r81so12109048iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWJ+GZXZo5zWa4BKCujlUhJy9HSlbiEbgX1mU4yP55A=;
        b=DsnHY0ebRPdWaw2nDwvA1LT5fUI0++sr53mDWpr8V1qWqdYSXnwnDXtT3uU5vvKuOm
         HgJGsaM5eSkzJY2iKh7hdqVwIwDDKYgSJ4BQfafkD+y7t/iMQNTCSMaHdisX5fKA4I9D
         swTh+pw8iUthMILYRxHZ0xycIkuYEwZZE6g9DLXG+5QRUMOJZZ6yqgdYd2+Heo4DaXE0
         8w7tajfDOx7MubMoxzRJBGlFeV7y1kLfos9nOq+/mc+t6D/+hDmDsW+t/FVmQdODuyIn
         0xlCVXlyx1mq9rbBoju4CC9y9jzsn71orq1D//YW7/huZ9OM6OpsgBhDcE3NTcJYHqZ3
         4fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWJ+GZXZo5zWa4BKCujlUhJy9HSlbiEbgX1mU4yP55A=;
        b=Y2ZMY7NEGYON72PXkWrrw2ThK7CfnhTIfOfOY7qpKb4Ys+vFRNyaWQTsAhNcgDdH+p
         ZWmb/j3CB4dwkeXazpD50KtWAhqTqOa33lin59ZzEUTWm1l5hqmRUthTfUrRrjs9DlGu
         J68qKU+/ZcNrUD7WVOl9F0P6RT+2yFHsD8ANC2Knb3ySaaFhufdAVtcj6PSVDnNtVcxS
         w+3CmNBOlyOsmU42CYuvKrdjBVxl2EpomLwSwmJrcdTfl+5zW/GvY+e93BZq4Ns0vyhz
         B6qThAgCbJJonUgQlaEFaA5pGaETHNG0+9vqhRJ+l8eykvDb1Qmj+EbtWsxC3pYgRbNC
         sAhw==
X-Gm-Message-State: ANoB5pmGkNBdPlfdlQNszHhvq+w8gN8SOzD86GxJuYfkDKZnYyUzMafg
        o7qbfIcoHyKAP78NfasROkvWT6mJkXqgPKtJFJbxPg==
X-Google-Smtp-Source: AA0mqf4ISiP7/VVyttLWrFl67FfC01wAJT1n1rrSXxZN0bi4OpMPaVsYw01hoG2ppi2+fTwcXTs9l5tFSEbgm12FqlY=
X-Received: by 2002:a02:9422:0:b0:373:2c18:a37e with SMTP id
 a31-20020a029422000000b003732c18a37emr11714430jai.51.1669159920647; Tue, 22
 Nov 2022 15:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20221122232721.2306102-1-yosryahmed@google.com>
In-Reply-To: <20221122232721.2306102-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Nov 2022 15:31:24 -0800
Message-ID: <CAJD7tkYPipcY9XzZNhdMdBEczkTGysfZhhGG4WVZJda7hTi6ww@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix stale protection of reclaim target memcg
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="00000000000025602405ee1794aa"
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

--00000000000025602405ee1794aa
Content-Type: text/plain; charset="UTF-8"

+David Rientjes

The attached test reproduces the problem on a cgroup v2 hierarchy
mounted with memory_recursiveprot, and fails without this patch.

On Tue, Nov 22, 2022 at 3:27 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> During reclaim, mem_cgroup_calculate_protection() is used to determine
> the effective protection (emin and elow) values of a memcg. The
> protection of the reclaim target is ignored, but we cannot set their
> effective protection to 0 due to a limitation of the current
> implementation (see comment in mem_cgroup_protection()). Instead,
> we leave their effective protection values unchaged, and later ignore it
> in mem_cgroup_protection().
>
> However, mem_cgroup_protection() is called later in
> shrink_lruvec()->get_scan_count(), which is after the
> mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
> result, the stale effective protection values of the target memcg may
> lead us to skip reclaiming from the target memcg entirely, before
> calling shrink_lruvec(). This can be even worse with recursive
> protection, where the stale target memcg protection can be higher than
> its standalone protection.
>
> An example where this can happen is as follows. Consider the following
> hierarchy with memory_recursiveprot:
> ROOT
>  |
>  A (memory.min = 50M)
>  |
>  B (memory.min = 10M, memory.high = 40M)
>
> Consider the following scenarion:
> - B has memory.current = 35M.
> - The system undergoes global reclaim (target memcg is NULL).
> - B will have an effective min of 50M (all of A's unclaimed protection).
> - B will not be reclaimed from.
> - Now allocate 10M more memory in B, pushing it above it's high limit.
> - The system undergoes memcg reclaim from B (target memcg is B)
> - In shrink_node_memcgs(), we call mem_cgroup_calculate_protection(),
>   which immediately returns for B without doing anything, as B is the
>   target memcg, relying on mem_cgroup_protection() to ignore B's stale
>   effective min (still 50M).
> - Directly after mem_cgroup_calculate_protection(), we will call
>   mem_cgroup_below_min(), which will read the stale effective min for B
>   and skip it (instead of ignoring its protection as intended). In this
>   case, it's really bad because we are not just considering B's
>   standalone protection (10M), but we are reading a much higher stale
>   protection (50M) which will cause us to not reclaim from B at all.
>
> This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
> e{low,min} state mutations from protection checks") which made
> mem_cgroup_calculate_protection() only change the state without
> returning any value. Before that commit, we used to return
> MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
> mem_cgroup_below_{min/low}() checks. After that commit we do not return
> anything and we end up checking the min & low effective protections for
> the target memcg, which are stale.
>
> Add mem_cgroup_ignore_protection() that checks if we are reclaiming from
> the target memcg, and call it in mem_cgroup_below_{min/low}() to ignore
> the stale protection of the target memcg.
>
> Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
>  mm/vmscan.c                | 11 ++++++-----
>  2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e1644a24009c..22c9c9f9c6b1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -625,18 +625,32 @@ static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
>
>  }
>
> -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
> +                                               struct mem_cgroup *memcg)
>  {
> -       if (!mem_cgroup_supports_protection(memcg))
> +       /*
> +        * The target memcg's protection is ignored, see
> +        * mem_cgroup_calculate_protection() and mem_cgroup_protection()
> +        */
> +       return target == memcg;
> +}
> +
> +static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
> +{
> +       if (!mem_cgroup_supports_protection(memcg) ||
> +           mem_cgroup_ignore_protection(target, memcg))
>                 return false;
>
>         return READ_ONCE(memcg->memory.elow) >=
>                 page_counter_read(&memcg->memory);
>  }
>
> -static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
> -       if (!mem_cgroup_supports_protection(memcg))
> +       if (!mem_cgroup_supports_protection(memcg) ||
> +           mem_cgroup_ignore_protection(target, memcg))
>                 return false;
>
>         return READ_ONCE(memcg->memory.emin) >=
> @@ -1209,12 +1223,19 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  {
>  }
>
> -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
> +                                               struct mem_cgroup *memcg)
> +{
> +       return false;
> +}
> +static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
>         return false;
>  }
>
> -static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
> +                                       struct mem_cgroup *memcg)
>  {
>         return false;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04d8b88e5216..79ef0fe67518 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4486,7 +4486,7 @@ static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned
>
>         mem_cgroup_calculate_protection(NULL, memcg);
>
> -       if (mem_cgroup_below_min(memcg))
> +       if (mem_cgroup_below_min(NULL, memcg))
>                 return false;
>
>         need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, swappiness, &nr_to_scan);
> @@ -5047,8 +5047,9 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
>         DEFINE_MAX_SEQ(lruvec);
>         DEFINE_MIN_SEQ(lruvec);
>
> -       if (mem_cgroup_below_min(memcg) ||
> -           (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
> +       if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
> +           (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
> +            !sc->memcg_low_reclaim))
>                 return 0;
>
>         *need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &nr_to_scan);
> @@ -6048,13 +6049,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>
>                 mem_cgroup_calculate_protection(target_memcg, memcg);
>
> -               if (mem_cgroup_below_min(memcg)) {
> +               if (mem_cgroup_below_min(target_memcg, memcg)) {
>                         /*
>                          * Hard protection.
>                          * If there is no reclaimable memory, OOM.
>                          */
>                         continue;
> -               } else if (mem_cgroup_below_low(memcg)) {
> +               } else if (mem_cgroup_below_low(target_memcg, memcg)) {
>                         /*
>                          * Soft protection.
>                          * Respect the protection only as long as
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

--00000000000025602405ee1794aa
Content-Type: text/x-sh; charset="US-ASCII"; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_lasup05w0>
X-Attachment-Id: f_lasup05w0

IyEvYmluL2Jhc2gKIwojIE1vdW50ZWQgd2l0aDoKIyAgIG1vdW50IC10IGNncm91cDIgLW8gbWVt
b3J5X3JlY3Vyc2l2ZXByb3Qgbm9uZSAkUk9PVAojIE9yIHJlbW91bnRlZCB3aXRoOgojICAgbW91
bnQgLW8gcmVtb3VudCxtZW1vcnlfcmVjdXJzaXZlcHJvdCAkUk9PVAoKIyBEZWZhdWx0IHJvb3Qg
cGF0aAo6ICR7Uk9PVDo9Ii9zeXMvZnMvY2dyb3VwIn0KQT0iJFJPT1QvQSIKQj0iJEEvQiIKCiMg
RGVmYXVsdCB0byBjdXJyZW50IGRpcmVjdG9yeQo6ICR7VEVTVF9ESVI6PS59ClNXQVBGSUxFPQpU
TVBGUz0KUElQRT0KCnNldHVwKCkgewogIHNldCAtZQoKICAjIFNldHVwIDEwME0gc3dhcGZpbGUK
ICBTV0FQRklMRT0ke1RFU1RfRElSfS90ZXN0X3N3YXBmaWxlCiAgZGQgaWY9L2Rldi96ZXJvIG9m
PSRTV0FQRklMRSBicz0xTSBjb3VudD0xMDAgc3RhdHVzPW5vbmUKICBjaG1vZCA2MDAgJFNXQVBG
SUxFCiAgbWtzd2FwICRTV0FQRklMRSA+IC9kZXYvbnVsbAogIHN3YXBvbiAkU1dBUEZJTEUKCiAg
IyBTZXR1cCB0bXBmcwogIFRNUEZTPSR7VEVTVF9ESVJ9L3Rlc3RfdG1wZnMKICBta2RpciAkVE1Q
RlMKICBtb3VudCAtdCB0bXBmcyB0bXBmcyAkVE1QRlMKCiAgIyBTZXR1cCBwaXBlCiAgUElQRT0k
e1RFU1RfRElSfS90ZXN0X3BpcGUKICBta2ZpZm8gJFBJUEUKCiAgIyBTZXR1cCByb290CiAgZW5h
YmxlX21lbWNnX3N1YnRyZWUgJFJPT1QKCiAgIyBTZXR1cCBBCiAgbWtkaXIgJEEKICBlbmFibGVf
bWVtY2dfc3VidHJlZSAkQQogIGVjaG8gNTBNID4gIiRBL21lbW9yeS5taW4iCgogICMgU2V0dXAg
QgogIG1rZGlyICRCCiAgZWNobyAxME0gPiAiJEIvbWVtb3J5Lm1pbiIKICBlY2hvIDQwTSA+ICIk
Qi9tZW1vcnkuaGlnaCIKfQoKY2xlYW51cCgpIHsKICBzZXQgK2UKCiAgIyBLaWxsIGFueSBwcm9j
cyBpbiBCIGZpcnN0LCB0aGVuIHJlbW92ZSBpdC4KICBwcm9jcz0kKGNhdCAkQi9jZ3JvdXAucHJv
Y3MpCiAgaWYgW1sgLW4gJHByb2NzIF1dOyB0aGVuCiAgICBraWxsIC1LSUxMICRwcm9jcwogICAg
d2FpdCAkcHJvY3MgMj4vZGV2L251bGwKICBmaQogIHdoaWxlIFtbIC1uICQoY2F0ICRCL2Nncm91
cC5wcm9jcykgXV07IGRvCiAgICBzbGVlcCAwLjEKICBkb25lCiAgcm1kaXIgJEIKCiAgIyBSZW1v
dmUgQQogIHJtZGlyICRBCgogICMgQ2xlYW51cCBldmVyeXRoaW5nIGVsc2UKICBpZiBbWyAtbiAk
VE1QRlMgXV07IHRoZW4KICAgIHVtb3VudCAkVE1QRlMKICAgIHJtZGlyICRUTVBGUwogIGZpCiAg
c3dhcG9mZiAkU1dBUEZJTEUKICBybSAkU1dBUEZJTEUKICBybSAkUElQRQp9CgpmYWlsKCkgewog
IGVjaG8gIltGQUlMXSAkKiIKICBleGl0IDEKfQoKcGFzcygpIHsKICBlY2hvICJbUEFTU10gJCoi
Cn0KCmFsbG9jYXRlX3RtcGZzKCkgewogIGVjaG8gMCA+ICQxL2Nncm91cC5wcm9jcwogIGRkIGlm
PS9kZXYvemVybyBicz0xTSBjb3VudD0kMiA+PiAkVE1QRlMvZmlsZSBzdGF0dXM9bm9uZQogIGVj
aG8gInRtcGZzIiA+ICRQSVBFCiAgc2xlZXAgMTAwMAp9Cgp3YWl0X2Zvcl9waXBlKCkgewogIGlm
IHJlYWQgLXQgMTAgbGluZSA8ICRQSVBFOyB0aGVuCiAgICBpZiBbWyAkbGluZSA9PSAidG1wZnMi
IF1dOyB0aGVuCiAgICAgIHJldHVybgogICAgZWxzZQogICAgICBmYWlsICJ3cm9uZyBpbnB1dCAo
JGxpbmUpIHJlY2VpdmVkIG9uIHBpcGUsIGV4cGVjdGVkICh0bXBmcykiCiAgICBmaQogIGZpCiAg
ZmFpbCAicGlwZSB0aW1vZXV0Igp9CgptZW1jZ191c2FnZSgpIHsKICBjYXQgJDEvbWVtb3J5LmN1
cnJlbnQKfQoKZW5hYmxlX21lbWNnX3N1YnRyZWUoKSB7CiAgZWNobyAiK21lbW9yeSIgPiAiJDEv
Y2dyb3VwLnN1YnRyZWVfY29udHJvbCIKfQoKdHJhcCBjbGVhbnVwIEVYSVQKCmVjaG8gIlJlZmVy
ZW5jZSBjYXNlIgojIEE6IG1lbW9yeS5taW4gPSA1ME0KIyBBL0I6IG1lbW9yeS5taW4gPSAxME0s
IG1lbW9yeS5oaWdoID0gNDBNCiMgQWxsb2NhdGUgMzUgTSBpbiBCLCBub3RoaW5nIGhhcHBlbnMK
IyBBbGxvY2F0ZSAxMCBNIG1vcmUgaW4gQiwgbWVtb3J5LmhpZ2ggcHVzaGVzIHVzIGJhY2sgYmVs
b3cgNDAgTQpzZXR1cAoKKGFsbG9jYXRlX3RtcGZzICRCIDM1KSYKd2FpdF9mb3JfcGlwZQoKdXNh
Z2VfbWI9JCgoICQobWVtY2dfdXNhZ2UgJEIpIC8gKDEwMjQgKiAxMDI0KSApKQplY2hvICJCJ3Mg
dXNhZ2UgYWZ0ZXIgaW5pdGlhbCBhbGxvY2F0aW9uOiAkdXNhZ2VfbWIgTSIKCihhbGxvY2F0ZV90
bXBmcyAkQiAxMCkmCndhaXRfZm9yX3BpcGUKCnVzYWdlX21iPSQoKCAkKG1lbWNnX3VzYWdlICRC
KSAvICgxMDI0ICogMTAyNCkgKSkKZWNobyAiQidzIHVzYWdlIGFmdGVyIGFsbG9jYXRpb24gYmV5
b25kIGhpZ2g6ICR1c2FnZV9tYiBNIgoKaWYgW1sgJHVzYWdlX21iIC1sZSA0MCBdXTsgdGhlbgog
IHBhc3MgIm1lbW9yeS5oaWdoIGVuZm9yY2VkIGVmZmVjdGl2ZWx5IgplbHNlCiAgZmFpbCAibWVt
b3J5LmhpZ2ggbm90IGVuZm9yY2VkIgpmaQoKY2xlYW51cAoKZWNobyAiQ29ybmVyIGNhc2UiCiMg
Q29ybmVyIGNhc2UKIyBTYW1lIHNldHVwIGFzIGFib3ZlCiMgQWxsb2NhdGUgMzUgTSBpbiBCLCBu
b3RoaW5nIGhhcHBlbnMKIyBJbnZva2UgZ2xvYmFsIHJlY2xhaW0sIGFsbCBvZiBCJ3MgbWVtb3J5
IHNob3VsZCBiZSBwcm90ZWN0ZWQgYnkgQSdzIG1lbW9yeS5taW4KIyBBbGxvY2F0ZSAxMCBNIG1v
cmUgaW4gQiwgbWVtb3J5IGhpZ2ggc2hvdWxkIHB1c2ggdXMgYmFjayBiZWxvdyA0MCBNCnNldHVw
CgooYWxsb2NhdGVfdG1wZnMgJEIgMzUpJgp3YWl0X2Zvcl9waXBlCgp1c2FnZV9tYj0kKCggJCht
ZW1jZ191c2FnZSAkQikgLyAoMTAyNCAqIDEwMjQpICkpCmVjaG8gIkIncyB1c2FnZSBhZnRlciBp
bml0aWFsIGFsbG9jYXRpb246ICR1c2FnZV9tYiBNIgoKIyBTaW11bGF0ZSBnbG9iYWwgcmVjbGFp
bQpzZXQgK2UKZWNobyAxME0gPiAkUk9PVC9tZW1vcnkucmVjbGFpbQpzZXQgLWUKCnVzYWdlX21i
PSQoKCAkKG1lbWNnX3VzYWdlICRCKSAvICgxMDI0ICogMTAyNCkgKSkKZWNobyAiQidzIHVzYWdl
IGFmdGVyIGdsb2JhbCByZWNsYWltOiAkdXNhZ2VfbWIgTSIKCiMgQiBzaG91bGQgYmUgZnVsbHkg
cHJvdGVjdGVkIGZyb20gZ2xvYmFsIHJlY2xhaW0gYnkgQSdzIG1pbgp1c2FnZV9tYl9hZnRlcj0k
KCggJChtZW1jZ191c2FnZSAkQikgLyAoMTAyNCAqIDEwMjQpICkpCmlmIFtbICR1c2FnZV9tYl9h
ZnRlciAtbmUgJHVzYWdlX21iIF1dOyB0aGVuCiAgZmFpbCAiQSdzIG1lbW9yeS5taW4gZGlkIG5v
dCBwcm90ZWN0IEIgZnJvbSBnbG9iYWwgcmVjbGFpbSIKZWxzZQogIHBhc3MgIkEncyBtZW1vcnku
bWluIHByb3RlY3RlZCBCIGZyb20gZ2xvYmFsIHJlY2xhaW0iCmZpCgooYWxsb2NhdGVfdG1wZnMg
JEIgMTApJgp3YWl0X2Zvcl9waXBlCgojIEIncyBtZW1vcnkuaGlnaCBzaG91bGQgYmUgZW5mb3Jj
ZWQgYW5kIGl0IHNob3VsZCByZW1haW4gYmVsb3cgNDBNCnVzYWdlX21iPSQoKCAkKG1lbWNnX3Vz
YWdlICRCKSAvICgxMDI0ICogMTAyNCkgKSkKZWNobyAiQidzIHVzYWdlIGFmdGVyIGdsb2JhbCBy
ZWNsYWltOiAkdXNhZ2VfbWIgTSIKCmlmIFtbICR1c2FnZV9tYiAtbGUgNDAgXV07IHRoZW4KICBw
YXNzICJtZW1vcnkuaGlnaCBlbmZvcmNlZCBlZmZlY3RpdmVseSIKZWxzZQogIGZhaWwgIm1lbW9y
eS5oaWdoIG5vdCBlbmZvcmNlZCIKZmkK
--00000000000025602405ee1794aa--
