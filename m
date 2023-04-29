Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483146F217F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347063AbjD2AJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjD2AJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:09:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC003C26
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:09:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso411824a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682726951; x=1685318951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YACjJPQ/4k1aGg00TusYEm4/EfglatXgozInXtXCNs=;
        b=FqJUlu5ddgmBLypqfG2Blbl7gQZL5TiIetcxXc+YjxAXrWjQst1OHU3rL12meDPFvF
         hXtWAqAfPoP1mZLbwogC94rdPFlS8tio/H9Q+m7fvc57iBfWv9u+TpNefsJq3C2zXoy8
         PgbUzlmTylo+d/4Ijq8xcB6MtQw1Fqwm/lrKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682726951; x=1685318951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YACjJPQ/4k1aGg00TusYEm4/EfglatXgozInXtXCNs=;
        b=KN849XXQxQYaxQCw2vsZKBWvTal2uS/9Ln2r3bgOLI2eQrTzwrkPXJxWxF3GTa+j1a
         /A6SZ0hOw2B/q/iEmPGEmnzsjEiWn1dWNzZhViZzG/t+6+kBCMelXH6mKj/kjtUU8g8f
         RmTH5JKZA7ZoZA41OPYnIOI78WeAkSeQ2RA7GYvKFK9FbKHKzCneAnNTFh0XY8GqSa8g
         FIghmwuuzOZ0aLeJDZvXA2Mf+VzzTv/TLA0jnPb9BgNsIIaYOfnOSQrvq4EPb/ly/LV3
         zPhj4P3CyA/7W/Hy1N5b10+CVCfM7rCrIJ42wa+tY7TjqhU/uRdDjp3VaivJFmDNSCXY
         aM1g==
X-Gm-Message-State: AC+VfDwIJ0XEMQL6gm/G44HXQ0HX7AXKLJJQjrZ9Ib65IkOVAUtW8y58
        QwQopvGb+SvZlwjF3S7w2714po16vLhoeUUpRPgJMyT2
X-Google-Smtp-Source: ACHHUZ6UUV2pmBtgFEHdyEGjidaaOCpCyEB/puAANC203k5Hzyld8hoNWmm1oDnRNTe2WxELgXKdVQ==
X-Received: by 2002:aa7:cc85:0:b0:504:b6a6:cbe0 with SMTP id p5-20020aa7cc85000000b00504b6a6cbe0mr406325edt.12.1682726951654;
        Fri, 28 Apr 2023 17:09:11 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0094f432f2429sm11886582ejb.109.2023.04.28.17.09.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 17:09:11 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso411799a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:09:10 -0700 (PDT)
X-Received: by 2002:aa7:d416:0:b0:504:80d8:a034 with SMTP id
 z22-20020aa7d416000000b0050480d8a034mr337676edq.40.1682726950671; Fri, 28 Apr
 2023 17:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
In-Reply-To: <mhng-57198db1-de34-4dca-be9f-989b1137503e@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 17:08:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivud6jefN+UKa4zkAf4dkapyh4iRazyUVgXTzqRntOMg@mail.gmail.com>
Message-ID: <CAHk-=wivud6jefN+UKa4zkAf4dkapyh4iRazyUVgXTzqRntOMg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.4 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 9:09=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/risc=
v-for-linus-6.4-mw1

Ugh, so this conflicted pretty nastily in arch/riscv/mm/init.c between comm=
its

  ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region")
  8589e346bbb6 ("riscv: Move the linear mapping creation in its own functio=
n")

and while I did try to make sense of it all, and generated what looks
like a sane resolution to me, I did *not* do some kind of build check,
much less can I test anything.

So.. Caveat emptor. I may or may not have gotten that conflict right,
and you should most definitely double-check it very carefully.

                  Linus
