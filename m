Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973066E49EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDQNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF634199A;
        Mon, 17 Apr 2023 06:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57325624B4;
        Mon, 17 Apr 2023 13:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B292EC433AA;
        Mon, 17 Apr 2023 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681738296;
        bh=Z1E7VRImbk5O8ynjKxbGEPL5/pNRjHf9QbC2IrDjeEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ApQLt+5hMKVQIvzY5fCsHXN1O9d66Vkqdbnf/xozhB9nuWuwLcZf/MN0ppBlfhFIt
         HQDUV2nEhzb6hm2lIFc6FOWsKV/xtHSrJDm16DGEKIk7rmSl1kCXD+7UtJki0cUM41
         8okXBMRnAHqFb3pXt6yy8HLqPKgBBH01IvciEYmbPaO9iX7on0mQpD89z1YsQnCqhL
         q322Ce5KqizgqcdNbLPtssnzKOay7XNC41dL/SlQYjEfg4XGzbmnPKW+wXhduIwJN+
         v6rbKR36oXKryWyC6KbHqtudzstgkxltXOwyhoC5jg1NY3BT/2BLRzyKhheW+Oby7i
         1ToU1aRNddTrw==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54ee0b73e08so419886927b3.0;
        Mon, 17 Apr 2023 06:31:36 -0700 (PDT)
X-Gm-Message-State: AAQBX9eGxyvuHzlfKkJwg+oWPlDZscfMuPgVFC5dXpk5VgFSDMxUSDax
        qFkGb7WNAAArCWRQ4p25LpAW7nyYYFu9vvY9Rg==
X-Google-Smtp-Source: AKy350bviA6nMrYItp2UFoijYxMfOof9zLeZI1Waml/VUI/79m2nqsKw6eSDud+5a83sS7abqkKDxQ68edHzGfQfRRo=
X-Received: by 2002:a81:b60c:0:b0:54c:a67:90b with SMTP id u12-20020a81b60c000000b0054c0a67090bmr9245222ywh.5.1681738295535;
 Mon, 17 Apr 2023 06:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230412224620.8909-1-tanure@linux.com> <20230412224620.8909-2-tanure@linux.com>
In-Reply-To: <20230412224620.8909-2-tanure@linux.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Apr 2023 08:31:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1L4EOpVm7nXbZ0t8-9wHVq4531MN4Csemi-4SBd=zig@mail.gmail.com>
Message-ID: <CAL_JsqL1L4EOpVm7nXbZ0t8-9wHVq4531MN4Csemi-4SBd=zig@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] of: fdt: Scan /memreserve/ last
To:     Lucas Tanure <tanure@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 5:46=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> Change the order of scanning /memreserve/ and /reserved-memory node.
> /reserved-memory node should go first, as it has a more updated
> description of the memory regions and it can apply flags, like nomap.
> Also, /memreserve/ should avoid reserving regions described in
> /reserved-memory node.

Please give some background details why we need to make this change.
As-is, sounds like some theoretical issue. IOW, incorporate some of
the details in the cover letter here. For single patches, you don't
need a cover letter anyways.

Powerpc folks, please comment and/or test. I worry there could be some
subtle differences with this change.

>
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/of/fdt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1a68b6d03b3..c28aedd7ae1f 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -635,6 +635,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
>         if (!initial_boot_params)
>                 return;
>
> +       fdt_scan_reserved_mem();
> +       fdt_reserve_elfcorehdr();
> +
>         /* Process header /memreserve/ fields */
>         for (n =3D 0; ; n++) {
>                 fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
> @@ -643,8 +646,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
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
