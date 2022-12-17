Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D716E64F753
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 04:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLQDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 22:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLQDVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:21:39 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE239468
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:21:38 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so4010632lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn9SLzwdIZcmuQ1drDJMuaaOftSKYIUzhXZaxs7j76c=;
        b=F+foKBrS57aTF+wxTik3ileOk3n2wT0tc7V8Bh3Hm2MIRsUfX15uAf5wjxcRiblIy1
         2dSkglFykUN2jMAsnQgczvcbeiwka98jUsb74M61qSW0KwtIoib8zyMbtoDPLA4iKJNh
         +ZH0FNBQvk5bkqaU255BVDrKl11So6fxdkxgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn9SLzwdIZcmuQ1drDJMuaaOftSKYIUzhXZaxs7j76c=;
        b=LoFLs+DTD8duiypbM+Mqlx0VfFyceJgbxVz9pYaoZEmrhfV763uqfadggPbPAfllOL
         ZlNNJuoNLhQLz65l2ybP4eON5feEjVIpi7YhuaeZZkalsnJdS/PBLGzlB6j339jWGwCs
         fSSx5YvR9hRXLkGU3msw7tfrSST8OpBPqPt9bsYGddTZdndCuV2xCqkEPebVwHtZASmz
         G3SHjrbAf+vsigB7QINRdgnwkTsz9GN5NgJQ6jCQ3sVRQ7JznhJh3Ht8BdAbAC1JP/Un
         Y4Sniw3mD8fEkxkXOfbpryQLdCx6bj++BbYEH4OP7uin7RIeBxNY2znqe30jZIcKovCV
         xt8w==
X-Gm-Message-State: ANoB5pnQ8JC3d+SsvztpOKsdTgkvYr77UTqwE3ya4f1ZYauEajLP+mr6
        FYbUwvkWY7gecwEnspmNZ9gsRtQnOH0VITkUw249oA==
X-Google-Smtp-Source: AA0mqf4ICl/tNZ6ab1VXe1nCl4TI8MhZoXf5VCUrqD1/CYimMTMz9aVGklp+KQP5oZbYlQGe5A9HlvyS5FmyqN/QC4Q=
X-Received: by 2002:a2e:3309:0:b0:279:d1ef:69f7 with SMTP id
 d9-20020a2e3309000000b00279d1ef69f7mr13034824ljc.167.1671247296694; Fri, 16
 Dec 2022 19:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org> <CAEXW_YTkeGVJZQCJ-_3ez_BpeMJ0TOYONCv_g76MDh5=M+9x_Q@mail.gmail.com>
In-Reply-To: <CAEXW_YTkeGVJZQCJ-_3ez_BpeMJ0TOYONCv_g76MDh5=M+9x_Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Dec 2022 22:21:25 -0500
Message-ID: <CAEXW_YSueD31wcNA_=YNiWJfZ80TBypYEXUAwg_XedzRvQ+5HA@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:19 PM Joel Fernandes <joel@joelfernandes.org> wr=
ote:
>
> Hi,
> On the related subject of this function, I drew a diagram for one of
> the reasons why per-CPU unlock counts have to be scanned first, for a
> particular index, before the per-CPU lock counts, and not the other
> way. Otherwise, a reader that got preempted after reading the index,
> can suddenly get scheduled during the inactive index's scan, and cause
> the total lock and unlock counts to falsely match:
> https://i.imgur.com/79fDWdQ.png

Better diagram: https://i.imgur.com/PXKJnmW.png
(Added the preemption reasoning for Reader 0).

thanks,

 - Joel


