Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE96D86CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDET0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDET0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:26:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E555E4ED2;
        Wed,  5 Apr 2023 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680722792; x=1712258792;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jlcwxPwRixCjk+gXHpBSJJJD7dfXxvwvtFmZKP7Y31w=;
  b=Qd1z2mYlG9R3KucpFobUKxZ/uFMlaH3tWRf8/mddyzXvVYS62n2NCznf
   l8xNG74y8iDxlxm793DELCfrWyhlDibTL3ftjvDGbC0mO4lyq2z9fhuZV
   R3+3gXbMI5dHZ3hWx5wJUAj+2Ui/NXOkQduFvH9VWefN/kCI3CpFm7W+E
   n+sOsgcsAkQyqtdwa610G1x8pb1cPTE+z/RfYBhOZTQjO+wqaiWdbRQLg
   mKUIpaDEyB9UU59426rsNAkQebX5sK1sbRn1+NoyAxjQno8rG/0IcjY81
   VDZkmJlS/krWMFQkOcrYA12p8A4wJ75xa7npOQNioV8+zP9xuQq2ER0VR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405328231"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="405328231"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 12:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="719429237"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="719429237"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2023 12:26:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 12:26:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 12:26:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 12:26:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 12:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZjXeW5WfRY/6vwc5g1qoVm6+bxmy2GfqrDT60x/6NYTDqrgolmMIJRJZe73xvtyYEG0m70VQFpRLKmtzo4KSIPbiMNQyrCqMwM02we56S4YD3d6Z7979CCoQUrpCbxkM4Azwy7wRJB3VsyNxC3WLG6INYGHFFUMf2gh7+1cYjXUX5hv1YgqhT4e7lwSipDcxqYTuXo9ibDoO3WhH+SkY+egt6H1niHvabzaXBxMOSNpY/WFy1jI4Q0RO1Rsfd7xj7IrqA8EVZim7f1A8zKXIHA/Cb+hLFl+eRWAovrDSK0I33/MXh7mafFimuX8rLNHwH16GwJ/Ix60quZCOnwB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfFAxBaNswrhCmVbWZJwUSAeooUL1Zjs7CJnugTiaP4=;
 b=c2DLuz5rOUMg471TSKwEQSv6vQHEHSyPTaHbj50ZWCYX6IJimw4TPqcBJbYrRZNVK+ZV9rRIkSvaDoltL89A2GRG6ws3vnsBljRPU22SNbMn0ZuV/rW888Hhs54XmjIi83b4syRyvwnNDQSZw8Qrsjyy22O2P9HgcXB/F203eqNFJraI9RoUNLTzoej+7oHnTNg189Rxh9cFxp8OS54NDj4iByKPO9TiBEZABu1tffIHI+aw5h9Vkqe9spMnJTP/zZkQT24WUPf4j/zRN1qxML65o9yejdExJ6DP1VVYfXOPz44+EERsih97a1PyW52S4t+dntZFau47sIqxgQensg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5416.namprd11.prod.outlook.com (2603:10b6:208:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 19:26:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 19:26:27 +0000
Date:   Wed, 5 Apr 2023 12:26:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <642dcb607a1a0_21a829483@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-5-Jonathan.Cameron@huawei.com>
 <642c9c6e1f9df_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
 <20230405170834.00000c44@Huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405170834.00000c44@Huawei.com>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: bc39c02a-dab1-4a00-4379-08db360ba691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mRk3q1pxnIA0tbKe1Zt4bbRnaBtgugX6j4zoM+NqcWnzBlZ/7/gPr+I6PmkwxIi99NhMrMvgMIcsgeybfslqTX/a5iC3OTDuGhOIyGJga3HmQOEXV2L8PByaVen0ehv7g3QKzFYc1Bb/qJLTCvBnWXlWnaTguxIJjErYsv0fE3MzMWaLDts+8AVlGnowv2rOLn3pBG771pwCQtEvXfzF8E0v5wLO+zwmsIlM5D16XTOHLHMjo/U4d8zGYXQT7cK8F+rrhVjXffA3IL+Gnvk/3koGeSJVjrjybqACLDYqiP/cHJ5CnNSg8DsIsDLjVIXMkH7BXrLmEQLNsKjWpcomZRGjAfvgAZYKHpOP6LXT+xY5E8sQA5BGHxDOE9FVwMnMYb1q4NJV+pfeeiFUyChJYO23qTaKWVwtnURlKWIIkSEw0o4uhnVsHf7mafxTC5zSXKitW4WjsIkB2J0OK3IrXqoB3mtW2/9HaDhATjGMdWGaiwDPDROa4fUM0DBOXYNxU+8hMyveb2Y6hd+k5hg9DuVlVex/aJLLrn3QbcAUPS4A4dshiAOQCkalLrDa+/Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(6512007)(83380400001)(9686003)(478600001)(316002)(6666004)(54906003)(26005)(186003)(110136005)(6506007)(6486002)(7416002)(30864003)(38100700002)(5660300002)(4326008)(2906002)(66476007)(41300700001)(82960400001)(86362001)(8936002)(8676002)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KyYk31M4XRVpZNZ1yUxcNZkwo2e9toTUwIIs7VlvzFLi6ZJxnqpVFnVE52?=
 =?iso-8859-1?Q?k8PHRlV7uTX26xsPfpjql2kHk4pY9KscFVdaGZWJOt93qphNSw85WcIRT2?=
 =?iso-8859-1?Q?U+giEguDCDEw9cWyAHeh5QDTIacQ4Eczv7s/IlZvmA2U1e/LQ5CefANsBH?=
 =?iso-8859-1?Q?KYmZh36Rz3jlGqK5SN47tkjA7G0i+kDvu56i4lqjZ0BIFxpJX40vMjwmOw?=
 =?iso-8859-1?Q?MJMkoIQ/OFXFhHF2EQY9JsQduZpNmU+2QKTv0BfUKoMRXJysTotjIRhyvO?=
 =?iso-8859-1?Q?CO2AWVu7BDGZsvCXCzh4tsca3qUw2CNcSxD8kV3c6YHVaQOV0Fr/mIVzpO?=
 =?iso-8859-1?Q?Wwbxad9lEN9MRv9+1vQmKQBJVh22emnIvjvcilqOzbmCW/cgrPuZJXncm1?=
 =?iso-8859-1?Q?UiUmVDD3ZEhy/qguC3CJUK+2GwmhSC3l2MgmxNwfmgypeWZwQxVh3dbQYc?=
 =?iso-8859-1?Q?dwwnEO6t41bB3ZVfHrJ875uyILB2L3wDq3MF22u4feMB3f2Rm46uGmHC9T?=
 =?iso-8859-1?Q?HS2iGXF2jeQZYtilJc7adiXJw8JNT9ydppmsBMfOAeYGM2SLIo4ibyUO+s?=
 =?iso-8859-1?Q?mbgeSbKyP1TTiYPIi37B+6yMQuZjUzRNkgDTXVuGXsAFkQkjEZelF+17ZV?=
 =?iso-8859-1?Q?Q3r1F8gvfUD8WJ9B4VTfoyYUbkC9sVPFH27r6nvKhRgwXGKieFkvwy41oY?=
 =?iso-8859-1?Q?swk6UJcaXakg72nHILgym42AQ3DWRh1WiNjegisOV5BecCeimTAO1uWKtY?=
 =?iso-8859-1?Q?TiLBU9NlA7WNhOiOGhdF6U2pXOV2ALreeid3S3j87Kes75LsPY8pcvTAOa?=
 =?iso-8859-1?Q?jpPSbQedWODxOLq/APMUPp77V5Ws2uY7mj2Jn4RRsnkHNX5BkxGoa5YcQe?=
 =?iso-8859-1?Q?oxgIewnnCvOYmQrRzemeyS9zBFc6luH4ntZvg6hQ8bef1/HthBSvlV0t+y?=
 =?iso-8859-1?Q?e664ODwW2+4NMSvv0QcKfZXld4yY3Vsfr8Cp+GEPxlEruzxfJlZt6cb1GG?=
 =?iso-8859-1?Q?YogicqaCL1xChzQKk/CMy4dIm4gytLfIMl3XQ0AqxECvKkguXO3VaklbPr?=
 =?iso-8859-1?Q?hFacG2uRy4Bw5M7le5C+Jk6QPYiCeeanKXBBBRpdo/cBcdriQ1XkMdA6GM?=
 =?iso-8859-1?Q?9KkHJfrfhLZ5TT9x0UG/rZ3mqMGVVjWcbacoZ0X9/MlblSXRm3sxHIZgWk?=
 =?iso-8859-1?Q?1hDvru+xC7Y0eLcTm6hv+s3YW/ev7MZw5sYbw8bJ3tWkjHdP07hrBCCIjt?=
 =?iso-8859-1?Q?rdM1PITDRFEk2hlGZKb5nzFTn2p6hMvDkTaSDWq1Z9sIZRJospustoTRsg?=
 =?iso-8859-1?Q?feTSfsG0o4LTeAUelGVx/h5w4WCe+uid9kD98Yk5bOEkxcaQ3gqN6x+tU4?=
 =?iso-8859-1?Q?l2+ELflcBjowltANwhcGSWC4/DByqoc0A4D2jfgko0gCu28L1BSO7tfAl5?=
 =?iso-8859-1?Q?WvSLRlEQGF1xWQEdiTy0nSJMttBMYt+RVHq5ZnxC+CuHenwf/G5Bp4h/HL?=
 =?iso-8859-1?Q?DZxHWaid7+5Bbvsivqv/fHz+/HEttajELlm12SxoPqz1H7QrEqxfmjVs9L?=
 =?iso-8859-1?Q?PkHoWm+CTXCEDwVAS4LC4Al63wmTbAsZceeTxRbyFeg1MzYQZczXoJ/BcV?=
 =?iso-8859-1?Q?FNBm94SQOOYPp+7OIxzpnMc1Teem5JFMomn8azymKkyg1L2ol2htaDiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc39c02a-dab1-4a00-4379-08db360ba691
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 19:26:27.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM0gXNPUTYvad6Z1mFmp7tQYWaeOMCiY+wsT/wUCmD+RuU5/xcM/TZshyTGsPR7YcntyuY6sxUKykgGxuynVbMIbPCHQzaGwVJXTi2S/s44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> Hi Dan,
> 
> Thanks for taking a look.
> 
> > > Development done with QEMU model which will be posted shortly.  
> > 
> > Per the comment on the cover letter is there a sense that set of
> > counters supported in QEMU and this patchset are representative of a
> > "common" set even if that is by convention and not specification?Just
> > trying to get a sense of how many real world CXL PMU instances this
> > might cover.
> 
> Good question.  Events wise, the driver supports all the Spec defined events
> (for the Vendor defined ones they "work" but are not described in this initial
> version so you have to know the magic numbers).  In discussion with Kan I think
> we've established what discoverability will look like but it is a substantial
> addition so I was planning that for a follow up series.
> 
> Features wise things I expect in hardware that don't 'yet' support include:
> 1) Implementations without freeze.  They require more complex handling of
>    start / stop (and will never work as well as you can't start sets of
>    counters with one register right).  Easy to see how to do this but
>    postponed for a follow up set.
> 2) Free running counters.  Chances are we'll see these for vendor defined events
>    as they are a cheap way of getting support for stuff that is really debug related.
>    Again, well understood how to do this but adds more complexity to the driver
>    so postponed for future work.
> 
> So after this series merges, I'd expect to see 3 follow-ups to add each of the
> above features, probably in the order:
> 
> 1) Discoverability.
> 2) Free running counters
> 3) Implementations without freeze.

