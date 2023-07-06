Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1A749476
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGFDvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGFDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:51:03 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895019BD;
        Wed,  5 Jul 2023 20:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz5ncPKoNIEylk7JFXusCVzyuedqPPXKpDgSI+RS9cHSnBCOQGlKk3y8sv+/DUveDv0bVtZN1a5Fu2i8mcSf0/5gj5zGBumZKyPpUbyDqZCjk/+aErYdkm6wioJ/X7Lpj3YhrzZDQcEKSXpvUjPzok3H/IbZky0klQpah2XtMJX1/md4e5cBu5+g0oPPtNULQALSmpvhHeTOT+oMoiUMMkQBfMAMDwIMv1DJ5dZ/AglSORfoLSN1ToPGLn52Z4G7OiWl06jpGJUTvJ0pIfc4VrClFyqzfuMUftI3+ueg/O9UwbX2Ut8bzf/IHTDRpbuYJXIFPI6US2a7bYqUn7YJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1zbsxGPrJMiTo/S/Ks0ebDluwilIcyqNnqUC0ir39k=;
 b=Ail+0IJehakkj1Zod0fPQHg1yQShl9TDakZSyxOf6oyBoB9yx28LbcxyjOSCzMPqnzqQQbyI8vdDPvnjdz+g+oWOVsWfNhInLT4LOxnIjoRtlXdNNDqgfwj/Ef+A8wsDqHz+9AD2626XF+5Z6jff69y5l/4Aj+ntqZWA+jRrJJ0GVLrS8DDpVbdS6+S+UqXOXgiHjytEdyn3ya6gkOb2BDOtYqoJaprgCXrZQbPD+yGo0dcXTcZsEYStTmWhHjKnduNmkVSykKf7TCGkeXygnUPFVCBnhut8Q92Qp1mlHMFKfR+JiMC4Hlyu5djeK6IYpAWOZMy6HbmpkebbYhXsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1zbsxGPrJMiTo/S/Ks0ebDluwilIcyqNnqUC0ir39k=;
 b=FHhBy+e+4a8aPoFnDSCHi7WbgFEopIjIOxsdEdECY3cgMry8kknLGrq4HRuAMbNvB3/V9YEr9mMapOkyx6qA6FVGv+aUCqVev/7G2aH2mAk7ktf4L5rUo62f9dyXZeWfj5Dplid8gmLVBGxV3IB+msMdBm4MxUGmxBy4oYLn7V4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3538.namprd21.prod.outlook.com (2603:10b6:8:a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Thu, 6 Jul
 2023 03:50:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Thu, 6 Jul 2023
 03:50:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>
CC:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "petr@tesarici.cz" <petr@tesarici.cz>
Subject: RE: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Topic: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a
 transient memory pool
Thread-Index: AQHZqN4Es6xs27E7q0W1vSuhepPC1q+p0aJA
Date:   Thu, 6 Jul 2023 03:50:55 +0000
Message-ID: <BYAPR21MB1688AAC65852E75764F53099D72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
 <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a10c81ad-217e-4ea7-9f38-c5cae7c29d67;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T16:07:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3538:EE_
x-ms-office365-filtering-correlation-id: cddab2e1-cf6d-4306-1e20-08db7dd433d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAH/4sOy5ewwQd2xsz2DYpBmsKFdtJQFBXVz72AcKc8CHjaG8urFZuLXk1bozQQbLq8sQSMARq80e2aD+XNdJsNXtrnv2iO3Zk1ajVnPswpKVjApQ75RCF2GLvQ8uhFEFAwXz0n1mvEqm3ivdp1e8OP9Fyy2hKS0RC8EuUFFUJyEKQT9Op1hefXPTEWaO9sIvyx6O6Zh0yEuyGmUG42+5Mhkp90UXNLENJExeiY/tPisQCKNNQ+v7Cu9VX45HhXAXyIkzwwDlgLy0Et3bgE0ekebuqM6OXM8VFXraGMMW3Rj7IaF6vrwQ2qgohteE06oLsw8J7BgJY+jC3AdKHFskzppG04EXtTRfuzcusErI0pZqNRz+V7/LyiahM0zrd9WCJCAuq+O7X6LhxKdvSnaS4wwLbNgyiP3Gl+j8pqnZbNgCm9vXkkSu1171/5O/nBW9oLKzK8WDxrtIKCM3f6zSTyRODaCccnx6Z+z+J0MKp06NHU+58VqbQf7xDXmyHbp9OSbi/9Zpnjbgxf9hRJ6tT9+FGfyDGKsn+Dky8Bwqd8D22zlQmYU8p++uiBN4+i98lYs4neZ1DOH0/cOKF1Kl+tqE6JakRxImZGkftf5AQ8zEcu0YcrVg/Q5FveKUHo2+Bi47YvVaC+9BVkDrfAL7JGQDergh9L3UAiF5seTx+R9KRDwqrfT4W4TI9mBer7dThx2kzTwDUVVf6CVttT/+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(4326008)(316002)(86362001)(64756008)(26005)(66946007)(186003)(66556008)(76116006)(9686003)(66446008)(6506007)(66476007)(8990500004)(82950400001)(82960400001)(83380400001)(921005)(122000001)(2906002)(38100700002)(30864003)(7696005)(33656002)(71200400001)(5660300002)(52536014)(10290500003)(478600001)(54906003)(8676002)(110136005)(41300700001)(38070700005)(8936002)(7416002)(55016003)(579004)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WbzUp58HEqcsE8tJDgA2nJNT653vcfg3NRvs1OnAoehLuuyXquobDaA6ibT0?=
 =?us-ascii?Q?NTHMRcqxwMD1oEAj6Uth3kYV6fKPIAAhs0oljzDiOwFJikLKu2jEYj/X9/A1?=
 =?us-ascii?Q?Txp4SCnyYJt9oPmKCRP77m2hlocGz2nEyoFE15aPZXhKpZXEwF8hv8ELI7/x?=
 =?us-ascii?Q?Fk4lVuzE9tvKQkANc3CWSqDnOlc0TFiU1lLt5ZGwJiSqbgQ4rohf/NZgD6Lx?=
 =?us-ascii?Q?DGD3KFnR3OCt1mGasj6dphDC+N5PQlS2Mcz/Z9yllW5STtkzQgwHfmc83sIB?=
 =?us-ascii?Q?DT+1ATscssymcEy4UUXNx/qJCIJ4OSh5p7flYiKef9yIvLAoXU7v/yyLVjF1?=
 =?us-ascii?Q?o1Nho1NFHTV57HU8ZEmefa9z+bWfOs35YEUj7RGDm/DOQA+cPm2gkmKnvHcZ?=
 =?us-ascii?Q?f2UTKlhR4ueHYk6ZeUcjpjQzvNw/+PbdqmMMDZmb0vuTx2voDBve9e+YL9au?=
 =?us-ascii?Q?OItwBoyzLVNgpa86Le98gwXH/FSyBbuj1g8KJLOWFED07bSkHe6rZBTCTZsv?=
 =?us-ascii?Q?8Y7/DFuf7OIO4NmoAVzTjWjrEUKEfAK9uIx5RSe6paALKFnveNugqOdYF4gs?=
 =?us-ascii?Q?Ix5iRWZplvJ/mI68N+ftGbbrPDiSTzkZlLZLYmNZYySeGvVXkv+4M2iRkZLI?=
 =?us-ascii?Q?rmIOUKvCktUJeAXyQfg1VpPKiEnopJgi2PRVhnu8etMjQ32woJgTlTwhpIpQ?=
 =?us-ascii?Q?lSQxK+6SYy+k3SWoMa1cuFUjXBqnF1vUAwsvvtu5BfuYxqoGiS9KTEbtcKrt?=
 =?us-ascii?Q?twI9mrWCC4SRt18Et8FoT8Fptx4jVbjssuX5a2UwwBPhd928iQEvNksnJJkC?=
 =?us-ascii?Q?FJ25ML8v86buotvonouy57EacgPRMSBhLXBeuqpW4zcY9iMUO93ipWTqCBmK?=
 =?us-ascii?Q?IUR4pNHJ5pia8g4SE2NjhltieBzHhMAaXdAXraMtE/ww9p42rym86pIQXbNY?=
 =?us-ascii?Q?mYGhGjPlQnGbVRX/fmOJMB5LFYwGLUK9Ts4oqHfH62KLueCV46hydo8bIpGN?=
 =?us-ascii?Q?ZJjsVnguplboc8+mZEBgS/IQPJ7/nul09USdPDZ1qPB8/swJzqQI6JOQg0/Z?=
 =?us-ascii?Q?Hqt7xu9bJg1cDSjoLqsCDfdPflX9bZse8s/hvqMUNFhKYUpqr8V50tILpkoR?=
 =?us-ascii?Q?LMz3ErxLvO+1hQKS0nziCO8SjS34xOjPClXN0QYxwOHzUmvNCbMQm0tfCmpi?=
 =?us-ascii?Q?eZW56xlHeJtEM8i5l4e6fMGBhSdd0p8pcczxI92JHmdxSUBzbA8jzeBY2DsI?=
 =?us-ascii?Q?v8Y11tmxHWmLrStQY5bFphIcAHmqG/r3ZytAjt0NNYVo3GAzH844/irczClU?=
 =?us-ascii?Q?unUqxcG0TrMZ5P0j7jUzdhhnobTrSHHHiK0OXypK9oqx1yuDO5/TnAYVs1nb?=
 =?us-ascii?Q?v2VPq/BzuomdqaH6iq2BzGalHnQP4eZkrtD9YTLPZWg1SA2D4+aSITs4tIEP?=
 =?us-ascii?Q?sBvFmzp+Og2yjX6/WZ7HVnxd18TTfJKLJ3lSafZQBXyxnxm1jhpaS9lpT5vN?=
 =?us-ascii?Q?QKsHlCvzvpG6VQQgcuvB31e48tHH7dnX/yTQvqT5t8pWzcOwDQaPlIqVdCFD?=
 =?us-ascii?Q?HXNAIBCDDLRLmTaj3MI8wQtG/nN4XvZEMK+WkqnoYm+Gub3sVzLnTevbbXoW?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddab2e1-cf6d-4306-1e20-08db7dd433d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 03:50:55.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psHbcPHMKSymoQmaGty3EIrzhOFH9mBc5FFzkNgasGdLOuhHmBCxuD/jmXd+ciaATfd+uAQmlNA5Q92heKGCJstb2MPEC05vzATkv6GdfWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, June 27, 20=
23 2:54 AM
>=20
> Try to allocate a transient memory pool if no suitable slots can be found=
,
> except when allocating from a restricted pool. The transient pool is just
> enough big for this one bounce buffer. It is inserted into a per-device
> list of transient memory pools, and it is freed again when the bounce
> buffer is unmapped.
>=20
> Transient memory pools are kept in an RCU list. A memory barrier is
> required after adding a new entry, because any address within a transient
> buffer must be immediately recognized as belonging to the SWIOTLB, even i=
f
> it is passed to another CPU.
>=20
> Deletion does not require any synchronization beyond RCU ordering
> guarantees. After a buffer is unmapped, its physical addresses may no
> longer be passed to the DMA API, so the memory range of the corresponding
> stale entry in the RCU list never matches. If the memory range gets
> allocated again, then it happens only after a RCU quiescent state.
>=20
> Since bounce buffers can now be allocated from different pools, add a
> parameter to swiotlb_alloc_pool() to let the caller know which memory poo=
l
> is used. Add swiotlb_find_pool() to find the memory pool corresponding to
> an address. This function is now also used by is_swiotlb_buffer(), becaus=
e
> a simple boundary check is no longer sufficient.
>=20
> The logic in swiotlb_alloc_tlb() is taken from __dma_direct_alloc_pages()=
,
> simplified and enhanced to use coherent memory pools if needed.
>=20
> Note that this is not the most efficient way to provide a bounce buffer,
> but when a DMA buffer can't be mapped, something may (and will) actually
> break. At that point it is better to make an allocation, even if it may b=
e
> an expensive operation.

I continue to think about swiotlb memory management from the standpoint
of CoCo VMs that may be quite large with high network and storage loads.
These VMs are often running mission-critical workloads that can't tolerate
a bounce buffer allocation failure.  To prevent such failures, the swiotlb
memory size must be overly large, which wastes memory.

Your new approach helps by using the coherent memory pools as an overflow
space.   But in a lot of ways, it only pushes the problem around.  As you
noted in your cover letter, reducing the initial size of the swiotlb might
require increasing the size of the coherent pools.

What might be really useful is to pend bounce buffer requests while the
new worker thread is adding more swiotlb pools.  Of course, requests made
from interrupt level can't be pended, but at least in my experience with la=
rge
CoCo VMs, storage I/O is the biggest consumer of bounce buffers.  A lot
(most?) storage requests make the swiotlb_map() call in a context where
it is OK to pend.   If the coherent pool overflow space is could be used on=
ly
for swiotlb_map() calls that can't pend, it's more likely to be sufficient =
to
bridge the gap until new pools are added.

Could swiotlb code detect if it's OK to pend, and then pend a bounce
buffer request until the worker thread adds a new pool?  Even an overly
conversative check would help reduce pressure on the coherent pools
as overflow space.

Michael

>=20
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  include/linux/device.h      |   4 +
>  include/linux/dma-mapping.h |   2 +
>  include/linux/swiotlb.h     |  13 +-
>  kernel/dma/direct.c         |   2 +-
>  kernel/dma/swiotlb.c        | 265 ++++++++++++++++++++++++++++++++++--
>  5 files changed, 272 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 83081aa99e6a..a1ee4c5924b8 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -510,6 +510,8 @@ struct device_physical_location {
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
>   * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
> + * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
> + * @dma_io_tlb_lock:	Protects changes to the list of active pools.
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @fwnode:	Associated device node supplied by platform firmware.
> @@ -615,6 +617,8 @@ struct device {
>  #endif
>  #ifdef CONFIG_SWIOTLB
>  	struct io_tlb_mem *dma_io_tlb_mem;
> +	struct list_head dma_io_tlb_pools;
> +	spinlock_t dma_io_tlb_lock;
>  #endif
>  	/* arch specific additions */
>  	struct dev_archdata	archdata;
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0ee20b764000..c36c5a546787 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -417,6 +417,8 @@ static inline void dma_sync_sgtable_for_device(struct=
 device
> *dev,
>  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h,=
 s, 0)
>  #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0=
)
>=20
> +bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
> +
>  static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 0aa6868cb68c..ae1688438850 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -63,6 +63,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t =
phys,
>=20
>  /**
>   * struct io_tlb_pool - IO TLB memory pool descriptor
> + * @node:	Member of the IO TLB memory pool list.
>   * @start:	The start address of the swiotlb memory pool. Used to do a qu=
ick
>   *		range check to see if the memory was in fact allocated by this
>   *		API.
> @@ -77,22 +78,27 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_=
t
> phys,
>   *		see setup_io_tlb_npages().
>   * @used:	The number of used IO TLB slots.
>   * @late_alloc:	%true if allocated using the page allocator.
> + * @transient:  %true if transient memory pool.
>   * @nareas:	Number of areas in the pool.
>   * @area_nslabs: Number of slots in each area.
>   * @areas:	Array of memory area descriptors.
>   * @slots:	Array of slot descriptors.
> + * @rcu:	RCU head for swiotlb_dyn_free().
>   */
>  struct io_tlb_pool {
> +	struct list_head node;
>  	phys_addr_t start;
>  	phys_addr_t end;
>  	void *vaddr;
>  	unsigned long nslabs;
>  	unsigned long used;
>  	bool late_alloc;
> +	bool transient;
>  	unsigned int nareas;
>  	unsigned int area_nslabs;
>  	struct io_tlb_area *areas;
>  	struct io_tlb_slot *slots;
> +	struct rcu_head rcu;
>  };
>=20
>  /**
> @@ -120,6 +126,8 @@ struct io_tlb_mem {
>  #endif
>  };
>=20
> +struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t pa=
ddr);
> +
>  /**
>   * is_swiotlb_buffer() - check if a physical address belongs to a swiotl=
b
>   * @dev:        Device which has mapped the buffer.
> @@ -133,9 +141,8 @@ struct io_tlb_mem {
>   */
>  static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t pad=
dr)
>  {
> -	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> -
> -	return mem && paddr >=3D mem->pool->start && paddr < mem->pool->end;
> +	return dev->dma_io_tlb_mem &&
> +		!!swiotlb_find_pool(dev, paddr);
>  }
>=20
>  static inline bool is_swiotlb_force_bounce(struct device *dev)
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5595d1d5cdcc..820561cab38d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -66,7 +66,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device =
*dev,
> u64 *phys_limit)
>  	return 0;
>  }
>=20
> -static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t=
 size)
