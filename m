Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C26D575A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjDDDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDDDzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:55:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70F170F;
        Mon,  3 Apr 2023 20:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680580543; x=1712116543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LyID76HGoNqNd8xACzi89PezDlIj83IvxrCZE6DMe8M=;
  b=E5AARRTKs+a5PDKoKuGKun58jejl7QHWrghSF5pTi0RnJmjKMPncZsMg
   SIjYaNL6PGaRCVSNiVDk4KENq/6I0V3YuqeBJf4FZuj+TGDov4DEmm8zB
   2G4wLQJYsboyR2bRpZiDYfH1P4kP9FSHPpWGv/R22n/8qodQwAVX613Jp
   vSONjPAM5yIXksV06rsmBtdug0QI2HnBZh9lt+ViRo73Ll4rsQ9fZi2MT
   +ej6NmWy8s/mUQuldARQqnevLvXzuSkMCmF1yDv+Yqqx6Yk32FxhkZUc6
   rX3KTfRjb6KRRxuFiasfHKNbd5GsHeiI/w08snFMpaM2QdXwFX0UHdUHV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="321736869"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="321736869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 20:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="716504107"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="716504107"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2023 20:55:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 20:55:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 20:55:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 20:55:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 20:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBjJZcAvfmiWny/y6HD/AlYptc6nXWz0TDr5dhBENLf6UtIcsGTHVUIPo5JBQDxrWKJIQ9wOlSsgKA+/GRqssexleiMhRrDep5T5RHY79nTnnrjpqFEUybFfRBIipHror2cGaLvDWVYqfTH2vCsCi4JUndQSN6FV0jpw1ee1DyrR3hO3HvQvWAMmPrKDYkGlqemTw2EB+hZ5/TgWMSQHIfrk/NWXNp/+F3gSPctFNRsPoCY+dlzapBtnS7n7GY+kVy3LRBenIWv+JclNOQy9UCIpp5bWlTFmEn/JkC5UzafcB10Vhr46BBybuYZcyYf2fVuu1YRLl9Ywl6BPNiOOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIlbVuGu6ZGVwaacey3b/snzy2YCZV11PsJad4W99Cs=;
 b=GenV+x65REEeMNTNoJdy+HUEtdQh2OxAU1Ey/fZX9ZQES3Bf+ULYadahvIFHEK+MPyBK0uhU65mCxWlXCXj48o8pOZlt4OzvN1LYOHyUmR1IiVbLYOvWNOM4gSdLxjdL0C1p5zeWl7Hq00D5KnDWTrGgqeMQkAjlEDCrHgGiRc47W25yQqr40C6SBMPhB2DBWKW7eC9zL3jJImkcIwG8gSQkW8qvlVAxeW34jx5JPQLCveFHM4O7/xYd1OjzyKbMqdaqQIj9xAtoKZx8guC8gLETA0lMrP+SYnhjrYHWipDnKGIMhAA1G7/li5DrT3YpADvNqSo3oKZ2/NBs6bb3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 03:55:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 03:55:39 +0000
