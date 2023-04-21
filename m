Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673076EAA16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjDUMOj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:14:37 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BFE7D93;
        Fri, 21 Apr 2023 05:14:35 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b992ed878ebso1928075276.0;
        Fri, 21 Apr 2023 05:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682079274; x=1684671274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpGP5Ic7xgbtuWAjmqGMPKY1bCeKiuYvBRGEng3tVTI=;
        b=XbCRSaginUwipaKBdY/XOMNasKG6wGN8PBehqW/1uy++/NfdnTp7hrtEMMjbl5gWvh
         GS3q8MR/0kRPpQ03TSr2pTanOjALeeQq+/K5KqrPTiNdtooO9xrN/QAFGy+BmqgBLtrm
         SerGcvmARt3wCaEmgo4nIZuRUNUyCuZOOOfqH/yDG0F1wQBfSs6thr3fMDSz6VAJSI7B
         rovXRox/yRu3KXXz3xwQMZ9s3kqxaISY7iwkRCOEpAOGUogyqKblkj2blRnYSVr5P7h4
         eH+rp7AXaZvY3uWr/apBKC0e1T+yCjkhFS4y6JAe39Oo6Ov1QL7cLmhsu4AXgcx8TJlP
         /y7w==
X-Gm-Message-State: AAQBX9eHKR49S0Y9j2hpU6eLVnHuAhGjOa+cBRKGEU/0vbyWh0am+TgD
        oUVNGh/1AYpHDocdF7s5iLRhCoYLuNc8xtq6
X-Google-Smtp-Source: AKy350Z+1cDxc7jwK0RKyI8MhwiZYmjnDO3bciT0yaOyFF6tOfIMFPGEzG/3n0dtZiDuWk+rQe2bcQ==
X-Received: by 2002:a25:d254:0:b0:b8f:46d8:dfb1 with SMTP id j81-20020a25d254000000b00b8f46d8dfb1mr1743831ybg.4.1682079274466;
        Fri, 21 Apr 2023 05:14:34 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 124-20020a251482000000b00b9550fcb12fsm881146ybu.64.2023.04.21.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 05:14:34 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-b992ed878ebso1927996276.0;
        Fri, 21 Apr 2023 05:14:34 -0700 (PDT)
X-Received: by 2002:a0d:d68d:0:b0:54f:9b37:c1af with SMTP id
 y135-20020a0dd68d000000b0054f9b37c1afmr1836713ywd.1.1682079274054; Fri, 21
 Apr 2023 05:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
 <434fe02c2c774ae4d1694ff222884bc5d5fc25e6.camel@physik.fu-berlin.de>
In-Reply-To: <434fe02c2c774ae4d1694ff222884bc5d5fc25e6.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 14:14:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW72T=OU0iEtbAjHqYUv_k0+xe8NeUod4BhzNTUqoPH6A@mail.gmail.com>
Message-ID: <CAMuHMdW72T=OU0iEtbAjHqYUv_k0+xe8NeUod4BhzNTUqoPH6A@mail.gmail.com>
Subject: Re: [PATCH v3] sh: Use generic GCC library routines
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, linux-sh@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 1:03 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-03-23 at 11:18 +0100, Geert Uytterhoeven wrote:
> > The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
> > arch/sh/lib/ are identical to the generic C implementations in lib/.
> > Reduce duplication by switching SH to the generic versions.
> >
> > Update the include path in arch/sh/boot/compressed accordingly.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

> > --- a/arch/sh/lib/Makefile
> > +++ b/arch/sh/lib/Makefile
> > @@ -7,9 +7,7 @@ lib-y  = delay.o memmove.o memchr.o \
> >        checksum.o strlen.o div64.o div64-generic.o
> >
> >  # Extracted from libgcc
> > -obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
> > -      ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
> > -      udiv_qrnnd.o
> > +obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
>
> Why are the single-precision (denoted as "si") variants not being replaced?
>
> Don't we have generic versions for these?

Because they are written in assembler, and thus different from generic
versions, and because Linux does not include generic versions for these.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
