Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70E6EA0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjDUAgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjDUAgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:36:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A465AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:36:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3e6aa05714bso14205461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682037392; x=1684629392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsVjJ4SkHhpAcJ2qMCfs0/jsmBQOUMoCMr/YEOhqf00=;
        b=LVkhB7fmYHzbjISrJz1LWFnsU3aY3gtxk39iUKqM2fFk0JneQmJPPI2r764uWQc3ub
         hyitBAhiMcSh9fx1n+tUwI6YtYrCH+9DZk4mZpqPr56giJPWSUM8qDS0Q66Y9UBVr+f9
         iCfABZBtFj33ZCQkDyvJ9SZCPW/J7F8IgoL4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682037392; x=1684629392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsVjJ4SkHhpAcJ2qMCfs0/jsmBQOUMoCMr/YEOhqf00=;
        b=LCnUn1d04TU7qiC3g3tcwL5X767yI0ITV01N1eoUadTM3NfHyMztpHD/XF4aVQSsU+
         s9FWacTbn67myfNZwmkx310mtDrb310OZpVz8EpA17lqVugy5hNIRwCAOQ5pTmOVswN0
         Xa46swVzK09paO5Sv+hj5yiLDgDm9DqZH8SkG8Gtvn7wB7n4eDarmLcrnjbAiG9RLuwM
         7ufmj1FXd61dycziLasRQvSk8H+3jHd5BDRKxVT4CA13jEeLnSVBpiQ8ZL3asT4C5w0U
         S38W5DIymu5gmW4aozZ/sdbIuZUG9q42ZJuMIxzamwRWzcm4tS/BDztGt6qq2nwac5nv
         1E4Q==
X-Gm-Message-State: AAQBX9eHK3nfbQ/PFyttT4KcM+g/I0Q618CpVKctn+/KZzRO87B9Y32h
        lZ+KvwfBWUjUcqtJlho2AoiEnFkNr/9RVMxIqW8=
X-Google-Smtp-Source: AKy350brmLyzLO7E8rCN23IbhgFtIOlc1whcf/3OHDj57+yAKOgumjUREv+w5O30iGBKkY79C3oVTA==
X-Received: by 2002:a05:622a:11cb:b0:3ef:52ac:10c5 with SMTP id n11-20020a05622a11cb00b003ef52ac10c5mr5581586qtk.35.1682037391761;
        Thu, 20 Apr 2023 17:36:31 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id bj11-20020a05620a190b00b0074e21c3bc8asm843274qkb.126.2023.04.20.17.36.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 17:36:31 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3ef31924c64so974111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:36:31 -0700 (PDT)
X-Received: by 2002:ac8:5fd1:0:b0:3ef:404a:b291 with SMTP id
 k17-20020ac85fd1000000b003ef404ab291mr66942qta.7.1682037390531; Thu, 20 Apr
 2023 17:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
 <e5237b55-50eb-2a93-78cf-79421164f1fd@suse.cz> <20230420102304.7wdquge2b7r3xerj@techsingularity.net>
In-Reply-To: <20230420102304.7wdquge2b7r3xerj@techsingularity.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 17:36:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSVzc62X3Lr7-QJ7dfePV=UDm5zNrUK-3JtP-U=Yr-mA@mail.gmail.com>
Message-ID: <CAD=FV=VSVzc62X3Lr7-QJ7dfePV=UDm5zNrUK-3JtP-U=Yr-mA@mail.gmail.com>
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Thu, Apr 20, 2023 at 3:23=E2=80=AFAM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> On Tue, Apr 18, 2023 at 11:17:23AM +0200, Vlastimil Babka wrote:
> > > Actually, the more I think about it the more I think the right answer
> > > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> > > MIGRATE_SYNC_LIGHT not block on the folio lock. kcompactd can accept
> > > some blocking but we don't want long / unbounded blocking. Reading th=
e
> > > comments for MIGRATE_SYNC_LIGHT, this also seems like it fits pretty
> > > well. MIGRATE_SYNC_LIGHT says that the stall time of writepage() is
> > > too much. It's entirely plausible that someone else holding the lock
> > > is doing something as slow as writepage() and thus waiting on the loc=
k
> > > can be just as bad for latency.
> >
> > +Cc Mel for potential insights. Sounds like a good compromise at first
> > glance, but it's a tricky area.
> > Also there are other callers of migration than compaction, and we shoul=
d
> > make sure we are not breaking them unexpectedly.
> >
>
> It's tricky because part of the point of SYNC_LIGHT was to block on
> some operations but not for too long. writepage was considered to be an
> exception because it can be very slow for a variety of reasons. I think
> At the time that writeback from reclaim context was possible and it was
> very inefficient, more more inefficient than reads.  Storage can also be
> very slow (e.g. USB stick plugged in) and there can be large differences
> between read/write performance (SMR, some ssd etc). Pages read were gener=
ally
> clean and could be migrated, pages for write may be redirtied etc. It was
> assumed that while both read/write could lock the page for a long time,
> write had worse hold times and most other users of lock page were transie=
nt.

