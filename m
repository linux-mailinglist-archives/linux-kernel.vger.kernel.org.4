Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507CF640F85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiLBU5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:57:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EEDB61C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670014647; x=1701550647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DL0P3bCxe8x3qvx+BxOIn5XlHNIPJswF9wLJcM9WY7s=;
  b=Tl5JfguYVLQgzgBD3e41CsUxykmh+iCdBS6XETZh//3XgU9bEEl2vILn
   IagO8A+d7TfoJSdviX/19RbDh+XyLu64JqL0mlMsw2rRkpdZgLESvkruq
   1sei/CHngmVbn9xKdwrcmE/smcuR+cuQfluZC25ddkbW8H+hGY2aV/6H1
   6ZXQGNTwd+iyfi1MW/5tjMtiQHoOXtIP3CSJqZoTqwX3pGawu6/2SIld2
   /lmNSr5/vephdeoxrEOxm/7OwW0ad6YWYKpLpdXQAJNWCQtp8ZZRCL7jm
   KVNo3Pr1OpgYnn2yE2CufzGrrPTfjV9zYywu5OZmANq9FPPT5zWB2rsFD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296402173"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="296402173"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 12:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595574780"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595574780"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2022 12:57:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 12:57:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 12:57:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 12:57:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 12:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVbLPiY5z56SkLEK37u8Lc5uhs5HMupdpw1ZnzwbJWpSHGZV/FjbJ+fWoADiroBSVPo5NO7ntyzvBeCo5lvqKQVhpxVNWLj7xblJvq4oUrqcoKQxBJtCcxGwotrFTaDY96sktTcPF+XkHoVxART8W4RDd2CcEJJA7vtaLBRE2yPUdRlNkbStYCjEVkiaEVNMsaB4H1sEwZdP1p9sFi9nZQ8g857rmO/6aF92SuOGyBdtQqrGD7ZyW9C36672adORqm+GPZnXicUiZGVUacnDrUtBWdn1fuI1bbeY09JR8Ms6Ia+MOHQvy2gSs1wxopoDCOPeEp4cMVe8IZYhqu1S4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+8SE1kndLE4NBrgJWmpYqt8nwoXvIVVIhPf3wjNIx0=;
 b=TGhjFsFGqiK+33nqkxGF+ncxAudo5nRi6gJDa30x3opYqjs1yJBaL0tRqcFNyWol1hgkApCoQTU8pIKih1M1CO3WZ0Ivf4QgupoTsHuKN4R0JJbq5KFu1zpxq0RQDvvCOWS86dsiLuQ8h7BePVw3iFmOnGI4pBnptrzG5QnCN/qMj48Y1r5XILQs5SMw+msB1kF06c63AJB/F3pjhrE35tx9sexnxNiVFqPHLJiFFzWZ9DZOuFSElK2XVwAw4csfz8ux/ouHHKTcZQgLcwpGfbveN+gKZ79CgTsNfGMiHPJ8+4wFnayLC+WdbEDNjUY3tt3okGBPqGyn5Dzsu9iMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 20:57:25 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::df5f:dbe7:6f49:e5d4]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::df5f:dbe7:6f49:e5d4%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 20:57:24 +0000
