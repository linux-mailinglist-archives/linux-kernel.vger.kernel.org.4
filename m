Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5E6B50B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCJTKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCJTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:10:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742B5F6F8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:10:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az36so4127261wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678475406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUHbwYiner6YWWsz85bbEgaPM/h3afo2jYmrpleK+vE=;
        b=rZ8J35Zy4a5UNeiY0zKCgGpGCDSqJvpCJBHyr2aL0aNWu2LVnruvhIiZvRPwj43RA7
         pVOYlwrDYASf3v7G5oIYZrvNXkqELixFJVAFqaHW5/cq4e3Lqc6cuQMptJL5/n9jimSf
         TbpnVYHlHNYsfnS1pzkrNHp3f27uB/YOniDwlLkWd5iCWmhxO+XuDzdYYM/gL3GPXlE2
         8WZo21fE1fFXugrmhhZth3eDSF9twfYBkTwupNQ3WCiAEVMZI42hq7u6GrpCRPUVJk4i
         RPsb5i+QjMyf4AM7NKx0YZHwm/bcT+Itn/ZNJsK0MJGFiRhN5W3nkljaV5ViavA4Ortk
         TDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUHbwYiner6YWWsz85bbEgaPM/h3afo2jYmrpleK+vE=;
        b=uHQv9JEA+Pn2F08uOx61jhz7p5FPJCA2eC3gkwW7rCBpF9OihQzFb5P0MO5scCDweH
         PwTa6sqSVryf6A0/ycP+QLU+nR7zfpylBb6FJBLM+uiyyQhRmOHFrFHzxyUI5WoT4aDz
         tswmQc17DBWzdz8KVUjsM3y4oPg64qExkB6YCWJE8vsH965oIIsfd+GQXypJFlDDdLX6
         Hwl3wdp89ur+CqRpw109c3cQCRmLDRT+7gb9otgJP1+Vzi68qYJ611ANS0pWAqhB0/Ij
         2yTRwXmRTKVmahLArQGHX9OPkwGLXZ2hblFllf5mhp+W+3fUy1CsdclviI4C27mHjukS
         c2Mg==
X-Gm-Message-State: AO0yUKW3bKXO4mEp7pL+nnDyPh5/c6JB+ryCg1UNBYdjZ23oqxiLOYSq
        eoQ302pwPZVDoSu/l68nEgq0xgcjbnKG8KFSUHpBtuN23pSc9HoFyWNvZw==
X-Google-Smtp-Source: AK7set9gS2QTGUszwInb5cwaSN89LsS0pyJZW7wVQdRjjaK2gGc6BDOXQq285jV3s5OSsm0S1MCyovF3RiLpgKIv8co=
X-Received: by 2002:a7b:c2b1:0:b0:3eb:5824:f0ee with SMTP id
 c17-20020a7bc2b1000000b003eb5824f0eemr1146298wmk.2.1678475406234; Fri, 10 Mar
 2023 11:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20230309213742.572091-1-nhuck@google.com> <ZAq8Ey8CZ5I2xcpW@sol.localdomain>
 <20230310065511.2390-1-hdanton@sina.com>
In-Reply-To: <20230310065511.2390-1-hdanton@sina.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Fri, 10 Mar 2023 11:09:55 -0800
Message-ID: <CAJkfWY6xWhcwfV-E5brz_qvW0v-ebqp8wYhgg_ZWyD9cUp-EJg@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Remove WQ_UNBOUND from fsverity read workqueue
To:     Hillf Danton <hdanton@sina.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:01=E2=80=AFAM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On 9 Mar 2023 21:11:47 -0800 Eric Biggers <ebiggers@kernel.org>
> > On Thu, Mar 09, 2023 at 01:37:41PM -0800, Nathan Huckleberry wrote:
> > > WQ_UNBOUND causes significant scheduler latency on ARM64/Android.  Th=
is
> > > is problematic for latency sensitive workloads like I/O post-processi=
ng.
> > >
> > > Removing WQ_UNBOUND gives a 96% reduction in fsverity workqueue relat=
ed
> > > scheduler latency and improves app cold startup times by ~30ms.
> >
> > Maybe mention that WQ_UNBOUND was recently removed from the dm-verity w=
orkqueue
> > too, for the same reason?
> >
> > I'm still amazed that it's such a big improvement!  I don't really need=
 it to
> > apply this patch, but it would be very interesting to know exactly why =
the
> > latency is so bad with WQ_UNBOUND.

My current guess for the root cause is excessing saving/restoring of
the FPSIMD state.

> >
> > > This code was tested by running Android app startup benchmarks and
> > > measuring how long the fsverity workqueue spent in the ready queue.
> > >
> > > Before
> > > Total workqueue scheduler latency: 553800us
> > > After
> > > Total workqueue scheduler latency: 18962us
>
> Given the gap between data above and the 15253 us in diagram[1], and
> the SHA instructions[2], could you specify a bit on your test?

The test I'm running opens the Android messaging APK which is
validated with fsverity. It opens the messaging app 25 times, dropping
caches each time. The benchmark produces a Perfetto trace which we use
to compute the scheduler latency. We sum up the amount of time that
each fsverity worker spent in the ready state. The test in [1] is
similar, but may be using a different APK. These tests are not in
AOSP, so I can't share a link to them, but I would expect that fio on
a ramdisk would produce similarly good results.

>
> [1] https://lore.kernel.org/linux-erofs/20230106073502.4017276-1-dhavale@=
google.com/
> [2] https://lore.kernel.org/lkml/CAJkfWY490-m6wNubkxiTPsW59sfsQs37Wey279L=
miRxKt7aQYg@mail.gmail.com/
