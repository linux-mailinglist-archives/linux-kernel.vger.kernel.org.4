Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162F15BB09B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIPPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIPPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:55:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DEA7AB4;
        Fri, 16 Sep 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343733; x=1694879733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZZuDKfRErq2ZSGPgSekc1oBWSyRVcTDULW/my9/Oj6w=;
  b=ZVVMMJlanOwunD84mT0hql1K9pK3c13c0N6gk6qD/CXNLSdPUFMYc51g
   oPsRl6nZlSHeZ2bGjuNyh0jORNWyCWYZrm3nfBs8x4xFzePFcf/2uRMvb
   6s6cA8npUo7gedkZerxSkAEmwveeC6POdk0Q62Bz4QwNUrt9YbZmEKmWQ
   1S052I3+HNk1835wvdfv3Jsu3b/ZKT/bWyYhNhwjs7Z/kJvMx7iXS1Tlr
   JkneYnPgL4Hi1fkGh1Zh2WEeM639z5WEZg1u+tn3eIgO6NqUp/BshzVqt
   vSfsEPhnGJBOu15aGJycxKbVsXTqO+NuBXfei7XalITvOfqf+kmc5YBuL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300381215"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="300381215"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595292362"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 08:55:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:55:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNAkXNgDOokL4JSwLyC4gz6z0vAXqMjw6dJdHKIycCWNvBxM/ka8NDKTDlU/epfxxyhwr8swC3i+yisD8U54FI0YngqiR/lHZWOHyf+wLF5011KXlcQ/9mLy/jrVw2vw0HfPFnfDCyvtrMKlAmn0YDeuQRqRJ7QEhvAGKv0LHrddaF9i+BU8rgvARioL9Cc09qH3iTIjtk0IKwNmoNEZg/gjPTvunn41t44c6rNYG4sre+PzCksBlRs5hUOOl7j+1qoc+VMuxG/kyD5IxX/X1OmR6tJheYihSzRweP2ZQrkiLdh1RyGfHYJbKM2/sM/vswb/Nq8VEo73KleThcCy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hVUXolVRV8qUw5sGASzH6SL35sF2uIH8ZTtvs7mKNY=;
 b=K4fu5eJFayChW4FMSVb+TJE67fJRKDDuwpQ+fJ2wQVP0xy3NhZNDYS9zoD8iutb92YJ/IsyB9xXsIJPl+3HCnO3tZ1mtWAr+fac5MFubwlMY680tWiy+/ggEplgbYpHA62ziorUCf7Cd9MBbJ22/rEZsdOCatvSVPOgye6ooYrw6yayevkpELuz3orl8m5qMIj9dQfMka40lY2mdPOnAA/D4RtAZQP0OSJrPKKyZaCB1hoOZ1N3d16duwQADVWi1o0lALPxOEmdDnNIrK3g8s21tWRxAZ1HeqLDxImq8cJXb0Pytu1ihJOaiPIrFJ9VhlFl3oayQ7N/wWxCmf4n+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:55:17 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:55:17 +0000
