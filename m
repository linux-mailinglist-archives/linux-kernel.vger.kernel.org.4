Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429F6F722E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEDS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:56:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423898
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:56:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so20282410a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683226591; x=1685818591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3KrGRxES7yi69TfDGsEI+bo95SlGqJYT0mXPM1FxOQ=;
        b=Z1L2Sn+N5TgrdO9tqr9/4QraLBAKu8sysz9/Vq0ah1ytoVYTAV093sEvwDNfsqvdEf
         w4QhJ68h7RBItbtGCONt699d1s69Qat6Xi1ULqD+2kwCphzkoA8gQ5IxZsfODsPyGoVm
         zT3EmNUEnOEHAecClPTcJc4sqMU0qdXHwC5xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226591; x=1685818591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3KrGRxES7yi69TfDGsEI+bo95SlGqJYT0mXPM1FxOQ=;
        b=FOjp7+GOo862ZDbMJ2gj83N7nTga4PjDmopz2UCwL7WGeIsTJ+vMPSCzsDxax84RPI
         +jQldqW42TFKG33hTdPXex8JjSPaPPLozaj4muElD0fjfHExQKhY95gPXkDvr3/vT393
         AzTkqdhlRM3appjyHS9by/OkOPqRJDGTf8jY2gmWdJ9dqiLjYyzOctXAXpCI3Zzv+k7A
         nvjStNdAxi9v+UA6KWkLvcjW+VIG+u739HSSp3d99lo0JtFS5fnjeJXYTTAqn5PVNoKZ
         f1O/lGxryDHUgYY3sU9pGxnJEe1ulFLVHJXDW9JaGuWR21c9PDU2TI7sdhXHo1G/e6uw
         BkDw==
X-Gm-Message-State: AC+VfDz+xSIW3OkzwN7slnLnzzybmtsigxETczcTE8ImCgXKnsUqTbTH
        xVSYJjBB0iPDlpTwqJ+t49zClVIPSjCwtLslNUOFTi0t
X-Google-Smtp-Source: ACHHUZ4YmgflN5/ZFKKSjSnsfcMKZxs8mEjypLq4yqJpxDrmR0a3iykpEP9NlVxbsaeFjvpGgoPQ8Q==
X-Received: by 2002:a05:6402:160d:b0:50b:dfe2:91 with SMTP id f13-20020a056402160d00b0050bdfe20091mr2497801edv.7.1683226590964;
        Thu, 04 May 2023 11:56:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id t1-20020aa7d4c1000000b0050bc9c38fb4sm2145177edr.69.2023.05.04.11.56.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:56:30 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so20282184a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:56:29 -0700 (PDT)
X-Received: by 2002:a17:907:96a8:b0:94a:643e:9e26 with SMTP id
 hd40-20020a17090796a800b0094a643e9e26mr6489766ejc.14.1683226589525; Thu, 04
 May 2023 11:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <202305041446.71d46724-yujie.liu@intel.com> <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 11:56:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMz_=WyfQMx1ebofeq+w6Cr_kRcJ1Xc=D6iKc4My16bQ@mail.gmail.com>
Message-ID: <CAHk-=wjMz_=WyfQMx1ebofeq+w6Cr_kRcJ1Xc=D6iKc4My16bQ@mail.gmail.com>
Subject: Re: [linus:master] [x86] adfcf4231b: blogbench.read_score -10.9% regression
To:     kernel test robot <yujie.liu@intel.com>,
        Frank Denis <j@pureftpd.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
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

On Thu, May 4, 2023 at 10:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I suspect that the 'blogbench.read_score' thing probably does
> mostly big reads, and really really liked the cacheline optimizations
> of 'rep movs' even when it was slow in other things.

Oh, and I went to look at the blogbench code, and it's a
*horrifically* bad benchmark for this case.

It may actually be a good benchmark for other things - the "look up
random filenames" etc might be somewhat indicative of real performance
on some loads.

But the read() system call part is very much *not* good.

It looks like the reason blogbench likes 'rep movs' is the traditional
reason why memory copy benchmarks tend to like uncached copies: it
looks like the benchmark doesn't actually even look at the data it
reads.

It's a common pattern, but it's a bad pattern. It's not very different
from doing CPU benchmarks using an empty loop:

     for (int i =3D 0; i < 1000000; i++) /*nothing*/;

and then being surprised when the compiler optimized the loop away
because it doesn't actually *do* anything.

Of course, unlike the empty loop, the kernel will still do the reads,
but the kernel will do the reads with the assumption that the result
matters.

And for blogbench, that is *doubly* not the case.

Because it looks like blogbench does a loop over

        read_dummy_file(file_name);

which will open that file, and then loop over

        #define READ_CHUNK_SIZE 65536
        ...
            static char garbage[READ_CHUNK_SIZE];
        ..
        loop:
                if ((readen =3D read(fd, garbage, sizeof garbage))

and that variable is very appropriately named indeed. It is very much garba=
ge.

So it really looks like what is going on is that you have

 (a) a threaded application (looks like N=3D100 for reads by default)

 (b) doing 'read()' calls into a *shared* buffer in parallel

 (c) and never using the buffer for anything else

which means that a memory copy that does non-temporal writes is going
to look artificially really good, because nobody wants to ever see the
end result.

Now, the "nobody wants to ever see the end result", might actually be
at least _partially_ valid in some historical setting, if you were to
use DMA to then push things out to a network. Back in the olden days,
that was actually a valid reason to use non-temporal writes, because
the DMA would have to invalidate the caches anyway.

So that part is wrong, but isn't necessarily *horrifically* wrong.
It's just bad.

But using one shared destination buffer for N readers is *completely*
bogus. Any cache-lines would bounce around like crazy for the
(pointless) sharing. I'd like to call it "false sharing", but it's not
really false: it's intentionally just using one big shared buffer as a
sink for all these read() calls.

End result: I think the benchmark scores for reading are entirely
pointless random numbers, and trying to optimize the kernel for this
benchmark is exactly the wrong thing to do.

The benchmark doesn't actually do anything half-way valid.

At a *minimum* that benchmark should have different threads using
different read() buffers.

I suspect it might be a good idea to also touch some of the data,
because that would be the normal situation (even with old-style
zero-copy DMA you'd probably not do raw file data and push it out to
the network unmodified).

Because otherwise you will always find that objectively bad memory
copies will do better than a good memory copy that makes sense.

Anyway, that was a very long-winded way of saying that I will not use
that benchmark as a reason to touch the kernel "copy_to_user()"
implementation.

Of course, that's not to say that this might not be a real regression
on real loads, but I'd want to see those other numbers.

It looks like this is an old benchmark that hasn't been touched in
years (just going by the github activity), but I'm cc'ing the author
anyway, and will add a pointer to this email as a github issue. Maybe
the developer cares, maybe he doesn't, but no reason not to at least
mention this and see if maybe the benchmark can be improved to at
least use a thread buffers for the reads.

(The same issues are true for the writing side too, of course, but the
writing side has less parallelism and a shared *source* is not the
same kind of problematic from a cache pattern standpoint, so probably
isn't going to have anything like the same effect from any memcpy
implementation).

                  Linus