> Cheers,
>
>  - Joel
>
>
>
> On Fri, Dec 16, 2022 at 11:54 AM Joel Fernandes <joel@joelfernandes.org> =
wrote:
> >
> >
> >
> > > On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > >
> > > =EF=BB=BFOn Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wro=
te:
> > >> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
> > >> [...]
> > >>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the r=
eader
> > >>>>>> has no new smp_mb() that happens AFTER the flip happened. So it =
can
> > >>>>>> totally sample the old idx again -- that particular reader will
> > >>>>>> increment twice, but the next time, it will see the flipped one.
> > >>>>>
> > >>>>> I will let you transliterate both.  ;-)
> > >>>>
> > >>>> I think I see what you mean now :)
> > >>>>
> > >>>> I believe the access I am referring to is the read of idx on one s=
ide and
> > >>>> the write to idx on the other. However that is incomplete and I ne=
ed to
> > >>>> pair that with some of other access on both sides.
> > >>>>
> > >>>> So perhaps this:
> > >>>>
> > >>>> Writer does flip + smp_mb + read unlock counts [1]
> > >>>>
> > >>>> Reader does:
> > >>>> read idx + smp_mb() + increment lock counts [2]
> > >>>>
> > >>>> And subsequently reader does
> > >>>> Smp_mb() + increment unlock count. [3]
> > >>>>
> > >>>> So [1] races with either [2] or [2]+[3].
> > >>>>
> > >>>> Is that fair?
> > >>>
> > >>> That does look much better, thank you!
> > >>
> > >> Perhaps a comment with an ASCII diagram will help?
> > >>
> > >>
> > >> Case 2:
> > >> Both the reader and the updater see each other's writes too late, bu=
t because
> > >> of memory barriers on both sides, they will eventually see each othe=
r's write
> > >> with respect to their own. This is similar to the store-buffer probl=
em. This
> > >> let's a single reader contribute a maximum (unlock minus lock) imbal=
ance of 2.
> > >>
> > >> The following diagram shows the subtle worst case followed by a simp=
lified
> > >> store-buffer explanation.
> > >>
> > >> READER                  UPDATER
> > >> -------------           ----------
> > >>                           // idx is initially 0.
> > >> read_lock() {
> > >>  READ(idx) =3D 0;
> > >>  lock[0]++; --------------------------------------------,
> > >>                           flip() {                      |
> > >>                              smp_mb();                  |
> > >>  smp_mb();                                              |
> > >> }                                                        |
> > >>                                                         |
> > >> // RSCS                                                  |
> > >>                                                         |
> > >> read_unlock() {                                          |
> > >>  smp_mb();                                              |
> > >>                              idx++;  // P               |
> > >>                              smp_mb();                  |
> > >>                           }                             |
> > >>                                                         |
> > >>                           scan_readers_idx(0) {         |
> > >>                               count all unlock[0];      |
> > >>                                   |                     |
> > >>                                   |                     |
> > >>  unlock[0]++; //X <--not-counted--`-----,               |
> > >>                                         |               |
> > >> }                                        V               `------,
> > >>                               // Will make sure next scan      |
> > >>                               // will not miss this unlock (X) |
> > >>                               // if other side saw flip (P) ,--`
> > >>                               // Call this MB [1]           |
> > >>                               // Order write(idx) with      |
> > >>                               // next scan's unlock.        |
> > >>                               smp_mb();                 ,---`
> > >> read_lock() {                                            |
> > >>  READ(idx)=3D0;                                           |
> > >>  lock[0]++; ----------------> count all lock[0];        |
> > >>  smp_mb();         |     }                              |
> > >> }     |             |                                    V
> > >>      |             `---> // Incorrect contribution to lock counting
> > >>      |                   // upto a maximum of 2 times.
> > >>      |
> > >>       `---> // Pairs with MB [1]. Makes sure that
> > >>             // the next read_lock()'s' idx read (Y) is ordered
> > >>             // with above write to unlock[0] (X).
> > >>                            |
> > >> rcu_read_unlock() {         |
> > >>  smp_mb(); <---------------`
> > >>  unlock[0]++;
> > >> }
> > >>
> > >> read_lock() {
> > >>  READ(idx) =3D 1; //Y
> > >>  lock[1]++;
> > >>  ...
> > >> }
> > >>                           scan_readers_idx(0) {
> > >>                               count all unlock[0]; //Q
> > >>                               ...
> > >>
> > >>
> > >> thanks,
> > >>
> > >> - Joel
> > >>
> > >>                          }
> > >>
> > >> This makes it similar to the store buffer pattern. Using X, Y, P and=
 Q
> > >> annotated above, we get:
> > >>
> > >> READER                    UPDATER
> > >> X (write)                 P (write)
> > >>
> > >> smp_mb();                 smp_mb();
> > >>
> > >> Y (read)                  Q (read)
> > >
> > > Given that this diagram is more than 50 lines long, it might go bette=
r in
> > > a design document describing this part of RCU.  Perhaps less detail o=
r
> > > segmented, but the same general idea as this guy:
> > >
> > > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> >
> > Yes, this sounds like a good place to add it and perhaps we refer to it=
 from the C source file? I can take this up to do over the holidays, if you=
 prefer.
> >
> > Thanks,
> >
> >   - Joel
> >
> >
> > >
> > > Thoughts?
> > >
> > >                        Thanx, Paul
