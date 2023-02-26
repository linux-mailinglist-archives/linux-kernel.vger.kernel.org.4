Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3F6A2DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjBZDy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjBZDyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:54:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E75199C6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:54:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d30so12828518eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3jzL0y6Ler5qUbb1nqA59NxYv4O7GPc8dG7aoiVSCI=;
        b=QLHt3ynSiWLdbW+mwY8WM0pFw+QPheMzsqFmcvauKPsFIdlaYmeyyVLbA4lQawcg4d
         rsoeJffGH7ki5ChbK3/YyLOGD/nrs+Uww7HdhEyNe/2b5z2lJy4TJ8RoemtH7InNWeDZ
         TpAqTpWyI/4aS4+2CnNU1BZoUUG1asBgcSfAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3jzL0y6Ler5qUbb1nqA59NxYv4O7GPc8dG7aoiVSCI=;
        b=ZupwJZNnhrlS8Zn0OTWlIfLQi5RZV3I8UrOJXN9M+7oZjrqjueLKh6jisksnyAT+9+
         QqaIxIvgxnDwFc6JRjPFIl+ZwXtMcC0+xpXL4mnDCmFDD+szztlFV/hwQ0E5clfIAkeN
         bI0FeZUJ5RjPVnxuRjKVjoFAHAi/ind7plvKGWz9qGpiW2NOsXKrln/mUfmvh74G6ruR
         gAvEAy8eN276mg7Jg1wjN2QxZC7Qw7MmlowiTj2ia5Egz6Fam+nEC69vduooA81ImHuC
         RXH31C7pXkU4QXlOMjcBBvmlRVM98HklPmG28T1C+6H2sCWFYC4aQDEUMqCeCHzZIRzX
         UamQ==
X-Gm-Message-State: AO0yUKWypoOqrPntDlaQP/Mki69xiiBMFuaXfLv75hKfXMMERz5zDXxj
        mXUL/3HcKqTVzYY2jLJg/KWO+MqVEPBfdEL77bJbuw==
X-Google-Smtp-Source: AK7set988hIGFzuQqbNlKENXH6JFBu2BxfXcX8PaEOdZAvi/m9kWKmtHgb8VeuxcOarCf9iUm8zelQ==
X-Received: by 2002:a17:907:76ad:b0:8b1:749f:b2bc with SMTP id jw13-20020a17090776ad00b008b1749fb2bcmr28951185ejc.11.1677383601838;
        Sat, 25 Feb 2023 19:53:21 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id qw26-20020a170906fcba00b008edf49f10a7sm1519782ejb.100.2023.02.25.19.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 19:53:21 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ec43so12742802edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:53:21 -0800 (PST)
X-Received: by 2002:a17:906:9f25:b0:8f5:2e0e:6def with SMTP id
 fy37-20020a1709069f2500b008f52e0e6defmr3062810ejc.0.1677383601014; Sat, 25
 Feb 2023 19:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com> <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 19:53:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com>
Message-ID: <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 7:27=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will bisect further, but adding Liam to the participants because it's
> now narrowed down to his changes.

Ok, it's commit 2286a6914c77 ("mm: change mprotect_fixup to vma iterator")

It was entirely consistent, and bisected right to that all the way
from my current git tip.

Without that commit, google-chrome works fine.

With that commit, I get "Aww snap" and a

  traps: ThreadPoolForeg[4337] trap invalid opcode ip:55d5542363ee
sp:7fa5e04f1f80 error:0 in chrome[55d5537d3000+a14c000]

message in the kernel dumps (and core dump noise in journalctl).

The commit before is fine.

Sadly, it doesn't revert cleanly on my current top-of-tree (or even
_remotely_ cleanly_ because of all the other vma changes), so I can't
test just reverting that on the current state.

Also, it's not like I can debug google-chrome very much. It presumably
does complex vma's and unusual mprotect() stuff to trigger this, when
nothing else seems to care.

Liam?

             Linus

---
2286a6914c776ec34cd97e4573b1466d055cb9de is the first bad commit
commit 2286a6914c776ec34cd97e4573b1466d055cb9de
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri Jan 20 11:26:18 2023 -0500

    mm: change mprotect_fixup to vma iterator

    Use the vma iterator so that the iterator can be invalidated or updated=
 to
    avoid each caller doing so.

    Link: https://lkml.kernel.org/r/20230120162650.984577-18-Liam.Howlett@o=
racle.com
    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 fs/exec.c          |  5 ++++-
 include/linux/mm.h |  6 +++---
 mm/mprotect.c      | 47 ++++++++++++++++++++++-------------------------
 3 files changed, 29 insertions(+), 29 deletions(-)
