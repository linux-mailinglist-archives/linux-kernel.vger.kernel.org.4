Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645985BACED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIPMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCABEAC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCF862B3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64738C433D7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663329847;
        bh=SDyVHic+g5Ln/swY+PozT5sqObg8/WxJ+rqngYuzFro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DvQwyaMWXD82NwWUoeJrKeV4DUHsMIooQCYHcmXosyl/K7WeLRGRkRndoqJ3SrkK1
         LcvCsmmGFAY+MhYDrz7xpw3FxMi5d+PzQ0fW/asv+Cr0i1n49A0F1qWoS+FI3A47Xy
         4B/5WOw0w9/sSli5YXJHD7wXhQ4foTYIZj90a1gBp8ARlG4GJBQK3lyl2LSF6ogojF
         J6EfBXoXGGAmXN0TxKx6qWywOKVawa0f9COqJsXsBYSXOC1nyzun57z3AbI0LIna/s
         TwatmS31qbtoiZnWx2n5l9+Hob6BiCu2PxJc5cgSzrVV5jiJdbnLsOTt3755sFgYE1
         9aCKWkFxhJIoQ==
Received: by mail-vk1-f170.google.com with SMTP id b5so99905vkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:04:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf1RVpLv1CZJgF1L5GR3jP+fHt5aBoA2lMsca6+Vjt8XOPFkNapR
        efc3S7E6wOd7L1MVKHT9myNOE7ZOcwMnFp+80w==
X-Google-Smtp-Source: AMsMyM7R+47aUUSWrJkPcclUE1JWWBatBMqC16j/7ya6IfwoPKPQZf1oKfsbs1hf02nYS8dtX20SyZppgT1c6KwVmjA=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr1736330vkd.35.1663329846359; Fri, 16
 Sep 2022 05:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-5-j@jannau.net>
In-Reply-To: <20220916094152.87137-5-j@jannau.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Sep 2022 07:03:55 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+u5ZjCNbxQd9FfgvHx6BM4AYjMS63qmm22k2zn5Xqtyg@mail.gmail.com>
Message-ID: <CAL_Jsq+u5ZjCNbxQd9FfgvHx6BM4AYjMS63qmm22k2zn5Xqtyg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] iommu/io-pgtable-dart: Add DART PTE support for t6000
To:     Janne Grunau <j@jannau.net>
Cc:     iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 4:42 AM Janne Grunau <j@jannau.net> wrote:
>
> From: Sven Peter <sven@svenpeter.dev>
>
> The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
> They support a 42bit physical address space by shifting the paddr and
> extending its mask inside the PTE.
> They also come with mandatory sub-page protection now which we just
> configure to always allow access to the entire page. This feature is
> already present but optional on the previous DARTs which allows to
> unconditionally configure it.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - apply change to io-pgtable-dart.c
> - handle pte <> paddr conversion based on the pte format instead of
>   the output address size
>
> Changes in v2:
> - add APPLE_DART2 PTE format
>
>  drivers/iommu/io-pgtable-dart.c | 49 ++++++++++++++++++++++++++++-----
>  drivers/iommu/io-pgtable.c      |  1 +
>  include/linux/io-pgtable.h      |  1 +
>  3 files changed, 44 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
