Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF455B9FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIOQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIOQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:52:21 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F195A45D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:52:03 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11e9a7135easo48342390fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tOtVH4ixRGCe5uqoihAe8MK5fBynZJb5fcnks2GXImY=;
        b=TvLczY1t4EDKLbg08MYFD6pN8vktVGlKuT2XDNIfqwh/OI5WLnvWo3tm5sKdeb/7u1
         PBmQGDRthHxMtYgvWysJqnCLh0sbmX8zGc0MAhGvMV2hoCbRU4aSJSOamAplXO+T8j7N
         vtD8WR5GrRP59RXwiSqZE8J56o6Jp5InqFC02ROSmdYML7wHoIuTy7bYW0INETyz7fU+
         GGnI06U1rh3QnfdBiE5K6hm0NtXjhuV1D5ik3mmZznK6T+DMMN2Xw2ZJhPAbFPfCOxsa
         JuSasCv3MqcDhJH5NQhzxoRXJpjhEifZdbGDAX+ahd98Z/apViNuOzUAUfWvQUMREBz3
         IUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tOtVH4ixRGCe5uqoihAe8MK5fBynZJb5fcnks2GXImY=;
        b=vwMYIcP4BqZAkcj4lqXplYFnuw3Stj82jXNULjWmqu5eXu/U26AZhOo8S2Yrd1Y0ft
         bITgh0dPjcsabrTbaCWdePMt6uXgw6qGszMIoQvZ+Wzi7JYJCJVfgjz1i7HwuVlF0T8h
         6IdujzC2Ryq6v1wxVcI+GrObCNzJxgVDAWcwg1FLdKsBo0wlhdQ/f455q2Hx4QOSIHiG
         7E+Lp/XR0gEGiBDVSjv/Mc+TBOTjEKw3M+g9QxHv76bjqb2ypVW5FfC4WTJkEU2+33ft
         dkWM/FrmvbnJRZdyGmdYrBgnO3xTT20D7CvUqJ52ykW7P0G+6Od9t/s2gEFkayqZQPn6
         9cNA==
X-Gm-Message-State: ACrzQf2gjLxqIj1KFWZZ7m6CWgU1HCor2Ajp0ZO0vR213TdlkN6zVelV
        Dm+wdSzgcY5Prv6W8aTMu3eipNWgW5vadzqPi8ZZ1Q==
X-Google-Smtp-Source: AMsMyM5SnZ8boja/eEQ65OZdUWRxu9Wq37qnXSNoTu87ivkLR6L3NK1Q4FF12nTu+0vua12P6qkAyirrVmf6vW/G32I=
X-Received: by 2002:a05:6870:3448:b0:12b:1a11:e868 with SMTP id
 i8-20020a056870344800b0012b1a11e868mr345228oah.198.1663260722395; Thu, 15 Sep
 2022 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-2-sudip.mukherjee@sifive.com> <2a50d782-ff21-91af-8488-503168e29867@microchip.com>
In-Reply-To: <2a50d782-ff21-91af-8488-503168e29867@microchip.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Thu, 15 Sep 2022 17:51:51 +0100
Message-ID: <CAHyZL-fdW-r_6Tfx+jCiMip7XN-GWZ0PYAfLCrexoq8ayLdiyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
To:     Tudor.Ambarus@microchip.com
Cc:     pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, greentime.hu@sifive.com,
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

Hi Tudor,

On Wed, Aug 10, 2022 at 8:55 AM <Tudor.Ambarus@microchip.com> wrote:
>
> On 8/9/22 23:14, Sudip Mukherjee wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
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
> >  drivers/mtd/spi-nor/issi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> > index 89a66a19d754..8b48459b5054 100644
> > --- a/drivers/mtd/spi-nor/issi.c
> > +++ b/drivers/mtd/spi-nor/issi.c
> > @@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
> >         { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
> >                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
> > -               NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> > +               PARSE_SFDP
> >                 FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
> >                 .fixups = &is25lp256_fixups },
> >
> > --
> > 2.30.2
> >
>
> Looks good to me.
> When submitting flash updates or new flash additions, we require contributors
> to do a little test using mtd-utils and to dump the SPI NOR sysfs entries.
> Would you please do that?
>
> Here's the simple test:

Here is the test result with only the PARSE_SFDP change. I can resend
the patch if you want.
I will work on the other patch enabling Quad PP now and send that
along with its own test result.

# dd if=/dev/urandom of=./qspi_test bs=1M count=6
6+0 records in
6+0 records out

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug erase /dev/mtd4 0 6291456
Erased 6291456 bytes from address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# hexdump qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0600000

# mtd_debug write /dev/mtd4 0 6291456 qspi_test
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash

# mtd_debug read /dev/mtd4 0 6291456 qspi_read
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read

# sha1sum qspi_test qspi_read
57f8d4fee65622104e24276e865f662844f12242  qspi_test
57f8d4fee65622104e24276e865f662844f12242  qspi_read

# cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
is25wp256

# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
9d7019

# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
issi

# xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110300000ff9d05010380000002ffffffffffff
ffffffffffffffffffffffffffffffffffffe520f9ffffffff0f44eb086b
083b80bbfeffffffffff00ffffff44eb0c200f5210d800ff234ac90082d8
11cecccd68467a757a75f7aed55c4a422cfff030faa9ffffffffffffffff
ffffffffffffffff501950169ff9c0648fefffff

# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
ba14818b9ec42713f24d94d66bb90ba0  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp


--
Regards
Sudip
