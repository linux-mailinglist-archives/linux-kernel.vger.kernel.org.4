Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6860D657
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiJYVxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiJYVxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:53:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459EEDBE5E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:53:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jo13so8566964plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1ebPB11JE5IFAkyV0hTUtb8iYF2G4QeJkAHbSonpqM=;
        b=Cy3SpsXHe4MYa7NALkJnN09vXeQems4AxsMMSNLXl04rex0tmvbZd4o6vXJqcAhaEY
         ukaT3ldu/vkOXILPa6oGq9DP3NY8fEWLZ2YkILfpSgvd7+quYDG5IOpNwKCopIlpmrSr
         jeEtbEaiF24gAwBoeYAKgWCkn8KcQM+bkpv/yaYrnPIOcYK8i/MzXvOF3dhqec6xpEA+
         rtTS6Au+z3Os+jW/JhVhvyOr7UOUXyNTkzMpkFaHEa0O8B4rALJ7yJ23YZPd+twEXEQT
         tcFiCKDE/O0zC5j9nm5xnbA05I9UciPI/03KW5pIiXvb29r6b62UKvaDiCMdrhJe/1hD
         vNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1ebPB11JE5IFAkyV0hTUtb8iYF2G4QeJkAHbSonpqM=;
        b=2JwYJ9+xpG4LVJQqNEzb/j9FIdKgXQw3R2PheJqwSRrAa/w40PPA4Fu21vWvHpn7oz
         UBMssBf/wZEZCYFdcHlD3ZFOpAO2pWtx2nbGcwmkCFQYev/DZC09TGvouEbjPXA4170i
         04fg3V8ljvVEyDbEwC6G7fzV26sDP989w21OEBGpw88EgQOoAnY8rUpm81tuSDXPea7o
         COctyS6vkXRvH/fmkGQb6Ky7aCngwDPTd4usgo74CRFbdKruCycQwwKVh/emfT/ApOL5
         7vVCJqCxL42TtVMq7FSml57k3N4i0bxfdPpD3ctdylLilFpXHJkCzrLoQtn1HSjEeuWt
         vXXA==
X-Gm-Message-State: ACrzQf2NjtqItDIuEFmavWwhsy8Xvs/+pykugtbSpMse4bI904JA6jqo
        CE4LLRRX8WtOtd7A5KCXJCLxv5Lf1SIP5rCCx8E=
X-Google-Smtp-Source: AMsMyM4C/2Z9I/zaOWPtWxp+6nRZCOyMFauEcH4XwoK6IZVlJnSZpqWUUV3Ik0V8yXili96TKo1GA9r17/1dO5s55Jg=
X-Received: by 2002:a17:90b:1c87:b0:20a:e485:4e21 with SMTP id
 oo7-20020a17090b1c8700b0020ae4854e21mr442378pjb.194.1666734793686; Tue, 25
 Oct 2022 14:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org> <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org>
In-Reply-To: <Y1hM6sMRpBGUPRyo@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 Oct 2022 14:53:01 -0700
Message-ID: <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Direct reclaim stats are useful for identifying a potential source for
> > > application latency, as well as spotting issues with kswapd. However,
> > > khugepaged currently distorts the picture: as a kernel thread it
> > > doesn't impose allocation latencies on userspace, and it explicitly
> > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > cause confusion when trying to understand actual kswapd behavior.
> > >
> > > Break out khugepaged from the direct reclaim counters into new
> > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > >
> > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > >
> > > pgsteal_kswapd 1342185
> > > pgsteal_direct 0
> > > pgsteal_khugepaged 3623
> > > pgscan_kswapd 1345025
> > > pgscan_direct 0
> > > pgscan_khugepaged 3623
> >
> > There are other kernel threads or works may allocate memory then
> > trigger memory reclaim, there may be similar problems for them and
> > someone may try to add a new stat. So how's about we make the stats
> > more general, for example, call it "pg{steal|scan}_kthread"?
>
> I'm not convinved that's a good idea.
>
> Can you generally say that userspace isn't indirectly waiting for one
> of those allocating threads? With khugepaged, we know.

AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM. Some
device mapper drivers may do heavy lift in the work queue, for
example, dm-crypt, particularly for writing.

>
> And those other allocations are usually ___GFP_KSWAPD_RECLAIM, so if
> they do direct reclaim, we'd probably want to know that kswapd is
> failing to keep up (doubly so if userspace is waiting). In a shared
> kthread counter, khugepaged would again muddy the waters.
