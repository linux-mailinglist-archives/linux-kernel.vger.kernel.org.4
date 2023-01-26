Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81567D376
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjAZRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjAZRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:45:52 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46318B0B;
        Thu, 26 Jan 2023 09:45:51 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z2so500059ilq.2;
        Thu, 26 Jan 2023 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T04Lwt/osJ3z9x91/GQOsUFFhCST0Wo0GTgNZCVXnH0=;
        b=De6qwAn5MQi8akTue0jKjOs7ZgOKo3hL7mvKewl9zt5UCTKrazNkIcEVM+vQ3KL+2G
         nQtql5bCwKdFlZepauedfaGfmPOAtgEIQReZN6ZJyCLWzy2h6SPHY3SPNO7XwULp5lwn
         qfvTlyAFyGp9ElWok5cJs1/ny3Tign6sNSyNzZuljNxbSL8+nstpkiOVbUehz8UUESfB
         nl77FcB6lMQL9zZvPvCpl4LFBD9Avur9djCkttQeaqcfY3g/cNTfuDptf8gSIa6wQVFI
         nBggE9DJ1lgnEuymrsVqUYHMhWjbVY79Bs3ExxhjQN6HJW7kBFoHA9sajY9jxry6m6RK
         4lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T04Lwt/osJ3z9x91/GQOsUFFhCST0Wo0GTgNZCVXnH0=;
        b=zo68qMV4ml+4SVNnGaTOFI2ZIkwFQP3QPpjbrgwg7bgu3IIMsw7ot5Tjb/k0oDRLXZ
         Iz22cEfyVO4j9vCAcHPgSRvqZdmYHOKoeZwt1RuZ1sefM8cjvvzx+W4PuFUtVAYHmS0/
         t3sZrSlKQgO1iK2ZvN/9YJ5tCncEMotOZc7Ec8OuixelADQXVyxWMt/Lf5II+1gYboYy
         kGZcOZ/sJMOrhOgPUCdW4WREHX/q01BS6141EFwCDEN6gKFiOZ/7RGTnpL9XwxlM1BBj
         4nt0yDy+WPdOZjzfhNLzQoRgtodekPuzWxDzFYpwZlc9gqnml4GXkwwJl8BWF5ezgjap
         mFMw==
X-Gm-Message-State: AFqh2kqKBHnv8vpp0cfW5RmC0ym6K52cZvvFwUNWQV6muFpVRgWyQlQs
        ys0f68MpxtwEVBu2x25OgQ1B3vdaZ7S8eD1wZ+A=
X-Google-Smtp-Source: AMrXdXvdEk+Fe1q+esJXTIVOij0pu05ZSglHaVIW6Er7Va3Sc3FL8hEN1czKSfxDdhISkgN0NBd4JbUDMDzmTByCSzY=
X-Received: by 2002:a92:6a05:0:b0:30d:ba97:90e2 with SMTP id
 f5-20020a926a05000000b0030dba9790e2mr4314331ilc.38.1674755150671; Thu, 26 Jan
 2023 09:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com> <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com> <20230126150725.GB4069@redhat.com>
In-Reply-To: <20230126150725.GB4069@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 26 Jan 2023 09:45:39 -0800
Message-ID: <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/25, Andrei Vagin wrote:
> >
> > On Wed, Jan 25, 2023 at 4:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 01/24, Gregory Price wrote:
> > > >
> > > > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > > > modify Syscall User Dispatch to suspend interception when enabled.
> > > >
> > > > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > > > SECCOMP interposition.  Without doing this, software like CRIU will
> > > > inject system calls into a process and be intercepted by Syscall
> > > > User Dispatch, either causing a crash (due to blocked signals) or
> > > > the delivery of those signals to a ptracer (not the intended behavior).
> > >
> > > Cough... Gregory, I am sorry ;)
> > >
> > > but can't we drop this patch to ?
> > >
> > > CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> > > config->mode anyway as we discussed.
> > >
> > > Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> > > with the same effect, no?
> >
> > Oleg,
> >
> > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is automatically cleared when
> > a tracer detaches. It is critical when tracers detach due to unexpected
> > reasons
>
> IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> code, and this also needs to change the state of the traced process. If
> the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> will have other problems?

Our injected code can reheal itself if something goes wrong. The hack
here is that we inject
the code with a signal frame and it calls rt_segreturn to resume the process.

We want to have this functionality for most cases. I don't expect that
the syscall user dispatch
is used by many applications, so I don't strongly insist on
PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH. In addition, if we know a user dispatch
memory region, it can be enough to inject our code out of this region
without disabling SUD.

Thanks,
Andrei
