Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D746A705E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCAP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCAP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:57:49 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C4367F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:57:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b10so14544594ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677686266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZY5EmaqD+P3EwReqCVyHwAW/VaGSUP/+XIGUbkZtms=;
        b=Gvv4zHlv94oBHWoM9u9axqXfB9byfnnU8jGTCTd2rOc519tknR7ersCYRyBHqQybud
         GTJR/3HkuRAqPaHjlQmJGN8lGBa00xveHOoh/RPtEUgIbPU6xGo3sMh9B0YHJuuRqv1+
         Wj2iCrUGBhvAPxR4cXNbxbMKeKZLakqSBVl74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677686266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZY5EmaqD+P3EwReqCVyHwAW/VaGSUP/+XIGUbkZtms=;
        b=izdUr4bfbHP1ry1PR0f/JU3GXi5SohNa30cr589p4inGPpXxD0nB1jILu8YjxI6uPt
         dvrauL2Ne7LB3KcP6HbeYIVJwYPy5K4SnWPklu9Amf2SQ7743Nb1V4wb9Jpqqs0jQFcZ
         4lx8xskYZnjCUqEeTWhh3jFsgp7te/WrER//DLqO/eFsZ+mHEyj+Xoj9ieH3RNs37aKt
         AgWfW/aCS8FwvrzdlhtE1BgZh6E87UGYvSJ9GRDpuSqjimrCZkm3IWtpgDws1f8al88g
         HTCConL4JJT/8VG6U+4ahLiDts2PoPIXnZwIYuuFGm80/qIr4lsTn/u5/QciOICG+axi
         st3Q==
X-Gm-Message-State: AO0yUKWBF/lnAwMNqAHNXqbjMYhY3oHmoTl2jJuAGBmHYdiytdNgbghq
        kIA646K4iMJGqjk5qzOURur5Yl4O5ifg5ATP8vwAjg==
X-Google-Smtp-Source: AK7set+PUT6fMy5JjsAgQSnvd2HKm/XJgvhhtyqHAlJpOdjtzWHJFpgnv1sPo1bRYNmhtPOd794aGqK9c4pLl3INt/Y=
X-Received: by 2002:a2e:a378:0:b0:295:a82e:ec06 with SMTP id
 i24-20020a2ea378000000b00295a82eec06mr2233608ljn.3.1677686266038; Wed, 01 Mar
 2023 07:57:46 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org> <IA1PR11MB617118DAE8D72E2419558D6689AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YQwu4ccqWLTfFSwcJQOH6fbhe4SiHHa4XPUCvefiBZi9g@mail.gmail.com> <IA1PR11MB61714E80960104FB04E3167989AD9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB61714E80960104FB04E3167989AD9@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Mar 2023 10:57:34 -0500
Message-ID: <CAEXW_YRe58jpu_WS3XLsvcEuLTGTRJzc5ErveaO5X093=_13Dg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 8:34=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Joel Fernandes <joel@joelfernandes.org>
> > Sent: Tuesday, February 28, 2023 10:27 PM
> > To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> > Cc: linux-kernel@vger.kernel.org; Frederic Weisbecker <frederic@kernel.=
org>;
> > Lai Jiangshan <jiangshanlai@gmail.com>; linux-doc@vger.kernel.org; Paul=
 E.
> > McKenney <paulmck@kernel.org>; rcu@vger.kernel.org
> > Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> > completed
> >
> > On Tue, Feb 28, 2023 at 1:40=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.c=
om> wrote:
> > >
> > [...]
> > > My testing showed the positive result that the OS boot time was
> > > reduced by ~4.6% on my side after applying Joel=E2=80=99s patch.
> >
> > Wow, this is great! I am guessing you have CONFIG_RCU_LAZY disabled,
> > when you tested. If so, that is great news that expediting RCU for a bi=
t longer
> > improves boot time! Please confirm that your config had LAZY disabled.
> >
>
> I confirm that CONFIG_RCU_LAZY kernel configuration was disabled in my te=
sting.
> All the kernel configurations for RCU used in my testing are as below:

Thank you! Good to know there is improvement in *existing code*,
that's the power of upstream... new features fix/improve old ones
sometimes.

Any case, I will include all your data in v3. Thanks!

 - Joel

>
>      #
>      # RCU Subsystem
>      #
>      CONFIG_TREE_RCU=3Dy
>      CONFIG_PREEMPT_RCU=3Dy
>      CONFIG_RCU_EXPERT=3Dy
>      CONFIG_SRCU=3Dy
>      CONFIG_TREE_SRCU=3Dy
>      CONFIG_TASKS_RCU_GENERIC=3Dy
>      # CONFIG_FORCE_TASKS_RCU is not set
>      CONFIG_TASKS_RCU=3Dy
>      # CONFIG_FORCE_TASKS_RUDE_RCU is not set
>      # CONFIG_FORCE_TASKS_TRACE_RCU is not set
>      CONFIG_TASKS_TRACE_RCU=3Dy
>      CONFIG_RCU_STALL_COMMON=3Dy
>      CONFIG_RCU_NEED_SEGCBLIST=3Dy
>      CONFIG_RCU_FANOUT=3D32
>      CONFIG_RCU_FANOUT_LEAF=3D16
>      # CONFIG_RCU_BOOST is not set
>      CONFIG_RCU_BOOT_END_DELAY=3D20000
>      CONFIG_RCU_NOCB_CPU=3Dy
>      # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
>      # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
>      # CONFIG_RCU_LAZY is not set
>      # end of RCU Subsystem
>
> -Qiuxu
