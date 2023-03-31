Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCEC6D218B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjCaNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjCaNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:39:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E52469A;
        Fri, 31 Mar 2023 06:39:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id cf7so27433485ybb.5;
        Fri, 31 Mar 2023 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680269986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8HyCR6qUgL2YL9MIarBVNh91rgqxInYdUkkRv7lzCA=;
        b=nRQVT9ShE0pExTB54GDQVPUoE5xeg0yZISdISWCkiaC/z9HRj31sfeE6I5mTha44sY
         FqPQHA8gp7feZ2Ap/WXLKcka4qprU9xOlYAwx/PsdGZrVMjzLZqi2emdau+nG0Hbv0C3
         3/kWmtGI/xWfhv3DXsK6HXxEZX3kBUw71sF2+RvpC1SgGXf/T9LO5ytk9j8HSurCFxee
         8IykdnR/8W6eifFOBjLc/iLlqTguUMNQnQ6jcxlYoujxYzVJa5RTq3wnT+T4zjX/HXub
         ROpXfaWDFJ+FMzmoEHNv30WTzud50vzxa8ncXd6vRq1MBzStrtfx2oA3T2JFefm8Cyoo
         i9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8HyCR6qUgL2YL9MIarBVNh91rgqxInYdUkkRv7lzCA=;
        b=mbEyhHuUMFMzMr/MwtW1ynR8B/oO0YS/R26No2V8Wz0GtQg4+Br5ph0c5dVg7LLn+n
         KbHcZFlJLhf1oXh0b5LMmEAvKaHYdh8h/BawaaSMneJ1Ljw16ucYJrC3rOyrOXcJiZQx
         tkHKGzYUJCRUaahPgWwvfGP2iyH/x+rnxVBOf2M98LS/v736gZ+GgmZRo2KWaFtjwtqx
         H2CtHcAtThurDUgl5/1jOIjlOzFIKA05lweqwObirQHaRGwMtSWx4AjqhpTULYI+3DgU
         eirnQY2WyJhCLEhkOUT7Uca3c7R5VgsQuIu+5XOEw2L/0T7TuDovH2bsWIivafkeX3DD
         h92Q==
X-Gm-Message-State: AAQBX9frankr/7+py7nHf2chcvc1xfTqL+kyGYxQbUYGx4xDzxXp0zxZ
        NwPsOiERCfj9LtQxwEF19VZxu1N23J9hG1z4PEw=
X-Google-Smtp-Source: AKy350apgoEPMUQxWR00klwXYYscnIAK0OZLPQx0ko6VrOlHD0pJFBErJN002gXBJZ2Hpee+HGT0ekYIUQKFrIQIx4Q=
X-Received: by 2002:a25:2f84:0:b0:b6e:d788:eba0 with SMTP id
 v126-20020a252f84000000b00b6ed788eba0mr17842248ybv.11.1680269986074; Fri, 31
 Mar 2023 06:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230318041555.4192172-1-davidgow@google.com>
In-Reply-To: <20230318041555.4192172-1-davidgow@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Mar 2023 15:39:35 +0200
Message-ID: <CANiq72==YbpCJPLOkCBGRkTYCOokLrEUNASn_JUpY2Ndw1sHfw@mail.gmail.com>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old GCC bugs
To:     David Gow <davidgow@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        SeongJae Park <sj@kernel.org>, linux-um@lists.infradead.org,
        x86@kernel.org, llvm@lists.linux.dev,
        rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 5:16=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Nevertheless, only disable SSE on clang setups, as that's a simple way
> of working around everyone's bugs.

Sounds good to me. If GCC >=3D 11 has fixed it, should we instead test
for GCC < 11, i.e. it could help catching future new regressions like
the linked GCC bug, if I understand correctly, right? Of course, that
could be done for the next cycle, since this one minimizes the
original change w.r.t. v6.2.

By the way, missing space on the title (`arch:um`).

Cheers,
Miguel
