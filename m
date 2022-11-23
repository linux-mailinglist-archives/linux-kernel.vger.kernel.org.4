Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC0634BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiKWA0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiKWA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:26:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33C5FF7;
        Tue, 22 Nov 2022 16:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669163179; x=1700699179;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rdlVzdgoEpFuoxfj/T6RTIXioBrMsiaUdb3dPPV5uUA=;
  b=RZhKTgKuGHVkFuOKWL6HGKnDk/HagW6PxTXNw/KzbTCPqaqL7eIloNHM
   G5yf6clMplocqal8b2udTp3dpxrS8tIqRMpyWsyjttzx6jtIvrO/N4Yhg
   +MFnoiRJI5CgoMlh9HM0QJ6JAPPwwuea/FjMO4DB4Lyp0vSRcrFKN+gtM
   XyuurwHK2fUvaByS5NmE/fugzzV6uuzSZtMbEHmLsvyhKffwxAJEbXcUn
   pH97RSqTXgk/PYDFF72Vjq6UjlwWz9RTHcdZfP7nx0rnfLSYYK4gZckIL
   dXnIwAR/T/2lyAKbMT1K7jjVjoOXxZKFJPpFpPluhDwytUqJjqIzYOmct
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="294336110"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="294336110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705159368"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="705159368"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 16:26:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:26:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:26:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13 via Frontend Transport; Tue, 22 Nov 2022 16:26:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7ndvoKYaGmPgYukWtRQnRqYcJohyCpv6BJUzWz+7HEglpodk4RwFJEQfccba8DyHF/mYMMHqfWJxFrwqmHu19cdILrCQcLs3++zSxzh8fTMBlikOMo9JKHUn1zqmHjAjtzxXHXvG1Ihhcz+UFUoc3BxtEL5aPnQxUGVlE3o93NdrTCiS771NV3uCcgmWm1heTFbPakIGBHMUznP7V0+8lPg1GGW/JB7OnkeQ4zF5/ze8+hICPbkY7z0aLBxZrVhUnK+zsKWme55eWLLg2wRXcG69YUmqbB16uPe/oxaHAZuAObtoZ8ximLgXd+JUA37bvxslBzm/32nKgUoCBSsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ano3cIpU3ybE132CUMI5vz9eOes9krYRuTvAG+RdV5k=;
 b=kaDGoIodIkbe1/ovuxpaRadu0SSFZv1KOII3M+OJK2UeN7KpHlTR82FMUsHd4Eo07vVXHYpZR5mGf1A7pLXJcIsmA2BMT45PhEtSPKE7YUJFe/zehWX0fAUMNrj3v77SD/hI7DmsnfUJKpAuywJa02N7tgmuNPHr3KjoWUSbZMKCxfLY6d6QdHdFaldrARAQxYm8P4AcsE9nCS0fuwZOUyug4MjngSMVkfMSd+lwK5VQR2BledkiZqq0DiakbI2RXHz1yDbRZ0+pspzzvw3zJwVsZ6+wECKhwfN4jRoDPlgcWOG27p7j3o/bQlyeEP0sSv0fvLYj/OMxmJXIEXNTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:26:09 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:26:09 +0000
