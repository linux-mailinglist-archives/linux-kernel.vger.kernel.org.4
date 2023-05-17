Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08C707651
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQXPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEQXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:15:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF724213C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso1840512a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=L3qjB3VaqsqlOiGB5yeTiiPsIIfhodMmHKQY2F8CmzC2L7OHTbVab0xh8JeM0wAPRf
         MVnA11JyPXHzfj84mH2U6ojLkg5Bs+WuZdXTkNXfkEFxQ3AqIyqzUyF4jEc8wFX0MnLP
         qf/BBm0TbuUJvdeQBAKk9cgSNfVYQQ9hV9DHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=LV7ycN5ssjLGOdUzfbs46jJOurTbY2Psj6eZI4MW38G6pTP8pY4px6FzGZO3PT1YyM
         Cfn6KG3oXsvBaOrgnYL9jp71WU+Q3uBRQ37LxXjpaNa1mXvsXPe9HYKfBQcAgLbPW0ar
         BpYmnvd1zlwaKPv+JV1TJQNwiTjeN1bJjrRbTSZdODbxXiv2SHYzwy2qHK4N4lagBEY8
         x+lXw1e/1SzO+zB5P9rS44vDXryUYESDud4yDQkKgclcwsPeU0RikxxvOz9+ay89gHG+
         kx847AcCuzxkhnF/QAn3YztJmKnjSye1dQOdBBUNkhCP6Xo3K5x0GC5m/ZmpBHDIcjzl
         hEcQ==
X-Gm-Message-State: AC+VfDxkfmxraIigkTVe2H0onr15s4Ql7NcVKF1BMG+DGm+DLa0Dgpbu
        4z9vgUT5fBSudZBk1TTazzJHZfZaqnb8H/mdwkjwbiG5
X-Google-Smtp-Source: ACHHUZ7n4CJCSQ8x56SUgOPnh/MCVXJ7bbtdpGLSEMfLO+8xXKlU2sBevrxzQaUUmlJfcHuNsyaK7w==
X-Received: by 2002:a17:906:db07:b0:94f:6058:4983 with SMTP id xj7-20020a170906db0700b0094f60584983mr33862855ejb.76.1684365301944;
        Wed, 17 May 2023 16:15:01 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709060a9500b00965cd15c9bbsm161858ejf.62.2023.05.17.16.15.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 16:15:01 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so2094310a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:00 -0700 (PDT)
X-Received: by 2002:a17:907:c26:b0:966:238a:c93 with SMTP id
 ga38-20020a1709070c2600b00966238a0c93mr38602562ejc.68.1684365300509; Wed, 17
 May 2023 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com> <20230517230054.GA195@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517230054.GA195@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 16:14:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
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

On Wed, May 17, 2023 at 4:01=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you mind giving me your Signed-off-by for these?

Assuming you have some test-cases that you've run them through, then yes:

 Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

for both. But since I can't really test them myself, I'd really like
that. I did these patches just by looking at the source code, and
while I think that's an excellent way to do development, I do think
that testing is _also_ required.

And that second patch was obviously not even build-tested, so really
just a "something like this".

> I plan to do a series where I take these patches and then also fix up a
> few comments and the link namings as you suggested.

Sounds good.

> First patch is clean, second patch I made the following changes and
> after that passed all the self-tests without bug splats with
> CONFIG_PROVE_LOCKING/RCU and ATOMIC_SLEEP:

Your suggested version with just "list_add()" and a comment about why
it doesn't need RCU safety looks good. And the build fix obviously
requited ;)

                  Linus
