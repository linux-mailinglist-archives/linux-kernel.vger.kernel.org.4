Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6C6DC6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDJMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9482738;
        Mon, 10 Apr 2023 05:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBAA060DFB;
        Mon, 10 Apr 2023 12:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7AEC433EF;
        Mon, 10 Apr 2023 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681131169;
        bh=qk6WhIKn/+ELvEp+vyHHVRr7i+l4sUrOaHlfuQKbTD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FOc+1DqDaxlZ1pnaeB70DndeLACDRYjTX/jsFCkl5+TGS+We+sbE5zBHfIxbnkSF8
         ZzPEIhHMVgWtlVXwzVdA0PeKIKSWB1TpjFEeKODs5uRQNcNsX8FbKFkFBF2r5hthn/
         x15WbbFlfbzCt1OzMD9iZ5Myx2pej8D+8dl6OscBOggH3xxX8bjeGdir59CxO1Fq+V
         yUhh91NuynM9VBJ6OKQgnDvhH1szftwWapx8yIFYcEZtGHKaRgQjEDGsdD/+p0nff+
         xM7/TY/h+cwNQtLA6R3QjsFB7MOTWEiL1mwR2rR5f6VcngBtZS8spmXh/qHqmz876v
         XZOz46hqTbGMw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54c0dd7e2f3so210790797b3.8;
        Mon, 10 Apr 2023 05:52:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9dlvPQxw4TtgPzSNJRfH2PljL50vTL3s4FvdosIS8cbkTl2bA3u
        NkG0o3KWTa+o9NkgbirgI5ch6kyfLk62w4a//w==
X-Google-Smtp-Source: AKy350aDRyQMV5T6mSbrLN2KN/1UzLpgACW1vknvF/Q03DFMH0R0/3LmWFu9WLLcHlBzT9xv1sRTcG7uq0fWVFnDrNk=
X-Received: by 2002:a81:ad05:0:b0:545:ed8e:f4f6 with SMTP id
 l5-20020a81ad05000000b00545ed8ef4f6mr5632727ywh.5.1681131168306; Mon, 10 Apr
 2023 05:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230410120017.41664-1-tanure@linux.com> <20230410120017.41664-2-tanure@linux.com>
In-Reply-To: <20230410120017.41664-2-tanure@linux.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Apr 2023 07:52:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZWmy8PGwjjBc7FA2JcgvHqmtgkkuHy=XHMT8bVEAxSA@mail.gmail.com>
Message-ID: <CAL_JsqJZWmy8PGwjjBc7FA2JcgvHqmtgkkuHy=XHMT8bVEAxSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] of: fdt: Scan /memreserve/ last
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 7:00=E2=80=AFAM Lucas Tanure <tanure@linux.com> wro=
te:
>
> Change the order of scanning /memreserve/ and /reserved-memory node.
> /reserved-memory node should go first, as it has a more updated
> description of the memory regions and it can apply flags, like nomap.
> Also, /memreserve/ should avoid reserving regions described in
> /reserved-memory node.

Like I said on v1, I think doing this has a high chance of causing
regressions on other platforms. It should probably not go to stable
for some time after a kernel release.

> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/of/fdt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1a68b6d03b3..26e608d8025d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -635,16 +635,21 @@ void __init early_init_fdt_scan_reserved_mem(void)
>         if (!initial_boot_params)
>                 return;
>
> +       fdt_scan_reserved_mem();
> +       fdt_reserve_elfcorehdr();
> +
>         /* Process header /memreserve/ fields */
>         for (n =3D 0; ; n++) {
>                 fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
>                 if (!size)
>                         break;
> +               if (memblock_overlaps_region(&memblock.memory, base, size=
) &&
> +                   memblock_is_region_reserved(base, size))

Just to make sure, a partial overlap will still get reserved?

> +                       break;

Shouldn't we continue to the next entry rather than stopping.

> +
>                 memblock_reserve(base, size);
>         }
>
> -       fdt_scan_reserved_mem();
> -       fdt_reserve_elfcorehdr();
>         fdt_init_reserved_mem();
>  }
>
> --
> 2.40.0
>
