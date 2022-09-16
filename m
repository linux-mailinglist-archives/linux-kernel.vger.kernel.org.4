Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557735BB0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIPP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIPP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:59:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8455A237C5;
        Fri, 16 Sep 2022 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343983; x=1694879983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3dlr6QwHHV4fwB+YQ7qqVqGJHrWIkJE/3wJu4/J92Q4=;
  b=EbwXw5HCQ1ljXp56Uo5QIzrQ76bN6GPg59blwaKJdn2AsaSsH4YXfPci
   flvW6mlT3G70xOs49ppMFsfRBWlStxwe8HuNnWJ4EJlI0dIcLjuHElU6x
   vTo1flPRXImuPNHUUOmsoDCsUhUx4FUXhzV5JfkH70kzLLJYjwE9d9K5N
   tFgLIAXT7xVmLn2IVaFqrjjbeeF6nJ7/a/HjVNpErGVBhbcNdP9MMpQId
   vEWe669gPXAyrgln4GdplA1USib/Zse2mvRXRHtf5dBMHhFMUaT+26rru
   uBchkUPKltzGoUnjqhsTmd6Dj5nFtgFKoXRfgH+odfkyR5/+EJ911UVJs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="385311643"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="385311643"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="686183271"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2022 08:59:42 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:59:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:59:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:59:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH0ER4UihpwUuzDVY2bWHzKEzC5J/zGo6AWpaJA2TIA3FZAx6P2XGViazh64qTs91oyfq/30lDFPr7He+/UefegmGURoVJiJhlcFBYi3FjeukYlExuJq0Qb3AF4X8xeeu38nR81KgSI7Cq9kw3+wGIeUhg3d/p9iRfBNn8MBjzrLkjOmXdzs/ygs7mkleTWCoSPsD+ZE/ObHs2DSgG50CxpbnN8KJxeNhhfaSebV/UeTSAcU8MsmBh5pa0AsSOvURVAlWc1zpcqsQuK5O027bglF6tGzOf1S81SC3n762xw7ZsgWVBKpYGWq2IxbHrCITux4wiNfE5qlimBayAUVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dbTm1qckY4lwqx4qi62MLmoWAYsu6/wU4VBrHwsmkE=;
 b=DL/t4EFmZyFprMKaI0m04X9vw0CwUngqO9iL1s5zA35DGVdrdMJ3SXKd9oCI809QNvpbklbIto7iPQjuqYPfwJVOJwXYKNwqrykdR2GkY7aEJuSYCTFQsS2Aom8pMAXfNDWj3jtbaUeT6PEd+fQKhZ+UK+12Xsk3Vg6oObLkM0403mGpwa/9JVMXGMx6VUxyW89d7Ul8gTaqqBDFAJT7WMz/YEu6FdWJa13BJ2BwDLa64mDiBApXl2fD2dljWuZGLZ6xiYxfgoSdkEvEnWUydfJjl504mxkW0SLWIGaT6Bf8J4w/KePj+cS30lLdmHtpolIT85DmHB/roSP++aYTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 15:59:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:59:36 +0000
