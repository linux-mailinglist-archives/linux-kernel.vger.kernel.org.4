Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4480B6CFCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjC3HcI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjC3Hbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:31:48 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91F729B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:31:41 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-544f7c176easo338891447b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxN0r0AhgneifQhzqL4mjT7JfsmxnYyFrUEJ452tNfU=;
        b=UJAKo2hjT5XN0jjvBr2vo0JiQAQPK5+gdUNYYR3tww7JMIaWR+CLHUEv8AQzCs/eQ6
         67ZBIxM+4H2lx8mM25tdCMGZqavotgXdgwinqXOeu2+d+rLRRe5aR0x+XieN5nu3vDIs
         XHYA2w7oEFF4bbbqZi7bXiYxtHhsGsqaqkwfJJkmjRSlGzCES7XuAX4q7GA0MV+xrswZ
         Vn4jAVXbO2qGvO0VuUZn5JvU9G0CdX9I4ilulDy7yuBm7mvzHvAxlF7i6smNws7LPFt+
         G0i0jEZe5iODiQJ9yG82taHUqAqOa9mcNg3zKlELCQf9yGbEgPRUZ7mXoAjBKYWOJOW0
         QwIw==
X-Gm-Message-State: AAQBX9cZqZ1pJRS0ixoy+P6xDkGtn4VnNpMHrpUKnErYS5peopEm9kIz
        EreAxbGhFfqUg9G8RO3w92ftAniTwNADjQ==
X-Google-Smtp-Source: AKy350aLyq2VOsME0JjYF9sJWMPq7sh6noPwlx2tB4qo//IzMq0//B5g2Xvh4L0MAAZhBD2Ne/4QkQ==
X-Received: by 2002:a81:7889:0:b0:544:b64e:f3dc with SMTP id t131-20020a817889000000b00544b64ef3dcmr4861063ywc.6.1680161499989;
        Thu, 30 Mar 2023 00:31:39 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 85-20020a810358000000b0054621137a77sm790815ywd.26.2023.03.30.00.31.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:31:39 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id k17so22347758ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:31:39 -0700 (PDT)
X-Received: by 2002:a25:1185:0:b0:a27:3ecc:ffe7 with SMTP id
 127-20020a251185000000b00a273eccffe7mr2687305ybr.3.1680161499271; Thu, 30 Mar
 2023 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230330060105.29460-1-rdunlap@infradead.org> <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
In-Reply-To: <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 09:31:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
Message-ID: <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Mar 30, 2023 at 8:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
> > On riscv64, linux-next-20233030 (and for several days earlier),
> > there is a kconfig warning:
> >
> > WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
> >   Selected by [y]:
> >   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
> >
> > and build errors:
> >
> > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
> > io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
> > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
> > io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
> > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> > ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
> > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> > ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
> >
> > Add RISCV as an allowed ARCH dependency to fix these problems.
> >
> > Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux.dev
> > Cc: Conor Dooley <conor@kernel.org>
> > Cc: linux-riscv@lists.infradead.org
> > ---
> >  drivers/iommu/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
> >  config IOMMU_IO_PGTABLE_LPAE
> >       bool "ARMv7/v8 Long Descriptor Format"
>
> I'm probably missing something here, but why would we want to enable
> "ARMv7/v8 Long Descriptor Format" on RISC-V?

Indeed, we should not enable it, unless compile-testing.

> Would it not be better to make the Renesas depend on, rather than
> select the option? It does seem highly arch specific, and I feel like
> Geert previously mentioned that the RZ/Five (their RISC-V offering)
> didn't use it.

I think the IPMMU_VMSA dependency should gain

        depends on ARM || ARM64 || COMPILE_TEST

> >       select IOMMU_IO_PGTABLE
> > -     depends on ARM || ARM64 || COMPILE_TEST
> > +     depends on ARM || ARM64 || RISCV || COMPILE_TEST
> >       depends on !GENERIC_ATOMIC64    # for cmpxchg64()
> >       help
> >         Enable support for the ARM long descriptor pagetable format.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
