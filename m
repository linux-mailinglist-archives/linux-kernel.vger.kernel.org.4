Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71116A899A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCBTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCBTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:39:40 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765025E02
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:39:24 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e82so4626811ybh.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahWOmlQ1UhPXqZ/fqMWkLunHfpvvJIgGILeEthfduoA=;
        b=m2iwped2kqIlOgzuLe3VXH3l2cAhwdleoyqMhyFO4N6X00vdx5R2qZTfuFquxody38
         X04I7aQs7KddGblTSsLRgXUTjZVsa65Vlh38gFtbccrNpaGJUpvTpMBipMKsCT41UECF
         JQuEHRYNcdtlTGD6KP69Gplof2QBQZaCDUSjGauZ95aGdOs/ykOmX3xtMP+K/R3FdQgr
         4Fps46cUDkjwLrox2YDULkm907rn/TJ9CLGsSYT3KGbrCVwXvE3xO8dwwHUDVLHMk3ss
         Y1QsXqy36POpCe50Rbb5WaTd2B0pOVFWc2otq5e1T7XO02boeHhpItEwm+RN071CPHCc
         tiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahWOmlQ1UhPXqZ/fqMWkLunHfpvvJIgGILeEthfduoA=;
        b=cumNYLuZM4Apq9FkS+H5Sbjno0rL3CkWoWECCX8PAb5ZfS2g4XZEHUQQtaNiUr+bp/
         sG9Y5E9OfuYCZJLjddVUMmCvc4MjLEpBaZKeEUnvrXaYIbV62Xh+NG/E/xuVap5ZqKho
         5LyGzrS0K+2pLCJNUb/mIDYgenBKpAJBlEhudrjKwKXh5yyKvFpiq22HpvCpdDosoWBA
         vPZkrB7MCNcybvNefKg9aloL85x6bc843bynEC8ezYjD+wJ29bfbVvcmLUiuS2k6xvMt
         leTVQAEFm7mm43uqESyHzwb1boC5fe4gTT28BtE6Gc+hxGZSBTXXU0exL+xCw04XCQgn
         mFwQ==
X-Gm-Message-State: AO0yUKXETaWqNMSEnE5oFUrAstXB8Axj0DzrlSErsCe1TjxagqizHP38
        A5e/CVFNCUx3IHg5s6VYs7uhQFu/ANsdTZauAMrts86EwSnCGZw=
X-Google-Smtp-Source: AK7set+CBZBciT/92gEbb+ZPdu0tB3tVStXfg67iqqa14dc5bEj8wC3OZBLri922lTommI7AJOJZl9HN+z4E7dy/OeU=
X-Received: by 2002:a25:9105:0:b0:ac2:ffe:9cb8 with SMTP id
 v5-20020a259105000000b00ac20ffe9cb8mr3285101ybl.3.1677785963482; Thu, 02 Mar
 2023 11:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230302082414.77613351@gandalf.local.home>
In-Reply-To: <20230302082414.77613351@gandalf.local.home>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 2 Mar 2023 11:39:12 -0800
Message-ID: <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:24=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  2 Mar 2023 06:27:41 +0000
> John Stultz <jstultz@google.com> wrote:
>
> > This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.
> >
> > So while priority inversion on the pmsg_lock is an occasional
> > problem that an rt_mutex would help with, in uses where logging
> > is writing to pmsg heavily from multiple threads, the pmsg_lock
> > can be heavily contended.
> >
> > Normal mutexes can do adaptive spinning, which keeps the
> > contention overhead fairly low maybe adding on the order of 10s
> > of us delay waiting, but the slowpath w/ rt_mutexes makes the
> > blocked tasks sleep & wake. This makes matters worse when there
> > is heavy contentention, as it just allows additional threads to
> > run and line up to try to take the lock.
> >
> > It devolves to a worse case senerio where the lock acquisition
> > and scheduling overhead dominates, and each thread is waiting on
> > the order of ~ms to do ~us of work.
> >
> > Obviously, having tons of threads all contending on a single
> > lock for logging is non-optimal, so the proper fix is probably
> > reworking pstore pmsg to have per-cpu buffers so we don't have
> > contention.
>
> Or perhaps we should convert rt_mutex to have adaptive spinning too. This
> will likely be needed for PREEMPT_RT anyway. IIRC, in the PREEMPT_RT patc=
h,
> only the spinlock converted rt_mutexes used adaptive spinning and the
> argument against converting the mutex to rt_mutex to adaptive spinning wa=
s
> because the normal one (at that time) did not have it, and we wanted to
> keep it the same as mainline. But it appears that that reason is no longe=
r
> the case, and perhaps the real answer is to have all mutexes have adaptiv=
e
> spinning?

This sounds like something to try as well (though I'd still want to
push this revert in the meantime to avoid regressions).

Do you have a more specific pointer to this adaptive spinning
rt_mutexes for spinlocks? Looking at the current PREEMPT_RT patch I'm
not seeing any changes to locking.

thanks
-john
