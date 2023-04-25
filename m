Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B976EDC07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjDYHBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 03:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDYHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:01:32 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8205FF0;
        Tue, 25 Apr 2023 00:01:31 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-b994571219fso3056931276.1;
        Tue, 25 Apr 2023 00:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682406090; x=1684998090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB97P4vgbyqiQhcx5imDgaPeUwULK8f02CPSYaXYZsE=;
        b=lu0ClDluzbg6eB/KG6mQ0UmsDWQLLjkEr0gpe2m1wRfV0Pbg1MD8YHCkH2F2H4F50z
         NTf/h9bFKLV6r200PpUgzGfLh7YxNU25mSNGg/EnJVrVvkUnmdDE7CH5XK9Zxqk2dzXZ
         u+/3mCfobvviOmgS1rgVAMDzoCItzbhyLDlAbFa6VaK7/+uP6wBeZfeg9s0EzxGETVpN
         rWRxTmNR9Zjt3liqlXYkFvVyeItP1XKz3ZKfoBGm0n4rV4SX6nPtRM9DNtPKEAY4Vp3t
         LxMEyFYuvGjLSfqv9KqNwDUzai9I+0+UoBH1mNZ9nY4gcqEeMeJcV6kkxneBxWWHePEw
         odAg==
X-Gm-Message-State: AAQBX9dC3z3anLhsA+Mwm1bomWnC6Xqxza10ldS85dIsyesuI1UwXu5g
        Zz9p5L4HETx7xpJfWTmC3o59vh86XosLnw==
X-Google-Smtp-Source: AKy350agPC/K7XMByZh+RnbhCUVOtCfvDnvnmFYOFZP5Q87DQ+TGOhNnqZg0d7S1t72A47if36P1Gw==
X-Received: by 2002:a25:ad9e:0:b0:b96:9011:ce25 with SMTP id z30-20020a25ad9e000000b00b969011ce25mr11076649ybi.19.1682406090476;
        Tue, 25 Apr 2023 00:01:30 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u73-20020a0deb4c000000b0054605c23114sm3363108ywe.66.2023.04.25.00.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 00:01:29 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b980e16b27bso4014023276.2;
        Tue, 25 Apr 2023 00:01:29 -0700 (PDT)
X-Received: by 2002:a25:ae51:0:b0:b8e:ef6c:fe5 with SMTP id
 g17-20020a25ae51000000b00b8eef6c0fe5mr11586315ybe.20.1682406089529; Tue, 25
 Apr 2023 00:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <26932016c83c2ad350db59f5daf96117a38bbbd8.1679566927.git.geert@linux-m68k.org>
 <9a2b08a5a83f457b24855e4741dd31bf935d18e5.camel@physik.fu-berlin.de>
In-Reply-To: <9a2b08a5a83f457b24855e4741dd31bf935d18e5.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Apr 2023 09:01:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUsh0bTRPiWvMFyvu1PEjbjCC1VrvuO5irp6+BFei_4xg@mail.gmail.com>
Message-ID: <CAMuHMdUsh0bTRPiWvMFyvu1PEjbjCC1VrvuO5irp6+BFei_4xg@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Apr 25, 2023 at 8:32 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-03-23 at 11:22 +0100, Geert Uytterhoeven wrote:
> > As arch/sh/include/uapi/asm/types.h doesn't exist, sh doesn't provide
> > any sh-specific uapi definitions, and it can just include
> > <asm-generic/int-ll64.h>, like most other architectures.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v2:
> >   - Rebased for SPDX-License-Identifier addition in 2017.
> >
> >  arch/sh/include/asm/types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
> > index 68eb24ad201383ef..9b3fc923ee28701c 100644
> > --- a/arch/sh/include/asm/types.h
> > +++ b/arch/sh/include/asm/types.h
> > @@ -2,7 +2,7 @@
> >  #ifndef __ASM_SH_TYPES_H
> >  #define __ASM_SH_TYPES_H
> >
> > -#include <uapi/asm/types.h>
> > +#include <asm-generic/int-ll64.h>
> >
> >  /*
> >   * These aren't exported outside the kernel to avoid name space clashes
>
> Is the use of your linux-m68k email address for this patch intentional?
>
> I'm asking because the other one you posted is with your geert+renesas
> address.
>
> Do you want to adjust this?

It is fine, v1 was sent in 2013
https://lore.kernel.org/all/1385369734-24893-20-git-send-email-geert@linux-m68k.org

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