Message-ID: <c4a9ea23-4280-d54c-263b-354ea321f746@intel.com>
Date:   Fri, 16 Sep 2022 08:55:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: c4867841-94d1-4a8b-3e9b-08da97fbd9af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SG2up2fp6WVGRFNqDA5J7BuBrztA7abqsZuWaXJEs4haWccmGUQsA2exbk2LwZ2QzLS0gZuYHo19woRDD7QKgzOFWshYhN2QfTjCPzdsmUCnFhBukIhmezfqtGRorWdb1kgnFcdCrBNC+IDNpIOvyr2bfBBOLwhxk7K2wFEOS10/l4IpXQsAhogopMo9SXoMBKTLEH237l3wutA0PGzYL1V9JeF+kvFuhkl+wuSAcjieG2x3rL61oNBkkPoubSUedYCpyN0Loq3acynpLUD7W9NXgJrrojfFEUb7doE6miAhJKxukEr7HXtZrVI2WynIc/oEUxsvKiGSMnyq+NqXskVqG2DLTlc4TiIjzVCDJn1QiR/3O8DthzoSc/rd6/5m0Xex53j1IcaJAnbhNXxKt4V4JDszQoWJ/qPPd8Dbu8yPlJqxS162vUFT2SnQv7Yu6iNRrZJN7enWf7N79bGmqXZ7YSGD8rNkXX0xtGzpoD3AGzWhPZakGcltSOU1G1prIu2CzQnkUD2aWx1vqCQVIHZ1gBhfJIFC7Wmhyy6hdr2d/O51FWW6NIemOW2uP8s4FcNOx0vdLpRWdKIKU2/2Xvl0WcFUuCPoKBl6tHIGM9bW70d/OFtwQazZdJF+5hF0LFu9PEMcY7HqSjpXdnkLnwgcrig2tQI/j1/fYf79VKF0ozmSbX0SuRLKrDmB7am0TtnjlJ4yMl+xQjWuzTr2Z1cLsGXkjmaV7imEaV6jZuhZZgNXgl6uB6GRBjg6RSHOee5LGyIrs3u75DE9L3L28WMjoRw/FzAF/4JWagI+u19I6Js7qn9CWcLVaQ/L0K3o/rn0u1FIzQCqynrRb5A04vICiKOJzSzi6lc1AnC86dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(83380400001)(6666004)(966005)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlUVmdJTWtoUFlqcXdoWjFRNXN6R3B6QUR6MVY1dVpxdkdrdVdMNWFtNWlR?=
 =?utf-8?B?OXBNa2dEUENZWC9Ua093M1IvYzN4MmhwcDIzQlh3NnUyVmxJM2pDekdCWUxn?=
 =?utf-8?B?b1EyRGM3T2tKVC8zSEdFSDZPVXhzRHB4OXdnNjBORENCdS9kM3F3QXFrSUdy?=
 =?utf-8?B?eHBuejlpU1JJVmFCU3V4VGRqK3h0VWRXTWRJSFdpbm1kaXR0UDlqMkNNeWhj?=
 =?utf-8?B?bEhhY0RUSCtyaFh5RUFhVGtFaDNQOG50ZmFsWHpjOFNxOTdjK3RQNHJsWHZP?=
 =?utf-8?B?dVA0cDlJSk9PUHMxVUVzVDlzWnBSU0Y3WHJ2bVJ1a2JhY3FndlVpU0hSU01J?=
 =?utf-8?B?eUZOcEdVQkF3KzZNVGp2Y0h3U1h2WC9ESzltQnlLa3FTK2h3TkZZcEVPelJS?=
 =?utf-8?B?ekVrbFhSV2dBdTliVVZJRzIvcHdFck9xVEhqaVlVcEFvQ3NEYkV0SVpEUlZP?=
 =?utf-8?B?V3VNeDdHU3JFQWZmZmpIN3BVZXN5U1h1aWwxSGVMWDZhMzR2UTVBT3VMYkND?=
 =?utf-8?B?MURWSWs0dk9KbzJsQWZiVGViT2lzVDRQQjA5YWhMUzFWdXpnWXlaejFLVTFK?=
 =?utf-8?B?cVBrK1JOd0g3Q01ySlhxbVJGTGNxWHpITTBRczJKeHZDWENXNEUyUW0xVFcy?=
 =?utf-8?B?QWl6NFRpOE44QzJSanhrVzhRbGNiSWZmcisxcU1uNHpBUVBHcXNkaU9oMWJZ?=
 =?utf-8?B?am44VVNCdUc1aGt6bjRHa0NBN2pnaElTWmpzczFvcVA4SzJzRXFTMzhQcGc2?=
 =?utf-8?B?REVaUS9XYkd4SXl3S1A1ZXRrcVI3eDI0aE9ONU5QQ0ZjWEd0OU9QWXMvbjBQ?=
 =?utf-8?B?Y0Q4akJMbDJDVW1GMktOeFNMaU9HNjZXUDRKRExWeHNuTWhMbncrR0IwTnRk?=
 =?utf-8?B?REJqc0N2RmovQTNsREFnMGJyT3lNdTN1T0w0MzJqcndNK0ZGNythYjJmUExE?=
 =?utf-8?B?cWF0RmFEcS9CTE5Fa1VFSHpRUk5lcDhyUjNhSkpwa1hoandKZDgwYXVTcTRS?=
 =?utf-8?B?Sm5xdVNKZUZVTXBoN3hUNTVOazFrZjdyUEdpby94dzVQWDhLZHh4YnArdTB4?=
 =?utf-8?B?dXZLcDB5eHFJVjc2blNDZkZiSEpncFRwMzlyMmloeVp2ZTZzRnQ3U1ZkdkpC?=
 =?utf-8?B?aTlTVkE2QzlvMUlPYmlLSU1qbXM0ZUFsRStjY0wzcFlwQXd4U1pNcWhoY0U2?=
 =?utf-8?B?RkxQMmdCaXpDYTljZGJZakt4aFVvS3VyWWVrL3lCZ1pxNEdtMTZVSWZ6TWRB?=
 =?utf-8?B?WU1rMzRsOHlYc3JGVGZ4eVlVWDFqM3NoRWJYK2huYkxhSzZxSC8zL2NWbnkv?=
 =?utf-8?B?RnVURUcwdHkwaDY0TmQrL0J5MFF5N1A1UWJpVmdBaHYxK1NVZWhDd0szd2xp?=
 =?utf-8?B?MklLdjRQYnROQm5OWldwZUxnMjhkNXAwU3E1eURLZTFxS0xaSGxkMFNNeUpm?=
 =?utf-8?B?amtVcHBwbEVLSEM0aXRRNnUyaFlIMWhmWE9DUWkxb0Njd2ZTTGdVV0ZIZWx3?=
 =?utf-8?B?M0lKWTJzUkxSODVnVG03Q2h2cTdWSWd0Mm1UbXUzRHZmM3h2azR4TXJ6VUNp?=
 =?utf-8?B?SDIycTdIYzUzdUZSVTFFdkV6dWR6VHlMS3FreDRRaFpVNFNzeWhIeTc2Z1Vn?=
 =?utf-8?B?dWU3RFlSaUdvVjljRURkSjdqNnlxeVVBeEVPb3ZtRmVmN2hmN2x5UVFMd1Vu?=
 =?utf-8?B?YnRBRUhWODZQRzdmTDBIVFRXZS9QYkNBdVFlWW9JM2NScmZWWnFiUUtoSXk2?=
 =?utf-8?B?TG5DMm1KYWk5MVFDR2U5Zm5OUUtzMWZoV0xqL24rUHpWUXliOG9VU1ZGdFI0?=
 =?utf-8?B?S3dPcTJQa3c4Tk9lYWsyUHVRTEdDQzJoZGdnK1hNaXUxeFc0RHVXMzBjNjhG?=
 =?utf-8?B?Y1J6TTAyMGxpb3VsUVlHTUxxVUk2eGlQNkY2WkhLUC9vWU9QcGd1WW1TUkFz?=
 =?utf-8?B?SGlvT0ZPMGRmRk5veHAxenpvSEExVE1mQ0VtV096ejBMVy9XaWorYWhEVXRw?=
 =?utf-8?B?cXFjMFNPZEpzNVd4MjF0KzM2ZzhtcnhWc0plRnR1U3U5aGpJdVVubzkxeHlM?=
 =?utf-8?B?NTZiWkRXTUxWNnJRRzZRSXBBTVlpY0YyMFR2bEVBS3VMSitGOC8vUkVQRDFw?=
 =?utf-8?B?T0pJckZkQVJIa2ZZWnJrV1gyaWdyUVBKSGhBZjNGMDVFd0tYZm1yUkFpZ3ll?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4867841-94d1-4a8b-3e9b-08da97fbd9af
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:55:17.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J+8eLmgEQpR3/JTc4VlanEjOgYSIhLLiC9jMaIltHtu30oZRerkbSm4Faq3qr6HhhhjndgeT3k4oPs410Ny61vLn6WxPCImVWCTN7L3DOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:00 AM, Babu Moger wrote:
> Newer AMD processors support the new feature Bandwidth Monitoring Event
> Configuration (BMEC).
> 
> Support of this feature is available via CPUID Fn8000_0020_EBX_x0 (ECX=0).
> Bits    Field Name       Description
> 3        EVT_CFG         Bandwidth Monitoring Event Configuration (BMEC)
> 
> Currently, the bandwidth monitoring events mbm_total_bytes and
> mbm_local_bytes are set to count all the total and local reads/writes
> respectively. With the introduction of SLOW memory, the two counters are

