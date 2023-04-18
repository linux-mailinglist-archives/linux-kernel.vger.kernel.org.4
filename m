Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA86E693B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjDRQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDRQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:19:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06ABB84
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f4b911570so162939866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681834775; x=1684426775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFrSQc7lDYoC+pA674PKNte5MxFoAJUM1iwHstdWOEo=;
        b=fWQbLhPbDolxi6LMQafclHGha50Rxvq8BwDvHozJVwPFmWzikBH4gTuzEGuxaYkBzU
         dw8tsuW51IQ6eE3XgEI5AJXy9trSRVjNnuNohxXVFCqKj4OpBGWrIma5r5W5HA4GiYXB
         jwIuhjGt8644HRHssfN5yvjAKGGgT1eIRVIE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834775; x=1684426775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFrSQc7lDYoC+pA674PKNte5MxFoAJUM1iwHstdWOEo=;
        b=FtmjrRPwl745XvMbjsF8tOMcBnkyxi4A3JfD9LTeielkKXCm60Cn78JA4YK2PW750s
         Eq9zqGx0y7I3NqfA8Fhn27d5Xf+I50GaohlsF2hoDelvx+6BclZ/jD2WhfQHiZGKtw59
         AWqRcpgY1bcGhHfIGIE7D892NamzWLU4tZSC1oV8GzKMQA+FMWv5tUA4azNXxCnOL1YE
         acT6pmhouqlMewGGhGQlhWvLgvBmJJYrCIRa9y8ZJV9pbY0ArhT5GPXkq2mG0Fu7Ulh+
         5j1PyKZ429oKi4bgjrAghOf8DZkJibu3ZH0Q6oOfLkhgP5ZXxroHY8JEkW95NL8ePx8i
         ziXg==
X-Gm-Message-State: AAQBX9dMcT1gLDh6FyGUbC0/KTp155+yNcZg4kLs2fTeM4e+2AF5T2uI
        LPUHBXkoRTUYbehc9wj7BUL00us0mU9cdscQFQQeMw==
X-Google-Smtp-Source: AKy350ZKviN5ZwuKQ/f1a5qe5bWv0rXfOkql/j10AvsY7uuXeV1A/01SDTmAo3PcuclQXKHSXRJTcQ==
X-Received: by 2002:aa7:cc84:0:b0:502:233e:af49 with SMTP id p4-20020aa7cc84000000b00502233eaf49mr2673566edt.4.1681834775505;
        Tue, 18 Apr 2023 09:19:35 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7da86000000b00506a09795e6sm3482678eds.26.2023.04.18.09.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:19:35 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so139798wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:34 -0700 (PDT)
X-Received: by 2002:a1c:770e:0:b0:3f1:758e:40fa with SMTP id
 t14-20020a1c770e000000b003f1758e40famr1171776wmi.6.1681834774341; Tue, 18 Apr
 2023 09:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
 <87edohvpzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edohvpzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Apr 2023 09:19:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1SAufJUT-d5praYszUN1ssdT61WS7iB-c62R4M6Lsmw@mail.gmail.com>
Message-ID: <CAD=FV=V1SAufJUT-d5praYszUN1ssdT61WS7iB-c62R4M6Lsmw@mail.gmail.com>
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
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

On Mon, Apr 17, 2023 at 8:18=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Sun, Apr 16, 2023 at 6:15=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Doug Anderson <dianders@chromium.org> writes:
> >>
> >> > Hi,
> >> >
> >> > On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Douglas Anderson <dianders@chromium.org> writes:
> >> >>
> >> >> > Currently when we try to do page migration and we're in "synchron=
ous"
> >> >> > mode (and not doing direct compaction) then we'll wait an infinit=
e
> >> >> > amount of time for a page lock. This does not appear to be a grea=
t
> >> >> > idea.
> >> >> >
> >> >> > One issue can be seen when I put a device under extreme memory
> >> >> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
> >> >> > swap). I ran the browser along with Android (which runs from a
> >> >> > loopback mounted 128K block-size squashfs "disk"). I then manuall=
y ran
> >> >> > the mmm_donut memory pressure tool [1]. The system is completely
> >> >> > unusable both with and without this patch since there are 8 proce=
sses
> >> >> > completely thrashing memory, but it was still interesting to look=
 at
> >> >> > how migration was behaving. I put some timing code in and I could=
 see