Message-ID: <36f0466f-517e-050d-5fae-9325ec28ebd6@intel.com>
Date:   Fri, 16 Sep 2022 08:59:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 10/13] x86/resctrl: Add the sysfs interface to read the
 event configuration
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
 <166257366902.1043018.16087054015308149859.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257366902.1043018.16087054015308149859.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c53cd1-d575-4f84-e909-08da97fc73f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnW/5We8wxyc0p7KyhAhFQizN5AaVEKFZnFgVwz3LIiCFw49g+0OSPG9MeLgqtM+3UYexmA2n2Fkd6F5VL0619kxnD6wVLTdPU3sN+Bv9oCna9N020/pJdQCvu7L8paMmXUdhmQDEvyKFVVByKHIglA2WMXrMY857qf5NCHPyn9uYYlMjQ1EcYgdE2do4c5rqqyj5HJ9ScEIVFzqf4h/wLKRzilgXVSKfWjMwowQHR7Zfun11UKygoObrP5hqr9FRIj+w2uP/D1exRbn/4WIKDiXFFAoPkESCEbUzilQptU/WXnLIasFWhbGniZaism76sGOxYdYyW8vhQJ5zk2NW4Dq5MTX9f6zV9dBgKeEpyEvN5o/j4HZy1vVreqJ9rQ0beqBXHgZ6iqIBWYEQ2+gwlVef3clV8+MMUgr/oc4iuWUnRRGlKH2kwxt56OosJEwR5HqHkJ8oTamRi+2OvaurU1DUPzrO2YJkTVu9/nwc7srDvJKKidbNMN/uETgdanL6CbG7qa12rerTz2a4tag6PdRI7HPrx9PNsh+E2YlJmW8mwX5x52CQI6qatETP5vy7KbtQh7g3ZXb08/FRMZV+do07OpKSZYAd9ylT1IIAr4frb9t+IKkC0X4bmwEKKsysc3IyNNQocmxVnYDDiFAnPIOv3Hx5G8iksTaYEOnC/Et15auv/h7wpX0jGsJaAL+FJmClnNf0VAwPP31Pe87S5wJVdpGOqN/WgsJmeLdEEkvHVO1lvT/RG728pafqQInieAGCgP+pAUGFijkUa7Yo1qSlwrk8m7gEtDpMWVb4vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(26005)(6512007)(41300700001)(6506007)(53546011)(6666004)(31686004)(36756003)(66476007)(66556008)(4326008)(66946007)(31696002)(83380400001)(86362001)(8676002)(82960400001)(8936002)(6486002)(186003)(478600001)(2616005)(38100700002)(44832011)(316002)(2906002)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFkZGVJZmo3RUdVbE1DK3hXSUFMa0dIWHg5V29DNDJYeGsxOERDYUE0UnNu?=
 =?utf-8?B?bWkzTTkzNDVjbWhjRmtJaTlSV3FvUVFlSmhHN1NTbWRlMWFvRUduUTNiN2NV?=
 =?utf-8?B?MW5YTmw2TmxQN0V5NllITWcrMEd4clNmVk9NSEljcDZhamNjTUxVNXhyYnM2?=
 =?utf-8?B?UGtwa3JubHVTaVZxRDV5RjVlSnRqT25wME1mcUxFMnUxSnE1aklzQ2M3Ni9L?=
 =?utf-8?B?bWNaRTRyc24wZStQS0VTUTJsMVRnVkhtNFcxZzBTZnpsUnRGSXFlelBqbGo4?=
 =?utf-8?B?RTJITlc3MmQ3TnVJbmJyTFlDb3p4SVcxanJCeEpMUnczNFdEY0J5NDJ4Rlc5?=
 =?utf-8?B?eFNsT051ZUJhR0lTd1ZEK29MRXhud3c4cDl2eUlnU3laSGNZYzlPRVpqbVN2?=
 =?utf-8?B?cDBjLzYvZjhmakU1VTBIQWt3M2xJSXlRVlQ2UTRiWGl4bzU5K2h5MHZCV1F1?=
 =?utf-8?B?K2VNcHJlTzVKekdrQlBNenpmbURjT01KbXJFUWQ2OVhjRVJad1phMW4xZHNm?=
 =?utf-8?B?b0dsbmZiQ3ZhOG9ucXRsTEVNaVd1N2EyRm9qdEhGL2R3VmRDL1M5SEkzUVVp?=
 =?utf-8?B?THk2VHpIR2tCSXppK2hzNEpRRjN2amVIUklFTGlkdXI0Q05TaGhjcXBzQXRq?=
 =?utf-8?B?Y2ZWcm1TaTdkWVVNenpUZDl2czVRb0hDd1ZHVVJiYk1ReUpKNUF5RS90bGFy?=
 =?utf-8?B?bGVqZXVaa25nR1JTLy9FMXpUVmJLQW1oUTV4ZUdPbHV3N2JLRFU5MTlSVlB4?=
 =?utf-8?B?MDJmSXoyNVZLZFZNV2NMbW12Wkl1UWVrcVI3WEJnRFB1Z2NhZ0pmdGlFVG1C?=
 =?utf-8?B?eHdKTDQxL2VXd01XYkl1NmtkaExCWU1ESHRDWmJ0NHozcSszcUFlK1hKSTRJ?=
 =?utf-8?B?RWpzdEkxdDZLYWVGS28yVkxGVlZ5UnBJeGs0dTVnN3B3cWVTTjJaWUJEWjA0?=
 =?utf-8?B?RUppYklHNklHY0orVzhkRnMrbG9xc2JONXBDcys0ZjNFQWczc2hYRFFya1d3?=
 =?utf-8?B?TU9jZnAzblRRTWF4YzdkYnlIbUJ1WFAwNnhFQ2c3eHc5aXpUVkk5bHVCb2NM?=
 =?utf-8?B?MGx2dDNBLzc4NHlqK2FJalZFdEZkWU5GWkpLYWxSSWlIOFJZcHdLN3VGOWtR?=
 =?utf-8?B?TFNlMEd0amw5a2p1ejF4Y0ljRkJleE9DaTN0RjZuWUc2aG9TM0VBVXhWU0ZY?=
 =?utf-8?B?TXhXejVFVkltMTZQeEtxNUt1Vi82Zm8zK3A0Z05nanl3cm5rNGdqZnZJbFZz?=
 =?utf-8?B?WXEzc0FNdlhSSnEyQ0lWWktsU2ZQSXlzeVNQRmtTM3hxNzhuTDQ4cU11TXJS?=
 =?utf-8?B?eHh1Umh3TUFQRnJWTjNOaU5mNTJaOHlBeCtHMUw2L0xicVJYaUsrSEdnMHZX?=
 =?utf-8?B?QzBoQ29oK3V2aG1kTlJSNFFEK2NZYUkwUmdsN3NBRzBadTFMb3NvaitrQTRn?=
 =?utf-8?B?bDdpUHEzamhTT1hKdWZkeU9XOHdIS040R1ZrbnZIUmYrTGpFMDhaNC9IRDdO?=
 =?utf-8?B?aUJYV05WVE9JUkdhS25WRWRSTk9pS2pqQ1RQbVR5czRWL09XMDBFamJEaW92?=
 =?utf-8?B?OFp2U3dzbVoyeXc3Sjh6WHUvRzlhOHlvNWJVanNQNHl3d1g2MTFMQ0FwcTV3?=
 =?utf-8?B?R3JhT3NwRW8vTTMxT2tiTFJPMGRyemJpZ1ZYR0wwbUVtRkUzU1kxWHdaS0lF?=
 =?utf-8?B?SVBxSWFzeldpcUZWd2o1M0g2Zk1ZYUp3SzlZa2MzL2hIT2pvczhFaFZaWWpp?=
 =?utf-8?B?NkFXaDM2SFB2d2t5Vk5CRDlKT0J1czhMeW9uTENwM2s4K3NEa3huSHBXZFNV?=
 =?utf-8?B?ZFFja0Y4OUwydThJSVUzOG5yYi9BL09qVEpnZVJYYmllVzc5dkExUXhnOHov?=
 =?utf-8?B?NFk1azZ1NUdDRHB3Ty9jM3M0WWNIYU9sdjRKTjVRZUhlcmRwdVZQSlZLRVBB?=
 =?utf-8?B?Y2x3akZLcEVYVUIxZHFuOXJjRlRVd2JEbFlMSE1iaGxHUzFEMlllcStVNzNh?=
 =?utf-8?B?Nk95QzhxVmZXbGhneUZQeFQ2cm1oTThWOTFtV2hWU2k3OWVKeDZ5cUxlMkd4?=
 =?utf-8?B?SUJNc3RlL3ZZa3BhZzBWY2luYzdkcm4wQ2xBMGdCMyswVkI4LzU4djVDRVVF?=
 =?utf-8?B?T2tFR2VpMjlQS2JWR3lBV3BRZTFyVHVRdjRTVXZpVWR0Z3oxTFZrenB6ZHBQ?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c53cd1-d575-4f84-e909-08da97fc73f1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:59:36.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEPnMWC8Xic88ETXbaZBnjMWfo6MyQz/gKvIyeZ5Ufgi6uTYVfafK7gl2Crzki5TBiMZrEb7cFt8Sv+5VmSO2XWMj/6WF6ML6Hpv1OPah/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
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

