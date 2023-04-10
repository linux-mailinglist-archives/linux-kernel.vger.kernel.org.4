Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED6DC81D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDJO60 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDJO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:58:24 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065E4C17;
        Mon, 10 Apr 2023 07:58:23 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id i10-20020a4ad68a000000b0053b8aa32089so733188oot.5;
        Mon, 10 Apr 2023 07:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681138702; x=1683730702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC0Mdx6dJbemnObfOPEMw+WA676pFjjKABCK5HPK6ZI=;
        b=FgyDaift2CXfb/RRzYxX0qdXdD/BflN+hVtvQMhfsFRWo5R/lkn74StyzGYgpWP9st
         TyMnnbziZR43Uef8sWuW5veO6YDKuilJEccCXNyotYxUCC1M6TTMWZod4A+sOqGMwYEd
         cSwFVrVcK4ZCw06u85QSj0WTuMXWX+epgBndTDjyKKIn4ss02rOkeslekTFcEgxr4Aio
         yFZrujxyALelzE8ekHzxHa1BKcuo1kYnlhfwLZHIg3PdvUbvhM8jLriex8E3Zh5IpQZH
         tmpnKW6iRlICYa+CdWUufRjTGy2eVvrokkfV9MPj/3FgoxsaW4nmzFmHs8x92QXSiIB0
         kclg==
X-Gm-Message-State: AAQBX9fDGIXdTzhww94vzLSlrBlyTtCOB77HQ3gLxqedDei7JZQiW69K
        +GRArXWM/ja5MSrsGjH5bUOLn03DOqEWTzYr
X-Google-Smtp-Source: AKy350bMib/6nqzOEoVagJeYapdnMLDBVy1q4ZKpYR+erJJu0wYdK3T7MC6x5tOIhQeCgaWRorGykw==
X-Received: by 2002:a4a:418e:0:b0:541:b682:13eb with SMTP id x136-20020a4a418e000000b00541b68213ebmr3036743ooa.5.1681138702011;
        Mon, 10 Apr 2023 07:58:22 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id j41-20020a4a88ac000000b0053b88b03e24sm4677616ooa.18.2023.04.10.07.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:58:21 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-184518754bfso2591972fac.5;
        Mon, 10 Apr 2023 07:58:21 -0700 (PDT)
X-Received: by 2002:a05:6870:d608:b0:17d:7221:d80c with SMTP id
 a8-20020a056870d60800b0017d7221d80cmr3664255oaq.5.1681138701166; Mon, 10 Apr
 2023 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230410120017.41664-1-tanure@linux.com> <20230410120017.41664-2-tanure@linux.com>
 <CAL_JsqJZWmy8PGwjjBc7FA2JcgvHqmtgkkuHy=XHMT8bVEAxSA@mail.gmail.com>
In-Reply-To: <CAL_JsqJZWmy8PGwjjBc7FA2JcgvHqmtgkkuHy=XHMT8bVEAxSA@mail.gmail.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 10 Apr 2023 10:58:10 -0400
X-Gmail-Original-Message-ID: <CAJX_Q+2thy6T8JYn4EDA5WTTv9C-m-1b2egUDtTHYisu3ePrsg@mail.gmail.com>
Message-ID: <CAJX_Q+2thy6T8JYn4EDA5WTTv9C-m-1b2egUDtTHYisu3ePrsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] of: fdt: Scan /memreserve/ last
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 8:52 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Apr 10, 2023 at 7:00 AM Lucas Tanure <tanure@linux.com> wrote:
> >
> > Change the order of scanning /memreserve/ and /reserved-memory node.
> > /reserved-memory node should go first, as it has a more updated
> > description of the memory regions and it can apply flags, like nomap.
> > Also, /memreserve/ should avoid reserving regions described in
> > /reserved-memory node.
>
> Like I said on v1, I think doing this has a high chance of causing
> regressions on other platforms. It should probably not go to stable
> for some time after a kernel release.
>
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  drivers/of/fdt.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index d1a68b6d03b3..26e608d8025d 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -635,16 +635,21 @@ void __init early_init_fdt_scan_reserved_mem(void)
> >         if (!initial_boot_params)
> >                 return;
> >
> > +       fdt_scan_reserved_mem();
> > +       fdt_reserve_elfcorehdr();
> > +
> >         /* Process header /memreserve/ fields */
> >         for (n = 0; ; n++) {
> >                 fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
> >                 if (!size)
> >                         break;
> > +               if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > +                   memblock_is_region_reserved(base, size))
>
> Just to make sure, a partial overlap will still get reserved?
A partial overlap will get reserved if not already reserved by the
/reserved-memory node.
>
> > +                       break;
>
> Shouldn't we continue to the next entry rather than stopping.
Yes, my mistake; I will send v3.
>
> > +
> >                 memblock_reserve(base, size);
> >         }
> >
> > -       fdt_scan_reserved_mem();
> > -       fdt_reserve_elfcorehdr();
> >         fdt_init_reserved_mem();
> >  }
> >
> > --
> > 2.40.0
> >
