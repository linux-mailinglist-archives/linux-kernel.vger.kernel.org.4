Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED236D9CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbjDFPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDFPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224A4220;
        Thu,  6 Apr 2023 08:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A391D617D5;
        Thu,  6 Apr 2023 15:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0901FC433EF;
        Thu,  6 Apr 2023 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680796125;
        bh=gCMj7rHc2vXcOYr+ShATDoCKp8S/RUyCf67KISWSutM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZMF5k7KKffyKyYyX7yspk2IyYCGQcqbQ7LzxlG0zX2jKbDx2pOFdE+SdtfFTELZzu
         FwuO9NAHPoZsCLnHSQWoYxNOd4EZptbNtaEiKJnCtGDzm6HX4olb1dHGrW0yhImCOR
         b37KPZ+7G8xuKUiVRNVrCB8boMqXobaklI/WLzcrmlJeD33tNmnMgcPDuPBLb3Ev91
         b+nIaoXvfjTF5tUEoFUBsDbcjQckoybX5C2qhTRZ2RR8OFJ2zqjYJjwUbQsRbq9JlC
         AYOTinadPVJ62rmoAO7oI8CG+gnG2hnBIDQ5LcvEQIEpNVnoCeYyIeJm9xS/EIn+RM
         2S4Fih8rtiKlw==
Received: by mail-yb1-f177.google.com with SMTP id r187so46598062ybr.6;
        Thu, 06 Apr 2023 08:48:44 -0700 (PDT)
X-Gm-Message-State: AAQBX9dFNQna3oWOKNwwaiKeBsyWcN+05Dvb6/UAsjSjvFffua3nRbbW
        5oA815aZ+hNXN5AqAh4rrztutoUscxbxUWu6Ww==
X-Google-Smtp-Source: AKy350Zzc2mowfFyIPi/dfoj4PLjaJFeaGp+GLAx0yBecFNH8tMSD++w2H0z7ixo8hKG1Kc7Dvdk1MZHPK6dVBFWaNg=
X-Received: by 2002:a25:cad1:0:b0:b75:3fd4:1b31 with SMTP id
 a200-20020a25cad1000000b00b753fd41b31mr2367088ybg.1.1680796124084; Thu, 06
 Apr 2023 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230406151429.524591-1-tanure@linux.com> <20230406151429.524591-3-tanure@linux.com>
In-Reply-To: <20230406151429.524591-3-tanure@linux.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Apr 2023 10:48:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_MLHO-zk0HAmuAmiJQ_TmD4EN5YC0JmRs7PXjStjr3A@mail.gmail.com>
Message-ID: <CAL_JsqL_MLHO-zk0HAmuAmiJQ_TmD4EN5YC0JmRs7PXjStjr3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: fdt: Allow the kernel to mark nomap regions
 received from fdt
To:     Lucas Tanure <tanure@linux.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 10:14=E2=80=AFAM Lucas Tanure <tanure@linux.com> wro=
te:
>
> Reserved regions can be described in FDT and device trees, but FDT doesn'=
t
> provide the related flags, like nomap.

It took me a minute to understand what you meant by FDT vs. device
trees. Use the exact things you are talking about: /memreserve/ and
/reserved-memory node.

> So allow the kernel to mark regions where the base and size received from
> the device tree are the same as the base and region on FDT.
> Here we trust that the device tree has a more updated description of the
> region than the one received from FDT.
>
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/of/fdt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1a68b6d03b3..754a7ea4f45c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -482,11 +482,13 @@ static int __init early_init_dt_reserve_memory(phys=
_addr_t base,
>         if (nomap) {
>                 /*
>                  * If the memory is already reserved (by another region),=
 we
> -                * should not allow it to be marked nomap, but don't worr=
y
> -                * if the region isn't memory as it won't be mapped.
> +                * should not allow it to be marked nomap, unless is the =
exact same region
> +                * (same base and size), which the kernel knows better an=
d should be allowed to mark
> +                *  it as nomap.
> +                * But don't worry if the region isn't memory as it won't=
 be mapped.
>                  */
> -               if (memblock_overlaps_region(&memblock.memory, base, size=
) &&
> -                   memblock_is_region_reserved(base, size))
> +               if (memblock_overlaps_region(&memblock.memory, base, size=
) =3D=3D MEMBLOCK_OVERLAPS &&
> +                   memblock_is_region_reserved(base, size) =3D=3D MEMBLO=
CK_OVERLAPS)

Won't this fail to work as IIRC memblock will merge regions when they
are adjacent and have the same atrributes.

Perhaps instead, the DT code should ignore any /memreserve/ entries
that are also in /reserved-memory.

I would suggest just reverse the order they are processed, but I
suspect that might cause some regression. This code is all fragile
especially with platforms putting in 100 regions.

Finally, perhaps fix u-boot. The reason the reserved location goes in
both places was to support an OS not supporting /reserved-memory. I
think that support has been in place for a lot longer than anyone
would care about.

Rob
