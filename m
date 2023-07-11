Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064174F421
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjGKPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjGKPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:54:33 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7FFB;
        Tue, 11 Jul 2023 08:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDY7dstcW/pUMeSilzAqSGlJiur2gzOd3bNysGulqTP40jc+RngStsoFPuzJA7TFrCosrv8Ien1aIqTt4rRgHV7gMsBOEeddBorBXwG0Ynd3Ht7rF8QKs6iqhi/gGAjV/tOOHv4n/NGKNkI62R2jjM2GziqZDus3FaOWSvTOQxm9Va163xZuP3S0bC39qhHf9O0JgEhVXVGrsNrEIVjwPf+hSaC/Q5CM+vECzeRyN0OLQyqOuX/Tc3FwSb+MqIkGpAxprBgVqplmZBxUJpdLLG3034oz7MiIyBbL6ilc/7FbhrlaJFR2ank4vO4tTHZpTztaiqy1Fuhs0SFwShmirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znrz4HIQxt2oszuYbbT9CbSrKWMeRoRJhvOteUxVFFE=;
 b=m+3C93Ka45bbclviXEZFu1UilTrGkDDcQ0Y8gQ9H07pp8lMQt/98WWRDkQ34qMOZk11dVTRk8a4Debiy0qRtY4LZWqF1SSPFVtrSiGt5Gou1iQq5IMWQKP7xN02pijWh0aVyK7BfMl87/jOSfguYibzAIkZeO4DA+OEU8d3LjNs6vfwTzVMauViPb8W7UcQCaB++rTbNJk/MgCHJeBebwV3IhMjoicQg21L1NXj5WCDG1PDseg+wiAR5PP2zHwyP8dAF3Mw3O8yVrGAHNTC9UzFM9VxsBFzg3/xaTzMSddIACWkelq9aP1XP+o46NVXUzGvTaidNL/OQg3Xu87nF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znrz4HIQxt2oszuYbbT9CbSrKWMeRoRJhvOteUxVFFE=;
 b=SMJamC8hMDbs4VhFv2XOlOMr/zw+Rvrh4PUYPT7/Xpek/rODe0ahd7lzQNdjLiCV2AJwrxnzOjh7nNGKP91BrvWTuZ66odhQx+lUUSsfA3Yubys+XctRPtk0QWqYHrQ4dNIMtPQX1QnFVfpOHoyX3o1DM12x9rTPGP/okzFj+e4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB4042.namprd21.prod.outlook.com (2603:10b6:510:207::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.6; Tue, 11 Jul
 2023 15:54:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd%5]) with mapi id 15.20.6609.003; Tue, 11 Jul 2023
 15:54:27 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: RE: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Topic: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Index: AQHZqN4Es6xs27E7q0W1vSuhepPC1q+p0aJAgAKeXgCAAGWX4IABQ5kAgAAO3oCAAduRkIACzpkAgAH5cQA=
Date:   Tue, 11 Jul 2023 15:54:27 +0000
Message-ID: <BYAPR21MB16886DBD419EFF6D16E05477D731A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
        <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
        <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070626-boxcar-bubbly-471d@gregkh>
        <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070706-humbling-starfish-c68f@gregkh>
        <20230707122213.3a7378b5@meshulam.tesarici.cz>
        <BYAPR21MB1688D3AC0C094420733717C4D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230710113618.2038e033@meshulam.tesarici.cz>