I feel like this one might be an "only if a device shows up" situation,
but the others seems reasonable to plan in advance of practical hardware
examples. I think it's ok for Linux to be prickly towards hardware
implementations that make our lives harder.

> > One thing I would have liked to see is a sample perf command line and
> > output.
> 
> Sure. I'll add one here and consider improving the docs on this.

I did eventually find the Documentation, but no harm putting an example
in here too...

> > One concern I have is how usable DPA based perf events is going to be
> > for end users. Is there a concept of a synthetic event that can turn
> > data gathered from all the devices in an interleave set into HPA
> > relative data? Or do you expect that is the responsibility of the perf
> > tool to grow that support in userspace?
> 
> Given we need to fuse counters from multiple devices up in userspace
> I'd expect us to do cross device aggregation in perf tool.  Will be very
> system dependent on whether such aggregation makes sense (if you can't monitor
> what you need in host or at the HB level.).

Ok, makes sense.

> > >  drivers/cxl/Kconfig  |  13 +
> > >  drivers/cxl/Makefile |   1 +
> > >  drivers/cxl/cpmu.c   | 940 +++++++++++++++++++++++++++++++++++++++++++  
> > 
> > Yeah, this is a bunch of code and ABI that is more relevant to drivers/perf/
> > than drivers/cxl/, so this wants to move to drivers/perf/cxl.c.
> For consistency with other drivers in there it will be drivers/perf/cxl_pmu.c
> with cxl_pmu.ko as module.

