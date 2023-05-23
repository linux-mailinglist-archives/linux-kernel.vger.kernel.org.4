Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43A270E627
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjEWT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEWT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:59:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA6119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:59:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-babb985f9c8so245840276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684871976; x=1687463976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A9E/lFsHSoXd0TYmZVOZifWBVMDrn+AB/7RYG+MO10=;
        b=CLh9gM+G7Anu7sJNmkM9xvDL/7YOECCXZprPxk+mZH3IlmRCbmGvH5mhByNqc3hbLj
         JuL+T56BUPwZMlRu4Q8BRtqLRsMvIoqkrxmojLQQ78LIIaw5TzN7jdKJuvREorfWSWmu
         uQVCz0k5Dz3axCIPouIMB5jN5zYyM7xBFHEPdXgxunDFmQshA3BQGv8u4O/mxRI2D4Fh
         dcyVvKM2TbpogRaKxGqhEYCOdPpiGbXHFKeSpzHTa20JqAF79GmsW1u9pmXu9rpLWyD/
         7D2NYI8cuKgFWFY1BjqnUohTvXcPF92ASun1dfgAxxtxOSwwE5UCMMo92YjRb2G2XPMZ
         6Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684871976; x=1687463976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A9E/lFsHSoXd0TYmZVOZifWBVMDrn+AB/7RYG+MO10=;
        b=VQcxj8ps5g0dZf3EJ8RHo3rvKSCtLHPMdKQHRjh3xrNWRIQqln2C/zFSu1QtYlkIuk
         0TyhJ7I+WY3wJpRySJCCTLI236ZLmElf0m2zF3tWrTt/1aSgU7iGFTK1J59G+weP5WCa
         MpwmBzHIxIDtcUW+L8SzFam7lh7hg/92bN+UAzCW+yFephrBVgYMkwlH2K881mYNL22J
         py0DJR7IcXUabHZ4PRI2ldjHiQRJQmtkjySm3p/4nbtuIu37R0ieOyPc8RBy+7mXugem
         Vajay2pvAUPIGyvEs+Ul0zr/BxwX4DvhPNXCviAaQd7rNQ81epvZJ45Ci1YttFJIaqk5
         gl5Q==
X-Gm-Message-State: AC+VfDyJQ9ftbHRSRdW0ivoMbM/BBxUlP3kUHnQWjCSYux56N84fXIaA
        GI7dzctsaPNy01+pzOTEQYof9MY+l3Z+O5jbGO6A39oTfqcvsPk=
X-Google-Smtp-Source: ACHHUZ5h/ZlcrlWTS35TM9lu45ATTZMgbsg/MVk4LRK3qrVhCgtbqp2Xz86V9brUNzENhxyNmctjTOetXH26GDJKUXU=
X-Received: by 2002:a25:6801:0:b0:b9d:9500:9d29 with SMTP id
 d1-20020a256801000000b00b9d95009d29mr15481840ybc.45.1684871976527; Tue, 23
 May 2023 12:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com>
In-Reply-To: <20230523181624.19932-1-ivan@cloudflare.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 15:59:25 -0400
Message-ID: <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
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

On Tue, May 23, 2023 at 2:16=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> Currently audit subsystem arms itself as long as there are rules present,
> which means that on every syscall exit all rules are evaluated, even
> if they don't match the syscall to begin with. For setups where
> there are no rules that can match any syscall, this means that
> the CPU price needs to be paid when it's not necessary.
>
> This patch introduces a bitmap for syscalls that is maintained
> when rules are inserted and removed. For every syscall we maintain
> a bit indicating whether it needs to be audited at all, which is then
> checked at syscall entry. If the are no rules matching a syscall,
> extra cost of checking all the rules is avoided.
>
> Consider the following set of 10 audit rules as a benchmark:
>
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/0 -F key=3DBENCH0
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/1 -F key=3DBENCH1
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/2 -F key=3DBENCH2
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/3 -F key=3DBENCH3
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/4 -F key=3DBENCH4
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/5 -F key=3DBENCH5
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/6 -F key=3DBENCH6
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/7 -F key=3DBENCH7
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/8 -F key=3DBENCH8
>     -a always,exit -F arch=3Db64 -S unlinkat,linkat,renameat,openat,renam=
eat2 -F perm=3Dwa -F dir=3D/tmp/audit-bench/9 -F key=3DBENCH9
>
> We can use the following benchmark to run unrelated syscalls:
>
>     #include <sys/stat.h>
>     #include <unistd.h>
>     #include <stdio.h>
>
>     #define GETPID_COUNT 100 * 1000
>     #define STAT_COUNT 100 * 1000
>
>     pid_t bench_getpid()
>     {
>         pid_t pid;
>
>         for (int i =3D 0; i < GETPID_COUNT; i++)
>         {
>             pid =3D getpid();
>         }
>
>         return pid;
>     }
>
>     struct stat bench_stat()
>     {
>         struct stat statbuf;
>
>         for (int i =3D 0; i < STAT_COUNT; i++)
>         {
>             stat("/etc/passwd", &statbuf);
>         }
>
>         return statbuf;
>     }
>
>     int main()
>     {
>         pid_t pid =3D bench_getpid();
>         struct stat statbuf =3D bench_stat();
>
>         printf("pid =3D %d, size =3D %d\n", pid, statbuf.st_size);
>     }
>
> Here we run 100k `getpid()` calls and 100k `stat()` calls, which are not
> covered by any of the audit rules installed on the system.
>
> When running without any rules present, but with auditd running, flamegra=
phs
> show ~5% of CPU time spent in audit_* code. If we install the rules menti=
oned
> above, this number jumps to ~24%. With this patch applied, the number is =
once
> again down to 5%, which is what one would expect.

Before seriously considering something like this, I would really like
to see some time put into profiling the original overhead and some
designs on how that could be improved.  Without that, patches like
this look like drive-by band-aids which have already caused enough
headaches for audit maintenance.

> There's extra cost of maintaining the bitmap when rules are changed,
> but it's negligible compared to CPU savings from cheaper syscalls.
>
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  include/linux/audit.h | 21 +++++++++++++++++++++
>  kernel/auditfilter.c  | 32 ++++++++++++++++++++++++++++----
>  kernel/auditsc.c      | 27 +++++++++++----------------
>  3 files changed, 60 insertions(+), 20 deletions(-)

--=20
paul-moore.com
