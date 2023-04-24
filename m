Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D656B6ED684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjDXVFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:05:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD66185
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso7571801a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682370335; x=1684962335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8tba+uDpkEW7dJT6XcMTrVp0OQq/mPaxrVBHBih1WQ=;
        b=VX8v4h3N/14yvstAMpfQ/TxNsG6TZa2MTPUeVu66hXV8uwCYMq5vGq+feQ1yaUQgJO
         Vq52tfGGw549jFbJJ/sDwZrM5Y1LjW9jzrrMKR4fDFc11IXc70/FRo8oqmYKIhP7mIgY
         kkvbjGEWVf/FraDkCD+AXyi8chYjXjDI68PJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370335; x=1684962335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8tba+uDpkEW7dJT6XcMTrVp0OQq/mPaxrVBHBih1WQ=;
        b=OSAx9u+JAt9rjURmnHzslByidHrewvq3gq1y/TjsoYBJ9j77MoRRnjM611g0afK+w5
         78orqHuwZ0y/FonLEIRvplYL5kd5Wk4BptBfooYBGIgvIihNoDG1Z/EsX65MGAzTMwNB
         m+gz/YBo21DQ44RvskNzNseW1qjC+ymFrM6W1p6P3QOXaibW8BZBevHZmAbbHjLYwwCF
         ++pj0LGoxhQSbPRAFWQ/mOPc3vae2KY4l6I9+e/ZoGzGXG3F/pSrYQy4+uaVj0mjGIy3
         QIN/vb0Z1jaldaF9WfiF+vGPSjTW0LJI3GTMi2pl5nIBiknA9EQYs1wDto+UXWqihLvy
         Xj3w==
X-Gm-Message-State: AAQBX9eGeig9lVfz9sihdZM9DZzYtnjOg3ebVKMkMxZoG87aAk+jgzUv
        aCPXKAsyIRcJhKAZLWXLsZPaesgsjCtLu0qHGju95hpM
X-Google-Smtp-Source: AKy350aQ7YeC7SyvJmG2r/dJdKl0tGowZyj0rRyA8LhbO7auHSlJrXt/UA1XpjrzC599qY0lGJnhZg==
X-Received: by 2002:a17:906:58:b0:921:da99:f39c with SMTP id 24-20020a170906005800b00921da99f39cmr12394634ejg.12.1682370335184;
        Mon, 24 Apr 2023 14:05:35 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906795600b0094f25ae0821sm5913033ejo.31.2023.04.24.14.05.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:05:34 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so7587753a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:05:34 -0700 (PDT)
X-Received: by 2002:a05:6402:151:b0:508:41df:b276 with SMTP id
 s17-20020a056402015100b0050841dfb276mr13756695edu.22.1682370334079; Mon, 24
 Apr 2023 14:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
In-Reply-To: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Message-ID: <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
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

On Fri, Apr 21, 2023 at 7:02=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This contains Jens' work to support FMODE_NOWAIT and thus IOCB_NOWAIT
> for pipes ensuring that all places can deal with non-blocking requests.
>
> To this end, pass down the information that this is a nonblocking
> request so that pipe locking, allocation, and buffer checking correctly
> deal with those.

Ok, I pulled this, but then I unpulled it again.

Doing conditional locking for O_NONBLOCK and friends is not ok. Yes,
it's been done, and I may even have let some slip through, but it's
just WRONG.

There is absolutely no situation where a "ok, so the lock on this data
structure was taken, we'll go to some async model" is worth it.

Every single time I've seen this, it's been some developer who thinks
that O_NONBLOCk is somehow some absolute "this cannot schedule" thing.
And every single time it's been broken and horrid crap that just made
everything more complicated and slowed things down.

If some lock wait is a real problem, then the lock needs to be just
fixed. Not "ok, let's make a non-blocking version and fall back if
it's held".

Note that FMODE_NOWAIT does not mean (and *CANNOT* mean) that you'd
somehow be able to do the IO in some atomic context anyway. Many of
our kernel locks don't even support that (eg mutexes).

So thinking that FMODE_NOWAIT is that kind of absolute is the wrong
kind of thinking entirely.

FMODE_NOWAIT should mean that no *IO* gets done. And yes, that might
mean that allocations fail too. But not this kind of "let's turn
locking into 'trylock' stuff".

The whoe flag is misnamed. It should have been FMODE_NOIO, the same
way we have IOCB_NOIO.

If you want FMODE_ATOMIC, then that is something entirely and
completely different, and is probably crazy.

We have done it in one area (RCU pathname lookup), and it was worth it
there, and it was a *huge* undertaking. It was worth it, but it was
worth it because it was a serious thing with some serious design and a
critical area.

Not this kind of "conditional trylock" garbage which just means that
people will require 'poll()' to now add the lock to the waitqueue, or
make all callers go into some "let's use a different thread instead"
logic.

                             Linus