I think some of the slowness gets into the complex ways that systems
like ChromeOS are currently working. As mentioned in the commit
message of my RFC patch, ChromeOS currently runs Android programs out
of a 128K-block, zlib-compressed squashfs disk. That squashfs disk is
actually a loopback mounted file on the main ext2 filesystem which is
stored on something like eMMC.

If I understand the everything correctly, if we get a page fault on
memory backed by this squashfs filesystem, then we can end up holding
a page/folio lock and then trying to read a pile of pages (enough to
decompress the whole 128K block). ...but we don't read them directly,
we instead block on ext4 which might need to allocate memory and then
finally blocks on the block driver completing the task. This whole
sequence of things is not necessarily fast. I think this is
responsible for some of the very large numbers that were part of my
original patch description.

Without the above squashfs setup, we can still run into slow times but
not quite as bad. I tried running a ChromeOS "memory pressure" test
against a mainline kernel plus _just_ the browser (Android disabled).
The test eventually opened over 90 tabs on my 4GB system and the
system got pretty janky, but still barely usable. While running the
test, I saw dozens of cases of folio_lock() taking over 10 ms and
quite a few (~10?) of it taking over 100 ms. The peak I saw was
~380ms. I also happened to time buffer locking. That was much less bad
with the worst case topping out at ~70ms. I'm not sure what timeout
you'd consider to be bad. 10 ms? 20 ms?

Also as a side note: I ran the same memory pressure but _with_ Android
running (though it doesn't actually stress Android, it's just running
in the background). To do this I had to run a downstream kernel. Here
it was easy to see a ~1.7 ms wait on the page lock without any
ridiculous amount of stressing. ...and a ~1.5 second wait for the
buffer lock, too.


> A compromise for SYNC_LIGHT or even SYNC on lock page would be to try
> locking with a timeout. I don't think there is a specific helper but it
> should be possible to trylock, wait on the folio_waitqueue and attempt
> once to get the lock again. I didn't look very closely but it would
> doing something similar to folio_wait_bit_common() with
> io_schedule_timeout instead of io_schedule. This will have false
> positives because the folio waitqueue may be woken for unrelated pages
> and obviously it can race with other wait queues.
>
> kcompactd is an out-of-line wait and can afford to wait for a long time
> without user-visible impact but 120 seconds or any potentially unbounded
> length of time is ridiculous and unhelpful. I would still be wary about
> adding new sync modes or making major modifications to kcompactd because
> detecting application stalls due to a kcompactd modification is difficult=
.

OK, I'll give this a shot. It doesn't look too hard, but we'll see.


> There is another approach -- kcompactd or proactive under heavy memory
> pressure is probably a waste of CPU time and resources and should
> avoid or minimise effort when under pressure. While direct compaction
> can capture a page for immediate use, kcompactd and proactive reclaim
> are just shuffling memory around for *potential* users and may be making
> the overall memory pressure even worse. If memory pressure detection was
> better and proactive/kcompactd reclaim bailed then the unbounded time to
> lock a page is mitigated or completely avoided.

I probably won't try to take this on, though it does sound like a good
idea for future research.
