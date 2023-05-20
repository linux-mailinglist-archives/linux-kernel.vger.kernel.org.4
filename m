Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4B70A67F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjETIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjETIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA8BD
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F2096102E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF11C4339E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684572620;
        bh=X/AwhdFPPERYtbQ7sS7+eyBw3xKrtCMibi3UUYr5J2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JyxMp5y95aZzCB0cvBvYssg2uZLhqMGIsPVRwwpxz1a5FS7KIdMXflxI8c1bfp7SC
         +t42OmVcNXci82J9u+B17a2ktWnYmBncD5Ez2g+52fpICwlcm/v9kkv70IywYRVig3
         nzxBA/geFHcaiEWErEyKc7VaTKQ+vYAXvNUYJNcEFXftFijH+RjDqzLnjLiicMnVkr
         L/+QOToR5c/8DnCl3Wv5F0+sCBKLa8fR7FfHKK7y6hQdPW4mQPojRp2LbQq/imqXO2
         HfRc4vm8PiHtNZYgJSlkt1LsWebphOKkcQDnHj3h+MjZtIxIi6I2e0P1Qj21jlzzwj
         ZJpTM6b0Th6Qg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f50e26b8bso403698566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:50:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDx3cHt/sKIYiqAKBlUgTOKIgjOtJwP7CaWurc6aNwiEPrapgG6+
        J1UJIyaG9b3HQO0HCBD7vFXDzWmFIVxSa7q7k9g=
X-Google-Smtp-Source: ACHHUZ7B2eILcWdrKNoLYc4hTPaMPAOYvEKVM9MOKBsZcErc+TMFAnu+ATvDwsy0HjPQ0iiCU73v07I+GPZScFpzYAU=
X-Received: by 2002:a17:907:c14:b0:969:e304:7a22 with SMTP id
 ga20-20020a1709070c1400b00969e3047a22mr5074698ejc.18.1684572619005; Sat, 20
 May 2023 01:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230509104127.1997562-1-chenhuacai@loongson.cn>
 <87ild0w5qs.fsf@email.froward.int.ebiederm.org> <CAAhV-H79bUF396+dWaafanzcMq41VtcOsfa_3SYSUftyNDOyvw@mail.gmail.com>
 <87ttwdu05t.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ttwdu05t.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 20 May 2023 16:50:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7QwdLt5Dr+bq4F34mn3xZ2E6GrTZtaY6eMfC6Jok42ig@mail.gmail.com>
Message-ID: <CAAhV-H7QwdLt5Dr+bq4F34mn3xZ2E6GrTZtaY6eMfC6Jok42ig@mail.gmail.com>
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,


On Mon, May 15, 2023 at 10:42=E2=80=AFPM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Huacai Chen <chenhuacai@kernel.org> writes:
>
> > Hi, Eric,
> >
> > On Wed, May 10, 2023 at 11:45=E2=80=AFPM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >>
> >> Huacai Chen <chenhuacai@loongson.cn> writes:
> >>
> >> > Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for =
init
> >> > and umh") introduces a new function user_mode_thread() for init and =
umh.
> >> > But the name is a bit confusing because init and umh are indeed kern=
el
> >> > threads at creation time, the real difference is "they will become u=
ser
> >> > processes".
> >>
> >> No they are not "kernel threads" at creation time.  At creation time
> >> init and umh are threads running in the kernel.
> >>
> >> It is a very important distinction and you are loosing it.
> >>
> >> Because they don't have a kthread_struct such tasks in the kernel
> >> are not allowed to depend on anything that is ``kthread''.
> > Hmm, traditionally, we call a "task" without userland address space
> > (i.e., the task_struct has no mm, it shares kernel's address space) as
> > a kernel thread, so init and umh are kernel threads until they call
> > kernel_execve().
>
> No.
>
> The important distinction is not the userland address space.
>
> The important distinction is how such tasks interact with the rest of
> the system.
>
> It is true the mm does not initially have userspace content but
> that does not change the fact that it is a valid userspace mm.
>
> For scheduling, for signal delivery, and for everything else
> these tasks are userspace tasks.
>
> The very important detail is that it is not at kernel_execve time that
> the distinction is made, but that it is made earlier when the thread
> is created.
>
> This is a subtle change from the way things used to work once upon a
> time.  But the way things used to work was buggy and racy.  Deciding at
> thread creation time what the thread will be used for, what limitations
> etc is much less error prone.
>
> We had this concept of kthread_create that used to create a special
> class of tasks.  What was special, and what extra could be done with
> those tasks was defined by the presence "struct kthread" (my apologies
> I mispoke when I said kthread_struct earlier).
>
> Then because that specialness was needed on other tasks struct kthread
> started to be added to tasks at run-time.  That runtime addition of
> struct kthread introduced races that complicated the code, and had
> bugs.
Thank you very much for providing so much background information. Now
I know that init and umh are different from typical kernel threads,
but on the other hand, they are also different from typical user mode
threads (have no mm struct at creation time). So from my point of
view, we can treat them as "special kernel thread".

Huacai

>
> > Of course in your patch a kernel thread should have a
> > "kthread" struct (I can't grep "kthread_struct" so I suppose you are
> > saying "kthread"), but I think the traditional definition is more
> > natural for most people?
>
> Natural and traditional is a silly argument.  The fact is those are
> tasks that ultimately run userspace code.  That ability needs to
> be decided upon at creation time to make them race free.
>
> Therefore the old code and definition are wrong.
>
> Eric
