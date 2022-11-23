Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207F636283
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiKWO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiKWO4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:56:31 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2570A37;
        Wed, 23 Nov 2022 06:56:30 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id w9so11328878qtv.13;
        Wed, 23 Nov 2022 06:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtDtDOhppRv+31z+yGSZ+dwXt5ca6W+mR7J4/BtnvWc=;
        b=crf1TcdqaCLycF73ITi/Bku2OZkcETQq+4D4W7jFdyjWOyIfwHhbPRa65pvCUyfWed
         /mq1IgoU+GUtYNRCfpx/LJf83XP+8MMk21P/2kspDU4ng5swyUv9DuaMrxgPCfD1272Z
         Jy4VXwaDJ3cMCJDRyRUDjsoslLJJe/UyWOIM1kOzCYcqRx6aGfbeFtZAbhXda4wXoG9V
         jwFfnUnCdI5CeBy4xNA4VxXIcI/iMx2J06A+ytWDygBhI61KdmomYMWmfCiKvKk4SoAj
         qG2GRsg8VbwT41Xi9w/l9einR0YqChpFyiqoveGhKeo8GukEPegTXzez4xiVrP/13szs
         hi0A==
X-Gm-Message-State: ANoB5pmDruPJbxnJZZbuvCBwPQ95O/DbDVdEAm04fPtTNT1CU249ykJ6
        +BKTXkD76mxUgmIAhoI4DQSIhWSM53b98g==
X-Google-Smtp-Source: AA0mqf7LaeoyniaSGsEW1viwZ6mT/yaHtlaLaTubMgxDGL2RUrx72oIT+WEEhVjZ1qdEej5uNIFLoQ==
X-Received: by 2002:ac8:5204:0:b0:3a5:6a35:bac8 with SMTP id r4-20020ac85204000000b003a56a35bac8mr26453927qtn.615.1669215389311;
        Wed, 23 Nov 2022 06:56:29 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006bb8b5b79efsm12574251qko.129.2022.11.23.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:56:29 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3b10392c064so13535117b3.0;
        Wed, 23 Nov 2022 06:56:29 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr1298002ybc.543.1669215004429; Wed, 23
 Nov 2022 06:50:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1656341824.git.geert+renesas@glider.be> <923c057c77b146710a82d486f89ce3a8ebda7ccd.1656341824.git.geert+renesas@glider.be>
In-Reply-To: <923c057c77b146710a82d486f89ce3a8ebda7ccd.1656341824.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Nov 2022 15:49:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5rZVh_oJJjkkD1H33N=49sE3KGaHoRuW1DBc5x=3+PQ@mail.gmail.com>
Message-ID: <CAMuHMdU5rZVh_oJJjkkD1H33N=49sE3KGaHoRuW1DBc5x=3+PQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] memory: renesas-rpc-if: Reinitialize registers during
 system resume
To:     linux-renesas-soc@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 5:31 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> During PSCI system suspend, R-Car Gen3 SoCs may be powered down, and
> thus the RPC-IF register state may be lost.  Consequently, when using
> the RPC-IF after system resume, data corruption may happen.
>
> Fix this by reinitializing the hardware state during system resume.
> As this requires resuming the RPC-IF core device, this can only be done
> when the device is under active control of the HyperBus or SPI child
> driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

For v2, I dropped this patch from the series.

Apparently this patch is not needed, nor does it have any impact on
HyperFLASH read operation on Salvator-XS with R-Car M3-N ES1.0 and
Ebisu-4D with R-Car E3 ES1.0.

On Salvator-X with R-Car M3-W ES1.0, there is a different issue causing
random bit flips (which is not solved by the Strobe Timing Adjustment
bit (STRTIM) fix for R-Car M3-W ES1.x in the BSP).

On Salvator-XS with R-Car H3-ES2.0, corruption is seen after s2ram.
TL;DR: while this patch does have impact on that, RPC operation after
s2ram is still not guaranteed, and the core issue is still not
understood.

---
For testing, I use the following command to read /dev/mtdblock1 (which
contains the BL2 bootloader) and check its checksum 100 times:

    time sha256sum -c <(yes $(cat mtdblock1.sha256sum) | head -100)

After boot and s2idle, the success rate is 100%.