> +bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
>  	dma_addr_t dma_addr =3D phys_to_dma_direct(dev, phys);
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4c5de91bda57..06b4fa7c2e9b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -35,6 +35,7 @@
>  #include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
> +#include <linux/rculist.h>
>  #include <linux/scatterlist.h>
>  #include <linux/set_memory.h>
>  #include <linux/spinlock.h>
> @@ -500,6 +501,157 @@ void __init swiotlb_exit(void)
>  	memset(mem, 0, sizeof(*mem));
>  }
>=20
> +/**
> + * alloc_dma_pages() - allocate pages to be used for DMA
> + * @gfp:	GFP flags for the allocation.
> + * @bytes:	Size of the buffer.
> + *
> + * Allocate pages from the buddy allocator. If successful, make the allo=
cated
> + * pages decrypted that they can be used for DMA.
> + *
> + * Return: Decrypted pages, or %NULL on failure.
> + */
> +static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
> +{
> +	unsigned int order =3D get_order(bytes);
> +	struct page *page;
> +	void *vaddr;
> +
> +	page =3D alloc_pages(gfp, order);
> +	if (!page)
> +		return NULL;
> +
> +	vaddr =3D page_address(page);
> +	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes))) {
> +		__free_pages(page, order);
> +		return NULL;
> +	}
> +
> +	return page;
> +}
> +
> +/**
> + * swiotlb_alloc_tlb() - allocate a dynamic IO TLB buffer
> + * @dev:	Device for which a memory pool is allocated.
> + * @bytes:	Size of the buffer.
> + * @phys_limit:	Maximum allowed physical address of the buffer.
> + * @gfp:	GFP flags for the allocation.
> + *
> + * Return: Allocated pages, or %NULL on allocation failure.
> + */
> +static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> +		u64 phys_limit, gfp_t gfp)
> +{
> +	struct page *page;
> +
> +	/*
> +	 * Allocate from the atomic pools if memory is encrypted and
> +	 * the allocation is atomic, because decrypting may block.
> +	 */
> +	if (dev && force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))=
 {
> +		void *vaddr;
> +
> +		return IS_ENABLED(CONFIG_DMA_COHERENT_POOL)
> +			? dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +					      dma_coherent_ok)
> +			: NULL;
> +	}
> +
> +	gfp &=3D ~GFP_ZONEMASK;
> +	if (phys_limit <=3D DMA_BIT_MASK(zone_dma_bits))
> +		gfp |=3D __GFP_DMA;
> +	else if (phys_limit <=3D DMA_BIT_MASK(32))
> +		gfp |=3D __GFP_DMA32;
> +
> +	while ((page =3D alloc_dma_pages(gfp, bytes)) &&
> +	       page_to_phys(page) + bytes - 1 > phys_limit) {
> +		/* allocated, but too high */
> +		__free_pages(page, get_order(bytes));
> +
> +		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> +		    phys_limit < DMA_BIT_MASK(64) &&
> +		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
> +			gfp |=3D __GFP_DMA32;
> +		else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> +			 !(gfp & __GFP_DMA))
> +			gfp =3D (gfp & ~__GFP_DMA32) | __GFP_DMA;
> +		else
> +			return NULL;
> +	}
> +
> +	return page;
> +}
> +
> +/**
> + * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
> + * @vaddr:	Virtual address of the buffer.
> + * @bytes:	Size of the buffer.
> + */
> +static void swiotlb_free_tlb(void *vaddr, size_t bytes)
> +{
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    dma_free_from_pool(NULL, vaddr, bytes))
> +		return;
> +
> +	/* Intentional leak if pages cannot be encrypted again. */
> +	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> +		__free_pages(virt_to_page(vaddr), get_order(bytes));
> +}
> +
> +/**
> + * swiotlb_alloc_pool() - allocate a new IO TLB memory pool
> + * @dev:	Device for which a memory pool is allocated.
> + * @nslabs:	Desired number of slabs.
> + * @phys_limit:	Maximum DMA buffer physical address.
> + * @gfp:	GFP flags for the allocations.
> + *
> + * Allocate and initialize a new IO TLB memory pool.
> + *
> + * Return: New memory pool, or %NULL on allocation failure.
> + */
> +static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
> +		unsigned int nslabs, u64 phys_limit, gfp_t gfp)
> +{
> +	struct io_tlb_pool *pool;
> +	struct page *tlb;
> +	size_t pool_size;
> +	size_t tlb_size;
> +
> +	pool_size =3D sizeof(*pool) + array_size(sizeof(*pool->areas), 1) +
> +		array_size(sizeof(*pool->slots), nslabs);
> +	pool =3D kzalloc(pool_size, gfp);
> +	if (!pool)
> +		goto error;
> +	pool->areas =3D (void *)pool + sizeof(*pool);
> +	pool->slots =3D (void *)pool->areas + sizeof(*pool->areas);
> +
> +	tlb_size =3D nslabs << IO_TLB_SHIFT;
> +	tlb =3D swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp);
> +	if (!tlb)
> +		goto error_tlb;
> +
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, 1);
> +	return pool;
> +
> +error_tlb:
> +	kfree(pool);
> +error:
> +	return NULL;
> +}
> +
> +/**
> + * swiotlb_dyn_free() - RCU callback to free a memory pool
> + * @rcu:	RCU head in the corresponding struct io_tlb_pool.
> + */
> +static void swiotlb_dyn_free(struct rcu_head *rcu)
> +{
> +	struct io_tlb_pool *pool =3D container_of(rcu, struct io_tlb_pool, rcu)=
;
> +	size_t tlb_size =3D pool->end - pool->start;
> +
> +	swiotlb_free_tlb(pool->vaddr, tlb_size);
> +	kfree(pool);
> +}
> +
>  /**
>   * swiotlb_dev_init() - initialize swiotlb fields in &struct device
>   * @dev:	Device to be initialized.
> @@ -507,6 +659,56 @@ void __init swiotlb_exit(void)
>  void swiotlb_dev_init(struct device *dev)
>  {
>  	dev->dma_io_tlb_mem =3D &io_tlb_default_mem;
> +	INIT_LIST_HEAD(&dev->dma_io_tlb_pools);
> +	spin_lock_init(&dev->dma_io_tlb_lock);
> +}
> +
> +/**
> + * swiotlb_find_pool() - find the IO TLB pool for a physical address
> + * @dev:        Device which has mapped the DMA buffer.
> + * @paddr:      Physical address within the DMA buffer.
> + *
> + * Find the IO TLB memory pool descriptor which contains the given physi=
cal
> + * address, if any.
> + *
> + * Return: Memory pool which contains @paddr, or %NULL if none.
> + */
> +struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t pa=
ddr)
> +{
> +	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> +	struct io_tlb_pool *pool =3D mem->pool;
> +
> +	if (paddr >=3D pool->start && paddr < pool->end)
> +		return pool;
> +
> +	/* Pairs with smp_wmb() in swiotlb_find_slots(). */
> +	smp_rmb();
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &dev->dma_io_tlb_pools, node) {
> +		if (paddr >=3D pool->start && paddr < pool->end)
> +			goto out;
> +	}
> +	pool =3D NULL;
> +out:
> +	rcu_read_unlock();
> +	return pool;
> +}
> +
> +/**
> + * swiotlb_del_pool() - remove an IO TLB pool from a device
> + * @dev:	Owning device.
> + * @pool:	Memory pool to be removed.
> + */
> +static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *poo=
l)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->dma_io_tlb_lock, flags);
> +	list_del_rcu(&pool->node);
> +	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
> +
> +	call_rcu(&pool->rcu, swiotlb_dyn_free);
>  }
>=20
>  /*
> @@ -523,7 +725,7 @@ static unsigned int swiotlb_align_offset(struct devic=
e *dev, u64
> addr)
>  static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, siz=
e_t size,
>  			   enum dma_data_direction dir)
>  {
> -	struct io_tlb_pool *mem =3D dev->dma_io_tlb_mem->pool;
> +	struct io_tlb_pool *mem =3D swiotlb_find_pool(dev, tlb_addr);
>  	int index =3D (tlb_addr - mem->start) >> IO_TLB_SHIFT;
>  	phys_addr_t orig_addr =3D mem->slots[index].orig_addr;
>  	size_t alloc_size =3D mem->slots[index].alloc_size;
> @@ -796,6 +998,7 @@ static int pool_find_slots(struct device *dev, struct=
 io_tlb_pool
> *pool,
>   * @alloc_size: Total requested size of the bounce buffer,
>   *		including initial alignment padding.
>   * @alloc_align_mask:	Required alignment of the allocated buffer.
> + * @retpool:	Used memory pool, updated on return.
>   *
>   * Search through the whole software IO TLB to find a sequence of slots =
that
>   * match the allocation constraints.
> @@ -803,10 +1006,46 @@ static int pool_find_slots(struct device *dev, str=
uct
> io_tlb_pool *pool,
>   * Return: Index of the first allocated slot, or -1 on error.
>   */
>  static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> -		size_t alloc_size, unsigned int alloc_align_mask)
> +		size_t alloc_size, unsigned int alloc_align_mask,
> +		struct io_tlb_pool **retpool)
>  {
> -	return pool_find_slots(dev, dev->dma_io_tlb_mem->pool, orig_addr,
> -			       alloc_size, alloc_align_mask);
> +	struct io_tlb_pool *pool;
> +	unsigned long flags;
> +	u64 phys_limit;
> +	int index;
> +
> +	pool =3D dev->dma_io_tlb_mem->pool;
> +	index =3D pool_find_slots(dev, pool, orig_addr,
> +				alloc_size, alloc_align_mask);
> +	if (index >=3D 0)
> +		goto found;
> +
> +	if (dev->dma_io_tlb_mem->for_alloc)
> +		return -1;
> +
> +	phys_limit =3D min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit)=
;
> +	pool =3D swiotlb_alloc_pool(dev, nr_slots(alloc_size), phys_limit,
> +				  GFP_NOWAIT | __GFP_NOWARN);
> +	if (!pool)
> +		return -1;
> +
> +	index =3D pool_find_slots(dev, pool, orig_addr,
> +				alloc_size, alloc_align_mask);
> +	if (index < 0) {
> +		swiotlb_dyn_free(&pool->rcu);
> +		return -1;
> +	}
> +
> +	pool->transient =3D true;
> +	spin_lock_irqsave(&dev->dma_io_tlb_lock, flags);
> +	list_add_rcu(&pool->node, &dev->dma_io_tlb_pools);
> +	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
> +
> +	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
> +	smp_wmb();
> +found:
> +	*retpool =3D pool;
> +	return index;
>  }
>=20
>  /**
> @@ -869,7 +1108,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *de=
v,
> phys_addr_t orig_addr,
>  	}
>=20
>  	index =3D swiotlb_find_slots(dev, orig_addr,
> -				   alloc_size + offset, alloc_align_mask);
> +				   alloc_size + offset, alloc_align_mask, &pool);
>  	if (index =3D=3D -1) {
>  		if (!(attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
> @@ -883,7 +1122,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *de=
v,
> phys_addr_t orig_addr,
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> -	pool =3D mem->pool;
>  	for (i =3D 0; i < nr_slots(alloc_size + offset); i++)
>  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
>  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> @@ -900,7 +1138,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *de=
v,
> phys_addr_t orig_addr,
>=20
>  static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_ad=
dr)
>  {
> -	struct io_tlb_pool *mem =3D dev->dma_io_tlb_mem->pool;
> +	struct io_tlb_pool *mem =3D swiotlb_find_pool(dev, tlb_addr);
>  	unsigned long flags;
>  	unsigned int offset =3D swiotlb_align_offset(dev, tlb_addr);
>  	int index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> @@ -954,6 +1192,8 @@ void swiotlb_tbl_unmap_single(struct device *dev,
> phys_addr_t tlb_addr,
>  			      size_t mapping_size, enum dma_data_direction dir,
>  			      unsigned long attrs)
>  {
> +	struct io_tlb_pool *pool;
> +
>  	/*
>  	 * First, sync the memory before unmapping the entry
>  	 */
> @@ -961,7 +1201,13 @@ void swiotlb_tbl_unmap_single(struct device *dev,
> phys_addr_t tlb_addr,
>  	    (dir =3D=3D DMA_FROM_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
>=20
> -	swiotlb_release_slots(dev, tlb_addr);
> +	pool =3D swiotlb_find_pool(dev, tlb_addr);
> +	if (pool->transient) {
> +		dec_used(dev->dma_io_tlb_mem, pool->nslabs);
> +		swiotlb_del_pool(dev, pool);
> +	} else {
> +		swiotlb_release_slots(dev, tlb_addr);
> +	}
>  }
>=20
>  void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_=
addr,
> @@ -1145,11 +1391,10 @@ struct page *swiotlb_alloc(struct device *dev, si=
ze_t size)
>  	if (!mem)
>  		return NULL;
>=20
> -	index =3D swiotlb_find_slots(dev, 0, size, 0);
> +	index =3D swiotlb_find_slots(dev, 0, size, 0, &pool);
>  	if (index =3D=3D -1)
>  		return NULL;
>=20
> -	pool =3D mem->pool;
>  	tlb_addr =3D slot_addr(pool->start, index);
>=20
>  	return pfn_to_page(PFN_DOWN(tlb_addr));
> --
> 2.25.1

