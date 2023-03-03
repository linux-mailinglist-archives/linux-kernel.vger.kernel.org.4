Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048AC6A9D5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCCRVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjCCRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:21:30 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410054C6EA;
        Fri,  3 Mar 2023 09:21:18 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230303172115usoutp022f753e9274b73baaaef86a7dd2f8eaa1~I_HyWSFMn1288012880usoutp024;
        Fri,  3 Mar 2023 17:21:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230303172115usoutp022f753e9274b73baaaef86a7dd2f8eaa1~I_HyWSFMn1288012880usoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677864075;
        bh=93rX8NnIr3BDpeiQw3kiHM30rlc8YYLmBMxPR1NBgNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UJvS5ss4MprStqlWFv5FG70FB3MnhWLCYvrQdHINeSA4Etyf5FphMBmOe4SUc61UM
         s8/mh2AiiDcf2eto+ZlmXTOM/oqbeJ8xBj+n5OYVYuJXCWRa1KR3O/Xsoh7IvtAbny
         /jN0TDZdFhxHGUGVudu3pyDIGD60i1xHqHzi42kQ=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230303172114uscas1p2c0dd92fdd1da46e32f7023aefa6e054a~I_HyKgEi81348013480uscas1p2X;
        Fri,  3 Mar 2023 17:21:14 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id B0.09.49129.A8C22046; Fri, 
        3 Mar 2023 12:21:14 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230303172114uscas1p24a96af84b17ca41ca7bc642eb9b60b6a~I_HxzzCil0702207022uscas1p26;
        Fri,  3 Mar 2023 17:21:14 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-e7-64022c8a4d31
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 9A.88.11378.A8C22046; Fri, 
        3 Mar 2023 12:21:14 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 3 Mar 2023 09:21:13 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        3 Mar 2023 09:21:13 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Thread-Topic: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
        check