Message-ID: <d757b376-3e36-da95-b69c-21390a0c92f5@intel.com>
Date:   Tue, 22 Nov 2022 16:26:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 13/13] Documentation/x86: Update resctrl.rst for new
 features
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
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759208987.3281208.3199784740546752454.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759208987.3281208.3199784740546752454.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf56bbb-2bb3-437c-df02-08dacce951b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY8ZdCPwc1q0a1rld7ws0B+SdeoYksYzaJhJXOi+m/ARcVc9pohdj/1uA1LNja59k9q4my/RegogLdHQaSeoxWu3VY5lbhbc5SX4L0tT0Vc2ljZoF2K13ycg3x34L+yOU2J9tM15GpcUuaVQUWaZ9CcYu0SWKG+g+Ib5DE7hXg8DWjC9pmSd6m0t9nEWx/7RSph4Q3qOqAUb211Zv1/w3YUMGizSViQjZElD3m/SyB5CfCAr32tV6GhVVVKcnbbYP2PEYv78ROGJyVozgWXHbfrs0WuJGCsGe/lJ6pa4N2ld8a77/rth3becAHXsUlWaKnKdaCu51ZJRon1jagvdcDMbqOBSiaA552TEIZmDZdAliqeYdeXR7BBb7pnki8TwRh5TLPWfPr4BVfC7LnzvyQXu6FGdz6clnfybx7DoAv3Si+hp9Xm6q3x78shPJBbcF4kHbPpu/wblp1v3Szfj2KIcHTwaDEDviG9ICkOXIy+nGsrgSOMC2InCe4KnXufaBePDxtDycmsxMOolvIftOU3dbAKkH2tDffNRPLGAwBNFYzKc+Xyc5Xh7ACEVR8YmT/MUsVhf0FNuR5fP8+lrtQutmqISkH56KeM9+f4oKSfNf90cdpVCFkRbILIL6tHhxQzcBoO98aaSzIucCYxmhqP+Wj2u8nkrzMifEW2Szuq/ZeBXue1Q2tGu4sEdR6RzgbHIyl6+6KKf59jRBHfgE/Aq5p7cNj9l5Wwdghx24aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(6486002)(6506007)(26005)(6666004)(6512007)(53546011)(478600001)(31686004)(36756003)(316002)(83380400001)(86362001)(38100700002)(31696002)(82960400001)(44832011)(7416002)(8936002)(2616005)(186003)(5660300002)(41300700001)(2906002)(4326008)(66556008)(66476007)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJJNEFrekg5ZzF6dWlhZ0RpVVVWNXVIQUY4TjJIOXI4bmY5emNOZW4zT2w5?=
 =?utf-8?B?VWtlRTVBTi8wVmsxbUZITGphRmwvSVRWQ0E1L3JqNTFYNXJrRW1GYmZ2Z0Nx?=
 =?utf-8?B?YTBTVkFoQjdBVk4wbzZXcEdyckQ0MEZYdVNpNEZqdG5GMFRaQWZOeC84MC9Y?=
 =?utf-8?B?aXcrSE03Qkg0b0dxSUxhNkpBWGVSUEpTNlBzMUhIRWJ6TDdVNUNqTmVjdElY?=
 =?utf-8?B?cWFDT2YrUmttQ2l1LzIybU1oaE5KbHRLTm9QZG95c3JIWksvZks1QmtDTTRF?=
 =?utf-8?B?Nkd5V3dGSHBGUlBNV1l2Z1JRdVhlRmNkS0NFeXUxSjQvZGh0VkxuYTZLQmF6?=
 =?utf-8?B?TXU1bGdsWTd2bll0MGpTWG5yb1ViaDQzRFZRMStEcEIyaWRVRkJnajFwbnpT?=
 =?utf-8?B?ZnQrSHV6Y2FkS0YrNjhpNGRoZ1pMK05nZ2tPelNwcTZ6aWh1dFE3UE9QZE5J?=
 =?utf-8?B?Q2xvZHFoL0NLdjV6ZnMrTnpXUXp0ei9tZUVqTG4wME5oMjQwMkFjd1NlL1ZR?=
 =?utf-8?B?NkZYd0VNMStBMmYwTlQ2R00xUm03MmZTYUR2K2w2NlNhK2ozQlp2S2UvaGRq?=
 =?utf-8?B?NUUzSlNqV3dhcnBnZUNmcnRWOG1IR2hRdmduZ1Vxa1BSU1dnTlBTNnJmWm8v?=
 =?utf-8?B?ZzYxVy8yc2FUVVpuVkhTcUE2eEM4ZURCSDZPZHNHOTl0b0lJR2Fkc09XMk1m?=
 =?utf-8?B?VFBsWmRPdGhPNGNjU054ZTJyOEJKZmxCU3dlbjBOZXJSSEtCR2Y4ZUVubXJG?=
 =?utf-8?B?OEczYllrNmZ0N2ZFVlhYT2lrRGJsZ0JQQkJYV2JDNHZjR2M1eTVGTWF1dmYr?=
 =?utf-8?B?N1lyTjd5dVlId2JFRGpXZllMQ214QUpvQ1RvZ3prSEhDMWx0T1JxMW1KUllT?=
 =?utf-8?B?M3pISW1VOEk2bEYwVGIyWGV6Zi8zS0M4RTZwYjVlVzBVZFZoREwvd2s1elVa?=
 =?utf-8?B?b1BPeE0vZkFxbWpaT0tmMlQyUjI5TkNZRDQwVnJkbXowY0RzQTJ5bW02eW1D?=
 =?utf-8?B?WGdzZFJCK3o4U1kvVTY0eEpOTUtVeWRIckQ5VGIvVXZabG1kT3VHbHVqenNH?=
 =?utf-8?B?RmIvMkdIM25ybXE4RU11ZWwvdHllVFRKRkNmaTJmdkJMbEVhcHhIUER5Ym1u?=
 =?utf-8?B?QXkvdTU3Z1hicU9UYzZuL2dKZUNSOVQvSThsTXU1Q2FRNElZNmpwdVl6a1o5?=
 =?utf-8?B?YnlneXNxdHZ6SzYxVVJ5WlZLN01nQWo3QjV2TUpnSVo2TExLVWJNTnhwdCtL?=
 =?utf-8?B?R3FmYUZUV0JjcU1HRjh0RFc2MDV2ejJQRXI0dEZCU0RFY2Rrc211NjFKQXBD?=
 =?utf-8?B?UFpKN1daQ2FXNjdjREY1dHZlNXZsMGJsZ3hXanlqcVE0OWxrVER1OEVhbE5m?=
 =?utf-8?B?WWs0OGIvRzA0S2NGdDNNd09DLy8xQVcrcHZrM25TeGw2QVVEalgzUXUySnVL?=
 =?utf-8?B?RDZua0t6dXVPcTFvT3FONFE0TmpIMEpzQjFiclk1SE1JT0MxZzIveTduRUo1?=
 =?utf-8?B?MEFWWk03aW03QXZCM2lvOXE0U1E4WDhVcDFOcXNtdG5aN2hOdFJCMFpLT0hv?=
 =?utf-8?B?NFIzczdtUHpEMmVvUzNsVko4V2FxbEU0VzRSSDJscHlta2JGVnhJNTd1V3FW?=
 =?utf-8?B?V1BtQk1LWGxVaGt0VGdFYmptK1lCWnlDZFJhbm1lVm13THRPc2tyWFhrWVI5?=
 =?utf-8?B?anBrUHQva2wvT2ZJVkdqWk5mQWllNFlyZzNCRVdtUExWWlZUNnBNQ1VEREVa?=
 =?utf-8?B?eXdienhEZDlQdlhmdUVLdGhDM24zaS81T3FQWlYwUlYzbFNtckFQYnNwR3k0?=
 =?utf-8?B?ZVo3NUlxRXJGdDdubGFBeHlNZWNXQ3NCbXlpb3JHa243c002RjFEYWxDcFlw?=
 =?utf-8?B?eTQzUFhVRFNjUGNoYzBzTkxZMCtGU1RzbUZ3c2RxKzlraWZoYXZkRTMwT1gz?=
 =?utf-8?B?MlRISmRxclhVbXNkSTV0STNPa1k4UlFwVElQSVBPMVpubC9jUms2OGY1ajJM?=
 =?utf-8?B?RWVMbWs2TWxpYWp0S3luNWdUZHBaRGFweUxKeFJmSjA0dWRJWHU2WVNkVlh4?=
 =?utf-8?B?UkZUSWtZUlVpQnRFd0hBUUVPUnFaRUs2VThRZ3VqV1ZjMWNXdUczSW1GeFJW?=
 =?utf-8?B?N1hDcHFCT0RpZktSc0RxOHVwK0c3L2lkMng2YUU5WnZRd2lqb2JLVGduRXNi?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf56bbb-2bb3-437c-df02-08dacce951b0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:26:09.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpaULOeZevV2gR1OG6noPQNqIM9/y615aVuuo1HhPoRaNtSt1SWffo+ciCHkYdUdxRPy9UrKlFXT66tLeOVv94zvbXT1Tury0xR15lnBh0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
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

Hi Babu,

On 11/4/2022 1:01 PM, Babu Moger wrote:
...

> @@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.
>  
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
> +Slow Memory Bandwidth Allocation (SMBA)
> +---------------------------------------
> +AMD hardware support Slow Memory Bandwidth Allocation (SMBA) feature.

How about
AMD hardware supports the Slow Memory Bandwidth Allocation (SMBA) feature.
or
AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).

> +Currently, CXL.memory is the only supported "slow" memory device.

What does "Currently" mean here? If there is a plan for changes, could
that be shared? Otherwise maybe just remove it: "CXL.memory is the only
supported "slow" memory device."

> +With the support of SMBA, the hardware enables bandwidth allocation
> +on the slow memory devices. If there are multiple such devices in the
> +system, the throttling logic groups all the slow sources together
> +and applies the limit on them as a whole.
> +
> +The presence of SMBA (with CXL.memory) is independent of slow memory
> +devices presence. If there is no such devices on the system, then

Maybe "is no such device" or "are no such devices"?

> +setting the configuring SMBA will have no impact on the performance

"setting the configuring SMBA" is hard to parse. How about just
"configuring SMBA"?


Reinette
