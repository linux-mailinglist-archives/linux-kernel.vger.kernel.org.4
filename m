Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658557207EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjFBQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjFBQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:49:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5072196
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:49:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75afa109e60so217425585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685724584; x=1688316584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UQdCHARuiwiuV0zQiL53aYkSXJ/lt2DZ527kuxBwaY=;
        b=CIbrKYKMxgv+t6fixphVWkC0XWrLAyTWTUlLZkgYk2HBxaiD2NczHhQjU6ISFSVv5Z
         dXtSVC8kYXjZc16PGFUNhq8NbuB9+6DIYbNDSmHpKeEya/OGChgKs1tus81bGVuRMm4T
         a5E2v6DdUbOvbK5ybeYeYpfrKYT5D/KG0NNxid94JKMeEdqvez3oha9yQ8gKGh21oElz
         9tq0P0Bq192rXi4jlVryqygLyNMw/1p4Cg1wJzHvrQ2gfg/Ps3H26iwd4EG/C1W8YVhv
         Et5wg9w3Te0f1Hiq0qITMVKyMa04ek6/Q7v5ByDfgTe6Oqw55UM3xotYjz9x9KnN3MBj
         sG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724584; x=1688316584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UQdCHARuiwiuV0zQiL53aYkSXJ/lt2DZ527kuxBwaY=;
        b=hrpM42JYY8q/7fEeDqOWk//jrWNxNH1kFLfyjpFzoAD2h7GEK7WcgHtw+ElsRp+3tV
         6EI/T/RQhZsOoJeKubj0uepqb+KbroAT09wGoYdbRMjA3kWQHA8vDke8qQftoPYwxHqe
         Hs4NDkQHDwevlc+aOQl84BIkg+tLtik5Zoytfu8sRRqZl8ivtnXzw+cTTdyhoVUZQ0nl
         eTR9pz9+wgEaLxKhLTkYW7Gr23ubF5DtPE3bFKGOKyhewNAo51MCZUO/GOm1/K8cGXT0
         pH0jO5AmUX+cZZ210vWbX1nIIUDkzlVDrMB2cuTORo76j9Fos+fwxczFrmSuOAvFSAnc
         +qwg==
X-Gm-Message-State: AC+VfDxSQUAJwDb4RNi8QINYplda35DKCeBFA/PxYJjZUY/eXV/4teKY
        foglxGhj25b43u+IE5fs8y666Q==
X-Google-Smtp-Source: ACHHUZ6GPHDNKSfuEYK7K6EwF6N76sP755roOSBcyc1ZrWvT1aPkathtU4IT+yytVGL9anKRSqSzKQ==
X-Received: by 2002:a05:6214:2242:b0:5a3:79cd:8ef7 with SMTP id c2-20020a056214224200b005a379cd8ef7mr13654976qvc.23.1685724583763;
        Fri, 02 Jun 2023 09:49:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id f12-20020a0cf7cc000000b0062821057ac7sm1037327qvo.39.2023.06.02.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:49:43 -0700 (PDT)
Date:   Fri, 2 Jun 2023 12:49:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: multiple zpool support
Message-ID: <20230602164942.GA215355@cmpxchg.org>
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org>
 <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:51:39AM -0700, Yosry Ahmed wrote:
> On Thu, Jun 1, 2023 at 8:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Wed, May 31, 2023 at 02:29:11AM +0000, Yosry Ahmed wrote:
> > > +config ZSWAP_NR_ZPOOLS_ORDER
> > > +     int "Number of zpools in zswap, as power of 2"
> > > +     default 0
> > > +     depends on ZSWAP
> > > +     help
> > > +       This options determines the number of zpools to use for zswap, it
> > > +       will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
> > > +
> > > +       Having multiple zpools helps with concurrency and lock contention
> > > +       on the swap in and swap out paths, but uses a little bit of extra
> > > +       space.
> >
> > This is nearly impossible for a user, let alone a distribution, to
> > answer adequately.
> >
> > The optimal value needs to be found empirically. And it varies heavily
> > not just by workload but by implementation changes. If we make changes
> > to the lock holding time or redo the data structures, a previously
> > chosen value might no longer be a net positive, and even be harmful.
> 
> Yeah, I agree that this can only be tuned empirically, but there is a
> real benefit to tuning it, at least in our experience. I imagined
> having the config option with a default of 0 gives those who want to
> tune it the option, while not messing with users that do not care.

Realistically, how many users besides you will be able to do this
tuning and benefit from this?

> > Architecturally, the pool scoping and the interaction with zswap_tree
> > is currently a mess. We're aware of lifetime bugs, where swapoff kills
> > the tree but the pool still exists with entries making dead references
> > e.g. We likely need to rearchitect this in the near future - maybe tie
> > pools to trees to begin with.
> >
> > (I'm assuming you're already using multiple swap files to avoid tree
> > lock contention, because it has the same scope as the pool otherwise.)
> >
> > Such changes quickly invalidate any settings the user or distro might
> > make here. Exposing the implementation detail of the pools might even
> > get in the way of fixing bugs and cleaning up the architecture.
> 
> I was under the impression that config options are not very stable.
> IOW, if we fix the lock contention on an architectural level, and
> there is no more benefit to tuning the number of zpools per zswap
> pool, we can remove the config option. Is this incorrect?

The problem is that it complicates the code for everybody, for the
benefit of a likely very small set of users - who have now opted out
of any need for making the code better.

And we have to keep this, and work around it, until things work for
thosee users who have no incentive to address the underlying issues.

That's difficult to justify.

> > I don't think this patch is ready for primetime. A user build time
> > setting is not appropriate for an optimization that is heavily tied to
> > implementation details and workload dynamics.
> 
> What would you suggest instead? We do find value in having multiple
> zpools, at least for the current architecture.

I think it makes sense to look closer at the lock contention, and
whether this can be improved more generically.

zbud and z3fold don't have a lock in the ->map callback that heavily
shows in the profile in your changelog. Is this zsmalloc specific?

If so, looking more closely at zsmalloc locking makes more sense. Is a
lockless implementation feasible? Can we do rw-locking against
zs_compact() to allow concurrency in zs_map_object()?

This would benefit everybody, even zram users.

Again, what about the zswap_tree.lock and swap_info_struct.lock?
They're the same scope unless you use multiple swap files. Would it
make sense to tie pools to trees, so that using multiple swapfiles for
concurrency purposes also implies this optimization?
