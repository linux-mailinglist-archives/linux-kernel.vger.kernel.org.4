Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7B6065ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJTQgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJTQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:36:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9217D2B4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283773; x=1697819773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQ/eqf5ZrmgjzDGAvWH0GkKmBBx90ZVnwUW6EQQC360=;
  b=dhB0ORubEETOOBdHGbYrdUuGZWMIET0SAGoAL1njFTYqQ9i8TCbxt/jR
   19fHpngdZdlKj/Wf4K4ZgmshwuHTdMOZMt6e7CX+d68MBglA0fJ79lb4Q
   ametKfgpRcoMnB7f7QVSRCZpE82hX1m9KFhHYYSYi0wMb3LwCFcISlTzS
   5t402nL7KjsrpktL8i6p6QZZBrkhDqwkvy/yygrKM3by+oZNV/qjU0Kvt
   QRUQCwl+ahjHYbeODYDHd3mshGpG8Dn4sFwW13RUciEHJ2eGp35Z7Erp1
   v0DYb1aH9mEtDPUsWI7aZCmRUfA1IzqEp8YZZNggCnt/CD+K5OIn6BJa+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368813635"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="368813635"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="734955176"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="734955176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 09:36:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:36:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:36:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 09:36:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 09:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQIHHb3OYJ3dx7vA3gkbzWCFrfVCZ1MndunnTw8gD3kWZXM92wyWnRee6ZQxWQNLSC+j2eIMjKGtV4M9NbWRDzFvus/oEBHZcMWyZMzxUf7yJdYbLCm/DNIqUVQo1mI0ayJeFdv3BnBerb/GHMyHPoM/zyYoPtNaB4UtKT/A7oXE0pX+XoJV/Yz590cpNHPiEEb+OcRijZov3hTckMl7Ld3t35/EX9qfkR/m8k6quRV4fkp2R0xoTkKtyM2X2peg7NWL/SDz8zk3QPsjvmiz/WgOwW8Q+zdThONNZpGRLwjizzVtDtL1LULWWl1GNf6rifqfcGcvyMRUf/QEPSgHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg6nuHy/06Pf/D6Rq5DR4QmzCyqEFCOtM2J0lgNz91c=;
 b=gvzOaBfFb+qxIMGJ923i/ABK2o5N5j6Z4cpdyaF5z0Etr2mahR0dv4ewqzgNhX5Myujg9J+GHoZKqK4+lB2c7HaP+UyTxkadfE2EBA4eNbL665eczvedrqj2Z3TIDBL5JIVYDME7CFRy7ttgMoRcJm3iZSfGhsM0jkcw3tNbtKtD1RqZZhoNu2PhvGccsKV9VuLaRobPrLwvNAwQ6+BvvBDQFna0UsoBQietShqjYEQZxSASVh8sFQhyK+jbeE02isyxjAfn7ehNLKf6lnp+ruLNeNlxdzqztkmnQnd2XC6E9a0As4mavnuHtAT5901O0S4IqQH9frWw4m1S98dzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 16:36:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.035; Thu, 20 Oct
 2022 16:36:01 +0000
