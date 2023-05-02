Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592856F42CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjEBL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjEBL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:28:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073695BBD
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:28:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A031C0008;
        Tue,  2 May 2023 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683026868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5uZzLTFj4JCdpkIdpRTcXSLdigmmlJ0kUKE2R8/0Y0=;
        b=QUn/PyRfXaOFOdB4jIFGk9BmWbv6JBk7SNDTzb1WIjTDj6KPPex59UjoQvArhtTWZoftiV
        y0AOLzuljE7TG/nOJo6aW5+70z36bzIrh3DnbsxExIsL5Ob6X0dcRpi7JKzFIiWoXvQWyS
        E/VSAcxUDjLbW+hFmfhQ6esIjgwwY6BKR7m33nPgxuJ99TxoS1ME6FJY+lsv7pVVMwuJtC
        TbRbedMCT6GI0cvG/ZawyPo0Dq4wi9NPDJolhy1UT5xNIZRZCyB3LqcxFYkCgXdko+Ruo/
        55HVunOgyeqCkxst4o9KeFEnegBarXONo8JO2bK8arEGuvu9Ir4P3DIzmOcweQ==
Date:   Tue, 2 May 2023 13:27:45 +0200
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
Message-ID: <20230502132745.14349770@xps-13>
In-Reply-To: <2274b432-d1a9-b3cf-4f7b-08c4a4c580b5@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
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
        <20230502115913.78012d98@xps-13>
        <2274b432-d1a9-b3cf-4f7b-08c4a4c580b5@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Tue, 2 May 2023 13:11:38 +0300:

> On 02.05.2023 12:59, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Wed, 26 Apr 2023 17:46:19 +0300:
> >  =20
> >> On 26.04.2023 16:51, Liang Yang wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> On 2023/4/20 17:37, Arseniy Krasnov wrote:   =20
> >>>> [ EXTERNAL EMAIL ]
> >>>>
> >>>> On 19.04.2023 09:41, Arseniy Krasnov wrote:   =20
> >>>>>
> >>>>>
> >>>>> On 19.04.2023 06:05, Liang Yang wrote:   =20
> >>>>>> Hi Arseniy,
> >>>>>>
> >>>>>> On 2023/4/18 22:57, Arseniy Krasnov wrote:   =20
> >>>>>>> [ EXTERNAL EMAIL ]
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 18.04.2023 16:25, Miquel Raynal wrote:   =20
> >>>>>>>> Hi Arseniy,
> >>>>>>>>   =20
> >>>>>>>>>>> Hello again @Liang @Miquel!
> >>>>>>>>>>>
> >>>>>>>>>>> One more question about OOB access, as I can see current driv=
er uses the following
> >>>>>>>>>>> callbacks:
> >>>>>>>>>>>
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand->ecc.write_oob_raw =3D na=
nd_write_oob_std;
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand->ecc.write_oob =3D nand_w=
rite_oob_std;
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Function 'nand_write_oob_std()' writes data to the end of the=
 page. But as I
> >>>>>>>>>>> can see by dumping 'data_buf' during read, physical layout of=
 each page is the
> >>>>>>>>>>> following (1KB ECC):
> >>>>>>>>>>>
> >>>>>>>>>>> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB=
 of data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>>> 0x400: [ 2B user data] [ 14B ECC code]
> >>>>>>>>>>> 0x410: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 KB=
 of data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]=C2=A0=C2=A0=C2=A0 (A)
> >>>>>>>>>>> 0x810: [ 2B user data] [ 14B ECC code]
> >>>>>>>>>>> 0x820: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32B unused=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> So, after 'nand_write_oob_std()' (let data be sequence from [=
0x0 ... 0x3f]),
> >>>>>>>>>>> page will look like this:
> >>>>>>>>>>>
> >>>>>>>>>>> 0x000: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>>> 0x400: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ........=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>>> 0x7f0: [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0xFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ]
> >>>>>>>>>>> 0x800: [ 00 .......................=C2=A0 ]
> >>>>>>>>>>> 0x830: [ ........................ 3f ]
> >>>>>>>>>>>
> >>>>>>>>>>> Here we have two problems:
> >>>>>>>>>>> 1) Attempt to display raw data by 'nanddump' utility produces=
 a little bit
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invalid output, as driver reli=
es on layout (A) from above. E.g. OOB data
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is at 0x400 and 0x810. Here is=
 an example (attempt to write 0x11 0x22 0x33 0x44):
