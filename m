Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD168AACE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjBDPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:02:25 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D9B2068E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:02:21 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230204150216epoutp04806054867365dcbb883b650a06f991c5~ApzvUMz9N2925229252epoutp04m
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:02:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230204150216epoutp04806054867365dcbb883b650a06f991c5~ApzvUMz9N2925229252epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675522936;
        bh=dLeEnsaLmr9vbQifWMXUlD+kzP3ViUsCatFqeEYa+g0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=XsGaAU6gtVQVOtLFVUoKP7SeRjEA1WUmcYYewQQKAFmLGWF7H9ufs+o7xvMODmRqJ
         GIrtgtPTkYo+UqZnKU3PHCncPAKjyTwEvNsKGZIeiNaREK/YrP2FsDTZxH6uGLCrWC
         7iHsSvbbJoxQEsoLnQFW1t9p8NNU0kFJt6jgAbJQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230204150216epcas1p3df5c0f85466eef266f8551f590654a09~Apzu1bIfQ0469104691epcas1p3S;
        Sat,  4 Feb 2023 15:02:16 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4P8G2v6Pylz4x9Pw; Sat,  4 Feb
        2023 15:02:15 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-e5-63de7377467f
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.33.54823.7737ED36; Sun,  5 Feb 2023 00:02:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     John Stultz <jstultz@google.com>
CC:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa@epcms1p8>
Date:   Sun, 05 Feb 2023 00:02:15 +0900
X-CMS-MailID: 20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvm558b1kg+5+fYs569ewWSx8eJfZ
        YvUmX4vuzTMZLXrfv2Ky+HNiI5vF5V1z2CzurfnPavH62zJmi1N3P7NbvFv/hc2B2+Pwm/fM
        Hnu/LWDx2DnrLrvHgk2lHptWdbJ5bPo0id3jzrU9bB4nZvxm8ejbsorR4/MmuQCuqGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGWtbtzAW
        HEqoOH9oKmMD45nYLkZODgkBE4m1C3azdzFycQgJ7GCUuHahmbGLkYODV0BQ4u8OYZAaYQF3
        iW1f3zCD2EICShJnf1xhh4jrSjR1r2YBsdkEtCXeL5jECmKLCKhIPJz7kw1kJrPASWaJKy9e
        MEMs45WY0f6UBcKWlti+fCsjiM0pECjR13kSKi4qcXP1W3YY+/2x+YwQtohE672zUHMEJR78
        3M0IM+fP8edsEHa5xI45+6HsConf/cug5uhLXOmfyQRi8wr4Sjyec4UF5EcWAVWJvx+1IEpc
        JF48XAFWwgz0y7KFr5lBSpgFNCXW79KHKFGU2Pl7LiNECZ/Eu689rDBf7Zj3hAnCVpNoefYV
        Ki4j8fffMyjbQ6J5TRMLJAg3sEo8+q84gVFhFiKgZyFZPAth8QJG5lWMYqkFxbnpqcWGBabw
        uE3Oz93ECE67WpY7GKe//aB3iJGJg/EQowQHs5II7/LTd5KFeFMSK6tSi/Lji0pzUosPMZoC
        fTyRWUo0OR+Y+PNK4g1NLA1MzIxMLIwtjc2UxHnFbU8mCwmkJ5akZqemFqQWwfQxcXBKNTAl
        SjS5JKuatDtlL2rh9S/+8sB7xZvo8ja2fZqHf4RN4WB9/jk6cCefmMPjtS1niiVDnjHIrlbV
        Xn4loky6uunc8m3fYzLtDi7euf77nU9XpT490+TcPmeHR87X9OeZIqeuskaGtyzrSknm52XX
        i26tOHG4qmJWrsgUydC33uEFs9h3btQNYEx1MvbWmVFikXR3al3bAf5p8wL/fryg7LfuQZRy
        Y/uGztQ5r9JdTq9qlZcVnqTVU7/N8kjO2s66xHOS5uw8cid+da659+PSh8W3XltZLzufvcDk
        yMc30Rd+Xgjb2OfAK/SF7+nCvX/WbVx9XfD/oaLyTscfuz3cFsmqyV18xCkTZGOSu+b47hgl
        luKMREMt5qLiRAAZ6dS9RAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com>
        <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
        <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
        <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
        <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> --------- Original Message ---------
>=20
> Sender : John Stultz <jstultz=40google.com>
>=20
> Date : 2023-01-26 14:04 (GMT+9)
>=20
> Title : Re: (2) =5BPATCH=5D dma-buf: system_heap: avoid reclaim for order=
 4
