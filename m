Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C063F9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLAVSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLAVS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:18:28 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F91B9563
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:18:27 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id x28so1522247qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HW+cTjgUb12iPneEGhpx2Sj/vvbmNf0F1OcpCH35RNU=;
        b=QxmG7c3ME3To4xBvAFTW6sn90UZSOww6KeX77UGdKbCZj15VPqTsNLZXGE6wm3D3g2
         psaRthOFthZceHh5d53zWWZcnoCpjgNah6WFCqEWG3aUI7qxemUoEn0Qgv29m8PXD2SJ
         tCy9c4QdWcsc+iBDkh0zep+dKdcw2R10puGwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HW+cTjgUb12iPneEGhpx2Sj/vvbmNf0F1OcpCH35RNU=;
        b=rMm/xTWssSSSrBP2fgnvITsUpddyPDn8mEvVFvqrRNJ0k1yk5JrUatYmLQ/w1QUh3d
         rkjTONna+aGPEJOgCnxLILFYA1EUlecF5Quc7pM/+/8WzZmOaoBc7hV8OpoC5A661U3U
         NcX2jYNTpZynMRgY5x3yvqX8p+4nf/InoBCXsCAw6rloSOe0B9HTjj98nCfNZTbiZOjC
         guZrMwXEvCC/9WF8/SLwOuwKk//JHNJwqD3QMqfYmwmD8czJ2rJCdhXZfPlmezevQvAM
         hMj/LtqXlS/k+CczIHuohZRMPKbXLrJTgQSj2kqgdke7zjur3QZMxTcL0LH07sCJib1+
         /+kQ==
X-Gm-Message-State: ANoB5pmXDVX3xmJHz26dpPLWZ6V5672qNknRTnqPi4X/SLyZVfZIzmRZ
        dwC7XIcx957F4wuk7MSX8/pwq3UkPEkKBA==
X-Google-Smtp-Source: AA0mqf6CB0+TNgO5uqK1b6ae3JIZvXfSXaLL82cqwwd4iH8r50OZySyci70QDqzmw7PSabpUNKl6hw==
X-Received: by 2002:ae9:dec2:0:b0:6fa:1c6f:1674 with SMTP id s185-20020ae9dec2000000b006fa1c6f1674mr43323496qkf.219.1669929506679;
        Thu, 01 Dec 2022 13:18:26 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id c11-20020ac8660b000000b003a586888a20sm1869485qtp.79.2022.12.01.13.18.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 13:18:25 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id a27so2622422qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:18:25 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr61404296qkk.72.1669929505133; Thu, 01
 Dec 2022 13:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
 <166991263326.311919.16890937584677289681.stgit@devnote3> <202212010838.B0B109DA@keescook>
 <20221201114848.13a87aca@gandalf.local.home> <202212010852.6D4B542@keescook>
 <20221201141426.08411b29@gandalf.local.home> <78b7a67f-8c5b-6b2e-7fb5-01c47d75c104@meta.com>
In-Reply-To: <78b7a67f-8c5b-6b2e-7fb5-01c47d75c104@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Dec 2022 13:18:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_rTJOjbMxtyWe41QNMs2ojYTHhyNrAEebz-fyGh5Wiw@mail.gmail.com>
Message-ID: <CAHk-=wi_rTJOjbMxtyWe41QNMs2ojYTHhyNrAEebz-fyGh5Wiw@mail.gmail.com>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
To:     Chris Mason <clm@meta.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:00 PM Chris Mason <clm@meta.com> wrote:
>
> On 12/1/22 2:14 PM, Steven Rostedt wrote:
> >
> > That is, please add why this is needed for BPF (and also include a Link:
> > tag to this thread).
>
> Sorry, I'm completely failing to parse.  Is this directed at Kees or
> Benjamin?  I'm also not sure what the this is in "why this is needed for
> BPF"?

It's not at all "needed for bpf".

There are mis-uses of error injection that have nothing to do with
error injection in linux-next, and some people have argued that said
mis-uses are a valid.

They aren't. They need fixing. Thankfully they haven't made it
upstream, and I most definitely do not want random users mis-using
"error injection" to inject random bpf code for non-error cases.

              Linus
