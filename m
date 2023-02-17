Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E269A35C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBQBX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBQBXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:23:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76650AE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676597004; x=1708133004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4p/HB+QjboKkqNeWf4BTktJ6/Cr3E8duL2WrUMQNFDE=;
  b=mB89VErTQF4pjHHDvEigu6SdW/SdD/pvZtd15Mdmki7jfzYY1Fx1oCo/
   N+4ABtmCc65VkhyaA1FRYhgx/ujJEqhkeX+8cqeHnvMYbG4bLEkxtSGFd
   u1TB4EcS/taXxKDu/y1R4cPBtZ73Js5doTZmcKv/+jNi1QASHw4yFyL1A
   w19/gxLwSeWqXD/GKCuPnRf0nBINoUUi04RjSHFlkg7CgD7IXpAn642wR
   wIhWUzigZHnkJNlAjWmIL6yXssGFZgClRXzN/PKQknCODCnjXNu6T29gt
   voZ/l/VUHPYr247ueZTvNO56GzLZLkX/TUc323viE7oY6iqnSNYzWAQLC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333242832"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333242832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="759187289"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="759187289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2023 17:23:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 17:23:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 17:23:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 17:23:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 17:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4EUL/vWKIy1rb+VohOMNIylDKF+vpLo8JI68T6HI4wYnj/r3agPalR1NCSuzPJz2xA8rnOvr1sSS6+QSMoNqO9Gi5o+8L7woqblZHMNGvvLcJT2paFX4e2Se3abK2/MpxC/XbivEYEj801Aknv3Ig7tIKR68dY1/VJns6mfrBiBz9QKcQx18D94SLjDrzAa+YpM+GL0xdLHswZB9ewas495NWZx0MS4SiMdKmW/d7ALG+CM42wSvyIYzP08kVQQL3ERvgvvl26TEvkK5AHrlYwbO1Budz33KHISHXzFaLsSbWNy1TV+lwjuVo52/aqr2D0gmuA/r4kd2htZELw8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWnHWPVUYfg4vOaWepcsIDP6QfANrpyKyIjN/Sw0i6U=;
 b=dAcRqP4YC/+oYLmbRbeoqSu0ewxSZhRZE3YlraQ4BP/omYsvFybJKhXG5mO3ZOL2rW1ZZbkzbdMuEZaeG5X9JVo6CgX9uU7YepXGU+hwOWwTW88z7Qm5m4sI3x7pzaLGLQnnZqQ8nsMj6AbCAUo03dCVBY3V/y5MpyBNUJqC3YWhGI62FNuTAvhnSHSYit91QZiFSwWa7tV4ekDdx47EvCWZWVm5yrNh2sPOIwk+2Dwzoz0vi7Euy5IXU2NWasIWAdAPH9es1QbcZQ+3lfsaz/LicVxPgz1ysG24B7hD9Psup7nFk/Kk89bhQDPGQFj6aY0ISRL9le6io7uq3VF2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB6547.namprd11.prod.outlook.com (2603:10b6:510:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 01:23:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 17 Feb 2023
 01:23:18 +0000
Message-ID: <25fbbc7f-f137-c2c4-ddf8-d143fce1dcc5@intel.com>
Date:   Thu, 16 Feb 2023 17:23:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/5] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
 <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 176459cc-8348-4847-25a3-08db10858cb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaNTzyyfU/nFnja7hVxxFBhZUXjv8sw6n1RP5SxLhfw5ZBBjfB+jyQwy8xCD4LGlsIX609EYFV8u17LPvs6M979Bc8MyFbY3rzCeHmDY5QQQG/tVoeczhZVgflFaGiLwdDLrwNDGpsTXyRF3IX60hMPE+UmWe3fbZmkpzE8A+zTmT5blNOmrUCwHY61+nq9Iq4sEp8ZD/Lud4CY27CwcV0Wfxnq5T68zaBPhXfja3CWysyRqOUsAsuUdT7EQOUFIUp7MHfl5Rb0B5TR7XldSFacVgy5xIoj3Wet1RoXEOkKtYFRJww7TMhPFlgTHMDZ/NCjp5J3YpxMQhssFvpGn4kBJaEQaxPKS3okE8K1haHmSIf3QxS4bNhXIBm1BOd4pZW+sdSKQn0dyyEJtMUACcipi62uV/HKNxNHhYvemoIJsueiq5ki52S80wkqIxeRGcQNk9evwybhw21LNSplvFN2jCaSDZGEixLCvJ6jm/AaCna8X7B4FEP8LMHF+yTYLHDcypYzacudXZGR2UY9OfwO7YrOwfLiQLie+r73x4+vgs8EqzarLbplBzCWDcNswyjzNOb/zDifRX03/XMReBXfjUybitfuhS58UnRo5ftxNnpGj8QHgUa9JzuOBQeKTEODFGChiNXp9NRuz2kvJvlP5UVzVW1wqJ6shf8udj6lF5dTRlYMs/BqwnGtjvPfUVyLxXNXA4Uz/odyQyXXO5qEc8AXQE+UAFhLbW162dkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(38100700002)(83380400001)(82960400001)(44832011)(36756003)(31696002)(86362001)(5660300002)(2906002)(8936002)(7416002)(41300700001)(2616005)(6512007)(186003)(6506007)(53546011)(26005)(6666004)(316002)(66946007)(110136005)(8676002)(66476007)(54906003)(6486002)(66556008)(478600001)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklIUTFlTFhocmlETHdHTmdCU3VBMG1naFZYYWtGY2RlTVRud1Y5bnc2bDFq?=
 =?utf-8?B?SGM4NGRodHZES3Nhb2hnYXlvN0xwckpaM2hCcWpaa1htTDVkazZCOVd3ZWVz?=
 =?utf-8?B?K0VjR0NHcUIwcWdnbU1sWGxTMDRKWnVGdk14Mk1EMkUrcTdzNEZ5MUczSVJx?=
 =?utf-8?B?VkM0U3haOHJBZHB0d1BQa1dnRkR5ZFRHbjNxL1BwcGY0SU9xUTJKUTQ5VnpO?=
 =?utf-8?B?QlMrTnVIaFZ1cHBzME9LWXRXbEJCMHo2emJZcWxGLzNHdkdEN1dKdzNLem5S?=
 =?utf-8?B?NDc1Qll5di83S2h4cXRWNzkzTUVxQUtPREZnejF1RTNFN1BUVmUxT2hLdyth?=
 =?utf-8?B?cWE5ZGVxamVjL2JPY3VUcHU3MmNad21ybjAzT2JYbnNFMVQ1YWF5QURMM3BI?=
 =?utf-8?B?S1JUL0FzZFljeU5SbWlKMDNJZHkwanFzSmoxZGlib3hrTHNETGdQdEdBTjgv?=
 =?utf-8?B?S1B2amxnMUxJWHUwc3ZPRWFUQy9SaDQySUk5NWplV0h4VEltaS93MGJCY3dh?=
 =?utf-8?B?MC8zWlR5SEo2WURiYkNnS1BveG14R2xlbHpYN1poV2tXbkN0VHBwKy93NDFn?=
 =?utf-8?B?NzJqd3JmNkFLVTJBSjd1Q2hsRmlFRHVXdXpuOGh2R0Z4d2FsdC9PWjN1VTN6?=
 =?utf-8?B?TFI5WHp2OFZGZ1MwQVdEY2VZdzZFWkhRQUlUTllHNkpCYUwzT2lGclRlakR1?=
 =?utf-8?B?MEFweGJNWFB2d1NDNktHNS83RldEa3lnczRSZjdrL0ozT0FuZFloMWR5Y3VJ?=
 =?utf-8?B?QXVwc0lUUWZPaDFSUFFkSi80dzZIZzVNTzcySVZtMlJTNTJaaG5ISU01ZTV1?=
 =?utf-8?B?TDdnRVR5MGlreG9MT0J2ZE12TmRMd2tzZ29scmZkZnl2MmM5NlVVTnEybU54?=
 =?utf-8?B?V1NTSTNzakhmdkdoaXEwc0RkaVREaDZqWmFNYlM0K2ZqcU9iUHRWNGpBTW82?=
 =?utf-8?B?S3ZXVWRpVXk4a1Y4ZExUdFZLbFhtYlc5QWVFU2dDMDlkQjVhN1AxSTVQVklY?=
 =?utf-8?B?akJ0eXg4VW52NDlnV215NUJGbnR2eFF3cEZFSzJBbVpQMjdsdzhmSitOa0sw?=
 =?utf-8?B?RW5YWUpsRlBnVXl5VG56ZllMSmVMUENhUEgvWkMvMFdaS29idDAvWHgvSFpI?=
 =?utf-8?B?RTVYbUNEWVJGbFhVbzZyeG9lNWlxcEZ5SWRoVHhZd0phTTNiUHpEUzBrQlBs?=
 =?utf-8?B?T3J2cHhnK3lhSUE4SFR3ZFVXNVNHbFdkQXhDWjBXOEhKS2hCcjk5dXphcExY?=
 =?utf-8?B?R0RtZ1BnOVJzdmxPSlNYQjFNL25Sb2pibFdDb0pMZHloYmNkTlUzUGMvaXpM?=
 =?utf-8?B?OFVFVldETVZBVFBib05ZckdRdFFjSDh2QnBxNTEvaXlKRE9tMzZrWFJUcTVI?=
 =?utf-8?B?RzVRQUVKM1lVUDVnQU5KakY2cUlJcGR5bHNLUDR3NUFZRXcxUVRHU0F4dmpC?=
 =?utf-8?B?elMrY29CTlhWMHFqTVMrUWQwMnV0c0MrU2tkcm9DcGNBZXUxQ3c5WHFFS3hx?=
 =?utf-8?B?cEdTQTFGOFNUZHV5MUtIOFY2Y1hOK045TFhXV3A4NzNDbnFTcWVCZTQweVY0?=
 =?utf-8?B?QkxGNWgxWWs4aUVHbHlxNHpVM2pOenp3OTVWK2pXVkxmeU1ORk1QRlJFL093?=
 =?utf-8?B?YkV6TFBuUVoySVEwM2JTSkM2NHh6amhwZ2YrV2U5Mm42a200dUtWcTc2ODVj?=
 =?utf-8?B?elk2UFd2TFpabmxUT0RxOVhma0FCUjBiZVhqWDdtVXNuSzBUSTM5N2dCNWhY?=
 =?utf-8?B?UVZDT0hPamNRTWliMitzaFI2dVZ6OHVXOGlDdTk3d1NuQmRxMG56SERFZjEr?=
 =?utf-8?B?RHl4Z1QrUDFablhxd0l6OUQ1RSswY1hMbmVMNXovSzJYNlROUG9DTzRUMlla?=
 =?utf-8?B?NFBhUWMxci9PZEZ3bFc1dnBQL2tRakdoNVRlbVl6OFhaYjdQZyt2Um5vL0Ft?=
 =?utf-8?B?VE11dTlXOGZDc1doaXlWNjV3UGs1Wk44dzdWVjYxUVpKSEQzNlowRldJOFZo?=
 =?utf-8?B?VmFqRXVIc05DY0I2WE5kWmdsMldtb2JiOHFSM0hsNFJKSUhqVjdBcFFXNlhM?=
 =?utf-8?B?VjJhR2pidW5tZDlJcnNsdnFtWFMrYkppQUJiZWYvRnpTNWw5YWQ1TzB6azNp?=
 =?utf-8?Q?WK/Ywv6fEtRYhTJBPv5s3gga/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 176459cc-8348-4847-25a3-08db10858cb4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 01:23:18.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6loLpHrukFaeVS5AXQDjep3XzVOdO4aTNL5DCiHCjPcAlWPsdGsBOaiW6x5hciVx/9HkFn5/nWm301sMcPpVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6547
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jacob,

