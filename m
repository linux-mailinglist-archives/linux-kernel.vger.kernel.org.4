Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD46CC1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjC1OQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjC1OPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:15:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9622173E;
        Tue, 28 Mar 2023 07:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73794B81D6B;
        Tue, 28 Mar 2023 14:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE66C4339C;
        Tue, 28 Mar 2023 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680012933;
        bh=KTQ5pqCwMxjCLp76U2Ck6TsKhM8aPCCJcsNQkFmamtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NjwxT+f/vKnR4L6Jji+0GXiJYbs3EytFhBJu6zjfnJlKNjoJfNbWafw5LbezNcfCL
         cB5BVrYIvGqgLPm8zf4MFSkEcBaMzER02mm7yB4tE/NdOSWFa++lmRQ2OpyEpwv+o1
         S1jeLSdaTtOIktyXA9Jkbj/m+Ba8Nge9aNb2ckgkMe3YB59VyFgcBQdkUkMzwohfNP
         ubiwVWkkp1MwoBwIj4IVRf9SUodlO3Ll4e6qqgPi1wtV2z7j0za1tfxg1ZDxTy3ZgT
         gDefivX83lskrgK0iS1yAkFfGIGstJa77tyqE2guTtAzlfwYCb4l/SQvnAyw9Tj36w
         tCOkzOIQHkqBg==
Received: by mail-yb1-f176.google.com with SMTP id i6so15239874ybu.8;
        Tue, 28 Mar 2023 07:15:33 -0700 (PDT)
X-Gm-Message-State: AAQBX9eWm4X+eFkJRUFfDF3A1KsRSmJKVxFQg+aRDNRPelMNYupmcobC
        95I5+G4tiDuhTv4NZ0m8F6haz+WBMtu/Vuve6Q==
X-Google-Smtp-Source: AKy350ZeXniVT2W0ktHF46dUuFUd+2aQjm+2XyAkxeqa0Slnktr+HmXjjIzlRv8cYTFNbgA1dPwAYhkFOMccqFv+ZgM=
X-Received: by 2002:a05:6902:1586:b0:b68:7b14:186b with SMTP id
 k6-20020a056902158600b00b687b14186bmr7386177ybu.1.1680012932155; Tue, 28 Mar
 2023 07:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com> <20230321110813.26808-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230321110813.26808-2-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 09:15:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxJ-u4owKhY1tSiDyBo0=92iQoJM0G6TAZ7BSNpJAZAw@mail.gmail.com>
Message-ID: <CAL_JsqKxJ-u4owKhY1tSiDyBo0=92iQoJM0G6TAZ7BSNpJAZAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] of: address: Fix default coherency for MIPS
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org
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

On Tue, Mar 21, 2023 at 6:08=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
> might override the system-wide default at runtime.
>
> Use dma_default_coherent to override default coherence for
> MIPS.
>

I assume you want this tagged for stable? Otherwise, I don't
understand why you add this here and then remove in patch 4.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/of/address.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 4c0b169ef9bf..c105d66a1fa4 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1105,6 +1105,14 @@ bool of_dma_is_coherent(struct device_node *np)
>         struct device_node *node;
>         bool is_coherent =3D IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
>
> +       /*
> +        * DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
> +        * might override the system-wide default at runtime.
> +        */
> +#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
> +       is_coherent =3D dma_default_coherent;
> +#endif
> +
>         node =3D of_node_get(np);
>
>         while (node) {
> --
> 2.37.1 (Apple Git-137.1)
>
