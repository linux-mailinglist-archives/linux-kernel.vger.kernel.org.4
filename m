Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C765C5BBFE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 22:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIRUkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 16:40:39 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA378140C8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:40:37 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id m66so28008963vsm.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=p2Y379zqkwz40ZL+4t+CIYoyTLObybL6KsnvdRTVh1w=;
        b=CMNhyAKgueFSnC433vb3wgkwkZ42HQt3WLZ7GEF7I05l0r8US1a01hlcGjTQD3g+9t
         l9jySJJ5TxbFOfF26oa5qfDzWv0DyyH7toXvocwOzifhitj8LL8/H8Y00rk46phggwDD
         fMvc7Kepq2m/8Fook+KqkCu5EYAnqjUbxe/OJhCKYXZyMRArlDl/8TqZkEbBR6kNWjOw
         c40mmBnBNstVSwKQKDTwHGRhb3BQIJT7orXgWM9d5bnQZ0/G61ntKz3yyNdnWhB8ciXq
         8v/SghhHV2PDK4CivHHzGBNJ9TB+5ZPfPo3r5de5YDKmLkZJKIH6vaCSQSBEDEAbWVNk
         KScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p2Y379zqkwz40ZL+4t+CIYoyTLObybL6KsnvdRTVh1w=;
        b=M19yoVP9X00OOiZxogol5Gg83X5h8CtNuSK8ZPH0mbEnCx79OebSCFTmnOTFKjQBs2
         XOj+x10d3Kg5x7pssPCJ0lOUt7xrYpkNlQLf2OczEPDzoXRjmtPb0qZL/WmCN2rldgPK
         yaPc7dijbbqpzAgA8R8ufKbgBtP1TlmJ2pqQX0F+B6UuBIe4gGVic3yWFLK7yKiLKSuR
         mtz8L/Zu/pbQMZ3bz21re4qNez9CVN6k0Zhn2fCQdsXTT+Vo/y1QVYVcLTbfeDmDztbB
         OeJx8yEpugsYl+joZLbcQiYNaNDhVf70l8LgMrhZkjmVNUaaHCcSd3lkitYSRd5HjO3m
         ohzQ==
X-Gm-Message-State: ACrzQf3dSC+uzEbNoU9bIL+kvZmCTzuNpWECOKAit2vn7WF5IDOcg58V
        gasOwfLG8vQBXKhJl2e9V21s6/Nj1j7VmHUo8iVH3g==
X-Google-Smtp-Source: AMsMyM5zsVVinbCD1mPksNskV06acgMEYCscCac9teY2zIOIGR1JAkwN86Uoa+vkhuhs7gR4TmsSqOguAcLBmI9QjPg=
X-Received: by 2002:a05:6102:3309:b0:39a:e5eb:8508 with SMTP id
 v9-20020a056102330900b0039ae5eb8508mr1821685vsc.65.1663533636994; Sun, 18 Sep
 2022 13:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220911170814.f6a32b40e64397a61b1f8daf@linux-foundation.org>
 <CAOUHufZk-u0S+FyDEdxw1nehBKz_G_GG_3_LAzqyssx21Wd4Jw@mail.gmail.com>
In-Reply-To: <CAOUHufZk-u0S+FyDEdxw1nehBKz_G_GG_3_LAzqyssx21Wd4Jw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 18 Sep 2022 14:40:01 -0600
Message-ID: <CAOUHufZzDCezgeeAj6M3WqOQKJYxQ_4jNCD8itU0+J6JE_fV4g@mail.gmail.com>
Subject: Re: [PATCH v14 00/14] Multi-Gen LRU Framework
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:56 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Sun, Sep 11, 2022 at 6:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > I'd like to move mglru into the mm-stable branch late this week.
> >
> > I'm not terribly happy about the level of review nor the carefulness of
> > the code commenting (these things are related) and I have a note here
> > that "mm: multi-gen LRU: admin guide" is due for an update and everyone
> > is at conference anyway.  But let's please try to push things along anyway.
>
> Thanks for the heads-up. Will add as many comments as I can and wrap
> it up by the end of tomorrow.

I've posted v15 which can replace what mm-unstable currently has.
Apologies for the delay: an unexpected lockdep warning from the maple
tree forced me to restart all the tests [1].

Let me also post the incremental patches after this email, in case you
strongly prefer to add them on top of v14.

[1] https://lore.kernel.org/r/CAOUHufZabH85CeUN-MEMgL8gJGzJEWUrkiM58JkTbBhh-jew0Q@mail.gmail.com/