Message-ID: <f46f133e-d401-a91b-b67a-cca278f171f2@intel.com>
Date:   Fri, 2 Dec 2022 12:57:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
To:     Ashok Raj <ashok.raj@intel.com>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221129210832.107850-4-ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5394f3a6-ba69-4131-a591-08dad4a7d055
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXhvDzFq2H5Yjv8+l4g+78UM7QVpK3rQ2LFg9xQWFwxWlAYTH02oYzEdAQB4vJFMkVj5YCqasw877BSPgb43MHYE/TZXpQylOVMMjzbBYRxxDCwvd9TGvVzaYS84VvxET3taVllDDADEpFzdVquHiAtL7dCFajhpNaQ1T7rr3uEwvwcLaIAMOi7IDCtekeo5D1+xRy+rBfS84S+WDoSNkflyKvlI9spBScNZe6YfLjhgoEZHYah4Ed/zxhkHklL64SH9O1q7PWnVR4uIkpkzR+PGXvkmu0NA+8hHwjh2Oh4Y1Z1RerDd4swCfONXswrk5bqBEDNe2SxxYotYHLXA9SLV3x3DHbaQIxsr0D+0BK1QKhoMW1eZw5xY7Me2ado2k6YZPPXRte3WhEleuLGKJmEu1dYLiu/uC5RWL9nYVOsVao98MFTfsd036yD+Mqg9CTqGCiHFOv5aVEpd/yfHMJU3EmoEu9lIHb/j65UPaMmd1/TdPxvCjpZxGlYiqKjqXZQDRg0bq5Lwuu1Fkmx5UoAhI3yzob7xVHVSO9WqcAO+jVMEPF9ax6RXZnSnAbGO2R/8ztrwaYH/D3Pt5VmnJ0KqhT6jm/WCU3PXMs6n0/ltDQP8ol/AIvYJxcPiBdCNygxEA1iowC0V0TRaoBAga6FUW3d6GKsKv6aOMWhGSGyQ0pmSv6ZfHKN+LvKjNzB9nMt20M5ld8dRZ/ZJfbAWp1QqGHCpb/6SnkotbEqgqow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(82960400001)(36756003)(38100700002)(31696002)(86362001)(316002)(31686004)(6512007)(37006003)(6636002)(54906003)(66946007)(8676002)(66556008)(66476007)(478600001)(6486002)(186003)(26005)(53546011)(6506007)(83380400001)(2906002)(2616005)(41300700001)(4326008)(5660300002)(8936002)(4744005)(6862004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VJaFI4dVltYWQyakppYThFVVhPaElhSlQzL2RhUjdnNzludTZPMHFpNEsr?=
 =?utf-8?B?bVhRcW1ia05OVGNqTUVKcDBrUTFwQk1rTzMzbjJzNUV0MDl3SjJwUmg0eFZ4?=
 =?utf-8?B?bnlrOGpHRDJpV1V4VzZubzVvWTM2bjhaWjdITk83ejRNbElVa1J0aHFUMmZP?=
 =?utf-8?B?aHhRTGs2MWppTFM0c2xDcVkzNmdZZVpZTkhnL1hNdHhSRm0wYzRpMGZRYVow?=
 =?utf-8?B?RlVPZW5jT0dmMEd3VGZvWkFveE9UR1U1Q2JFcjNVRXNZRjlseWNoZXFiZFcr?=
 =?utf-8?B?Q2JCQ1NNbkU2VWF1a2J5L3dqMVhJeFVncmJPY1VIdmZYY0JTV21KemoreW9l?=
 =?utf-8?B?TXFqanJFbC94VFQrb1FYazhUblpzK0FBaXpKRFJaM3ZkSUhZSitTUDJsYmc4?=
 =?utf-8?B?UTRrRTdLc0dRdUNybWdKUkhsMm9KYWZNT2ZYNks4U3hhT1hjd24yQlRSQVpr?=
 =?utf-8?B?bHZQY3ZjNE9Lb0pTQkxzTFBtZUVISjBLeElTNXN6MVkzcTA3akFPOTNwY1Y5?=
 =?utf-8?B?cWJNU0ljOHhYNW9sM1NWT0tNcGFjMU11Y2JrVU8xSHJGMkl1N1Y4a2RWeFJ2?=
 =?utf-8?B?ZEhSQXQ0Qk1zUXVab0hLOTZSVmxyV3pyYmhKU1ZON2NaYjFqY1RZOEUzcnFu?=
 =?utf-8?B?MzhnN1JIZmlkMjl3ZXlkQkxLWmFUMEFGZE1ZTnFndmxlcTZuN3dKc0swMVFw?=
 =?utf-8?B?MjVwT0R2TncvbVJXUXFFZlk4aVpCVk5NYUtYcEwyM2FhanlFR2xwSlZFSkVy?=
 =?utf-8?B?SC8xT2lpZ3c4OHZuRUxvUWl0S1RVRVQxNkh5TW5FS1dIUFlkemxVWEkwTU42?=
 =?utf-8?B?c2s5cFJOQjJkbG9sdDA2STV0WmVKUW1QQ0FuSm04NjdmcXlualF6WjA2VzNv?=
 =?utf-8?B?eFF3NTl4K2NlcGcyLzJCSFJhWUlodk0rUmpkWXA3d0FWOFJkNHYxKzNGenVU?=
 =?utf-8?B?U0RXMkpsM0dvZ3hKMzNuaDBteHNaeWl3R003N1MyV3A4a0M3ekZIWXVXeVIx?=
 =?utf-8?B?WDNPSlhqQjVpdWlLSC9tSGVNN2NVM2JCMEV0OElTaHpQUkhDV2RINHZMTDd2?=
 =?utf-8?B?aXZNMEErbXYzRDBseGw2SnljNG1wSTFHeFl6MG1wU0xNdWw2WW1CVE5XdnlU?=
 =?utf-8?B?b1dva2tvL2dWZmoyV0Q2MmNCN0xmaWVjTzYzMk41SkRCSTZyZU5yL0Jyd0lt?=
 =?utf-8?B?aDVndXJEZ1ExQXU4OEo4bDMyVjdmd0NqZGpRRGlDTGUzNzJrUFFSempvM2p0?=
 =?utf-8?B?bTRWYmpaZStqaVJWWHE3THNKM0hFVUkxWE1sTVdFUVJPZGR4RUF6emRvZy9t?=
 =?utf-8?B?UFFQQURZZjF4cVhEc1l0elh1UFljLzQrcndmaGF1V0dhOGJwRG41SUVPbGFy?=
 =?utf-8?B?NE5FVjFrZDhYWFF1UzIrZ251RG1ZWmxvSytjRS9mcm1lZmFKSERML3VTNXUr?=
 =?utf-8?B?aU1FejRUd1Y4elMrU1NiRDhNU3g4NW5LRkhsenZ3Z3ppR1hISzYyNUZUUFFz?=
 =?utf-8?B?eGl4b2pjNy8vbkxJN3h2SWV3Y09HbG44dUNsczRzUURWTC9BSUREZ3FHOVBy?=
 =?utf-8?B?TUlPV0FtcFBLR0hidVBmekFZcmxjdXhUOVJWZXVOd1NUaTRVV0tpQzhwZVJY?=
 =?utf-8?B?MlUrT1NqWWVEQW9OKzlXRW5iNHdpUWRnT3Z2UlgxNjAzN2NWbi9aaXZxNWNr?=
 =?utf-8?B?bldrYSt2cXJHU2pMcE9qTUh4aHl6UzlxUVIyZHlCYS9iY2ErZ0JMcDdoVjFW?=
 =?utf-8?B?MnQyNGJuK25uL0habjg0Rm1MQTRrVDhuTlZNajV6YUJOOEFhdVI5eTg5QlNB?=
 =?utf-8?B?czZ3NW5KTjVQeUZzeFBJNG8xZGgxNnlFZWVCZDAyTW1DQ0p6SVRZcDNDbDFx?=
 =?utf-8?B?YmNPQmRJejQ3RldLNklZUGZPZjN3cU5VY2lTRXFXSFJFakEzTEU5Sm1uU25K?=
 =?utf-8?B?R0xaSEd6Kyt6M3pWUzZPVE0zbktSd0tXVjFiL2w5b3hVc0FaMVdDZVBUaXJl?=
 =?utf-8?B?UHFLWlBoZ241NUVWaWJ0dnJxUVJwcFlwRk5NQzMyRXVKcjVWWmpHL0wzbXpH?=
 =?utf-8?B?N2pFdy9ldkJhNm4wZVY2YlBHSFhRNVQ0VVJkZmxkZmtCcS9ZZTd4WUV0aWhL?=
 =?utf-8?B?ZlJzY0J2LzhTZ25sdGNGN1hSSmx3Q1J4Z0RUTUdYSnhOQTllbDlHL2kvZytu?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5394f3a6-ba69-4131-a591-08dad4a7d055
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 20:57:24.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6bgJgVvw6xZSeWBwXQSX7GGJMJc0Ux72lQQ+pEkWAm1/EcUllimgdj5Cl3ropCecQed4reg/M/slMaVU/Hj7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2022 1:08 PM, Ashok Raj wrote:
> microcode_check() is only called from microcode/core.c. Move it and make
> it static to prepare for upcoming fix of false negative when checking CPU
> features after a microcode update.

Should we use this opportunity to also make the function name a bit more 
descriptive? microcode_check() seems very ambiguous to a first time reader.

> +/*
> + * The microcode loader calls this upon late microcode load to recheck features,
> + * only when microcode has been updated. Caller holds microcode_mutex and CPU
> + * hotplug lock.
> + */
> +static void microcode_check(void)

How about, microcode_recheck_features() or simply recheck_features() 
since it is static now?

Sohil

