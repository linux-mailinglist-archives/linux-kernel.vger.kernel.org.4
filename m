Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638E623ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKJJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKJJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:40:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEE26EA;
        Thu, 10 Nov 2022 01:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668073253; x=1699609253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dktSg7v+3fLCU0GIAusOb0jSb8PStTxjWXnhfddq8kY=;
  b=jpyiylFsKt9c9LsH9g/D3G4nN1oR/mXwf0Ls59t0Q5ZMGwJalt8zWQ2A
   4iZT72dYVNyqUJkwYnmBmf3AJzallfah4KKrFe1Fj3Ls9aqHHpOjIAp59
   bBfO1A/PgOeFX50G2qWfDnEDEr8ENaFzc/DZSO+tXPBI/ldyYYxsH6iEz
   KFG8yGazj7U+0UR6cLwbyruiKNlNh6H3xecRkwgDLlumvjsFs5GTNdQpU
   yi94+ChUOtAnfV7Bs5UHA92A0kwwFK+cfYhbHmf7SjnkO6rmOFplkVyq8
   +A6K9+MIxOjzfNXhL+2XnVz6A+30jvMPL6knXefzqSV1HMrdm8OpokRuK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="291664456"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="291664456"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 01:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="637109971"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="637109971"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 10 Nov 2022 01:40:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 01:40:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 01:40:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 01:40:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 01:40:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX7fdrW5P1yABy8XCCBk9rREpFx5qxdvT1pk560AYqy6ljvZB9DJXjpdykPs8xo2BBlbHwG7KEygqtBJVG7tOapvnsgsl5+vQEst4nPjKKXBYb0md6p+0sqIsuC6GqpCd3znWgIn8a3No7wN2zwpl66EyAiCIIOla/Ug4OKUsrDnplXc0y2cCOnJQlHfNr0HxaXz7fXtm+u8+TFIkhK+bZeQjAiO93lUPxNTmb9vgeZPQQoToCcCtZkVRJ9Xo8CipsFLuoFRhwEcTYZPkZ8ZS0hbw2AcOuoGnkDS5cAdMBT4w7O+2R9ySxIz8oKdNUgx/8XBeSG3gQrD7VYuEIxR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0cHTKDxru+NcuUCOPszwkTqt9uzVfids4+h8RkyBfA=;
 b=dSxdoUY1FSfY+Ni6BMh8NFSC0zc0vXOFV6sl7r3QGHwY0TcNpNrYla/r/hmJn69TfFTH2IOOaJyY51Y5DItaY6nId2Z7xr3QY9D0qrNkMOZPS3ia0IAw9f1wPGbVsOP7bLNNnrC5bpquI/K7QmujKDmCcm10qYcZlHOzVoWVxRGStbsncwq+LRxd85NxYVb9vs7mn8OsvCeTCp8pPBT80trRWaIRb7CN89xnDy22Kw/x/TemxgXy6TWET1gaEyVaFdSPe2OL9AyWh8wTHeYVWpzsGjHHK8h4ROKHI/BH95Gj3TTbzfbQU9uWjbV2mu1XB9vMJAFi6c2m+KuNFDwKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY5PR11MB6463.namprd11.prod.outlook.com (2603:10b6:930:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 09:40:49 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 09:40:48 +0000
Message-ID: <63635101-df2d-c698-6112-8db2e747a95c@intel.com>
Date:   Thu, 10 Nov 2022 01:40:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
 <a0f6723b-ecfa-ba5b-5779-c7326cd31a86@intel.com>
 <6b98f0ef-8529-43eb-1774-ba81c0bb0839@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <6b98f0ef-8529-43eb-1774-ba81c0bb0839@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY5PR11MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 701bb734-6833-41d1-3622-08dac2ffa622
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anNgOgHrzIJCgwrkQOE6YpGVQYAzT5fk2bVGvxaZuy93YgPjroFSJpd4HoQ1riDGIHyjaOyauKW3d6PL4N/BWWcGjJV2QMquiS0K/drq0UqGvP+NgSmQnGBlxJg25vZ/tnnOQESY90G4yneAoZqgqKkwd5tV+GXMg4p63cFGLeuO8skJVp6UyrByoCWywPEfGHLU9hXy+IyOtnbz+rncT5FshQnNDRPrVL7B3/H1bUa27FfYjrVaa2wXkVDjb1k9WMtj3YeXKpUJ1dPfbceSRt3G0i5c1dSplgaXjpzysZwWeM1Wh92ZAIuG00NuZGwThGAeUi8lbEGEWzxZ0oRu5u/uypl6yTHcdfcnguZKTTOXA9DYjRBECboRrVrXan5QdmflxDHlC8c/rJHJK92EakIMYap0uUqp/qxdQOtdyXZFDXjIL3XkV9orCyX+uaSYePTG0rOpdaafvl7NxpRamOD61jrLHNY+9FOewFiOEemRVwoKW5L1BqYmL+rKScKIxYuAifaXrUUlPqNeNgZJpVQ3tXJ6LHXb8pEGGvmn1i9N8rwmGZZhOmMkTbWPDZH0Px1FRWOMIoFheMokqBfIEH8HaZJPCFWZkW+5TugrLORMExWvuJpE2GJtPAtZboK1Y26B+ABhdC+zlZRoQLG+UO+eUp7R5wdHCx3AmrAxjBT5SVJzbB6T+gQpVV4Kwtv5v9+aKXLJyHw+d+Xb+yXqb7UvYKVx0fNHELchDTVYc1bDhYQauwR6E+uZUJk34pcAxCTKJNG1Eq0GFaHIQMWd0oXsV0rqtJGv4ohPBusH0BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(86362001)(82960400001)(83380400001)(31696002)(44832011)(36756003)(41300700001)(38100700002)(7416002)(8676002)(6512007)(186003)(2616005)(4326008)(66476007)(66946007)(53546011)(316002)(2906002)(6506007)(26005)(66556008)(31686004)(6486002)(478600001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNzNDV0RG1xVHR3VXBIZXZHTkExSVRhemE4QzRneXoza0UyY0lodng2OUxl?=
 =?utf-8?B?b1JzYzBkRHRNUGF1M3hkYlNNeTU2N0FaSmZwK2x6aEdDY0M0MjEwVndlUUJB?=
 =?utf-8?B?ZHFZUnEvOWhYcmtWM1htUWNORFlyQ0RmVlJnSlpQMHgzaUNlSVkrSUJBZmt4?=
 =?utf-8?B?QmdjWWxxWGNBYXZveHZYSVNsc0xhVUxZY1JWb3EwRG15T1NxbVNjNkFYNDRv?=
 =?utf-8?B?bDBHKzNmTjBYT2VtcXJ5b2FuN2RDR0dYcG1pOEF6NkpzYk51cnEra25GaUZj?=
 =?utf-8?B?NFRzbTE2enU2eWdVNlpvMU1LL0phSDhJd1E0Qnk4TFMzZy91V0NIcVBzWWJv?=
 =?utf-8?B?MkIzNlZ1ZTQ0VkladVZEcFIrZTBBTm1xTGtGSmRidFNJdHJvQ0RVWlNrMFlT?=
 =?utf-8?B?SmF0aDRpWWI3VE1JZ245N3J3MURBdjNFYzFHZVZHMUk0NCtGTFJGSjlvMGhE?=
 =?utf-8?B?ZUMyTUs5cVpGaVYvVml5NGdWQXN0RVIrZjcvSjFVV2J2KzJUQzdFL3M2WmEr?=
 =?utf-8?B?UmV2OGVtbUErbHRYYXhZNi9FeW9DVFd3UFNDSDdVMjdPb2cxT1ZSMWFlVmcv?=
 =?utf-8?B?MUUzMEhSRkdUeGtQZ1VxODlqYWdsL2R6a1o2dHJuOUZDbkdEK1pCTkdCWjNN?=
 =?utf-8?B?aVJWWmJ6VTVwZklnVUNCYXZ4WStMaWpDYmVWbkxPZGlVRjVHWVNGWHc4bWxW?=
 =?utf-8?B?Slg4NGh5dG1MM3B5VVN2WkxUSFFBUFJocUJ2QlVlRXdxUVJBUS9tUHZlY21E?=
 =?utf-8?B?M1Q4amVUTmVaZUdqWDAxMytEWVpBSTRHSXFJWkpQVzY3Y0xuL0g4UVAxaElo?=
 =?utf-8?B?VklmMkt1OWVpWVgxanViSTZxNXpNQkw3OGN5MFJyWWRiRDdtRXovRVk4Z3RV?=
 =?utf-8?B?MEI3Nk42emV0NU16RWhVdHFLTDlTa1kzOVhFdHM4TzRIYmdhYXhkL201Zk14?=
 =?utf-8?B?SDZseE1zT1pJYlFObGdOSm84WEVwMFR2Y3NYNG5XR0tHN2V0OHR6QndFOE5l?=
 =?utf-8?B?blArSllENUtHNmJTTnNxZlluaUkrbHduS0ZSdU5PbXV3U2g3cURUUGFGa3pz?=
 =?utf-8?B?SVpVV1EzbUVQaWdiLzRTWkNpZ21STXpwZzhrTE1iTmFmck5YaWwrb3Q3Tkdr?=
 =?utf-8?B?S2FpOXIranI4NlNsZFgzOUQ3MTlqKzZGVkg4NkJZZ2c2WlA4VHUrdEZJL2NY?=
 =?utf-8?B?L01QbGcrQUtRMUpqR2E4Z1ZvbVNoNkhEREVaQW9kYk5KSFFMdmFCUWZuZWYy?=
 =?utf-8?B?NU5VeFdUUitoZzU3Zi9nQXpjYlNFRVZGL3ZPNE4wL2V0d1hUb0ZzV1hkYjNY?=
 =?utf-8?B?Smp6bDlnQzVPOE5MUHgreUJMWkI5UTZNU1hPSjBZZUFrMU5ZQXkwbXRRbElI?=
 =?utf-8?B?V1NSWWJMMlZCY3Z2YnM3UGtFNHM3TkhZck5iM2ZBNEVKYmc4R0tjczh0NlBS?=
 =?utf-8?B?NFk0REp0N1FCSzQ0dGV4c1c5cFZXQUxLKzh2N1hXSWVKd0Z4eW8xZFNweEQv?=
 =?utf-8?B?dDhpZ0RJWGplNENkd1EwNyt4cmxMWTQ2Ym1FaDMvbStFQjFjcHl4YklnaUtT?=
 =?utf-8?B?RlFnL3h4cVJZOThqK21jdFQ0R1dhSzc2TDhsakt6V1Z6S3pCTzlBMkZ2b1M1?=
 =?utf-8?B?RXRNYlh5MklobFBTekNzaE9lNGVkVmE0RHIzeGhDdFBPTjZWKzZ1dks5VHJh?=
 =?utf-8?B?QU5FRklEUCt6OTRUUkFFS2NyMU4wZDduOUM0VG44QVRvNVNINlNkV2RSaU0r?=
 =?utf-8?B?bVVmSDBmcDJNM0hKZFdyQmJiaFhCN0hERllwTTRpaWtlSDVaQXV6c0RMeXJz?=
 =?utf-8?B?L2Y3M3NSZE5RdHZkdmNGd0cyZURNRTZwTEJibVhNRk1ObUdabGkzb1NzeVRM?=
 =?utf-8?B?NG1LTkVIaUhwY2dHWldlS2hnMmxmTjY1ZWVKMEVaZnRsd3Z6dkRUVDByOFpW?=
 =?utf-8?B?ay9BWWQ4T1ZLTzB5ek5jRmt4Qm5aMDk0M3hOV1daa0NQVUErR3VNZ1pkTnFG?=
 =?utf-8?B?cy9FRXpaVHU0aTlSWTJXdXdDSmFwL3hWN2VHUE1xTW1KVU5wTW9iVGNBVHpy?=
 =?utf-8?B?QTViQ1FuY2RKZU5SaEhDalpqYzdKSkZkdm43dG9Id250N3lXQkttZDJQenVn?=
 =?utf-8?Q?0B5Fd4PPdzxcTHQWjd1gNMXLm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 701bb734-6833-41d1-3622-08dac2ffa622
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 09:40:48.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwOzzRQHPAMAjIp9/o3Eh5ExTYc4Zv5oOvt3Ep2Ztwt6mwe4dR3r+Nh1r+jSxvFwKmZQIrni5HzAFrIvX9Y+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2022 5:22 PM, Joseph, Jithu wrote:

> Here is the layout of the metadata section in an IFS test image.
> Test Data (chunks) follow the struct meta_data  defined in load.c
> 

Thanks, this helps clarify things around the test data placement in this 
patch. I think it would be useful to include the below information in 
the commit message as well.

Given that,

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

>      IFS Metadata layout
>     +----------------------+  0
>     |META_TYPE_IFS (=1)    |
>     +----------------------+
>     |meta_size             |
>     +----------------------+
>     |test type             |
>     +----------------------+
>     |fusa info             |
>     +----------------------+
>     |total images          |
>     +----------------------+
>     |current image#        |
>     +----------------------+
>     |total chunks          |
>     +----------------------+
>     |starting chunk        |
>     +----------------------+
>     |size per chunk        |
>     +----------------------+
>     |chunks per stride     |
>     +----------------------+
>     |Reserved[54]          |
>     +----------------------+ 256
>     |                      |
>     |                      |
>     |                      |
>     |                      |
>     |Test Data/Chunks      |
>     |                      |
>     |                      |
>     |                      |
>     |                      |
>     +----------------------+  meta_size
>     |   META_TYPE_END (=0) |
>     +----------------------+  meta_size + 4
>     |   size of end (=8)   |
>     |                      |
>     +----------------------+  meta_size + 8
> 
> 
> Jithu