Sure.

> It's currently a little messy to get the includes from
> ../cxl/ but not bad enough that I think it's worth ripping those headers
> apart to move some of the content to include/linux/cxl so I'll go with 
> #include "../cxl/cxlpci.h" (needed for the DVSEC ID).
> #include "../cxl/pmu.h" (with stuff drivers/cxl doesn't need pushed into the cxl_pmu.c)
> #include "../cxl/cxl.h" (For cxl_driver)
> 
> Similar to done in drivers/dax/cxl.c

Works for me or:

CFLAGS_cxl_pmu.o := -I$(srctree)/drivers/cxl/

...in drivers/perf/Makefile.

[..]
> > Is it worthwhile to maintain the TODO list in the code? I just fear this
> > getting stale over time.
> 
> There is already some text covering the most important of these in the patch
> description so I'll drop it from here.  Patch descriptions shouldn't ever
> be stale (says the person who just deleted the garbage that was stale in
> previous patch... :(

Hey, I resemble this remark, it happens.

> 
> > > +/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
> > > +#define CPMU_GID_CLOCK_TICKS		0x00
> > > +#define CPMU_GID_D2H_REQ		0x0010
> > > +#define CPMU_GID_D2H_RSP		0x0011
> > > +#define CPMU_GID_H2D_REQ		0x0012
> > > +#define CPMU_GID_H2D_RSP		0x0013
> > > +#define CPMU_GID_CACHE_DATA		0x0014
> > > +#define CPMU_GID_M2S_REQ		0x0020
> > > +#define CPMU_GID_M2S_RWD		0x0021
> > > +#define CPMU_GID_M2S_BIRSP		0x0022
> > > +#define CPMU_GID_S2M_BISNP		0x0023
> > > +#define CPMU_GID_S2M_NDR		0x0024
> > > +#define CPMU_GID_S2M_DRS		0x0025
> > > +#define CPMU_GID_DDR			0x8000  
> > 
> > Last note about the naming quibble, I notice that CPMU exists in other
> > places in the kernel, but CXL_PMU does not, so there is a small
> > grep'ability win as well.
> 
> You mean unlike CXL in drivers/misc/cxl  :)

Touché.

> I was going to leave these definitions alone, but fair enough I'll do these as well.
> Anyone with a narrow terminal can blame you for the line wraps ;).

