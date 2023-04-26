Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A996EF7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbjDZPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbjDZPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:24:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C9930C1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:24:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so13331352a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682522694; x=1685114694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPvsDH5jNOVR6Eyv2yuotNriNEuFABwoitK5mC3a5ek=;
        b=Ep+byN//ShUm0mEnGmNhxSFePnJp5vzi/a5Tbgi9cE9lQBsqLMsgePrOCr5nTLNIrp
         YBcbWvcF2e3Zf0LwQH9mG27s/jkD82N9kAWuTDHbxusogXZOODbKxbPKC9UaJQYOa+x/
         MOMG6+B2CQe9elGCd/3sEkyhHrWtkDG77mvdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682522694; x=1685114694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPvsDH5jNOVR6Eyv2yuotNriNEuFABwoitK5mC3a5ek=;
        b=cGbRw3RZA9oGY8EfOBu+Q4cKoN3Pvc5dq5NC1D/5cD4Ua3tzQXoLRDvAiWF7NGenGa
         UyXjLjl48NLswk7Zcxf7hAvy+dtkuX+Gh80xG+SNlXgVeYufhnOTYXmR7m5q3XnkiEri
         24V2l+9j9UKGROcjoiPXOKQTMn3Z/6ofSlhhVBmzlHOskksENloGiPzo33zzm+njIl/f
         JCQ+1CUUGcuN6VCbeqbmCUZEyWagJCiiWwrGToxklm7Q6P1+lVsei0SBlNAyL8sWi5cK
         wf0AsGHWvA+mTDgLLKjD6qif82WUy5GcF/oG2Jmto3Tf6Z9zAO5OaQGaN+5yC0w6DBZV
         a7Ug==
X-Gm-Message-State: AAQBX9cNtNQUj8ZvxIO0guX4tFVUDsG9Qdj9aCROUE27sXSJF1JgsPjh
        uVNvMCu5qoyTB7nOUwcWeH2nQ3wcI4wLeFSxTcLOtw==
X-Google-Smtp-Source: AKy350ZlpDZYoGPcg2KNTQI7vfGst/laCwxE9vmuR9pIqrUO1ntmD220obYOe8fLfMtI1Iy4yKb5WQ==
X-Received: by 2002:a50:fb04:0:b0:506:7d3e:ade5 with SMTP id d4-20020a50fb04000000b005067d3eade5mr15820424edq.33.1682522694128;
        Wed, 26 Apr 2023 08:24:54 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id bq6-20020a056402214600b0050470aa444fsm6900987edb.51.2023.04.26.08.24.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:24:53 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so13331299a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:24:53 -0700 (PDT)
X-Received: by 2002:a05:6402:2c7:b0:502:61d8:233b with SMTP id
 b7-20020a05640202c700b0050261d8233bmr20090196edx.19.1682522693062; Wed, 26
 Apr 2023 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com> <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com> <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
In-Reply-To: <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 08:24:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTw-Ct60_P+jnOfjKBAvpNJyvZENhA477Th0K6b6S3fA@mail.gmail.com>
Message-ID: <CAHk-=wiTw-Ct60_P+jnOfjKBAvpNJyvZENhA477Th0K6b6S3fA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
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

On Wed, Apr 26, 2023 at 3:09=E2=80=AFAM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> The reason I don't consider this patch a NAK candidate is that this is no=
t
> conditional locking as such because no special action is taken if the loc=
k
> cannot be acquired.

If this comes from my rant against not having conditional locking for
the O_NDELAY (well, the io_uring equivalent) IO path, then no, I don't
think something like lock_page_timout() is "conditional locking".

Some caller wanting to get the lock, but being willing to just go on
and do something else after a timeout is fine. Within the context of
something like memory compaction internally for the kernel that is
fundamentally opportunistic anyway, that sounds fine to me.

In fact, in contexts like that, even trylock is fine. We obviously
have trylock in lots of places of the kernel.

My "no conditional locking" is really that I do not think it's sane to
have user IO fail with EAGAIN just because some data structure
happened to be busy. It's a debugging nightmare with unlikely things
that happen only in special conditions. Doing IO is not some
"opportunistic" thing.

We've actually had things like that before where people tried to make
O_NDELAY mean "no locking" (I think that was driven at least partly by
the old in-kernel web server patches), and it also causes actual
problems with user space then busy-looping in a select() loop, because
the select doesn't consider some low-level lock to be a waiting event.

(The io_uring case is _slightly_ different from our historical issues
in this area, in that the kernel can fall back to the user worker
thread case, but it's all mixed up in that same IO path and that's why
I absolutely hated that "if (X) trylock else proper_lock" approach).

So a unconditional "lock with timeout" in the context of "we can just
skip this if it times out" is perfectly fine by me.

That said - the kcompactd code is not code I know, so maybe there are
*other* issues with that patch, so this is also not an ACK from me.

So please consider this just a "that is a very different case from the
one I complained about".

                Linus
