Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7126B6E26E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDNP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDNP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA4BD319
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:26:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d16so4605795iow.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681485963; x=1684077963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVIzYueR5h3salqus+tvLerctScXZDI3PZY9MNj+cH4=;
        b=QH1FqJeFAK+xWXX+XVJrVvdWSs8j2coXbS9fVJT/mPQBC6Yr5lxCWi2p0probPiGRp
         YQnkoKTj9yFKgE7TqHNtGf4oK3Ft3QeDaLj6Hqrgo9PPSpiJNH1EyqPtrEKK/bFOtneV
         zhVRx5EGRbXD9FZr+zSDV5ZVdpIhSAqJiRfr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485963; x=1684077963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVIzYueR5h3salqus+tvLerctScXZDI3PZY9MNj+cH4=;
        b=eEMsjFUmHlLGLCdcZxjpT+caKmMqAlBu0gP/EajG1NwepR3WPr7LIx9ac/NbgR5cTk
         GwE+n8o52t73MPnMTioBqPbwMav246EyM3i9Xg9ghA0TGS/dGKPBZJGgsZ9/S3dpK5t+
         jHcWZFTbY9kLhvCvKPrvzXLjNzvOgci34UflytYKDuPGYq5DLMZUQMqywByIN+o1C+H3
         JBYWwx231EL8heMRuZ8y13iAi7D7/XrToxYVKz2PGw6YsDrZ9RKQpw5TEQsfpPXwvjzg
         gtPOC2MthxlSh1tT84w0kDl4bBRc3mEm29dt9eRq+hUZyDplFYK9Juo5525IzmYTjxvF
         5eLg==
X-Gm-Message-State: AAQBX9cXq1SmYm9IjIrw4DRMJXlBlPKlBzFtu65fNqSOPp99Y0kTKBny
        j8sGlns2rpsH6a4wFlYE1kU/sTXOjHQ/hzpttvg=
X-Google-Smtp-Source: AKy350aBVqOtMmW+IwZnlYgg9uAT2wFKZzyMgOAh6zEuWFNrDNerrE0JbDicQ8XtsddX2/iSwhW3fQ==
X-Received: by 2002:a5e:880d:0:b0:758:d404:8236 with SMTP id l13-20020a5e880d000000b00758d4048236mr3886215ioj.3.1681485962930;
        Fri, 14 Apr 2023 08:26:02 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id z20-20020a056638241400b0040f8a65164csm281504jat.105.2023.04.14.08.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:26:02 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id e22so4467518ioc.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:26:02 -0700 (PDT)
X-Received: by 2002:a6b:e80f:0:b0:74f:d943:f1cf with SMTP id
 f15-20020a6be80f000000b0074fd943f1cfmr2300579ioh.3.1681485961798; Fri, 14 Apr
 2023 08:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Apr 2023 08:25:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
Message-ID: <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
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

On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org> writes:
>
> > Currently when we try to do page migration and we're in "synchronous"
> > mode (and not doing direct compaction) then we'll wait an infinite
> > amount of time for a page lock. This does not appear to be a great
> > idea.
> >
> > One issue can be seen when I put a device under extreme memory
> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
> > swap). I ran the browser along with Android (which runs from a
> > loopback mounted 128K block-size squashfs "disk"). I then manually ran
> > the mmm_donut memory pressure tool [1]. The system is completely
> > unusable both with and without this patch since there are 8 processes
> > completely thrashing memory, but it was still interesting to look at
> > how migration was behaving. I put some timing code in and I could see
> > that we sometimes waited over 25 seconds (in the context of
> > kcompactd0) for a page lock to become available. Although the 25
> > seconds was the high mark, it was easy to see tens, hundreds, or
> > thousands of milliseconds spent waiting on the lock.
> >
> > Instead of waiting, if I bailed out right away (as this patch does), I
> > could see kcompactd0 move forward to successfully to migrate other
> > pages instead. This seems like a better use of kcompactd's time.
> >
> > Thus, even though this didn't make the system any more usable in my
> > absurd test case, it still seemed to make migration behave better and
> > that feels like a win. It also makes the code simpler since we have
> > one fewer special case.
>
> TBH, the test case is too extreme for me.

That's fair. That being said, I guess the point I was trying to make
is that waiting for this lock could take an unbounded amount of time.
Other parts of the system sometimes hold a page lock and then do a
blocking operation. At least in the case of kcompactd there are better
uses of its time than waiting for any given page.

> And, we have multiple "sync" mode to deal with latency requirement, for
> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
> latency.  If you have latency requirement for some users, you may
> consider to add new "sync" mode.

Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
guess my first thought would be to avoid adding a new mode and make
MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
wait for all the pages to be migrated can use the heavier sync modes.
It seems to me like the current users of MIGRATE_SYNC_LIGHT would not
want to block for an unbounded amount of time here. What do you think?

-Doug