Message-ID: <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
Date:   Thu, 20 Oct 2022 09:35:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        James Morse <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 212e877e-3d6f-46da-2724-08dab2b92ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCCkwujQTvjAJoA+60IlGrukIzMl1COB2Gu0Cl5TSmAYpz1Bb654aX1+Qq0qYRB8imB1N7rAsPNAOvfcsRNEYlxGF7Bz40TGInGc7rf+2veQelFcZcISCq9bIv8XYi3fn1ZDUUuCgLlePdKcQ3h/rCmBAtNwZMN02RHMIcanFCwYuWZHRvoDz/WzR5J4O91QLDamNcrNBTAdvWQjdJrgPkzn7/Nj13CZv/Tcej6s42poJY/q4CHCh6iwhULWdpqLEt5Ogva94wDc6Tum4sUwlsmIDnjlwckUs1lHQna92H2IVL2rWMMr7xu50faxu8MCj4GX0Zq9LpfOQX+Aq3rLngbT6Ych/5Et/kXHK85Hpd12y2UI8HaVn1x1i+6gTpG1dHm7eXOEw6YoFw/HHvvyjHmzxnC9m7h4O0YUEnNzMmo/SEhkXHNryM3712jf2dziWsOUGzjQPr2143o66gKlZBI05SAQXOxUnk8nWI2YIRt1CARRmlNtskqjZlEuHsRB4paOpYlc8NIF9PtBbhkkr+7QnhTnXi6YTCpv4k4weUZd0T2yeGmmZeRqKQ3gIa0iGUikJZuAlYiFn7IsSxvM6G3S6n6XdcXrBmsrIiuOJL0QmRupn+co5UAl5HWX8Up/cPZQ3F98Appr156yjCMck14s2xB70cTpA1itwTaD+nqdvNAfUwVjHuHT4Ux8FpB/zr3dyFsED/sBENn0u3AeDjop36snlcjkyGm7RxQ8D0ZBH0bcSk66tZuCt7vL/i+9wPCDkfjspo3lnmw8fkCZlwAM6jEybhjSAYQ6AhNOoj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(66946007)(83380400001)(2616005)(86362001)(82960400001)(38100700002)(31696002)(66476007)(66556008)(41300700001)(44832011)(4326008)(8676002)(316002)(8936002)(6636002)(6512007)(6486002)(7416002)(26005)(186003)(6506007)(2906002)(5660300002)(478600001)(53546011)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0c2L0hINk9lTy8vM0plakExMFc2ajEvR1NYd2NaZ3UxdXdnczJQcHgyT2Nq?=
 =?utf-8?B?Qks2MS8rQzNPdzBpMWJhcXZYdjVxcjgxMFpva2FveE95b3dObFBPK081czQw?=
 =?utf-8?B?M05PenJncTh3Q3A1S2h4L09uR0tMOVBaM3p4ZENUZDFabk1Tai9RV0lPUVFt?=
 =?utf-8?B?djc2WWpLQi81SlFPUklsSHdEWGVQY1RaL1J0ZHB1MUUzK204c3lsWnBTNHZx?=
 =?utf-8?B?ZHNwNmU0TmhIVW85OU5meTh2ZUNQc1dYU2VJSlBZbXJhRDlVVkt4TmdLN2tD?=
 =?utf-8?B?bTd5TCswRTJCdStzMlgzV3lDQUtrSWxiT2Z0MnZVVkFJNWRGNVVzaG9CR0dL?=
 =?utf-8?B?bk5wb3lhTUQ5M3FDNUc5dXZWcDBNYjNxdmNBaUVsU3d3R0pDK3BCeXVYSTcv?=
 =?utf-8?B?bFBmRzQ3WFlib2JDQzA5cnQ0U3NXM1VlU2tGaXQ1VVZUZDBHRXcvQlRGUlBn?=
 =?utf-8?B?RW9JM2huanVPSS9DanNUbkg0VU0rT0hQQ2RobUk0c3k4WkZBTjNUTnN3alFv?=
 =?utf-8?B?bUpjYWU4My9URnBsK0F5NE5OSisvZDAzMS84cWk0ditQTW5DZUk0ZlZPTzlk?=
 =?utf-8?B?WE5QSG9tenpuMHZtUnpsVklHL2JsdUVmNVpxK21YbGYwSGV0Tm1vaFVRcHhw?=
 =?utf-8?B?ODV0NGludXZHdnM5aEk5QzZPeHBDM0prcGQ2L1I5cXNKN3RiT21tVUNqQ0l2?=
 =?utf-8?B?VDhjVkpTTWZZMm56RXNhT2hIZlRrOU55d1NncEQxait3bjI0QW40ekJhRFYx?=
 =?utf-8?B?ekg5allQVWoxajd6bXJMRFFNK0Z2QVEycEtMTGFFbzZkd0Z1MVVEVGI0NFZT?=
 =?utf-8?B?VVQ3cVZPR283Y01Ob0pmOUJPQVlFOXVMRlkvNm8wWER4d2duK2JxOU1EYXdU?=
 =?utf-8?B?Yy9NUytrMjduRGVXQlNVeDV2QWsrVzAzSC9tYWI5NnorYldORWlaUUgwNXp6?=
 =?utf-8?B?RCtmUjg0Zi9nVUREVUZVOVp6dVZMN0hQVFhUYUdJc0wwUGFFbS9jV0JxdFo0?=
 =?utf-8?B?VWtMOHZkajFmNlJnQlJOMVN6VjZIMUVPcW15SkRUdkNGcGE3M2pIUGRjeXln?=
 =?utf-8?B?ZXdhUXR0MGdOa3JrcTJuVUhPTUxmNGZGanVuZ2p3bm5IclVXcXZ2RXBDTk9p?=
 =?utf-8?B?d1dUZFRMYndwTm5EV28wQU1xbm5sUDIvSk5sbTVhaHpSWUFGNnJ0UXk3Zjdy?=
 =?utf-8?B?dTI2M3J6V08xNEJEUEtPOXdHNTlpOXF6dTc3dWZJVHlNSDhZM1NvR3BkclVy?=
 =?utf-8?B?blZKbEMyT295WGZCNXdYdi9kdE00cCsyckRVS1hOZjF1Y2hnWVIxNm1wR1Iy?=
 =?utf-8?B?RURiNktoZEtlVkFvSTFuZlpMMjh4L0lIMWJhMTZYcVRxckZPZUlZcDdTMnVZ?=
 =?utf-8?B?Q1FSWHhxSy8rNUw4eEVNNndFbzZlcGR6c0pSMFB1UzVhL3BiUTBaWStHcDdJ?=
 =?utf-8?B?TXRlZFZDYWNsM1YvcVJ2OHpYOUwrbEJXS3FCTVc0bXNFdzkrZ2d3RkREY3N6?=
 =?utf-8?B?OHVNMGlpTVlNMUZvYmpzVDBDRHRpTWF2aFRyaHlEM0JZRG1aVGRqbytRenRM?=
 =?utf-8?B?bTdtQVRCd0lrTndVb2kxb1A1M3ZjR2ptWGttbktNTTlwYjROemh3TzFkV2I5?=
 =?utf-8?B?TDM3ZHNYekRUWGlEb3BPU1NtL1dMRFNBZWcwOXloNEJWYkFHQXgxRFhxNVlH?=
 =?utf-8?B?blI5S3FtOXJBUXp4azdMc2poYUxhSXZ1NGpXYmpkVE1la0txWUVNYXl6cSs0?=
 =?utf-8?B?ZjZ0TG1tdmROdTdMaUVkd3ZUa085TGlDeTN1QkpMZGgxdkVSeHNQRWR2YkZU?=
 =?utf-8?B?eDZBa0hTNlZLb2FvS2lqZUl4bGVwNkpjNlBxcFN1K1VJNlNJMEpndEIyTVNu?=
 =?utf-8?B?ekEwSUZreGNYV3FBRzFNSjNYdkF2NDBPT2NucVpaZ2lKR2FQNGdyNUJvZjJt?=
 =?utf-8?B?OWx2RjJBMGJ1czNWV1dmU1BuVHJ6dHhFcDVGdEJETlcyS2tyYUt2aFJ1UStN?=
 =?utf-8?B?Qm5aQWpIZkhLMHpoREtUL3NzVCtHMXN4R3g2bGRQaDQ2bnJqR09jOGRZS1FJ?=
 =?utf-8?B?dDcwTEFkTFQ1d0lSV1hySGZyYm5CVG5LdWFtOFlsaTlFdmNza3BOR0FQOS9a?=
 =?utf-8?B?anRSZFNXTGRRMEhncHRnSHd0NENxMFkxNTJwS1RTWSt5YmdqN3I4Ny85ZHpN?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e877e-3d6f-46da-2724-08dab2b92ca7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 16:36:01.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsFr9/1pdZf4BmJTb5EW1sJbrh8Qp+s3qau0Z1+oFjIPSUcw1tmS7F8JLj0riPxE+iuzWL0unE+yahnXlfN9QjJDiKbdi7uC97MM7vx76AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 10/19/2022 10:55 PM, Shawn Wang wrote:
> Hi Reinette,
> 
> Sorry for replying now due to other things.

No problem.

> 
> On 10/12/2022 7:48 AM, Reinette Chatre wrote:
>> Hi Shawn,
>>
>> Thank you very much for working on getting this fixed.
>>
>> On 10/9/2022 1:36 AM, Shawn Wang wrote:

...

>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index 1dafbdc5ac31..2c719da5544f 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>>>                   msr_param.high = max(msr_param.high, idx + 1);
>>>               }
>>>           }
>>> +        /* Clear the stale staged config */
>>> +        memset(d->staged_config, 0, sizeof(d->staged_config));
>>>       }
>>>         if (cpumask_empty(cpu_mask))
>>
>> Please also ensure that the temporary storage is cleared if there is an
>> early exist because of failure. Please do not duplicate the memset() code
>> but instead move it to a common exit location.
>>
> 
> There are two different resctrl_arch_update_domains() function call paths:
> 
> 1.rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
> 2.rdtgroup_schemata_write()->resctrl_arch_update_domains()
> 
> Perhaps there is no common exit location if we want to clear staged_config[] after every call of resctrl_arch_update_domains().

I was referring to a common exit out of resctrl_arch_update_domains().

Look at how resctrl_arch_update_domains() behaves with this change:

resctrl_arch_update_domains()
{
	...

	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
		return -ENOMEM;

	...
	list_for_each_entry(d, &r->domains, list) {
		...
		memset(d->staged_config, 0, sizeof(d->staged_config));
	}


	...
done:
	free_cpumask_var(cpu_mask);
	
	return 0;
}


The goal of this fix is to ensure that staged_config[] is cleared on
return from resctrl_arch_update_domains() so that there is no stale
data in staged_config[] when resctrl_arch_update_domains() is called
again.

Considering this, I can see two scenarios in the above solution where
staged_config[] is not cleared on exit from resctrl_arch_update_domains():
1) If the zalloc_cpumask_var() fails then it returns -ENOMEM right away
   without clearing staged_config[].
2) If there are no domains associated with the resource (although, this
   seems not possible because that would imply no CPUs are online ...
   but let's make this code robust against strange scenarios).

What I referred to with a "common exit location" was something like this:

resctrl_arch_update_domains()
{
	...
	int ret = -EINVAL;
	...

	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
		ret = -ENOMEM;
		goto done;
	}

	...
	list_for_each_entry(d, &r->domains, list) {
		...
	}


	...
	ret = 0;
done:
	free_cpumask_var(cpu_mask);
	memset(d->staged_config, 0, sizeof(d->staged_config));	
	return ret;
}

Something like the above will ensure that staged_config[] is
always cleared on exit from resctrl_arch_update_domains().

Reinette

