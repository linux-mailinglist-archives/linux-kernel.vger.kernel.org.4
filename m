Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E870410E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjEOWlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEOWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:41:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51AA5DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:40:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96ab81aa68dso732140966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684190458; x=1686782458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iImPlVdd8BhaOj4VIb2AFWOJsf+WlGIJLTwbGNKfuFA=;
        b=fdIMwBPq+cSa6NPR4ZvPQg+0ifK7lC1OklGzprnBFsNKb19BA67IuLSbM3IUvNUzTq
         eU33fBrK0xRgAMD2jPl2fe7Y49Uhb04gC20IpGicusMeFS3lKm9SKYpFcMa7vg9mcIO1
         ALb4KZHhdVFbxjQdqEQyRgVwxTU0W3zBgwSdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684190458; x=1686782458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iImPlVdd8BhaOj4VIb2AFWOJsf+WlGIJLTwbGNKfuFA=;
        b=A43Oia8Gjj+olzZs/XiyJwOCSD2lDhmRmFP+IWo00PchqhUwXjm32b+PHkpnjfIDQa
         jdwFY8NcnEBMbC3In11aUW3BwyKrpyj2GkZorPS1roOcCN6JMz5pRi4a71nje6hhnR+7
         gUGcpjDcw7Iuxqd9YqRTkotD6O1fa/fpmaHDAaE5bJweO2cdO0TF/xm3p0KQhsIM86ta
         KrnpuI+qvEregygvhfb5Iba89by4zn/6Pn00dBiZYyzxKghzqQtwo4PLTWUcUqVqQXsI
         9Dw/g0ih+Xzbr3BTQiGNVW114FDD8+3/sC8U2CyA0O/Jg/8iKUnKJ5HWKwoGYp4G7Er1
         9yMA==
X-Gm-Message-State: AC+VfDw+4r03TQEuaCgy7gLh+gya3lSjNeWbZukoku6yBJ6sUJ7NnSdS
        gi3hTHp+Y1BSy8zsmWGlMU2fTPfbMfyYm7Z92y5U+2op
X-Google-Smtp-Source: ACHHUZ6AfQ7f3jv+D3FUlwNRcXe0sZMuDBt1+TsQhjYnN4xITnegQk2LpBRSXul+Az9MjjfgrHkMVA==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr36320764ejy.15.1684190457771;
        Mon, 15 May 2023 15:40:57 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id u11-20020a50eacb000000b0050bc7c882bfsm7548869edp.65.2023.05.15.15.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 15:40:57 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so24776947a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:40:57 -0700 (PDT)
X-Received: by 2002:a17:906:9b88:b0:96a:8a7f:4aa5 with SMTP id
 dd8-20020a1709069b8800b0096a8a7f4aa5mr16812995ejc.18.1684190456767; Mon, 15
 May 2023 15:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com> <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
 <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com> <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
 <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
In-Reply-To: <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 15:40:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZvH9KZPVbeTeLKwnv+bO4x15JVjeqWX68-+pmbsxJCQ@mail.gmail.com>
Message-ID: <CAHk-=wgZvH9KZPVbeTeLKwnv+bO4x15JVjeqWX68-+pmbsxJCQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 2:36=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> I did hack something together that seems to work for fork() and
> get_task_mm().  Basically, we let get_task_mm()'s legacy behavior to be
> the fast path.

So I don't like the patch very much, and I think you're being too
blinded by the mm_count.

It's not the mm_count itself that is the problem, after all. The
problem is literally "another CPU is using this MM for its TLB fills",
which is what can cause those dirty bits.

My mm_count suggestion was just a simplistic - and clearly overly so -
approximation for that not being the case.

So it's not actually "get_task_mm()" that is the problem - it's the
transition through "switch_mm_irqs_off()" that is the true barrier
here (whether through task switching or using it through switch_mm().

And basically no uses of "get_task_mm()" lead to that "switch_mm()"
path. The most common case by far for get_task_mm() is just for
various /proc things that want the mm struct for stats or other random
information (ie things like "ps" will do a *lot* of get_task_mm() to
read the command lines, for example, but won't actually _switch_ into
the resulting mm).

So I don't really love  your patch - not because I think it's
necessarily wrong, but because I think it was just a mistake to
concentrate too much on the counts as the "thing to protect".

IOW, let's take a step back. The mm_count idea was just broken. It
seemed simple, but it turned out that the only thing simple was me ;)

No, I think we should look at mm switching instead, and I think the
obvious main culprit here is kthread_use_mm().  Yes, there are other
uses of "switch_mm()" out there, but they tend to be pretty special
(ie we have EFI code that switches temporarily to the EFI page tables
and then switches back, but that will never switch to some *new*
context).

And the good news is that we're actually walking away from that
kthread_use_mm()  use, mostly because a lot of the kthread users of
user space state have been so hugely problematic. So io_uring switched
to "real user threads in kernel space" instead, and this merge window
vhost did too.

So I think instead of my - clearly racy - idea to use mm_count, we
could just use proper serialization with kthread_use_mm(). We could
even introduce a fork-specific lock that just says "you can't do that
during fork()", which honestly is not going to hurt *anything*,
because already nobody does.

And once you *do* have that serialization, at that point you can then
use mm_count as a heuristic, knowing that you won't race with
kthread_use_mm().

Because while kthread_use_mm() does remain, it's for things like the
GPU drivers and some other special driver infrastructure that has some
async user space access, which wouldn't make sense during fork()
anyway.

So I *think* fork() could do something like this:

  struct fork_cookie; // dummy type purely for type checking
  static struct fork_cookie *is_singe_threaded(void)
  {
        struct mm_struct *mm =3D current->mm;
        mutex_lock(&mm->fork_lock);
        if (atomic_read(&mm->mm_users) > 1 ||
            atomic_read(&mm->mm_count) > 1) {
                mutex_unlock(&mm->fork_lock);
                return NULL;
        }
        return (struct fork_cookie *)mm;
  }

  static void release_single_threaded(struct fork_cookie *cookie)
  {
        if (cookie) {
                struct mm_struct *mm =3D (struct mm_struct *)cookie;
                mutex_unlock(&mm->fork_lock);
  }

or whatever.

Then you just put

        const struct fork_cookie *single_threaded =3D is_singe_threaded();
        ...
        release_single_threaded(single_threaded);

around the whole copy_mm() in fork, and use that "single_threaded"
cookie to decide whether you do the optimized fork or not.

And all you need to do in kthread_[un]use_mm() is to
increment/decrement the mm_users under that same fork_lock.

We can still race with *other* possible uses of the mm_count, but not
with the ones that matter - the ones that use the mm for mapping.

(The whole idle thread use-case needs some thinking about when the
'fork()' itself bounces from core to core, and might leave idle
threads in its wake. But I don't think any speculative idle thread
accesses could possibly mark page tables dirty???)

I dunno. The above is wild handwaving. My hands are waving so hard
that I'm generating a bit of lift. I may well be missing some other
case - AGAIN.

What do you think? A lock that basically will never show even a hint
of contention under real loads seems like a fairly cheap thing to
serialize on.

             Linus