> >>>>>>>>>>>
> >>>>>>>>>>> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
=C2=A0 |."..............|
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff=
 ff ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: 33 44 ff ff ff ff ff ff ff=
 ff ff ff ff ff ff ff=C2=A0 |3D..............|
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff=
 ff ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff ff ff ff ff ff=
 ff ff ff ff ff ff ff=C2=A0 |................|
> >>>>>>>>>>>   =20
> >>>>>>>>>> Hi Arseniy,
> >>>>>>>>>>
> >>>>>>>>>> I realized the write_oob_raw() and write_oob() are wrong in me=
son_nand.c. I suggest both of them should be reworked and follow the format=
 of meson nand controller. i.e. firstly format the data in Layout (A) and t=
hen write. reading is firstly reading the data of layout (A) and then compo=
st the layout (B).   =20
> >>>>>>>>>
> >>>>>>>>> IIUC after such writing only OOB (e.g. user bytes) according la=
yout (A), hw will also write ECC codes, so
> >>>>>>>>> it will be impossible to write data to this page later, because=
 we cannot update ECC codes properly for the newly
> >>>>>>>>> written data (we can't update bits from 0 to 1).
> >>>>>>>>>   =20
> >>>>>>>>>>
> >>>>>>>>>>   =20
> >>>>>>>>>>>
> >>>>>>>>>>> 2) Attempt to read data in ECC mode will fail, because IIUC p=
age is in dirty
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state (I mean was written at l=
east once) and NAND controller tries to use
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ECC codes at 0x400 and 0x810, =
which are obviously broken in this case. Thus   =20
> >>>>>>>>>>
> >>>>>>>>>> As i said above, write_oob_raw() and write_oob() should be rew=
orked.
> >>>>>>>>>> i don't know what do you mean page was written at least once. =
anyway the page should be written once, even just write_oob_raw().   =20
> >>>>>>>>>
> >>>>>>>>> Sorry, You mean that after OOB write, we cannot write to the da=
ta area (e.g. 0x0 .. 0x810) until page will be erased? For example
> >>>>>>>>> JFFS2 writes to OOB own markers, then it tries to write to the =
data area of such page.   =20
> >>>>>>>
> >>>>>>> @Liang, I'll describe current test case in details:
> >>>>>>> 1) I have erased page, I can read it in=C2=A0 both raw and ecc mo=
des - no problem (it is full of 0xFF).
> >>>>>>> 2) I (JFFS2 for example) want to write only OOB - let it be clean=
 markers.
> >>>>>>> 3) I use raw write to the needed page (please correct me if i'm w=
rong). Four bytes
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at 0x400 and 0x810 are updated. All othe=
r bytes still 0xff.
> >>>>>>> 4) Now, when i'm trying to read this page in ECC mode, I get ECC =
errors: IIUC this
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 happens because from controller point of=
 view ECC codes are invalid for current
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 data (all ECCs are 0xff). Is this behavi=
our is ok?   =20
> >>>>>>
> >>>>>> Yes, it is exactly reported ECC errors.   =20
> >>>>>
> >>>>> I see, so if we write OOB (e.g. using raw mode), there is no way to=
 read this page in ECC mode later? And the   =20
> >>>
> >>> Of course, there is no ECC parity bytes in it; or raw write the data =
with the ECC parity bytes per the layout (A) you describe above.
> >>>    =20
> >>
> >> But don't it looks like strange? Just writing OOB makes page unreadabl=
e? May be it is better to move OOB data
> >> out of ECC area as I suggested in v2?
> >> =20
> >>>>> only way to make it readable is to write it in ECC mode, but before=
 this write, we need to read it's
