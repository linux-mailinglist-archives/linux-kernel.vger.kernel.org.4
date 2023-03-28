Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B86CC210
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjC1O3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjC1O3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:29:10 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA60CA1E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5dVBLmLdCfUJoVLlCYqW+nlVYnA4EuXd7VnyNrk8Ye2Vi2EA49qiK3M+GzBEM8p51SoGDC5keypzs3j1zlF501af11zE/V/9QJOiUzkvOMg7YxoZu6rOeHYew0QbKBofUHsmjft16WQL30L4AUmlOExYF1ytJP5U2VzkrndHEjRmPY1fnAA+P0Js+JWHZDxv0QJ1Kfa32+4WhAfHtynv2vPHeTm3F9wZQ0JrpwoP7hT0RE97IZgjPz75vxJu5YD0IxzCKppYrEFCrViLzl/9Q+zDUGPehr2GjdBwaHh+n7ywuyO6uqPAaHrXHszLeq0Yn0NmQz/docceuoJ0RcDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6nLTu/cujPInggwUMtblib3uQEEhDmvHx7pilEDjuM=;
 b=mrbm9kN6bIWfvcBcjSBAxmtF+xnl9AMFz1DoKYQQX+no0NTfdfWacIIp21JWw/BAAKELZrRq6rwZRSsTrxCm2k+8qH8pVRcb0FNj+qjRqUC7o6/mnjpiXod3UOn86chchrXtEuSXxbgBshebhJM95XRIc+vHt85MIHTzjkXbrKa8mQfqX5pvExd13JALNqdPYjiUqh/PwejCgmolElbx1QezXRtzy1GEtCEzmy6YelU06R4g/1AXFQG8RmcLo82jIofu04rVolXnHRfJmPtgnnPZUNYyitfRw71qm/rjawrG7ZwLPE6Y7QDDSgcj36MDXpPKh3MzTajPK6SPQdB42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6nLTu/cujPInggwUMtblib3uQEEhDmvHx7pilEDjuM=;
 b=Dz+yO0R+Rb98keB1+ODRi4uJhnP4kFevIWWfqRAzuJ35782uUfKPiFT5HO5rUrk5gr7uaF1qG+jsXOt90jZLOPE9ut1dtfFq/kp4Yn69CRR7mJ9r0iV88P8BtZyZBSFNrw8KiyNFFlfL9x6FC/7BBVtNL/cJId15bWC+mxAwva4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1312.namprd21.prod.outlook.com (2603:10b6:a03:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.6; Tue, 28 Mar
 2023 14:29:04 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6277.006; Tue, 28 Mar 2023
 14:29:04 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
CC:     Christoph Hellwig <hch@infradead.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZX0LG5qMB8+ZzCUqrEQruwKd8m68PbDKAgAC/CxCAAA6ygIAABf5w
Date:   Tue, 28 Mar 2023 14:29:03 +0000
Message-ID: <BYAPR21MB1688983A72B114BBC3AA1DE2D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
        <ZCJEAx/G0x6zokPF@infradead.org>
        <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230328155017.5636393b@meshulam.tesarici.cz>
In-Reply-To: <20230328155017.5636393b@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8e7b4f4-17a5-4497-91a2-72fcf09ee385;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-28T14:11:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1312:EE_
x-ms-office365-filtering-correlation-id: cd87bbfd-b753-415f-de38-08db2f98c7fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2eRk8TqKbU5aCSrCZ2grF4K0YxpnlzE4FoeSuNfgQnk/WqaCxuJjnMPIvFepywbEKeu/euweHSdONbV4VF/2eff/8MUY17qBKyQKfum6Z/T1j/UvZ7vY/R9Gf6n8v37GtsdL/bmRcF5V9f6YoYiKpxskQdf2ZbBtGpehO71sch7TAaj5HYv4B11jHJ2HghciTQyMsUSrHKA4brW6kTb9bOj5cLlqZTp1REUduO3qT/EZBQQCsD73SwJ127l7sFOvbohIVG4rNgekTCR2GMZTz9HNOwWZyMqw4RahcTZ1eP/wsfsHSVJixwnkTA51jj9vv4ENPgPbXCSRVIgV5Vdl08BJnZg2UpQ7HzmTQ2qF24jjVnIzcZ7A5rTg/R9EQ7dlJCMtTfFnl9K6Ltuvshje8iyE0OlnC2+D3LbpzxnmX9F0WHKlOE9Ov3oisz6QvU2MPN2nT0jhZvFbudOkpAMRwWufZV/+1ahuKuSd0t2uoPdZVHAeoG7fDFBhkU2dX+6pZE5MD+W15+eEr4FxrIeI4a2Xhu8Mo31YMj5yPjafeCTM45QBH579aYzN1+QfvDEphdOlGgZDAj2Q9SxSBcb6jEW7U3PLziiBvght6f/cQkG7QR1pQgx9FFKydrXaHUDHKoBWti8Xe9skVOlp8zfYU9HiDrN+jdy4GuymkrkdRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(316002)(6506007)(82960400001)(82950400001)(86362001)(122000001)(5660300002)(54906003)(52536014)(8936002)(66946007)(41300700001)(64756008)(66556008)(66446008)(4326008)(6916009)(66476007)(8676002)(76116006)(186003)(26005)(9686003)(33656002)(55016003)(38100700002)(10290500003)(83380400001)(38070700005)(478600001)(71200400001)(2906002)(66899021)(7696005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?mbLXQlH8KX+rc3tOt109JhO9x28MBoONIimxWmc2WtMd4wxMpFFY2R2uT2?=
 =?iso-8859-2?Q?jXY9dTdJPDEUKuFXsY854b4KU+/t1Udu8+PgEtNSegHMt2I9LErttPl3Xn?=
 =?iso-8859-2?Q?oDJQCaB02fjVX1T66k3oFMT8f81jii10bLNiUbC8ELEgNsFKAbMEG5GSkt?=
 =?iso-8859-2?Q?HYwcjEtrETtm6M65XGqBhpEBb5Ekbc7IeeSrOGq5grIJ9760k97bIqbvWf?=
 =?iso-8859-2?Q?BYqfXXoUYcQdV3j7HlyOYwp+SoUB+lN3dYQdj7FFxlrpF20fEKRv0oZ9Jl?=
 =?iso-8859-2?Q?ih0mBwNCOjOnKSHoMiq1CdUoXMvWngeN0SOQ0lP9FyYWoJp1JXzB1+qc1w?=
 =?iso-8859-2?Q?a+gYdAVezsQGSmCDOAD6Ls9PkKjYUGW3FkG9F7oHMW5iqm5MdbPCagFDi3?=
 =?iso-8859-2?Q?jdHI0wrcwn2i5msCeCWkhcN4psJt1dvqyMZY7TujNgwqoSvt/UySNhKMmp?=
 =?iso-8859-2?Q?CnRi9pwCgCthwe4d6V1Fj3CVAZ5hvbWKOsDVw1Y6sr7vW7A+Xb9wRL5d0W?=
 =?iso-8859-2?Q?4c0lQ0wY9adrcx45j5supSlDlwV32DY9GwT5wqLkgeOqmgwllF0i9M1gwx?=
 =?iso-8859-2?Q?DkMCuQzpUhsYC40Y9YV0OG5eUEgIzcIPsQBoqAcMLmRX71Qf6QmAvDIeVJ?=
 =?iso-8859-2?Q?giGQ184YZ5eaTZFvhTiofZbUtMG9RY1cMUipVWTVpY395cE4oWHJPN86zr?=
 =?iso-8859-2?Q?gTQsUfWFXCYSnw7uNQsPmII4ID/4l7ZR0jDuVdjwK6FI4Tyllw/8DzBy8F?=
 =?iso-8859-2?Q?7kmk8K0JjoL1CJpwL66AYYWUltnrFZLehvzZZp8j+kvsgra5qPS3RsZfZj?=
 =?iso-8859-2?Q?VKlT3MDSMSSZmNM1rvsASx6XZ9RRRAK9MJf4aMdsoEUV/jcJ0BW4R//nxM?=
 =?iso-8859-2?Q?U8dfoa47QC0/A2afzsm+aeAn5hBrGc4SdJe7cYWQqFeM4dAr+puGpVXdvy?=
 =?iso-8859-2?Q?0qmBCa3fmm3fUClhBR0XkT8goNonJ6dcPmTcp1EmYCKZ2SynNWMpU9WDG8?=
 =?iso-8859-2?Q?SAN9u23l8s1fQ1dzd8D1F4RNnLh/O9oYLuN6vy2nC1pRJTNfDYFLt9DZJ7?=
 =?iso-8859-2?Q?XxpdERkaSp3ZDiNQBZJOUk/2NbOm7mAZLn5ylT/L85Xt65VtIx1UKHXZJm?=
 =?iso-8859-2?Q?VEgI+TtB7uoFtrIljSom3yfXZEBDgf+SCbLdB9DitUfaepRrico0kQHgAA?=
 =?iso-8859-2?Q?vpIvCT2+fyF9F6h+9jMSFAMTFyNlSz1FsjBe+jGG0kiL3s/e+bSCWJAtte?=
 =?iso-8859-2?Q?lq5wob+2W+afMVGVSUwuaIAccr6Oiy5A5BTAxKByD47o7zOGu21uL72j97?=
 =?iso-8859-2?Q?270poWzuqskY12NLPHanCY75CD3q5xXw6/dBrl5Dt6iw+sGaGBU1plk68e?=
 =?iso-8859-2?Q?6/F8Qhf7x/PZp+nu5v2WUP8u0u1XEHT0SxLVRWLCJ+PumDk8hBU35dr9eD?=
 =?iso-8859-2?Q?Uz6kNNbRpO0xid6H2wT3uqNHjn+AhHek35IufaFuyCd8umUA0t+6sI2H0U?=
 =?iso-8859-2?Q?fdjEtWO/Z9+IrSQX+hLCE5E83N/0I+wnXGmUTLoceCLoU9Kj0dhNXrD7Ux?=
 =?iso-8859-2?Q?KCM5tMTp31F8/BeLXysKh19cmtAtkAf7JDLFu+BJco5tYHwLfV6X8d9PdE?=
 =?iso-8859-2?Q?8MrvtdX/O03iIP1LM0mewS1i+ozaWQEg83U3oPn8ZcLg29jlIhP32SXQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd87bbfd-b753-415f-de38-08db2f98c7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 14:29:03.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9cg8RI+GXUTsalx8S7QIcmxEPfBpwMrD6aeFu9ORKn8Ugka/bgZHkSqYv8XxmYCsSvToYO+lmJHMgYXnrOMSdDu1jMAIi7xZYt7gyQMFO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1312
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Tuesday, March 28, 2023 6:5=
0 AM
>=20
> On Tue, 28 Mar 2023 13:12:13 +0000
> "Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
>=20
> > From: Christoph Hellwig <hch@infradead.org> Sent: Monday, March 27, 202=
3 6:34
> PM
> > >
> > > On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote:
> > > > @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device=
 *dev, int
> > > area_index,
> > > >   area->index =3D wrap_area_index(mem, index + nslots);
> > > >   area->used +=3D nslots;
> > > >   spin_unlock_irqrestore(&area->lock, flags);
> > > > +
> > > > + new_used =3D atomic_long_add_return(nslots, &total_used);
> > > > + old_hiwater =3D atomic_long_read(&used_hiwater);
> > > > + do {
> > > > +         if (new_used <=3D old_hiwater)
> > > > +                 break;
> > > > + } while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, ne=
w_used));
> > > > +
> > > >   return slot_index;
> > >
> > > Hmm, so we're right in the swiotlb hot path here and add two new glob=
al
> > > atomics?
> >
> > It's only one global atomic, except when the high water mark needs to b=
e
> > bumped.  That results in an initial transient of doing the second globa=
l
> > atomic, but then it won't be done unless there's a spike in usage or th=
e
> > high water mark is manually reset to zero.  Of course, there's a simila=
r
> > global atomic subtract when the slots are released.
> >
> > Perhaps this accounting should go under #ifdef CONFIG_DEBUGFS?  Or
> > even add a swiotlb-specific debugfs config option to cover all the swio=
tlb
> > debugfs code.  From Petr Tesarik's earlier comments, it sounds like the=
re
> > is interest in additional accounting, such as for fragmentation.
>=20
> For my purposes, it does not have to be 100% accurate. I don't really
> mind if it is off by a few slots because of a race window, so we could
> (for instance):
>=20
> - update a local variable and set the atomic after the loop,
> - or make it a per-cpu to reduce CPU cache bouncing,
> - or just about anything that is less heavy-weight than an atomic
>   CMPXCHG in the inner loop of a slot search.
>=20