Date:   Mon, 3 Apr 2023 20:55:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v4 0/5] CXL 3.0 Performance Monitoring Unit support
Message-ID: <642b9fb7d6986_29cc2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1904b57f-77b6-4e4d-9275-08db34c073e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo2ZG01KMTgvfP5H4cGeFyWuK5alIhjYkOn5JFK5Elr+MrWkMDnihk8CzUSdLDd6fghbPVEqhlNRcjXD8CILQWFEZu0sbhwvy2O21bKWl2k6ZJdFUGWNcL/6fAwCjgW/2Xi1afBwN3MzyoHNzcKDpS5VO5mGDUP+Q1mCOyyGDB2I7o80OlQjziDV8d7hZkd5C0H8uSxESAfRQEiiSUBMARtD/qfpuZVKyPX2AjcknGQHLb0jzbmEBp7BQckporZM7Zqe7zHMRXmlCz/NxM2lRmZJr6NGWMs2x67z5E7yi8fyOQ2WZ4lWahoziNkIJrIlawY0/xl9psSdIERdJvk/vglTSyP/Tj+J21UXGIpTdBeUkZ8blfqjobnaQBwf6c2d3/ely7WS0GncdwGM3rXsICU+TC6zAUSz79gRCMxKa9hB0Ve/meJu1vLV/bsuFLolwQzHCxsBJWOk8bCo29uQHtuK6aUdNmDXIXgFeEfCnafDVQTYze41bxOFQw9CjpQEXoDI65UXLD5LyQHWtaaopjV+euXoIUjTPBpOMkzRPQ8YF/9w1mRKcMpibvQXe0MViHr7rjhccJm5Z25oaDoyqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(5660300002)(7416002)(83380400001)(54906003)(110136005)(6506007)(316002)(6486002)(186003)(478600001)(6666004)(966005)(86362001)(26005)(6512007)(82960400001)(9686003)(4326008)(8676002)(41300700001)(66946007)(8936002)(66476007)(66556008)(66899021)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01Y4LHe7E5IauOTfKwr7snJvGvc4b5iSlX3DOXXNwBY7AOSmC3fFrbhmPU3r?=
 =?us-ascii?Q?R1WECNcDJ6+orQnusteUqryO/q9wYEf/H0QIJpWsF7YrhHzvXN72v4mSPVbW?=
 =?us-ascii?Q?z5hleBIL3cuM6nRm3sjHLeNTlBW2UOcx8cbXKD5kWBnK3QAl2wuis9g0h+Iz?=
 =?us-ascii?Q?7fN6LoHLu7W6VAwBhQFLm0xHnJNB9J33lA1CNR/cMP+dcaVHN0X1sX4MJTan?=
 =?us-ascii?Q?BYeJ3siWAn+dwltq/jM17hLBS3yoc/qpqjOe0F9LXbMqeZHbGiFiY6Cj+Zv7?=
 =?us-ascii?Q?3n2ayBQ2kR1TbqIMhtnyOn8qBtOW4fCLGsOZ8mjH5A9odDZ6exxBkAXOl+kV?=
 =?us-ascii?Q?62lOJIqa9Xhn50jPPKmen0w9eGfwzi/bb+UcEZN0Lnyylr90fKzwa8Sjiwry?=
 =?us-ascii?Q?gV6CrSYGuCnX7zBtwpj9A57TLPpAt53PR+Q4eAMyHx41jT1zcdw+TUklLK+H?=
 =?us-ascii?Q?EyImDxw8AziAfM+sjEN4HT1yOLT8bpbjW2JywkbOiRe7HaNgYknUvFdEx1WI?=
 =?us-ascii?Q?X2OD9k5KTT7kfNPVWFVJ3Gt03F6VzeY4nmIAPTv0SLKg3qFx349x5ggCYbkm?=
 =?us-ascii?Q?v9QZ3dltiYxLp1aIUTaekerTc99piT05zGxzrLHGPS2DcLZVrY9T6JhPE08Y?=
 =?us-ascii?Q?M2bbpGmkfDamoiXL7JzY9RotucuTBSRJt7AkRAaOaXWrnNI37lMmEi4Btvl6?=
 =?us-ascii?Q?3bCXPNXhuer38lOeWgtmLF7arXnhAepOaF3CZnlap/MhC39OKxnQ1KGICpym?=
 =?us-ascii?Q?NVD1dpVU7RW6mkP1JZUNJpUNRwdvFQC14R3zNmvq13CH82gEcmCc29VWqZyP?=
 =?us-ascii?Q?kFWftGcUzG+Z7E8QrsYRY0BiOHrtukasCRtsjXpaQ5YwnDdE4Heeah58qjVa?=
 =?us-ascii?Q?S0sE6ZDu5tpr7zTfsO9ENxeJzG+n2uld7SSkX2IIqGE/K9j7gNoMaJzkdRxF?=
 =?us-ascii?Q?TivxNnb/fgUJyiy7XSXwImeK6KSZN+I8pJJXdobnNjjlSqKxKiV4w8H0+ZSU?=
 =?us-ascii?Q?EZlTZUzaX+nDF+1gQgUr+EF6LMUSP8qnRBGt1BU1yUfAxH+2dmAWvtQMXxJm?=
 =?us-ascii?Q?6FTn0dRpnuEcSpHTMO6iCHN4mSlnV8B27Js3clDK9Ge9GGZAEkFVMk70NVaB?=
 =?us-ascii?Q?6Lmzh8hrgcU+pvAIlwMr3/7z7XMUteJ9FB/xcjVr2kEOo3z+UhWwr5A5zAXw?=
 =?us-ascii?Q?P0x44paqrvTDRfbBnWQWLTcv1utXGDUapzFCaMyVul+MRaJk2AtfpWNBVpeO?=
 =?us-ascii?Q?luOw7c1YD0alTceB1FxynhzPQavJYLJjXX2rvlzOd6Y8uxncvfqCvgHJGAED?=
 =?us-ascii?Q?42tZ1/uvERstqUlUTsfF1orxFg58yXU3yCz9isrWbK+CP76AcLMH83t+3ydd?=
 =?us-ascii?Q?OQVxNvrhORxDo/QLYlo0u7VaWDfcz6tBLu3ekhly4IGJd+eqKQnNUXA2XCr1?=
 =?us-ascii?Q?EfJZy2JetKqpuhyGXfdox+F1X9QaGUDgro/uEmmP9scBo+2+YuddqrmlI/3K?=
 =?us-ascii?Q?oUYedEKmti141fkgyzCESjyW5tVN1l9507XdLhFfxBnule7jzY1BT7XtG5VK?=
 =?us-ascii?Q?KlB2jsJpYmne8an4dxb4DKXI1R56VYSsH32/jZLO0vFFGVjkSWmP2ljBhtua?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1904b57f-77b6-4e4d-9275-08db34c073e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 03:55:38.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epFiaNWwxa6tMS3k5dQhNS9kr/Rzi59hNQbvt/g2hYrkBAY1yvXHwlgoKsnpXS9+I5SQRhf/D7LVoU1iZasiw8XiqgUc6Pp7DeB11xhOz+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> Changes since v3: Kan Liang gave feedback on v2 incorporated here.
