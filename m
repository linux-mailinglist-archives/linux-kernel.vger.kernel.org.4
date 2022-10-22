Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820FF609058
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJVW6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJVW6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:58:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D2EA9D5;
        Sat, 22 Oct 2022 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666479489; x=1698015489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1y7Wgfd5Wr9ofisXa9JicFQnpWUCgp2QTTR2UXnMx9U=;
  b=Wnxb31C9m5l1lGvoI1+7kNVb4NQMmFWRzWYIpoieRdk6ZHLk/ieacspI
   UlE3Z31Ij/b1hI3kH/W5LyNZz3UJUpMUvnPM6CPysO3Nz9aZWVIus3P/V
   y3J/GJjQFsQ+HuX/MWADyf7XZVNmXCkLtO3ALP3m8Gl13tq+ihk722LNa
   9u6E9Fuw9km1HacKNgSB0SYXDFeM/+CHRCoErhaA2Yr+H3kgKF2RxlJVH
   2FS/c4uMnIkS72sh/xsY+y0ECNJsZBScLxXT+RLXkFe2Z6lozGd2uZfIN
   0LAadCMlcul7PIeOsnB9TrTJMnmvoaFeXE0R4u5+mRpVsDkeJ1JfukLe+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="287616152"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="287616152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="735975681"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="735975681"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2022 15:58:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:58:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:58:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:58:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVqlvIFuCybs0us/x5TxQWXU+faMheAJ+/1BgUQoWhqnXIp5TTdw2ezTLAzRLxN37Qco5M6SSemw1ncjHO8s9tcJFxPrc64YUEPywMK7PWZ0fiHRSjqJA2gLB7dK+3SRl9gxIr5Cbcj+X6CSOCBwMipCeA7iV4XsXQ5vb7+q/1E6EYHOyu5RiL/RCP4eoCdcCHcUkOe9AON9OpL6wfrClZJYZvxxwl1gpuy8I3eFzjlyDwgkAAJLuiat85+EdcqZfSzYqEFjWCo/MH257tyH6iBZIe0wgIudVFyTe382/etmpgtSz5LkcslxwOewbi5yuX5jwGJrbdNP93HzHQsgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCq5SmnSfeqDyaWaFYXFQZqFcF/TO+yvqSMwxai1u3A=;
 b=ZeYynMka9oFbEzLdCn+lHybD0hDY8A38e2qvbWBcdyjf1FOH7PJwXBRvDsZ/WYKUmzQFBnp//F7DMvYf2EZy8oq2bv8tAQXqNG2ZZw1hawdASlBnEzLizY9/TAvQnoI2f1V1nRRPjuAGsGz4w1VzIP78gvWdwInhS71fH8C8TrCKw7dJlVxyJ5LBi5M27g5W8EkW2kBoAuVwsHdB1u8cyPCjYClmtHUJ/neaJ65wFNp+WZQPGwCkwy5AVakl9OAELqEaP0whH/YIrtRAVrEvXWyPzMgxMizorhlI/jGFQypuzAmUjHstwhYU53g/Tx8LtLfUsj19NMnXQ62BgYKRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 22:58:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:58:00 +0000
Date:   Sat, 22 Oct 2022 15:57:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <akpm@linux-foundation.org>, <hch@lst.de>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <a.manzanares@samsung.com>,
        <x86@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dave@stgolabs.net>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>
Subject: RE: [PATCH v3 -next] memregion: Add cpu_cache_invalidate_memregion()
 interface
