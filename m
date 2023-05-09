Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750A6FCE89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjEIT3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEIT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:29:34 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F054486
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:29:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6a5f7341850so4284480a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683660572; x=1686252572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nshW081Je0Ct1TPDyiEBPFzb8ygIPnS0SW9brrMdekw=;
        b=SYVk9dCiNpWbU5xm3mawedT7+nrWY0hZ4g0Ajqlhu0IY4UOUL8Wv1LFavtxCvkIEY5
         txdWCaBrKHVEdH9jH28dSxzADU7fefFg9W9XSS+zOn/nkOrjKViMhl4Bu46HY4CboTBa
         346FkasT5QERCvME/+vBrUBwYjNAAp4hkM51HLT7fL3mqrJBKuJMKaH8PnaJKuE+/Ik/
         daYZcNcetgbJ2wxVH3QwkE37Q3YI/9S0ns5/6JY6owwi1umOm8UvsVPapCqeXm9l4p4o
         cu9zdbs75tO6oIcnC9XOT0pnYDT7eAmEHXvUvDSuSJZzliuXXJX/y8QF5mOtPuHMpWp3
         xbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660572; x=1686252572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nshW081Je0Ct1TPDyiEBPFzb8ygIPnS0SW9brrMdekw=;
        b=Wpu37TN7vz8SDTDH3/OuuDXg0gYL+OlW/InDFIpAQbtR+Q0TGZu7eBtZJ4csQ8AiA3
         vlwpDPBgsGrsg/oIZ+w/SAZRf4zLPE4LiFw8D0R/ZPwVOOLjqsjR/nCP6vCno200o3Ym
         CAOW/UdLnRtIAk3j1kKS5G+aedmZ+SBI5DC3b3fg/tFsT/0F8fP3nkQijYXtMacSSy6E
         Q/vHULulLUBo+68qCej2MHEQfTBJqsKuXgPUK3R6WBm8woOQvzVfmVhiGzukg/804Ax3
         4t5cvX0vZcrUXT8ymZ7u2VUCSmHlokFGe0dMoJ6/qKkXb5/3UpjWnjRoHhxAQXCehiTB
         yQLQ==
X-Gm-Message-State: AC+VfDxr5EZS/XwXhjJPnoo9BPEXJwtOL3OWXw3T4iApRLICk58ciyVi
        a1kIMloNqDF0GWUbT7O5CyzRuBpMIj78h7cwPAkEcg==
X-Google-Smtp-Source: ACHHUZ4ttVO3Kjk4VenwZACti+SYmo33rOMANrlfvXvsQMH2mfyKDcS+h8h/fB6FhOlKkjQGCrfo/62tBByoJMT8n+E=
X-Received: by 2002:a05:6870:93d3:b0:183:fc80:7354 with SMTP id
 c19-20020a05687093d300b00183fc807354mr5723936oal.21.1683660572023; Tue, 09
 May 2023 12:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230508160829.2756405-1-vineeth@bitbyteword.org> <20230509132534.09098acc@luca64>
In-Reply-To: <20230509132534.09098acc@luca64>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Tue, 9 May 2023 15:29:21 -0400
Message-ID: <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luka,

Thanks for reviewing the changes.

On Tue, May 9, 2023 at 7:25=E2=80=AFAM luca abeni <luca.abeni@santannapisa.=
it> wrote:
>
> Hi,
>
> if I understand well, your patch addresses 2 separate issues:
> 1) The current reclaiming code uses an approximation to avoid using
>    div64_u64(), which might introduce too much overhead (at least, as
>    far as I remember :). Your patch changes it to use the exact,
>    non-approximated, equation
> 2) Currently, the reclaimable CPU time is divided as if all the
>    SCHED_DEADLINE tasks (and not only the SCHED_FLAG_RECLAIM tasks)
>    could use it; your patch changes the code to distribute the
>    reclaimable CPU time only to tasks having the SCHED_FLAG_RECLAIM
>    flag set
>
> Is this understanding correct?
Yes, the above two details are correct. In addition to that, I think
the existing equation had a small bug:
GRUB paper says, running time is depreciated as
   "dq =3D -U dt" where U is running_bw.
This is assuming that the whole cpu bandwidth could be reclaimed. But
in our case, we cap at Umax. So the equation should be
   "dq =3D -(U/Umax) dt"

And then we have an upper limit of (1 - Uextra - Uinact). I feel we
should be taking the minimum of these values to make sure that we
don't cross the upper bound. I think the equation should be:
   "dq =3D -min{U/Umax, (1 - Uextra - Uinact)} dt"

But the current implementation is
   "dq =3D -max{u/Umax, (1 - Uextra - Uinact)} dt"
   Where u =3D dl_se->dl_bw.

After fixing the above equation, reclaim logic works well but when only
SCHED_FLAG_RECLAIM tasks are running. When we have a mix of both
normal deadline and SCHED_FLAG_RECLAIM, it breaks the reclaim logic.
As you pointed out, the second part of the fix is for that.

> If using div64_u64() does not introduce too much overhead, then I agree
> with the first change.
In my testing, I did not see a change in the performance of the
grub_reclaim function. Both old and new implementations take 10 to
20 nanoseconds on average. But my observation might not be accurate.

With this change, it is difficult to avoid division as the denominator
is a variable and we would not be able to pre-calculate an inverse. We
could probably calculate inverse during {__add/__sub}_running_bw so as
to reduce the frequency of div64_u64. I shall try this for v2.

> The second change also looks good to me.
>
> I have no comments on the code, but there is one thing in the comments
> that looks misleading to me (or I am misunderstanding the code or the
> comments):
>

> > + * We can calculate Umax_reclaim as:
> > + *   Umax_reclaim:   this_bw + Uinact + Ureclaim
>
> I think this looks like a typo (summing this_bw to Uinact
> looks wrong). Should "this_bw" be Uextra?
>
Thanks a lot for pointing it out. Yes you are right, I messed up in the
comments. It should be Uextra and I shall fix it in v2.

> > + *   dq =3D -(Ureclaim / Umax_reclaim) * dt
> > + *      =3D -(Ureclaim / (Ureclaim + Uextra + Uinact)) * dt
>
> I think this should be the correct equation. BTW, since you are summing
> Uextra and Uinact, mabe you could just use "Umax - running_bw"?
>
Makes sense, it will avoid an extra variable Uinact. I shall modify this
in v2.

Thanks,
Vineeth
