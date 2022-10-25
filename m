Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA660CAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiJYLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiJYLTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:19:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABF1217F4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:19:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l28so7242004qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOEv+spg1vFxsgLP+Brkgpa4VWCFOV4NiNl/t5XRFeU=;
        b=xbKz4RXc7hITxZLV5zki1DRdTSN0MwWgeFqRqblQ/IC4NzR9WeGwjQ+dxwhkIWTMLM
         F0t//xKeOjFrx/CHRlLc0FHX42lVXad3vqdZiyqzL8fewRljG8p3Iz0YviTLqUha/1fg
         dVCcGUwJ/q1Zgi5A0/TG4gkhu1o/5CSLJq7Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOEv+spg1vFxsgLP+Brkgpa4VWCFOV4NiNl/t5XRFeU=;
        b=i164hTx9Kz/BHdEqxTuja5nMy7cSiuGB7N0FeWFS9ZAifzDqrCuatHytY3aEnKMeCV
         oJ1mpxv+jRI+0XuDhH+72ny25Y7K+sPu+L1a0grVy1zuLik2l99cKo0PWIURzB9dyTxT
         RoTM8/w391tClkmh6N1Hm0XxNrVr7YjbnJRiqZMdCgTD9PCOERSy9NOYH4mfEnN0f85l
         e0oOy3r+JzZtuc6WJGMMyJgr7+O6nlAXJvlGV7BxKiRZfiOioVE/oVi46SBNZC9lrJKt
         EvGTVztgeGyQxn8vZj8CuyWPvjjqAWSDmZZUwLP5Ufge0P/fBeti0LHbvyIZ/7aRuZIb
         AD2w==
X-Gm-Message-State: ACrzQf1zAR6DIWc5lN5nmxSH/Q7KwCZvty+WxKysddK2d+eBjac01Y4I
        4MgsQ7HGbio5XBfkz4tQyuSqMQ==
X-Google-Smtp-Source: AMsMyM5/co3sXBmnQXmliFUD4AwxdbigeNhnHiGScaCaLcD6QELJZZoJHJ988ub9fN03hGD1aw6Atw==
X-Received: by 2002:ac8:4e4d:0:b0:39c:e229:7172 with SMTP id e13-20020ac84e4d000000b0039ce2297172mr30548177qtw.129.1666696777194;
        Tue, 25 Oct 2022 04:19:37 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006ed61f18651sm1855390qka.16.2022.10.25.04.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 04:19:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Date:   Tue, 25 Oct 2022 07:19:35 -0400
Message-Id: <7BBED338-D158-401B-8A6B-FDBD9FC03973@joelfernandes.org>
References: <20221024223324.2jgwrmnqxpgw2m67@airbuntu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
In-Reply-To: <20221024223324.2jgwrmnqxpgw2m67@airbuntu>
To:     Qais Yousef <qyousef@layalina.io>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 24, 2022, at 6:33 PM, Qais Yousef <qyousef@layalina.io> wrote:
>=20
> =EF=BB=BFOn 10/17/22 09:26, Peter Zijlstra wrote:
>=20
>> Additionally, the highest priotiy waiter will get the lock next.
>=20
> True for RT. But for CFS, priority is share and there will be no guarantee=
 the
> 'highest priority' task will run as soon as the lock is released to grab i=
t,
> no?

But the mutex lock owner should have done a wake_up in the mutex unlock path=
, which is arranged in FIFO order, if I am not mistaken. Subsequently the sc=
heduler will at least get a chance to see if the thing that is waiting for t=
he lock is of higher priority, at the next preemption point.

If it did not get to run, I don=E2=80=99t think that=E2=80=99s an issue =E2=80=
=94 it was not highest priority as far as the scheduler is concerned. No?

Steve was teaching me some of this code recently, he could chime in :)

> For example I can envisage:
>=20
>    +--------+----------------+--------+--------
>    |  p0    |       p1       |   p0   |   p1
>    +--------+----------------+--------+--------
>              ^  ^                 ^      ^ ^
>          |  |                 |      | |=20
>              |  |                 |      | Fails to hold the lock
>      holds lock        releases lock | and proxy execs for p0 again
>             |                        |
>         |                        |
>         tries to hold lock         holds lock again
>         proxy execs for p0
>=20
> The notion of priority in CFS as it stands doesn't help in providing any
> guarantees in who will be able to hold the lock next. I haven't looked at t=
he
> patches closely, so this might be handled already. I think the situation w=
ill
> be worse if there're more tasks contending for the lock. Priority will
> influences the chances, but the end result who holds the lock next is
> effectively random, AFAICT.

The wake up during unlock is FIFO order of waiters though. So that=E2=80=99s=
 deterministic.

> I had a conversation once with an app developer who came from iOS world an=
d
> they were confused why their higher priority task is not preempting the lo=
wer
> priority one when they ported it to Android.
>=20
> I wonder sometimes if we need to introduce a true notion of priority for C=
FS.
> I don't see why an app developer who would like to create 3 tasks and give=
 them
> strict priority order relative to each others can't do that. At the moment=
 they
> have little option in controlling execution order.

I want to talk more about this with you, I am actually working on something s=
imilar. Let=E2=80=99s talk ;)

Thanks,

- Joel


>=20
> Actually I think we need two types of priorities:
>=20
>    * global priorities for a sys admin to say which apps are more
>      important to run over other apps. Or fairly share it if
>      equal priority.
>    * local priorities for an app to control which of its tasks are more
>      important to run over other tasks it owns.
>=20
> The concept of share doesn't allow controlling execution order - and force=
s us
> to look at things like latency_nice to, somewhat, overcome this limitation=
.
>=20
>=20
> Thanks
>=20
> --
> Qais Yousef
