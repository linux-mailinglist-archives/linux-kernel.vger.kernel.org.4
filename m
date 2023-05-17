Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E609706DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEQQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:15:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AC7D95
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:15:49 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9daef8681fso776219276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684340148; x=1686932148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2gTXSn/sAnthj8EUBok/oEwRWKIACHKkdx5w+oZf38=;
        b=KGzvb2XcE+FirmiMSpp/vp6AWRNr1FeUSwCsGDqaUMRxJxOeJBBhSlYZZvSKKyYlwG
         7l72AyR3KO3DHfLJDodJziZ6YBRlykQwovxGfJSdfk8bGUYEaQCph2bcojMTQxSn7Q3X
         ri/aAgxjyKDKtyJiVCSFrE+ffOn/pTtWdlRenk5WomZDGX7ntS4/kFwp3PCpIIdy3tO9
         ykfk91Diqyo2IT2WJFhPJZV1kbU1duXIYAqvzTAoWZgm5q6eEcm0yNf2Jpb7uWtCxMl0
         LcnNh3NRzNNCAaM8AOLpehOxfuSv1jd4ayDnlli2WCjTcVMDC+XOTKdDAX7gEox0AiTz
         iwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340148; x=1686932148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2gTXSn/sAnthj8EUBok/oEwRWKIACHKkdx5w+oZf38=;
        b=VCaUYydKSOWlTvaxhsRb8M2I4l1a9PHMEd1mnBldT8cjBIe22/IDiYG/5M7swuaX0p
         X1LwWpGKk6tIsJYIUkfalNXd5dnZTFevI+1Qam59fmuL9k2NPjs5lGseWLyM9ttP49kz
         qPdSTG2NbooFQmKDra+3j4z3ra6wE/iFvl3f4LfAzyCNG6wvfm/hH7nbGpbz3+9KV0+w
         Q2cMqgRLpaDu/VgMnK4y0KX1c3eG66fkcPQ2rsEhrRWbTlL8CkeDKL5aMG2F8RQs7HUT
         G8OWsw89qaauT2dQ4lF+piabU2K6ROfiml40W6IMRe1wGvHXbvHwoVSbjEDlZf/pUKNC
         bsxg==
X-Gm-Message-State: AC+VfDwdQL6QCJxMrHSbyZMlQZzCUHzjFGA8B7gbRB8QjCYFZatZ54cF
        +xk1EjmEcPT6hxNR6rxcxPNsnDsWLlbNKzByQoyU
X-Google-Smtp-Source: ACHHUZ4vchZXSbTft1q/2C4BAt6gORgMwx3UreEKp/lmtXV2I1uZyGLf6YwDsfxQS/6X97rK+704mh/1I2bmAQDPLiM=
X-Received: by 2002:a0d:ca8b:0:b0:561:1de8:26cc with SMTP id
 m133-20020a0dca8b000000b005611de826ccmr14903444ywd.30.1684340148288; Wed, 17
 May 2023 09:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com>
 <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com> <0BA588DC-1E53-4BCE-B124-77C5C730C267@nutanix.com>
In-Reply-To: <0BA588DC-1E53-4BCE-B124-77C5C730C267@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 May 2023 12:15:37 -0400
Message-ID: <CAHC9VhQaWvgwHGVv==FTdoEZhSqak02ijR7vt4h2pBU5Xs7-2A@mail.gmail.com>
Subject: Re: [PATCH 0/4] audit: refactor and fix for potential deadlock
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 4:09=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 9, 2023, at 10:34, Eiichi Tsukata <eiichi.tsukata@nutanix.com> w=
rote:
> >> On May 8, 2023, at 23:07, Paul Moore <paul@paul-moore.com> wrote:
> >> On Mon, May 8, 2023 at 3:58=E2=80=AFAM Eiichi Tsukata
> >> <eiichi.tsukata@nutanix.com> wrote:
> >>> Commit 7ffb8e317bae ("audit: we don't need to
> >>> __set_current_state(TASK_RUNNING)") accidentally moved queue full che=
ck
> >>> before add_wait_queue_exclusive() which introduced the following race=
:
> >>>
> >>>   CPU1                           CPU2
> >>> =3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> (in audit_log_start())         (in kauditd_thread())
> >>>
> >>> queue is full
> >>>                                wake_up(&audit_backlog_wait)
> >>>                                wait_event_freezable()
> >>> add_wait_queue_exclusive()
> >>> ...
> >>> schedule_timeout()
> >>>
> >>> Once this happens, both audit_log_start() and kauditd_thread() can ca=
use
> >>> deadlock for up to backlog_wait_time waiting for each other. To preve=
nt
> >>> the race, this patch adds queue full check after
> >>> prepare_to_wait_exclusive().
> >>
> >> Have you seen this occur in practice?
> >
> > Yes, we hit this issue multiple times, though it=E2=80=99s pretty rare =
as you are mentioning.
> > In our case, sshd got stuck in audit_log_user_message(), which caused S=
SH connection
> > timeout.
> >
>
> I found another case.
>
> kauditd_thread issues wake_up(&audit_backlog_wait) once after wake up.
> As waiter side is using add_wait_queue_exclusive() it only wakes up one p=
rocess at once.
>
> If kauditd wakes up a process which is sleeping in audit_log_start(), the=
n the process will
> queue skb and issue wake_up_interruptible(&kauditd_wait). No problem.
> But if kauditd wakes up a process which is sleeping in audit_receive(), t=
hen the process
> won=E2=80=99t try to wake up kauditd. In this case other processes sleepi=
ng in audit_log_start()
> keep sleeping even if kauditd have flushed the queue.
>
> At this point I=E2=80=99m planning to use non-exclusive wait in audit_rec=
eive() in v2.
> Let me know if we should use wake_up_all() in kauditd or you have better =
solution.

The nice part about marking the waiters as WQ_FLAG_EXCLUSIVE is that
we avoid the thundering herd problem.  The waiter was held in the
first place because the system was under high levels of audit
pressure, so it stands to reason that a slow wake-up of the waiters is
a wise choice to avoid re-entering another audit pressure state.

I'll take a look at your v2 patch, but as things stand I still believe
that this is better addressed via runtime configuration (see my
previous email).  However, some of the refactoring you've done might
be nice, I'll reply back on that in your v2 patch.

Thanks.

--=20
paul-moore.com
