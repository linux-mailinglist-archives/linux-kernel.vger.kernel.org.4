Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE5673D520
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFYXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:04:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D801A3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:04:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso7533711fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687734290; x=1690326290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMSRVSKvdMX0dea+B6+Hs/HDDXnMxvCzvCL3UJTsBTg=;
        b=eS9u/bq1l3sG+ndTIlBSp/rjKrVlUhGF0tXq1bR7Mo/A9ALfWw47pkkF/8krym8Glo
         rk3FOIwctxHg7R96nGyFYg4kOkcougICh6lyToi9YPOEHEeePRREOU1RL0sTpq8swTMA
         2oed0S1O1OPmAUZrB1BGEwy15w1eWpuf5XlyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687734290; x=1690326290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMSRVSKvdMX0dea+B6+Hs/HDDXnMxvCzvCL3UJTsBTg=;
        b=Gna0shA6cu0KQNBb4NyG+TeDpL9oeVgfkXjpXaLvBfOvIiajPamIDceUV0g4iNklMF
         K+oYjc2eqC9D1TJJOaxUK5QDq/FPTaWspouGaqKpxkLjpMMEXbTgp6VRrafVk0/OfPUp
         HWvw9wJgeUKjRuyXCwQ25igGMlOOy1OAZ8NZY6dpUuDYZz87+jQ6jq4K+Y2vpHkxCx3d
         a28puvZ9J6BUFxqxuRkZWseDX4pHlVC8aVGf4ODyZJ01qt3tpkfbrvr9N2Z2x3rejtiq
         8y2KHQxSEJeP6VTf3LOzvtxMJVMhOFEiuFktkMAldpIlB5LwElgKoZRen+DXOXy8knZT
         1Qsw==
X-Gm-Message-State: AC+VfDzPs5kf34xmHLjDd+2T2ABCqL52Ewa/hai6hNDQ1uoRBlaIFNnz
        NZlJSY7RumKRQU6/xn17oZjToqiXmG3iWB//W4y9m6AO
X-Google-Smtp-Source: ACHHUZ73PXftJbveDVAEGkI3GxSx08G3eLMAu2nNEWOjrRm4W2HRMGIqgxdvu/s3APXaCBXK3eg+PA==
X-Received: by 2002:ac2:4f0a:0:b0:4fb:7404:538b with SMTP id k10-20020ac24f0a000000b004fb7404538bmr596272lfr.66.1687734290119;
        Sun, 25 Jun 2023 16:04:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7d90f000000b0051bc5adc942sm2191633edr.47.2023.06.25.16.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 16:04:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so1716747a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:04:49 -0700 (PDT)
X-Received: by 2002:aa7:d34b:0:b0:51a:4963:e00d with SMTP id
 m11-20020aa7d34b000000b0051a4963e00dmr15123627edr.15.1687734288864; Sun, 25
 Jun 2023 16:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230623152926.128aa568@gandalf.local.home> <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
 <20230623220959.6461cc02@rorschach.local.home> <20230624135056.263e0ba9@rorschach.local.home>
In-Reply-To: <20230624135056.263e0ba9@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jun 2023 16:04:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirKv866nP=v3uBf0TTvaPxfSvAQUJfL2KB-NZboBVUaQ@mail.gmail.com>
Message-ID: <CAHk-=wirKv866nP=v3uBf0TTvaPxfSvAQUJfL2KB-NZboBVUaQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: user_event fix for 6.4
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 at 10:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 23 Jun 2023 22:09:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > The code that does the write is basically something being monitored by
> > something else that will tell it to start writing. But that something
> > else could have the buffer disabled for writes. The use case for this
> > is to disable the buffer, enable all the trace events you care about,
> > and then enabled the buffer which is the same as enabling all events at
> > the same time to get a more coherent trace.
>
> Are you fine with the above explanation?

Honestly, I still think that returning zero is completely crazy.

It's exactly the wrong thing to do.

"write()" returning 0 is only normal if the passed-in length was zero
to begin with, and then it can actually have special meaning (ie
zero-sized writes have historically been used for STREAMS etc to do
EOF signalling to the other side, and/or are used to detect pending
errors).

There is one "return zero" case I know about, and it's the "disk full"
signalling (kind of EOF) for block devices.

If you are reading the man-pages, and your eyes found this:

   "In the absence of errors, or if error detection is not performed,
    the write() function shall return zero and have no other results"

I'd like to point out that that is exactly the "pass in a zero length
to write" case. That verbiage is all about "write(fd, buf, 0)"
possibly returning zero _or_ an error if an error was pending (and was
detected).

So returning zero from a write is basically insanity. It's not a valid
error case.

And it's a *dangerous* return value, because if you have some write
wrapper that is trying to deal with partial writes (think pipes etc),
I would not be surprised if there are cases of that just looping
forever on a zero return.

In fact, I went to Debian code search, and looked for "= write(" as a pattern.

The VERY FIRST hit on Debian Code search was this from LibreOffice:

    bool safeWrite(int fd, void* data, std::size_t dataSize)
    {
        auto nToWrite = dataSize;
        unsigned char* dataToWrite = static_cast<unsigned char *>(data);

        while ( nToWrite ) {
            auto nWritten = write(fd, dataToWrite, cap_ssize_t(nToWrite));
            if ( nWritten < 0 ) {
                if ( errno == EINTR )
                    continue;

                return false;

            }

            assert(nWritten > 0);
            nToWrite -= nWritten;
            dataToWrite += nWritten;
        }

        return true;
    }

which loops forever if NDEBUG is set, otherwise it will print an error
message and abort.

See why I think returning zero is such a bad bad idea?

There is NO EXPLANATION that makes it ok. Really. It's a huge bug, and
wrong on all possible levels.

The fact that your explanation is "we have that bug in other places"
does *not* make me any happier.

              Linus
