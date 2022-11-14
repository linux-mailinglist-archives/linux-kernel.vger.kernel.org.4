Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D5628ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiKNUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiKNUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:54:43 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0E65D8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:54:42 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so7403661oti.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQOsCeOOJFs4UoeDhRrZPJ5dm+sP1ZOVKfdXHmuW7+g=;
        b=Chx8SKM4uDi3l7GEZU4sEaiyG9UTKQoBTyv+/cn9VEAmASK0vq27nopo9q+QV3YhBg
         /BuOgBLueDfmAsGbRwbCK3izH3GiOzVHK2ngBwAC9hjIYm5EPNHIRGZN/8JY04AKCV0S
         A1Rn6b02JZLpEUDEKDxvfgnCWzjB8fi868Z88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQOsCeOOJFs4UoeDhRrZPJ5dm+sP1ZOVKfdXHmuW7+g=;
        b=nWshm6thddwGFbABD7zGq0wXe2Nxlt2GJXFcAhnyzKQbJz8RreiDJYY1aTedTVKxYg
         EIm3coPGwBDTKOMMR37iyJDj6isLTcWoCf1L0nQKfr57PsHu2QZEcuoej3O2WxlOk90n
         700amMDNZ0ZsfpEsXGUOHV+Ouz+mjD1lSfAUsB2VEPQ4YeFqWbMQqPp4VLb54cA8euwC
         CwaF4ArytHFt86Rb6qOTRwStkMUqts583jVDOHYPOGlS2csBg6h3PuQAAgj2JRByHHLI
         IogaM35AFdOJgJB29vl24M5MMzHZyh6nUEFC8RCDkUNADl3aeC3o6A6pcqiUPKYIlahk
         Iy+w==
X-Gm-Message-State: ANoB5pnJC/mm8nFFQonUWk6kJW9echAXuOtSwuBKbPqDRS1UrmybQPDZ
        5iMmIOM4Q/02Kq5KWo4VLLrHgt2pX5ure+klPH134w==
X-Google-Smtp-Source: AA0mqf7b+N2UineU1wTXzjfjDotQVuh7h4cVws952140gNcmY0eEVvj/hWcg/bAvT9/ANrRC8nQU+72mEsJ8NL1HkBg=
X-Received: by 2002:a9d:188:0:b0:66d:3e45:8e5a with SMTP id
 e8-20020a9d0188000000b0066d3e458e5amr7231168ote.177.1668459281621; Mon, 14
 Nov 2022 12:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636> <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan> <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636> <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 14 Nov 2022 15:54:30 -0500
Message-ID: <CAEXW_YSGmHWdFJFcYH1UoqC8NT8V0ZGPf+_NdtepCbu8O1LMnA@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
To:     paulmck@kernel.org
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
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

On Mon, Nov 14, 2022 at 11:17 AM Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>
> On Mon, Nov 14, 2022 at 01:20:33PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.co=
m> wrote:
> > > > >
> > > > > > > On ChromeOS, using this with the increased timeout, we see th=
at we
> > > > > > almost always
> > > > > > > never need to initiate a new grace period. Testing also shows=
 this frees
> > > > > > large
> > > > > > > amounts of unreclaimed memory, under intense kfree_rcu() pres=
sure.
> > > > > > >
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.or=
g>
> > > > > > > ---
> > > > > > > v1->v2: Same logic but use polled grace periods instead of sa=
mpling
> > > > > > gp_seq.
> > > > > > >
> > > > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > > >
> > > > > > >  /**
> > > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for =
RCU grace
> > > > > > period
> > > > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling=
 of monitor
> > > > > > work.
> > > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a =
grace period
> > > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiti=
ng for a
> > > > > > grace period
> > > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting=
 for a
> > > > > > grace period
> > > > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > > >       raw_spinlock_t lock;
> > > > > > >       struct delayed_work monitor_work;
> > > > > > > +     unsigned long gp_snap;
> > > > > > >       bool initialized;
> > > > > > >       int count;
> > > > > > >
> > > > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kf=
ree_rcu_cpu
> > > > > > *krcp)
> > > > > > >                       mod_delayed_work(system_wq, &krcp->moni=
tor_work,
> > > > > > delay);
> > > > > > >               return;
> > > > > > >       }
> > > > > > > +     krcp->gp_snap =3D get_state_synchronize_rcu();
> > > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, dela=
y);
> > > > > > >  }
> > > > > > >
> > > > > > How do you guarantee a full grace period for objects which proc=
eed
> > > > > > to be placed into an input stream that is not yet detached?
> > > > >
> > > > >
> > > > > Just replying from phone as I=E2=80=99m OOO today.
> > > > >
> > > > > Hmm, so you=E2=80=99re saying that objects can be queued after th=
e delayed work has
> > > > > been queued, but processed when the delayed work is run? I=E2=80=
=99m looking at
> > > > > this code after few years so I may have missed something.
> > > > >
> > > > > That=E2=80=99s a good point and I think I missed that. I think yo=
ur version did too
> > > > > but I=E2=80=99ll have to double check.
> > > > >
> > > > > The fix then is to sample the clock for the latest object queued,=
 not for
> > > > > when the delayed work is queued.
> > > > >
> > > > The patch i sent gurantee it. Just in case see v2:
> > >
> > > You are right and thank you! CBs can be queued while the monitor time=
r is in
> > > progress. So we need to sample unconditionally. I think my approach i=
s still
> > > better since I take advantage of multiple seconds (I update snapshot =
on every
> > > CB queue monitor and sample in the monitor handler).
> > >
> > > Whereas your patch is snapshotting before queuing the regular work an=
d when
> > > the work is executed (This is a much shorter duration and I bet you w=
ould be
> > > blocking in cond_synchronize..() more often).
> > >
> > There is a performance test that measures a taken time and memory
> > footprint, so you can do a quick comparison. A "rcutorture" can be
> > run with various parameters to figure out if a patch that is in questio=
n
> > makes any difference.
> >
> > Usually i run it as:
> >
> > <snip>
> > #! /usr/bin/env bash
> >
> > LOOPS=3D10
> >
> > for (( i=3D0; i<$LOOPS; i++ )); do
> >         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --to=
rture rcuscale --allcpus --duration 1 \
> >         --kconfig CONFIG_NR_CPUS=3D64 \
> >         --kconfig CONFIG_RCU_NOCB_CPU=3Dy \
> >         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy \
> >         --kconfig CONFIG_RCU_LAZY=3Dn \
> >         --bootargs "rcuscale.kfree_rcu_test=3D1 rcuscale.kfree_nthreads=
=3D16 rcuscale.holdoff=3D20 rcuscale.kfree_loops=3D10000 torture.disable_on=
off_at_boot" --trust-make
> >         echo "Done $i"
> > done
> > <snip>
> >
> > just run it from your linux sandbox.
>
> Would it make sense to modify the "if test "$do_kvfree" =3D "yes" code
> in tools/testing/selftests/rcutorture/bin/torture.sh to do something
> like this instead of what it currently does?

Yes I think so, Were you also thinking of adding it to
tools/testing/selftests/rcutorture/configs with a corresponding
".boot" file for the kfree test's boot parameters?

If it means the bots will run it more, that would be awesome :-)

Thanks,

 - Joel
