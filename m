Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAE6F1F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjD1UP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjD1UPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:15:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030F26B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:15:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94eff00bcdaso39511666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682712952; x=1685304952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUIWX3sGJnBrImpfMXQlWdZnoxCUJzr5qJ00uMkbMW4=;
        b=FNV0xFYLhSTM1MJhlQVhXI7rE7KfxNE2O9moJ9l47IDzM5oyHBu24cENZxcykYS3Re
         7bc6W6hbtUmvW6T1ll6W5ah2J1NL1QcriOoySzii5vDMkS8FaMzqc7+kOZQZ23cY5k1V
         YqPn2su66+zEtVacvnhwSMo7sUPnXivoatiWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682712952; x=1685304952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUIWX3sGJnBrImpfMXQlWdZnoxCUJzr5qJ00uMkbMW4=;
        b=QlBWMpcGhyISzk8jY29EbJ6DN7jj1FcEiN9cPpbvKzex7XxIfNfBTSR/CSdqROlWLR
         gZbFVI5/EH1iuCN67dTeCgAvR8a4poJgPFYFdGlEqJKYz8IbFFLOI9+QACpSH+tGHRo2
         34AqKW1x4gB2KBFNZ5Jep2FQx/rdcWKfbPdzHaNF/BomLLJYeHiXMcaXn4gNjYGCHBzX
         M8z/uXoZzDnf/LPM/jLTkplrBJRvWRxBqMkSE0m5UKZyXnQl0Unw7ewql/N+p05gv9i5
         KdjfaCC6bYFFBfEbFF4+KyHmCYAgwHgDbUxSjH3F8Ttdv0H0osGuA6UVfKJg3BnIJK2m
         qUuA==
X-Gm-Message-State: AC+VfDwHZ145NWwCFgvbLWc3chyoS/OUtzApCJhvRzl/0inYb3WlK78y
        QdPbyAUCwX8Ecqf3PI4eOVb1oUbOBdeohD1qJUIssg==
X-Google-Smtp-Source: ACHHUZ4QJ4Ck5AJHSPAM98ZnBkrWrR+iZUwdM6m6Y0UHwXcWbH2s2DbUlv+rnuz2bcPC43T9TQ6PRA==
X-Received: by 2002:a17:907:7b93:b0:953:517a:8f1a with SMTP id ne19-20020a1709077b9300b00953517a8f1amr6662375ejc.58.1682712951792;
        Fri, 28 Apr 2023 13:15:51 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b0095381e27d13sm11448526ejs.184.2023.04.28.13.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 13:15:50 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so172994a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:15:50 -0700 (PDT)
X-Received: by 2002:a17:906:eec8:b0:94f:444c:fc25 with SMTP id
 wu8-20020a170906eec800b0094f444cfc25mr6300392ejb.12.1682712949981; Fri, 28
 Apr 2023 13:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com> <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
In-Reply-To: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 13:15:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
Message-ID: <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Apr 28, 2023 at 1:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So here's my suggested change on top of the current tree. Comments?

Oh, and I wanted to particularly mention that

    We could probably just do that "check only starting address" for any
    arbitrary range size: realistically all kernel accesses to user space
    will be done starting at the low address.  But let's leave that kind of
    optimization for later.  As it is, this already allows us to generate
    simpler code and not worry about any tag bits in the address.

part of the commit log.

Right now that patch only simplifies the range check for when the
compiler statically knows that the range is small (which does happen,
but not very often, because 'copy_to/from_user()' isn't inlined on
x86-64, so the compiler doesn't actually see the constant size case
that is very common there).

However, that "check the end of the range" is sometimes actually
fairly complicated code, and it would be nice to drop that entirely.

See for example the fs/readdir.c case, where the length of the access
is kind of annoying:

        if (!user_write_access_begin(dirent,
                        (unsigned long)(dirent->d_name + namlen + 1) -
                                (unsigned long)dirent))
                goto efault;

and there really isn't any actual reason to check the end of the
access on x86: if the beginning address has the low bit clear, it
doesn't really matter what the end is, because we'll either have a
good area, or we'll fault in the non-canonical area even if the sign
changes.

So being careful about the range is kind of annoying, when we don't
really need it.

                  Linus
