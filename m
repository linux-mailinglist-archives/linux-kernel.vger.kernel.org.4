Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07076F408A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjEBJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:59:23 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBAF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:59:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B2348C000D;
        Tue,  2 May 2023 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683021558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dvd+YJ9QYW6nikd3ncq16PFBQQJnsDafDti7fUtdmI=;
        b=cWTT6ps84p3U/m7lifbiRXvE2IJtKcWqcbVBlbIja+s9iQl0F0L+lhbHG7mRT+VZ6/fqBi
        /wrhO0go0gJ+6CEJxKUKQnzsmRzj7WvAkJ7mS/GsG0hn128iZ9lHP3+h43ATJQIpDzcjck
        BmsYiiemDjLIPOfgIQIwCpNe9ru/fXYGipRN2g0KrNuHrasKevDocqmX7HaNuT6UuJ6R8z
        JMIZFCulerVZTCHRW8aRqb/JfAAViiMut18/gzChhpMgQIIqMpmOV30jGOrYifMF1RElw3
        vFjM0gY29qCWX4oUlFARkaV8uvOhnZcT6XP30D2tbCry+ywEAjYCxFQ5OujPJw==
Date:   Tue, 2 May 2023 11:59:13 +0200
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
Message-ID: <20230502115913.78012d98@xps-13>
In-Reply-To: <cf27b6b4-a75b-c5a6-32ea-ac20a2984192@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412163214.0c764bb3@xps-13>
        <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
        <fbb8cb2b-0996-3029-b368-f67087d73487@amlogic.com>
        <7520e512-8a19-ff04-364c-b5be0a579ef0@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Wed, 26 Apr 2023 17:46:19 +0300:

> On 26.04.2023 16:51, Liang Yang wrote:
> > Hi Arseniy,
> >=20
> > On 2023/4/20 17:37, Arseniy Krasnov wrote: =20
> >> [ EXTERNAL EMAIL ]
> >>
> >> On 19.04.2023 09:41, Arseniy Krasnov wrote: =20
> >>>
> >>>
> >>> On 19.04.2023 06:05, Liang Yang wrote: =20
> >>>> Hi Arseniy,
> >>>>
> >>>> On 2023/4/18 22:57, Arseniy Krasnov wrote: =20
> >>>>> [ EXTERNAL EMAIL ]
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 18.04.2023 16:25, Miquel Raynal wrote: =20
> >>>>>> Hi Arseniy,
> >>>>>> =20
> >>>>>>>>> Hello again @Liang @Miquel!
> >>>>>>>>>
> >>>>>>>>> One more question about OOB access, as I can see current driver=
 uses the following
> >>>>>>>>> callbacks:
> >>>>>>>>>
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand->ecc.write_oob_raw =3D nand=
_write_oob_std;
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand->ecc.write_oob =3D nand_wri=
te_oob_std;
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Function 'nand_write_oob_std()' writes data to the end of the p=
age. But as I
> >>>>>>>>> can see by dumping 'data_buf' during read, physical layout of e=
ach page is the
> >>>>>>>>> following (1KB ECC):
> >>>>>>>>>
> >>>>>>>>> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB o=
f data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>> 0x400: [ 2B user data] [ 14B ECC code]
> >>>>>>>>> 0x410: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB o=
f data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]=C2=A0=C2=A0=C2=A0 (A)
> >>>>>>>>> 0x810: [ 2B user data] [ 14B ECC code]
> >>>>>>>>> 0x820: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32B unused=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> So, after 'nand_write_oob_std()' (let data be sequence from [0x=
0 ... 0x3f]),
> >>>>>>>>> page will look like this:
> >>>>>>>>>
> >>>>>>>>> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ]
> >>>>>>>>> 0x400: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ........=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>> 0x7f0: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ]
> >>>>>>>>> 0x800: [ 00 .......................=C2=A0 ]
> >>>>>>>>> 0x830: [ ........................ 3f ]
> >>>>>>>>>
> >>>>>>>>> Here we have two problems:
> >>>>>>>>> 1) Attempt to display raw data by 'nanddump' utility produces a=
 little bit
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invalid output, as driver relies=
 on layout (A) from above. E.g. OOB data
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is at 0x400 and 0x810. Here is a=
n example (attempt to write 0x11 0x22 0x33 0x44):
> >>>>>>>>>
> >>>>>>>>> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff=C2=
=A0 |."..............|
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff f=
f ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: 33 44 ff ff ff ff ff ff ff f=
f ff ff ff ff ff ff=C2=A0 |3D..............|
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff f=
f ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff f=
f ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>> =20
> >>>>>>>> Hi Arseniy,
> >>>>>>>>
> >>>>>>>> I realized the write_oob_raw() and write_oob() are wrong in meso=
n_nand.c. I suggest both of them should be reworked and follow the format o=
f meson nand controller. i.e. firstly format the data in Layout (A) and the=
n write. reading is firstly reading the data of layout (A) and then compost=
 the layout (B). =20
