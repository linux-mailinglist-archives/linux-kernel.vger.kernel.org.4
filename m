Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEF6CC1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjC1ORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjC1ORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:17:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD401712;
        Tue, 28 Mar 2023 07:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35D2CB81D62;
        Tue, 28 Mar 2023 14:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7FDC433A1;
        Tue, 28 Mar 2023 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680013060;
        bh=CeTJeyHjFur2f8WQY7ADogd1pxku0UIl/9w1d1coW7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHXjS8SG3+3woOSAsFZdKMiLfHOR8D8y4ypuURIO9m+IDdndbuq9tPM/esayv+V1f
         ZJ3/M/o/DBlJq0UvTMV8GZlYG9qvJS7Qah2rXNf5BPaXQLtAP1fo/WxvNFqzLPCA8p
         62NWv6TP+8OgLFioR1AbfMCEvvjdocPm7oYfxQmmwkY1BGaYt8ZW+xB/zRGryvHjJM
         RZ0d4I9ditQjW8Y3Ju7NluGRCu3lyzz81HVFHKN74eT954FNjbuvJtAYLL9jB3sdhB
         C80k1uFjRGovCo5TCMimpPNua/7+NY3ZQZuhfwNTUejLIZvFMlPc78tikqP3aHk1fa
         zpSEdkmO7XDGQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5456249756bso232472747b3.5;
        Tue, 28 Mar 2023 07:17:40 -0700 (PDT)
X-Gm-Message-State: AAQBX9ddgVUHbdHXC1qIeJzuiu1x1lUfaaMMqrqTfr4kUDbI99UtshdU
        8PmOaxKnZAwi5k+YOeINxtJZkKjoCacv+hwxjw==
X-Google-Smtp-Source: AKy350bpnUIh0Y3dOsByH0JInTgzU6Fdniof4Id3yRA3M5UehlXCBkq6XqT1KY0HTUQS4VYyL/VzpN9pZZ3dOqvJVvM=
X-Received: by 2002:a81:b149:0:b0:543:9065:b225 with SMTP id
 p70-20020a81b149000000b005439065b225mr7296521ywh.5.1680013059755; Tue, 28 Mar
 2023 07:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com> <20230321110813.26808-5-jiaxun.yang@flygoat.com>
In-Reply-To: <20230321110813.26808-5-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 09:17:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+jFqKPVwheobNYNHVk5=u41CXbyyiEdfhEUSAGZmgCoA@mail.gmail.com>
Message-ID: <CAL_Jsq+jFqKPVwheobNYNHVk5=u41CXbyyiEdfhEUSAGZmgCoA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] of: address: Always use dma_default_coherent for
 default coherency
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org
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

On Tue, Mar 21, 2023 at 6:08=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> As for now all arches have dma_default_coherent reflecting default
> DMA coherency for of devices, so there is no need to have a standalone
> config option.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v3: Squash setting ARCH_DMA_DEFAULT_COHERENT into this patch.
> ---
>  arch/powerpc/Kconfig |  2 +-
>  arch/riscv/Kconfig   |  2 +-
>  drivers/of/Kconfig   |  4 ----
>  drivers/of/address.c | 10 +---------
>  4 files changed, 3 insertions(+), 15 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