>=20
> =20
>=20
> On Wed, Jan 25, 2023 at 8:42 PM =EA=B9=80=EC=9E=AC=EC=9B=90=20<jaewon31.k=
im=40samsung.com>=20wrote:=0D=0A>=20=0D=0A>=20>=20>=20On=20Wed,=20Jan=2025,=
=202023=20at=202:20=20AM=20Jaewon=20Kim=20<jaewon31.kim=40samsung.com>=20wr=
ote:=0D=0A>=20=0D=0A>=20>=20>=20>=20>=20>=20On=20Tue,=20Jan=2017,=202023=20=
at=2010:54=20PM=20John=20Stultz=20<jstultz=40google.com>=20wrote:=0D=0A>=20=
=0D=0A>=20>=20>=20But=20because=20your=20change=20is=20different=20from=20w=
hat=20the=20old=20ion=20code=20did,=20I=0D=0A>=20=0D=0A>=20>=20>=20want=20t=
o=20be=20a=20little=20cautious.=20So=20it=20would=20be=20nice=20to=20see=20=
some=0D=0A>=20=0D=0A>=20>=20>=20evaluation=20of=20not=20just=20the=20benefi=
ts=20the=20patch=20provides=20you=20but=20also=20of=0D=0A>=20=0D=0A>=20>=20=
>=20what=20negative=20impact=20it=20might=20have.=20=20And=20so=20far=20you=
=20haven't=20provided=0D=0A>=20=0D=0A>=20>=20>=20any=20details=20there.=0D=
=0A>=20=0D=0A>=20>=20>=0D=0A>=20=0D=0A>=20>=20>=20A=20quick=20example=20mig=
ht=20be=20for=20the=20use=20case=20where=20mid-order=20allocations=0D=0A>=
=20=0D=0A>=20>=20>=20are=20causing=20you=20trouble,=20you=20could=20see=20h=
ow=20the=20performance=20changes=20if=0D=0A>=20=0D=0A>=20>=20>=20you=20forc=
e=20all=20mid-order=20allocations=20to=20be=20single=20page=20allocations=
=20(so=0D=0A>=20=0D=0A>=20>=20>=20orders=5B=5D=20=3D=20=7B8,=200,=200=7D;)=
=20and=20compare=20it=20with=20the=20current=20code=20when=0D=0A>=20=0D=0A>=
=20>=20>=20there's=20no=20memory=20pressure=20(right=20after=20reboot=20whe=
n=20pages=20haven't=20been=0D=0A>=20=0D=0A>=20>=20>=20fragmented)=20so=20th=
e=20mid-order=20allocations=20will=20succeed.=20=20That=20will=20let=0D=0A>=
=20=0D=0A>=20>=20>=20us=20know=20the=20potential=20downside=20if=20we=20hav=
e=20brief=20/=20transient=20pressure=0D=0A>=20=0D=0A>=20>=20>=20at=20alloca=
tion=20time=20that=20forces=20small=20pages.=0D=0A>=20=0D=0A>=20>=20>=0D=0A=
>=20=0D=0A>=20>=20>=20Does=20that=20make=20sense?=0D=0A>=20=0D=0A>=20>=0D=
=0A>=20=0D=0A>=20>=20Let=20me=20try=20this.=20It=20make=20take=20some=20day=
s.=20But=20I=20guess=20it=20depends=20on=20memory=0D=0A>=20=0D=0A>=20>=20st=
atus=20as=20you=20said.=20If=20there=20were=20quite=20many=20order=204=20pa=
ges,=20then=208=204=200=0D=0A>=20=0D=0A>=20>=20should=20be=20faster=20than=
=208=200=200.=0D=0A>=20=0D=0A>=20>=0D=0A>=20=0D=0A>=20>=20I=20don't=20know=
=20this=20is=20a=20right=20approach.=20In=20my=20opinion,=20except=20the=20=
specific=0D=0A>=20=0D=0A>=20>=20cases=20like=20right=20after=20reboot,=20th=
ere=20are=20not=20many=20order=204=20pages.=20And=0D=0A>=20=0D=0A>=20>=20in=
=20determinisitic=20allocation=20time=20perspective,=20I=20think=20avoiding=
=20too=20long=0D=0A>=20=0D=0A>=20>=20allocations=20is=20more=20important=20=
than=20making=20faster=20with=20already=20existing=0D=0A>=20=0D=0A>=20>=20f=
ree=20order=204=20pages.=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20I=20suspect=
=20you=20are=20right,=20and=20do=20think=20your=20change=20will=20be=20help=
ful.=0D=0A>=20=0D=0A>=20But=20I=20just=20want=20to=20make=20sure=20we're=20=
doing=20some=20due=20diligence,=20instead=0D=0A>=20=0D=0A>=20of=20going=20o=
n=20just=20gut=20instinct.=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20Thanks=20=
so=20much=20for=20helping=20with=20this=21=0D=0A>=20=0D=0A>=20-john=0D=0A>=
=20=0D=0A>=20=0D=0A=0D=0AHello=20John=20Stultz,=20sorry=20for=20late=20repl=
y.=0D=0AI=20had=20to=20manage=20other=20urgent=20things=20and=20this=20test=
=20also=20took=20some=20time=20to=20finish.=0D=0AAny=20I=20hope=20you=20to=
=20be=20happy=20with=20following=20my=20test=20results.=0D=0A=0D=0A=0D=0A1.=
=20system=20heap=20modification=0D=0A=0D=0ATo=20avoid=20effect=20of=20alloc=
ation=20from=20the=20pool,=20all=20the=20freed=20dma=0D=0Abuffer=20were=20p=
assed=20to=20buddy=20without=20keeping=20them=20in=20the=20pool.=0D=0ASome=
=20trace_printk=20and=20order=20counting=20logic=20were=20added.=0D=0A=0D=
=0A2.=20the=20test=20tool=0D=0A=0D=0ATo=20test=20the=20dma-buf=20system=20h=
eap=20allocation=20speed,=20I=20prepared=0D=0Aa=20userspace=20test=20progra=
m=20which=20requests=20a=20specified=20size=20to=20a=20heap.=0D=0AWith=20th=
e=20program,=20I=20tried=20to=20request=2016=20times=20of=2010=20MB=20size=
=20and=0D=0Aadded=201=20sleep=20between=20each=20request.=20Each=20memory=
=20was=20not=20freed=0D=0Auntil=20the=20total=2016=20times=20total=20memory=
=20was=20allocated.=0D=0A=0D=0A3.=20the=20test=20device=0D=0A=0D=0AThe=20te=
st=20device=20has=20arm64=20CPU=20cores=20and=20v5.15=20based=20kernel.=0D=
=0ATo=20get=20stable=20results,=20the=20CPU=20clock=20was=20fixed=20not=20t=
o=20be=20changed=0D=0Ain=20run=20time,=20and=20the=20test=20tool=20was=20se=
t=20to=20some=20specific=20CPU=20cores=0D=0Arunning=20in=20the=20same=20CPU=
=20clock.=0D=0A=0D=0A4.=20test=20results=0D=0A=0D=0AAs=20we=20expected=20if=
=20order=204=20exist=20in=20the=20buddy,=20the=20order=208,=204,=200=0D=0Aa=
llocation=20was=201=20to=204=20times=20faster=20than=20the=20order=208,=200=
,=200.=20But=0D=0Athe=20order=208,=200,=200=20also=20looks=20fast=20enough.=
=0D=0A=0D=0AHere's=20time=20diff,=20and=20number=20of=20each=20order.=0D=0A=
=0D=0Aorder=208,=204,=200=20in=20the=20enough=20order=204=20case=0D=0A=0D=
=0A=20=20=20=20=20=20=20=20=20diff=098=094=090=0D=0A=20=20=20=20=20665=20us=
ec=090=09160=090=0D=0A=20=20=201,148=20usec=090=09160=090=0D=0A=20=20=201,0=
89=20usec=090=09160=090=0D=0A=20=20=201,154=20usec=090=09160=090=0D=0A=20=
=20=201,264=20usec=090=09160=090=0D=0A=20=20=201,414=20usec=090=09160=090=
=0D=0A=20=20=20=20=20873=20usec=090=09160=090=0D=0A=20=20=201,148=20usec=09=
0=09160=090=0D=0A=20=20=201,158=20usec=090=09160=090=0D=0A=20=20=201,139=20=
usec=090=09160=090=0D=0A=20=20=201,169=20usec=090=09160=090=0D=0A=20=20=201=
,174=20usec=090=09160=090=0D=0A=20=20=201,210=20usec=090=09160=090=0D=0A=20=
=20=20=20=20995=20usec=090=09160=090=0D=0A=20=20=201,151=20usec=090=09160=
=090=0D=0A=20=20=20=20=20977=20usec=090=09160=090=0D=0A=0D=0Aorder=208,=200=
,=200=20in=20the=20enough=20order=204=20case=0D=0A=0D=0A=20=20=20=20=20=20=
=20=20=20diff=098=094=090=0D=0A=20=20=20=20=20441=20usec=0910=090=090=0D=0A=
=20=20=20=20=20747=20usec=0910=090=090=0D=0A=20=20=202,330=20usec=092=090=
=092048=0D=0A=20=20=202,469=20usec=090=090=092560=0D=0A=20=20=202,518=20use=
c=090=090=092560=0D=0A=20=20=201,176=20usec=090=090=092560=0D=0A=20=20=201,=
487=20usec=090=090=092560=0D=0A=20=20=201,402=20usec=090=090=092560=0D=0A=
=20=20=201,449=20usec=090=090=092560=0D=0A=20=20=201,330=20usec=090=090=092=
560=0D=0A=20=20=201,089=20usec=090=090=092560=0D=0A=20=20=201,481=20usec=09=
0=090=092560=0D=0A=20=20=201,326=20usec=090=090=092560=0D=0A=20=20=203,057=
=20usec=090=090=092560=0D=0A=20=20=202,758=20usec=090=090=092560=0D=0A=20=
=20=203,271=20usec=090=090=092560=0D=0A=0D=0AFrom=20the=20perspective=20of=
=20responsiveness,=20the=20deterministic=0D=0Amemory=20allocation=20speed,=
=20I=20think,=20is=20quite=20important.=20So=20I=0D=0Atested=20other=20case=
=20where=20the=20free=20memory=20are=20not=20enough.=0D=0A=0D=0AOn=20this=
=20test,=20I=20ran=20the=2016=20times=20allocation=20sets=20twice=0D=0Acons=
ecutively.=20Then=20it=20showed=20the=20first=20set=20order=208,=204,=200=
=0D=0Abecame=20very=20slow=20and=20varied,=20but=20the=20second=20set=20bec=
ame=0D=0Afaster=20because=20of=20the=20already=20created=20the=20high=20ord=
er.=0D=0A=0D=0Aorder=208,=204,=200=20in=20low=20memory=0D=0A=0D=0A=20=20=20=
=20=20=20=20=20=20diff=098=094=090=0D=0A=20=20=20=20=20584=20usec=090=09160=
=090=0D=0A=20=2028,428=20usec=090=09160=090=0D=0A=20100,701=20usec=090=0916=
0=090=0D=0A=20=2076,645=20usec=090=09160=090=0D=0A=20=2025,522=20usec=090=
=09160=090=0D=0A=20=2038,798=20usec=090=09160=090=0D=0A=20=2089,012=20usec=
=090=09160=090=0D=0A=20=2023,015=20usec=090=09160=090=0D=0A=20=2073,360=20u=
sec=090=09160=090=0D=0A=20=2076,953=20usec=090=09160=090=0D=0A=20=2031,492=
=20usec=090=09160=090=0D=0A=20=2075,889=20usec=090=09160=090=0D=0A=20=2084,=
551=20usec=090=09160=090=0D=0A=20=2084,352=20usec=090=09160=090=0D=0A=20=20=
57,103=20usec=090=09160=090=0D=0A=20=2093,452=20usec=090=09160=090=0D=0A=09=
=09=09=0D=0A=20=20=20=20=20=20=20=20=20diff=098=094=090=0D=0A=20=20=20=20=
=20808=20usec=0910=090=090=0D=0A=20=20=20=20=20778=20usec=094=0996=090=0D=
=0A=20=20=20=20=20829=20usec=090=09160=090=0D=0A=20=20=20=20=20700=20usec=
=090=09160=090=0D=0A=20=20=20=20=20937=20usec=090=09160=090=0D=0A=20=20=20=
=20=20651=20usec=090=09160=090=0D=0A=20=20=20=20=20636=20usec=090=09160=090=
=0D=0A=20=20=20=20=20811=20usec=090=09160=090=0D=0A=20=20=20=20=20622=20use=
c=090=09160=090=0D=0A=20=20=20=20=20674=20usec=090=09160=090=0D=0A=20=20=20=
=20=20677=20usec=090=09160=090=0D=0A=20=20=20=20=20738=20usec=090=09160=090=
=0D=0A=20=20=201,130=20usec=090=09160=090=0D=0A=20=20=20=20=20677=20usec=09=
0=09160=090=0D=0A=20=20=20=20=20553=20usec=090=09160=090=0D=0A=20=20=201,04=
8=20usec=090=09160=090=0D=0A=0D=0A=0D=0Aorder=208,=200,=200=20in=20low=20me=
mory=0D=0A=0D=0A=20=20=20=20=20=20=20=20diff=098=094=090=0D=0A=20=201,699=
=20usec=092=090=092048=0D=0A=20=202,082=20usec=090=090=092560=0D=0A=20=20=
=20=20840=20usec=090=090=092560=0D=0A=20=20=20=20875=20usec=090=090=092560=
=0D=0A=20=20=20=20845=20usec=090=090=092560=0D=0A=20=201,706=20usec=090=090=
=092560=0D=0A=20=20=20=20967=20usec=090=090=092560=0D=0A=20=201,000=20usec=
=090=090=092560=0D=0A=20=201,905=20usec=090=090=092560=0D=0A=20=202,451=20u=
sec=090=090=092560=0D=0A=20=203,384=20usec=090=090=092560=0D=0A=20=202,397=
=20usec=090=090=092560=0D=0A=20=203,171=20usec=090=090=092560=0D=0A=20=202,=
376=20usec=090=090=092560=0D=0A=20=203,347=20usec=090=090=092560=0D=0A=20=
=202,554=20usec=090=090=092560=0D=0A=09=09=09=0D=0A=20=20=20=20=20=20=20dif=
f=098=094=090=0D=0A=201,409=20usec=092=090=092048=0D=0A=201,438=20usec=090=
=090=092560=0D=0A=201,035=20usec=090=090=092560=0D=0A=201,108=20usec=090=09=
0=092560=0D=0A=20=20=20825=20usec=090=090=092560=0D=0A=20=20=20927=20usec=
=090=090=092560=0D=0A=201,931=20usec=090=090=092560=0D=0A=202,024=20usec=09=
0=090=092560=0D=0A=201,884=20usec=090=090=092560=0D=0A=201,769=20usec=090=
=090=092560=0D=0A=202,136=20usec=090=090=092560=0D=0A=201,738=20usec=090=09=
0=092560=0D=0A=201,328=20usec=090=090=092560=0D=0A=201,438=20usec=090=090=
=092560=0D=0A=201,972=20usec=090=090=092560=0D=0A=202,963=20usec=090=090=09=
2560=0D=0A=0D=0AFinally=20if=20we=20change=20order=204=20to=20use=20HIGH_OR=
DER_GFP,=0D=0AI=20expect=20that=20we=20could=20avoid=20the=20very=20slow=20=
cases.=0D=0A=0D=0Aorder=208,=204,=200=20in=20low=20memory=20with=20HIGH_ORD=
ER_GFP=0D=0A=0D=0A=20=20=20=20=20=20=20=20=20=20diff=098=094=090=0D=0A=201,=
356=20usec=090=09155=0980=0D=0A=201,901=20usec=090=0911=092384=0D=0A=201,91=
2=20usec=090=090=092560=0D=0A=201,911=20usec=090=090=092560=0D=0A=201,884=
=20usec=090=090=092560=0D=0A=201,577=20usec=090=090=092560=0D=0A=201,366=20=
usec=090=090=092560=0D=0A=201,711=20usec=090=090=092560=0D=0A=201,635=20use=
c=090=0928=092112=0D=0A=20=20=20544=20usec=0910=090=090=0D=0A=20=20=20633=
=20usec=092=09128=090=0D=0A=20=20=20848=20usec=090=09160=090=0D=0A=20=20=20=
729=20usec=090=09160=090=0D=0A=201,000=20usec=090=09160=090=0D=0A=201,358=
=20usec=090=09160=090=0D=0A=202,638=20usec=090=0931=092064=0D=0A=09=09=09=
=0D=0A=20=20=20=20=20=20=20=20=20=20diff=098=094=090=0D=0A=20=20=20669=20us=
ec=0910=090=090=0D=0A=20=20=20789=20usec=098=0932=090=0D=0A=20=20=20603=20u=
sec=093=09112=090=0D=0A=20=20=20578=20usec=090=09160=090=0D=0A=20=20=20562=
=20usec=090=09160=090=0D=0A=20=20=20564=20usec=090=09160=090=0D=0A=20=20=20=
686=20usec=090=09160=090=0D=0A=201,621=20usec=090=09160=090=0D=0A=202,080=
=20usec=090=0940=091920=0D=0A=201,749=20usec=090=090=092560=0D=0A=202,244=
=20usec=090=090=092560=0D=0A=202,333=20usec=090=090=092560=0D=0A=201,257=20=
usec=090=090=092560=0D=0A=201,703=20usec=090=090=092560=0D=0A=201,782=20use=
c=090=091=092544=0D=0A=202,225=20usec=090=090=092560=0D=0A=0D=0AThank=20you=
=0D=0AJaewon=20Kim