> >>>>>>>
> >>>>>>> IIUC after such writing only OOB (e.g. user bytes) according layo=
ut (A), hw will also write ECC codes, so
> >>>>>>> it will be impossible to write data to this page later, because w=
e cannot update ECC codes properly for the newly
> >>>>>>> written data (we can't update bits from 0 to 1).
> >>>>>>> =20
> >>>>>>>>
> >>>>>>>> =20
> >>>>>>>>>
> >>>>>>>>> 2) Attempt to read data in ECC mode will fail, because IIUC pag=
e is in dirty
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state (I mean was written at lea=
st once) and NAND controller tries to use
> >>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ECC codes at 0x400 and 0x810, wh=
ich are obviously broken in this case. Thus =20
> >>>>>>>>
> >>>>>>>> As i said above, write_oob_raw() and write_oob() should be rewor=
ked.
> >>>>>>>> i don't know what do you mean page was written at least once. an=
yway the page should be written once, even just write_oob_raw(). =20
> >>>>>>>
> >>>>>>> Sorry, You mean that after OOB write, we cannot write to the data=
 area (e.g. 0x0 .. 0x810) until page will be erased? For example
> >>>>>>> JFFS2 writes to OOB own markers, then it tries to write to the da=
ta area of such page. =20
> >>>>>
> >>>>> @Liang, I'll describe current test case in details:
> >>>>> 1) I have erased page, I can read it in=C2=A0 both raw and ecc mode=
s - no problem (it is full of 0xFF).
> >>>>> 2) I (JFFS2 for example) want to write only OOB - let it be clean m=
arkers.
> >>>>> 3) I use raw write to the needed page (please correct me if i'm wro=
ng). Four bytes
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at 0x400 and 0x810 are updated. All other =
bytes still 0xff.
> >>>>> 4) Now, when i'm trying to read this page in ECC mode, I get ECC er=
rors: IIUC this
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 happens because from controller point of v=
iew ECC codes are invalid for current
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 data (all ECCs are 0xff). Is this behaviou=
r is ok? =20
> >>>>
> >>>> Yes, it is exactly reported ECC errors. =20
> >>>
> >>> I see, so if we write OOB (e.g. using raw mode), there is no way to r=
ead this page in ECC mode later? And the =20
> >=20
> > Of course, there is no ECC parity bytes in it; or raw write the data wi=
th the ECC parity bytes per the layout (A) you describe above.
> >  =20
>=20
> But don't it looks like strange? Just writing OOB makes page unreadable? =
May be it is better to move OOB data
> out of ECC area as I suggested in v2?
>=20
> >>> only way to make it readable is to write it in ECC mode, but before t=
his write, we need to read it's
> >>> user's byte (from previous OOB write) in raw mode, put it to info buf=
 (as user's bytes) and write this page. In this
> >>> case NAND controller will generate ECC codes including user's byte an=
d page become readable in ECC mode
> >>> again. =20
> >=20
> > yes, you are right.
> >  =20
> >>> =20
> >>>> =20
> >>>>> 5) Ok, don't care on these ECC errors, let's go further.
> >>>>> 6) I'm going to write same page in ECC mode - how to do it correctl=
y? There is already
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 4 OOB bytes, considered to be covered by E=
CC (but in fact now - ECC area is FFed). =20
> >>>>
> >>>> If step 4 has excuted "program" command at the page (nand_write_oob_=
std() does), it can't be written again before erasing the page(block). so w=
e have to read the whole page in the ddr and change the content, erase bloc=
k, write it again.
> >>>>
> >>>> I don't think Jffs2 has the same steps (1-6) as you said above. are =
you sure that happes on Jffs2 or just an example? =20
> >>
> >> =20
> >>>
> >>> I just checked JFFS2 mount/umount again, here is what i see:
> >>> 0) First attempt to mount JFFS2.
> >>> 1) It writes OOB to page N (i'm using raw write). It is cleanmarker v=
alue 0x85 0x19 0x03 0x20. Mount is done.
> >>> 2) Umount JFFS2. Done.
> >>> 3) Second attempt to mount JFFS2.
> >>> 4) It reads OOB from page N (i'm using raw read). Value is 0x85 0x19 =
0x03 0x20. Done.
> >>> 5) It reads page N in ECC mode, and i get:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 jffs2: mtd->read(0x100 bytes from N) returne=
d ECC error
> >>> 6) Mount failed.
> >>>
> >>> We already had problem which looks like this on another device. Solut=
ion was to use OOB area which is
> >>> not covered by ECC for JFFS2 cleanmarkers. =20
> >=20
> > ok, so there is not ECC parity bytes and mtd->read() returns ECC error.
> > does it have to use raw write/read on step 1) and 4)?
> >  =20
>=20
> If i'm using non raw access to OOB, for example write OOB (user bytes) in=
 ECC mode, then
> steps 1) and 4) and 5) passes ok, but write to this page will be impossib=
le (for example JFFS2
> writes to such pages later) - we can't update ECC codes properly without =
erasing whole page.
> Write operation will be done without problem, but read will trigger ECC e=
rrors due to broken
> ECC codes.
>=20
> In general problem that we discuss is that in current implementation data=
 and OOB conflicts
> with each other by sharing same ECC codes, these ECC codes could be writt=
en only once (without
> erasing), while data and OOB has different callbacks to access and thus s=
upposed to work
> separately.

The fact that there might be helpers just for writing OOB areas or just
in-band areas are optimizations. NAND pages are meant to be written a
single time, no matter what portion you write. In some cases, it is
possible to perform subpage writes if the chip supports it. Pages may
be split into several areas which cover a partial in-band area *and* a
partial OOB area. If you write into the in-band *or* out-of-band areas
of a given subpage, you *cannot* write the other part later without
erasing.

Thanks,
Miqu=C3=A8l
