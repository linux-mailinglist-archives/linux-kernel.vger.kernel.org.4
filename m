Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1E6A7B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCBGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCBGYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:24:20 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8026865;
        Wed,  1 Mar 2023 22:23:42 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230302062320usoutp01be7ded3253993f6e0727a35612c39c1f~IhgE2hH0u1833418334usoutp01h;
        Thu,  2 Mar 2023 06:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230302062320usoutp01be7ded3253993f6e0727a35612c39c1f~IhgE2hH0u1833418334usoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677738201;
        bh=m0dnWZXQ+7mVEVzZEG1kSsp+sI1xgT444djgFDxtk9w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ADjLwxG4m4ZtDIT9oxZIeNvC79sOcdPN3CeWhuVL9cAUh5bOCWLOCaVFqGHL3aRTu
         Iv7yjn0gQ6IxUTUNOF/Fd8tvRMK0dN7kxCeFUjMsrNSzqD+BZoRkRV/zVNM8Mv2SPR
         PwQpoc68JGtPTpj7uNY6WZraIKNvwVdtTkSLUAFo=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302062320uscas1p1516ac300a1fe3f95721b7f6808123d07~IhgEtlWnH1656616566uscas1p1H;
        Thu,  2 Mar 2023 06:23:20 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id A7.10.06976.8D040046; Thu, 
        2 Mar 2023 01:23:20 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230302062320uscas1p161e16bdb8d07a9a7f596b7be5902bedd~IhgENsnFV1656616566uscas1p1G;
        Thu,  2 Mar 2023 06:23:20 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-7a-640040d89057
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 08.EB.11378.7D040046; Thu, 
        2 Mar 2023 01:23:20 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 1 Mar 2023 22:23:19 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        1 Mar 2023 22:23:19 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Thread-Topic: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
        check
Thread-Index: AQHZS8WnqoF9q+YY/UCqLavADTGrLa7mzPgAgADAioA=
Date:   Thu, 2 Mar 2023 06:23:19 +0000
Message-ID: <20230302062305.GA1444578@bgt-140510-bm03>
In-Reply-To: <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <289B2BF480131E4A9FC85BC21DC8C71A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djX87o3HBhSDP7uVrO4+/gCm0Xz5MWM
        FtOnXmC0OHGzkc1i9c01jBb7nz5nsVi18BqbxflZp1gsLu+aw2Zxa8IxJgcuj5Yjb1k9Fu95
        yeSxaVUnm8fU2fUenzfJBbBGcdmkpOZklqUW6dslcGXMWfSDveCtakXr3N+sDYzz5boYOTkk
        BEwkrh1pYOli5OIQEljJKNE8fSkjhNPKJHGutYUZpmrelJvMEIm1jBKNS+YwQTgfGSV+7j4M
        5SxllJj64iwLSAubgKLEvq7tbCC2iICqxP31j9lAipgF5rJI3Pw3m72LkYNDWCBQ4uXpGoia
        IIldp+6yQNhWEvuav7CBlLAIqEhMnJQEEuYVMJPovrmZFcTmFLCVePD7NTuIzSggJvH91Bom
        EJtZQFzi1pP5TBBXC0osmr0H6gMxiX+7HrJB2IoS97+/ZIeo15FYsPsTG4RtJ3HjVTtUXFti
        2cLXzBB7BSVOznzCAtErKXFwxQ1weEkIfOCQeHJ4AitEwkXi5qW/7BC2tMTV61OZQe6XEEiW
        WPWRCyKcIzF/yRaoOdYSC/+sZ5rAqDILydmzkJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb
        5qWW6xUn5haX5qXrJefnbmIEpq7T/w7n7mDcceuj3iFGJg7GQ4wSHMxKIrwLb/9JFuJNSays
        Si3Kjy8qzUktPsQozcGiJM5raHsyWUggPbEkNTs1tSC1CCbLxMEp1cC09m/FqoVBmhLyB5O2
        /Jb6apV//o2kj7Jn1b2/CQ49L+UdHpcpPSk87JR/ee93h/9fjk3Y+j3OcOJt57d8aY8rTJZs
        uhi0rVi+/uNNhTrVVZtONM2Zd91qz7Pr9mv/HfDf7Dkxcm+W+OUvrHM/2HOXx6kctQzMfRr8
        3pk354XUnheuYUalcRU9h3i0Vxb+nHFuU4z4yg0/+F9mBqcZ+FpUKnNWL/SMWaXnumTG0bCt
        n/tutSkGCNVqR904+nnS340aZSK+/XkXjYIdYyeKaz7vrVp1xcJ74e1dVx9+XKI41zpiNe/D
        VH+btOe623O/zf4fOP2DRmf59G2i7DV6az6eZBPYmT5VZdfGRz8mPZnGqMRSnJFoqMVcVJwI
        AHhvQHnMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWS2cA0SfeGA0OKQcNZTou7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaLH/6XMWi1ULr7FZnJ91isXi8q45bBa3JhxjcuDyaDnyltVj8Z6X
        TB6bVnWyeUydXe/xeZNcAGsUl01Kak5mWWqRvl0CV8acRT/YC96qVrTO/c3awDhfrouRk0NC
        wERi3pSbzCC2kMBqRokFx+Ug7I+MErf/V3QxcgHZSxklNnY/YQFJsAkoSuzr2s4GYosIqErc
        X/+YDaSIWWAui8TNf7PZuxg5OIQFAiVenq6BqAmSuPtqMVS9lcS+5i9sICUsAioSEyclgYR5
        Bcwkum9uZoXYe4BR4s5CURCbU8BW4sHv1+wgNqOAmMT3U2uYQGxmAXGJW0/mM0HcLyCxZM95
        ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20nceNUOFdeWWLbwNTPEDYISJ2dCvCghIClx
        cMUNlgmMErOQrJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrig3zUsv1ihNzi0vz0vWS83M3
        MQJj/vS/w5E7GI/e+qh3iJGJg/EQowQHs5II78Lbf5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8wq5TowXEkhPLEnNTk0tSC2CyTJxcEo1MDk9eC8m4s15m/Hfne3uEVX63hf/CR6ap79qZcQz
        PouIaTebVdkvTUoMmB1r/XbzW/nLG7iPsT/56Bm389SJ5ZzqvC/vfF1296Evi1O2rQ/32YxP
        kndXJO8+3zphO1d90ukJtbcq0uJzIsV9f+lfiz/8ISlKZMEDQ8tJsty3Hzvxf7BhW/RP+Pu8
        9kWBMw7EqFhMixCq+XbvX4C0wkYeR9X8g/6hzBO7M7/uyZM+NqW7gX+h2T7HDZ33bgm27wjK
        zawyyL0gHDCjlFfGVTHZZ/ax8x73V2yYdsxg+iMz1SMrMmfoVnPxzVx8amvg/+m2bc9EJC7d
        e3/51utE/6hfMktKXysvbl435at9Vlu0jLcSS3FGoqEWc1FxIgC2ARtGaAMAAA==
