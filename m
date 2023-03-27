Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3136C99CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjC0DBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC0DA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:00:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267F4EDA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:00:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g7so4611402pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679886056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZhjRQbh8R5ex59fuxEu46LK4T0oGCZgeorkpSIsHq8=;
        b=lIVQKxNC+VU35e5A3LBOAyepUzx23aW+fpoSQR93DMNuDQqHyJx/N9J3omcLivxq9J
         YZXFhiWZfvKTbG5OO5DNO/MHZMUCe1SXH8oJYFLiE7F10Xep1EeTiZjMoEBWku2CA3EB
         4DoWfNQA3PmsQfCG4VTRwt9rlIcIskZTmwGhJKBaSIeHkFnOyU7R6pK1ndEaKw9GgLRO
         LrZmISWGnnRsJnxPmXqhqlObgMVNriil742jpugYJfHXB6zuNzGleOpM/i0bOpTC/nRI
         JzsnC0FqpPBpZ3L1QCvSUbPfRSIPgRZwE69XIgJmw4eh6cxwqAZxrMq38hAzOFo0ZbXz
         mCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679886056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZhjRQbh8R5ex59fuxEu46LK4T0oGCZgeorkpSIsHq8=;
        b=v7pqHULBeQ3dr6ti5rHzkeDMw+sKUE5EA+DpHc1e3XT4Js5YNwOr/S6TWi+WFALEj3
         VOyzH8Dn4eIPEqFOREwSmA4AJ2dMDmm84iI7noBdlcHnLr5N7Mbc1fzci94/LSVMwlWj
         BiUh+yOqtyFqHc8pbdzX1cziZEQpgLrd6WFBvvU1fgdzICMFEgwC0ypIFn1Wa/6WRu5/
         +k4GY6mK69zQy246dMoOpXuqrUaX57BdjntJo8uMgcgIAWWf+x+Tf0kWhAEDlXFySQ9n
         dOngTJUA6JKG1Vrgsu0pVAYQBX3lo/6/2SDefdbhsoRfaHPe7bDinw8JqoF1KbkIvE0G
         8I9Q==
X-Gm-Message-State: AAQBX9e7gHPJT/3sOwtkRImRS1RUDmmOeHA68Q0hfUFlLTNuyNf0tB4j
        KUaAJDrLnqUYWJkv59CfWsg=
X-Google-Smtp-Source: AKy350ZD/JAnRFP7zvPqBqQ0kOuUK8glvmqXyPWWuj0w/cPP4+1O3GSWqxrTzIxDG59kqzSzBDYPTw==
X-Received: by 2002:a62:1cc8:0:b0:625:8b35:3f32 with SMTP id c191-20020a621cc8000000b006258b353f32mr9251297pfc.18.1679886056196;
        Sun, 26 Mar 2023 20:00:56 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b00627e9ab34b3sm15506063pff.91.2023.03.26.20.00.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Mar 2023 20:00:56 -0700 (PDT)
Date:   Mon, 27 Mar 2023 11:07:39 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] workqueue: Drop the NOT_RUNNING check to flags in
 worker_{set,clr}_flags
Message-ID: <20230327110739.000057ed.zbestahu@gmail.com>
In-Reply-To: <CAJhGHyAvzjK5r5yfB_wcLPnq=Y=wwsxh=M=EA3x5EsNacRKMVQ@mail.gmail.com>
References: <20230320092652.16649-1-zbestahu@gmail.com>
        <ZB0Dwxs6xen7D/qh@slm.duckdns.org>
        <CAJhGHyAvzjK5r5yfB_wcLPnq=Y=wwsxh=M=EA3x5EsNacRKMVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun, Lai,

On Sat, 25 Mar 2023 17:20:14 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> On Fri, Mar 24, 2023 at 9:58 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Mar 20, 2023 at 05:26:52PM +0800, Yue Hu wrote:  
> > > From: Yue Hu <huyue2@coolpad.com>
> > >
> > > We know whether the worker flags are belong to WORKER_NOT_RUNNING or not
> > > when we are setting and clearing them.  So check the flags not running
> > > related is unnecessary for both the cases.
> > >
> > > Currently, worker_{set,clr}_flags() are all used for WORKER_NOT_RUNNING
> > > except for clearing WORKER_IDLE.  Let's change to directly clear it
> > > instead.  Also, update the comment a little in worker_clr_flags().  
> >
> > I'm not sure this is better. Semantically, the existing code seems clearer
> > and less error-prone to me and this isn't gonna make any meaningful perf
> > difference. Lai, what do you think?  
> 
> objdump -DSr kernel/workqueue.o | less
> 
>     3275:       00 00
>                         3273: R_X86_64_32S      current_task
>         WARN_ON_ONCE(worker->task != current);
>     3277:       48 39 43 40             cmp    %rax,0x40(%rbx)
>     327b:       0f 85 91 00 00 00       jne    3312 <process_one_work+0x3a2>
>             !(worker->flags & WORKER_NOT_RUNNING)) {
>     3281:       8b 43 68                mov    0x68(%rbx),%eax
>         if ((flags & WORKER_NOT_RUNNING) &&
>     3284:       a9 c8 01 00 00          test   $0x1c8,%eax
>     3289:       75 0b                   jne    3296 <process_one_work+0x326>
>         struct worker_pool *pool = worker->pool;
>     328b:       48 8b 43 48             mov    0x48(%rbx),%rax
>                 pool->nr_running--;
>     328f:       83 68 20 01             subl   $0x1,0x20(%rax)
>     3293:       8b 43 68                mov    0x68(%rbx),%eax
>         worker->flags |= flags;
>     3296:       83 c8 40                or     $0x40,%eax
>     3299:       89 43 68                mov    %eax,0x68(%rbx)
> 
> It seems the compiler will do the trick. The clearer existing code
> seems better.

Thank you for taking time to review the patch.

The `worker_set_flags` has two behaviors. One is set worker flags unconditionally.
Another is to conditionally adjust `nr_running`. I understand the adjustment should be
only for the flags that we set to NOT_RUNNING. 

And currently the `worker_set_flags()` is not universally used when setting them, such
as in the case of setting WOKER_IDLE. So, I think this helper is not fulfilling its
responsibility, it is actually just only processing `not_running` state. 

If the change is meaningful, maybe it's better to name it as worker_set_not_running_flags()?

Anyway, it is just a minor change.

Thanks.

> 
> Thanks
> Lai
> 
> >
> > Thanks.
> >
> > --
> > tejun  

