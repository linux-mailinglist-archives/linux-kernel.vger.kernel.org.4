Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD755EE919
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiI1WDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1WDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:03:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37917583
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:03:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s125so16938566oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tmCcbs8t+TQBW8BCIw+S4lYW0IEH6zSrzGu/chcwJpI=;
        b=ViN6DS2PE0rE7/ZFHW24Z2RMpqYNwXkvYbP6FGXPP1wK1uVPUX/gKiyHqt5uPEEeww
         rp6D8aLHWrI9CIuhmvFjwWlTzEgEQpFjrGULuOgMxe1w65ipmL1QgMSMi5vYUW5BM9ck
         rpl/6X42uGtBQpd4mWPjuMeuJ0Sgmk+PzVf2B1M57OqMHIuOyN94ZmMstzKlEpfFA+mX
         eWTQpWedYYdwJ3k31fMuSVAFmtnNJO7oZDguoqYkg7ea6zt2ug6SE1p5lBPfC/BvUo0c
         TJKcPzLRVjTnN1RW3mvZBOg2Sn5pP5nZe/vLNeLvQRmUHdqRgvhRgDA8nqzW5Mg9cT0Z
         3tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tmCcbs8t+TQBW8BCIw+S4lYW0IEH6zSrzGu/chcwJpI=;
        b=0u1o47GOKUF1SVKuHAkkXoI/pC1gQV0zavjqpa+4Y3sorRrID2OceHZLtjEii3PGf9
         frRAfCDL6dAdjdcGzN572UbyVFMT+FtmAGgEOqQl9oQ2hLdS3OrcFcZEP8pp5ESMSpVk
         pPYPwWHo2YAFsNUOic3xV4XrFCbo84QUhGInsdbMnqStuoqnyte3Br6tFLYv1C/EOWAG
         PKZ0XsrNhJWyNODhzL3h1Kao8QKlCFpkDbu4aNxFeBOWaPQRzho0DvkaFdWbAkPuiiQr
         a7hZ8gP9UXPixnLv9MWOOovsybFIuI62XeG+Bv909D3xuX+hzK0dE0YoboOR7OFrWbNZ
         /GJQ==
X-Gm-Message-State: ACrzQf0d9E1UOORkXs1OBu+b/bi7GCfKhFqclDt2t5kchDJBF7Xg+yse
        C9bQUALLC0czJ1HXPg/Zp+nOkNicA8jAS9WL1kK1
X-Google-Smtp-Source: AMsMyM7yraCRKe46aRwmI9LtrdinymR7eUbk9FXRY518o7VvX+F9EPUgAsWp7aY4T3LbWqtLiDYplu5zlOe9jziyOnQ=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr5507250oiv.51.1664402599405; Wed, 28
 Sep 2022 15:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com> <20220927225944.2254360-2-ankur.a.arora@oracle.com>
In-Reply-To: <20220927225944.2254360-2-ankur.a.arora@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 18:03:08 -0400
Message-ID: <CAHC9VhRZzU5-+65AFOK826rA0xo-nbgRK_pP05Q_zjvAQvLnRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 6:59 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> ctx->major contains the current syscall number. This is, of course, a
> constant for the duration of the syscall. Unfortunately, GCC's alias
> analysis cannot prove that it is not modified via a pointer in the
> audit_filter_syscall() loop, and so always loads it from memory.
>
> ...
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/auditsc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This looks pretty trivial to me, but it's too late in the current -rc
cycle for this to be merged, I'll queue it up for after the upcoming
merge window closes.  Thanks.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 79a5da1bc5bb..533b087c3c02 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -843,13 +843,14 @@ static void audit_filter_syscall(struct task_struct *tsk,
>  {
>         struct audit_entry *e;
>         enum audit_state state;
> +       unsigned long major = ctx->major;
>
>         if (auditd_test_task(tsk))
>                 return;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
> -               if (audit_in_mask(&e->rule, ctx->major) &&
> +               if (audit_in_mask(&e->rule, major) &&
>                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
>                                        &state, false)) {
>                         rcu_read_unlock();
> --
> 2.31.1

-- 
paul-moore.com
