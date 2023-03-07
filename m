Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633036AD58B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCGDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCGDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:12:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070950729
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 19:12:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i9so15407918lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 19:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678158653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij4quFfm9XyGiMMZ5/1/B+XAEdKVJEmmxJdTkh+GOZ4=;
        b=NJtxDkTaW/9ZvA3NYbCUQ8Htm8hACa7UlynfkFBx/a1RY3XyiESVUh4FCmJUehKs42
         1VSAft4ys5UPuVPlrgkXGqWbvAPr4VfJArlxa+hIHmhyEgRyLPf/EpdgkMEVOnd0sZ3S
         wM2jXh1kP72XKXbLvdvrBLc1Nruf4fA5dWTlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678158653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij4quFfm9XyGiMMZ5/1/B+XAEdKVJEmmxJdTkh+GOZ4=;
        b=XkLstY98Hc/yWH7F/+ztoKohJjwxHLPaN6HIC6fzag5sDoJTpOz5+o/uwqScLj8Jqu
         WlLrDG+fjz5FPevNuWmpUQHf4wMWzgfL1sGZcvpyH2i/Ijj6TBjwyDgvHSROlMtDiDvq
         g5ZEKr2rSepBSMBajnhD7oz5+Ff6QwQ/1sxiorHoVHdEif7hBI30Hb36K7HtYFZpOnJB
         ndusW9J3jvEybONFV9uxWwNZvmbyYvTjstSuv+4dpPB0IJz682B/9p74kTl91WS1qv53
         x+kJk3uzQUbLkPja4C8Dp5egJIZtFFjlJOqt51dJQ6a7dBuw2I/1dI7qj1CR2fAsbNhU
         /sMg==
X-Gm-Message-State: AO0yUKW8rILHLxbo6I6sP4fHjcGBVIQTI6Bm/5WhuWtyqcuWqra9xYnP
        VwO6wq1i0ElhB4J0R1LhTX55SCQP6jfdjFjSSzJ9pQ==
X-Google-Smtp-Source: AK7set9iRw9s/hlcsLUGpRdH0Bgp5KJV6710JZtugyLfHuCcrjtnuQgAO6eFolxZzPPAkDrPyZFgLrocULDR2cluAHs=
X-Received: by 2002:a19:740e:0:b0:4db:345d:4f8a with SMTP id
 v14-20020a19740e000000b004db345d4f8amr3973160lfe.11.1678158652961; Mon, 06
 Mar 2023 19:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20230307030457.3499834-1-joel@joelfernandes.org> <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
In-Reply-To: <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Mar 2023 22:10:39 -0500
Message-ID: <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 10:08=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> > error-prone. However, till all users are converted, we would like to in=
troduce
> > checkpatch errors for new patches submitted.
> >
> > This patch adds support for the same. Tested with a trial patch.
> >
> > For now, we are only considering usages that don't have compound
> > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name)=
.
> > This is sufficient as such usages are unlikely.
> >
> > Once all users are converted and we remove the old API, we can also rev=
ert this
> > checkpatch patch then.
>
> I think this should be added to the deprecated_apis hash instead
>
> our %deprecated_apis =3D (
>         "synchronize_rcu_bh"                    =3D> "synchronize_rcu",
>         "synchronize_rcu_bh_expedited"          =3D> "synchronize_rcu_exp=
edited",
>         "call_rcu_bh"                           =3D> "call_rcu",
>         "rcu_barrier_bh"                        =3D> "rcu_barrier",
>         "synchronize_sched"                     =3D> "synchronize_rcu",
>         "synchronize_sched_expedited"           =3D> "synchronize_rcu_exp=
edited",
>         "call_rcu_sched"                        =3D> "call_rcu",
>         "rcu_barrier_sched"                     =3D> "rcu_barrier",
>         "get_state_synchronize_sched"           =3D> "get_state_synchroni=
ze_rcu",
>         "cond_synchronize_sched"                =3D> "cond_synchronize_rc=
u",
>         "kmap"                                  =3D> "kmap_local_page",
>         "kunmap"                                =3D> "kunmap_local",
>         "kmap_atomic"                           =3D> "kmap_local_page",
>         "kunmap_atomic"                         =3D> "kunmap_local",
> );

This is not an API name change though, it is a "number of arguments"
or argument list change. Is there a different way to do it?

thanks,

 - Joel
