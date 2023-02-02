Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBF688162
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjBBPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBBPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:13:33 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA03401F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:13:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z5so2120270qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WqJC9VZ4AG3j1X+hs58y4e3ep1HxT3O0baiSoKtjog=;
        b=D6DG9Ekpgc1jWUsf3Unm4PkdYuZFvSadEnC72eA+9UEEfc6CXzLDFg3uw/PYFEQtA4
         JURsqe0RbY0kwzhIL7GfmdpcPf9+RObCThJQC40qwj6pKOcfqJ/YOoQGBixPOWdMJAu8
         rVy04DyjOR9rBOBg/uRRpLBLTZyOS570yjR8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WqJC9VZ4AG3j1X+hs58y4e3ep1HxT3O0baiSoKtjog=;
        b=Ozi68Th4twITMK4mgh8kdFevKWsYu4H8Psd9AFEpr706p/tvE/29CiGnj5i0LmulWl
         bOoomc18y1h+ZHEwOXxvo0BMbVthp6nKm6ssyUUgVxCqzDslcy7YBjUNbqoafL86axHu
         B7EI45cpODMOLvD5kKSFo+L0ilyFFGQmcIQKEfj8yvOCHem+4COT+WjtYy7d7ZEPfh5i
         1XAQL20ecC4achlPipizohWVDH/Cxd7O2DHxjQ1dFDQIwemuJxgBNavbBbaZwE5yMbfy
         /KYAZfCMxL3ZiKSMWcJH/tXITk/joplJ6tqDp2+Uc6Knwn0sSU5w1iBZaBbRuLwNflRQ
         L9iQ==
X-Gm-Message-State: AO0yUKVCNvunbDkWGU46Gl0TU5BTBdHqTri+TiudxMB6SLgorqHnnBWD
        t7FYXYhwjQHdmnw56u9nXQE/bw==
X-Google-Smtp-Source: AK7set9b2cCOhZ/ZYI0qHVadcjf2S+Gnd/QhtxGEg1IHjEv01E8EJTXfsztJVO93zpX1zQ+r4HeUAA==
X-Received: by 2002:a05:622a:1ce:b0:3b6:334b:2cbc with SMTP id t14-20020a05622a01ce00b003b6334b2cbcmr13450465qtw.65.1675350811166;
        Thu, 02 Feb 2023 07:13:31 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bs18-20020ac86f12000000b003b8558eabd0sm9426401qtb.23.2023.02.02.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:13:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcutorture: Create nocb tasks only for CONFIG_RCU_NOCB_CPU=y kernels
Date:   Thu, 2 Feb 2023 10:13:19 -0500
Message-Id: <7959A7ED-A47F-4472-9278-8582F1CCC6A9@joelfernandes.org>
References: <20230202070245.3311951-1-qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230202070245.3311951-1-qiang1.zhang@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 2, 2023, at 1:57 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>=20
> =EF=BB=BFWhen setting nocbs_nthreads to start rcutorture test with a non-z=
ero value,
> the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()=

> to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=3Dn
> kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
> meaningless for torture_type is non-rcu.
>=20
> This commit therefore add member can_nocbs_toggle to rcu_torture_ops
> structure to avoid unnecessary nocb tasks creation.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
> kernel/rcu/rcutorture.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)

Sorry if I am missing something but what is the point of adding more lines o=
f code and complexity to handle this? Does it improve the test coverage or r=
educe overhead?

This is test code. I see no problem with cost of an extra unused task with p=
ositive trade off of keeping the code simple=E2=80=A6

thanks,

 - Joel=20


>=20
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 297da28ce92d..ced0a8e1d765 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -383,6 +383,7 @@ struct rcu_torture_ops {
>    long cbflood_max;
>    int irq_capable;
>    int can_boost;
> +    int can_nocbs_toggle;
>    int extendables;
>    int slow_gps;
>    int no_pi_lock;
> @@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops =3D {
>    .stall_dur        =3D rcu_jiffies_till_stall_check,
>    .irq_capable        =3D 1,
>    .can_boost        =3D IS_ENABLED(CONFIG_RCU_BOOST),
> +    .can_nocbs_toggle    =3D IS_ENABLED(CONFIG_RCU_NOCB_CPU),
>    .extendables        =3D RCUTORTURE_MAX_EXTEND,
>    .name            =3D "rcu"
> };
> @@ -2356,7 +2358,7 @@ rcu_torture_print_module_parms(struct rcu_torture_op=
s *cur_ops, const char *tag)
>         "n_barrier_cbs=3D%d "
>         "onoff_interval=3D%d onoff_holdoff=3D%d "
>         "read_exit_delay=3D%d read_exit_burst=3D%d "
> -         "nocbs_nthreads=3D%d nocbs_toggle=3D%d "
> +         "nocbs_nthreads=3D%d/%d nocbs_toggle=3D%d "
>         "test_nmis=3D%d\n",
>         torture_type, tag, nrealreaders, nfakewriters,
>         stat_interval, verbose, test_no_idle_hz, shuffle_interval,
> @@ -2368,7 +2370,7 @@ rcu_torture_print_module_parms(struct rcu_torture_op=
s *cur_ops, const char *tag)
>         n_barrier_cbs,
>         onoff_interval, onoff_holdoff,
>         read_exit_delay, read_exit_burst,
> -         nocbs_nthreads, nocbs_toggle,
> +         nocbs_nthreads, cur_ops->can_nocbs_toggle, nocbs_toggle,
>         test_nmis);
> }
>=20
> @@ -3708,6 +3710,10 @@ rcu_torture_init(void)
>        pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs di=
sabled.\n");
>        fqs_duration =3D 0;
>    }
> +    if (!cur_ops->can_nocbs_toggle && nocbs_nthreads !=3D 0) {
> +        pr_alert("rcu-torture: ->can_nocbs_toggle false and non-zero nocb=
s_nthreads, nocbs_toggle disabled.\n");
> +        nocbs_nthreads =3D 0;
> +    }
>    if (cur_ops->init)
>        cur_ops->init();
>=20
> --=20
> 2.25.1
>=20
