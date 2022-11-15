Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C249462A3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiKOVIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKOVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:08:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314027DD3;
        Tue, 15 Nov 2022 13:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668546494; x=1700082494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lfEh/tZir7rJAChvFDtoW0H8tP5MP/XFucWfdKZLMnY=;
  b=JZAZ1EBRnc5iGGnUzpIUld79fG+DiKYa+EwWvVaxColEpHieK4iv3RxY
   3ocbY/2SiIykX51Fvzx3FVAjEiab8c92YtWE/in9kvdZXdUlG5fnXMNqS
   lqROZxCfeuACiCTAEKOTJUa4QAnTrVdwBKuAyU2SppUCzTtM8Ic2nJlcM
   6kkymgOlJ2IaLJ00ExrcGdAsXi9i/FAl2gDT+iEeRzwznZXbV9lsyxTAp
   KkzyuFzX2YycxPy0N6urczbm4fR8rDNI2d7wIjJISfT4Z1hms169GYmTs
   kb3lHrF/On6bwJgECJ8cV9P77EnbyePILl1t7Rz9s5mDv5P8GT3DcYC+9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295735107"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295735107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744752450"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="744752450"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 13:08:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:08:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:08:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 13:08:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 13:08:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUxa0E/ofPj2pwWHN4qarjFlSz3MLk8L9WTxarOpsgBm1qqW0VRzqJF90QcwyIeCLv4kyLiQds15fm0OKrNV/Mv6O07mFyLHKlLjbsT8RPtBHHFrfVGVzKsYuRndQdPUyP69Fbs996+sOlDP7MAOZY2ZWC8Q1vIRwFsLZKHd8wonkBDKaqkxQw41IyVeqCO220SzTVmFpGJBGwRotbmxqYvZ4e2JcVi0FyJK5jBvJe1sgam4glfsk0Gsp4ua1g5CmhqbsO9hHr/c481leN5eeqIf4BTWloSMatyv01jGaJVfg3UWb65jx8G0pLpA2tzhcfKXnIj0x6SHp7cugOz/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfIVWr1c3pynro41PpDiYdTBZeqMquyI65Yc2b1Pspo=;
 b=LK0Q1wx397qDdGHi+UKagViNZ53Jx5EyNs8hEWACn1DUcIWmnlAW6syOq2NxFigERPD92+esNKzjge30+HVRaAOoIdwgvLK66fsGMq284HpGhkIdOhOYRb5DSZbOmpeMr12marvy3omKGcEKhkXrRwqMYjbQ/L4/gV60OPGcyD73dnMty3MZRkXllAV4YK9UFbEvfIJGiAXraqc/gKdZp/x/rfVU3oi3r0ZmLt3+3zLBuzoGDq0WDUbPeNN/u+mQQRe2eSzjqO7m+1ePL9OUXyOe5jIWId4drtp3PKZGPPL9BdnJxEI2xqzqGEg+Y8BO51P8vVzaa36r+zSi1TzQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB6815.namprd11.prod.outlook.com (2603:10b6:a03:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 21:08:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.017; Tue, 15 Nov
 2022 21:08:01 +0000
Message-ID: <90a66b72-368a-7199-0d6c-f876cd1ca63f@intel.com>
Date:   Tue, 15 Nov 2022 13:07:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v8 00/13] Support for AMD QoS new features
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
 <f69a6454-a8c0-8ce1-0356-cde0d8b89c2a@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f69a6454-a8c0-8ce1-0356-cde0d8b89c2a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 31523e11-8f5f-4d63-f707-08dac74d7aea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keMYdaDZPgefDZjssYeNUKyI8wXNgS5YW76cnvE5Uz8YoETjvlzRF1GPHOnnte13+8ndiph3mp2ztvHQPGM9Z1N9j6Ihk46jakdoA1j26yPrBl/FZLYBV+BrW8u7IO+c+EqtkANosI0zAZqCJa5QhqTyp8eYyP0QxE/xnQlcnZLg/b7Yj1PM4DUB5piUVQuJzM7XIr9XwWoeZgmidG4Ic09gD6swljIwHqI4LXhEeWVhHJe0/d5s3WGOZj/5/YfqW4STC5q2c4l02u6DCdIybSimzU2KH7M7t5VniSlV8MFlhqSUsxbbhaBQLWfAJnE+GNrJ0vOW4lxnJKG0P1XE4A6H4TNUxTlyz6P4Wwv3U8DRt1eJOPJ9TIgU0ckDGNR2ZDPwiBj+DPEm/+zAwVwtstkaFbl0DAmHHtt+LDhdapEXzMJ1krUG0GtZNaBeNw2uzp1rS8hAc5wHgAQiJpj/l+tmWthrwpYXqTxjLtbwz8NYKJNc0bszC8Hk4tJyDIXTSi8Dmwutzk5g8JfINqPxM4nYeb9zQpWoE9q2nwp73dfpX5EUXnZ5jWfld/hgRnNYBtsOivTpir14xs7wg5Qg+9yi649W5AyV5VL3VXxy4/lTqP0DqElzU4cbHBwtDvwdETSNmcbLypEDTA4gpKhN0by8AnaOKNhB1bBzspQeGRGMks71MoSaDrgNSnrryKUxECHBRsbX4ZxQbPF+/p9JLCT0mlLiP9XzhviLXbD9fbergiM8otLZYCMKcHcUQKuZI6G3f46KsAsyYDM85dH5vlqbOPMWOM95LPpuqlDhKnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(478600001)(38100700002)(6486002)(82960400001)(6512007)(6666004)(6506007)(41300700001)(186003)(53546011)(26005)(4326008)(66476007)(8676002)(31696002)(5660300002)(31686004)(86362001)(7416002)(66946007)(316002)(2616005)(83380400001)(44832011)(2906002)(8936002)(66556008)(4744005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjEveTROVDZ2Njh0TENYWTY3THZyR012aFhBMjkwUVl3TnlCU2pzN094cWxi?=
 =?utf-8?B?S2ZUNWppejdPWWZTaFVoeDM0UVQ1VEhUL1pURlhIVTNnYUxwZnN5SXh1NFNk?=
 =?utf-8?B?cGNmREZrblJyV2FsNDJhMmltaVlmYkU4VUxsZW9RMWN0em1SdkZIY0RuazVP?=
 =?utf-8?B?NmZKYTlaV3BmR2ovQU5jRjV2UnBRRlJWQXgrd3VDbVozNUl1ZTVXcU1kRkt0?=
 =?utf-8?B?ZHIxZkU5cTdPNXZtZzdIWG5oeXhxNi9Sb0ZUbXNXQnVwQVcvM3BmZkRManBm?=
 =?utf-8?B?MS9ncjNHS01xdjdIOStYRmk1TU1VTWdIdDZkVDR4a3MzWVU4VUNKdll2WmxF?=
 =?utf-8?B?SzcwRFZEU24rbEtaQldPRngvSGlkQ29MUGFpeEU5NUJuY280elVFeXljZWdn?=
 =?utf-8?B?VjZqUzhXOWNSRkFRNFFGN0ZwWldLL3ZnOFdxYWpRaVJjRGJPQ29kbmtmR0Jw?=
 =?utf-8?B?N1cxWXg5bzRGd2pXWVpIb1d2WXM5NmdqNnFnbXh4N3lmUWVocjdkOXRtTUZj?=
 =?utf-8?B?ZVpIbkZFVXJsZ1h2Tng5U0hhcFdob1hxcURVRis2QlV3dkdoOHJ5Nm04R2hw?=
 =?utf-8?B?c2k2OFVZOER5eEZ6RHlsdVR2b1U4dHlnbVVDWUIrUEdUckFOVUpFbWdkQUpi?=
 =?utf-8?B?WmIybWpOOE1FTW4wSkY2MVgwNEQ4RzdhWnMwWVQ4dDhDdWgvQzFJNUJSTFl2?=
 =?utf-8?B?RCt3SmVHU3pYK2JCOEk3aTZ0QXJ1bUVIVTVBMEdJTTA2M0w2MHdLOWVvVFZF?=
 =?utf-8?B?WmVUcGVkMmF2WnNoODVMeGNKVXRleHFpTkw2Z1V1eVNmTDZXa1djYnlUb3dw?=
 =?utf-8?B?ZHhnZjk4NmhDQ3JDZ0VPOElDQzF1TGFRUStNejVJS0IzdE5hYTV6Q2M4Z0F2?=
 =?utf-8?B?NS9CazFVMzZpWHlId0c4WTFIeVMzZGtHVUlBTU91T3BheVA1UDRFdndLOHBv?=
 =?utf-8?B?L2ZGdEh4MWRVQVA1WWJvN0VJWEdpTmFyT1BZcFB2cFVsNHd0VnQxc2Fsa3hC?=
 =?utf-8?B?WDhXbHdGSGh6V1RSVTNOMDh5d1BLOS9RM1ZzSDV0RWJQTnI4Q2UwODlyK3FT?=
 =?utf-8?B?K255MkxXRExjckNIN2M0QUhacS9xWU1vR1V2dWNRWlBMejlld1FwV3RKY0Fn?=
 =?utf-8?B?dExqdEZoL2xQMGZGL3QzUWJ2cEFSV252Z3R2Sjk1OG9IdzZOVzBJMVZNcjNo?=
 =?utf-8?B?bXM1aWJFaEFTRk5UbFo2UVlSVU03L0hWdWprT05vaEs0cHpqbTdlRCtDSStH?=
 =?utf-8?B?Nng2RTIwTjd1b2o0M29qTUJ1aHV2SENtK3B1SkxuUlRwKzE3TkR0cUhwait0?=
 =?utf-8?B?VjZxVDJNclhvYlJ1RFFQQnptT3hmbk51Ty9vSUhJZmg2aERXTjNaVmdldCtu?=
 =?utf-8?B?SlNYSCtLdWVJZXhQb05qeDExS3kyNjBNUm50L1huQmNqVTRCa0FuaTRvMTNn?=
 =?utf-8?B?bGw2NUExekFNUk4xOHUwMTVuYnIwUCtTMXd2SUVreW5ENVdzSHdkVm5WMVNw?=
 =?utf-8?B?VndsbHJPY0JxbzAxRHZwaU05UlI5eFYzeTEyT1NvekZsY0pyWC9DWW1BWkxT?=
 =?utf-8?B?dDJiRjUxc2IrQmM4c3lRbjRnTTY2SmZsaU9SYmwwbmNQdldFYk5CRFFhMUs5?=
 =?utf-8?B?RDM3QjErbjRnTnB2OVpuVWNXdDVUSjRMK1MybWVtYkR0UzFWTW1wZ2FCV3Zw?=
 =?utf-8?B?V1dEVklEZFRRMlFkckNTQ1V3ZS90Zk9Ba0dRVS9FemtUUGZBM0szUkxUK1R2?=
 =?utf-8?B?L1pHVE55b0lMeUFWOFRZOWJsM0VuT1QzMWs5eVF4bzl5dGZzcEp2dUU0cjhU?=
 =?utf-8?B?RkttVDJONW1ISENZeHkwWnFOSktnSDRCSVFHemFBN0VhKzdzODdXOFMzdDJU?=
 =?utf-8?B?Vkg2TTJ5bGpaNmhFMk9SeFpMZktNU2FMcHBnd1NOOXJIV3F2d0ZqcnpVL2xz?=
 =?utf-8?B?dWtTakluaE9zVXlEQWZNZmdwbWh6TS9iZUNsenBiSUFESUlNYlBWR1IxQUZh?=
 =?utf-8?B?QW9aci80bDA2c1VMa2VnakFMdGtvdWVnMTBOcU5jSm0wanBwWk94R3lGN0lK?=
 =?utf-8?B?STRUSnlibkpBOFhJUUR0SUVidW1sWkhpQTc5U2RBclpBMnN2VFlhcG5mbklQ?=
 =?utf-8?B?UjRxOGh4SWthLzN5dEkyV2JEU1loTWhXTGNUOEJJNTVOQ3dydmRjMklGVk5l?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31523e11-8f5f-4d63-f707-08dac74d7aea
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 21:08:01.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Natwi/LYQF70QXcHiI/s3hd/+KItRpPJzFHyOquweefKE4AjMsePWuLu9jKJGKaKhJQGXgOT9+82Uzog0ZaI+wMlRG1Y4HYzRR3gjVNh3nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/15/2022 12:50 PM, Moger, Babu wrote:
> Hi Reinette and Others,
> 
> I was planning to refresh the series later this week. I have one comment
> from Peter Newman.  Let me know if you have any comments.
> 

I am behind on resctrl work and have not had a chance to look
at this series yet.

Reinette