> - All updates in patch 4, see details there.
> 
> Updated cover letter.
> 
> The CXL rev 3.0 specification introduces a CXL Performance Monitoring
> Unit definition. CXL components may have any number of these blocks. The
> definition is highly flexible, but that does bring complexity in the
> driver.
> 
> Notes.
> 
> 1) The QEMU model against which this was developed needs tidying up.
>    Latest tree at https://gitlab.com/jic23/qemu branch cxl-2023-02-28
>    It's backed up behind other series that I plan to upstream first.
> 2) There are quite a lot of corner cases that will need working through
>    with variants of the model, or I'll have to design a pathological
>    set of CPMUs to hit all the corner cases in one go. So whilst I believe
>    the driver should be fine for what it supports we may find issues
>    as those corners of what is allowed are explored.
> 3) I'm not sure it makes sense to hang this of the cxl/pci driver but
>    couldn't really figure out where else in the current structure we could
>    make it fit cleanly.
> 4) Driver location. In past perf maintainers have requested perf drivers
>    for PCI etc be under drivers/perf. That would require moving some
>    CXL headers to be more generally visible, but is certainly possible
>    if there is agreement between CXL and perf maintainers on the correct
>    location.

I am ok the bulk of the logic living under drivers/perf/

Are drivers/perf/ folks ok with a:

CFLAGS_cxl.o := -I$(srctree)/drivers/cxl/

...or similar in their Makefile, because I don't think this by itself is
a reason to push CXL headers to include/.

I say this without having looked at the code yet and whether this driver
will need new exports from the cxl/core etc.

> 5) Patch 1 led to a discussion of how to handle the self describing
>    and extensible nature of the CPMU counters.  That is likely to involve
>    a description in the "caps" sysfs directory and perf tool code that is
>    aware of the different event combinations that make sense and can
>    establish which sets are available on a given device.
>    That is likely to take a while to converge on, so as the driver is useful
>    in the current state, I'm looking to upstream this first and deal with
>    the more complex handling later.

What's "this" in this last sentence, a canned set of base counters?

> 6) There is a lot of other functionality that can be added in future
>    include allowing for simpler hardware implementations that may not
>    support the minimum level of features currently required by the driver
>    (freeze, overflow interrupts etc).

Curious if the the minimal set determined by the specification, like the
minimal features a CXL Memory Expander device must implement, or by what
you decided was fit to be emulated in QEMU?

> 
> CXL rev 3.0 specification available from https://www.computeexpresslink.org
> 
> 
> Jonathan Cameron (5):
>   cxl: Add function to count regblocks of a given type
>   perf: Allow a PMU to have a parent
>   cxl/pci: Find and register CXL PMU devices
>   cxl: CXL Performance Monitoring Unit driver
>   docs: perf: Minimal introduction the the CXL PMU device and driver
> 
>  Documentation/admin-guide/perf/cxl.rst   |  65 ++
>  Documentation/admin-guide/perf/index.rst |   1 +
>  drivers/cxl/Kconfig                      |  13 +
>  drivers/cxl/Makefile                     |   1 +
>  drivers/cxl/core/Makefile                |   1 +
>  drivers/cxl/core/core.h                  |   1 +
>  drivers/cxl/core/cpmu.c                  |  72 ++
>  drivers/cxl/core/pci.c                   |   2 +-
>  drivers/cxl/core/port.c                  |   4 +-
>  drivers/cxl/core/regs.c                  |  50 +-
>  drivers/cxl/cpmu.c                       | 940 +++++++++++++++++++++++
>  drivers/cxl/cpmu.h                       |  56 ++
>  drivers/cxl/cxl.h                        |  17 +-
>  drivers/cxl/cxlpci.h                     |   1 +
>  drivers/cxl/pci.c                        |  27 +-
>  include/linux/perf_event.h               |   1 +
>  kernel/events/core.c                     |   1 +
>  17 files changed, 1245 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/admin-guide/perf/cxl.rst
>  create mode 100644 drivers/cxl/core/cpmu.c
>  create mode 100644 drivers/cxl/cpmu.c
>  create mode 100644 drivers/cxl/cpmu.h
> 
> -- 
> 2.37.2
> 
