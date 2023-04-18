Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA66E6D74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjDRUZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjDRUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:25:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63E213F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:25:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt6so38212804ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681849539; x=1684441539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np4Mh5emCjbqZYkVAnvgCrsWZdAU1h0zngtlF2/nwH8=;
        b=VNgDWN5KlJL19nq5fj0ukcRAySKmZ/cl4VzLWPC+01dIvnUMWWb97n3r+uO3dMsaah
         krDN6S8bd/iC15RuivwCw96ysgLx15OpdLitdDsT27r+NkKXAdIetZlSVfYta85GOgGU
         NzPEM+3JgFx6cMli5AbZR6KSXtDQLm74lRjBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681849539; x=1684441539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np4Mh5emCjbqZYkVAnvgCrsWZdAU1h0zngtlF2/nwH8=;
        b=IAr/gl68rtGb33XyINYU5MlehuM+VYvGRZR8eLObIAB2DhiYN93B3JkHjSb1nhTlNc
         8EsGr5gvAQ4mQYDcC+g2UMqBFK2W71qXCbiWKgMQrT22O7DOb1kvD8CJG4kUYTY0pfFh
         4KAGCECr8Y2kTaIN/XzdlJliz3biuitbzUepC1RXroahmtwit5rRm6cmtc2v76l6J6ax
         Vq14eDjrijQ717qCrdOtgdOW3CTT0dA5VS18ImNg576gQduv4nnqtMJrR3QJdBfGXxe+
         Qp5/KRm7i9VhFSajgOsM73EmyGhW3SDWLnPOhdB5tp0CE9JC8FxbAfo/NbxUCmvqKYFS
         1TiQ==
X-Gm-Message-State: AAQBX9dI8kRCNpjbLx+LWoB+lIynuQ93R1qECo+HP5YmgsNKj6wqVvXj
        FSrjjY4ufczsWiUrHUg6IQozSHggDYGfA+f37jubKg==
X-Google-Smtp-Source: AKy350YCM56rRnKTv2KlZUTwsVXZo3+IXqXGR66SPKC410XIk3x/7ZhfjKj9yjiAeGeWwRKCm1Uu0A==
X-Received: by 2002:a17:907:3c23:b0:94a:7da2:d339 with SMTP id gh35-20020a1709073c2300b0094a7da2d339mr9556514ejc.26.1681849539070;
        Tue, 18 Apr 2023 13:25:39 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id b16-20020a1709063f9000b0094a962da55dsm8414025ejj.195.2023.04.18.13.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 13:25:38 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso2163640f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:25:38 -0700 (PDT)
X-Received: by 2002:adf:dd91:0:b0:2c7:1483:9479 with SMTP id
 x17-20020adfdd91000000b002c714839479mr651568wrl.11.1681849538078; Tue, 18 Apr
 2023 13:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418095852.RFC.1.I53bf7f0c7d48fe7af13c5dd3ad581d3bcfd9d1bd@changeid>
 <20230418195335.GA268630@cmpxchg.org>