1. Without this patch, the failure rate after s2ram is ca. 65%.

When splitting and comparing the data read back, some blocks of 64 KiB
(but not always the same on different runs) have been replaced by bad
data, containing either data from elsewhere, or all ones.  The latter is
probably the same symptom as the former, as the HyperFLASH does contain
blocks with all-ones data.

The data from elsewhere looks like e.g.:

    00046f10  75 75 69 64 5f 64 69 73  75 75 69 64 5f 64 69 73
|uuid_disuuid_dis|
    00046f20  64 72 27 0a 20 20 20 20  64 72 27 0a 20 20 20 20  |dr'.
  dr'.    |
    00046f30  6c 69 67 6e 65 64 20 74  6c 69 67 6e 65 64 20 74
|ligned tligned t|
    00046f40  61 64 64 72 32 20 63 6f  61 64 64 72 32 20 63 6f  |addr2
coaddr2 co|
    00046f50  0a 6d 6d 63 20 72 70 6d  0a 6d 6d 63 20 72 70 6d  |.mmc
rpm.mmc rpm|
    00046f60  20 6c 61 72 67 65 72 0a  20 6c 61 72 67 65 72 0a  |
larger. larger.|
    00046f70  6d 32 00 63 6d 6d 31 00  6d 32 00 63 6d 6d 31 00
|m2.cmm1.m2.cmm1.|
    00046f80  32 5f 64 61 74 61 34 00  32 5f 64 61 74 61 34 00
|2_data4.2_data4.|
    00046f90  31 00 47 50 5f 35 5f 31  31 00 47 50 5f 35 5f 31
|1.GP_5_11.GP_5_1|
    00046fa0  65 78 63 65 65 64 65 64  65 78 63 65 65 64 65 64
|exceededexceeded|
    00046fb0  30 34 2d 72 63 34 2d 30  30 34 2d 72 63 34 2d 30
|04-rc4-004-rc4-0|

which seems to originate from two copies of the first 8 bytes of each of
the following lines, found elsewhere in the HyperFLASH:

    006f1000  75 75 69 64 5f 64 69 73  6b 3d 00 6e 61 6d 65 3d
|uuid_disk=.name=|
    ...
    006f2000  64 72 27 0a 20 20 20 20  20 20 70 61 73 73 69 6e  |dr'.
    passin|
    ...
    006f3000  6c 69 67 6e 65 64 20 74  6f 0a 20 20 20 20 20 20
|ligned to.      |
    ...
    006f4000  61 64 64 72 32 20 63 6f  75 6e 74 00 6d 65 6d 6f  |addr2
count.memo|
    ...
    006f5000  0a 6d 6d 63 20 72 70 6d  62 20 6b 65 79 20 3c 61  |.mmc
rpmb key <a|
    ...
    006f6000  20 6c 61 72 67 65 72 0a  00 75 6e 7a 69 70 00 75  |
larger..unzip.u|
    ...
    006f7000  6d 32 00 63 6d 6d 31 00  63 6d 6d 30 00 63 73 69
|m2.cmm1.cmm0.csi|
    ...
    006f8000  32 5f 64 61 74 61 34 00  73 64 68 69 32 5f 64 61
|2_data4.sdhi2_da|
    ...
    006f9000  31 00 47 50 5f 35 5f 31  32 00 47 50 5f 35 5f 31
|1.GP_5_12.GP_5_1|
    ...
    006fa000  65 78 63 65 65 64 65 64  00 0a 25 73 3b 20 73 74
|exceeded..%s; st|
    ...
    006fb000  30 34 2d 72 63 34 2d 30  30 30 38 32 2d 67 35 34
|04-rc4-00082-g54|

For both hexdumps above, offsets are absolute FLASH offsets, not relative
partition offsets.  Still, there is some similarity (e.g. 0x46f10 vs.
0x6f1000).

2. With this patch, the failure rate of 100 reads after s2ram is either
0%, or 100%.  The same is true after subsequent s2ram operations.

Contrary to before this patch, in case of corruption, the data read back
is always the same: i.e. either the good data is read back, or the exact
same bad data is read back.  In case of bad data, some blocks of 64 KiB
have been replaced by blocks containing either data from elsewhere,
or all ones again....

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