In-Reply-To: <20230710113618.2038e033@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4fe17a3a-44f9-4ee2-847b-6be77321446b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-11T15:45:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB4042:EE_
x-ms-office365-filtering-correlation-id: ad1fcb6d-8fbd-4cd9-1489-08db82271b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUnwiDdXEay51yrfY3ijdJ+NR2hnIGskLhzhza3h4MzpZu1yWZizIOcxBp70Cr/sy4FLGGdTgp14YQjevcPz2SAmYE/6dRUjgJhYtbmi0NTEuOA6uTDAv9j+P52loN9x5JDfE7RKr1ELN0rmbh6K4EqsHEpg3XhnJaNb2aRQTrVupnOhRebuN1WM6qCZERdcZLIgLrv88vIqRYGxM4U8n0wyJpnyf0k9NQXp0ESibttfW3JLu6TktXmEs125kYYK3pDsnv72s6eODiB0k1hFH5lPqvzCWufZ/vnIxQWNCDMeASpuGf4FNsg7p4yxFE3aZT/VNSgQZvWYIFvcHUwO6vXladPrqZ/1fT/y3Jwj7VKWpRwHrxhnRqywori55V1xx2PrxkbRwgW7Or9Gq2w7kU7CIfWgl4LLAkYmM0Hshx1/Uk/G6uQSgt1wf+AL0cAWPIjlfJF/mmR1hdeQxPSOl4oFCTNWiyR6j1iCF65zt4E28fGcamJxyRLpP8r8x8KXuuJqYZ1RrXBB2Tt1rKsrgrY+vuAcytmLxPcLkREnINA1q8xFM7ENPKqhq0LesohT/EMkpE7E+poo/x+prLdl8bTToDYfAQmYXWo/YfXolCWLmsq2dWgxJQX/Au3qzDr6z7JRgCLk+zjEBH33ucw/kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(6916009)(4326008)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(38100700002)(122000001)(86362001)(186003)(38070700005)(6506007)(26005)(83380400001)(82960400001)(82950400001)(10290500003)(33656002)(478600001)(9686003)(966005)(7696005)(8990500004)(54906003)(71200400001)(7416002)(55016003)(41300700001)(8676002)(8936002)(5660300002)(52536014)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?DpmrLS+gaMw2CjFaOZce4l0z2b2Krn/u2YYH3rcdpVo7SQk2r5Eu5nOgy0?=
 =?iso-8859-2?Q?xDY2v5vQ2jWEfgHB7ZRtspI/SJN8dyvls8CrpzQ8csJvY5kRs2U4fvcG7I?=
 =?iso-8859-2?Q?kt1LM/d5P3Plc5KWY9+6YNZki0PBBSKtvQkB8M62Ab5fUTveRmcFNV8haD?=
 =?iso-8859-2?Q?m5MreUSn/DxE2zRCpCbsqJalYxLNDLOsHo6umpwioJUnRXLCWR2JdifFh0?=
 =?iso-8859-2?Q?flHBZDuQM8Skab8N+wkzL7sktZ5SOXNyzF4B2fyNYAd8K7RxIs0Vhqfv6x?=
 =?iso-8859-2?Q?KARwdlu1n2hw1eby++iWeWRDlYremDkNnQIZn6vcV+42S6kJ0H5G+GsYFU?=
 =?iso-8859-2?Q?6J9sTvefivDtYUuAp2vYgT+cPvhS/ilTVT/d6sq1U2XgquQkdtZBv3rqbP?=
 =?iso-8859-2?Q?SWY+4pKFTnUsL5b2YEQF4J+y2dF7lntDBbr21H5EjhlONVWEaUhlQp/VkL?=
 =?iso-8859-2?Q?xk4x4p11D/RMw19y6AanGvteS9rI1B683m11OybjdLNUHppA/odKfE4XN/?=
 =?iso-8859-2?Q?rFju7bwjNgcdywwPduoKeFEYnzX4TOls3C0HQWzAk/sQMyjR1+eD6hB64P?=
 =?iso-8859-2?Q?nxsmTn1jz6kuqKtAxkbPq1s6vy29Z/fL2qQ3RpHmLopI6GB0Lh+ghHZzCe?=
 =?iso-8859-2?Q?yp+amZSvzqVgFxUl7Pwffc+/eZr2IzOb8ypbPHGT3f5RlDvCOYp/n0wA2F?=
 =?iso-8859-2?Q?YwqNzXB/69QzPAo2Z4YFux8zdjS8ynjm8iNPDHW/WFLnz6oMKRAwPlHpPC?=
 =?iso-8859-2?Q?B+Y10vqN5T4+IXLOYeaxlGYgxwo7u94fUqboHxOk+8SOcN338buueEXiwH?=
 =?iso-8859-2?Q?ygQ7jSyZnu7SYbd+Iew3BZFN/k5dRymAlTSbD1HiWENQd+EwuTmPUgJCCU?=
 =?iso-8859-2?Q?BmQOw79lkWW1XYFu+qL77YCUQ9Y7hUol55YxXmGag2B3V5eTaHVP5MkqBh?=
 =?iso-8859-2?Q?ivbfC6NZqi6YtX9uHC60bU+sQB6qpYSCB+7GHRUKDubzD5lqhwOZQa09TD?=
 =?iso-8859-2?Q?kopn0ks05NamWBHj5Drn4p8LuTOjMODwvfb81fKLKUDFRnQD9+mBH1cDn5?=
 =?iso-8859-2?Q?eb1VY13z+HDYK83ur/Kfa/g6JEOwZn9qCj8Sc4aWRCCMneXnPb4GC0IGIm?=
 =?iso-8859-2?Q?U1Z0OKxFEargiRkkqEyp2ISWAEecY5IBPPtPSAQ52xESmu7nhZPo1bvfDC?=
 =?iso-8859-2?Q?3GK46c0LqsJRE/dJW3K2WZIaoLAxeVay0nnNIfzFLOArHtBz1HoecCnddO?=
 =?iso-8859-2?Q?OTnwoT/6pcDPkoxboNs6bJgJ0tW1OAWnBsH94PYIFeYj5pYJWxdRve2heR?=
 =?iso-8859-2?Q?erSqYi8jJJKCjKXFJvKzg6UuHvYyYIUSz+UFc3K884Vsny9glEL8NxYUow?=
 =?iso-8859-2?Q?mwK7xewi/XSiYugo/YXcc5mhA2wQWzUrIo0z2vLoMSBCI+tg8fVmmaqPrJ?=
 =?iso-8859-2?Q?T6gisz3OnSysbFX1+a1qKBI/NMEbhu3m1ORDRjCUimDf7JYs2o5dRYk+HU?=
 =?iso-8859-2?Q?+cHkl/DK91aRfQuSp4TpPVo1H5IWmPzjEtibj+spjiTSGnFLmvqnsSWFFR?=
 =?iso-8859-2?Q?ly6/qOWE30uFM7cJr2AF/ZCzuOIYT/F4SQfWeqa6jjKgU0UXTtxlgXTFXc?=
 =?iso-8859-2?Q?0W6yV8HbNLz1vG57vvyPB79mliLS8A9iigOZOtJJ84Vcks9yMvMoNrig?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1fcb6d-8fbd-4cd9-1489-08db82271b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 15:54:27.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rcT/mx8AI1N/qgQmkIse7rnaczRnduqikxVREcs9Opuektrxry4sSBk1AvL52MsvS/t4ClDE1zqo8yU6GZ/qXSjCLlutG9UdkD5gUBiVp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Monday, July 10, 2023 2:36 =
