Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA1706D97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjEQQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjEQQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:03:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D31173C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:03:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so1269973276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684339432; x=1686931432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLN4hR+vf8IV6dL3Yiybxphtk3K6xzfKOo/BEcKtKBw=;
        b=Yq9wGZwPNMMn7yE/Yf6dY6pidAcCw00N2b3QmZC4+PN9CqWT6VmtZzgyg1CNAnrgNp
         LAzlMPfReQpA12tjyEYpoTW9f3AqNuKdwlTpjc5QEO8m6TeH98PMHnfih1q/5APngpFb
         igUsbbGctuHXRZF+wpWQbZw9diz3Cab2JEvy8YkRL/Fs5Qh97lnkCvoDKKZ+moON6O6m
         MP4E84Et5yR3ZX780yrZ2fMflKsBZZSnCscNhFXdv7ZCF+2HslTC+B95mGFVLThW6mGW
         4rHGOSJDACw5BeIUr/LcqwuVKtGc4kIoIQEcpHl4QwmB0XtBEXtf+kq1dF8LfEqVHgMC
         IhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339432; x=1686931432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLN4hR+vf8IV6dL3Yiybxphtk3K6xzfKOo/BEcKtKBw=;
        b=ROD/yBrvdNmrBal2uhArmDTuDMlrTNQm+W7pjbVaMh8TOpwkrNCey5vW+8JC8vwY7n
         iUK0eVscbe7GBg3QJIP5XBM+sGVIszRYm6fkzF1ix+ZU4TuF7A6/pLJK134r9xhIO8ql
         PAa+hJ+ErgU6Ayz+8AbrdjysRY0kZXJX8Pb71H1imXQHtq8PHlmqDZPC+VinVBB6Il3F
         Hv5diZSJJ8MNdBl45kemSm67iH7h0CxmR4UrADt6s+73grvCmm9+VQuPdXD/rs06WLX7
         YbrP54OTZelFJmeJlYQlT91ZbwhxJriP7GvAFohJ8wWOADb1zqsIhaAAbl0loXoBQ3wI
         IfcA==
X-Gm-Message-State: AC+VfDz0bfHfSfK3BMYYDtFRHRDqJPV9jtxXPpjEnH59Ue/6fmFnZr2/
        vPAqnnCc4wvWj6VVEHCyYEFz3nWEFSYqe9lK0OBI
X-Google-Smtp-Source: ACHHUZ4+IsvnlJEX2APNGtVxoy8mXlTEJbRZACJCN1aFcwjRqrckilVZgTSgsbJNap+PfCiYLX0Zgk5BP8qfmOjvE/k=
X-Received: by 2002:a25:31c2:0:b0:ba8:1d2a:8096 with SMTP id
 x185-20020a2531c2000000b00ba81d2a8096mr4859580ybx.31.1684339432131; Wed, 17
 May 2023 09:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com> <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
In-Reply-To: <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 May 2023 12:03:41 -0400
Message-ID: <CAHC9VhQg6aF_MKgkfY5RxgBgfVpUrU=xOTHenob++nmW5=aWug@mail.gmail.com>
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

On Mon, May 8, 2023 at 9:49=E2=80=AFPM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 8, 2023, at 23:07, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, May 8, 2023 at 3:58=E2=80=AFAM Eiichi Tsukata
> > <eiichi.tsukata@nutanix.com> wrote:
> >> Commit 7ffb8e317bae ("audit: we don't need to
> >> __set_current_state(TASK_RUNNING)") accidentally moved queue full chec=
k
> >> before add_wait_queue_exclusive() which introduced the following race:
> >>
> >>    CPU1                           CPU2
> >>  =3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=3D=3D=3D=
=3D
> >>  (in audit_log_start())         (in kauditd_thread())
> >>
> >>  queue is full
> >>                                 wake_up(&audit_backlog_wait)
> >>                                 wait_event_freezable()
> >>  add_wait_queue_exclusive()
> >>  ...
> >>  schedule_timeout()
> >>
> >> Once this happens, both audit_log_start() and kauditd_thread() can cau=
se
> >> deadlock for up to backlog_wait_time waiting for each other. To preven=
t
> >> the race, this patch adds queue full check after
> >> prepare_to_wait_exclusive().
> >
> > Have you seen this occur in practice?
>
> Yes, we hit this issue multiple times, though it=E2=80=99s pretty rare as=
 you are mentioning.
> In our case, sshd got stuck in audit_log_user_message(), which caused SSH=
 connection
> timeout.

Sorry for the delay, I was away at a conference last week.

Regardless of how we tweak the wait, there is always going to be a
chance that rescheduling the task with a timeout is going to impact
the application.  If you have sensitive applications where this is
proving to be a problem I would suggest tuning your backlog size, the
wait time, or removing the backlog limit entirely.

--
paul-moore.com
