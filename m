Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCD714920
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjE2MKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjE2MKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CED9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685362195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezmo3ySrpKVEkRTo4rKlpHzjSOV6s+cSz0saVXSnw7w=;
        b=XTnaPgZv9cviN+OTb3Xlzy7RSux0QhvgNO0cNwTupvYUQsJe8i++FLs9iIB59j0q7W8xns
        Ct6tt/RsUFcVFnc0gnmCjP8AyVWzzmOr6vVmteiCH0vIFZuLjAcuykjP1Nr0uyt7Ui+VNx
        Zz5lHzl9tJG1OvIhhKJg92iOlikF7vA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-G4I4gjXcOxyPezHYIdeNgA-1; Mon, 29 May 2023 08:09:54 -0400
X-MC-Unique: G4I4gjXcOxyPezHYIdeNgA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-783777fc49aso970941241.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362194; x=1687954194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezmo3ySrpKVEkRTo4rKlpHzjSOV6s+cSz0saVXSnw7w=;
        b=gapHMeM2eIK1niPAQ9j5lGg60E4jFIdrFPpyGhamewX/ADRM52Nep4uaQcelUP0T9e
         1PIUWlqpXOPslSV96eRq2/VXIgrJsgopTvSmeI3VsFfuiPcCFDRuP7KIvSTdpPD+yGPl
         BGvsd24/8MvkiyM+xJKHtD//2HMd9KdocBp2TdTB2Yx24P8X9+vscKlbZzNhsz/oZ3lt
         TIFdM1m5WZEqM45lk/xZ44oswfZndHQ002I5TFGlP1s5hc8A3Z3jK9lvjStjIX//6idU
         5v+XF2zMkCPznnfhjQXq0GnieZS0HDIuI+5lmPhbnpmRqMCaOOSE2MdMm4a+Rnil1Ke6
         wUUg==
X-Gm-Message-State: AC+VfDyc5m1voBegaCtillUEQ1OAOcU2dSuzFV1EKAt/2DCPpXJ1asoX
        PUQ5OklJv2ZUPns/ufHXjTh6qF56RJ66mh11CBMaeWj/VBpBeWUciV4n4dF9xE5+aaz1/bkVssQ
        i/3aY1jW5redUpNAqVGVZEoD/jLwFoirg2IGXB5Lv
X-Received: by 2002:a05:6102:1d2:b0:432:8d2b:893 with SMTP id s18-20020a05610201d200b004328d2b0893mr2715026vsq.28.1685362194252;
        Mon, 29 May 2023 05:09:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WDA5GMerB0+79R5dtvoa22SRWwArSNcMPw28cLOlENzyRlzUS+YwKbIh/VRm1P6MAklZfN8ow0IGzsBwLjZE=
X-Received: by 2002:a05:6102:1d2:b0:432:8d2b:893 with SMTP id
 s18-20020a05610201d200b004328d2b0893mr2715015vsq.28.1685362193963; Mon, 29
 May 2023 05:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
In-Reply-To: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Mon, 29 May 2023 14:09:42 +0200
Message-ID: <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 9:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It's also an example of something people need to be aware of: the
> auto-releasing is not ordered. That may or may not be a problem. It's
> not a problem for two identical locks, but it very much *can* be a
> problem if you mix different locks.

It is guaranteed. It would be nice to have it documented, but if you
look at the intermediate representation of this simple example:

#include <stdio.h>

int print_on_exit(void **f) {
    if (*f) puts(*f);
    *f =3D NULL;
}

int main(int argc) {
    // prints "second" then "first"
    void *__attribute__((__cleanup__(print_on_exit))) cleanup1 =3D "first";
    void *__attribute__((__cleanup__(print_on_exit))) cleanup2 =3D "second"=
;
}

... the implementation is introducing a scope and reusing the C++
try/finally implementation, and the "optimizations" that are allowed
when functions are not "throwing" anything. This is always the case
for C, so this (from f.c.005t.original, obtained with -c
-fdump-tree-all):

{
  // the duplicated initializers are just an artifact of the AST
  void * cleanup1 =3D (void *) "first";
  void * cleanup2 =3D (void *) "second";

    void * cleanup1 =3D (void *) "first";
  try
    {
            void * cleanup2 =3D (void *) "second";
      try
        {

        }
      finally
        {
          print_on_exit (&cleanup2);
        }
    }
  finally
    {
      print_on_exit (&cleanup1);
    }
}
return 0;

becomes this as soon as exceptions are lowered (from f.c.013t.eh),
which is before any kind of optimization:

int main (int argc)
{
  void * cleanup2;
  void * cleanup1;
  int D.3187;

  cleanup1 =3D "first";
  cleanup2 =3D "second";
  print_on_exit (&cleanup2);
  print_on_exit (&cleanup1);
  cleanup1 =3D {CLOBBER(eol)};
  cleanup2 =3D {CLOBBER(eol)};
  D.3187 =3D 0;
  goto <D.3188>;
  <D.3188>:
  return D.3187;
}

> So in the crazy above, the RCU lock may be released *after* the
> cgroup_mutex is released. Or before.
>
> I'm not convinced it's ordered even if you end up using explicit
> scopes, which you can obviously still do:

It is, see

        void *__attribute__((__cleanup__(print_on_exit))) cleanup1 =3D "fir=
st";
        {
                void *__attribute__((__cleanup__(print_on_exit)))
cleanup2 =3D "second";
                puts("begin nested scope");
        }
        puts("back to outer scope");

which prints

begin nested scope
second
back to outer scope
first

This is practically required by glibc's nasty
pthread_cleanup_push/pthread_cleanup_pop macros (the macros are nasty
even if you ignore glibc's implementation, but still):

#  define pthread_cleanup_push(routine, arg) \
  do {                                                                     =
   \
    struct __pthread_cleanup_frame __clframe                               =
   \
      __attribute__ ((__cleanup__ (__pthread_cleanup_routine)))            =
   \
      =3D { .__cancel_routine =3D (routine), .__cancel_arg =3D (arg),      =
         \
          .__do_it =3D 1 };

/* Remove a cleanup handler installed by the matching pthread_cleanup_push.
   If EXECUTE is non-zero, the handler function is called. */
#  define pthread_cleanup_pop(execute) \
    __clframe.__do_it =3D (execute);                                       =
     \
  } while (0)

If the scope wasn't respected, pthread_cleanup_pop(1) would be broken
because pthread_cleanup_pop() must immediately execute the function if
its argument is nonzero.

>  - I think the above is simpler and objectively better in every way
> from the explicitly scoped thing

It is simpler indeed, but a scope-based variant is useful too based on
my experience with QEMU. Maybe things like Python's with statement
have spoiled me, but I can't quite get used to the lone braces in

{
    ...
    {
        auto_release(mutex, &mutex);
        ...
    }
    ...
}

So in QEMU we have both of them. In Linux that would be

   auto_release(mutex, &mutex)

and

   scoped(mutex, &mutex) {}

>  - I do think that the auto-release can be very dangerous for locking,
> and people need to verify me about the ordering. Maybe the freeing
> order is well-defined.

It is but having it documented would be better.

>  - I also suspect that to get maximum advantage of this all, we would
> have to get rid of -Wdeclaration-after-statement

Having both a declaration-based and a scope-based variant helps with
that too. You could add _Pragma("GCC diagnostic push/ignore/pop") to
the declaration-based macros but ouch... even without thinking of
whether clang supports it, which I didn't check.

Paolo

> That last point is something that some people will celebrate, but I do
> think it has helped keep our code base somewhat controlled, and made
> people think more about the variables they declare.

