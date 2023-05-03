Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8C6F52A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjECIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjECIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:04:51 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F44526C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:03:49 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9B530240015;
        Wed,  3 May 2023 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683101025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWtD5hZ9pO4qfOfqb/gEUugnVCqJ/xBVK6sNPby8CWk=;
        b=iV00TE+i2AgoYyt8d5LKg/8zuOlIz1ELOS3LA3ydbnFzO1+Fd7Wk/nM7XcIdTVpJ4YQL3D
        oZlp4DK5kCbzvtPCQSzy08akUthfe3diKIagYIJywxdKAxqieAvJpeCMTGa918dNnhMJuQ
        PemHM3EJez5nw04UxPvqf6S16lmcDDcA+HiaUpK/9xYwURu9o6SsmLRzoMDsf0UfenjYvw
        ybmomkP1A9OXuAJlZ2OPHO7y8sbJB9v7w9h9ZdIm2j6JyIMNnI6QvDZit4UmIj86l+cFvo
        MC2PmVcDrXUgwgdff4xWG5DkwlncDDhGBHoEz/T+gLhLGVrOfUZj3TTHYm/qdg==
Date:   Wed, 3 May 2023 10:03:42 +0200
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
Message-ID: <20230503100342.63215058@xps-13>
In-Reply-To: <8996d53c-54ff-6a37-e08b-95cae0629703@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
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
        <20230502141703.29f0bc30@xps-13>
        <91cb8e19-e782-b847-8d2b-22580c371c34@sberdevices.ru>
        <20230502150553.65fdeb7f@xps-13>
        <8996d53c-54ff-6a37-e08b-95cae0629703@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 2 May 2023 19:13:38 +0300:

> On 02.05.2023 16:05, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Tue, 2 May 2023 15:24:09 +0300:
> >  =20
> >> On 02.05.2023 15:17, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> Richard, your input is welcome below :-)
> >>>    =20
> >>>>>>>>>>> I just checked JFFS2 mount/umount again, here is what i see:
> >>>>>>>>>>> 0) First attempt to mount JFFS2.
> >>>>>>>>>>> 1) It writes OOB to page N (i'm using raw write). It is clean=
marker value 0x85 0x19 0x03 0x20. Mount is done.
> >>>>>>>>>>> 2) Umount JFFS2. Done.
> >>>>>>>>>>> 3) Second attempt to mount JFFS2.
> >>>>>>>>>>> 4) It reads OOB from page N (i'm using raw read). Value is 0x=
85 0x19 0x03 0x20. Done.
> >>>>>>>>>>> 5) It reads page N in ECC mode, and i get:
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 jffs2: mtd->read(0x100 bytes from N)=
 returned ECC error
> >>>>>>>>>>> 6) Mount failed.
> >>>>>>>>>>>
> >>>>>>>>>>> We already had problem which looks like this on another devic=
e. Solution was to use OOB area which is
> >>>>>>>>>>> not covered by ECC for JFFS2 cleanmarkers.         =20
> >>>>>>>>>
> >>>>>>>>> ok, so there is not ECC parity bytes and mtd->read() returns EC=
C error.
> >>>>>>>>> does it have to use raw write/read on step 1) and 4)?
> >>>>>>>>>          =20
> >>>>>>>>
> >>>>>>>> If i'm using non raw access to OOB, for example write OOB (user =
bytes) in ECC mode, then
> >>>>>>>> steps 1) and 4) and 5) passes ok, but write to this page will be=
 impossible (for example JFFS2
> >>>>>>>> writes to such pages later) - we can't update ECC codes properly=
 without erasing whole page.
> >>>>>>>> Write operation will be done without problem, but read will trig=
ger ECC errors due to broken
> >>>>>>>> ECC codes.
> >>>>>>>>
> >>>>>>>> In general problem that we discuss is that in current implementa=
tion data and OOB conflicts
> >>>>>>>> with each other by sharing same ECC codes, these ECC codes could=
 be written only once (without
> >>>>>>>> erasing), while data and OOB has different callbacks to access a=
nd thus supposed to work
> >>>>>>>> separately.       =20
> >>>>>>>
> >>>>>>> The fact that there might be helpers just for writing OOB areas o=
r just
> >>>>>>> in-band areas are optimizations. NAND pages are meant to be writt=
en a
> >>>>>>> single time, no matter what portion you write. In some cases, it =
is
> >>>>>>> possible to perform subpage writes if the chip supports it. Pages=
 may
