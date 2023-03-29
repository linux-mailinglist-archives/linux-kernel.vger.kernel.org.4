Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60C46CED13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjC2PgT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2PgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:36:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2555B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:35:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54184571389so299983507b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUMIPPhWmbOod7a8dH8XtYFyKZRtnp1P9P4vDBHhORY=;
        b=A7hvvKLmTNoCNkKtmldEiN4VoxQX2t251RDs5U61UJiNCKVY30939RiVpOn+Q6PI3B
         aPuH2/W9DAhLJ1JilbJkkgGbE+y973mugY6r79r4NS7bFjxUB0pgP7pFQjklVyBzNJU1
         +s3wabKEe1k1owRweG4j4l7XS8Be8QWTDtAEQwE9Cpa6AD1Kc7D1oarJAT5WRjfVUxlm
         TZ8J3QZ7M8xe6ZMg5+sI/qmMkQHTVtnH2NFiZc3o7LGxssRXD8eaBwwp7pnsl42dtH15
         HlOWxwwg3hg84hqtFHZqAvKRnaglfyVEYf1gBj38M7xHX7hEQuKaqkWBWu7c9Xy0LBEB
         lnKg==
X-Gm-Message-State: AAQBX9cFsbHUbWUOLQoNzQhbln371VpVraFk5RYN9yz9XyPg9mQ+QGMS
        odYRTUBvN3ByWlI7SqtW2Ae31O0As4ZvRw==
X-Google-Smtp-Source: AKy350bMcCHzIyb2fSrYba7S3j/LyBeD6Ddhhjx6v4YSceBTxmLv5KUtheE3yifiYONyBL+bIGet9g==
X-Received: by 2002:a0d:ddd1:0:b0:544:f952:2184 with SMTP id g200-20020a0dddd1000000b00544f9522184mr23596675ywe.44.1680104076090;
        Wed, 29 Mar 2023 08:34:36 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id da12-20020a05690c0d8c00b00545a08184efsm3050194ywb.127.2023.03.29.08.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:34:35 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5456249756bso299924287b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:34:34 -0700 (PDT)
X-Received: by 2002:a05:690c:b94:b0:541:698b:7bdb with SMTP id
 ck20-20020a05690c0b9400b00541698b7bdbmr1638553ywb.2.1680104074757; Wed, 29
 Mar 2023 08:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329071405.1568021-1-geert+renesas@glider.be> <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
In-Reply-To: <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Mar 2023 17:34:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
Message-ID: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Desnes Nunes <desnesn@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        noreply@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Wed, Mar 29, 2023 at 5:03 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> > On 32-bit without LPAE:
> >
> >     kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
> >     kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> >     kernel/dma/debug.c: In function ‘dump_show’:
> >     kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> >
> > Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
=
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
> >                       if (!dev || dev == entry->dev) {
> >                               cln = to_cacheline_number(entry);
> >                               dev_info(entry->dev,
> > -                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> > +                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
> >                                        type2name[entry->type], idx,
> >                                        phys_addr(entry), entry->pfn,
> >                                        entry->dev_addr, entry->size,
> > -                                      cln, dir2name[entry->direction],
> > +                                      &cln, dir2name[entry->direction],
>
> Won't this just print out the address of cln declared at the beginning of debug_dma_dump_mappings() each time, instead of the value
> returned from to_cacheline_entry() ?

The physical address is passed by reference, cfr.
https://elixir.bootlin.com/linux/latest/source/Documentation/core-api/printk-formats.rst#L231

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
