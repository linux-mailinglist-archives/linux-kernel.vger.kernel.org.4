Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6D74BE17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGHPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:18:38 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C915E61;
        Sat,  8 Jul 2023 08:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTT631oSQyKgiGbnsDELKgrQrqAbPfLnV3dYSCm2vv80VnoUZs3DUg5Fan3ohvkw2FXoyX4xP/GTihISc2SHFTqVy1U2O3JQR56+uvr39qhCXdos+Gy6MlxKrtnSdlK4G1bk6Bc7FcBh1Em9YMy6sSCsZBveEJh9FSVG/zwFLMpk/g0qd8qo2O99Bk7OTWmYO/V+OouewYinKdx+yiNmCb0RPnx2qeO4gKNXxQ0lWHTbNn7qZENW4YhX/RRaTkT6126Ohu5I3/An+F6hcv+CioLyM8DazVn5B64jt5n0Wv8DplQGblty29+TEe+P84oCnujPcygsRoBgVK3KY7Yq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTJcv+2jASq2Rdi44amqr3eQks4yE0wbhzlh4aW8TPY=;
 b=MtO5IUUdg7Il6G73sCQP1O6Ur5pvAiBJnpcOpVydyfvo0KgHjjnThdye+j50xUzKm5egnrIVgJilljGADziY40KbjDszaPEIfhWuT8nKgSjQ4KDvtHf+DX/fEc3CQKf+kW25YUrvlwVQY+EX9IcPQ+x1QNbCkHMFUBiUp/cqa8EYDeCp3OQTOL1cJ5t0LaZ6WpOmFJIHp7+VcebtJl3z7M945yLA444fdZOugWRWf2fEwlnL53A5x78SfU0Hbw9IfKDILG0lbB1IFz5jEMx50ttEn8tenI3nsxdO/ZOxtqN7abUfD5urJFewu0+efDYSHHq27k7kD1e0wbz2tOkdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTJcv+2jASq2Rdi44amqr3eQks4yE0wbhzlh4aW8TPY=;
 b=G7buebqiAzy2OTzgNF6ArFzjCK2MopYmADW2VWlI1pHmH8O6HuciMEI2pxQnHg7cs4Xkh2kbrYI2FFfIbnpEkBCQqu383E2SkRDIkJzTl3AhWBZdHMMGFQQ8gu0fqhtYujIrLxc+E8KrLR4SZ9ewLFjpHmPvuceJQudWYYPElQU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1520.namprd21.prod.outlook.com (2603:10b6:208:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.0; Sat, 8 Jul
 2023 15:18:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6609.000; Sat, 8 Jul 2023
 15:18:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Petr Tesarik <petrtesarik@huaweicloud.com>,
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
Thread-Index: AQHZqN4Es6xs27E7q0W1vSuhepPC1q+p0aJAgAKeXgCAAGWX4IABQ5kAgAAO3oCAAduRkA==
Date:   Sat, 8 Jul 2023 15:18:32 +0000
Message-ID: <BYAPR21MB1688D3AC0C094420733717C4D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
        <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
        <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070626-boxcar-bubbly-471d@gregkh>
        <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
        <2023070706-humbling-starfish-c68f@gregkh>
 <20230707122213.3a7378b5@meshulam.tesarici.cz>
In-Reply-To: <20230707122213.3a7378b5@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bbfda968-88bd-4966-b7bb-df0951631493;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-08T14:44:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1520:EE_
x-ms-office365-filtering-correlation-id: 0b1cf401-deec-4f43-9e7b-08db7fc6975a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +agW1rQigQAp0KS7pjnBDE7R65k8Q6YXCTDWBpZVB/njPapJrrAG0GMjhKx+59QaWGDPwiv+zXcp64+XdZX0WsZ5S+mIvVfgDn+Fm+SQ+rvXjqxZCMBrVUPtA59hNM8xDfo0sk7HzbVSLdXr45//0fQZe9qYCYPuiJapPATGDrWgvojr23vLFAC5eJGSW+6c0de9fUHpzgyP5iWVt06KPS4rsi5ZCM1QqTuffDq34LZrSNiB3mh91pkV9BjKwPvi6CzKQ0YV1BqbF47T1/2i8IFK07NBfwyvOK/SKMUVM8bE7V1jHCA+Bs830hODbQZ3ET5anqwEEI/VB0S73250RiHqu6x+4gLhzM85LswKAC1mj73dcDp7BXFn+flFVPPiS9Rc+Mwxt39UMQzQe4//SJJvHrq/kz5s48EWZHkBaOJCgxTWtf01nQWD/BYOE/N0JkLiLyfODAaKn+6SlwZDv0r0TZ6qfWP6mijgv1kvtf3k2kRRf/AwPcVW/EWWRnKQwp77cyrwB8HAeg12LYsCd3ft3ZIMCsJQNrnYUErUP6sV+D+LzoorQZbPRx7ljgOhVkS/h4xtsC7R5BEBo00AI3jW7Jt+l3ITszt0dQ4ajaq6MMfql0+OVqjnjjt423Kqw0rhMZWgJ3FQdUf/8T+0+QUg40s1Zrfw8+e7YiWKpmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(10290500003)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(6506007)(26005)(186003)(9686003)(8990500004)(2906002)(66946007)(41300700001)(316002)(66556008)(66476007)(66446008)(64756008)(4326008)(5660300002)(52536014)(7416002)(8936002)(8676002)(38100700002)(122000001)(82960400001)(82950400001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?17kObggti0B8dMM183+rdgXqPuGvJXCnSzDP6Q49zaYWei9fuUM/GGASJb?=
 =?iso-8859-2?Q?FX/yxa3Z1v8CWfDgZSaH9LEyrYxSX9YiofROXoE5R/24OvJ4x7I21jEnEn?=
 =?iso-8859-2?Q?jpWDwbFWoFZmsYO9YZ/RVMKD98AKXfzPZiwfRqhjqx9B+j236GIxkQSeVG?=
 =?iso-8859-2?Q?FIZrUUebOIOYV4QcMixUCU9o04SS40JJfC/EO7SPdo3uCSK2+8HiMacxeD?=
 =?iso-8859-2?Q?PE9oB0B46F0gR2DY7OM3xBUmK9auaYhTum70zRYsR7s3gT/XQMn+5G1FN/?=
 =?iso-8859-2?Q?LcmphXdF4JVwaDBkwxJXU1tKCz33xBI0YxzDWFfxRu2xs3+QSm5o4loM14?=
 =?iso-8859-2?Q?PNu45zk8JoQNe2qGu9PPomb9JWF+xBJrHXb8w0rpTXgMOrQk7yru9tjLh4?=
 =?iso-8859-2?Q?1WBqbsf4JO9gKPbcZQlsXhAAGh3C9iG+7imc2mzUvnUkhfLfDk5sTQ/KmT?=
 =?iso-8859-2?Q?Wu5Kg+ArpfYNCTwztJJRD0SciNyj4dJhQVVNj5d2BitlAkiHekq4z769AJ?=
 =?iso-8859-2?Q?/agchMF0JHHhpLwUJg8DZ5W0vBkvlwsskwekQyOsExnWhE3V7FZPumRwpq?=
 =?iso-8859-2?Q?FTnekxBe/xln8zWicvA5VeOTJ+yHJIpKohHUWpTXXhNC2L9s8+AkvBlf1C?=
 =?iso-8859-2?Q?mdRFVm5pXto2xCg/Sipq/zHb6olSbq6QMgWwWZitiDcUidENHdnfP10jN+?=
 =?iso-8859-2?Q?Zyp+uPLzHocTw8irYYw0kOgA88Dw4JVm5PF1ToRcEr2ggVmnvEo7dN1OQJ?=
 =?iso-8859-2?Q?Gdt9T0ysemwaq91BItedvJIT9sAFcfYeIUNY9yBatfGEB7mknsFSdEg3p2?=
 =?iso-8859-2?Q?01S0Kqm6WJ3vHf+bdC0k7Q+vHMbN6FqMeMupETtcwxVeFvLqF1hvXfnSi3?=
 =?iso-8859-2?Q?7MQp4HZOl2/EvCdF1CZDUoZik/GBLeWyo6eqrls9Rf54MVebap2fnwdiWq?=
 =?iso-8859-2?Q?AC3p+pNTMtKJ18mSY1N0ceejkhH6mM+UsOuzmDEW0wTjuWZZoB1wudgVVC?=
 =?iso-8859-2?Q?8YnjG1JU0YQPIQ/MHiO1YpzGrKS/BFs8awjd4BakvQNqRdl/DuOGRADUM7?=
 =?iso-8859-2?Q?6FeeWBziZxloUze4SsaP0KEkqCVzFBgIPNExxZwbAZi4rxZfT/HMKz//ns?=
 =?iso-8859-2?Q?xhGIPKuDgy87KCy5nqrI0NZKh4U1L+wMQB7a68NgswXDwLyyXAqfsiD3dv?=
 =?iso-8859-2?Q?imfJtH1Xw9QM4Z33mJeD2RLDN/tlmUTyN6R4IWAIfCoGeqpzc92bmOkjBs?=
 =?iso-8859-2?Q?91RpWbb1Y8KCsCpuFdKs5JvyRbO/Qe2bqX13JLY5Ymzad+F5cFT4cQ/vkc?=
 =?iso-8859-2?Q?aSRL2kLchYCIl5Z7p3AHax8w1V+TcMUNhkQJq/wN7uVl06+c+UkWHI28zR?=
 =?iso-8859-2?Q?8yQqq7lIsBRy5xgns/H+LtiEmnFuPrBzlMf6deTdW3/k0afdVGxPIm72M5?=
 =?iso-8859-2?Q?xGfu9RICEIUtaMtkkclp6pjJ/5uebpW+OIV95R73JGO9x39KuLkQbnYQC+?=
 =?iso-8859-2?Q?fecKJvUTq5zFsCEkTQ8I2ALtIuwwX/RwHKZD0g4kNyvC/mwKKGhZ2JVF12?=
 =?iso-8859-2?Q?RrqJ/btFjU/Pp5Vw4Jwnh1AJLAUnGL/rqvRyeHCafsrMx9rfW3SRm2YhMc?=
 =?iso-8859-2?Q?MKlzSX7nO4Dj+GEO2XwahltVXGZpSGuMVcY0B793UVDTuvO6vYdbCYYQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1cf401-deec-4f43-9e7b-08db7fc6975a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 15:18:32.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4ycpb8hogLp8SWH+CGtF4ANdZx8MLZ3CFoPq+sQ0yX9A+2mMNmP7lHiP0fIoNnHI99eTUolK/qPcR6GTh0EKu062oWJ1cVv3WV2qu8Awt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1520
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, July 7, 2023 3:22 A=
M
>=20
> On Fri, 7 Jul 2023 10:29:00 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > On Thu, Jul 06, 2023 at 02:22:50PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday,=
 July 6,
> 2023 1:07 AM
> > > >
> > > > On Thu, Jul 06, 2023 at 03:50:55AM +0000, Michael Kelley (LINUX) wr=
ote:
> > > > > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, J=
une 27, 2023
> > > > 2:54 AM
> > > > > >
> > > > > > Try to allocate a transient memory pool if no suitable slots ca=
n be found,
> > > > > > except when allocating from a restricted pool. The transient po=
ol is just
> > > > > > enough big for this one bounce buffer. It is inserted into a pe=
r-device
> > > > > > list of transient memory pools, and it is freed again when the =
bounce
> > > > > > buffer is unmapped.
> > > > > >
> > > > > > Transient memory pools are kept in an RCU list. A memory barrie=
r is
> > > > > > required after adding a new entry, because any address within a=
 transient
> > > > > > buffer must be immediately recognized as belonging to the SWIOT=
LB, even if
> > > > > > it is passed to another CPU.
> > > > > >
> > > > > > Deletion does not require any synchronization beyond RCU orderi=
ng
> > > > > > guarantees. After a buffer is unmapped, its physical addresses =
may no
> > > > > > longer be passed to the DMA API, so the memory range of the cor=
responding
> > > > > > stale entry in the RCU list never matches. If the memory range =
gets
> > > > > > allocated again, then it happens only after a RCU quiescent sta=
te.
> > > > > >
> > > > > > Since bounce buffers can now be allocated from different pools,=
 add a
> > > > > > parameter to swiotlb_alloc_pool() to let the caller know which =
memory pool
> > > > > > is used. Add swiotlb_find_pool() to find the memory pool corres=
ponding to
> > > > > > an address. This function is now also used by is_swiotlb_buffer=
(), because
> > > > > > a simple boundary check is no longer sufficient.
> > > > > >
> > > > > > The logic in swiotlb_alloc_tlb() is taken from __dma_direct_all=
oc_pages(),
> > > > > > simplified and enhanced to use coherent memory pools if needed.
> > > > > >
> > > > > > Note that this is not the most efficient way to provide a bounc=
e buffer,
> > > > > > but when a DMA buffer can't be mapped, something may (and will)=
 actually
> > > > > > break. At that point it is better to make an allocation, even i=
f it may be
> > > > > > an expensive operation.
> > > > >
> > > > > I continue to think about swiotlb memory management from the stan=
dpoint
> > > > > of CoCo VMs that may be quite large with high network and storage=
 loads.
> > > > > These VMs are often running mission-critical workloads that can't=
 tolerate
> > > > > a bounce buffer allocation failure.  To prevent such failures, th=
e swiotlb
> > > > > memory size must be overly large, which wastes memory.
> > > >
> > > > If "mission critical workloads" are in a vm that allowes overcommit=
 and
> > > > no control over other vms in that same system, then you have worse
> > > > problems, sorry.
> > > >
> > > > Just don't do that.
> > > >
> > >
> > > No, the cases I'm concerned about don't involve memory overcommit.
> > >
> > > CoCo VMs must use swiotlb bounce buffers to do DMA I/O.  Current swio=
tlb
> > > code in the Linux guest allocates a configurable, but fixed, amount o=
f guest
> > > memory at boot time for this purpose.  But it's hard to know how much
> > > swiotlb bounce buffer memory will be needed to handle peak I/O loads.
> > > This patch set does dynamic allocation of swiotlb bounce buffer memor=
y,
> > > which can help avoid needing to configure an overly large fixed size =
at boot.
> >
> > But, as you point out, memory allocation can fail at runtime, so how ca=
n
> > you "guarantee" that this will work properly anymore if you are going t=
o
> > make it dynamic?
>=20
> In general, there is no guarantee, of course, because bounce buffers
> may be requested from interrupt context. I believe Michael is looking
> for the SWIOTLB_MAY_SLEEP flag that was introduced in my v2 series, so
> new pools can be allocated with GFP_KERNEL instead of GFP_NOWAIT if
> possible, and then there is no need to dip into the coherent pool.
>=20
> Well, I have deliberately removed all complexities from my v3 series,
> but I have more WIP local topic branches in my local repo:
>=20
> - allow blocking allocations if possible
> - allocate a new pool before existing pools are full
> - free unused memory pools
>=20
> I can make a bigger series, or I can send another series as RFC if this
> is desired. ATM I don't feel confident enough that my v3 series will be
> accepted without major changes, so I haven't invested time into
> finalizing the other topic branches.
>=20
> @Michael: If you know that my plan is to introduce blocking allocations
> with a follow-up patch series, is the present approach acceptable?
>=20

Yes, I think the present approach is acceptable as a first step.  But
let me elaborate a bit on my thinking.

I was originally wondering if it is possible for swiotlb_map() to detect
whether it is called from a context that allows sleeping, without the use
of SWIOTLB_MAY_SLEEP.   This would get the benefits without having to
explicitly update drivers to add the flag.  But maybe that's too risky.  Fo=
r
the CoCo VM scenario that I'm most interested in, being a VM implicitly
reduces the set of drivers that are being used, and so it's not that hard
to add the flag in the key drivers that generate most of the bounce
buffer traffic.

Then I was thinking about a slightly different usage for the flag than what
you implemented in v2 of the series.   In the case where swiotlb_map()
can't allocate slots because of the swiotlb pool being full (or mostly full=
),
kick the background thread (if it is not already awake) to allocate a
dynamic pool and grow the total size of the swiotlb.  Then if
SWIOTLB_MAY_SLEEP is *not* set, allocate a transient pool just as you
have implemented in this v3 of the series.  But if SWIOTLB_MAY_SLEEP
*is* set, swiotlb_map() should sleep until the background thread has
completed the memory allocation and grown the size of the swiotlb.
After the sleep, retry the slot allocation.  Maybe what I'm describing
is what you mean by "allow blocking allocations".  :-)

This approach effectively throttles incoming swiotlb requests when space
is exhausted, and gives the dynamic sizing mechanism a chance to catch
up in an efficient fashion.  Limiting transient pools to requests that can'=
t
sleep will reduce the likelihood of exhausting the coherent memory
pools.  And as you mentioned above, kicking the background thread at the
90% full mark (or some such heuristic) also helps the dynamic sizing
mechanism keep up with demand.

Michael




