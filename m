Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31672CACF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbjFLP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbjFLP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:56:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F13F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:56:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so54680371fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686585403; x=1689177403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ugCj9YhfDUqOrFu4vKJ/c5GJ+ui7RcmNnGjLCf8eEY=;
        b=JJotxGl8KOTjITNCHaLDw6NzEzsWXz5Fu12VZ+4h7dmxgwhO19QcltY4zHOLQ/pLE0
         i3/d7k/DwHOfxUTOD7uwU+KG85ZNvmO5Ceusqf+J2DHO3073HRlwNudGyLUg8xdS4dNW
         lgulr6K9yCt9KRYkGKt4jEt5I/1megOVAuNjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585403; x=1689177403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ugCj9YhfDUqOrFu4vKJ/c5GJ+ui7RcmNnGjLCf8eEY=;
        b=f/dJ1HoNhLVLpkVpj4wZLyxF+9rHoR2KQBjhWNWqXxa+7mHSi33piDHdyOBV/gmoUu
         AEsIkxNRySfRze2sgjrbF7Z/7KRAX1rP2LH10zkyuDJCoV4jKjL1dFxB/trfsPX/rem7
         y/EzX3TAxn84JAnizsB6YSdEKLpY0UMpXatvZepcbSqv8s6qAJ9/Prq0dcKloAIWNn4m
         5EDcg7HpNKsNdYGACPwIfdCAfWpdfLX2mtOWO662O9VDJjxHb8BYnlIN9qu36Db+bVF5
         Rsdn+rTPxFsMrLxYn4c541z2LmR76lRosTWf/g/aUt2aA86eJdJVq2HoeJMCgv3sCeOe
         w+QA==
X-Gm-Message-State: AC+VfDwWdg2PYh5HUJ8shSoyPF7F83be08tVnvkppxG2LGWCOZdKIcHW
        Eq/EBpZ4467IIywCCz2jP+n47SqPfor/AvYMVuh4ng==
X-Google-Smtp-Source: ACHHUZ6zmjk2pmvlAV7ixB1ZRSrFwAps0NQAZKr7gpaNCIW8cx9kcQZ1JrW/nG7rhd8/qqPgs11dRw==
X-Received: by 2002:a2e:86c4:0:b0:2b1:d91b:51c3 with SMTP id n4-20020a2e86c4000000b002b1d91b51c3mr3488951ljj.30.1686585403067;
        Mon, 12 Jun 2023 08:56:43 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k22-20020a2e9216000000b002add1f4a92asm1812704ljg.113.2023.06.12.08.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:56:42 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so5070187e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:56:42 -0700 (PDT)
X-Received: by 2002:a19:6445:0:b0:4f6:1e9c:cb11 with SMTP id
 b5-20020a196445000000b004f61e9ccb11mr4517490lfj.14.1686585402149; Mon, 12 Jun
 2023 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs>
In-Reply-To: <20230612153629.GA11427@frogsfrogsfrogs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 08:56:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
Message-ID: <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     "Darrick J. Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>, Zorro Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 8:36=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> > Or maybe Darrick (who doesn't see the issue) is running on raw
> > hardware, and you and Zorro are running in a virtual environment?
>
> Ahah, it turns out that liburing-dev isn't installed on the test fleet,
> so fstests didn't get built with io_uring support.  That probably
> explains why I don't see any of these hangs.
>
> Oh.  I can't *install* the debian liburing-dev package because it has
> a versioned dependency on linux-libc-dev >=3D 5.1, which isn't compatible
> with me having a linux-libc-dev-djwong package that contains the uapi
> headers for the latest upstream kernel and Replaces: linux-libc-dev.
> So either I have to create a dummy linux-libc-dev with adequate version
> number that pulls in my own libc header package, or rename that package.
>
> <sigh> It's going to take me a while to research how best to split this
> stupid knot.

Oh, no, that's great. It explains why you don't see the problem, and
Dave and Zorro do. Perfect.

No need for you to install any liburing packages, at least for this
issue. You'll probably want it eventually just for test coverage, but
for now it's the smoking gun we wanted - I was looking at why vhost
would be impacted, because that commit so intentionally *tried* to not
do anything at all to io_uring.

But it obviously failed. Which then in turn explains the bug.

Not that I see exactly where it went wrong yet, but at least we're
looking at the right thing. Adding Jens to the participants, in case
he sees what goes wrong.

Jens, commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix
freezer/ps regression") seems to have broken core dumping with
io_uring threads, even though it tried very hard not to. See

  https://lore.kernel.org/all/20230611124836.whfktwaumnefm5z5@zlang-mailbox=
/

for the beginning of this thread.

Honestly, that "try to not change io_uring" was my least favorite part
of that patch, because I really think we want to try to aim for these
user helper threads having as much infrastructure in common as
possible. And when it comes to core dumps, I do not believe that
waiting for the io_uring thread adds anything to the end result,
because the only reason we wait for it is to put in the thread
register state into the core dump, and for kernel helper threads, that
information just isn't useful. It's going to be the state that caused
the thread to be created, not anything that is worth saving in a core
dump for.

So I'd actually prefer to just simplify the logic entirely, and say
"PF_USER_WORKER tasks do not participate in core dumps, end of story".
io_uring didn't _care_, so including them wasn't a pain, but if the
vhost exit case can be delayed, I'd rather just say "let's do thig
thing for both io_uring and vhost, and not split those two cases up".

Anyway, I don't see exactly what goes wrong, but I feel better just
from this having been narrowed down to io_uring threads. I suspect
Jens actually might even have a core-dumping test-case somewhere,
since core dumping was a thing that io_uring ended up having some
issues with at one point.

           Linus