On 2/16/23 15:59, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   Documentation/x86/sva.rst   | 2 +-
>   arch/x86/kernel/traps.c     | 5 ++++-
>   drivers/dma/idxd/device.c   | 8 ++++----
>   drivers/dma/idxd/idxd.h     | 1 +
>   drivers/dma/idxd/init.c     | 2 +-
>   drivers/dma/idxd/irq.c      | 2 +-
>   drivers/iommu/intel/dmar.c  | 4 ++--
>   drivers/iommu/intel/iommu.c | 2 +-
>   drivers/iommu/intel/svm.c   | 2 +-
>   drivers/iommu/iommu-sva.c   | 2 +-
>   include/linux/ioasid.h      | 4 ----
>   include/linux/iommu.h       | 6 +++++-
>   mm/init-mm.c                | 4 ++--
>   13 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> index 2e9b8b0f9a0f..33cb05005982 100644
> --- a/Documentation/x86/sva.rst
> +++ b/Documentation/x86/sva.rst
> @@ -107,7 +107,7 @@ process share the same page tables, thus the same MSR value.
>   PASID Life Cycle Management
>   ===========================
>   
> -PASID is initialized as INVALID_IOASID (-1) when a process is created.
> +PASID is initialized as IOMMU_PASID_INVALID (-1) when a process is created.
>   
>   Only processes that access SVA-capable devices need to have a PASID
>   allocated. This allocation happens when a process opens/binds an SVA-capable
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d317dc3d06a3..d6fb03ebf548 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,7 +40,10 @@
>   #include <linux/io.h>
>   #include <linux/hardirq.h>
>   #include <linux/atomic.h>
> -#include <linux/ioasid.h>
> +
> +#ifdef CONFIG_IOMMU_SVA
> +#include <linux/iommu.h>
> +#endif
>   
>   #include <asm/stacktrace.h>
>   #include <asm/processor.h>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 29dbb0f52e18..125652a8bb29 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1194,7 +1194,7 @@ static void idxd_device_set_perm_entry(struct idxd_device *idxd,
>   {
>   	union msix_perm mperm;
>   
> -	if (ie->pasid == INVALID_IOASID)
> +	if (ie->pasid == IOMMU_PASID_INVALID)
>   		return;
>   
>   	mperm.bits = 0;
> @@ -1224,7 +1224,7 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>   	idxd_device_clear_perm_entry(idxd, ie);
>   	ie->vector = -1;
>   	ie->int_handle = INVALID_INT_HANDLE;
> -	ie->pasid = INVALID_IOASID;
> +	ie->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   int idxd_wq_request_irq(struct idxd_wq *wq)
> @@ -1240,7 +1240,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
>   
>   	ie = &wq->ie;
>   	ie->vector = pci_irq_vector(pdev, ie->id);
> -	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : INVALID_IOASID;
> +	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : IOMMU_PASID_INVALID;
>   	idxd_device_set_perm_entry(idxd, ie);
>   
>   	rc = request_threaded_irq(ie->vector, NULL, idxd_wq_thread, 0, "idxd-portal", ie);
> @@ -1265,7 +1265,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
>   	free_irq(ie->vector, ie);
>   err_irq:
>   	idxd_device_clear_perm_entry(idxd, ie);
> -	ie->pasid = INVALID_IOASID;
> +	ie->pasid = IOMMU_PASID_INVALID;
>   	return rc;
>   }
>   
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 7ced8d283d98..417e602a46b6 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -13,6 +13,7 @@
>   #include <linux/ioasid.h>
>   #include <linux/bitmap.h>
>   #include <linux/perf_event.h>
> +#include <linux/iommu.h>
>   #include <uapi/linux/idxd.h>
>   #include "registers.h"
>   
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 529ea09c9094..f30eef701970 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -105,7 +105,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>   		ie = idxd_get_ie(idxd, msix_idx);
>   		ie->id = msix_idx;
>   		ie->int_handle = INVALID_INT_HANDLE;
> -		ie->pasid = INVALID_IOASID;
> +		ie->pasid = IOMMU_PASID_INVALID;
>   
>   		spin_lock_init(&ie->list_lock);
>   		init_llist_head(&ie->pending_llist);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index aa314ebec587..242f1f0b9f09 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
>   	desc.opcode = DSA_OPCODE_DRAIN;
>   	desc.priv = 1;
>   
> -	if (ie->pasid != INVALID_IOASID)
> +	if (ie->pasid != IOMMU_PASID_INVALID)