On 9/7/2022 11:01 AM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the sysfs configuration file.
> 
> Following are the types of events supported:
> 
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 45923eb4022f..96f439324d78 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -15,6 +15,7 @@
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  
>  #define MSR_IA32_QM_CTR			0x0c8e
>  #define MSR_IA32_QM_EVTSEL		0x0c8d
> @@ -50,6 +51,29 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> +/* Reads to Local DRAM Memory */

What prompted the terminology switch between the
changelog ("local NUMA")  and the comments ("DRAM")?

> +#define READS_TO_LOCAL_MEM		BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM		BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> +
> +/* Reads to Local Memory the system identifies as "Slow Memory" */
> +#define READS_TO_LOCAL_S_MEM		BIT(4)
> +
> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
> +#define READS_TO_REMOTE_S_MEM		BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
> +

Could you please fixup the comments to only capitalize 
the first word of each sentence (unless it is an acronym
or required for some other reason)?

> +/* Max event bits supported */
> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index da11fdad204d..6f067c1ac7c1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -254,8 +254,85 @@ static const struct kernfs_ops kf_mondata_ops = {
>  	.seq_show		= rdtgroup_mondata_show,
>  };
>  
> +struct mon_config_info {
> +	u32 evtid;
> +	u32 mon_config;
> +};
> +
> +/*
> + * This is called via IPI to read the CQM/MBM counters
> + * in a domain.

This comment does not seem accurate - it is not reading the
actual counters but the configuration of the counters?

> + */
> +void mon_event_config_read(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 h, msr_index;
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		/* Not expected to come here */
> +		return;
> +	}
> +
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);
> +}
> +
> +void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> +{
> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +}
> +
> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
> +{
> +	struct kernfs_open_file *of = m->private;
> +	struct mon_config_info mon_info;

Could you please initialize this struct? I think this is important considering
that there is an (albeit unlikely) chance that uninitialized data can be returned
to user space.

> +	struct rdt_hw_resource *hw_res;
> +	u32 resid, evtid, domid;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	union mon_data_bits md;
> +	struct rdt_domain *d;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	md.priv = of->kn->priv;
> +	resid = md.u.rid;
> +	domid = md.u.domid;
> +	evtid = md.u.evtid;
> +
> +	hw_res = &rdt_resources_all[resid];
> +	r = &hw_res->r_resctrl;
> +
> +	d = rdt_find_domain(r, domid, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	mon_info.evtid = evtid;
> +	mondata_config_read(d, &mon_info);
> +
> +	seq_printf(m, "0x%x\n", mon_info.mon_config);
> +
> +out:
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret;
> +}
> +
>  static const struct kernfs_ops kf_mondata_config_ops = {
>  	.atomic_write_len       = PAGE_SIZE,
> +	.seq_show               = rdtgroup_mondata_config_show,
>  };
  
>  static bool is_cpu_list(struct kernfs_open_file *of)
> 
> 

Reinette
