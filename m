Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739306A5ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjB1O1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjB1O1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:27:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F29630B23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:27:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h9so10459862ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAHdW0R4bB84/Yv1D1KskPGK8seaDNPN4i0lvIc9rYU=;
        b=DacTmKHtT5gE40GOYuFI7D4a8YIPu8S+Ow599Df9by4CQ5BRdHBvyt0nQUSRIeSb2t
         6KkwAQUuQFKa73+u7fMjGiBPj3HjVRGt9ZsBJU8SkQ9aAonlpfwGT1RQH51bTDRK9cRM
         AEX1sJuu42mM+X3ly+4jkuNjrKykcR9+EFUuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAHdW0R4bB84/Yv1D1KskPGK8seaDNPN4i0lvIc9rYU=;
        b=CVK34ZFQ4yjIPDPLh99EkhzZENltqupWvunP7vGbS4VIePPohE0sR15YSKGrk+fy4o
         Jmbxgxorp2AZYi5CWrNkcQDVS+QtvtAhfbQTp97uOto7TsI9Gu01M8sXKZmugFSMtHcN
         ARlrGs3W/hs99BIHBmXgKZozrt1lbyFVN2LkuseK74YroRlmRTNYy/37tt9+Ua7Hi3+V
         4OwvH7M99eXWOgT98Ly5GBHngXSTVd5YhpbGuh0hXTeG45stJjbawYwT6JV978nQckLi
         +ZSxo+o9e0qoz++z+HDI/i9l0gmnudvoBLKxvKxrl0ldCgCt08zMK7w0zcwPt7Alvmzi
         GmOA==
X-Gm-Message-State: AO0yUKVPKACR4zjUpQKmrZJhGoNP1ugEqd2bt8y/uDvqvFqFKUzBsywp
        H6oEUQ43AwZKdBSrgbmAJWUkLS+ga0clZyBVwZgKQA==
X-Google-Smtp-Source: AK7set8RWzXot28kcY8LaU3hLMJC0uJ6rGu9Tkc9ovqpMn1izF9y3NUPM6HM9WcSGA1oi7Sam5kJlLxEvYt1S7tqTJI=
X-Received: by 2002:a2e:508:0:b0:294:6de5:e642 with SMTP id
 8-20020a2e0508000000b002946de5e642mr870608ljf.3.1677594433251; Tue, 28 Feb
 2023 06:27:13 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org> <IA1PR11MB617118DAE8D72E2419558D6689AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB617118DAE8D72E2419558D6689AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 09:27:01 -0500
Message-ID: <CAEXW_YQwu4ccqWLTfFSwcJQOH6fbhe4SiHHa4XPUCvefiBZi9g@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:40=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
[...]
> > > If so, we might make rcupdate.boot_end_delay =3D 0 as the default val=
ue
> > > (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?
> >
> > Could you measure how much time your RT system takes to boot before the
> > application runs?
>
> I don't have a real-time OS environment to measure the OS boot time.
> I tried to measure the OS boot time of my "CentOS Stream 8" w/o and
> w/ Joel=E2=80=99s patch.
>
> My testing showed the positive result that the OS boot time was
> reduced by ~4.6% on my side after applying Joel=E2=80=99s patch.

Wow, this is great! I am guessing you have CONFIG_RCU_LAZY disabled,
when you tested. If so, that is great news that expediting RCU for a
bit longer improves boot time! Please confirm that your config had
LAZY disabled.

> For testing details, please see the below:
>
> 1) Testing environment:
>     OS            : CentOS Stream 8 (non-RT OS)
>     Kernel     : v6.2
>     Machine : Intel Cascade Lake server (2 sockets, each with 44 logical =
threads)
>     Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=3D2,sockets=3D2,=
 =E2=80=A6
>
> 2) My OS boot time definition:
>     The time from the start of the kernel boot to the shell command line
>     prompt is shown from the console. [ Different people may have
>     different OS boot time definitions. ]
>
> 3) My measurement method (very rough method):
>     A timer in the kernel periodically prints the boot time every 100ms.
>     As soon as the shell command line prompt is shown from the console,
>     we record the boot time printed by the timer, then the printed boot
>     time is the OS boot time.

Hmm, Can you not just print the boot time from userspace using
clock_gettime() and CLOCK_BOOTTIME? But yeah either way, good data!

>     The console log (mixed userspace and kernel logs) looked like this:
>
>            [  OK  ] Started Permit User Sessions.
>                         Starting Terminate Plymouth Boot Screen...
>                         Starting Hold until boot process finishes up...
>            [  OK  ] Started Command Scheduler.
>            [    6.824466] input: ImExPS/2 Generic Explorer ...
>            [    6.884685] Boot ms 6863
>                 ...
>            [    7.170920] Spectre V2 : WARNING: Unprivileged eBPF ...
>            [    7.173140] Spectre V2 : WARNING: Unprivileged eBPF ...
>            [    7.196741] Boot ms 7175
>                 ...
>            [    8.236757] Boot ms 8215
>
>            CentOS Stream 8
>            Kernel 6.2.0-rcu+ on an x86_64
>
>            login: [    8.340751] Boot ms 8319
>            [    8.444756] Boot ms 8423
>                 ...
>
>      Then the log "login: [    8.340751] Boot ms 8319" roughly showed the=
 OS boot time was ~8.3s.
>
> 4) Measured OS boot time (in seconds)
>    a) Measured 10 times w/o Joel's patch:
>         8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
>         The average OS boot time was: ~8.7s
>
>    b) Measure 10 times w/ Joel's patch:
>         8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
>         The average OS boot time was: ~8.3s.
>
> The OS boot time was reduced by : 8.7 =E2=80=93 8.3 =3D 0.4 second
> The reduction percentage was       : 0.4/8.7 * 100% =3D 4.6%
>
> If the testing above makes sense to you, please feel free to
> add
>
>       Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Yes, it makes sense. I will add these. Thanks!

 - Joel

>
> Thanks!
> -Qiuxu
>
> > I can change it to default 0 essentially NOOPing it, but I would rather=
 have a
> > saner default (10 seconds even), than having someone forget to tune thi=
s for
> > their system.
> >
> > Thanks,
> >
> >  - Joel
>
