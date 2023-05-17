Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F17705C99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjEQBqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEQBqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:46:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530E30F6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so271074a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684288008; x=1686880008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=UxzPI//Y+e8V0S88o5eJxyixOdJbSlW4tDwH0wjDBiNm5Yd67+p5ysTPqR9rB50IpD
         mRkXFCClc5nX0olQJRbsBu2Ak/1PjoAVdxBfhtfssBJ9LfuncXJ0h/3LNkl+sq3GY1hM
         yVdb1DDL7Hd7Wa1lDR9EKdDxkxf899GsKu9qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288008; x=1686880008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=If8YCq1SmFXprfZE5WRW8O8FvSDm0r0KWfH8sCbAlhQxfCTooeD+q0qOgxrT980yLF
         61pVzLYNw6OsAgrWmx06Ijv9Dbcuck1j/vk6wqhi2uU22Q3OxuOgF1hJkJ22XTg9Q0BL
         NQndvxm+eROY3GVbQQuwpyfIxzq3Nnmg0KNiJllKyFWHjvmNSI519kO7+mMB/y4IJ1na
         zd5xUInSy3z1CeyomtQSuST1yBLUcwn1oTuXP0I7izrq96msswU2kdC4OIIHUSI3bnQ7
         tMjxiilT3/0Jb/llkjmf73QjEVdP9HOdsbWtd/Y3B0gWuiSeSF6po6D/p3t4YyCXJmdI
         AQHw==
X-Gm-Message-State: AC+VfDy3P9T0Gikkh3j1m4rrdMguwQbOzagFLCv8Bv++puaXVKs9I16K
        I6o1GXF5/CHzvO/2vnZxzfALj0aVWrveuxABsudCcg==
X-Google-Smtp-Source: ACHHUZ5tZffvHeJYB3itfTFTVrF/AgWr702gbN86blK0m4vWjcUOXFzApN/cdmw2q8H5VUuAuHoTiw==
X-Received: by 2002:a17:907:9810:b0:96a:861:a2ac with SMTP id ji16-20020a170907981000b0096a0861a2acmr25268817ejc.0.1684288007811;
        Tue, 16 May 2023 18:46:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id ci17-20020a170907267100b009682b2b3d66sm11542288ejc.197.2023.05.16.18.46.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 18:46:46 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so285450a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:46 -0700 (PDT)
X-Received: by 2002:a17:907:1c9e:b0:96a:9c6:d75a with SMTP id
 nb30-20020a1709071c9e00b0096a09c6d75amr24685640ejc.24.1684288006002; Tue, 16
 May 2023 18:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
In-Reply-To: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 18:46:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Tue, May 16, 2023 at 5:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That code depends on all the usual MM locking, and it does not work at
> all in the same way that "pagefault_disable()" does, for example.

Note that in interrupt context, the page table locking would also
deadlock, so even though it's using spinlocks and that _could_ be
atomic, it really isn't usable in interrupt (much less NMI) context.

And even if you're in process context, but atomic due to other reasons
(ie spinlocks or RCU), while the page table locking would be ok, the
mm locking isn't.

So FOLL_NOFAULT really is about avoiding faulting in any new pages,
and it's kind of like "GFP_NOIO" in that respect: it's meant for
filesystems etc that can not afford to fault, because they may hold
locks, and a page fault could then recurse back into the filesystem
and deadlock.

It's not about atomicity or anything like that.

Similarly, FOLL_NOWAIT is absolutely not about that - it will actually
start to fault things in, it just won't then wait for the IO to
complete (so think "don't wait for IO" rather than any "avoid
locking").

Anyway, the end result is the one I already mentioned: only
"get_user_page[s]_fast_only()" is about being usable in atomic
context, and that only works on the *current* process.

That one really is designed to be kind of like "pagefault_disable()",
except instead of fetching user data, it fetches the "reference" to
the user datat (ie the pointers to the underlying pages).

In fact, the very reason that *one* GUP function works in atomic
context is pretty much the exact same reason that you can try to fault
in user pages under pagefault_disable(): it doesn't actually use any
of the generic VM data structures, and accesses the page tables
directly. Exactly like the hardware does.

So don't even ask for other GUP functionality, much less the "remote"
kind. Not going to happen. If you think you need access to remote
process memory, you had better do it in process context, or you had
better just think again.

               Linus