> >> >> > that we sometimes waited over 25 seconds (in the context of
> >> >> > kcompactd0) for a page lock to become available. Although the 25
> >> >> > seconds was the high mark, it was easy to see tens, hundreds, or
> >> >> > thousands of milliseconds spent waiting on the lock.
> >> >> >
> >> >> > Instead of waiting, if I bailed out right away (as this patch doe=
s), I
> >> >> > could see kcompactd0 move forward to successfully to migrate othe=
r
> >> >> > pages instead. This seems like a better use of kcompactd's time.
> >> >> >
> >> >> > Thus, even though this didn't make the system any more usable in =
my
> >> >> > absurd test case, it still seemed to make migration behave better=
 and
> >> >> > that feels like a win. It also makes the code simpler since we ha=
ve
> >> >> > one fewer special case.
> >> >>
> >> >> TBH, the test case is too extreme for me.
> >> >
> >> > That's fair. That being said, I guess the point I was trying to make
> >> > is that waiting for this lock could take an unbounded amount of time=
.
> >> > Other parts of the system sometimes hold a page lock and then do a
> >> > blocking operation. At least in the case of kcompactd there are bett=
er
> >> > uses of its time than waiting for any given page.
> >> >
> >> >> And, we have multiple "sync" mode to deal with latency requirement,=
 for
> >> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
> >> >> latency.  If you have latency requirement for some users, you may
> >> >> consider to add new "sync" mode.
> >> >
> >> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
> >> > guess my first thought would be to avoid adding a new mode and make
> >> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
> >> > wait for all the pages to be migrated can use the heavier sync modes=
.
> >> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would no=
t
> >> > want to block for an unbounded amount of time here. What do you thin=
k?
> >>
> >> It appears that you can just use MIGRATE_ASYNC if you think the correc=
t
> >> behavior is "NOT block at all".  I found that there are more
> >> fine-grained controls on this in compaction code, please take a look a=
t
> >> "enum compact_priority" and its comments.
> >
> > Actually, the more I think about it the more I think the right answer
> > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> > MIGRATE_SYNC_LIGHT not block on the folio lock.
>
> Then, what is the difference between MIGRATE_SYNC_LIGHT and
> MIGRATE_ASYNC?

Aren't there still some differences even if we remove blocking this
one lock? ...or maybe your point is that maybe the other differences
have similar properties?

OK, so let's think about just using MIGRATE_ASYNC and either leaving
MIGRATE_SYNC_LIGHT alone or deleting it (if there are no users left).
The nice thing is that the only users of MIGRATE_SYNC_LIGHT are in
"compaction.c" and there are only 3 places where it's specified.

1. kcompactd_do_work() - This is what I was analyzing and where I
argued that indefinite blocking is less useful than simply trying to
compact a different page. So sure, moving this to MIGRATE_ASYNC seems
like it would be OK?

2. proactive_compact_node() - Just like kcompactd_do_work(), this is
called from kcompactd and thus probably should have the same mode.

3. compact_zone_order() - This explicitly chooses between
MIGRATE_SYNC_LIGHT and MIGRATE_ASYNC, so I guess I'd keep
MIGRATE_SYNC_LIGHT just for this use case. It looks as if
compact_zone_order() is called for direct compaction and thus making
it synchronous can make sense, especially since it seems to go to the
synchronous case after it failed with the async case. Ironically,
though, the exact lock I was proposing to not wait on _isn't_ ever
waited on in direct reclaim (see the comment in migrate_folio_unmap()
about deadlock), but the other differences between SYNC_LIGHT and
ASYNC come into play.

If the above sounds correct then I'm OK w/ moving #1 and #2 to
MIGRATE_ASYNC and leaving #3 as the sole user or MIGRATE_SYNC_LIGHT.

> > kcompactd can accept some blocking but we don't want long / unbounded
> > blocking. Reading the comments for MIGRATE_SYNC_LIGHT, this also seems
> > like it fits pretty well. MIGRATE_SYNC_LIGHT says that the stall time
> > of writepage() is too much. It's entirely plausible that someone else
> > holding the lock is doing something as slow as writepage() and thus
> > waiting on the lock can be just as bad for latency.
>
> IIUC, during writepage(), the page/folio will be unlocked.
>
> But, during page reading, the page/folio will be locked.  I don't really
> understand why we can wait for page reading but cannot wait for page
> writeback.

I'm not sure I totally got your point here. It sorta sounds as if
you're making the same point that I was? IIUC by waiting on the lock
we may be implicitly waiting for someone to finish reading which seems
as bad as waiting for writing. That was why I was arguing that with
MIGRATE_SYNC_LIGHT (which says that waiting for the write was too
slow) that we shouldn't wait for the lock (which may be blocking on a
read).

-Doug