AM
>=20
> On Sat, 8 Jul 2023 15:18:32 +0000
> "Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
>=20
> > From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, July 7, 2023 3:=
22 AM
> > >
> > > On Fri, 7 Jul 2023 10:29:00 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Thu, Jul 06, 2023 at 02:22:50PM +0000, Michael Kelley (LINUX) wr=
ote:
> > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thurs=
day, July 6,
> > > 2023 1:07 AM
> > > > > >
> > > > > > On Thu, Jul 06, 2023 at 03:50:55AM +0000, Michael Kelley (LINUX=
) wrote:
> > > > > > > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesda=
y, June 27, 2023
> > > > > > 2:54 AM
> > > > > > > >
> > > > > > > > Try to allocate a transient memory pool if no suitable slot=
s can be found,
> > > > > > > > except when allocating from a restricted pool. The transien=
t pool is just
> > > > > > > > enough big for this one bounce buffer. It is inserted into =
a per-device
> > > > > > > > list of transient memory pools, and it is freed again when =
the bounce
> > > > > > > > buffer is unmapped.
> > > > > > > >
> > > > > > > > Transient memory pools are kept in an RCU list. A memory ba=
rrier is
> > > > > > > > required after adding a new entry, because any address with=
in a transient
> > > > > > > > buffer must be immediately recognized as belonging to the S=
WIOTLB, even if
> > > > > > > > it is passed to another CPU.
> > > > > > > >
> > > > > > > > Deletion does not require any synchronization beyond RCU or=
dering
> > > > > > > > guarantees. After a buffer is unmapped, its physical addres=
ses may no
> > > > > > > > longer be passed to the DMA API, so the memory range of the=
 corresponding
