Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2806E51DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDQU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDQU1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:27:53 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CD4216
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:27:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fbee98814so183156117b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681763270; x=1684355270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=603fxDNgME8lltID5rMAJWB1Mm6APJZHsFnhCBG8aPk=;
        b=TpC1Yp40ASMzRicb+mYwlYcdOXge/c6zxTt66I9F/TrkF1Nb5qc+5PXf6tZ4JwJLGt
         sPJ6ELltZNTucWg42/w1+480QGznbJTSKHtdcFhtqjT1Nx51KAtaRZ2Q3KAfdlnTqCaX
         TD58c2DoyXKs9wQj+tzbGpnFMun0JxUYGLfEMFm0y7VMd7W6OF1IO9/VIsTDeqN0NTJR
         ybaSNg1Mo+fQFzoGZnG13TAJBFW7/qTf17W11SOlbLExXK1CvTYOWDEEABQxjl0Ebs3t
         59IV5uX4woIO03S/kLyHxH97CAzCHl3IEjJAEuq5wNaSBKDIxKL/j3uERt5g4wCc2HA7
         y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763270; x=1684355270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=603fxDNgME8lltID5rMAJWB1Mm6APJZHsFnhCBG8aPk=;
        b=CrIbtM4cUAMPkA+MKuLSsDIz8FOVT39UF3AG1VjvnXy2Rk8YtLK0Jv6R+sDCUjx8dF
         WGjjM8fiMksCExMxbSizSw24zbEZp5FbepiZ7AQ3HNA6kKaK1IsgUf57nobjRqh7ebnE
         Cvuls8NqaC20+aqx5EBSYDa5wjkgqap7A39z4SVRY5cmblH/R1BBiwWRiuEOT+ung2nr
         NePwtzpope0NCddVeUuWYPAdsNz7XBD7Wy0j4fj5CNhEmZsyO/zznfmmeiSVw8psxEm1
         4Z9BG2oaxeLrOx0YONHjfBR+XOzGCynWdoakA4Vp8YARqv0howzckMK6gCD2gNjd4lht
         8oVw==
X-Gm-Message-State: AAQBX9cXvi/xL0jxC8FJImlVROaBwNL2lb2xVR1JH2pAt6G6r2GfFlDN
        6l9M9PMi9srVPdK/xSzziub/LjBU/mpXi2jZfevT
X-Google-Smtp-Source: AKy350YrsqLYcx0ksF4fyEYq6/LoWTcdjMTVb2/aVsuPGVhAikaasV2Qdj6tHUzjQKIU1g0pUalli+i4tN181CGCFVg=
X-Received: by 2002:a81:ed06:0:b0:54f:bf72:7fa6 with SMTP id
 k6-20020a81ed06000000b0054fbf727fa6mr10335523ywm.0.1681763269741; Mon, 17 Apr
 2023 13:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com> <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
In-Reply-To: <7FCAD214-5E79-4D07-A111-3657E91758B1@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Apr 2023 16:27:39 -0400
Message-ID: <CAHC9VhTRXwrKkXMFJNiVgZbV=ZHExHa2VhBo6DKPEKZ8xcS=iw@mail.gmail.com>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
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

On Mon, Apr 17, 2023 at 7:42=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On Apr 14, 2023, at 23:44, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Apr 13, 2023 at 11:14=E2=80=AFPM Eiichi Tsukata
> > <eiichi.tsukata@nutanix.com> wrote:
> >>
> >> auditd_test_task() is a hot path of system call auditing. This patch
> >> introduces a new bit field "is_auditd" in pid struct which can be used
> >> for faster check of registered audit daemon.
> >>
> >> Benchmark
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Run the following command:
> >>
> >>  dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
> >>
> >> With rule:
> >>
> >>  -a never,exit -F arch=3Db64 -S uname
> >>
> >> Result:
> >>
> >>  Base line    : 2.572 sec
> >>  /w this patch: 2.412 sec (6.6% faster)
> >>
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> include/linux/pid.h |  4 ++++
> >> kernel/audit.c      | 22 ++--------------------
> >> kernel/audit.h      |  3 ++-
> >> kernel/pid.c        |  3 +++
> >> 4 files changed, 11 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/include/linux/pid.h b/include/linux/pid.h
> >> index 343abf22092e..5fe38e254c9a 100644
> >> --- a/include/linux/pid.h
> >> +++ b/include/linux/pid.h
> >> @@ -68,6 +68,10 @@ struct pid
> >>        wait_queue_head_t wait_pidfd;
> >>        struct rcu_head rcu;
> >>        struct upid numbers[1];
> >> +#ifdef CONFIG_AUDIT
> >> +       /* registered audit daemon tgid */
> >> +       unsigned is_auditd:1;
> >> +#endif
> >> };
> >
> > Thank you for the patch, but I don't think we want to add an audit
> > specific field to the pid struct at this time.
> >
>
> Hi Paul
>
> I agree =E2=80=9Cis_auditd=E2=80=9D is too specific.
>
> How about having global =E2=80=9Cauditd_pid=E2=80=9D struct pid pointer a=
nd let auditd_test_task() use it?
> I mean:
> #define auditd_test_task(tsk) (READ_ONCE(auditd_pid) =3D=3D task_tgid(tsk=
))

At this point in time I prefer to keep the auditd pid in the
auditd_connection struct.

> By the way, it=E2=80=99s a bit different topic,  I may have found a race =
in usage of auditd_pid_vnr().
>  In AUDIT_SET handling, the variable auditd_pid is referenced outside of =
the spinlock so it can be changed while it=E2=80=99s referenced.
> So there is a TOCTOU race like this:
>
> CPU0                                        CPU1
> =3D=3D=3D=3D=3D                                       =3D=3D=3D=3D=3D
> auditd =3D auditd_pid_vnr()
>                                                   auditd =3D auditd_pid_v=
nr()
> if (auditd_pid) {=E2=80=A6}
>                                                   if (auditd_pid) {=E2=80=
=A6}
> auditd_set()
>                                                   auditd_set()
>
>
>
> If auditd_pid_vnr() returns 0, this case can lead to replacement of a hea=
lthy auditd, which seems to be prohibited judging from the code comment "/*=
 replacing a healthy auditd is not allowed */=E2=80=9C.
>
> Please correct me if I=E2=80=99m wrong.

Simultaneous AUDIT_SET operations are prevented by the
audit_cmd_mutex/audit_ctl_lock(), see audit_receive().

--=20
paul-moore.com
