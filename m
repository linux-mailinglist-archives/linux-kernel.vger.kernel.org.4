Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E96F6AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEDMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:17:59 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DD5FD3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:17:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A30CE0009;
        Thu,  4 May 2023 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683202674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbXzNdxPcjGO34B7zdhv5ZWV5LEvN4cjVh12sq63EG4=;
        b=gidcvKR34gSCuMExONQ/hoZeB7yA4R21fm8dEKWYTtLk12+qhgdKn5O64FHHon4Ietr048
        sIzqcN2vI5BaGcVvvttZ2zcUS60QFP/zTe1eS4mSYOIQR6UzeQ2adPWHwZ62wldOHNgWO8
        NlEdi+1+0/wtUEG+zeM+GzOQ7OYXqdyE9qtq5tIsIxfURI/dY30YWzzPgpu7xPXa4ouOak
        H+jNesa6nG8RXFrJhE/y4yMXGUaQaWtJ1HlI+ZWifoN128UjQUcBC884O8jQu5x84T3FLi
        Wcescvn/jI+mVr25fMnWqjHOn7OQxrrU9hq7kNMEinNP0gxS+TlVSYkM9ShgZA==
Date:   Thu, 4 May 2023 14:17:50 +0200
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
Message-ID: <20230504141750.107fb1aa@xps-13>
In-Reply-To: <805dea68-8a40-a52a-ad7c-b2e9cd3d05a8@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
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
        <20230503100342.63215058@xps-13>
        <c160eb18-fa50-88a9-a4cf-4afb1b46b177@sberdevices.ru>
        <805dea68-8a40-a52a-ad7c-b2e9cd3d05a8@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 4 May 2023 14:37:45 +0300:

> On 03.05.2023 13:23, Arseniy Krasnov wrote:
> >=20
> >=20
> > On 03.05.2023 11:03, Miquel Raynal wrote: =20
> >> Hi Arseniy,
> >>
> >> avkrasnov@sberdevices.ru wrote on Tue, 2 May 2023 19:13:38 +0300:
> >> =20
> >>> On 02.05.2023 16:05, Miquel Raynal wrote: =20
> >>>> Hi Arseniy,
> >>>>
> >>>> avkrasnov@sberdevices.ru wrote on Tue, 2 May 2023 15:24:09 +0300:
> >>>>    =20
> >>>>> On 02.05.2023 15:17, Miquel Raynal wrote:   =20
> >>>>>> Hi Arseniy,
> >>>>>>
> >>>>>> Richard, your input is welcome below :-)
> >>>>>>      =20
> >>>>>>>>>>>>>> I just checked JFFS2 mount/umount again, here is what i se=
e:
> >>>>>>>>>>>>>> 0) First attempt to mount JFFS2.
> >>>>>>>>>>>>>> 1) It writes OOB to page N (i'm using raw write). It is cl=
eanmarker value 0x85 0x19 0x03 0x20. Mount is done.
> >>>>>>>>>>>>>> 2) Umount JFFS2. Done.
> >>>>>>>>>>>>>> 3) Second attempt to mount JFFS2.
> >>>>>>>>>>>>>> 4) It reads OOB from page N (i'm using raw read). Value is=
 0x85 0x19 0x03 0x20. Done.
> >>>>>>>>>>>>>> 5) It reads page N in ECC mode, and i get:
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 jffs2: mtd->read(0x100 bytes from=
 N) returned ECC error
> >>>>>>>>>>>>>> 6) Mount failed.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> We already had problem which looks like this on another de=
vice. Solution was to use OOB area which is
> >>>>>>>>>>>>>> not covered by ECC for JFFS2 cleanmarkers.           =20
> >>>>>>>>>>>>
> >>>>>>>>>>>> ok, so there is not ECC parity bytes and mtd->read() returns=
 ECC error.