> > > > > > > > stale entry in the RCU list never matches. If the memory ra=
nge gets
> > > > > > > > allocated again, then it happens only after a RCU quiescent=
 state.
> > > > > > > >
> > > > > > > > Since bounce buffers can now be allocated from different po=
ols, add a
> > > > > > > > parameter to swiotlb_alloc_pool() to let the caller know wh=
ich memory pool
> > > > > > > > is used. Add swiotlb_find_pool() to find the memory pool co=
rresponding to
> > > > > > > > an address. This function is now also used by is_swiotlb_bu=
ffer(), because
> > > > > > > > a simple boundary check is no longer sufficient.
> > > > > > > >
> > > > > > > > The logic in swiotlb_alloc_tlb() is taken from __dma_direct=
_alloc_pages(),
> > > > > > > > simplified and enhanced to use coherent memory pools if nee=
ded.
> > > > > > > >
> > > > > > > > Note that this is not the most efficient way to provide a b=
ounce buffer,
> > > > > > > > but when a DMA buffer can't be mapped, something may (and w=
ill) actually
> > > > > > > > break. At that point it is better to make an allocation, ev=
en if it may be
> > > > > > > > an expensive operation.
> > > > > > >
> > > > > > > I continue to think about swiotlb memory management from the =
standpoint
> > > > > > > of CoCo VMs that may be quite large with high network and sto=
rage loads.
> > > > > > > These VMs are often running mission-critical workloads that c=
an't tolerate
> > > > > > > a bounce buffer allocation failure.  To prevent such failures=
, the swiotlb
> > > > > > > memory size must be overly large, which wastes memory.
> > > > > >
> > > > > > If "mission critical workloads" are in a vm that allowes overco=
mmit and
> > > > > > no control over other vms in that same system, then you have wo=
rse
> > > > > > problems, sorry.
> > > > > >
> > > > > > Just don't do that.
> > > > > >
> > > > >
> > > > > No, the cases I'm concerned about don't involve memory overcommit=
.
> > > > >
> > > > > CoCo VMs must use swiotlb bounce buffers to do DMA I/O.  Current =
swiotlb
> > > > > code in the Linux guest allocates a configurable, but fixed, amou=
nt of guest
> > > > > memory at boot time for this purpose.  But it's hard to know how =
much
> > > > > swiotlb bounce buffer memory will be needed to handle peak I/O lo=
ads.
> > > > > This patch set does dynamic allocation of swiotlb bounce buffer m=
emory,
> > > > > which can help avoid needing to configure an overly large fixed s=
ize at boot.
> > > >
> > > > But, as you point out, memory allocation can fail at runtime, so ho=
w can
> > > > you "guarantee" that this will work properly anymore if you are goi=
ng to
> > > > make it dynamic?
> > >
> > > In general, there is no guarantee, of course, because bounce buffers
> > > may be requested from interrupt context. I believe Michael is looking
> > > for the SWIOTLB_MAY_SLEEP flag that was introduced in my v2 series, s=
o
> > > new pools can be allocated with GFP_KERNEL instead of GFP_NOWAIT if
> > > possible, and then there is no need to dip into the coherent pool.
> > >
> > > Well, I have deliberately removed all complexities from my v3 series,
> > > but I have more WIP local topic branches in my local repo:
> > >
> > > - allow blocking allocations if possible
> > > - allocate a new pool before existing pools are full
> > > - free unused memory pools
> > >
> > > I can make a bigger series, or I can send another series as RFC if th=
is
> > > is desired. ATM I don't feel confident enough that my v3 series will =
be
> > > accepted without major changes, so I haven't invested time into
> > > finalizing the other topic branches.
> > >
> > > @Michael: If you know that my plan is to introduce blocking allocatio=
ns
> > > with a follow-up patch series, is the present approach acceptable?
> > >
> >
> > Yes, I think the present approach is acceptable as a first step.  But
> > let me elaborate a bit on my thinking.
> >
> > I was originally wondering if it is possible for swiotlb_map() to detec=
t
> > whether it is called from a context that allows sleeping, without the u=
se
> > of SWIOTLB_MAY_SLEEP.   This would get the benefits without having to
> > explicitly update drivers to add the flag.  But maybe that's too risky.
>=20
> This is a recurring topic and it has been discussed several times in
> the mailing lists. If you ask me, the best answer is this one by Andrew
> Morton, albeit a bit dated:
>=20
> https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundatio=
n.org/