> >>>>> user's byte (from previous OOB write) in raw mode, put it to info b=
uf (as user's bytes) and write this page. In this
> >>>>> case NAND controller will generate ECC codes including user's byte =
and page become readable in ECC mode
> >>>>> again.   =20
> >>>
> >>> yes, you are right.
> >>>    =20
> >>>>>   =20
> >>>>>>   =20
> >>>>>>> 5) Ok, don't care on these ECC errors, let's go further.
> >>>>>>> 6) I'm going to write same page in ECC mode - how to do it correc=
tly? There is already
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 4 OOB bytes, considered to be covered by=
 ECC (but in fact now - ECC area is FFed).   =20
> >>>>>>
> >>>>>> If step 4 has excuted "program" command at the page (nand_write_oo=
b_std() does), it can't be written again before erasing the page(block). so=
 we have to read the whole page in the ddr and change the content, erase bl=
ock, write it again.
> >>>>>>
> >>>>>> I don't think Jffs2 has the same steps (1-6) as you said above. ar=
e you sure that happes on Jffs2 or just an example?   =20
> >>>>
> >>>>   =20
> >>>>>
> >>>>> I just checked JFFS2 mount/umount again, here is what i see:
> >>>>> 0) First attempt to mount JFFS2.
> >>>>> 1) It writes OOB to page N (i'm using raw write). It is cleanmarker=
 value 0x85 0x19 0x03 0x20. Mount is done.
> >>>>> 2) Umount JFFS2. Done.
> >>>>> 3) Second attempt to mount JFFS2.
> >>>>> 4) It reads OOB from page N (i'm using raw read). Value is 0x85 0x1=
9 0x03 0x20. Done.
> >>>>> 5) It reads page N in ECC mode, and i get:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0 jffs2: mtd->read(0x100 bytes from N) retur=
ned ECC error
> >>>>> 6) Mount failed.
> >>>>>
> >>>>> We already had problem which looks like this on another device. Sol=
ution was to use OOB area which is
> >>>>> not covered by ECC for JFFS2 cleanmarkers.   =20
> >>>
> >>> ok, so there is not ECC parity bytes and mtd->read() returns ECC erro=
r.
> >>> does it have to use raw write/read on step 1) and 4)?
> >>>    =20
> >>
> >> If i'm using non raw access to OOB, for example write OOB (user bytes)=
 in ECC mode, then
> >> steps 1) and 4) and 5) passes ok, but write to this page will be impos=
sible (for example JFFS2
> >> writes to such pages later) - we can't update ECC codes properly witho=
ut erasing whole page.
> >> Write operation will be done without problem, but read will trigger EC=
C errors due to broken
> >> ECC codes.
> >>
> >> In general problem that we discuss is that in current implementation d=
ata and OOB conflicts
> >> with each other by sharing same ECC codes, these ECC codes could be wr=
itten only once (without
> >> erasing), while data and OOB has different callbacks to access and thu=
s supposed to work
> >> separately. =20
> >=20
> > The fact that there might be helpers just for writing OOB areas or just
> > in-band areas are optimizations. NAND pages are meant to be written a
> > single time, no matter what portion you write. In some cases, it is
> > possible to perform subpage writes if the chip supports it. Pages may
> > be split into several areas which cover a partial in-band area *and* a
> > partial OOB area. If you write into the in-band *or* out-of-band areas
> > of a given subpage, you *cannot* write the other part later without =20
>=20
> Thanks for details! So in case of JFFS2 it looks like strange, that it tr=
ies
> to write page after writing clean markers to it before? In the old vendor=
's
> driver OOB write callback is suppressed by return 0 always and JFFS2 works
> correctly.

Can you point the code you're mentioning? (both what JFFS2 which looks
strange to you and the old vendor hack)


Thanks,
Miqu=C3=A8l