In-Reply-To: <20230418195335.GA268630@cmpxchg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Apr 2023 13:25:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXdLWTFicdWSbwZ33Hc3MuY=zu94yTUT-rvF6n1h_B9w@mail.gmail.com>
Message-ID: <CAD=FV=UXdLWTFicdWSbwZ33Hc3MuY=zu94yTUT-rvF6n1h_B9w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, compaction: kcompactd work shouldn't count
 towards memory PSI
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>, Ying <ying.huang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 18, 2023 at 12:53=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Apr 18, 2023 at 09:58:54AM -0700, Douglas Anderson wrote:
> > When the main kcompactd thread is doing compaction then it's always
> > proactive compaction. This is a little confusing because kcompactd has
> > two phases and one of them is called the "proactive" phase.
> > Specifically:
> > * Phase 1 (the "non-proactive" phase): we've been told by someone else
> >   that it would be a good idea to try to compact memory.
> > * Phase 2 (the "proactive" phase): we analyze memory fragmentation
> >   ourselves and compact if it looks fragmented.
> >
> > From the context of kcompactd, the above naming makes sense. However,
> > from the context of the kernel as a whole both phases are "proactive"
> > because in both cases we're trying compact memory ahead of time and
> > we're not actually blocking (stalling) any task who is trying to use
> > memory.
> >
> > Specifically, if any task is actually blocked needing memory to be
> > compacted then it will be in direct reclaim. That won't block waiting
> > on kcompactd task but instead call try_to_compact_pages() directly.
> > The caller of that direct compaction, __alloc_pages_direct_compact(),
> > already marks itself as counting towards PSI.
> >
> > Sanity checking by looking at this from another perspective, we can
> > look at all the people who explicitly ask kcompactd to do a reclaim by
> > calling wakeup_kcompactd(). That leads us to 3 places in vmscan.c.
> > Those are all requests from kswapd, which is also a "proactive"
> > mechanism in the kernel (tasks aren't blocked waiting for it).
>
> There is a reason behind annotating kswapd/kcompactd like this, it's
> in the longish comment in psi.c:
>
>  * The time in which a task can execute on a CPU is our baseline for
>  * productivity. Pressure expresses the amount of time in which this
>  * potential cannot be realized due to resource contention.
>  *
>  * This concept of productivity has two components: the workload and
>  * the CPU. To measure the impact of pressure on both, we define two
>  * contention states for a resource: SOME and FULL.
>  *
>  * In the SOME state of a given resource, one or more tasks are
>  * delayed on that resource. This affects the workload's ability to
>  * perform work, but the CPU may still be executing other tasks.
>  *
>  * In the FULL state of a given resource, all non-idle tasks are
>  * delayed on that resource such that nobody is advancing and the CPU
>  * goes idle. This leaves both workload and CPU unproductive.
>  *
>  *      SOME =3D nr_delayed_tasks !=3D 0
>  *      FULL =3D nr_delayed_tasks !=3D 0 && nr_productive_tasks =3D=3D 0
>  *
>  * What it means for a task to be productive is defined differently
>  * for each resource. For IO, productive means a running task. For
>  * memory, productive means a running task that isn't a reclaimer. For
>  * CPU, productive means an oncpu task.

Ah, thanks for the pointer!


> So when you have a CPU that's running reclaim/compaction work, that
> CPU isn't available to execute the workload.
>
> Say you only have one CPU shared between an allocating thread and
> kswapd. Even if the allocating thread never has to do reclaim on its
> own, if it has to wait for the CPU behind kswapd 50% of the time, that
> workload is positively under memory pressure.

I guess I'm so much in the mindset of having 2-8 CPUs that I didn't
think as much about the single CPU case. What you say makes a lot of
sense for the single CPU case or for very parallel workloads that take
up all available CPUs, but what about when you've got extra CPUs
sitting there idling? In that case we're really not taking any CPU
cycles away from someone by having one of those CPUs doing compaction
in the background.

I'm sure this has been discussed before somewhere, but I'd also wonder
if there's ever a reason why we should prioritize kswapd/kcompactd
over user programs. AKA: why don't kswapd/kcompactd run with a big
"sched_nice" value? If kswapd/kcompactd were low enough priority then
even in the single CPU case (or the multiple CPU case with a very
parallel workload) kswapd/kcompactd would never be taking away
significant time from a real program.


> I don't think the distinction between proactive and reactive is all
> that meaningful. It's generally assumed that all the work done by
> these background threads is work that later doesn't have to be done by
> an allocating thread. It might matter from a latency perspective, but
> otherwise the work is fungible as it relates to memory pressure.

If all compaction should count towards PSI then it feels like we have
a different bug. The proactive_compact_node() function should also be
marked as counting towards PSI, shouldn't it?

-Doug