It was really the devm_cxl_add_cpmu() that got me into this naming
tangent, I admit it's a personal preference to remove redundancy when
pathnames or other prefixes cover.

> > > +#define CPMU_MAX_COUNTERS 64
> > > +struct cpmu_info {
> > > +	struct pmu pmu;
> > > +	void __iomem *base;
> > > +	struct perf_event **hw_events;
> > > +	struct list_head events_configurable;
> > > +	struct list_head events_fixed;  
> > 
> > Linked lists? Didn't xarray kill the linked list?
> 
> No. Kan raised similar in an earlier review and I couldn't come
> up with a way that worked (for the configurable ones anyway)
> 
> How would you index these given they are defined by a full 64
> bits made up of VID, GID and MASK + we need to match in some
> cases by exact mask (for events_fixed) and sometimes as a subset
> (for events_configurable)?  I see below you say we could make
> this dependent on 64BIT to handle the fixed counters list but
> that seems ugly to me.
> 
> There might be some magic data structure I'm unaware of we could
> use but why bother? Expectation is these will have only a small
> number of elements so a list is fine.
> 
> Looking at it again the naming is a bit misleading.  These aren't
> generally individual events but instead the "event capabilities".
> Let me rename them to make that clear. event_caps_configurable,
> even_caps_fixed + rename the struct cxl_pmu_event to cxl_pmu_ev_cap

Ah, I indeed was thinking that this was lists of events, not
capabilities.

> As such the absolute maximum length of the sum of those two lists is
> 32.  Most like they'll be a lot shorter than that.

Even without the (too?) fancy hack to try to make the (vid, did, mask)
tuple the xarray lookup key, you can still replace a doubly-linked list
with an xarray indexed by the pointer value:

xa_insert(&info->events_configurable, (unsigned long)ev, ev, GFP_KERNEL);

...and then walk it with xa_for_each(). Given the small list sizes the
benefit would be more for readability in the sense that I can look at
xa_for_each() and not worry about the locking context, but not with
list_for_each_entry(). I won't push hard on this since these lists are
small and not going to grow beyond 32.

> > > +	DECLARE_BITMAP(used_counter_bm, CPMU_MAX_COUNTERS);
> > > +	DECLARE_BITMAP(conf_counter_bm, CPMU_MAX_COUNTERS);
> > > +	u16 counter_width;
> > > +	u8 num_counters;
> > > +	u8 num_event_capabilities;
> > > +	int on_cpu;
> > > +	struct hlist_node node;
> > > +	bool freeze_for_enable;
> > > +	bool filter_hdm;
> > > +	int irq;
> > > +};
> > > +
> > > +#define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
> > > +
> > > +/*
> > > + * All CPMU counters are discoverable via the Event Capabilities Registers.
> > > + * Each Event Capability register contains a a VID / GroupID.
> > > + * A counter may then count any combination (by summing) of events in
> > > + * that group which are in the Supported Events Bitmask.
> > > + * However, there are some complexities to the scheme.
> > > + *  - Fixed function counters refer to an Event Capabilities register.
> > > + *    That event capability register is not then used for Configurable
> > > + *    counters.
> > > + */
> > > +static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
> > > +{
> > > +	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};  
> > 
> > An 'unsigned long' is always at least 32-bits, and:
> > 
> > unsigned long fixed_counter_event_cap_bm = 0;
> > 
> > ...would not have interrupted my reading of the code.
> 
> Hmm. I'm in two minds about this. Given we are accessing it with 
> bitmap walking macros and hence this bitmap being replace by
> an unsigned long (unlike the bigger ones) requires a bunch of
> &fixed_counter_event_cap_bm  I think it is messier to change.
> 
> Don't feel that strongly though so made the change.

