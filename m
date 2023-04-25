Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFEA6EE688
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjDYRU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjDYRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:20:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190E59E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:20:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1110584666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682443250; x=1685035250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVVmJ1fx0aoOuxkq/knWyaeG2lUoRnjKcWlgPQdyjRo=;
        b=bJJMzkHIfxGnsK/YyxlJuvhLvBAEe+R1L0q1Gwk6Hh1Zb2ZAIjPzFEeS2N9u/XsHOK
         TPT9vCnJdH3AaiGf+Xpfiz7mvavulFbJUi8AzpjnPP5R23hUqn3XAGxzThsuVR3Af4sx
         cbUQ3ye6L/qAxM/kriZO1VAuPyMayP30asQjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443250; x=1685035250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVVmJ1fx0aoOuxkq/knWyaeG2lUoRnjKcWlgPQdyjRo=;
        b=a3OE9QEnbjrS5/XTqagqtNPU6eZ59TP76FCszLme+m5OuiRkgc7DCftegistK5weiS
         VA2tFz7qZxHv47kpOcolwJnHBrR/M21hPWAxgyCUo2LuEFhMBLaIMrQztscsGhEGZ38Q
         TRa/6m8I10aBjySPfQ+Qg2jNKsWQ19MsQC72oDDgnzndmGIGlgCT1FFuRvd/Ok1Ymc8w
         qhkHoqIlY2jDx7OhiyR3uSD/ntWLXXBUzolNzXRt1BXwZvETYF2s5ytCcl+dvNaP0Fwg
         3Grll9+xnBpyRrs/SZs7Mdr4uNYoM7/1GaeGiT+ne5qjEaESh97GpiChXj5I9mT8+5b+
         2Npg==
X-Gm-Message-State: AAQBX9cqtOTuZcnxAhtyB60ngNGnQFhrrQt0njxWgyUDuZRUA6lawa6E
        4naGpuujc4nbtlX7+qIRlHzgJbqOZGaZf7KdhOrt+/M0
X-Google-Smtp-Source: AKy350aPTi63fsfW6X9k7PUXhdGkUj4Qgi/Tu/Q/MHA+bmd7IwG/mwhhabhQimGLEH3gxYN1L4XaWw==
X-Received: by 2002:a17:906:6048:b0:94f:5847:8ac with SMTP id p8-20020a170906604800b0094f584708acmr12041110ejj.51.1682443250128;
        Tue, 25 Apr 2023 10:20:50 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b0094a8f61ef3fsm7085995ejc.173.2023.04.25.10.20.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:20:49 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso10497096a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:20:49 -0700 (PDT)
X-Received: by 2002:aa7:c558:0:b0:4fd:c5e:79b8 with SMTP id
 s24-20020aa7c558000000b004fd0c5e79b8mr17195243edr.32.1682443248946; Tue, 25
 Apr 2023 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk> <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
In-Reply-To: <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 10:20:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
Message-ID: <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 8:16=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, you should move the
>
>         old_fmode =3D READ_ONCE(file->f_mode);
>
> to outside the loop, because try_cmpxchg() will then update
> 'old_fmode' to the proper value and it should *not* be done again.
>
> I also suspect that the READ_ONCE() itself is entirely superfluous,
> because that is very much a value that we should let the compiler
> optimize to *not* have to access more than it needs to.

I ended up looking around a bit, and the READ_ONCE() before the
"try_cmpxchg()" loop is definitely our common pattern.

However, I'm adding in the locking people, because I think that
pattern is wrong and historical.

I think it comes from the original cmpxchg loop model, where we did
the read inside the loop, and the READ_ONCE() was some kind of "let's
make sure it's updated every time" thing (which should be unnecessary
due to memory clobbers on the cmpxchg, but whatever...

Inside the loop, the READ_ONCE() also makes more sense in general, in
that there isn't any sane point in merging it with earlier values, so
there's no downside.

But the more I look at it, the more I'm convinced that our pattern of

        old =3D READ_ONCE(rq->fence.error);
        do {
                if (fatal_error(old))
                        return false;
        } while (!try_cmpxchg(&rq->fence.error, &old, error));

(to pick one random user) is simply horribly wrong.

If we have code where we had an earlier load of that same value (or an
earlier store, for that matter - anything where the compiler can
assume some starting value), then the READ_ONCE() only adds pointless
overhead.

And if we don't have it, then the READ_ONCE() doesn't add any value,
since it doesn't imply any ordering.

IOW, I think the READ_ONCE() pattern is either pointless or
detrimental. I see no upside.

So I think we should make the pattern be used with a try_cmpxchg()
loop to be either a proper *ordered* read (ie something like
"smp_load_acquire()" for reading the original value), or we should
just let the compiler read it any which way it wants. Not the
READ_ONCE() pattern we seem to have.

But I'm adding the locking maintainers to this email to make sure that
I'm not missing anything.

PeterZ in particular, who added that new (and hugely improved!)
try_cmpxchg() interface in the first place.

        Linus
