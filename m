Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDED5BED2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiITSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiITSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:52:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C975CF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:51:55 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n83so4882831oif.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vY8sHYY7zNUoEuLbLjqUl5lsurpJUVgT1WqyEhJsWE8=;
        b=MMpj/KNqVxz+oHCOmTgPx1BIvbKWe/wPCPo4d7GodQLILghv+7qkr/S6m6cR3Kila6
         OhHVY2ETF82PAjps+SF6Eu9XkO2FMau6MY4QRnXQH33RMVm/FRzTuSH7Ai1N1ZM0WRma
         H2Hg5taBWg01mq4aQPWBPcLxlgDPU+2E/FXcY3ru2/No/T7fwsSxwzup98rcr+Ux7/BN
         EO09A/yX0P3FbS/nkBpLeII14aQBNx2+nE5dU+gCvOJeaj3jYC5kB+G9yrUcfqY0bpe+
         AEy5zeUZmCoJx/MdoNlMHmb9P1M+nTLMdkS7+IPKfn7U/ZnYadda2TAa0CiOM1IRO54l
         1qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vY8sHYY7zNUoEuLbLjqUl5lsurpJUVgT1WqyEhJsWE8=;
        b=X2tN1GLZZ8W5Knz59KRSbScg+2E5kAeUDwfHN7aBoP6a5gGwPQ0JB1+JiismjlUPuE
         MvkBsZo6hnHFPO45/ebVTefOoQ9jwOhoZJbvX27CcSQTiMiwRgVQBq/YJnPH6Ir8/WJO
         jgF9eu9qHQAgkZTiIJ5BxgxmtUE+6UcZg60rPsXtwEOzHPC0AwmSRgYP8hnIj/8CoiJH
         0ATxmiqIjV23IXujtdZC0rnp+YmA9ISEELhlGU+BWavVu2FNmqGYwjgGImlnUoKHW2T/
         kB/9zWbPSkSMoCq7/PwdyW/jLguU46GygjQDB3GyFDpqJfLnJp2vvd5GDPB2QITS7odT
         wlTw==
X-Gm-Message-State: ACrzQf0oO/Zny6J6it5Dc4v1b9wuhfoDcGgEnFHGT4CptDvYTjy+PYnb
        tb7J5g4q+HIk5KZnF0bheHc0rRFEzuKLnUwEYaPxcw==
X-Google-Smtp-Source: AMsMyM6mey0/kpmB5FqJFxrogjFkw/IEJbgHNhbIlkVR/h/IDgaOuLIZm1dytx7DrSZFsJrXL03uv7Ix3qF/X+rpPhw=
X-Received: by 2002:aca:35d6:0:b0:34f:bb2a:4f5f with SMTP id
 c205-20020aca35d6000000b0034fbb2a4f5fmr2279516oia.54.1663699914656; Tue, 20
 Sep 2022 11:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
In-Reply-To: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Tue, 20 Sep 2022 19:51:43 +0100
Message-ID: <CAHyZL-fHcyeBM-mmqQHjLidWJK77-cZgbOCjXrHDkXYyjL02ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 7:48 PM Sudip Mukherjee
<sudip.mukherjee@sifive.com> wrote:
>
> The datasheet of is25wp256 says it supports SFDP. Get rid of the static
> initialization of the flash parameters and init them when parsing SFDP.
>
> Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
> SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
> After this patch, it parses the SFDP information and still uses the
> same opcodes.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>
> No change from v2, just resending again with the next patch.
> Results from the tests given by Tudor in the following mail.

Test result after this patch:

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
