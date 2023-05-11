Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0626FEB22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEKFYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:24:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860DA4EC5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:23:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so39537895276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683782610; x=1686374610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpgvCWUvXRPNNavpasm5+g46uRmrCKwxG9LMGl+6Jtk=;
        b=efay1tWYMWyi1JX1C0rrXA7GPOd4BG0NYAB1w1aWz+guHNKHZknX5a0+U+mZNcQU6r
         CPlAKxYlvKDhJrjyNeYqoGzBtF+vc9dDjA/FvqOt9rQZaJ/mcnPGgoXL0iNVJ3PtiUXz
         iX87UHvALo8OHJYU00n2HDfSJlYfPDqnUCEfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683782610; x=1686374610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpgvCWUvXRPNNavpasm5+g46uRmrCKwxG9LMGl+6Jtk=;
        b=SwsW+Q5G1eITtXtZx/K9G/pKsdMjnnATWG2wSmCO6+iPXFgPSL4rrbE2bRaDMO35K/
         G4gHYgSAyWQH4MKtUNTSBmYGIPI7ro9npkJAMrnQAeisX1BpBs+1/xka5OgWLbV0Zb5j
         lVBqf8GS6DHRp05AAacSQf5uo/PlbxwsXMGqmLeTPwx3rsDrsBVkMIpi7AWdVX5eqg+r
         XKGzTGrJuuV/LOi9Dn/+NhPvYFIu4zlg9Rplr0s5a5e/urQ+oOC9ag5TU6uF+pnmk2kS
         zxHHAvKf1v9a+1dQmFZSpAJehQduw3xVWZnG22L7uUqxzr6N6QEUV/4YALYmNWeZXaLT
         n4BA==
X-Gm-Message-State: AC+VfDyaTKKmRIOfE/ryMeQgAdSSi/pLzxww0iGWudRM3s4WCGnIDt15
        SoHsHsFUtLiE3DNCzMC2TkoCOubhTCmHESFdPKKtwQ==
X-Google-Smtp-Source: ACHHUZ5dPZfSQWHIC5VVwllMx8xK3Il3V//E3cwZzvPxdvVz+TE42m38cs+vd+RQshnHAIG1RDbT3E/GlAwEl+8IsUg=
X-Received: by 2002:a25:1f07:0:b0:ba6:b71:3ba9 with SMTP id
 f7-20020a251f07000000b00ba60b713ba9mr6600870ybf.12.1683782610548; Wed, 10 May
 2023 22:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop> <20230510171238.2189921-3-paulmck@kernel.org>
In-Reply-To: <20230510171238.2189921-3-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:23:19 -0700
Message-ID: <CAEXW_YTHNbzdSn3RpJwnwKZOJX=rGdMabfsCw0ZuMZhsXZMjQA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> This code-movement-only commit moves the rcu_scale_cleanup() and
> rcu_scale_shutdown() functions to follow kfree_scale_cleanup().
> This is code movement is in preparation for a bug-fix patch that invokes
> kfree_scale_cleanup() from rcu_scale_cleanup().
>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/rcuscale.c | 194 +++++++++++++++++++++---------------------
>  1 file changed, 97 insertions(+), 97 deletions(-)

I wish diff was better at showing what really changed. The meld tool
can help but its gui...

Should I run meld later (I'm out at a conference so no access to
meld-capable machines) or are we sufficiently confident that the lines
were moved as-is ? :)

 - Joel


