Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C46F88BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjEESlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEESlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:41:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2361436C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:41:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29768782a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683312060; x=1685904060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhm3Rctnlx5UPRybogDdMN4gKvloPHqLZXPlqb0HbTI=;
        b=VXp66tQBwYbM0EWUCbQ0q9HdCzgIXFRCsNBqKAPIsWsz5JhB5gb/3Ns5z9qJK4/TmM
         AQZ3wqUSSVQA3S7yUGlYQeQUvudTcI9eYWwEd+f+A0hv+6tlS2N9DAPyaO8iIhn3BQZm
         eXuzRa1UphcBVWcsfHoxNy0t1TnRMPF0o7vPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312060; x=1685904060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhm3Rctnlx5UPRybogDdMN4gKvloPHqLZXPlqb0HbTI=;
        b=afvWyEkwW+gMVPT00F8Y5bG464q9yMbxpiUbBAH6nlv62oMshCc2Wruv87D13gYuHi
         zB5L1oxKR7EGRdHoJbMUJgVI0UjHmaxfsYlV9C1gAXtgGitDeV+/s+RxdN0+bQ/x3mhs
         98V4nbFX6OiQpFFx++gFTFkDlqZhfD9geYAkG7YWMmoSagHCTh6NIVHtlUhcpZ3Edff9
         op/7t3IkYUiMV56iuWmS+a6HcReOMXn/OH8gKiaXigdYqVBmIlgCUXeqsJVx/qvbkYMp
         k/B3O0932p3ubKlHFcZHyfmnCqUd2cYr9lSpjXyUBiqDPk3UwO79cj77zm0yGuYAr5Dn
         nNig==
X-Gm-Message-State: AC+VfDz18t+u5x96TgKOsl0JUYXlxkRqyEfOgkRvCVIbmpOJa0PRHkou
        QRZZ31XkHVnRuuHE2JXxzlPMOojUFoc4A1EpPuJwtw==
X-Google-Smtp-Source: ACHHUZ53OpipS1F6a32D/qx3mF+z9gwE7RkBT2SDj37TCy+h0DTnlszlY4JjIG/J2Yn7V1+1iUuQcw==
X-Received: by 2002:a17:907:36c7:b0:94e:f3d5:e4f8 with SMTP id bj7-20020a17090736c700b0094ef3d5e4f8mr2657912ejc.37.1683312060199;
        Fri, 05 May 2023 11:41:00 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id w21-20020a170907271500b009629ffabe0asm1245168ejk.224.2023.05.05.11.40.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:40:59 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so29912351a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:40:59 -0700 (PDT)
X-Received: by 2002:a17:907:1690:b0:94f:6316:ce8d with SMTP id
 hc16-20020a170907169000b0094f6316ce8dmr2825064ejc.34.1683312059288; Fri, 05
 May 2023 11:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com> <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
In-Reply-To: <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 11:40:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
Message-ID: <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
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

On Fri, May 5, 2023 at 6:56=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Which way do we want to go with respect to the rvalue of the assignment
> operator "=3D" in a macro ? (with or without parentheses)
>
> In short:
>
> #define m(x) do { z =3D (x); } while (0)
>
> or
>
> #define m(x) do { z =3D x; } while (0)

I suspect that the first one is preferred, just as a "don't even have
to think about it" thing.

In general, despite my suggestion of maybe using upper-case to show
odd syntax (and I may have suggested it, but I really don't like how
it looks, so I'm not at all convinced it's a good idea), to a
first-order approximation the rule should be:

 - always use parentheses around macros

 - EXCEPT:
     - when used purely as arguments to functions or other macros
     - when there is some syntax reason why it's not ok to add parens

The "arguments to functions/macros" is because the comma separator
between arguments isn't even a operator (ie it is *not* a
comma-expression, it's multiple expressions separated by commas).
There is no "operator precedence" subtlety.

So we have a lot of macros that are just wrappers around functions (or
other macros), and in that situation you do *not* then add more
parentheses, and doing something like

    #define update_screen(x) redraw_screen(x, 0)

is fine, and might even be preferred syntax because putting
parentheses around 'x' not only doesn't buy you anything, but just
makes things uglier.

And the "syntax reasons" can be due to the usual things: we not only
have that 'pass member name around' issue, but we have things like
string expansion etc, where adding parentheses anywhere to things like

    #define __stringify_1(x...)     #x
    #define __stringify(x...)       __stringify_1(x)

would obviously simply not work (or look at our "SYSCALL_DEFINEx()"
games for more complex examples with many layers of token pasting
etc).

But in general I would suggest against "this is the lowest priority
operator" kind of games. Nobody remembers the exact operator
precedence so well that they don't have to think about it.

So for example, we have

    #define scr_writew(val, addr) (*(addr) =3D (val))

to pick another VT example, and I think that's right both for 'addr'
(that requires the parentheses) and for 'val' (that might not require
it, but let's not make people think about it).

                  Linus
