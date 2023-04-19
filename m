Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9336E81EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDSTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDSTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:31:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01128132
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:31:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b10so542884ybk.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681932668; x=1684524668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHVwt8ouo1WrczMVZ0u9DPFDA9SmLrHyYVpeivZ/wGA=;
        b=GNz+FvJo5e+qc8WQalDUQexCP8WwoPEShICw/eWfka7BOVOnW2lEE9YZqPG779CCtJ
         Kx38jHAEoLR9gGJ0BLzIglyvlLcqdbvXrdDThPoSWm9BF9mPoN12M0b4eTxgQGR++b/F
         fmKrP9uxmBeQXaNU3llZSyFf9CY3k9hhMgWz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681932668; x=1684524668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHVwt8ouo1WrczMVZ0u9DPFDA9SmLrHyYVpeivZ/wGA=;
        b=CdgpZJgtJmbIwGGenDDw0LPO2/e1bfEhaPxk4/izYvlaU1AIW28o9vbJA6PyaQc7KT
         i8thwPAki8i0JW2LlYQA+lPAFhL3Xj8kIHzVMl9IlDHpwEWArr4eKNsl+0vS7FB0sn2D
         HSP2JrMcm+LvfPN6zn4PElqOnfi4LPyo/8dpc7RymPvQai08cFXtKlmQ1ykUPBNvKKG9
         4GZz2fObSYGnjXZEnkqN3qqAxEjuGnCBGrQrXenDx1lC0PhSwCNox7tBdYF6+afcx/4L
         TIkUCNyxKRZXnaJMANMAjyVUvql+LHkZBMYyShCUBSkHO2IS2cG2YYIfl4r5uJvAlf29
         LQ7A==
X-Gm-Message-State: AAQBX9fJTjpO7HnK62x74BnU/vZa5PiU2KWIH7DwHjcM330JoTJc146t
        NlS8GSSmZZ1jrhu7zIFIipUC2DzePTRwM9HjRryE0A==
X-Google-Smtp-Source: AKy350Y9MKlcyV3MPiuXNzfWUQmVvLo4Nv7le7wXy0opf3AYFNObmVKPFo8XCwZPnRFOUd/1BeD9iA==
X-Received: by 2002:a25:e657:0:b0:b8f:60cd:bd1 with SMTP id d84-20020a25e657000000b00b8f60cd0bd1mr854241ybh.0.1681932668014;
        Wed, 19 Apr 2023 12:31:08 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 82-20020a250f55000000b00b8f21594ca8sm4504077ybp.14.2023.04.19.12.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:31:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id l5so558212ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:31:07 -0700 (PDT)
X-Received: by 2002:a25:cad6:0:b0:b92:380b:caeb with SMTP id
 a205-20020a25cad6000000b00b92380bcaebmr573391ybg.0.1681932666601; Wed, 19 Apr
 2023 12:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
 <87edohvpzk.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=V1SAufJUT-d5praYszUN1ssdT61WS7iB-c62R4M6Lsmw@mail.gmail.com>
 <87wn28u2wy.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wn28u2wy.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Apr 2023 12:30:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBjG85VAKqAmffBnWH+-zcY2JJ_MoGuPev4r3xjn=B-Q@mail.gmail.com>
Message-ID: <CAD=FV=XBjG85VAKqAmffBnWH+-zcY2JJ_MoGuPev4r3xjn=B-Q@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 5:34=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> >> >> >> TBH, the test case is too extreme for me.
> >> >> >
> >> >> > That's fair. That being said, I guess the point I was trying to m=
ake
> >> >> > is that waiting for this lock could take an unbounded amount of t=
ime.
> >> >> > Other parts of the system sometimes hold a page lock and then do =
a
> >> >> > blocking operation. At least in the case of kcompactd there are b=
etter
> >> >> > uses of its time than waiting for any given page.
> >> >> >
> >> >> >> And, we have multiple "sync" mode to deal with latency requireme=
nt, for
> >> >> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too l=
ong
> >> >> >> latency.  If you have latency requirement for some users, you ma=
y
> >> >> >> consider to add new "sync" mode.
> >> >> >
> >> >> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. =
I
> >> >> > guess my first thought would be to avoid adding a new mode and ma=
ke
> >> >> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs t=
o
> >> >> > wait for all the pages to be migrated can use the heavier sync mo=
des.
> >> >> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would=
 not