Thread-Index: AQHZS8WnqoF9q+YY/UCqLavADTGrLa7mzPgAgADAioCAAJq2gIABgVGAgAAuHoA=
Date:   Fri, 3 Mar 2023 17:21:13 +0000
Message-ID: <20230303172054.GA1478149@bgt-140510-bm03>
In-Reply-To: <20230303143605.0000159a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C3593FCF5553B4D9EFCB298278AF9B3@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djXc7pdOkwpBqsfmFrcfXyBzaJ58mJG
        i+lTLzBanLjZyGax+uYaRov9T5+zWKxaeI3N4vysUywWl3fNYbO4NeEYkwOXR8uRt6wei/e8
        ZPLYtKqTzWPq7HqPz5vkAlijuGxSUnMyy1KL9O0SuDKuXTzJVPDCtaJn8mqWBsZ7Zl2MnBwS
        AiYSs+82sXcxcnEICaxklLg3bwkzSEJIoJVJYv68Ipii1qvz2CDiaxklHr+IhWj4yChxbdIn
        ZghnKaPEozltYN1sAooS+7q2g3WICBhJXFl2EGwFs0Azi8S7+2+Zuhg5OIQFAiVenq6BqAmS
        2HXqLguE7SexcepZdpASFgEViW87VEDCvAJmEmeO7wEr4RQwlHh1vBVsFaOAmMT3U2uYQGxm
        AXGJW0/mM0EcLSixaPYeZghbTOLfrodsELaixP3vL9kh6nUkFuz+xAZh20ncXz2dEcLWlli2
        8DUzxF5BiZMzn7BA9EpKHFxxgwXkFQmBDxwSr3a+YAW5U0LARaL3lRVEjbTE1etTmSHCyRKr
        PnJBhHMk5i/ZAjXGWmLhn/VMExhVZiG5ehaSi2YhuWgWkotmIbloASPrKkbx0uLi3PTUYqO8
        1HK94sTc4tK8dL3k/NxNjMCkdfrf4fwdjNdvfdQ7xMjEwXiIUYKDWUmEt7qBIUWINyWxsiq1
        KD++qDQntfgQozQHi5I4r6HtyWQhgfTEktTs1NSC1CKYLBMHp1QDk7HPehs1Ue/rvxZq3Le4
        c+9Z0WbrFK4VetU3G7/NkHx34c9nY99iXcs5dtubE/JiDDeH56cbz7z/Mftmo0Pk7993WNYl
        3FCyMzllOoWPy8xgV/HO/xGpBo93n9j9fvkel6l2083FfBfXZJh+/+GtH7H+tb+t8MJrPZ43
        v+ZLbj/df+7ogbPMibplNc3cCywFjiduMO9Kizz/u17z3q37NZeT7qdbXv7v0ZHBXfnZpOno
        YcuFfvsPvequv/Ps1zeO++HvS5cocn/T/ZFmZf9r+fHrnYvveC/dGszlt/TbYSvRlZd/RMk8
        jv5x4YRz7SbrpW3ThHfvfjNra+bWM4l/vs7g+R70I848+l/itx0THi1SYinOSDTUYi4qTgQA
        0QM3rskDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWS2cA0SbdLhynF4PsNGYu7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaLH/6XMWi1ULr7FZnJ91isXi8q45bBa3JhxjcuDyaDnyltVj8Z6X
        TB6bVnWyeUydXe/xeZNcAGsUl01Kak5mWWqRvl0CV8a1iyeZCl64VvRMXs3SwHjPrIuRk0NC
        wESi9eo8ti5GLg4hgdWMEisv/2CEcD4ySqyeuQvKWcoo8WX+CTaQFjYBRYl9XdvBbBEBI4kr
        yw6ygxQxCzSzSLy7/5api5GDQ1ggUOLl6RqImiCJu68WQ9X7SWycepYdpIRFQEXi2w4VkDCv
        gJnEmeN7WCB2HWeSWPDqAhNIglPAUOLV8VZmEJtRQEzi+6k1YHFmAXGJW0/mM0G8ICCxZM95
        ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20ncXz2dEcLWlli28DUzxBGCEidnPmGB6JWU
        OLjiBssERolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnpFcWGeanlesWJucWleel6yfm5
        mxiBkX/63+HIHYxHb33UO8TIxMF4iFGCg1lJhLe6gSFFiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OK+Q68R4IYH0xJLU7NTUgtQimCwTB6dUA1PzvkwnuwlfTV6k8Kxx2m6TPv3X2oYaP933Atw8
        P956PuGYMfOS9uJfEj9+ffolv3LL1OmNR3hddyZMC9ObP/v2/1n7N/BvXFMrGMPmkpHq/TIk
        8NOsz23zlCSMivp+LGA91M51f2v88zkxLoweDF/K/Z8niBholm/tnf+vtVdHt/O8Yep5PoHj
        Pz7L/c8/qsh/haF4S/j+x47+tjcKD/sXlarnWq0rPtsr9tV215P6fSf5TFbapWjnvFazlFri
        uXSfdeakb8d+7Hy+/93cptcvE4N+TzbLP7ojWL1r+fHHT062nmC0zlo+y+ZLv/uhnR71zTV2
        XfOOB6w/WZbxSP2srMNtd6M/K4typ10va5ypxFKckWioxVxUnAgA0+BbtWsDAAA=
X-CMS-MailID: 20230303172114uscas1p24a96af84b17ca41ca7bc642eb9b60b6a
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
        <20230302062305.GA1444578@bgt-140510-bm03>
        <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
        <20230303143605.0000159a@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 02:36:05PM +0000, Jonathan Cameron wrote:

> On Thu, 2 Mar 2023 08:36:59 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> > On 3/1/23 11:23 PM, Fan Ni wrote:
> > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote: =20
> > >> =20
> > > Hi Dave,
> > > Thanks for looking into this. =20
> > >>
> > >> On 2/28/23 3:40 PM, Fan Ni wrote: =20
> > >>> Add COMMIT field check aside with existing COMMITTED field check du=
ring
> > >>> hdm decoder initialization to avoid a system crash during module re=
moval
> > >>> after destroying a region which leaves the COMMIT field being reset=
 while