Thanks.  That's useful context.

>=20
> > For
> > the CoCo VM scenario that I'm most interested in, being a VM implicitly
> > reduces the set of drivers that are being used, and so it's not that ha=
rd
> > to add the flag in the key drivers that generate most of the bounce
> > buffer traffic.
>=20
> Yes, that's my thinking as well.
>=20
> > Then I was thinking about a slightly different usage for the flag than =
what
> > you implemented in v2 of the series.   In the case where swiotlb_map()
> > can't allocate slots because of the swiotlb pool being full (or mostly =
full),
> > kick the background thread (if it is not already awake) to allocate a
> > dynamic pool and grow the total size of the swiotlb.  Then if
> > SWIOTLB_MAY_SLEEP is *not* set, allocate a transient pool just as you
> > have implemented in this v3 of the series.  But if SWIOTLB_MAY_SLEEP
> > *is* set, swiotlb_map() should sleep until the background thread has
> > completed the memory allocation and grown the size of the swiotlb.
> > After the sleep, retry the slot allocation.  Maybe what I'm describing
> > is what you mean by "allow blocking allocations".  :-)
>=20
> Not really, but I like the idea. After all, the only reason to have
> transient pools is when something is needed immediately while the
> background allocation is running.

You can also take the thinking one step further:  For bounce buffer
requests that allow blocking, you could decide not to grow the pool
above a specified maximum.  If the max has been reached and space
is not available, sleep until space is released by some other in-progress
request.  This could be a valid way to handle peak demand while
capping the memory allocated to the bounce buffer pool.  There
would be a latency hit because of the waiting, but that could
be a valid tradeoff for rare peaks.  Of course, for requests that can't
block, you'd still need to allocate a transient pool.

Michael

>=20
> > This approach effectively throttles incoming swiotlb requests when spac=
e
> > is exhausted, and gives the dynamic sizing mechanism a chance to catch
> > up in an efficient fashion.  Limiting transient pools to requests that =
can't
> > sleep will reduce the likelihood of exhausting the coherent memory
> > pools.  And as you mentioned above, kicking the background thread at th=
e
> > 90% full mark (or some such heuristic) also helps the dynamic sizing
> > mechanism keep up with demand.
>=20
> FWIW I did some testing, and my systems were not able to survive a
> sudden I/O peak without transient pools, no matter how low I set the
> threshold for kicking a background. OTOH I always tested with the
> smallest possible SWIOTLB (256 KiB * rounded up number of CPUs, e.g. 16
> MiB on my VM with 48 CPUs). Other sizes may lead to different results.
>=20
> As a matter of fact, the size of the initial SWIOTLB memory pool and the
> size(s) of additional pool(s) sound like interesting tunable parameters
> that I haven't explored in depth yet.
>=20
> Petr T
