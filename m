Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BB5FA304
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJJR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJJR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:56:41 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA178581
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:56:35 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso8494767ook.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0jsc05F5cszgl+0lYID8794ncmh/vleAv7LDJHo+sNI=;
        b=fzyyftKvkZ514BTtpUG2Q3csmZOLSVUbnAwyOdFVE2HX5OWT+mBQyzaftfrHQPttgO
         Q/4Ghrbpd2U/xCd2sqVo5cz6e4jbwooDTBla7ub6jjXM0pnC0eJW8jch/LuxVMPygwIe
         uLUboTQOgLowdrabz9WOSX31hOCH/XaRq8Diw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jsc05F5cszgl+0lYID8794ncmh/vleAv7LDJHo+sNI=;
        b=Qd72mX5na/lmcRs0XKH+Zb8pzhI3+AHA9OYhLgY4tTgMq2FNccbk78K+y1vc8UcMLR
         wk/YWszqhHSIbCy3HN05XvhRdIyLm/QQm6Uya4DeY+TxE/VLJxY0elYErBjWpfpz7max
         MagTuu9FX1uJAmS5xHqskDKmNqmpAb+MtCkL+pwgZ5tOcTVwBN/l2lceywFBmGwoGl62
         IH5JwR9gLgXA5e1JpaOlyTyMaQCFDWXOOCU5sRD4vVNK8oKd91RiwPphBKa9HzF1qjGC
         s8PI0isx5ZT1VRkV8rHH6Jrtm2cFC5uX1vR1AEY3AybrfoVvYi4XZTHGMBwkZm9FBYcO
         04vA==
X-Gm-Message-State: ACrzQf1CEP8JHnWs5VLf8AQXI5iBorwIT4cBQg0ityH7hUYLc0tPtDvZ
        7asmG/Gw9Sfeo8jwE0FgEdzdrjPYa1eQGQ==
X-Google-Smtp-Source: AMsMyM7tAvTu1i4jZ9M0Ut+uvt/IOeQltDpwn5XH4SZht0d3tx+wRWkHAT6qJ05N9BSVODjuRRT8wQ==
X-Received: by 2002:a05:6830:d02:b0:661:9466:dfc3 with SMTP id bu2-20020a0568300d0200b006619466dfc3mr4137162otb.333.1665424593920;
        Mon, 10 Oct 2022 10:56:33 -0700 (PDT)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id k23-20020a544697000000b003507c386a4asm4545385oic.40.2022.10.10.10.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:56:33 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so8473714oop.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:56:32 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr5016787otv.69.1665424592620; Mon, 10
 Oct 2022 10:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221003174431.1189919-1-Jason@zx2c4.com>
In-Reply-To: <20221003174431.1189919-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 10:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoPebQJqtSb+8by4o5pHKCPaUzMkbFp5_EjKuo3dxBUg@mail.gmail.com>
Message-ID: <CAHk-=whoPebQJqtSb+8by4o5pHKCPaUzMkbFp5_EjKuo3dxBUg@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Oct 3, 2022 at 10:45 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>   Merge tag 'net-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-09-22 10:58:13 -0700)
>
> for you to fetch changes up to d687772e6d2cbffd91fdda64812f79192c1e7ca0:
>
>   random: fix typos in get_random_bytes() comment (2022-10-01 23:37:51 +0200)

Oh, and I notice that since you sent your pull request, you've updated
that tag with a new commit for a fix.

That's fine, and hey, it took me a while to get to this pull request.

But I do wish you had notified me (a follow-up email just saying "hey,
that tag got updated for a fix" is fine for a small change like this,
a new pull request saying "this supercedes the previous one is
preferred for anything bigger), if only because the difference in what
I pull and what gets described makes me then go back and lok "what
exactly happened here?".

              Linus