> > >>> the COMMITTED field still being set. =20
> > >>
> > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The=
 =20
> > > I run into the issue with qemu emulation. =20
> > >> situation does not make sense to me. If we clear the COMMIT bit, the=
n the
> > >> COMMITTED bit should be cleared by the hardware shortly after right?=
 =20
> > >=20
> > >  From the spec, I cannot find any statement saying clearing the COMMI=
T bit
> > > will automatically clear the COMMITTED. If I have not missed the stat=
ement in
> > > the spec, I assume we should not make the assumption that it will be
> > > cleared automatically for real hardware. But you may be right, leavin=
g the
> > > COMMITTED bit set can potentially cause some issue? Need to check mor=
e. =20
> >=20
> > I have not been able to find direct verbiage that indicates this either=
.=20
> > However, logically it would make sense. Otherwise, the COMMITTED field=
=20
> > never clears and prevents reprogramming of the HDM decoders. The curren=
t=20
> > QEMU implementation is creating a situation where the HDM decoder is=20
> > always active after COMMIT bit is set the first time, regardless whethe=
r=20
> > COMMIT field has been cleared later on during a teardown. It does sound=
=20
> > like a bug with QEMU emulation currently.
>=20
> I agree that one sane interpretation is that unsetting commit should resu=
lt in
> the decoder being deactivated and hence the commit bit dropping.  However
> I'm not sure that's the only sane interpretation.
>=20
> There is no verbage that I'm aware of that says the committed bit being
> set means that the current register values are in use.  It simply says th=
at
> when the commit bit was set, the HDM decoder was successfully committed
> (using registers as set at that time).  There is a specific statement abo=
ut
> not changing the registers whilst checks are in progress, but those check=
s
> are only required if lock on commit is set, so it doesn't cover this case=
.
>=20
> Wonderfully there isn't actually anything says what a commit transition t=
o 0
> means.  Does that result in the decoder become uncommitted, or does that =
only
> happen when the next 0 to 1 transition happens?
>=20
> The only stuff we have is what happens when lock on commit =3D 1, which i=
sn't
> the case here.
>=20
> So is there another valid implementation? I think yes.
> In some implementations, there will be a complex state machine that is
> triggered when commit is set.  That will then write some entirely invisib=
le
> internal state for decode logic based on the contents of the registers.
> As such, once it's set committed, it typically won't look at the register=
s
> again until another commit 0->1 transition happens.  At that point the
> committed bit drops and raised again once the commit state machine finish=
es
> (given QEMU doesn't emulate that delay the upshot is if you set commit th=
en
> check committed it will be set ;)
>=20
> In that implementation the commit 1->0 transition is an irrelevance and
> it won't change the committed bit state.
>=20
> So whilst the QEMU code is doing the less obvious implementation, I think
> the spec still allows it.  I don't mind QEMU changing to the more obvious
> one though if someone wants to send a patch.
>=20
> Jonathan
>=20

In current qemu emulation, when COMMITTED bit is set when the decoder is
committed and at the same time the COMMIT field will be cleared. Does
the following fix make sense?
1. At qemu side, when the commit completes, just set the COMMITTED bit,
but leave the COMMIT bit as set, also check LOCK ON COMMIT bit,
if it is set, clear it, which will allow further reset of COMMIT bit.
2. for the kernel side, if it needs to reprogram the decoder, it needs to
check the COMMITTED bit, if it is set, then OS need to reset COMMIT bit
first, which will also clear COMMITTED bit automatically at qemu side.
3. when the OS needs to reset the decoder, it does similar thing as 2 to
reset COMMIT bit and qemu will clear COMMITTED bit.

Fan

