Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2B749EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjGFOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGFOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:23:01 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085E1BD3;
        Thu,  6 Jul 2023 07:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwhdvMOTCj1pk6YoWX/0vA8V1MM1yW1X+cgckphBoWw18+TH5Wq4fo6sy5T77KA9dxG2QmsFTIED0utRdGSKbFhjMifbh0Yx5wjIefStAvpwxYREUbfvGnyNJp74WgBoV6/zkzgu1ro93YJgZmAqlvDxcv19Yf0ne/v32iCEfyibMuTwXufpKaiV/jiLLwOxN6tiBgOpj2T1iIVTb3yQ6dQ10HKf/K40XhmE4fLUWzyBE9ipz1Q320hp35gTgZ1ChNcQEwbMJY3ERm6nSf+UmZN+ifGu+PzwaTnIZ9jGa/nCal+N25zkuQTZYRzV9dkKMvcBNMMTgKbW9FMKvxbJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG+YaDqOerIORGaH0fUqy7utjqv7UUuWUSk817E/mzg=;
 b=ndEu3JVKgKXySe5MQlXcBi/fbhKlL2O0ptdcmhzZZxiudcIPTbIuVNkdkB7HkH16H+jm5k6aAN4AnE+XU/Bvf+Gbx1R3+7dta0Lcn6aYfG+gC0CCAU0mfxQfTbhB7RQZI28QC+FK6HoyeJmazK9axvEgoJf1S8XHAN5MIikeRHp7Ubrli0RYpTiUsZolPvoEta0+yaUEHgModwpkI6gDAPusar30t15FZF7HmHAh+AOZc0VXj0LuXz8lKc2c9SPM4H5QN6pffvIkThZvUj7YwHPFN99E7t/QoUkv1YcH+JkRqtxD+dBLRm8stD2aC8qqWCyamxXnaxRzoidhuSwbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG+YaDqOerIORGaH0fUqy7utjqv7UUuWUSk817E/mzg=;
 b=BX5CjAB/nwUpSZIB8jmjak4/kZaXQUY83pGmmBzgho/V+8jgYNNr3ujodWzkus5oPCYtGCbxA/qEh6fTt8pO/YEE2JphEFOWikQdRVCbke2dzDhP87v/7JdeiUCoOKtPp1bBq2vejmj/TjBffepZ2mCOmgtFmAzX+kKEmbktEJc=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3493.namprd21.prod.outlook.com (2603:10b6:930:e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.19; Thu, 6 Jul
 2023 14:22:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6588.010; Thu, 6 Jul 2023
 14:22:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "petr@tesarici.cz" <petr@tesarici.cz>
Subject: RE: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Topic: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Index: AQHZqN4Es6xs27E7q0W1vSuhepPC1q+p0aJAgAKeXgCAAGWX4A==
Date:   Thu, 6 Jul 2023 14:22:50 +0000
Message-ID: <BYAPR21MB168802F691D3041C9B2F9F2DD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
 <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
 <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2023070626-boxcar-bubbly-471d@gregkh>
In-Reply-To: <2023070626-boxcar-bubbly-471d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8aa5c53-11c1-447d-8308-ef08c97544cc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T14:10:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3493:EE_
x-ms-office365-filtering-correlation-id: 2aad2f2f-3f4a-4a93-0f5d-08db7e2c7a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffQ8B6GEk16LjgRECqfLARZg2milg373MaXIenId9pbAhydXyqiowRyCuEtSjHvmWz8CslFOoJOdwPPy6TAHIIyoXSAdLEomrjgAA8N1FiJueN6DY+grG3dT4d+N6jYopUIMOEnqe1Iqrh+pF1ji/035vpeLn9UvQe2il3FQvFwP7gPN7A5GakVYyuAKeMkMs5/jGPvmtFRwCQ5r1vzcGlPjd4nL4JoFRjAhzYUm6AC1W5qE+DpwnOsv8vVD07zz0lYyD2yp/DWTSln2UdCoeQGyrlJWngx8eVQ0Qg89zrySEAGmP4CA1IDithsRcKWmZoe+vWp4i0STxWHIy0pcY9qFwUk+huKeBqdpZN6cj9GcTq+XcAlXwZmy5+s6GFj+TCjF7u3nBTMODt+MreNwwWsO6PE5nAilJxZHxTQnXxzy+G8kge8ZxoCz1zXFP3xOqOcc/ViOW/ooSfdK/78KKppj9nd5yLlYz98XzGumO7NmxPwDxQlWY2HO+8SGpMCTHwHebc7G8V/ksw01ZVdPIbOkFyrdPQY1nR0Mru60esT9d6QTRD9DuGgJw0O2bZimJ89U9rbRuBsYDiREBKpYmQo0cxQAjHT4uKUvU9tqus1Ez/Iji8xty6CyQyatRxYFsWJjrPCn26lFYu0iVXdbUpRUtMWhAYUhalaioeZ131Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(71200400001)(54906003)(7696005)(122000001)(478600001)(10290500003)(66556008)(38070700005)(83380400001)(33656002)(55016003)(86362001)(2906002)(26005)(6506007)(76116006)(8990500004)(9686003)(186003)(38100700002)(8676002)(82950400001)(66946007)(316002)(64756008)(66476007)(66446008)(8936002)(4326008)(7416002)(82960400001)(41300700001)(52536014)(5660300002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8C/RmAxRX6jrwILrS+C+xpuXVOlUz8jEfM3RdZheqKoyckjlfp/wxCeq1jOL?=
 =?us-ascii?Q?FNrXHxZNtCjj+NJagqMj26M0rSjNKLVsCyltm/Jv/S1qPrAUgGEqWTh6XcR1?=
 =?us-ascii?Q?vR806vdO8Ig7PBrus6pambxkYYGAt3/0M51g+eWaqotTjeKfwEc8MCIrbkET?=
 =?us-ascii?Q?yAJjVy2FI0idGRTOgwmJdYiktDK3R/QtopWBsCNdgKZ9fNeWCyU1NitH3ZtG?=
 =?us-ascii?Q?Ngfv0/2437QQRzfSAMrijTvjfJX5zz1KIg5jtmbIFs5315bMaMC4XvpcIa2A?=
 =?us-ascii?Q?aijDz4cLhYeFQBf4ScpPtGvfpky7tdeHMu2ZftrNVXk34G8IueVG6suzZowO?=
 =?us-ascii?Q?dOt8u+rOCT9ICTymN2LZrBnhNMUwVS1expBSeeAUtB1xZeTtE1XE3WSVKvKg?=
 =?us-ascii?Q?b4Ih2p8AV4QA/eZ9XbUS3nXW6I1PwxDPq3RfHynyA5hqJdSCjN5Qudb3j3ld?=
 =?us-ascii?Q?DVABO2RYPb2C4xKQHcg/s12CeJd9lwi3AifLKkf2x/wX3UmNiSjqmyMjwGH8?=
 =?us-ascii?Q?X3sxiu+GD3jy11Bu+urz9kfLQ3+oQf+1bse+caWr/UOD/707kJpAzxFVCRee?=
 =?us-ascii?Q?QVI77dl+NQDLSDL8qUkTgTpH10QgVWCzCPLUNaNQokOihcxW+oI3VOs7+zzj?=
 =?us-ascii?Q?mgJZzOBA/3QzNnvz2rjF979iDLhYBHNLEJlDIf1QkNmgEo5eCS87Lbolzgm5?=
 =?us-ascii?Q?2RFJxbaUAsVicTtTr3toRmSRdfmnoHtJ3/72Y+Bk8hlmLx38Fu1YJqR9riq3?=
 =?us-ascii?Q?rCLYuIV4cHYylQhJY+PtZNUnbO4hRER6FQDGAZeObSfdMnmubjD/Y2caKjls?=
 =?us-ascii?Q?9e8TJ3QTz3ZdwiUBRwjC0cmEPDcbkX2FYkbjFAI0yU511Qm/F7Yj93mmWYQE?=
 =?us-ascii?Q?4XI2O6pYAwH4LQ61OjlvRqkxVfEFNs8WpiHZ5zfcRhXvnnreaFSqPb2S3TjV?=
 =?us-ascii?Q?Tuwg1niNEo3cBrOeYFq+SoZ6kX0O1dxJ3GR5xUc+JPEblRPO8HyBHhQyT9Qx?=
 =?us-ascii?Q?ohCq1i5HAKieEJyip+Kj6aiIFz3XuGleFYeXHS012B2NguRM3G6Wa1hodhNx?=
 =?us-ascii?Q?keYoBqoK1DpyG6WtL3V9nW8WIhTvvzxvfxWjggIAxxkYWnwo6eW1R+Ukj2a9?=
 =?us-ascii?Q?yiqMH20LgWjvWyhYSfVlYdWM/V8hcdXEBwGArvi6as0+zEcgs1+XNxZO4wnx?=
 =?us-ascii?Q?mII7SKLN6oiEX4pKspIfTxYi5Q2PFkW4OVTJR7v4N1muFKMkRvbWMlgZIpn+?=
 =?us-ascii?Q?X7UN7YkPeAvP2KPaDkph3HqQbcQXiS/LDYjoar/Q99xpKxE7N0Mk0A4WTJ3f?=
 =?us-ascii?Q?rWycxmCWILHlOMsm6KmzrNEsIXAdR1Upi2vYSMQBwjWG9OYgEC0f/y1Dip+z?=
 =?us-ascii?Q?averv8YToXbJ7Jf4O9gR5GoYDSiWCtdgwXxoN3qWIS5JEsF8G7FU4fRlwTCC?=
 =?us-ascii?Q?b8MM8oNO1v/eTC0O+4MUROzlHonkc0uEmtKwrcFL3lsCFC1/kGhakhezEGM4?=
 =?us-ascii?Q?LUzVWweOmKMFsC+iA9384d7SNCzPhmvjNnjktdQEZ6CrKf8lUverIaxTxSNq?=
 =?us-ascii?Q?d9S3cFLVzVdOoM2cnKcWI1/pT47njF1ZZEMprTYyGYN/Lp0V3OFObKDZEjaP?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aad2f2f-3f4a-4a93-0f5d-08db7e2c7a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:22:50.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqFDnJYrC3LQC9s/7hcOB4tP41bB/DlWxzkQUJ0CSsmiPR3HPjjgb5lGqUiN4d+9ahRtC3W7Vc5xrCP1s7UEelf8bvq0Nc35AfvfI/KqtAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday, July =
6, 2023 1:07 AM
>=20
> On Thu, Jul 06, 2023 at 03:50:55AM +0000, Michael Kelley (LINUX) wrote:
> > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, June 27=
, 2023
> 2:54 AM
> > >
> > > Try to allocate a transient memory pool if no suitable slots can be f=
ound,
> > > except when allocating from a restricted pool. The transient pool is =
just
> > > enough big for this one bounce buffer. It is inserted into a per-devi=
ce
> > > list of transient memory pools, and it is freed again when the bounce
> > > buffer is unmapped.
> > >
> > > Transient memory pools are kept in an RCU list. A memory barrier is
> > > required after adding a new entry, because any address within a trans=
ient
> > > buffer must be immediately recognized as belonging to the SWIOTLB, ev=
en if
> > > it is passed to another CPU.
> > >
> > > Deletion does not require any synchronization beyond RCU ordering
> > > guarantees. After a buffer is unmapped, its physical addresses may no
> > > longer be passed to the DMA API, so the memory range of the correspon=
ding
> > > stale entry in the RCU list never matches. If the memory range gets
> > > allocated again, then it happens only after a RCU quiescent state.
> > >
> > > Since bounce buffers can now be allocated from different pools, add a
> > > parameter to swiotlb_alloc_pool() to let the caller know which memory=
 pool
> > > is used. Add swiotlb_find_pool() to find the memory pool correspondin=
g to
> > > an address. This function is now also used by is_swiotlb_buffer(), be=
cause
> > > a simple boundary check is no longer sufficient.
> > >
> > > The logic in swiotlb_alloc_tlb() is taken from __dma_direct_alloc_pag=
es(),
> > > simplified and enhanced to use coherent memory pools if needed.
> > >
> > > Note that this is not the most efficient way to provide a bounce buff=
er,
> > > but when a DMA buffer can't be mapped, something may (and will) actua=
lly
> > > break. At that point it is better to make an allocation, even if it m=
ay be
> > > an expensive operation.
> >
> > I continue to think about swiotlb memory management from the standpoint
> > of CoCo VMs that may be quite large with high network and storage loads=
.
> > These VMs are often running mission-critical workloads that can't toler=
ate
> > a bounce buffer allocation failure.  To prevent such failures, the swio=
tlb
> > memory size must be overly large, which wastes memory.
>=20
> If "mission critical workloads" are in a vm that allowes overcommit and
> no control over other vms in that same system, then you have worse
> problems, sorry.
>=20
> Just don't do that.
>=20

No, the cases I'm concerned about don't involve memory overcommit.

CoCo VMs must use swiotlb bounce buffers to do DMA I/O.  Current swiotlb
code in the Linux guest allocates a configurable, but fixed, amount of gues=
t
memory at boot time for this purpose.  But it's hard to know how much
swiotlb bounce buffer memory will be needed to handle peak I/O loads.
This patch set does dynamic allocation of swiotlb bounce buffer memory,
which can help avoid needing to configure an overly large fixed size at boo=
t.

Michael
