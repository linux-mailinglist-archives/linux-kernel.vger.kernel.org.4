Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9C6FAFB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjEHMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjEHMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:12:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649443847E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:12:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6438d95f447so2960188b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683547946; x=1686139946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YomQZvLv9U8LydRAVDM7uH3rsydf2VckIT0qLaKYgH4=;
        b=Py7muHYwG6zPRaX+oumvWzOw51CdAo3uRtkps3zvOagnhnvPdHNPQ4hj4BETg3uIY3
         bw1MOFvCMil2kTbJk29QVjD7BiIg/oMwHlbe5nLO92s/vk7WffTRgxwSGi6ZHaur+mRH
         yO/zQLQLt26bqzF891XuY4xqbC5aM5Nv0Uw04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547946; x=1686139946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YomQZvLv9U8LydRAVDM7uH3rsydf2VckIT0qLaKYgH4=;
        b=gh/0BXRmnVji2wLzGwc0s0g/i+KnvHy4K9SeIAV0lb4gHIdmCu13DRgVm5BxkG2j3S
         8LbutUGpbDKMv9Y3lq9oK1U9pkk4GXYGYVv2WxpAO1JGAl118HbYR6tdM8SJbH8K7tt7
         VKChw+h53RoRGB6lBXuwuNvqebwL3HSWbGaVskKnHE1YVnP2PL8oqvMqnVkNpKocIvUZ
         dBQtfgo3qHfnzMF4Oldb2wvEUbEnj98dLlbvgHwBV5hkedKQBVmECzQdnW7XoXSeQxuW
         cIWEAjLsBPY/44hAWeXeIT8TOFyEsJXJlq088bulNqJGCMlXv1QxYEQ4jq6jORnUoT3H
         rVJg==
X-Gm-Message-State: AC+VfDwqmQmfRiu+QgMh4Unm0a7xVFf5BXL/YfidcumC+Xcet6+pViFf
        eQFsDWSidY3VvjM4BGBNStV1WTcijm32icgOlwNrZw==
X-Google-Smtp-Source: ACHHUZ7VFRVjNcNqpJzwYp7zp0ZTeknZGMvtFs1Y57kRo83uZmvZygCrpjIHaDKG8rxlno+Rrsl3kSNWXGC1Gi9q+F4=
X-Received: by 2002:a05:6a20:3ca9:b0:100:1044:9ce2 with SMTP id
 b41-20020a056a203ca900b0010010449ce2mr6052128pzj.56.1683547945910; Mon, 08
 May 2023 05:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <20230504170942.822147-5-revest@chromium.org>
 <66900d0ad42797a55259061f757beece@ispras.ru> <CABRcYmKXrPE0oP9R=qsn=mL3Nwm_mVqT-r-TvOvowTdiuYU--A@mail.gmail.com>
 <3a38319a3b241e578729ffa5484ad24b@ispras.ru>
In-Reply-To: <3a38319a3b241e578729ffa5484ad24b@ispras.ru>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 8 May 2023 14:12:14 +0200
Message-ID: <CABRcYm+SUV9HThByGcTfS8K+f5KRxgD1SWnc5iqWTqgipsCP0g@mail.gmail.com>
Subject: Re: [PATCH 4/4] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 11:26=E2=80=AFPM Alexey Izbyshev <izbyshev@ispras.ru=
> wrote:
>
> On 2023-05-05 19:42, Florent Revest wrote:
> > On Thu, May 4, 2023 at 10:30=E2=80=AFPM Alexey Izbyshev <izbyshev@ispra=
s.ru>
> > wrote:
> >>
> >> On 2023-05-04 20:09, Florent Revest wrote:
> >> > Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> >> > PR_SET_MDWE prctl.
> >> >
> >> > Signed-off-by: Florent Revest <revest@chromium.org>
> >> > ---
> >> >  tools/testing/selftests/mm/mdwe_test.c | 95 +++++++++++++++++++++++=
+--
> >> >  1 file changed, 89 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/tools/testing/selftests/mm/mdwe_test.c
> >> > b/tools/testing/selftests/mm/mdwe_test.c
> >> > index 91aa9c3099e7..9f08ed1b99ae 100644
> >> > --- a/tools/testing/selftests/mm/mdwe_test.c
> >> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> >> > @@ -22,6 +22,8 @@
> >> >
> >> >  TEST(prctl_flags)
> >> >  {
> >> > +     EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), =
0);
> >> > +
> >>
> >> PR_MDWE_NO_INHERIT is defined to an int constant, so passing it to
> >> prctl() without a cast to long or similar may produce wrong code on
> >> 64-bit targets (ABIs typically don't require the compiler to clear the
> >> upper 32 bits of a 64-bit register when passing a 32-bit argument, so
> >> va_arg(arg, unsigned long) in prctl() implementation might get junk).
> >
> > Ah, good catch Alexey! :)
> >
> >> Arguably, defining PR_MDWE_* to plain int constants is a bug, or at
> >> least a footgun for users of uapi headers.
> >
> > As part of the next version of this series, I'm happy to:
> > 1- change the existing PR_MDWE_REFUSE_EXEC_GAIN to 1UL
> > 2- introduce PR_MDWE_NO_INHERIT as 2UL
> >
> Yes, I think it's the right thing to do. I suggest to spell them as (1UL
> << 0), etc. for consistency with all other unsigned long flags in the
> header.

Ah yeah, absolutely! Good tip too, thank you :)

> > But I'm surprised that most of the macros in
> > include/uapi/linux/prctl.h are the same sort of footguns already ?
> > Hasn't it been an issue for other prctls yet ?
>
> Yes, they are. I'm not aware of a public discussion of this specific
> issue, but note that at least for some prctl() options the kernel
> doesn't care about upper bits because arguments are truncated before
> doing anything else with them (e.g. for PR_SCHED_CORE raw prctl()

That makes sense

> arguments are implicitly converted to what sched_core_share_pid()
> expects). Also, actually getting junk in the upper bits might not always
> be easy (e.g. on x86-64 all or almost all instructions with r32
> destination operand clear the upper bits). Unfortunately, I don't have a
> better answer than this.

Okay, I was just curious, that's good to know