> >
> > DJ
> >=20
> > >=20
> > > Fan
> > >  =20
> > >> Otherwise, how would one reprogram the decoder if the decoder is ind=
icating
> > >> to be active?
> > >>
> > >> DJ
> > >> =20
> > >>>
> > >>> In current kernel implementation, when destroying a region (cxl
> > >>> destroy-region),the decoders associated to the region will be reset
> > >>> as that in cxl_decoder_reset, where the COMMIT field will be reset.
> > >>> However, resetting COMMIT field will not automatically reset the
> > >>> COMMITTED field, causing a situation where COMMIT is reset (0) whil=
e
> > >>> COMMITTED is set (1) after the region is destroyed. Later, when
> > >>> init_hdm_decoder is called (during modprobe), current code only che=
ck
> > >>> the COMMITTED to decide whether the decoder is enabled or not. Sinc=
e
> > >>> the COMMITTED will be 1 and the code treats the decoder as enabled,
> > >>> which will cause unexpected behaviour.
> > >>>
> > >>> Before the fix, a system crash was observed when performing followi=
ng
> > >>> steps:
> > >>> 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > >>> 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> > >>> 3. cxl destroy-region region0 -f
> > >>> 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> > >>> 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> > >>> "no CXL window for range 0x0:0xffffffffffffffff" error message)
> > >>> 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kerne=
l
> > >>> crash at cxl_dpa_release due to dpa_res has been freed when destroy=
ing
> > >>> the region).
> > >>>
> > >>> The patch fixed the above issue, and is tested based on follow patc=
h series:
> > >>>
> > >>> [PATCH 00/18] CXL RAM and the 'Soft Reserved' =3D> 'System RAM' def=
ault
> > >>> Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia=
2-xfh.jf.intel.com
> > >>>
> > >>> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > >>> ---
> > >>>    drivers/cxl/core/hdm.c | 8 +++++---
> > >>>    1 file changed, 5 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > >>> index 80eccae6ba9e..6cf854c949f0 100644
> > >>> --- a/drivers/cxl/core/hdm.c
> > >>> +++ b/drivers/cxl/core/hdm.c
> > >>> @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *po=
rt, struct cxl_decoder *cxld,
> > >>>    	struct cxl_endpoint_decoder *cxled =3D NULL;
> > >>>    	u64 size, base, skip, dpa_size;
> > >>>    	bool committed;
> > >>> +	bool should_commit;
> > >>>    	u32 remainder;
> > >>>    	int i, rc;
> > >>>    	u32 ctrl;
> > >>> @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *=
port, struct cxl_decoder *cxld,
> > >>>    	base =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(=
which));
> > >>>    	size =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(=
which));
> > >>>    	committed =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > >>> +	should_commit =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
> > >>>    	cxld->commit =3D cxl_decoder_commit;
> > >>>    	cxld->reset =3D cxl_decoder_reset;
> > >>> -	if (!committed)
> > >>> +	if (!should_commit || !committed)
> > >>>    		size =3D 0;
> > >>>    	if (base =3D=3D U64_MAX || size =3D=3D U64_MAX) {
> > >>>    		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> > >>> @@ -727,7 +729,7 @@ static int init_hdm_decoder(struct cxl_port *po=
rt, struct cxl_decoder *cxld,
> > >>>    	};
> > >>>    	/* decoders are enabled if committed */
> > >>> -	if (committed) {
> > >>> +	if (should_commit && committed) {
> > >>>    		cxld->flags |=3D CXL_DECODER_F_ENABLE;
> > >>>    		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> > >>>    			cxld->flags |=3D CXL_DECODER_F_LOCK;
> > >>> @@ -772,7 +774,7 @@ static int init_hdm_decoder(struct cxl_port *po=
rt, struct cxl_decoder *cxld,
> > >>>    		return 0;
> > >>>    	}
> > >>> -	if (!committed)
> > >>> +	if (!should_commit || !committed)
> > >>>    		return 0;
> > >>>    	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainde=
r); =20
> =
