Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E474652A60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiLUAQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiLUAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:16:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABD20BDF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:15:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so21049239lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XH7jLCHw49UfoB8dcP80Xoh9zFjiyuN29qfL2uQIx0=;
        b=sx/ZZngReB8j72F0HrKnEuxs2Y41b/88kxTw5/hQ/jBmtfyJ63Y4uJoDyeCDh5HJP7
         bLgHZVBsPc/rGSj+Conn4myeOMWIDu5/EjKJwiiYZRsJG9JGZAvSSrZ91QvfVopP3kP8
         ua6+Z4G0cr8m9wkleFSdr/i2e122vxFSpKChw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XH7jLCHw49UfoB8dcP80Xoh9zFjiyuN29qfL2uQIx0=;
        b=Y5iOcczkzGazLkKlcqulqmZm8h/rkzcVEIoGGKXd2beb2hckZr94bxDapezTTVNQhM
         CYFYhnmwHZ23I2+TjmRNl7zINk+uxzQyVjA5DiQHMtyRVCbnZbF/bdseqmqdmTRz0GFP
         okbAhOZIn+CWWV4sYeonpPJYMm/KqPQUl9yaSCT6VxuCbZnptS2T/26yS3cfqrLsI2lH
         WdUSrLUmXfSFfRB1n2ZcE2lbXCaPBqHb0Y3MloF1gCiJZD7eslBGOT46qAdchhp0/vZd
         AlXta1JP0HTrhfsoJDRb5Cp+WsyyQftxFult7iCKIZjcatgLrt4YMIr/G0BLHCfUMWx0
         yjGQ==
X-Gm-Message-State: ANoB5pmfmKlkiWCIu/++TyKc3pdq4rnglYeKCsq98w34KHfBQW+FBnV9
        VUQ3caRDaGGN5bWW70voQEhChIdNQQR7VE9w7R++8w==
X-Google-Smtp-Source: AA0mqf78lipnO46J5Nf/p1tJ10kq9BnIUZj25VaM5pKPfehhN1UfDp4EM5DKtr/LjOcJqvaGOKQDDdITkkMj0fwKEa8=
X-Received: by 2002:ac2:510c:0:b0:4af:d4e:dfa7 with SMTP id
 q12-20020ac2510c000000b004af0d4edfa7mr28337581lfb.582.1671581712104; Tue, 20
 Dec 2022 16:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20221220140714.GB22763@lothringen> <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen>
In-Reply-To: <20221220224459.GA25175@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Dec 2022 19:15:00 -0500
Message-ID: <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Tue, Dec 20, 2022 at 09:20:08AM -0500, Joel Fernandes wrote:
> > > On Dec 20, 2022, at 9:07 AM, Frederic Weisbecker <frederic@kernel.org=
> wrote:
> > >
> > > =EF=BB=BFOn Tue, Dec 20, 2022 at 08:44:40AM -0500, Joel Fernandes wro=
te:
> > >>> C w-depend-r
> > >>>
> > >>> {
> > >>>   PLOCK=3DLOCK0;
> > >>> }
> > >>>
> > >>> // updater
> > >>> P0(int *LOCK1, int **PLOCK)
> > >>> {
> > >>>   int lock1;
> > >>>
> > >>>   lock1 =3D READ_ONCE(*LOCK1); // READ from inactive idx
> > >>>   smp_mb();
> > >>>   WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
> > >>> }
> > >>>
> > >>> // reader
> > >>> P1(int **PLOCK)
> > >>> {
> > >>>   int *plock;
> > >>>
> > >>>   plock =3D READ_ONCE(*PLOCK);    // Read active idx
> > >>>   WRITE_ONCE(*plock, 1); // Write to active idx
> > >>
> > >> I am a bit lost here, why would the reader want to write to the acti=
ve idx?
> > >> The reader does not update the idx, only the lock count.
> > >
> > > So &ssp->sda->srcu_lock_count is the base address and idx is the offs=
et, right?
> > > The write is then displayed that way:
> > >
> > >     this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
> > >
> > > But things could be also thought the other way around with idx being =
the base address and
> > > ssp->sda->srcu_lock_count being the offset.
> > >
> > >     this_cpu_inc(idx[ssp->sda->srcu_lock_count].counter);
> > >
> > > That would require to change some high level types but the result wou=
ld be the same from
> > > the memory point of view (and even from the ASM point of view). In th=
e end we
> > > are dealing with the same address and access.
> > >
> > > Now ssp->sda->srcu_lock_count is a constant address value. It doesn't=
 change.
> > > So it can be zero for example. Then the above increment becomes:
> > >
> > >   this_cpu_inc(idx.counter);
> > >
> > > And then it can be modelized as in the above litmus test.
> > >
> > > I had to play that trick because litmus doesn't support arrays but I =
believe
> > > it stands. Now of course I may well have got something wrong since I'=
ve always
> > > been terrible at maths...
> >
> > Ah ok, I get where you were going with that. Yes there is address depen=
dency
> > between reading idx and writing lock count. But IMHO, the access on the=
 update
> > side is trying to order write to index, and reads from a lock count of =
a
> > previous index (as far as E / B+C is concerned). So IMHO, on the read s=
ide you
> > have to consider 2 consecutive readers and not the same reader in order=
 to
> > pair the same accesses correctly. But I could be missing something.
>
> And you're right, for the first part of the comment (let's call that (1))=
:
>
>          * Ensure that if this updater saw a given reader's increment
>          * from __srcu_read_lock(), that reader was using an old value
>          * of ->srcu_idx.
>
> My litmus test shows the ordering displayed in the second part of the com=
ment
> (call it (2)):
>
>          * Also ensure that if a given reader sees the
>          * new value of ->srcu_idx, this updater's earlier scans cannot
>          * have seen that reader's increments (which is OK, because this
>          * grace period need not wait on that reader).
>
> _ In (1), E indeed pairs with B and C

Agreed about (1).

> _ In (2), E pairs with the address-dependency between idx and lock_count.

But that is not the only reason. If that was the only reason for (2),
then there is an smp_mb() just before the next-scan post-flip before
the lock counts are read.

The comment also says that: "D" pairs with "C" and does not mention
"C" being an addr dependency.  So IMHO, you need to look at the unlock
count access and the idx access, for (2). Something like this:
https://hastebin.com/raw/gadeliquta . Though that is complex as fuck.

Or did I miss something subtle?

Thanks.
