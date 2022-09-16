Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1B5BA956
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIPJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIPJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:24:26 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722C67154
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:24:25 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3457bc84d53so253117867b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ICLxIYLKXePaeX7uqOrK23uRDuhGBueBgNNfHGZTbYo=;
        b=iKuPoaJFZuGpISn2LNxjPZDTYltZp2yYz7EjsSDOTMSrsmWKISyQWE+8R0W3Noaxdh
         J67WD0GhPNbs2ZfwpPxNgbFMM4v//+o2m6W92oNOWGoQp8Pm2HMq1js5UI1sFo87fUI9
         MvqGeHVFn9D1YGWApSlPSYmnXrGlHwaLfjdQFN0BwObXO3DUgO3RrA6T3xaQqEPGLzXQ
         0EXws5GnRh/SMbPaMkkyLZ+getRmmxwYdyMEUYQYwgzjcGGlv3ejcfImrZFEFoXl2eih
         RHAeAef5dhW/OI5ZfMGUohaRMTire37kk8EJdr2qZumLOUhrmXM2g5T6Apj/GBOEG16z
         rgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ICLxIYLKXePaeX7uqOrK23uRDuhGBueBgNNfHGZTbYo=;
        b=4leX2cM4GEyWEddmP3vzK5fhUe7b9bEYCay1W6OdT48t2v68D5KTQd6sxGa7kOLH57
         RZ+x2YQvUGwmR0Eeqic6qVXb15b8Sf0HZUClvWyWV2R3kX8Hv59dnd2+LgBlo6OFPeBd
         yB6uxxeyuviHH1hlEGp5u9+Mn+4FYEIAhV3qy17ekaeUc6hdkk45WYefxPLqNivT3Z5r
         FLg8sBlcIZG8V6QHtThCyfaeg0L95yG4tG8kP10nQNDO+H+Rh8Jv2G4QtosRV8+X45NX
         5OeSAvkici9gunoSTU7yVMqu+izOiZSdNcnLIQdUks3wvGcSMslzh4dmD2BQkyeM0OY/
         DG9w==
X-Gm-Message-State: ACrzQf3Fw2jTq5Ca5Cb65HfZJHT89+HwXFCTZK1FTJqcJB0eK0/YJEpk
        yebljY6EZjHgd0MITfgkyr2U4YsBGTU9eh+qSuoq1w==
X-Google-Smtp-Source: AMsMyM4IEyu4SELoiPZYqJXqFSsxD8xWUmDmdqx1BOynAfW+NapM9J/HLecVe0kFGIteirFbOOlJXPKdVbsta53L3Cs=
X-Received: by 2002:a0d:d64b:0:b0:345:2455:a1c with SMTP id
 y72-20020a0dd64b000000b0034524550a1cmr3593259ywd.295.1663320264035; Fri, 16
 Sep 2022 02:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220909095811.2166073-1-glider@google.com> <20220909095811.2166073-2-glider@google.com>
In-Reply-To: <20220909095811.2166073-2-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 16 Sep 2022 11:23:47 +0200
Message-ID: <CAG_fn=UT24yoY=amdXF5gXQjM9jw8bMamjC-mqJndiXNtNhvLA@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] crypto: x86: kmsan: disable accelerated configs
 in KMSAN builds
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Please use this patch to replace "crypto: x86: kmsan: disable
accelerated configs in KMSAN builds" when merging linux-mm into
linux-next (assuming arch/x86/crypto/Kconfig is still in -next).

On Fri, Sep 9, 2022 at 11:58 AM Alexander Potapenko <glider@google.com> wro=
te:
>
> KMSAN is unable to understand when initialized values come from assembly.
> Disable accelerated configs in KMSAN builds to prevent false positive
> reports.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Robert Elliott <elliott@hpe.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-next@vger.kernel.org
> ---
>  crypto/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 40423a14f86f5..4a2915bd40d1f 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1430,7 +1430,9 @@ endif
>  if SPARC
>  source "arch/sparc/crypto/Kconfig"
>  endif
> -if X86
> +# KMSAN is unable to understand when initialized values come from assemb=
ly.
> +# Disable accelerated configs to prevent false positive reports.
> +if X86 && !KMSAN
>  source "arch/x86/crypto/Kconfig"
>  endif
>
> --
> 2.37.2.789.g6183377224-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