Message-ID: <63547574168e7_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20220919110605.3696-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220919110605.3696-1-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW4PR11MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: a57712d4-83f1-47be-0a7a-08dab480ddc2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxQNfLX3qAbKbKQF8nEv8ifnNn09IzS/qkrnJ789ZZkxKv7SQ/trliJjjwvj8cgnXZRUEmLGqEeRQMscNMsbkX4RpNw37Xk80UMHhsPh5+IVnzEGeIdRXM/7yZY85adC+PGVp1W3vk0b87FnyVQUf/vVhospz4cmjVsh+cRmb77sx0Dl6I2jHTflZUydqhXJl9C925n4B/c9Mz2CnQdCO0dC8RST77X3hpn8wVFoWw8cFAO6gar6hTzR895tttNrVfsYmW5YtdGW1Mu3gCvkvR3SmuTPB0Z3SFhwVYoqffohG1d2QSlqJXPzob1+NWiqAEapXK83Pbkdqxwigyscz7roLWH2y6ocQVNPqrup+3zp1zIzRZSpXs62JLE9kvqIrCxLCEgr660+8WWt97H+c2/obi3o+G6kEMh/I1EThsryRyGTCe1WA9wBDsh97o+e4avDStwyDThBM7QZ5gDkcK8MpdqyvyNQuwGn+YD/wHgNJ9Q0ERyakRNGNKn3VFZiYVchVGT0+jh6dYp0CXbVsfvq0EiIM8t3aZ0rsIvyr5Sjo6fHEha5UbxNDu22DkWFPQpiroc5jW4nJZ9I9it8SXL3BG+RKFpGsTEHAqzjchKEWKFVq3CcAYAZ5bIlHiMlwSozwYKzCXh6hMWIvRKhaoszjBUduIrtUp6mZp6PQMIpojbPyHDcZGFPr/RWK1sqcknW4a8T8VYZceL3G3VhYaDKifspdskv3KhjEwFOoRi8aLqAH7SZ44mX2IsV+IqU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(7416002)(5660300002)(2906002)(478600001)(4326008)(316002)(66476007)(8676002)(66946007)(66556008)(41300700001)(8936002)(6486002)(83380400001)(38100700002)(6666004)(82960400001)(6506007)(26005)(86362001)(6512007)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nr/22MYRO6z6gylEUIKGIR7qMhKffoyOB7vKcSsqrTWWo87J/qqFUPtcXsTM?=
 =?us-ascii?Q?Ct4VjnVG16Ib7MkAEMxBG2hw6OpJrYip08UpB0mhMJ8rjAe/AFDEV92qtfSV?=
 =?us-ascii?Q?QQHuXbYzoUuQGzCsPVxJE5+M2Fz1hw9zgoRVJciH04Q7uSIYhI6UijC+YANI?=
 =?us-ascii?Q?F/HBaUU/vw8kCO9oUw5OnVpbdeDlfjJs6zA2gpcMWmwZ0AI21iL7bA+05CQV?=
 =?us-ascii?Q?hXdw1dWSxWSSOnUrL/mRgn+MNOuJBaYy2kamwcEiuz0uVRuoLm+NVpLR2lvk?=
 =?us-ascii?Q?FTnE+ysd69v2iKXg0tkEOtbvdL3cfxfDt6uHL+eBq3tnsFTu206aE1SVv4JI?=
 =?us-ascii?Q?OKN2leYopUTagBru5OhTX4YMTzhDYI8eb7wi6wUBJD5P5LDFnV7sh5t4IrRm?=
 =?us-ascii?Q?RgHBXyZJKFFEPrymk4HkJqxinBWxtZjcH6Ojnc6Is+h4HhTIc6alrf1WMSFD?=
 =?us-ascii?Q?a/5xD9pyFW0sUkdjeBYivXR1I7dWD9/a5+KWno1u7WnyzjoiIkYxJe9GE3vY?=
 =?us-ascii?Q?Giuto57WDqGDEYqHImZFqskU5IxhctLdjhEbchY04gOrWvgUQOwa4xIZpGpq?=
 =?us-ascii?Q?947mezide0v+Utmxc43PDxTpL6mWXvj1/2ySfXfYOnEsbI9N5izJe8z+TalI?=
 =?us-ascii?Q?ldzC6LYmpxv/Cn0i/zcP8LYyNICyhrH1UKdGPCirCmkSvVLmg138UNHPL7IR?=
 =?us-ascii?Q?aO0IIU+x/Sw6u6XS34l/2G8dAak3VroWVFqW6FwKFcuBy1LcoHLXi/IZaZqy?=
 =?us-ascii?Q?Iby/YnQ1XcrYyG+KAinuParNG1MZ5cpkqhed1NLdxBSnRzfZs4VWzbgAMLK1?=
 =?us-ascii?Q?KDDtCmU2Z3+1F0cbGqALzXJTmgnuDA2iTMnvaihETe+Tem2o794YDSAe2mzh?=
 =?us-ascii?Q?p7Yd+I/31Wk1Gr5yMwWDHymXLwdJTVdXQBHCNVWdIF9cGg4NCfEk7iVAFO4r?=
 =?us-ascii?Q?M8/R8Vl82liF/SD9TsVgJP3auTH0yLIZxFDYa/ZabOcaKvXNGEAEy8noZ+bk?=
 =?us-ascii?Q?yzOVli23kolHDf7mTuIiuP53rlB8zyTRTG9pnSBk7CFgtAM5VlwIKIrZbIdb?=
 =?us-ascii?Q?xP38xxepaYJ1PG3kf0n9bqpRc3S3sj56Kl28aMuA6tIU6+8jqk3EtndCOl/j?=
 =?us-ascii?Q?GA97jYkp9PRSwkBYa9oy76+wayHV2+FueuhDRwB4jjGGvl+SyNI6abJqBiru?=
 =?us-ascii?Q?OmQxQP6HeNJY8BtR7N9tWufijje+4Y3Tx69I8oi4V3XLLtGJIM0i3iNft8C2?=
 =?us-ascii?Q?QtJArkQkFAuykLIhNSTQ61V0VTj7qcbiO7yA2wdNwTmZyUzXVwVMpb7sHaAw?=
 =?us-ascii?Q?540KK1yGrETPNGNCD+9vm+R7qeHd7lPaVr9ZGOHjyXHAJLqaLM7fzwkVHc6P?=
 =?us-ascii?Q?EEUsZMI+S1C6RbZ5SCAzy6HS5ElH8pHLwf/BJd64ninMi+PIFqXTW4TKF793?=
 =?us-ascii?Q?0Pf6o+CUkhZeYuFsSGj/yQf4/IhBEXTNTAt5LpzARRnZXu7GdKaL2ENkSxK4?=
 =?us-ascii?Q?CNSKMaluTN+7YyApjl4OsqpWfp3MfzYYUwxicqJmJ16GCeoffMCpxskhHgVJ?=
 =?us-ascii?Q?oPkCuczU/+I98xpmGGvqv0de3bPrCHVt7IsC0Ovsdfx4lrWOkjq332kwBlJt?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a57712d4-83f1-47be-0a7a-08dab480ddc2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:57:59.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxTV+vzbE1aJY0sKzBdT2PWyqULtr0bObHtTRLyurVHxwVxKTkdemXN8QOek2TgpBuoQms8q7a/Ybovf1fIzLDKjO0cT5UuAWolAb+iOp3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add the rest of the X86 MM maintainers, Dave and Andy ]

