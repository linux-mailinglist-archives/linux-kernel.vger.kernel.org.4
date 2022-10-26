Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920060E68C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiJZRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:32:22 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B07E09A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:32:21 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w10so5845911qvr.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjKfksPlBhlwYLzBgcKzpziSVwI69KcAuIfLwh+ulWo=;
        b=QxzeJ/8gAFock46G6AynUz67ur9KujA23UFuhm9X8nKa5ZTKZpdCTPiZaGIjZh6/iQ
         CUgWzthusrsB7Ny/aynnKAhUgWn3XoloiLODTi/PLWQSwuq3B/LlpXIJuhfHqcE/1H4H
         Nm8L2FtRBj1/ZFFRVE+4dxftrnSsmcMKGAKbNst3KexHj2hKHpBTQRXD7agBjLXMVTZv
         DLg8sS3HSUYvMc8Q2pPGmAgWgs0gEZ8++VBmd5KWG5qi9VLDrNmAuHvyH6QIj3EtMG0L
         oDdCVpJO0Mj0NhqOQ6wZc2lzO/7O5F3t4yu26Lfyi8b30AriWwjXVAcHNv/frQs8Q3rG
         n5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjKfksPlBhlwYLzBgcKzpziSVwI69KcAuIfLwh+ulWo=;
        b=LHyLEbGQxzsEi4/PQb41GQmeNXj+AsjY1wMU/J4YB9ZqZGNpF3lbQCZXV3btoWI9BX
         vpKJyzYVb8c3jGHWkw9FPHJF9N4r2eqmgooOOyJ/ZF+gjHF4anAQ6J3Og6m4Gbu0RWhh
         GA74ibmaMA88iu7kOffcj253kluwtaVZZmQ4up5FWwqkY4j82jY1gelJaVnvVn2A1O8P
         i+ifKg4uZ3ZzvzL5SrTX3nl6cpRYWDfrnyICyeK/E0OYrMIfpvqBtlWwNeIo3geG5Ehn
         wxEq7B7EavueBotVuO9Qz9n+lh4gxzk/Vof153uplQ0TiaK3ukZcdASzDlEwfULE1JVw
         WxMg==
X-Gm-Message-State: ACrzQf2NsQLHRl1Gsh3Bc8HlpBSmsTUtiF9wK5qtXj4hk2AmLPO7klVP
        BJY5GUj372SHg6rO1QTciNFPsA==
X-Google-Smtp-Source: AMsMyM4zC2bor82A6TRyJteIhhSCalmnmm5YkOvC3A7NuQKtQ6+exeNR7sYQ5Pr1gVPPygNaGtNTqg==
X-Received: by 2002:a05:6214:ac7:b0:4bb:61e7:18eb with SMTP id g7-20020a0562140ac700b004bb61e718ebmr3576201qvi.55.1666805540383;
        Wed, 26 Oct 2022 10:32:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a258b00b006ceb933a9fesm4351579qko.81.2022.10.26.10.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:32:20 -0700 (PDT)
Date:   Wed, 26 Oct 2022 13:32:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
 <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org>
 <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:53:01PM -0700, Yang Shi wrote:
> On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > Direct reclaim stats are useful for identifying a potential source for
> > > > application latency, as well as spotting issues with kswapd. However,
> > > > khugepaged currently distorts the picture: as a kernel thread it
> > > > doesn't impose allocation latencies on userspace, and it explicitly
> > > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > > cause confusion when trying to understand actual kswapd behavior.
> > > >
> > > > Break out khugepaged from the direct reclaim counters into new
> > > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > > >
> > > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > > >
> > > > pgsteal_kswapd 1342185
> > > > pgsteal_direct 0
> > > > pgsteal_khugepaged 3623
> > > > pgscan_kswapd 1345025
> > > > pgscan_direct 0
> > > > pgscan_khugepaged 3623
> > >
> > > There are other kernel threads or works may allocate memory then
> > > trigger memory reclaim, there may be similar problems for them and
> > > someone may try to add a new stat. So how's about we make the stats
> > > more general, for example, call it "pg{steal|scan}_kthread"?
> >
> > I'm not convinved that's a good idea.
> >
> > Can you generally say that userspace isn't indirectly waiting for one
> > of those allocating threads? With khugepaged, we know.
> 
> AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM.

Right, but ksm also uses __GFP_KSWAPD_RECLAIM. So while userspace
isn't directly waiting for ksm, when ksm enters direct reclaim it's
because kswapd failed. This is of interest to kernel developers.
Userspace will likely see direct reclaim in that scenario as well, so
the ksm direct reclaim counts aren't liable to confuse users.

Khugepaged on the other hand will *always* reclaim directly, even if
there is no memory pressure or kswapd failure. The direct reclaim
counts there are misleading to both developers and users.

What it really should be is pgscan_nokswapd_nouserprocesswaiting, but
that just seems kind of long ;-)

I'm also not sure anybody but khugepaged is doing direct reclaim
without kswapd reclaim. It seems unlikely we'll get more of those.

> Some device mapper drivers may do heavy lift in the work queue, for
> example, dm-crypt, particularly for writing.

Userspace will wait for those through dirty throttling. We'd want to
know about kswapd failures in that case - again, without them being
muddied by khugepaged.

> > And those other allocations are usually ___GFP_KSWAPD_RECLAIM, so if
> > they do direct reclaim, we'd probably want to know that kswapd is
> > failing to keep up (doubly so if userspace is waiting). In a shared
> > kthread counter, khugepaged would again muddy the waters.
