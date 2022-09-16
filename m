Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50755BACF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIPMFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIPMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D228A6C8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8537662772
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9804C433D7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663329920;
        bh=X/vY/KRBPWKbSbi9cNPBQFHDmijh1dF4skZMnpE87+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tra+VRACI/8hW1YMCjHLg2258UxkPf1UGNEnpc7sHblYHZs+Pkl5V0b5zQmu1dtXu
         0xehh5aPOv9M2n0FY98KDCiw6hSQnV3pZk0HdgSyTsKO2y82mz/rLjBZpFKU6bUx4b
         2ZzDtpqSmxacQEkqlAFp7UlIamVOZ4419hXzlSOwZnzZE4r4ShIoWntOPehiA4vTA/
         Q9vFBZYgu+hBzJxOlBILpj60Kt0M575/+iWvMn82D3xFHs61M7j3ro+5KBtf1XSEGM
         vC67l1h2LZL5N9nkuGbegELOnjjV43Cllt5aSmXvP9cCZiSl68G4BDq6pwon7Sto7d
         HuoJvzvZAMRuw==
Received: by mail-ua1-f42.google.com with SMTP id a18so7792134uak.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:05:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf0hYu1l0tZ5gCgvz/nxmgDRei/a4mwQx0OBrFfd7XRZtC2xdQdz
        Golvn+iNmoz5Dj0N2Y6xMZ7M07cbsRbfAmjbxQ==
X-Google-Smtp-Source: AMsMyM6JqoWENmcjIu/e8yxtT/sLSv8+SY5ABk4vsdDmdDuhMa7hBIrdG0PEFMAjHmumVKlV+9knF9FfzOgvFU7wu8g=
X-Received: by 2002:ab0:2ea9:0:b0:395:b672:508 with SMTP id
 y9-20020ab02ea9000000b00395b6720508mr1696771uay.63.1663329918882; Fri, 16 Sep
 2022 05:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-6-j@jannau.net>
In-Reply-To: <20220916094152.87137-6-j@jannau.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Sep 2022 07:05:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL27Oj3+Pahyfn+HmW-bTtwT0UnSuRDRAiyk3nExV4wVw@mail.gmail.com>
Message-ID: <CAL_JsqL27Oj3+Pahyfn+HmW-bTtwT0UnSuRDRAiyk3nExV4wVw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iommu: dart: Support t6000 variant
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

On Fri, Sep 16, 2022 at 4:43 AM Janne Grunau <j@jannau.net> wrote:
>
> From: Sven Peter <sven@svenpeter.dev>
>
> The M1 Pro/Max/Ultra SoCs come with a new variant of DART which
> supports a larger physical address space with a different PTE format.
> Pass through the correct paddr address space size and the PTE format
> to the io-pgtable code which will take care of the rest.
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
>
> Changes in v2:
> - use APPLE_DART2 PTE format for dart-t6000
>
>  drivers/iommu/apple-dart.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
