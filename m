Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724DE6DB649
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjDGWFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDGWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:05:31 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25EC61BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvV+nPxj6VsQ1WKepCQA24FhtDMtGIW3RkwZj20pk3Nfy+RUnM+vAJi3GWRL/Ldo3H1Z+TKvgiA/pb7VpFPKitjFJuGEtlob2LRAhVSKWmuUzOD/49Wq+iPzyRc/Qll0yzofYm9AktUUCzk/tbwznXYLXYZR1dJk/AFeIUZaca/x/7PjwePgXBCHwqdpO/foWG7iaAmCERKdqv9R8paYN1tgjSDuVA+ULFSwywO2OSgtVQpL2MCNvmJK+Ufs/W3dDhMR7c/8i4Veo2T/T+lGWDISshSlBWKYyX3TTE29jGMg040rXdF2wztgaof9Y+PnHuq18jTryfVkBj0hBk9s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAYBUqgZry8qXPdWVFFH9gYDFwwit96L0gQoQrHGyjs=;
 b=M2ekxXVpedF48IIw1SmQKwdWJCfiI+qtsOHRWZXE/X09wOCV0g5WTezOc77EhIw9zwTqITFXBWa7quADTZmod9AQ754oUPLc4nOIYhA9zGbsSYIKvsEJymSAHem0ChutRedtKNMkD12cvwTMhV64HAWP3/9KMhbXkYvJuTxU12w0kKuQN3kJ6TvU0lILMu8Ffr+O/tltjJM9ARwxY1/D881eaXkYReuRYfzWqXZ/A40VazcVl3kyP+5SO+PBUsvfqalIFA5yBQbhY8Hg4at0EsY6pLXYwa0NZKH0zJg0PUCOKMUsCASmwi98gdVlnGQvcw4j39V/ebAcPk+/RWqH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAYBUqgZry8qXPdWVFFH9gYDFwwit96L0gQoQrHGyjs=;
 b=aGRU16dZyXg3VYJ8/CfOHldSO7rFcaXTlhm7AVTGVPoHqH4jkJAunRRGVeAImFWuj/jN2CUJ58zzFwjYQsdGarz7nQeszj5iSw1kUgxq7O2+bQp/GUV0mEmz31t/xN/zvNV5xuaKNXsNJvc5XBsNl4bk4TDFVh3WbU0uiVEjBR4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3057.namprd21.prod.outlook.com (2603:10b6:8:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.18; Fri, 7 Apr
 2023 22:05:26 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 22:05:26 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
CC:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZZFTgGkCO6sw65k+irtwUSCAKHq8ftkyAgAC5/sA=
Date:   Fri, 7 Apr 2023 22:05:26 +0000
Message-ID: <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
 <20230407125535.476350d4@meshulam.tesarici.cz>
In-Reply-To: <20230407125535.476350d4@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04edda0c-16e0-466f-a597-8c359a8c141a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T22:01:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3057:EE_
x-ms-office365-filtering-correlation-id: 170cb514-42e1-424b-159a-08db37b4317f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMThrD5DhSecMEn8KQXb+ounf5pMexIeP5q2zhXJwHvIBY0yMJKrv3EwuSVTg5rZ5JPzEiIZrsNYLoNYs0SdF5wDqSK3BjxgOMYdR6EDBRhc3//F2TGPK4PjwAiPmzzDVMRlDsf2UC9FXc5+4yPdwMN0+3yBWUsFgUOOhZyxDg6wWdBi7GqXmv1n1Fo0UUwuJkx/Ws+KKqWmbdWgSrTUkGgS0gfKuldFsKcNR767htjDuAkexmCpMZyo8+CvBP53ew1TU2Q9b2BGhLd2eI/aK7fkMcxd3kCsMVlXtsqo4c14PVFfsANL9qGrPRtOz+97IqYtcV+F7YOnv6eiAwKGKjh9g0TT36E/KeYAz7MHsxUazlGW5usaJ12KseD60D3C9n82AI82SDYeD3lcwjbH0bQ04ts8QO/hAEdCFsXbur35w/OJuCDvRLViclWWiNK6A05VGhWiPYI7n0k6QAV/1tSlBrl5QfR03ehUikFL+JfJY1f1NaND/dJ684Td4xH6gMGtY/yc7JoT06+v1S5cBT+jWoV9XdwSaBlouOMm/DNGQcMaMq/IT5CZqrDQ0bE97X2+iyqfYf5vve2CqgkSrX2RQmYY/IVkAOMGgfsZDnceExN36+v6CBJ/HSSA/ZOx8HJH1/3/9p3re6sCIMSsDYxOGOl01+MqjwR6jBtV4ZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(38070700005)(5660300002)(2906002)(52536014)(38100700002)(82950400001)(82960400001)(55016003)(122000001)(33656002)(86362001)(8990500004)(186003)(54906003)(316002)(71200400001)(76116006)(66946007)(66556008)(66446008)(6916009)(4326008)(64756008)(66476007)(7696005)(26005)(478600001)(9686003)(6506007)(41300700001)(10290500003)(786003)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?FcTJK7teeYdlnzu9EvCnzfr33m0MacZvYUsWL1EzexpqmV1isCcCCh58co?=
 =?iso-8859-2?Q?FGsy2NCaH+fiTTUdvpXq8cWBv2ZDLQV4wdZPa4O8NQ3SMRYZvOTKx4WDm7?=
 =?iso-8859-2?Q?pc9vKIyJH9tM7u6S16CpdsTlyHb2kmU5BYH/SUwN1fe6ZG4y3SbLT9jYFj?=
 =?iso-8859-2?Q?Wv7Cxl+E6PJ/X8av5AcA7WUMxugnebPz/wJsBBWDNuMlVzBz4d7ceXBLdv?=
 =?iso-8859-2?Q?TKjzAipyfhpBUDdC9Iso28lBxq9Yl5d6c4nfyp8a2oG1R65xT6KkfvD0cX?=
 =?iso-8859-2?Q?zA9VetMnyKYGtRrhFi3wMsmIIMP2NJwQ2TI7+Fcv9sQ0IH/fI4qc4Bw1aC?=
 =?iso-8859-2?Q?lLJsg3CEIoHuT63jbeshK5wnniTXgHk2jA1My0FLeKyns6jGDsZSyIqBly?=
 =?iso-8859-2?Q?wOv9s9/wofnKZqDMe4ltHK2vVPkCWI1aQg8/ME+KjjFYEQeE7wCUzJI5ag?=
 =?iso-8859-2?Q?munzbKAS2mDPHfjVc6yf1xofKMFbfgRzMWnF8h/FjeaGmO79Paj70MAxQ7?=
 =?iso-8859-2?Q?nccj2IWQZgmN0DIVo9WarQRURVcYjbMP1nsE92DobqiHz3M//TUfKo94Df?=
 =?iso-8859-2?Q?gS2PJzBSXvKZLIg+WYdpJKWqqNL6MPCRSqoHbB2FwEK/205c0UGVW4U1Ye?=
 =?iso-8859-2?Q?no6+oXGG3cHvtt0eFUfIUy3fAmUu0RRbv+rTFxKwuYTvJ3Zc+Y64GHRbmw?=
 =?iso-8859-2?Q?p1+17UXWulzGySEdK+qWbKe6zOXpAUR+HiRm0LhOi0RS6Qwkwf0dkzgYeI?=
 =?iso-8859-2?Q?1LBS91Cfv8nRq4ZN7iTNeUIqJ1z1VvTj+L4jctQ40GlkX4+Suqb+I6EmJi?=
 =?iso-8859-2?Q?nUJC1/9KH4AKH+L69xVe5Pr4nPBaIeVNEVoCywSjCHvm1uy3way4BlbG96?=
 =?iso-8859-2?Q?LyJRd7RDKxhM7UC5OXkdNkdPGL+nUn9S5bLrXuGl5RygimCdLdaa8CA5fD?=
 =?iso-8859-2?Q?b1xJlDiCPTfR9Q8lZU+wnudfxQYjbLnG+xOQZcuZ6oG4OydgyncNj7rMuG?=
 =?iso-8859-2?Q?dBvtCHQnE+5yore+hPyxFl5rAwndoDy3my7fWiSzkWK1MrTk0mok5V9g10?=
 =?iso-8859-2?Q?DI/CEyTPQwjUPEwaxhSEGGUtSkTSkOoDh4Zl/0yDJGRmxHfTi9whpCWrW4?=
 =?iso-8859-2?Q?7bvAmxbE04bHNf8Bp3kI/Z5lfhKcW608+AdoIirlz0ZjGqg3ELt0BcPQYg?=
 =?iso-8859-2?Q?r4G/W9l1yzgK3MnqSFoyXqIfiCxeW3HnKiFXm1dmxDaeWYfwpt3pXcqZKQ?=
 =?iso-8859-2?Q?2KYQ92a6ZXNXWUAv2ZVwZU0auvlAM6HyH+1x3qOaH29eDs5w+fLa2ullpv?=
 =?iso-8859-2?Q?LynEOr44BcrLnWVUlbNTKGNjtug9PY3lYKB6xznGrCxqgdkPtvYyJ9BOlD?=
 =?iso-8859-2?Q?ElqG2rIPg7I87nYlvkUlAZa9ew7Ixyh8zlYu/khlJBkacU10GMVte8qpMC?=
 =?iso-8859-2?Q?2LGYrmmqmUE+dkeFbao+XrmDePmQr1r0MEAxHJGLu/j+L2Puq7RwllzHL9?=
 =?iso-8859-2?Q?fSxvbdefVIHMGQWak2v+cvIQSxKtuHXwFqGkPpz4zpKJKNUmlReG7656dI?=
 =?iso-8859-2?Q?fotZ+Q6xgPxGLiOE2UV98fNiSq/goU9BdOmI8DFv+/PPgyEtmnqvE/xGhk?=
 =?iso-8859-2?Q?shYNuNhKYsx87DIi97gFcARJPVQ8EAmZsTGVCa6LXI61JTE5gdpmI4rA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170cb514-42e1-424b-159a-08db37b4317f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 22:05:26.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mATOLE8YpA9PzCKjIhEHDK/9tqC/4Nk94uLFIN1J1FTR8fMwHYr7UVRf38ygE3rSNPBkHLHU+lCP+o6T/2CB+Bg9boOAq9TpGi4pw9acMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3057
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, April 7, 2023 3:56 =
AM
>=20
> On Fri, 31 Mar 2023 21:45:00 -0700
> Michael Kelley <mikelley@microsoft.com> wrote:
>=20
> > swiotlb currently reports the total number of slabs and the instantaneo=
us
> > in-use slabs in debugfs. But with increased usage of swiotlb for all I/=
O
> > in Confidential Computing (coco) VMs, it has become difficult to know
> > how much memory to allocate for swiotlb bounce buffers, either via the
> > automatic algorithm in the kernel or by specifying a value on the
> > kernel boot line. The current automatic algorithm generously allocates
> > swiotlb bounce buffer memory, and may be wasting significant memory in
> > many use cases.
> >
> > To support better understanding of swiotlb usage, add tracking of the
> > the high water mark usage of the default swiotlb bounce buffer memory
> > pool. Report the high water mark in debugfs along with the other swiotl=
b
> > metrics.  Allow the high water mark to be reset to zero at runtime by
> > writing to it.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> > Changes in v3:
> > * Do high water mark accounting only when CONFIG_DEBUG_FS=3Dy. As
> >   as a result, add back the mem_used() function for the "swiotlb
> >   buffer is full" error message. [Christoph -- I didn't hear back
> >   whether this approach addresses your concern about one additional
> >   atomic operation when slots are allocated and again when freed. I've
> >   gone ahead with this new version, and we can obviously have further
> >   discussion.]
> >
> > * Remove unnecessary u64 casts. [Christoph Hellwig]
> >
> > * Track slot usage and the high water mark only for io_tlb_default_mem.
> >   Previous versions incorrectly included per-device pools. [Petr Tesari=
k]
> >
> > Changes in v2:
> > * Only reset the high water mark to zero when the specified new value
> >   is zero, to prevent confusion about the ability to reset to some
> >   other value [Dexuan Cui]
> >
> >  kernel/dma/swiotlb.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index d3d6be0..6587a3d 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -76,6 +76,9 @@ struct io_tlb_slot {
> >  static unsigned long default_nslabs =3D IO_TLB_DEFAULT_SIZE >> IO_TLB_=
SHIFT;
> >  static unsigned long default_nareas;
> >
> > +static atomic_long_t total_used =3D ATOMIC_LONG_INIT(0);
> > +static atomic_long_t used_hiwater =3D ATOMIC_LONG_INIT(0);
> > +
> >  /**
> >   * struct io_tlb_area - IO TLB memory area descriptor
> >   *
> > @@ -594,6 +597,7 @@ static int swiotlb_do_find_slots(struct device *dev=
, int
> area_index,
> >  	unsigned long flags;
> >  	unsigned int slot_base;
> >  	unsigned int slot_index;
> > +	unsigned long old_hiwater, new_used;
> >
> >  	BUG_ON(!nslots);
> >  	BUG_ON(area_index >=3D mem->nareas);
> > @@ -663,6 +667,17 @@ static int swiotlb_do_find_slots(struct device *de=
v, int
> area_index,
> >  		area->index =3D 0;
> >  	area->used +=3D nslots;
> >  	spin_unlock_irqrestore(&area->lock, flags);
> > +
> > +	if (IS_ENABLED(CONFIG_DEBUG_FS) && mem =3D=3D &io_tlb_default_mem) {
>=20
> Yes, this works fine now, but why are total_used and used_hiwater
> global variables? If you make them fields in struct io_tlb_mem
> (possibly guarded with #ifdef CONFIG_DEBUG_FS), you can get rid of the
> check. Of course, in instances other than io_tlb_default_mem these
> fields would not be exported to userspace through debugfs, but if really
> needed, I can at least find them in a crash dump (or read them through
> /proc/kcore).
>=20

Got it.

Your previously comments mentioned making them fields in struct io_tlb_mem,
and I missed your point.  :-(   I got focused on fixing the accounting for
DEBUG_FS so it didn't include the non-default pools, and didn't pick up on =
the
idea of doing the accounting for the non-default pools even though the valu=
es
aren't exposed in /sys.   I'll fix this in the next version.

Michael