Davidlohr Bueso wrote:
> With CXL security features, global CPU cache flushing nvdimm requirements
> are no longer specific to that subsystem, even beyond the scope of
> security_ops. CXL will need such semantics for features not necessarily
> limited to persistent memory.
> 
> The functionality this is enabling is to be able to instantaneously
> secure erase potentially terabytes of memory at once and the kernel
> needs to be sure that none of the data from before the erase is still
> present in the cache. It is also used when unlocking a memory device
> where speculative reads and firmware accesses could have cached poison
> from before the device was unlocked.
> 
> This capability is typically only used once per-boot (for unlock), or
> once per bare metal provisioning event (secure erase), like when handing
> off the system to another tenant or decommissioning a device. It may
> also be used for dynamic CXL region provisioning.
> 
> Users must first call cpu_cache_has_invalidate_memregion() to know whether
> this functionality is available on the architecture. Only enable it on
> x86-64 via the wbinvd() hammer. Hypervisors are not supported as TDX
> guests may trigger a virtualization exception and may need proper handling
> to recover. See:
> 
>    e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v2 (https://lore.kernel.org/all/20220829212918.4039240-1-dave@stgolabs.net/):
> - Change the names and params (Dan).
> - GPL symbols (Boris).
> - Mentioned VMM check in the changelog (Boris).

Any remaining concerns from x86 maintainers?

Peter had asked whether this requirement to use wbinvd could be
addressed from the CXL device side in the future. I did raise this
question and I will point out that "back-invalidate" (device initiated
requests to invalidate CPU caches) is a prominent capability defined in
the CXL 3.0 specification. So, there is at least line of sight for that
to be used for these flows going forward.

There will also be motivation for this from platforms that do not have
an equivalent to wbinvd once the Linux CXL stack declines to support
dynamic CXL memory region provisioning and secure erase in the absence
of a functional cpu_cache_invalidate_memregion() or a device-side
back-invalidate capability.

> 
> 
>  arch/x86/Kconfig             |  1 +
>  arch/x86/mm/pat/set_memory.c | 15 +++++++++++++
>  drivers/acpi/nfit/intel.c    | 41 ++++++++++++++++--------------------
>  include/linux/memregion.h    | 35 ++++++++++++++++++++++++++++++
>  lib/Kconfig                  |  3 +++
>  5 files changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2e8f6fd28e59..fa5cc581315a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -69,6 +69,7 @@ config X86
>  	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_CACHE_LINE_SIZE
> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION  if X86_64
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 0656db33574d..7d940ae2fede 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -330,6 +330,21 @@ void arch_invalidate_pmem(void *addr, size_t size)
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +bool cpu_cache_has_invalidate_memregion(void)
> +{
> +	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
> +}
> +EXPORT_SYMBOL_GPL(cpu_cache_has_invalidate_memregion);
> +
> +int cpu_cache_invalidate_memregion(int res_desc)
> +{
> +	wbinvd_on_all_cpus();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cpu_cache_invalidate_memregion);
> +#endif
> +
>  static void __cpa_flush_all(void *arg)
>  {
>  	unsigned long cache = (unsigned long)arg;
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 8dd792a55730..b2bfbf5797da 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -3,6 +3,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/ndctl.h>
>  #include <linux/acpi.h>
> +#include <linux/memregion.h>
>  #include <asm/smp.h>
>  #include "intel.h"
>  #include "nfit.h"
> @@ -190,8 +191,6 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
>  	}
>  }
>  
> -static void nvdimm_invalidate_cache(void);
> -
>  static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  		const struct nvdimm_key_data *key_data)
>  {
> @@ -213,6 +212,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
>  	memcpy(nd_cmd.cmd.passphrase, key_data->data,
>  			sizeof(nd_cmd.cmd.passphrase));
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> @@ -228,7 +230,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  	}
>  
>  	/* DIMM unlocked, invalidate all CPU caches before we read it */
> -	nvdimm_invalidate_cache();
> +	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>  
>  	return 0;
>  }
> @@ -297,8 +299,11 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  	if (!test_bit(cmd, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
>  	/* flush all cache before we erase DIMM */
> -	nvdimm_invalidate_cache();
> +	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>  	memcpy(nd_cmd.cmd.passphrase, key->data,
>  			sizeof(nd_cmd.cmd.passphrase));
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> @@ -318,7 +323,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  	}
>  
>  	/* DIMM erased, invalidate all CPU caches before we read it */
> -	nvdimm_invalidate_cache();
> +	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>  	return 0;
>  }
>  
> @@ -341,6 +346,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
>  	if (rc < 0)
>  		return rc;
> @@ -355,7 +363,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  	}
>  
>  	/* flush all cache before we make the nvdimms available */
> -	nvdimm_invalidate_cache();
> +	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>  	return 0;
>  }
>  
> @@ -380,8 +388,11 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
>  	/* flush all cache before we erase DIMM */
> -	nvdimm_invalidate_cache();
> +	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
>  	memcpy(nd_cmd.cmd.passphrase, nkey->data,
>  			sizeof(nd_cmd.cmd.passphrase));
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> @@ -401,22 +412,6 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  	}
>  }
>  
> -/*
> - * TODO: define a cross arch wbinvd equivalent when/if
> - * NVDIMM_FAMILY_INTEL command support arrives on another arch.
> - */
> -#ifdef CONFIG_X86
> -static void nvdimm_invalidate_cache(void)
> -{
> -	wbinvd_on_all_cpus();
> -}
> -#else
> -static void nvdimm_invalidate_cache(void)
> -{
> -	WARN_ON_ONCE("cache invalidation required after unlock\n");
> -}
> -#endif
> -
>  static const struct nvdimm_security_ops __intel_security_ops = {
>  	.get_flags = intel_security_flags,
>  	.freeze = intel_security_freeze,
> diff --git a/include/linux/memregion.h b/include/linux/memregion.h
> index e11595256cac..d3fafb6873b5 100644
> --- a/include/linux/memregion.h
> +++ b/include/linux/memregion.h
> @@ -20,4 +20,39 @@ void memregion_free(int id)
>  {
>  }
>  #endif
> +
> +/**
> + * cpu_cache_invalidate_memregion - drop any CPU cached data for
> + *     memregions described by @res_desc
> + * @res_desc: one of the IORES_DESC_* types
> + *
> + * Perform cache maintenance after a memory event / operation that
> + * changes the contents of physical memory in a cache-incoherent manner.
> + * For example, device memory technologies like NVDIMM and CXL have
> + * device secure erase, or dynamic region provision features where such
> + * semantics.
> + *
> + * Limit the functionality to architectures that have an efficient way
> + * to writeback and invalidate potentially terabytes of memory at once.
> + * Note that this routine may or may not write back any dirty contents
> + * while performing the invalidation.
> + *
> + * Returns 0 on success or negative error code on a failure to perform
> + * the cache maintenance.
> + */
> +#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +int cpu_cache_invalidate_memregion(int res_desc);
> +bool cpu_cache_has_invalidate_memregion(void);
> +#else
> +static inline bool cpu_cache_has_invalidate_memregion(void)
> +{
> +	return false;
> +}
> +
> +int cpu_cache_invalidate_memregion(int res_desc)
> +{
> +	WARN_ON_ONCE("CPU cache invalidation required");
> +	return -EINVAL;
> +}
> +#endif
>  #endif /* _MEMREGION_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..757ae7fff93d 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -652,6 +652,9 @@ config ARCH_HAS_PMEM_API
>  config MEMREGION
>  	bool
>  
> +config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +	bool
> +
>  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
>  	bool
>  
> -- 
> 2.37.0
> 


