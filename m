Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310596A5FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjB1TwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjB1TwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:52:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EBE32E71
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o15so42297399edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=EGqXWGb6FO9oqjBg/RjdN/86icRC1mPJ3oftK9FFQmtW1fgTuj/zmUleWUKUiXp25b
         c6AlQmcV0atsC/y67K5zu2wXxvzhbGCaOD7syFHQ9VXJzRYz6NH2pn9up0dOx+dWjEbu
         VnxtlH/hlKeQ5BYQrPpt5FLATZFI06UDFf424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=B4m+mOPPU63xvAtPkrRNTUOwW+7ifEX8vUofAHW9eDuEaL1JJwzvlv9C4ul2JtZZ0f
         +R+oZ7Wo/0XzEw43RDGQnkM+GwMS/pIYkeoXBgGHxBeLsMGUcCtAvP0cPPscNaI/8+sz
         JbkwuTJ2ROXc21JD6rAXbKPGGR17CJUyd5mXvjHZhC+TllDpCN19kIPXEArJtNQrSiRd
         wBDRT/L4TtTPmJNaLCwVUzphrRItcrEb1HTJV4V9NsfHLP0vYtVeEE1bFvQF/NgPJhaw
         ugL7SILWVVsMhNuW9XtpNZc7m/gSOWH8P3fqfoZeNzP03hDYMaqr/xVB1OTFZGyrrf3g
         gtLQ==
X-Gm-Message-State: AO0yUKUpYc9BKL/wOU6rOJ6V7CeByMW3B5tudzmj2A7OI/8urfA9VM4Z
        Gt2FSjoKY9744rIEttaCqlJ4NEklDWK6kMEjJ3Q=
X-Google-Smtp-Source: AK7set+S+LgTL7SUtcQ74x6ZIYP0X6uCvTY5a7Nvgj/6gD9xxsv3gdQuY5V7khDmf68HwWuLloc2lw==
X-Received: by 2002:a05:6402:488:b0:4ac:b760:f07a with SMTP id k8-20020a056402048800b004acb760f07amr5185726edv.19.1677613915582;
        Tue, 28 Feb 2023 11:51:55 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906085700b008e51a1fd7bfsm4905812ejd.172.2023.02.28.11.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:51:54 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id da10so44885222edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:54 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr1947231ejz.0.1677613914258; Tue, 28 Feb
 2023 11:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 11:51:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

Oh, and while I haven't actually booted it or tested it in any way, I
did verify that it changes

-       movq    48(%rbx), %rax
-       movq    56(%rbx), %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13
-       shrq    $32, %rax
-       shrq    $32, %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13

into

+       movq    56(%rbx), %rax
+       cmpq    48(%rbx), %rax
+       jne     .LBB58_12

because it looks like clang was smart enough to unroll the silly
fixed-size loop and do the two adjacent 32-bit loads of the old cap[]
array as one 64-bit load, but then was _not_ smart enough to combine
the two 32-bit compares into one 64-bit one.

And gcc didn't do the load optimization (which is questionable since
it then just results in extra shifts and extra registers), so it just
kept it as two 32-bit loads and compares. Again, with the patch, gcc
obviously does the sane "one 64-bit load, one 64-bit compare" too.

There's a lot to be said for compiler optimizations fixing up silly
source code, but I personally would just prefer to make the source
code DTRT.

Could the compiler have been even smarter and generated the same code?
Yes it could. We shouldn't expect that, though. Particularly when the
sane code is much more legible to humans too.

                 Linus
