Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F136C86DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCXU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:29:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA919BA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:29:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so12557707edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679689750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szzCt9QgYlmv+MdPEpdeehiy7Y3yIBOornBldbmElZU=;
        b=HEUkzzFfbkd2t4QLVjmsN13rGr1E08bjBTMtmniTEh0Fy0XI5uOWH1TtTY9aNvmD22
         q9H9RNHRg2DeFl/u4HCp8SgTThcUmm8MfCtuz+JLq8p6lXyBG44RR5UEOJpH+7SNcocW
         xStZYNej2tf1wJTuyM94i+dhQCVtOQb+3L4LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szzCt9QgYlmv+MdPEpdeehiy7Y3yIBOornBldbmElZU=;
        b=aJIc6A+oQEGQnrFNHpRos14BoBLPpHN6cQ6S1wbVMaRsV9d8StTbm8FmVE/Lvkcj+w
         ZpFVHE5KoAMRpqKNbJEOM0AK54ylP+hxqfQqqjgW24Y4PA3oLdhRh5YLLPfeLR1GD63G
         kqOH+vxGdcvB0qMaFxpJoc5NNGAl/xHyE8p8rwtCmzLrts1Fdf4iXCLksIsv31zeEQx1
         aodDbweJH16FNqRTpkNapkQCu1kY9xeVSZBMM2p9DBIZqPcoWGZXBTEEp2i/hjGXGAAm
         eTeinhjcWPDGAR5dCvmNnZsnu/ukafIBWjmwbev1keaJ7kkzgNid3/8siHRx9f8NmDT2
         3TPw==
X-Gm-Message-State: AAQBX9cPq073sLSL4YPTZ+mRokKDJdqM/fVzowVlLm0TkvHSTaL0T9pg
        W0FkyOQ6ixnXWvTN4FCSAaimrr/NUUh02wDqn/LKJjRU
X-Google-Smtp-Source: AKy350YqK5rjJbOQ+H6kGa13Ame5wKMOA7c11rPPJ6osKpWBNQhC42903GSM72Y7llbn+EJXxEAbhA==
X-Received: by 2002:a17:906:555:b0:92e:e9c2:7b9e with SMTP id k21-20020a170906055500b0092ee9c27b9emr3485761eja.41.1679689750442;
        Fri, 24 Mar 2023 13:29:10 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm10823587ejb.132.2023.03.24.13.29.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 13:29:09 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id r11so12495214edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:29:09 -0700 (PDT)
X-Received: by 2002:a17:906:d54d:b0:932:da0d:9375 with SMTP id
 cr13-20020a170906d54d00b00932da0d9375mr2532911ejc.4.1679689748729; Fri, 24
 Mar 2023 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com> <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com> <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org> <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com> <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com> <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
In-Reply-To: <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 13:28:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
Message-ID: <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 1:00=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On the modules side of things we can be super defensive on the second
> vmalloc allocation defensive [0] but other than this the initial kread
> also needs care too.

Please don't re-implement semaphores. They are a *classic* concurrency limi=
ter.

In fact, probably *THE* classic one.

So just do something like this instead:

   --- a/kernel/module/main.c
   +++ b/kernel/module/main.c
   @@ -2937,6 +2937,11 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
        return load_module(&info, uargs, 0);
    }

   +#define CONCURRENCY_LIMITER(name, n) \
   +    struct semaphore name =3D __SEMAPHORE_INITIALIZER(name, n)
   +
   +static CONCURRENCY_LIMITER(module_loading_concurrency, 50);
   +
    SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs,
int, flags)
    {
        struct load_info info =3D { };
   @@ -2955,8 +2960,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const
char __user *, uargs, int, flags)
                      |MODULE_INIT_COMPRESSED_FILE))
                return -EINVAL;

   +    err =3D down_killable(&module_loading_concurrency);
   +    if (err)
   +            return err;
        len =3D kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
                                       READING_MODULE);
   +    up(&module_loading_concurrency);
        if (len < 0)
                return len;

NOTE! Entirely untested. Surprise surprise.

I'm a tiny bit worried about deadlocks here, so somebody needs to make
sure that the kernel_read_file_from_fd() case cannot possibly in turn
cause a "request_module()" recursion.

We most definitely have had module recursion before, but I *think*
it's always just in the module init function (ie one module requests
another when ithe mod->init() function is called).

I think by the time we have opened the module file descriptors and are
just reading the data, we should be ok and the above would never
deadlock, but I want people to at least think about it.

Of course, with that "max 50 concurrent loaders" limit, maybe it's
never an issue anyway. Even if you get a recursion a few deep, at most
you just wait for somebody else to get out of their loaders. Unless
*everybody* ends up waiting on some progress.

              Linus
