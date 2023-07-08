Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962D574BEAD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGHSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:05:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839E21B3
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 11:05:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9939fbb7191so579565266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688839508; x=1691431508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MjnZGX1PQcWVMUP4ngUH52YPa64eL7ZPB4WTz7UhRF0=;
        b=GIjkI0H+l12pwV8268GoTcFasRmnKd5Q9vwyG/4x3rs3N7icFJh7p7JRu5il/KcK+n
         FJAMZUGCO5MVPgZ0B9Z+w0Ubs0vs6elQPlWXN52AsnYirx8/q2pjyxNtEx0yI/KoIrsl
         eJGztnSX9KK+1RZWhCrQH2vCYWF5pGyCVfTwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688839508; x=1691431508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjnZGX1PQcWVMUP4ngUH52YPa64eL7ZPB4WTz7UhRF0=;
        b=VmBgkkRGPn36pMP8EjYf0qkRxPkrLBU6OSYAWt3pA9VvFW1WUHoUkftCawKUhNNkGk
         AbtsPStc2YGfjvdpNmP8Ozdg4zaZSwxg2roqy8K/8g5u2ocdN5O9WRpqrtuUplOtHOtA
         VBaE4KMdDk+eKF87XxUJU3T59IBWn4wGIM+Tl5OVkre2i603HdT5ZR2urr1x+FCJxJ1N
         N6rvPx3dbnd0TI/jdstPrl7fqnATjjKd+zOwdBMUSKX8MNXCMrDVXFcSEzzCzCnd2cjp
         QeNBmweBPSihGdP8ShC5dy8Fq6l233YeCebpCNhdYC8EArwtUBJGQpi0J+qUCcT37T5P
         Ocew==
X-Gm-Message-State: ABy/qLZ0dRdfDHlXOFpyf4VG3W0g6vUMNUYjOc/RN6JwWx+BAS68Vip8
        7U+CvXzIDBZjWbnOETyPW0+Iwp+0tvnbR7zvEfoJk2Xa
X-Google-Smtp-Source: APBJJlGZIjA3nHcc65uTN2HIIjuf6K9+Srr488mDmsgiCRsAGAyoU+CZGHB02+cHf0lnREe33ZLqxg==
X-Received: by 2002:a17:906:7952:b0:98e:4f1:f987 with SMTP id l18-20020a170906795200b0098e04f1f987mr11805122ejo.3.1688839507849;
        Sat, 08 Jul 2023 11:05:07 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906858900b0098e78ff1a87sm3758850ejx.120.2023.07.08.11.05.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 11:05:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7322109a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 11:05:06 -0700 (PDT)
X-Received: by 2002:a05:6402:274c:b0:51b:d59f:8518 with SMTP id
 z12-20020a056402274c00b0051bd59f8518mr12625706edd.16.1688839506127; Sat, 08
 Jul 2023 11:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
 <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info> <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
 <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org>
In-Reply-To: <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 11:04:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
Message-ID: <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Suren Baghdasaryan <surenb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 10:39, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> That was the v1 fix, but after some discussion
> (https://lkml.kernel.org/r/20230705063711.2670599-1-surenb@google.com)
> it was decided to take the "excessive" approach.

That makes absolutely _zero_ sense.

It seems to be complete voodoo programming.

To some degree I don't care what happens in stable kernels, but
there's no way we'll do that kind of thing in mainline without some
logic or reason, when it makes no sense.

flush_cache_dup_mm() is entirely irrelevant to the whole issue, for
several reason, but the core one being that it only matters on broken
virtually indexed caches, so none of the architectures that do per-vma
locking.

And the argument that "After the mmap_write_lock_killable(), there
will still be a period where page faults can happen" may be true
(that's kind of the *point* of per-vma locking), but it's irrelevant.

It's true for *all* users of mmap_write_lock_killable, whether in fork
or anywhere else. What makes fork() so magically special?

It's why we have that vma_start_write(), to say "I'm now modifying
*this* vma, so stop accessing it in parallel".

Because no, flush_cache_dup_mm() is not the magical reason to do that thing.

Maybe there is something else going on, but no, we don't write crazy
code without a reason for it. That's completely unmaintainable,
because people will look at that code, not understand it (because
there is nothing to understand) and be afraid to touch it. For no
actual reason.

The obvious place to say "I'm now starting to modify the vma" is when
you actually start to modify the vma.

> Also, this change needs a couple more updates:

Those updates seem sane, and come with explanations of why they exist.
Looks fine to me.

Suren, please send me the proper fixes. Not the voodoo one. The ones
you can explain.

And if stable wants to do something else, then that's fine. But for
the development kernel,. we have two options:

 - fix the PER_VMA_LOCK code

 - decide that it's not worth it, and just revert it all

and honestly, I'm ok with that second option, simply because this has
all been way too much pain.

But no, we don't mark it broken thinking we can't deal with it, or do
random non-sensible code code we can't explain.

            Linus
