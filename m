Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222176BD5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCPQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCPQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:33:25 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32AE4C47
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:33:06 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s1so2035222vsk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline.eu; s=google; t=1678984384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8B3d1S23a0KcdvhQ92wJ0437Yle3gXb1RhMvXQci9J4=;
        b=n3e8Z5+dg1VAXR3+2t7jvGEZ0CD9VH4XhsWI7+ik2wPXMAxg+l16LkJpv0W2LdM/kQ
         Dx1KnhuUGHtXBlwIPfJQ30OtaFjaOpv9/DG2+DNtBrTlE5VXeCUzpwTOqEgXqy6umNT8
         VNFEb8ROJvoQsqTlUcOAVqfv+ZFRLP5nfaXKhgAGwTF2C/1UBuGYpeao1c7gQyYfZwtC
         jg0fSR+/xcvCL0oKgjb1RdchjH4CSaDVM3KDlrYXr7QkJMOG/zmDhEWfOCHuzUvTV5gI
         nALMPqWL1pI43yXcTY5yJiU3wl5fTyU4i2swTmP3spRIPLg0FKnNPvu6UBaZ2ZrRBiSz
         arFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B3d1S23a0KcdvhQ92wJ0437Yle3gXb1RhMvXQci9J4=;
        b=UZxyu2ZXxJvwHRRr0VmiqZwdXR5JZpwBH+52WFvyxI1/juVlyBfwSGhM1DJGsjqjVh
         RgTbQI9y8Qaz3U/WlGrd3Siqm/SBSmdC0r4hbQpifwz8OR5paZz/gwy7zKEzHq0vWbdA
         UefQvtIL8kYpuRWcZP9t0+OPVMrwCr0CkWbzdoZs9vFBVqqRocFmWsDIM7jMp9D/bolX
         qe8rZCOOi/eCCk+4xVp1Ie+3pjbjSOGOyLebeeFzQ33crpNF2uf8JqQaLh6k2UB1kuNC
         C2wleIIkfbdQus90QHksgYWQShgUZXvqCNIezqWu6lryRzbJjtW6u8jjMCPsazeQueEs
         tjIQ==
X-Gm-Message-State: AO0yUKWOz19Sr6XlIkvHE7MaDXVfcUAI0mxi57YO4J4M/jeLzVZzfZGX
        Bt7SSVumR8wYXojPMEgaIEO5+q+NsqTx9CvwwEC6zwCz6avdXIuAPe4=
X-Google-Smtp-Source: AK7set/XYqoEoZ9PRe4KKx8z5WDa0F2MzP0birljKpD5C5T4HsZGI9FkOxeUI629ouWfkVjQHhuAZxyfMTsiuWWWh8k=
X-Received: by 2002:a67:ea49:0:b0:411:a740:c3ea with SMTP id
 r9-20020a67ea49000000b00411a740c3eamr29958526vso.0.1678984384556; Thu, 16 Mar
 2023 09:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132616.794171-1-timo@incline.eu> <20230314192740.GQ2017917@hirez.programming.kicks-ass.net>
In-Reply-To: <20230314192740.GQ2017917@hirez.programming.kicks-ass.net>
From:   Timo Beckers <timo@incline.eu>
Date:   Thu, 16 Mar 2023 17:32:53 +0100
Message-ID: <CANgQc9jF_wimvUsC0ck7o5w3oEwJ5g7DS0DRQqNm57X-WdGz=Q@mail.gmail.com>
Subject: Re: [PATCH] perf core: apply calculated padding to PERF_SAMPLE_RAW output
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 20:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 19, 2020 at 03:26:16PM +0200, Timo Beckers wrote:
> > Zero the amount of padding bytes determined in perf_prepare_sample().
> > This prevents garbage being read from the ring buffer after it has wrapped
> > the page boundary at least once.
>
> But it's user garbage, right?

Hey Peter, correct. Not a security issue, but rather a usability one. (IMO)
It would be nice if the receiver could verify if the trailing bytes
are all zeroes
after interpreting the payload. (I deal with Go interop; C<->Go struct
alignment behaviour differs subtly, so this helps debugging)

I know the ship has sailed and it's been like this for a long time, but getting
it fixed in a non-invasive way would be neat if the performance penalty is
not too steep. I think Jiri was playing around with some benchmarks.

> And they should be unconsumed anyway.

Well, not quite. perf_event_sample.size contains the size of .data including
padding, so the reader always needs to copy out the full event, which
potentially includes garbage. .data is completely opaque from a generic
perf reader POV, so it can't automatically trim it or choose not to read it.

Haven't looked at the kernel side in a while, but maybe setting .size to
the length of the input on the bpf side would be a better solution? Then no
zeroing needs to be done. I assume there's no strong need to increase
.size in 8-byte aligned steps, as I currently see values like 4, 12,
20, 28, etc.
Please correct me if I'm wrong.

Thanks,

Timo

>
> > Signed-off-by: Timo Beckers <timo@incline.eu>
> > ---
> >  kernel/events/core.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 80cf996a7f19..d4e0b003ece0 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6807,8 +6807,16 @@ void perf_output_sample(struct perf_output_handle *handle,
> >                                       break;
> >                               frag = frag->next;
> >                       } while (1);
> > -                     if (frag->pad)
> > -                             __output_skip(handle, NULL, frag->pad);
> > +                     /*
> > +                      * The padding value is determined in
> > +                      * perf_prepare_sample() and is not
> > +                      * expected to exceed u64.
> > +                      */
> > +                     if (frag->pad) {
> > +                             u64 zero = 0;
> > +
> > +                             __output_copy(handle, &zero, frag->pad);
> > +                     }
> >               } else {
> >                       struct {
> >                               u32     size;
> > --
> > 2.26.2
> >
