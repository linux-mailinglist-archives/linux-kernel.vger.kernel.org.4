Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34175E81C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiIWSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiIWSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:31:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67611DFE5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:31:18 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u131so863041oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RQH0ikj6o1UT8tZfU0Tbzm64t8KnmNW2b00rreeuJH8=;
        b=EgQfxf51q6nSHS22d9TFQD++CVkawsWb1isejnpqd54A9ZSLICrUXqJEaBUP8AxQzD
         QFxwLuBOFIoNevwSSCybK/GyjLKvibG7vaQ5X0XJX3VlTZzKzHCBIKTdllfocN9UHFLz
         LIcv/mLbKsSRlyJZGOgtgiCxXZKzOIyW3SsIY0PyEtNZxMMz6pDXlBgr+PWGGxDh5+tz
         cL/S8hbTsZVExsrOb7AFTzJ9L8gTatVw++4PnFaqidwEeMBGe2/zpbZfJKKYalg7R89J
         MD9hNFZQIlVTLDkg1Vct2DlkfW+ciEOTeHH8A1TIt/y9xbcHq5e4wdthVNSeoOGtLK8Q
         HVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RQH0ikj6o1UT8tZfU0Tbzm64t8KnmNW2b00rreeuJH8=;
        b=BFfhmQg7uRre63TmuVCag60hNbvQ34Ovb3XnUO+aMhlbTgN6NUaCYQYjNW0Mc03AmK
         F5hfN6NFxy9NyYETMmv53yS8Qw4FJZdwltRk0nUuz1ZC3cOEXsxNmD+t2NXM4e52PeNe
         3Y57LHBKUPA+FiTa3QZBtmcJXSDHH2ujTqknnKWAm2g97O2GHhsM04P2/DGQlTXV9v0m
         t9N5BI3kyy5u6ZMJQV+zymUfcZyvJeQ2qmngABIJwDvecBP7Qso8rsyC+b/s5vov072f
         1k1xLQfZXaSAJLzlK+JRs1/TEvmV4kmlSVN462TdtP1Kr83jx2T83G4IV+UZopETcDan
         QP0w==
X-Gm-Message-State: ACrzQf2NXOZvBTU1rIJKiA8F2MU5eL24L0rmf0eQEDH5lUk1/YEXKwlj
        oRITUyMRWHQV3OOPTzcyz+HfYG4zdzDVhfZjgc7Q1Q==
X-Google-Smtp-Source: AMsMyM4StEFiN4OPqCyD+zkWZvRXYBnK1F8+6hKtr28dP2nSv+g5XDFPpjs0wKdqia6pvWtmwvkXTHC5iOg75np5uG4=
X-Received: by 2002:a05:6808:ec5:b0:337:ac3c:550c with SMTP id
 q5-20020a0568080ec500b00337ac3c550cmr5084267oiv.262.1663957877485; Fri, 23
 Sep 2022 11:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com> <1b62d0d80d3680e94172149946c936a0@walle.cc>
In-Reply-To: <1b62d0d80d3680e94172149946c936a0@walle.cc>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Fri, 23 Sep 2022 19:31:06 +0100
Message-ID: <CAHyZL-eU7t5aD5ube=L+7MWHow+1uXROfTXxmFdHQMj-w6jYVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

On Thu, Sep 22, 2022 at 3:19 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-09-20 20:48, schrieb Sudip Mukherjee:
> > The datasheet of is25wp256 says it supports SFDP. Get rid of the static
> > initialization of the flash parameters and init them when parsing SFDP.
> >
> > Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
> > SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
> > After this patch, it parses the SFDP information and still uses the
> > same opcodes.
> >
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> > ---
> >
> > No change from v2, just resending again with the next patch.
> > Results from the tests given by Tudor in the following mail.
> >
> >
> >  drivers/mtd/spi-nor/issi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> > index 89a66a19d754f..8b48459b5054c 100644
> > --- a/drivers/mtd/spi-nor/issi.c
> > +++ b/drivers/mtd/spi-nor/issi.c
> > @@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
> >       { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
> >               NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
>
> I'm curious, does it also work with:
>         { "is25wp256", INFO(0x9d7019, 0, 0, 0)
>                 PARSE_SFDP

Applied this on top of my patch series:

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 014cd9038bed..a0ddad2afffc 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -70,7 +70,7 @@ static const struct flash_info issi_nor_parts[] = {
                NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ) },
        { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
                NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
SPI_NOR_QUAD_READ) },
-       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
+       { "is25wp256", INFO(0x9d7019, 0, 0, 0)
                PARSE_SFDP
                FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
                FLAGS(SPI_NOR_QUAD_PP)

And, I can see it working. dmesg showed:
[   35.299888] spi-nor spi0.0: is25wp256 (32768 Kbytes)
[   35.403858] spi-nor spi0.0: mtd .name = spi0.0, .size = 0x2000000
(32MiB), .erasesize = 0x00001000 (4KiB) .numeraseregions = 0

The system booted and I can see all the partitions.

-- 
Regards
Sudip
