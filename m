Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CF6E4B75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDQO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:28:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA459DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:28:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50670cc3abfso2968797a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681741722; x=1684333722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrJp/BsBrfAzaGece7i1JSZGw1d/TlwbKCb/n0TBQoo=;
        b=E88g1SN+xajbXIX3KHWTh2EeuVsSBdRto4KlgR4r2YOVvmg6Rs54lkNFnRD/XePwGz
         KSYesexLsEOD5iO3uRprLuMlZ1+oRrKbekkNKknh/M/XnA4mkbSa25ef+No3MxBonPw1
         f3zVa6Sw2ctjb8ZaTgcgajp9uDpv9M68kMvh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681741722; x=1684333722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrJp/BsBrfAzaGece7i1JSZGw1d/TlwbKCb/n0TBQoo=;
        b=A2hv9wGaKFqodHWxQYC5/a+4QpnP3oxrwTaQHg76FeWzvloRd1H9tMSwSNZZ9ashvQ
         A9N2iUXVIe2L+nK2dcrh0VgdKJQEiy0mwy8oAjZjed/mT15Y9OEgiYZS1SPrCBac6klG
         BzpGWpD+MS0h7JRZ6oFQ9XHI9/2uXbCeNdXtVKAEmgsSkFJfQFX08eBsT9uAuasN53L4
         fUYh8PVVRzaFKWw3mqDX7XYATh2j/UR4nAtL4h5MaVvVQ52Iz9TN1dc8eN48T6o2rCim
         NwvP4egZ8ngcRjPufIIZe/OPdloK4NK1mjCpVfUYPlbO73Ytx9yjIZzk7birv1lixNYk
         ksNA==
X-Gm-Message-State: AAQBX9dH8ZKkZJkznz4m8LfQ+GK8DcTeUCTsQBsY0GnGs/OpDY6Zavl2
        f4I0IpF8iQ4jvotS4zSZA9Lb0bl+lK8U0Rj2wUtvBdTB
X-Google-Smtp-Source: AKy350ZWtmV27uv41E+WcTqiYLIEwOIsDHSci+pemwczndnbsGyr4CnPCKGWpvLPtU6ZZ0uxmn4C6A==
X-Received: by 2002:a05:6402:10c2:b0:504:8929:71ca with SMTP id p2-20020a05640210c200b00504892971camr12807141edu.6.1681741721949;
        Mon, 17 Apr 2023 07:28:41 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7ce0c000000b00506a2e645f6sm2039959edv.71.2023.04.17.07.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:28:41 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so960562f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:28:41 -0700 (PDT)
X-Received: by 2002:adf:e0ca:0:b0:2f5:9146:700f with SMTP id
 m10-20020adfe0ca000000b002f59146700fmr980814wri.11.1681741720976; Mon, 17 Apr
 2023 07:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
 <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Apr 2023 07:28:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
Message-ID: <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 16, 2023 at 6:15=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Douglas Anderson <dianders@chromium.org> writes:
> >>
> >> > Currently when we try to do page migration and we're in "synchronous=
"
> >> > mode (and not doing direct compaction) then we'll wait an infinite
> >> > amount of time for a page lock. This does not appear to be a great
> >> > idea.
> >> >
> >> > One issue can be seen when I put a device under extreme memory
> >> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
> >> > swap). I ran the browser along with Android (which runs from a
> >> > loopback mounted 128K block-size squashfs "disk"). I then manually r=
an
> >> > the mmm_donut memory pressure tool [1]. The system is completely
> >> > unusable both with and without this patch since there are 8 processe=
s
> >> > completely thrashing memory, but it was still interesting to look at
> >> > how migration was behaving. I put some timing code in and I could se=
e
> >> > that we sometimes waited over 25 seconds (in the context of
> >> > kcompactd0) for a page lock to become available. Although the 25
> >> > seconds was the high mark, it was easy to see tens, hundreds, or
> >> > thousands of milliseconds spent waiting on the lock.
> >> >
> >> > Instead of waiting, if I bailed out right away (as this patch does),=
 I
> >> > could see kcompactd0 move forward to successfully to migrate other
> >> > pages instead. This seems like a better use of kcompactd's time.
> >> >
> >> > Thus, even though this didn't make the system any more usable in my
> >> > absurd test case, it still seemed to make migration behave better an=
d
> >> > that feels like a win. It also makes the code simpler since we have
> >> > one fewer special case.
> >>
> >> TBH, the test case is too extreme for me.
> >
> > That's fair. That being said, I guess the point I was trying to make
> > is that waiting for this lock could take an unbounded amount of time.
> > Other parts of the system sometimes hold a page lock and then do a
> > blocking operation. At least in the case of kcompactd there are better
> > uses of its time than waiting for any given page.
> >
> >> And, we have multiple "sync" mode to deal with latency requirement, fo=
r
> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
> >> latency.  If you have latency requirement for some users, you may
> >> consider to add new "sync" mode.
> >
> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
> > guess my first thought would be to avoid adding a new mode and make
> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
> > wait for all the pages to be migrated can use the heavier sync modes.
> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would not
> > want to block for an unbounded amount of time here. What do you think?
>
> It appears that you can just use MIGRATE_ASYNC if you think the correct
> behavior is "NOT block at all".  I found that there are more
> fine-grained controls on this in compaction code, please take a look at
> "enum compact_priority" and its comments.

Actually, the more I think about it the more I think the right answer
is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
MIGRATE_SYNC_LIGHT not block on the folio lock. kcompactd can accept
some blocking but we don't want long / unbounded blocking. Reading the
comments for MIGRATE_SYNC_LIGHT, this also seems like it fits pretty
well. MIGRATE_SYNC_LIGHT says that the stall time of writepage() is
too much. It's entirely plausible that someone else holding the lock
is doing something as slow as writepage() and thus waiting on the lock
can be just as bad for latency.

I'll try to send out a v2 with this approach today and we can see what
people think.

-Doug