>
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index e82ec9f9a5d8..7e8965b0827a 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -522,89 +522,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *c=
ur_ops, const char *tag)
>                  scale_type, tag, nrealreaders, nrealwriters, verbose, sh=
utdown);
>  }
>
> -static void
> -rcu_scale_cleanup(void)
> -{
> -       int i;
> -       int j;
> -       int ngps =3D 0;
> -       u64 *wdp;
> -       u64 *wdpp;
> -
> -       /*
> -        * Would like warning at start, but everything is expedited
> -        * during the mid-boot phase, so have to wait till the end.
> -        */
> -       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> -               SCALEOUT_ERRSTRING("All grace periods expedited, no norma=
l ones to measure!");
> -       if (rcu_gp_is_normal() && gp_exp)
> -               SCALEOUT_ERRSTRING("All grace periods normal, no expedite=
d ones to measure!");
> -       if (gp_exp && gp_async)
> -               SCALEOUT_ERRSTRING("No expedited async GPs, so went with =
async!");
> -
> -       if (torture_cleanup_begin())
> -               return;
> -       if (!cur_ops) {
> -               torture_cleanup_end();
> -               return;
> -       }
> -
> -       if (reader_tasks) {
> -               for (i =3D 0; i < nrealreaders; i++)
> -                       torture_stop_kthread(rcu_scale_reader,
> -                                            reader_tasks[i]);
> -               kfree(reader_tasks);
> -       }
> -
> -       if (writer_tasks) {
> -               for (i =3D 0; i < nrealwriters; i++) {
> -                       torture_stop_kthread(rcu_scale_writer,
> -                                            writer_tasks[i]);
> -                       if (!writer_n_durations)
> -                               continue;
> -                       j =3D writer_n_durations[i];
> -                       pr_alert("%s%s writer %d gps: %d\n",
> -                                scale_type, SCALE_FLAG, i, j);
> -                       ngps +=3D j;
> -               }
> -               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: =
%d batches: %ld\n",
> -                        scale_type, SCALE_FLAG,
> -                        t_rcu_scale_writer_started, t_rcu_scale_writer_f=
inished,
> -                        t_rcu_scale_writer_finished -
> -                        t_rcu_scale_writer_started,
> -                        ngps,
> -                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> -                                          b_rcu_gp_test_started));
> -               for (i =3D 0; i < nrealwriters; i++) {
> -                       if (!writer_durations)
> -                               break;
> -                       if (!writer_n_durations)
> -                               continue;
> -                       wdpp =3D writer_durations[i];
> -                       if (!wdpp)
> -                               continue;
> -                       for (j =3D 0; j < writer_n_durations[i]; j++) {
> -                               wdp =3D &wdpp[j];
> -                               pr_alert("%s%s %4d writer-duration: %5d %=
llu\n",
> -                                       scale_type, SCALE_FLAG,
> -                                       i, j, *wdp);
> -                               if (j % 100 =3D=3D 0)
> -                                       schedule_timeout_uninterruptible(=
1);
> -                       }
> -                       kfree(writer_durations[i]);
> -               }
> -               kfree(writer_tasks);
> -               kfree(writer_durations);
> -               kfree(writer_n_durations);
> -       }
> -
> -       /* Do torture-type-specific cleanup operations.  */
> -       if (cur_ops->cleanup !=3D NULL)
> -               cur_ops->cleanup();
> -
> -       torture_cleanup_end();
> -}
> -
>  /*
>   * Return the number if non-negative.  If -1, the number of CPUs.
>   * If less than -1, that much less than the number of CPUs, but
> @@ -624,20 +541,6 @@ static int compute_real(int n)
>         return nr;
>  }
>
> -/*
> - * RCU scalability shutdown kthread.  Just waits to be awakened, then sh=
uts
> - * down system.
> - */
> -static int
> -rcu_scale_shutdown(void *arg)
> -{
> -       wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_fini=
shed) >=3D nrealwriters);
> -       smp_mb(); /* Wake before output. */
> -       rcu_scale_cleanup();
> -       kernel_power_off();
> -       return -EINVAL;
> -}
> -
>  /*
>   * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs f=
or number
>   * of iterations and measure total time and number of GP for all iterati=
ons to complete.
> @@ -874,6 +777,103 @@ kfree_scale_init(void)
>         return firsterr;
>  }
>
> +static void
> +rcu_scale_cleanup(void)
> +{
> +       int i;
> +       int j;
> +       int ngps =3D 0;
> +       u64 *wdp;
> +       u64 *wdpp;
> +
> +       /*
> +        * Would like warning at start, but everything is expedited
> +        * during the mid-boot phase, so have to wait till the end.
> +        */
> +       if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> +               SCALEOUT_ERRSTRING("All grace periods expedited, no norma=
l ones to measure!");
> +       if (rcu_gp_is_normal() && gp_exp)
> +               SCALEOUT_ERRSTRING("All grace periods normal, no expedite=
d ones to measure!");
> +       if (gp_exp && gp_async)
> +               SCALEOUT_ERRSTRING("No expedited async GPs, so went with =
async!");
> +
> +       if (torture_cleanup_begin())
> +               return;
> +       if (!cur_ops) {
> +               torture_cleanup_end();
> +               return;
> +       }
> +
> +       if (reader_tasks) {
> +               for (i =3D 0; i < nrealreaders; i++)
> +                       torture_stop_kthread(rcu_scale_reader,
> +                                            reader_tasks[i]);
> +               kfree(reader_tasks);
> +       }
> +
> +       if (writer_tasks) {
> +               for (i =3D 0; i < nrealwriters; i++) {
> +                       torture_stop_kthread(rcu_scale_writer,
> +                                            writer_tasks[i]);
> +                       if (!writer_n_durations)
> +                               continue;
> +                       j =3D writer_n_durations[i];
> +                       pr_alert("%s%s writer %d gps: %d\n",
> +                                scale_type, SCALE_FLAG, i, j);
> +                       ngps +=3D j;
> +               }
> +               pr_alert("%s%s start: %llu end: %llu duration: %llu gps: =
%d batches: %ld\n",
> +                        scale_type, SCALE_FLAG,
> +                        t_rcu_scale_writer_started, t_rcu_scale_writer_f=
inished,
> +                        t_rcu_scale_writer_finished -
> +                        t_rcu_scale_writer_started,
> +                        ngps,
> +                        rcuscale_seq_diff(b_rcu_gp_test_finished,
> +                                          b_rcu_gp_test_started));
> +               for (i =3D 0; i < nrealwriters; i++) {
> +                       if (!writer_durations)
> +                               break;
> +                       if (!writer_n_durations)
> +                               continue;
> +                       wdpp =3D writer_durations[i];
> +                       if (!wdpp)
> +                               continue;
> +                       for (j =3D 0; j < writer_n_durations[i]; j++) {
> +                               wdp =3D &wdpp[j];
> +                               pr_alert("%s%s %4d writer-duration: %5d %=
llu\n",
> +                                       scale_type, SCALE_FLAG,
> +                                       i, j, *wdp);
> +                               if (j % 100 =3D=3D 0)
> +                                       schedule_timeout_uninterruptible(=
1);
> +                       }
> +                       kfree(writer_durations[i]);
> +               }
> +               kfree(writer_tasks);
> +               kfree(writer_durations);
> +               kfree(writer_n_durations);
> +       }
> +
> +       /* Do torture-type-specific cleanup operations.  */
> +       if (cur_ops->cleanup !=3D NULL)
> +               cur_ops->cleanup();
> +
> +       torture_cleanup_end();
> +}
> +
> +/*
> + * RCU scalability shutdown kthread.  Just waits to be awakened, then sh=
uts
> + * down system.
> + */
> +static int
> +rcu_scale_shutdown(void *arg)
> +{
> +       wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_fini=
shed) >=3D nrealwriters);
> +       smp_mb(); /* Wake before output. */
> +       rcu_scale_cleanup();
> +       kernel_power_off();
> +       return -EINVAL;
> +}
> +
>  static int __init
>  rcu_scale_init(void)
>  {
> --
> 2.40.1
>