Why is SLOW in caps?

> not enough to count all the different types of memory events. With the
> feature BMEC, the users have the option to configure mbm_total_bytes and
> mbm_local_bytes to count the specific type of events.
> 
> Each BMEC event has a configuration MSR, QOS_EVT_CFG (0x000_0400h +
> EventID) which contains one field for each Bandwidth Type that can be used
> to configure the bandwidth event to track any combination of supported
> bandwidth types. The event will count requests from every Bandwidth Type
> bit that is set in the corresponding configuration register.
> 
> Following are the types of events supported:
> 
> ====    ========================================================
> Bits    Description
> ====    ========================================================
> 6       Dirty Victims from the QOS domain to all types of memory
> 5       Reads to slow memory in the non-local NUMA domain
> 4       Reads to slow memory in the local NUMA domain
> 3       Non-temporal writes to non-local NUMA domain
> 2       Non-temporal writes to local NUMA domain
> 1       Reads to memory in the non-local NUMA domain
> 0       Reads to memory in the local NUMA domain
> ====    ========================================================
> 
> By default, the mbm_total_bytes configuration is set to 0x7F to count
> all the event types and the mbm_local_bytes configuration is set to
> 0x15 to count all the local memory events.
> 
> Feature description is available in the specification, "AMD64 Technology
> Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375
> Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 1815435c9c88..a4ee02a56d54 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -305,6 +305,7 @@
>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>  #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation */
> +#define X86_FEATURE_BMEC		(11*32+18) /* AMD Bandwidth Monitoring Event Configuration (BMEC) */

(numbering issue has already been discussed)

>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 885ecf46abb2..7981df0b910e 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>  	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
> +	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
> 
> 

Similar to previous - please use same coding style as area being changed.

Is there a feature dependency (cpuid_deps[]) on X86_FEATURE_CQM_LLC needed?

Reinette