> >>>>>>> be split into several areas which cover a partial in-band area *a=
nd* a
> >>>>>>> partial OOB area. If you write into the in-band *or* out-of-band =
areas
> >>>>>>> of a given subpage, you *cannot* write the other part later witho=
ut       =20
> >>>>>>
> >>>>>> Thanks for details! So in case of JFFS2 it looks like strange, tha=
t it tries
> >>>>>> to write page after writing clean markers to it before? In the old=
 vendor's
> >>>>>> driver OOB write callback is suppressed by return 0 always and JFF=
S2 works
> >>>>>> correctly.     =20
> >>>>>
> >>>>> Can you point the code you're mentioning? (both what JFFS2 which lo=
oks
> >>>>> strange to you and the old vendor hack)     =20
> >>>>
> >>>> Here is version of the old vendor's driver:
> >>>>
> >>>> https://github.com/kszaq/linux-amlogic/blob/master_new_amports/drive=
rs/amlogic/nand/nand/aml_nand.c#L3260
> >>>>
> >>>> In my version there is no BUG() there, but it is same driver for the=
 same chip.
> >>>>
> >>>> About JFFS2 - i didn't check its source code, but what I can see usi=
ng printk(), is that it first
> >>>> tries to write cleanmarker using OOB write callback. Then later it t=
ries to write to this page, so
> >>>> may be it is unexpected behaviour of JFFS2?   =20
> >>>
> >>> TBH I am not knowledgeable about JFFS2, maybe Richard can help here.
> >>>
> >>> Are you sure you flash is recognized by JFFS2 as being a NAND device?
> >>> Did you enable CONFIG_JFFS2_FS_WRITEBUFFER correctly? Because
> >>> cleanmarker seem to be discarded when using a NAND device, and
> >>> recognizing the device as a NAND device requires the above option to =
be
> >>> set apparently.   =20
> >>
> >> Yes, I have
> >>
> >> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> >>
> >> And i see, that jffs2_mark_erased_block() calls jffs2_cleanmarker_oob(=
) which checks that we have MTD_NANDFLASH. This
> >> check is true, so then jffs2_write_nand_cleanmarker() is called and th=
ere is OOB write in it. So I see opposite thing:
> >> cleanmarkers are not discarded with NAND device.  =20
> >=20
> > Excellent. So when cleanmarker_size =3D=3D 0, it means there is no
> > cleanmarker. But if it is a NAND device, we write the marker anyway.
> >=20
> > Well I guess it used to work on old controllers using a Hamming ECC
> > engine not protecting any user OOB bytes, so writing the clean markers
> > would simply not lead to ECC bytes being produced/written. Or it might
> > have worked as well on controller drivers not enabling the ECC engine
> > when performing OOB-only writes. It also requires the chip to be old
> > enough to support multiple writes on the same (sub)page as long as the
> > written bits do not overlap? =20
>=20
> Yes, with controller which supports such modes there will be no problem h=
ere!
> What i see, is that this controller doesn't support multiple writes to the
> same page in ECC mode(e.g. it can't update ECC correctly).

I don't think this is a controller limitation. The NAND chip cannot
write ECC bytes a first time and then overwrite other ECC bytes, that
cannot work. The fact that we write ECC bytes in the first place is
because the ECC engine covers the free OOB bytes used by JFFS2 to write
its cleanmarkers.

> So in v2 i've added
> patch which moves OOB out of ECC area, thus JFFS2 driver will work correc=
tly.

I am sorry but the above sentence is not clear to me. I believe you
meant the free OOB bytes are moved outside of the area protected by the
ECC engine. In this case I guess it should be fine.

> So for me main question here is:
>=20
> How JFFS2 should work with controllers where we can't update data and OOB
> independently? Driver of this filesystem knows nothing about this feature=
s of
> the controller.
>=20
> Or JFFS2 works incorrectly in my case when it tries to call write page ca=
llback
> after calling write OOB callback (IIUC it is better to ask Richard as You=
 mentioned above).
>=20
> Or may be it is better to suppress OOB write callback (or set it to NULL)=
 in this
> driver as in vendor's driver?

I would assume using the unprotected free OOB bytes to store the
cleanmarkers should work. But that's a bit fragile and very filesystem
oriented. I don't like this much. But on the other side JFFS2 is
legacy, you should use UBI (which does not play with OOB areas) :-)

Thanks,
Miqu=C3=A8l

>=20
> Thanks, Arseniy
>=20
> >=20
> > Perhaps that's what the hack in the old driver is for. But that's
> > IMHO broken in case of unexpected reboot :-)
> >=20
> > Miqu=C3=A8l =20

