Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA95BED2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiITSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiITSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:53:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF70B74CF2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:53:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d64so1925675oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NQSp04YXkI8Lt5/3SrP2Re4/jE+TRLZY4RvOoW+1RS8=;
        b=PG/CqIvz8CUj25Csqo/zQ1Vw3RziRi6Mw9dmoSRn37M+03Oj9GZrd/CVOnioh9DFA5
         Y0Q1zG1l2rC9OVIVfoWaKV2tNR9x1U2L0q8PO91prw6t2BAAfXIcgssiZHI1mM1H6Qgi
         rJsFXFzw7uF6GMd1rNcC2KQDr5j9aWQPhfxtzxORZsXH0DLBjErBcEp1l4Yq8kqfvWED
         y1K5zeZPWb3VHniyvT/rp5ZQZVJOhL8UKRaS1Wx/3w6xcp5VoF0suIjmeWp9XI3WSH39
         r8UUDZhsX1rSdRr24u6s+C3Ecunb8ALKYwLizTZJJGr0i4LqLK8WI8bJYDSrojDlpsqb
         2RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NQSp04YXkI8Lt5/3SrP2Re4/jE+TRLZY4RvOoW+1RS8=;
        b=ihJmOj5e1bJnyo7iq98wDSemEK5dOENXmFp/rqs3hmWlbrtNTbwUAOAqWlZuqmSKPw
         xHvsheuAZqCcVpN8Qd7bRh4mAKUwP6GmFUk4/P6/x/OnPySbhqvnBE1AGcGOBzIlZ2Pq
         s0exrHhBr0YUW82A/GhuxDeJBUDzsxODi1I+/8vsc/AD7ObaVcRevBhAd3PwKZ2g0dpl
         nsQo0xYuy4gT+PtjeghUwHfieaRwDI7Dxp6enZqjmMrQP0rhxooFvmpk/abtq+W8Py4t
         Z0a/Dwn+f9J0h2oKUa/XRacYCEZnRMN66HlCMpNnk4SSIeZllg9HagNpbW7wBFY97Iil
         0qZg==
X-Gm-Message-State: ACrzQf13nGchh7xv0FyfxVy3Yz9/t5BX/czr9UEs1U9tJ6VbKoA9Gn1a
        L7bssTXm2TF65OiDmUmaWGBNE7UUOds/tDSReblddw==
X-Google-Smtp-Source: AMsMyM5zU9rZvOZ0lJNvR3G0TS5hmBY1MdBbNjW0HVale+YxMne+zYZy+LgmwoIa+yEamOKbcWKsAAZncI+d9m1lYpM=
X-Received: by 2002:aca:35d6:0:b0:34f:bb2a:4f5f with SMTP id
 c205-20020aca35d6000000b0034fbb2a4f5fmr2281456oia.54.1663699987658; Tue, 20
 Sep 2022 11:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com> <20220920184808.44876-2-sudip.mukherjee@sifive.com>
In-Reply-To: <20220920184808.44876-2-sudip.mukherjee@sifive.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Tue, 20 Sep 2022 19:52:56 +0100
Message-ID: <CAHyZL-ch=mr0x_19e6P9G+Z4sW2iJXW9nTnXUNAhn+pTptN2ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: add SFDP fixups for Quad Page Program
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
> SFDP table of some flash chips do not advertise support of Quad Input
> Page Program even though it has support. Use flags and add hardware
> cap for these chips.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>
> Change from v2: SPI_NOR_QUAD_PP added to info->flags instead of
> info->fixup_flags.
> Link: https://lore.kernel.org/lkml/498c33a8-014f-e542-f143-cba5760fafdd@microchip.com/
>
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
fefab5ffbc2ca7bed3b45732f2fe6a8139cd6248  qspi_test
fefab5ffbc2ca7bed3b45732f2fe6a8139cd6248  qspi_read

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