If there were a BITMAP() macro that did the declaration and init,
similar to LIST_HEAD() then I think I would not have reacted. It's really
the "DECLARE_BITMAP() = { 0 }" that bothered me.

[..]
> > > +static void cpmu_event_start(struct perf_event *event, int flags)
> > > +{
> > > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	void __iomem *base = info->base;
> > > +	u64 cfg;
> > > +
> > > +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> > > +		return;
> > > +
> > > +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));  
> > 
> > Maybe a comment about why these warns will likely never fire in practice?
> 
> Hmm. Good question (I cut and paste without thinking about these :)
> 
> start is only either called:
> a) from cxl_pmu_event_add() where these flags are set directly
> b) from a few places in kernel/events/core.c
>    __perf_event_stop() (with restart set)
>    perf_adjust_period().
>       there pmu->stop() is called with PERF_EF_UPDATE and we set
>       the flags in our callback.
> 
>    perf_adjust_freq_unthr_context()
>       One path calls pmu->stop() as above.      
>       One path perf_pmu_disable() has just been called.
>        this is only path I can find that might leave these two flags not set
>        but I am fairly sure we can't trigger it because (in common with most
>        drivers in drivers/perf) we aren't counting interrupts as necessary to
>        trigger this path.
> 
> If anyone more familiar with perf can confirm / correct my logic
> it would be much appreciated.
> 
> For now I'll just add a comment that we should only reach here via
> the stop call or with the state explicitly set and hence these flags should
> be set appropriately.

That works for me, maybe a check_hw_perf_event_state() helper could
centralize these common assertions in the perf core?

[..]
> > > +static int cpmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> > > +{
> > > +	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
> > > +
> > > +	if (info->on_cpu != -1)
> > > +		return 0;
> > > +
> > > +	info->on_cpu = cpu;
> > > +	WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));  
> > 
> 
> > Is this really a kernel crashable scenario for folks that have
> > panic_on_warn() set? If it's a "should never" happen type situation then
> > maybe a comment, otherwise pr_warn().
> 
> Will see if I can come up with a comment beyond "shouldn't happen" as
> if a hotplug notifier says it's online it better still be online within
> that notifier callback.
> 
> I think the key here is these are called with the cpuhp lock held and as
> such there is no race and we shoul always be able to set the irq affinity
> appropriately.

I have started to make sure all my WARN_ONs are sane after Greg pointed
out that panic_on_warn() has users.