> >>>>>>>>>>>> does it have to use raw write/read on step 1) and 4)?
> >>>>>>>>>>>>            =20
> >>>>>>>>>>>
> >>>>>>>>>>> If i'm using non raw access to OOB, for example write OOB (us=
er bytes) in ECC mode, then
> >>>>>>>>>>> steps 1) and 4) and 5) passes ok, but write to this page will=
 be impossible (for example JFFS2
> >>>>>>>>>>> writes to such pages later) - we can't update ECC codes prope=
rly without erasing whole page.
> >>>>>>>>>>> Write operation will be done without problem, but read will t=
rigger ECC errors due to broken
> >>>>>>>>>>> ECC codes.
> >>>>>>>>>>>
> >>>>>>>>>>> In general problem that we discuss is that in current impleme=
ntation data and OOB conflicts
> >>>>>>>>>>> with each other by sharing same ECC codes, these ECC codes co=
uld be written only once (without
> >>>>>>>>>>> erasing), while data and OOB has different callbacks to acces=
s and thus supposed to work
> >>>>>>>>>>> separately.         =20
> >>>>>>>>>>
> >>>>>>>>>> The fact that there might be helpers just for writing OOB area=
s or just
> >>>>>>>>>> in-band areas are optimizations. NAND pages are meant to be wr=
itten a
> >>>>>>>>>> single time, no matter what portion you write. In some cases, =
it is
> >>>>>>>>>> possible to perform subpage writes if the chip supports it. Pa=
ges may
> >>>>>>>>>> be split into several areas which cover a partial in-band area=
 *and* a
> >>>>>>>>>> partial OOB area. If you write into the in-band *or* out-of-ba=
nd areas
> >>>>>>>>>> of a given subpage, you *cannot* write the other part later wi=
thout         =20
> >>>>>>>>>
> >>>>>>>>> Thanks for details! So in case of JFFS2 it looks like strange, =
that it tries
> >>>>>>>>> to write page after writing clean markers to it before? In the =
old vendor's
> >>>>>>>>> driver OOB write callback is suppressed by return 0 always and =
JFFS2 works
> >>>>>>>>> correctly.       =20
> >>>>>>>>
> >>>>>>>> Can you point the code you're mentioning? (both what JFFS2 which=
 looks
> >>>>>>>> strange to you and the old vendor hack)       =20
> >>>>>>>
> >>>>>>> Here is version of the old vendor's driver:
> >>>>>>>
> >>>>>>> https://github.com/kszaq/linux-amlogic/blob/master_new_amports/dr=
ivers/amlogic/nand/nand/aml_nand.c#L3260
> >>>>>>>
> >>>>>>> In my version there is no BUG() there, but it is same driver for =
the same chip.
> >>>>>>>
> >>>>>>> About JFFS2 - i didn't check its source code, but what I can see =
using printk(), is that it first
> >>>>>>> tries to write cleanmarker using OOB write callback. Then later i=
t tries to write to this page, so
> >>>>>>> may be it is unexpected behaviour of JFFS2?     =20
> >>>>>>
> >>>>>> TBH I am not knowledgeable about JFFS2, maybe Richard can help her=
e.
> >>>>>>
> >>>>>> Are you sure you flash is recognized by JFFS2 as being a NAND devi=
ce?
> >>>>>> Did you enable CONFIG_JFFS2_FS_WRITEBUFFER correctly? Because
> >>>>>> cleanmarker seem to be discarded when using a NAND device, and
> >>>>>> recognizing the device as a NAND device requires the above option =
to be
> >>>>>> set apparently.     =20
> >>>>>
> >>>>> Yes, I have
> >>>>>
> >>>>> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> >>>>>
> >>>>> And i see, that jffs2_mark_erased_block() calls jffs2_cleanmarker_o=
ob() which checks that we have MTD_NANDFLASH. This
> >>>>> check is true, so then jffs2_write_nand_cleanmarker() is called and=
 there is OOB write in it. So I see opposite thing:
> >>>>> cleanmarkers are not discarded with NAND device.    =20
> >>>>
> >>>> Excellent. So when cleanmarker_size =3D=3D 0, it means there is no
> >>>> cleanmarker. But if it is a NAND device, we write the marker anyway.
> >>>>
> >>>> Well I guess it used to work on old controllers using a Hamming ECC
> >>>> engine not protecting any user OOB bytes, so writing the clean marke=
rs
> >>>> would simply not lead to ECC bytes being produced/written. Or it mig=
ht
> >>>> have worked as well on controller drivers not enabling the ECC engine
> >>>> when performing OOB-only writes. It also requires the chip to be old
> >>>> enough to support multiple writes on the same (sub)page as long as t=
he
> >>>> written bits do not overlap?   =20
> >>>
> >>> Yes, with controller which supports such modes there will be no probl=
em here!
> >>> What i see, is that this controller doesn't support multiple writes t=
o the
> >>> same page in ECC mode(e.g. it can't update ECC correctly). =20
> >>
> >> I don't think this is a controller limitation. The NAND chip cannot
> >> write ECC bytes a first time and then overwrite other ECC bytes, that
> >> cannot work. The fact that we write ECC bytes in the first place is
> >> because the ECC engine covers the free OOB bytes used by JFFS2 to write
> >> its cleanmarkers.
> >> =20
> >>> So in v2 i've added
> >>> patch which moves OOB out of ECC area, thus JFFS2 driver will work co=
rrectly. =20
> >>
> >> I am sorry but the above sentence is not clear to me. I believe you
> >> meant the free OOB bytes are moved outside of the area protected by the
> >> ECC engine. In this case I guess it should be fine. =20
> >=20
> > Exactly, free bytes which are reported by OOB layout callbacks were mov=
ed out of
> > ECC area.
> >  =20
> >> =20
> >>> So for me main question here is:
> >>>
> >>> How JFFS2 should work with controllers where we can't update data and=
 OOB
> >>> independently? Driver of this filesystem knows nothing about this fea=
tures of
> >>> the controller.
> >>>
> >>> Or JFFS2 works incorrectly in my case when it tries to call write pag=
e callback
> >>> after calling write OOB callback (IIUC it is better to ask Richard as=
 You mentioned above).
> >>>
> >>> Or may be it is better to suppress OOB write callback (or set it to N=
ULL) in this
> >>> driver as in vendor's driver? =20
> >>
> >> I would assume using the unprotected free OOB bytes to store the
> >> cleanmarkers should work. But that's a bit fragile and very filesystem
> >> oriented. I don't like this much. But on the other side JFFS2 is
> >> legacy, you should use UBI (which does not play with OOB areas) :-) =20
> >=20
> > Problem here is that we can't use UBI in this case, because it does not=
 support
> > small fs images. So the only way to make JFFS2 work is to move free OOB=
 bytes to
> > non protected area. Otherwise i think we have strange situation that JF=
FS2 can't
> > work correctly on specific type on NAND controller. We already had same=
 problem
> > on another NAND controller, and solution was to move OOB free bytes no =
non-protected
> > area:
> >=20
> > https://lore.kernel.org/all/20230329114240.378722-1-mmkurbanov@sberdevi=
ces.ru/
> >=20
> > Thanks, Arseniy =20
>=20
> Upd: may be i can add option for this driver, which makes JFFS2 work corr=
ectly on this chip.
> This feature suppresses OOB writes as in old driver. By default it is dis=
abled and OOB is
> ECC protected(current behaviour), if enabled - it prints WARN_ONCE() and =
always returns 0.
> What do You think?
>=20
> Or may be add an option, which moves free bytes of OOB to ECC non-protect=
ed area and it is disabled
> by default.

I prefer having a single ooblayout where we expose unprotected user OOB
bytes only. As of today, the only upstream user of user OOB bytes is
JFFS2 anyway.

Thanks,
Miqu=C3=A8l