It's better to change to:
+	if (pasid_valid(ie->paid))

If pasid_vaild() is called, any invalid PASID value change in the future 
will be hidden in pasid_valid() and won't impact this code any more.

And checking pasid_valid() is more readable and meaninful than direct 
checking the invalid PASID value.

>   		desc.pasid = ie->pasid;
>   	desc.int_handle = ie->int_handle;
>   	portal = idxd_wq_portal_addr(wq);
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index bf0bfe5ba7a7..c567f94b66c7 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1933,7 +1933,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   		return 0;
>   	}
>   
> -	if (pasid == INVALID_IOASID)
> +	if (pasid == IOMMU_PASID_INVALID)

Ditto.

>   		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> @@ -2014,7 +2014,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>   		if (!ratelimited)
>   			/* Using pasid -1 if pasid is not present */
>   			dmar_fault_do_one(iommu, type, fault_reason,
> -					  pasid_present ? pasid : INVALID_IOASID,
> +					  pasid_present ? pasid : IOMMU_PASID_INVALID,
>   					  source_id, guest_addr);
>   
>   		fault_index++;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a295e80fdfe8..10f657828d3a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -876,7 +876,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   		return;
>   	}
>   	/* For request-without-pasid, get the pasid from context entry */
> -	if (intel_iommu_sm && pasid == INVALID_IOASID)
> +	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)

