Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADD6F3A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjEAWCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEAWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:02:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90970EB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:02:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef36d814a5so21391cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682978568; x=1685570568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUoPyEclplnbQ5nsG5OgNwVF48A7g0Micb2U/fMXHNA=;
        b=S3AYc2AIegwzM337Nai49vEIytMZBsPs3Yrvsbb8mZULcD9O2VW51PF3j9yS1A7HSo
         IlqcrY7C+y6Kq38ke2szkFf2Y8u7VeR4dc2nIiwrKxJIKPcjT6TgB5qcoBNEgKJXRZ7R
         +YorsZjxiZemj2YzPi/yrHHuqZ+UIhEK+MSXclZaFNzcfYMv0yVSY+tnaRbBBtaNQCIW
         utYRShodnQaza8a6GNhfGxL5OqRlmEsRJCfGx/dQpvzqU+uqq63IeoBjrmrmuxj5jBTx
         bVafRuqwBCY82Zqna0Ez00l66KSNjysu8FrC/neMwZv23TBHDocD6EKWx2z/+f0dcK5O
         14LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978568; x=1685570568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUoPyEclplnbQ5nsG5OgNwVF48A7g0Micb2U/fMXHNA=;
        b=gqE3Lyog7fEHLLKRXaAJk7j333NDVvMMVhH8kDMjP9T2TmXw1fqKefGqE8GW8ARYcy
         0EtKg+JAcsNPC4q2OEVTA7b8hOB6FMWSXsAoq6tmPLX1lf9woFsvZgnBeX81sj90GNHE
         7CKgtpMZ2IDTfXuUZYNMPsRQZeNmV7g8CF2n9UXKMR7sJ5VC9Q8SVkc7keGm3uAG1jN6
         g7FFZgJ8XeGDVEQwOodeLt/veEWx+O+jYO0phw4kYMzR8SNDZU9RbHew/k7gvtQJdQHQ
         JY+BbsW5WPRdAszNt94x9L8uOh4jUSKqna53QBm/RByDhDrUYpE7UDi+tw4K7p/R5yO/
         /mYg==
X-Gm-Message-State: AC+VfDz1tu66ULAB7WEJh5V7dCjpZbe5O4rJ6Xx/shqJqkqKYNGzSiQr
        wlOE9XM5KAq60qqm1IbQ+Z7yVh5V00xeERoEsssPnQ==
X-Google-Smtp-Source: ACHHUZ5CuqN0ueoP6LXfs8ZQiH2iNDJ0f/JbMmFWBRGoqTLO5Al7z/X8HDiTurSelO2YjDTLfuq7qw0/Vdw1XZ8K+mA=
X-Received: by 2002:ac8:7f47:0:b0:3ef:62f2:52df with SMTP id
 g7-20020ac87f47000000b003ef62f252dfmr21723qtk.9.1682978568636; Mon, 01 May
 2023 15:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
In-Reply-To: <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 1 May 2023 15:02:37 -0700
Message-ID: <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:45=E2=80=AFPM Peter Collingbourne <pcc@google.co=
m> wrote:
>
> On Wed, Feb 15, 2023 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> wro=
te:
> >
> > On Wed, 15 Feb 2023 09:57:40 +0100
> > Marco Elver <elver@google.com> wrote:
> >
> > > Yes, you are right, and it's something I've wondered how to do better
> > > as well. Let's try to consult tracing maintainers on what the right
> > > approach is.
> >
> > I have to go and revisit the config options for CONFIG_FTRACE and
> > CONFIG_TRACING, as they were added when this all started (back in
> > 2008), and the naming was rather all misnomers back then.
> >
> > "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> > really should just be for the function tracing infrastructure, and
> > perhaps not even include trace events :-/ But at the time it was
> > created, it was for all the "tracers" (this was added before trace
> > events).
>
> It would be great to see this cleaned up. I found this aspect of how
> tracing works rather confusing.
>
> So do you think it makes sense for the KASAN tests to "select TRACING"
> for now if the code depends on the trace event infrastructure?

Any thoughts? It looks like someone else got tripped up by this:
https://reviews.llvm.org/D144057

Peter
