Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9E6BA387
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCNXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:30:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536B58B6F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:30:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e194so17459299ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678836606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CGx+2lSjSQDiTc7ljAgHgFH+XwnN61FRvgMDbdvIpI=;
        b=LtB/tm8vHXf9k20eragZbnEXeIY60N3ZQdpqGBvDTrLYk0/iWOudxiRvgcvwCao4ea
         YNVM4dQ44LwoUBJ+QhSd5Er4NF2u7SEFNjv8wQcxDY3mXrLSont2SOa4bFi2pNTzCND9
         6UbHkT6vkJeDNuFFymBALd5IhuO8eVFY9dJAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678836606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CGx+2lSjSQDiTc7ljAgHgFH+XwnN61FRvgMDbdvIpI=;
        b=GDCTj7NyVscP73WUV3AOuKwguoXzMrkcnQGapcxqjpJSrG5PTN2S4wa92O3Np+rCGy
         ostwuD0wOyA/kvpv3M4UJ6SO9gQlPSFf6glYxsYjhOTfVLxznTKIUc45P1IhWP0Pp4e/
         ZxhjOgsojBbmMtOnBR2CRkZpqYNcH90WowSPDNG/T3XleTzlSYKU/6WmIvGbY4HkXRrf
         9LvEq44KmuZ+AEbWfHKrssbV0JfcJqJ2iUIVmRQ1LxScCvrK3ecse3sCijnWFs4TaST6
         dNXED5qlkTU651tfq7DLwMKqd3NuWUjZ0GlVycEWYNjqVQTsKd7a5Wizb0MPe2uA6zN/
         l1Dw==
X-Gm-Message-State: AO0yUKXbuXFtx3C082bTvVsSlfSgTM/1Eh9cl835gJ7aGDT02NiK/D4p
        h3BsYWqobPv+GHKTz1tESmgOgGw2pNI9PgpxLCEKqw==
X-Google-Smtp-Source: AK7set+r2ERtVzzNLDRX38IjrWoYRr4LTlZKcSP0tMlG+fou7BMKSVDkUfAlpdnVq9IQfrsS0L2n2exK7Fax0p2trcE=
X-Received: by 2002:a25:8f82:0:b0:b39:be7e:30c8 with SMTP id
 u2-20020a258f82000000b00b39be7e30c8mr5642874ybl.2.1678836606112; Tue, 14 Mar
 2023 16:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com> <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
In-Reply-To: <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 14 Mar 2023 19:29:54 -0400
Message-ID: <CAEXW_YRxWGCuV_YVLqpFqOnGAMYAf2c+TAV1iAD8=2uVOqkf_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
To:     paulmck@kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 7:02=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Mar 13, 2023 at 04:04:03PM +0800, Qiuxu Zhuo wrote:
> > When running the 'kfree_rcu_test' test case with commands [1] the call
> > trace [2] was thrown. This was because the kfree_scale_thread thread(s)
> > still run after unloading rcuscale and torture modules. Fix the call
> > trace by invoking kfree_scale_cleanup() when removing the rcuscale modu=
le.
>
> Good catch, thank you!
>
> > [1] modprobe torture
> >     modprobe rcuscale kfree_rcu_test=3D1
>
> Given that loading the rcuscale kernel module automatically pulls in
> the rcuscale kernel module, why the "modprobe torture"?  Is doing the
> modprobes separately like this necessary to reproduce this bug?
>
> If it reproduces without manually loading and unloading the "torture"
> kernel module, could you please update the commit log to show that
> smaller reproducer?
>
> >     // After some time
> >     rmmod rcuscale
> >     rmmod torture
> >
> > [2] BUG: unable to handle page fault for address: ffffffffc0601a87
> >     #PF: supervisor instruction fetch in kernel mode
> >     #PF: error_code(0x0010) - not-present page
> >     PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
> >     Oops: 0010 [#1] PREEMPT SMP NOPTI
[..]
> >     Call Trace:
> >      <TASK>
> >      ? kvfree_call_rcu+0xf0/0x3a0
> >      ? kthread+0xf3/0x120
> >      ? kthread_complete_and_exit+0x20/0x20
> >      ? ret_from_fork+0x1f/0x30
> >      </TASK>
> >     Modules linked in: rfkill sunrpc ... [last unloaded: torture]
> >     CR2: ffffffffc0601a87
> >     ---[ end trace 0000000000000000 ]---
> >
> > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > ---
> >  kernel/rcu/rcuscale.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 91fb5905a008..5e580cd08c58 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -522,6 +522,8 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *=
cur_ops, const char *tag)
> >                scale_type, tag, nrealreaders, nrealwriters, verbose, sh=
utdown);
> >  }
> >
> > +static void kfree_scale_cleanup(void);
> > +
>
> I do applaud minmimizing the size of the patch, but in this case could yo=
u
> please pull the kfree_scale_cleanup() function ahead of its first use?

The only trouble with moving the function like that is, the file is
mostly split across kfree and non-kfree functions. So moving a kfree
function to be among the non-kfree ones would look a bit weird.
Perhaps a better place for the function declaration could be a new
"rcuscale.h". But I am really Ok with Paul's suggestion as well.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>
>                                                         Thanx, Paul
>
> >  static void
> >  rcu_scale_cleanup(void)
> >  {
> > @@ -542,6 +544,11 @@ rcu_scale_cleanup(void)
> >       if (gp_exp && gp_async)
> >               SCALEOUT_ERRSTRING("No expedited async GPs, so went with =
async!");
> >
> > +     if (kfree_rcu_test) {
> > +             kfree_scale_cleanup();
> > +             return;
> > +     }
> > +
> >       if (torture_cleanup_begin())
> >               return;
> >       if (!cur_ops) {
> > --
> > 2.17.1
> >