Perhaps I'm missing your point, but there's no loop here.  The atomic
add is done once per successful slot allocation.  If swiotlb_do_find_slots(=
)
doesn't find any slots for the current area, it exits at the "not_found" la=
bel
and the atomic add isn't done.

In the case where the high water mark is bumped, the try_cmpxchg()
is in a loop only to deal with a race condition where another CPU updates
the high water mark first.  The try_cmpxchg() should only rarely be
executed more than once, and again, only when the high water mark
changes.

I thought about tracking the high water mark on a per-CPU basis or
per-area basis, but I don't think the resulting data is useful.  Adding up
the individual high water marks likely significantly over-estimates the
true high water mark.   Is there a clever way to make this useful that I'm
not thinking about?

Tracking the global high water mark using non-atomic add and subtract
could be done, with reduced accuracy.  But I wanted to be tracking the
high water mark over an extended time period (days, or even weeks),
and I don't have a feel for how much accuracy would be lost from
non-atomic arithmetic on the global high water mark.  It would still
be a shared cache line.

Regarding your other email about non-default io_tlb_mem instances,
my patch just extends what is already reported in debugfs, which
is only for the default io_tlb_mem.   The non-default instances seemed
to me to be fairly niche cases that weren't worth the additional
complexity, but maybe I'm wrong about that.

Michael