> >> >> > want to block for an unbounded amount of time here. What do you t=
hink?
> >> >>
> >> >> It appears that you can just use MIGRATE_ASYNC if you think the cor=
rect
> >> >> behavior is "NOT block at all".  I found that there are more
> >> >> fine-grained controls on this in compaction code, please take a loo=
k at
> >> >> "enum compact_priority" and its comments.
> >> >
> >> > Actually, the more I think about it the more I think the right answe=
r
> >> > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> >> > MIGRATE_SYNC_LIGHT not block on the folio lock.
> >>
> >> Then, what is the difference between MIGRATE_SYNC_LIGHT and
> >> MIGRATE_ASYNC?
> >
> > Aren't there still some differences even if we remove blocking this
> > one lock? ...or maybe your point is that maybe the other differences
> > have similar properties?
>
> Sorry for confusing words.  Here, I asked you to list the implementation
> difference between MIGRATE_ASYNC and MIGRATE_SYNC_LIGHT after your
> proposed changes.  Which are waited in MIGRATE_SYNC_LIGHT but not in
> MIGRATE_ASYNC?

Ah, got it! It's not always the easiest to follow all the code paths,
but let's see what I can find.

I guess to start with, though, I will assert that someone seems to
have believed that there was an important difference between
MIGRATE_ASYNC and MIGRATE_SYNC_LIGHT besides waiting on the lock in
migrate_folio_unmapt() since (as I found in my previous digging) the
"direct reclaim" path never grabs this lock but explicitly sometimes
chooses MIGRATE_ASYNC some times and MIGRATE_SYNC_LIGHT other times.

OK, so looking at mainline Linux and comparing differences in behavior
between SYNC_LIGHT and ASYNC and thoughts about which one should be
used for kcompactd. Note that I won't go _too_ deep into all the
differences...

--

In nfs.c:

1. We will wait for the fscache if SYNC_LIGHT but not ASYNC. No idea
what would be the most ideal for calls from kcompactd.

In compaction.c:

2. We will update the non-async "compact_cached_migrate_pfn" for
SYNC_LIGHT but not ASYNC since we keep track of sync and async
progress separately.

3. compact_lock_irqsave() note contentions for ASYNC but not
SYNC_LIGHT and cause an earlier abort. Seems like kcompactd would want
the SYNC_LIGHT behavior since this isn't about things indefinitely
blocking.

4. isolate_migratepages_block() will bail if too_many_isolated() for
ASYNC but not SYNC_LIGHT. My hunch is that kcompactd wants the
SYNC_LIGHT behavior for kcompact.

5. If in direct compaction, isolate_migratepages_block() sets
"skip_on_failure" for ASYNC but not SYNC_LIGHT. My hunch is that
kcompactd wants the SYNC_LIGHT behavior for kcompact.

6. suitable_migration_source() considers more things suitable
migration sources when SYNC_LIGHT but not (ASYNC+direct_compaction).
Doesn't matter since kcompactd isn't direct compaction and non-direct
compaction is the same.

7. fast_isolate_around() does less scanning when SYNC_LIGHT but not
(ASYNC+direct_compaction). Again, it doesn't matter for kcompactd.

8. isolate_freepages() uses a different stride with SYNC_LIGHT vs.
ASYNC. My hunch is that kcompactd wants the SYNC_LIGHT behavior for
kcompact.

In migrate.c:

9. buffer_migrate_lock_buffers() will block waiting to lock buffers
with SYNC_LIGHT but not ASYNC. I don't know for sure, but this feels
like something we _wouldn't_ want to block on in kcompactd and instead
should look for easier pickings.

10. migrate_folio_unmap() has the case we've already talked about

11. migrate_folio_unmap() does batch flushes for async because it
doesn't need to worry about a class of deadlock. Somewhat recent code
actually ends up running this code first even for sync modes to get
the batch.

12. We'll retry a few more times for SYNC_LIGHT than ASYNC. Seems like
the more retries won't really hurt for kcompactd.

--

So from looking at all the above, I'll say that kcompactd should stick
with SYNC_LIGHT and we should fix #10. In other words, like my
original patch except that we keep blocking on the lock in the full
SYNC modes.

It's possible that we should also change case #9 I listed above. Do
you know if locking buffers is likely to block on something as slow as
page reading/writing?

-Doug
