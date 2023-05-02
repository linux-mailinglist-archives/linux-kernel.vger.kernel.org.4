Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC26F438C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjEBMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjEBMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:17:13 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5630E8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:17:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2ED8540014;
        Tue,  2 May 2023 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683029826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WtAk/oO17QNSG+MVFQT+biwAhXZn5Gzxzievf+xDyU=;
        b=TxUhuHagSMChb0MUZjPqcqj1NgRhBR1NzWL1NTGB9ytH+m8Rvb9B5G5q+dJRYBCVUPJn7H
        XKmvBjcrNYMXC+oBhR8GMwca+u4UX7DRSoOy1fLlhyxuq+7sILdjiENtGdUIByXWqEY37l
        NhWBK9rhuaEFgDwk2LGmFJ0noK9KQ4y0oJWlnn/UaSx7ag/b5/POIO1MmIJhOx07ymeIsO
        Qv6Oi4EjLMuWgqitdeu8dfL2XqCLEiKUQQMZDXZesdjs6/9qc1yKhXL20XRZJTFdscA4iC
        CrLpV2X2ywqfKWLJkmS4TNfPqeKuoyfLiX+hFb6i/Nodnn3xyZIjAALORMbFGQ==
Date:   Tue, 2 May 2023 14:17:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "yonghui.yu" <yonghui.yu@amlogic.com>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before
 read
Message-ID: <20230502141703.29f0bc30@xps-13>
In-Reply-To: <2b2f5cb4-84f7-65f6-13b2-42f965503023@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230413102200.309fbe9c@xps-13>
        <b3279de4-e89d-db03-a515-a6aa52ab90d3@sberdevices.ru>
        <20230413122252.0a8efcd8@xps-13>
        <569a948e-654a-b21f-8a4f-55dc4b295387@sberdevices.ru>
        <60fa656e-bda1-1de6-a79e-3e3041cd69a8@sberdevices.ru>
        <780c0cae-18b6-2652-1c2c-6d398ea60451@amlogic.com>
        <e7c49f2d-b3c1-8d9b-76fe-c8759b37c7c7@sberdevices.ru>
        <20230418152505.72fc16da@xps-13>
        <15a6e415-1489-a81f-fc8f-2372678ad2cb@sberdevices.ru>
        <ee10bdeb-416c-70f0-d323-7107fe0746e8@amlogic.com>
        <5e4b395e-bf9d-0123-a0f2-2b378d950b29@sberdevices.ru>
        <fda1ae91-4bf8-6945-bd0d-b6dabc9cb4bd@sberdevices.ru>
        <a5010dcf-a8ce-f144-949c-687548cefce7@amlogic.com>
        <cf27b6b4-a75b-c5a6-32ea-ac20a2984192@sberdevices.ru>
        <20230502115913.78012d98@xps-13>
        <2274b432-d1a9-b3cf-4f7b-08c4a4c580b5@sberdevices.ru>
        <20230502132745.14349770@xps-13>
        <2b2f5cb4-84f7-65f6-13b2-42f965503023@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

Richard, your input is welcome below :-)

> >>>>>>> I just checked JFFS2 mount/umount again, here is what i see:
> >>>>>>> 0) First attempt to mount JFFS2.
> >>>>>>> 1) It writes OOB to page N (i'm using raw write). It is cleanmark=
er value 0x85 0x19 0x03 0x20. Mount is done.
> >>>>>>> 2) Umount JFFS2. Done.
> >>>>>>> 3) Second attempt to mount JFFS2.
> >>>>>>> 4) It reads OOB from page N (i'm using raw read). Value is 0x85 0=
x19 0x03 0x20. Done.
> >>>>>>> 5) It reads page N in ECC mode, and i get:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 jffs2: mtd->read(0x100 bytes from N) ret=
urned ECC error
> >>>>>>> 6) Mount failed.
> >>>>>>>
> >>>>>>> We already had problem which looks like this on another device. S=
olution was to use OOB area which is
> >>>>>>> not covered by ECC for JFFS2 cleanmarkers.     =20
> >>>>>
> >>>>> ok, so there is not ECC parity bytes and mtd->read() returns ECC er=
ror.
> >>>>> does it have to use raw write/read on step 1) and 4)?
> >>>>>      =20
> >>>>
> >>>> If i'm using non raw access to OOB, for example write OOB (user byte=
s) in ECC mode, then
> >>>> steps 1) and 4) and 5) passes ok, but write to this page will be imp=
ossible (for example JFFS2
> >>>> writes to such pages later) - we can't update ECC codes properly wit=
hout erasing whole page.
> >>>> Write operation will be done without problem, but read will trigger =
ECC errors due to broken
> >>>> ECC codes.
> >>>>
> >>>> In general problem that we discuss is that in current implementation=
 data and OOB conflicts
> >>>> with each other by sharing same ECC codes, these ECC codes could be =
written only once (without
> >>>> erasing), while data and OOB has different callbacks to access and t=
hus supposed to work
> >>>> separately.   =20
> >>>
> >>> The fact that there might be helpers just for writing OOB areas or ju=
st
> >>> in-band areas are optimizations. NAND pages are meant to be written a
> >>> single time, no matter what portion you write. In some cases, it is
> >>> possible to perform subpage writes if the chip supports it. Pages may
> >>> be split into several areas which cover a partial in-band area *and* a
> >>> partial OOB area. If you write into the in-band *or* out-of-band areas
> >>> of a given subpage, you *cannot* write the other part later without  =
 =20
> >>
> >> Thanks for details! So in case of JFFS2 it looks like strange, that it=
 tries
> >> to write page after writing clean markers to it before? In the old ven=
dor's
> >> driver OOB write callback is suppressed by return 0 always and JFFS2 w=
orks
> >> correctly. =20
> >=20
> > Can you point the code you're mentioning? (both what JFFS2 which looks
> > strange to you and the old vendor hack) =20
>=20
> Here is version of the old vendor's driver:
>=20
> https://github.com/kszaq/linux-amlogic/blob/master_new_amports/drivers/am=
logic/nand/nand/aml_nand.c#L3260
>=20
> In my version there is no BUG() there, but it is same driver for the same=
 chip.
>=20
> About JFFS2 - i didn't check its source code, but what I can see using pr=
intk(), is that it first
> tries to write cleanmarker using OOB write callback. Then later it tries =
to write to this page, so
> may be it is unexpected behaviour of JFFS2?

TBH I am not knowledgeable about JFFS2, maybe Richard can help here.

Are you sure you flash is recognized by JFFS2 as being a NAND device?
Did you enable CONFIG_JFFS2_FS_WRITEBUFFER correctly? Because
cleanmarker seem to be discarded when using a NAND device, and
recognizing the device as a NAND device requires the above option to be
set apparently.

Thanks,
Miqu=C3=A8l