Ditto.

>   		pasid = PASID_RID2PASID;
>   
>   	dir_index = pasid >> PASID_PDE_SHIFT;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c76b66263467..be98af2fce06 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -274,7 +274,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
>   	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
>   		return -EINVAL;
>   
> -	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
> +	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
>   		return -EINVAL;
>   
>   	svm = pasid_private_find(pasid);
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 17821ad5bf9b..1f1b4d680ede 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -41,7 +41,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   
>   void mm_pasid_init(struct mm_struct *mm)
>   {
> -	mm->pasid = INVALID_IOASID;
> +	mm->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   /* Associate a PASID with an mm_struct: */
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index af1c9d62e642..9ef22552376c 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>   int ioasid_set_data(ioasid_t ioasid, void *data);
> -static inline bool pasid_valid(ioasid_t ioasid)
> -{
> -	return ioasid != INVALID_IOASID;
> -}
>   
>   #else /* !CONFIG_IOASID */
>   static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa22..f04d3f05784a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -193,7 +193,11 @@ enum iommu_dev_features {
>   };
>   
>   #define IOMMU_PASID_INVALID	(-1U)
> -
> +typedef unsigned int ioasid_t;
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != IOMMU_PASID_INVALID;
> +}
>   #ifdef CONFIG_IOMMU_API
>   
>   /**
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index c9327abb771c..a084039f55d8 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -10,7 +10,7 @@
>   
>   #include <linux/atomic.h>
>   #include <linux/user_namespace.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu.h>
>   #include <asm/mmu.h>
>   
>   #ifndef INIT_MM_CONTEXT
> @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
>   	.user_ns	= &init_user_ns,
>   	.cpu_bitmap	= CPU_BITS_NONE,
>   #ifdef CONFIG_IOMMU_SVA
> -	.pasid		= INVALID_IOASID,
> +	.pasid		= IOMMU_PASID_INVALID,
>   #endif
>   	INIT_MM_CONTEXT(init_mm)
>   };

Thanks.

-Fenghua
