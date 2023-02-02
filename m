Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED0688991
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjBBWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBBWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:12:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FC64682
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:11:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o12so3384868ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDBf9AfsyJbDtWjBnORPYU2pBf1EAExr7r+iEnI2UJk=;
        b=DiQK1RYQzoUkORmBEz1Rkwi9p4a0tXqoRCrUVCeT+LRfAIZWk19mpwacI3+cO5xyfQ
         X/unw6O6ZAPTICkvk+5xe4gMtll3sTUc2iD9XpTX63fkRrNHxkVjqi5JT0up7TNX9K7I
         mxvMKxD7qHndz5uwVXyrdy+jbuUmOKccaQBi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDBf9AfsyJbDtWjBnORPYU2pBf1EAExr7r+iEnI2UJk=;
        b=p3pm/C9guac7pptEPkBe/TEeI7QfhZQyY7aASCZSYd2X5JIyhvRq+WxCgVUpKl1pZH
         45FM8sdyW/SYY/vFqF2KuDl7vd/7gESFLS/QYleO1ZCN9XFGxqo7wmWWcN7jr9TC+LrH
         p4UnVrJ1vCK26gMo3AwFrmJC3cdUkeAuPT8nbh3ptTK7+veKT2ZZ4g0IoRcrTUxmeK2X
         4v6dQKW452oRZXS7JKTVgRxZOevQhM9GyDt4aJE3uXDut0ihwypnYVYvkQ2/94O7FkT/
         WSvx9ZrlZv9YYnBjAM6B8OBZigzTgyG8Klfr1uLJhM1dpKV/NvjvsBclgHrP1mmAP+WI
         IMhg==
X-Gm-Message-State: AO0yUKUFFe5W3tyDA+OsyrOJw8sUB8ph0ov1koTi56NVDJi5PUS746Pp
        lvjjWZxIezYfrYTlauTNwFUAmi+ahhvw+cvVuLZdlQ==
X-Google-Smtp-Source: AK7set/RbA0pp+Qg8Rsnud2lgip3FiJpNc3sLz6lAva+5lxLZwIGc8AFOklF/KcPcvFq6MOUVDu6o3TNx1Z/7sHc9AM=
X-Received: by 2002:a2e:a36c:0:b0:28b:7226:f203 with SMTP id
 i12-20020a2ea36c000000b0028b7226f203mr1266615ljn.207.1675375917469; Thu, 02
 Feb 2023 14:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20230202070245.3311951-1-qiang1.zhang@intel.com>
 <7959A7ED-A47F-4472-9278-8582F1CCC6A9@joelfernandes.org> <PH0PR11MB5880DF541BB1D75E0DFC02FEDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880DF541BB1D75E0DFC02FEDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 2 Feb 2023 17:11:45 -0500
Message-ID: <CAEXW_YRSEu=O7FW=T5fOAWcRbejQUXVN+RoGcTN+xkd7xmJepA@mail.gmail.com>
Subject: Re: [PATCH v2] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Feb 2, 2023 at 4:25 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote=
:
>
>
> > On Feb 2, 2023, at 1:57 AM, Zqiang <qiang1.zhang@intel.com> wrote:
> >
> > =EF=BB=BFWhen setting nocbs_nthreads to start rcutorture test with a no=
n-zero value,
> > the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffloa=
d()
> > to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=3Dn
> > kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is als=
o
> > meaningless for torture_type is non-rcu.
> >
> > This commit therefore add member can_nocbs_toggle to rcu_torture_ops
> > structure to avoid unnecessary nocb tasks creation.
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> > kernel/rcu/rcutorture.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >Sorry if I am missing something but what is the point of adding more lin=
es of code and complexity to handle this? Does it improve the test coverage=
 or reduce overhead?
> >
> >This is test code. I see no problem with cost of an extra unused task wi=
th positive trade off of keeping the code simple=E2=80=A6
>
> For nocbs_nthreads is non-zero and CONFIG_RCU_NOCB_CPU=3Dn kernels,
> the rcu_nocb_cpu_offload/deoffload() is a no-op,  we create nocbs_nthread=
s
> kthreads and perform nocb toggle tests periodically, which is meaningless=
 and
> will take extra cpu time.

Ah, ok. I see what you did now, could you add these details to the
changelog. One comment below:

[...]
> > @@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops =3D {
> >    .stall_dur        =3D rcu_jiffies_till_stall_check,
> >    .irq_capable        =3D 1,
> >    .can_boost        =3D IS_ENABLED(CONFIG_RCU_BOOST),
> > +    .can_nocbs_toggle    =3D IS_ENABLED(CONFIG_RCU_NOCB_CPU),
> >    .extendables        =3D RCUTORTURE_MAX_EXTEND,
> >    .name            =3D "rcu"
> > };
> > @@ -2356,7 +2358,7 @@ rcu_torture_print_module_parms(struct rcu_torture=
_ops *cur_ops, const char *tag)
> >         "n_barrier_cbs=3D%d "
> >         "onoff_interval=3D%d onoff_holdoff=3D%d "
> >         "read_exit_delay=3D%d read_exit_burst=3D%d "
> > -         "nocbs_nthreads=3D%d nocbs_toggle=3D%d "
> > +         "nocbs_nthreads=3D%d/%d nocbs_toggle=3D%d "
> >         "test_nmis=3D%d\n",
> >         torture_type, tag, nrealreaders, nfakewriters,
> >         stat_interval, verbose, test_no_idle_hz, shuffle_interval,
> > @@ -2368,7 +2370,7 @@ rcu_torture_print_module_parms(struct rcu_torture=
_ops *cur_ops, const char *tag)
> >         n_barrier_cbs,
> >         onoff_interval, onoff_holdoff,
> >         read_exit_delay, read_exit_burst,
> > -         nocbs_nthreads, nocbs_toggle,
> > +         nocbs_nthreads, cur_ops->can_nocbs_toggle, nocbs_toggle,
> >         test_nmis);
> > }
> >
> > @@ -3708,6 +3710,10 @@ rcu_torture_init(void)
> >        pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs=
 disabled.\n");
> >        fqs_duration =3D 0;
> >    }
> > +    if (!cur_ops->can_nocbs_toggle && nocbs_nthreads !=3D 0) {
> > +        pr_alert("rcu-torture: ->can_nocbs_toggle false and non-zero n=
ocbs_nthreads, nocbs_toggle disabled.\n");
> > +        nocbs_nthreads =3D 0;
> > +    }

Instead of adding a hook, why not check for CONFIG_RCU_NOCB_CPU here?

so like:
 if (cur_ops !=3D &rcu_ops || !IS_ENABLED(CONFIG_RCU_NOCB_CPU))
   nocbs_nthreads =3D 0;

Or will that not work for some reason? Just 2 line change and no ugly hooks=
 =3D)

- Joel