X-CMS-MailID: 20230302062320uscas1p161e16bdb8d07a9a7f596b7be5902bedd
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
        <20230228224014.1402545-1-fan.ni@samsung.com>
        <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:
>=20
Hi Dave,
Thanks for looking into this.
>=20
> On 2/28/23 3:40 PM, Fan Ni wrote:
> > Add COMMIT field check aside with existing COMMITTED field check during
> > hdm decoder initialization to avoid a system crash during module remova=
l
> > after destroying a region which leaves the COMMIT field being reset whi=
le
> > the COMMITTED field still being set.
>=20
> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The
I run into the issue with qemu emulation.
> situation does not make sense to me. If we clear the COMMIT bit, then the
> COMMITTED bit should be cleared by the hardware shortly after right?

From the spec, I cannot find any statement saying clearing the COMMIT bit
will automatically clear the COMMITTED. If I have not missed the statement =
in
the spec, I assume we should not make the assumption that it will be
cleared automatically for real hardware. But you may be right, leaving the
COMMITTED bit set can potentially cause some issue? Need to check more.

Fan

> Otherwise, how would one reprogram the decoder if the decoder is indicati=
ng
> to be active?
>=20
> DJ
>=20
> >=20
> > In current kernel implementation, when destroying a region (cxl
> > destroy-region),the decoders associated to the region will be reset
> > as that in cxl_decoder_reset, where the COMMIT field will be reset.
> > However, resetting COMMIT field will not automatically reset the
> > COMMITTED field, causing a situation where COMMIT is reset (0) while
> > COMMITTED is set (1) after the region is destroyed. Later, when
> > init_hdm_decoder is called (during modprobe), current code only check
> > the COMMITTED to decide whether the decoder is enabled or not. Since
> > the COMMITTED will be 1 and the code treats the decoder as enabled,
> > which will cause unexpected behaviour.
> >=20
> > Before the fix, a system crash was observed when performing following
> > steps:
> > 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> > 3. cxl destroy-region region0 -f
> > 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> > 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> > "no CXL window for range 0x0:0xffffffffffffffff" error message)
> > 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
> > crash at cxl_dpa_release due to dpa_res has been freed when destroying
> > the region).
> >=20
> > The patch fixed the above issue, and is tested based on follow patch se=
ries:
> >=20
> > [PATCH 00/18] CXL RAM and the 'Soft Reserved' =3D> 'System RAM' default
> > Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xf=
h.jf.intel.com
> >=20
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   drivers/cxl/core/hdm.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 80eccae6ba9e..6cf854c949f0 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
> >   	struct cxl_endpoint_decoder *cxled =3D NULL;
> >   	u64 size, base, skip, dpa_size;
> >   	bool committed;
> > +	bool should_commit;
> >   	u32 remainder;
> >   	int i, rc;
> >   	u32 ctrl;
> > @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,
> >   	base =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which=
));
> >   	size =3D ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which=
));
> >   	committed =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> > +	should_commit =3D !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);
> >   	cxld->commit =3D cxl_decoder_commit;
> >   	cxld->reset =3D cxl_decoder_reset;
> > -	if (!committed)
> > +	if (!should_commit || !committed)
> >   		size =3D 0;
> >   	if (base =3D=3D U64_MAX || size =3D=3D U64_MAX) {
> >   		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> > @@ -727,7 +729,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
> >   	};
> >   	/* decoders are enabled if committed */
> > -	if (committed) {
> > +	if (should_commit && committed) {
> >   		cxld->flags |=3D CXL_DECODER_F_ENABLE;
> >   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> >   			cxld->flags |=3D CXL_DECODER_F_LOCK;
> > @@ -772,7 +774,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
> >   		return 0;
> >   	}
> > -	if (!committed)
> > +	if (!should_commit || !committed)
> >   		return 0;
> >   	dpa_size =3D div_u64_rem(size, cxld->interleave_ways, &remainder);=
