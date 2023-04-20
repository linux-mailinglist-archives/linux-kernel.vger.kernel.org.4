Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F76E9970
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDTQXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjDTQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:23:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DEB1BFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:23:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a9290a6f96so153895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682007786; x=1684599786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks1pj/8VEbhe1cDxED1IfhUi5j9EFf/8larL9jb+Yu0=;
        b=NN/vZs/zkWFh62Q8qiR0pKgIuQ3kxw/NBTdO0DHUcPYdfAM0NvmP1lf/TWJZ33YaSh
         r7bYjYPp+d1Z1ekPWdh3zcNgTeEI3BRYSjSjNeIey6NyJE4HCbpNZGz0sVu/pskNxoFy
         DvD19Y0FcR3IIB264LTl4dVMO2aGgJssTdZln+HA70hADRMBngfHgywNWg0bDFMIbEm5
         szitXZSETCsjXEQgwqecX+0TXkIF41F0WEIiPLkRaa3tzTaptoTV0wGg3tkLH6ET2pNu
         hPEZAYwVCEyweYiLFf0xqT7UDHRn87IsDEH1Ww1G1tEkVjmQqtj8PtQatVj5ltD+Ltj1
         BDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007786; x=1684599786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks1pj/8VEbhe1cDxED1IfhUi5j9EFf/8larL9jb+Yu0=;
        b=ibA2gTmTysL/XDOF0vHduT1sKjgexbJhsyI6L2GIlMD28/YokyDsOOJFbu9bWgEiHw
         9npMQJQ6UxW6+caPFgrfaBcXviIFsw0r4EznByyTOdpFjg2rei2tweuH3sxb/aqEfqGE
         6qq95NlqxQtVV+MaP0fLaFfF3hapT8Yz6lgbTyPjG/CJ1BJXsrKn6aOqlmWoInvDGEqH
         ebrJuNEIcJTaw9SiT1jJJwETV8lrstoZfNFADomB7VwFvaO4bW/32SrbDx5H//EmVD+O
         oXMc6cscihO/TMI9oWKiwaut2UFVAWqlqOMyyb/+xMcDCmm0nQt0s4ff6lR1GQHtggZn
         4vyA==
X-Gm-Message-State: AAQBX9eVx8nQvFR1mL8ZMX5UATF0h8LIBJnswOpRWT98j/mSX6ECOnwE
        WXGuXnCVA0F4o0+ObwAYfTahG0mTM7MVfUfS8D25tw==
X-Google-Smtp-Source: AKy350bghINCvW24JqQLKQpbapa1G/OxuUoCO3z4/qjrZH4gB3rVgn9UpQYjwlT+CGt0VTJqjwUbk9GH4hgG6O19LBg=
X-Received: by 2002:a17:902:9a42:b0:1a1:e93c:8932 with SMTP id
 x2-20020a1709029a4200b001a1e93c8932mr252612plv.15.1682007786361; Thu, 20 Apr
 2023 09:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com> <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
In-Reply-To: <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Apr 2023 09:22:27 -0700
Message-ID: <CAGETcx9RGnW_Bq49yVogFo3Eys4UczmXP-6bkZh1q=u+M-_bDg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 2:37=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 20/04/2023 03:11, David Dai wrote:
> > On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >
> > Hi Dietmar, thanks for your time,
> >
> >> On 16/04/2023 23:34, David Dai wrote:
> >>> A userspace service may manage uclamp dynamically for individual task=
s and
> >>> a child task will unintentionally inherit a pesudo-random uclamp sett=
ing.
> >>> This could result in the child task being stuck with a static uclamp =
value
> >>
> >> Could you explain this with a little bit more detail? Why isn't the
> >> child task also managed by the userspace service?
> >
> > See Qais=E2=80=99 reply that contains more detail on how it=E2=80=99s b=
eing used in
> > Android. In general, if a dynamic userspace service will adjust uclamp
> > on the fly for a given task, but has no knowledge or control over if
> > or when a task forks. Depending on the timing of the fork, a child
> > task may inherit a very large or a small uclamp_min or uclamp_max
> > value. The intent of this patch is to provide more flexibility to the
> > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > value when spawned while retaining other sched attributes. When
> > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > for the child but also reset other sched attributes as well.
>
> OK, in this case, why not just change behavior and always reset the
> uclamp values at fork?

Personally, I'd have preferred uclamp was never inherited in the first
place, but wouldn't that be considered as breaking UAPI if we change
it now?

-Saravana

> Do we anticipate a use-case in which uclamp inheritance would be required=
?
>
> Let's not over-complicate the sched_[sg]etattr() unnecessarily.
>
> [...]
>
> >> Does this issue happen with uclamp mainline or only with Android's
> >> slightly different version (max- vs. sum aggregation)?
> >
> > I=E2=80=99m using the version of uclamp that=E2=80=99s in Linus=E2=80=
=99 tree. How uclamp is
> > aggregated is unrelated to the problem I=E2=80=99m trying to solve with=
 this
> > patch. Which is to extend the uclamp APIs to have finer control for
> > the uclamp inheritance of child tasks.
>
> OK, I see.
