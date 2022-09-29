Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD995EF658
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiI2NXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiI2NXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:23:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B3147CE8;
        Thu, 29 Sep 2022 06:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXcctBQtEe6cruh9FFStr7gY3a1N5wOCgqWb/cqaweZ0+wZ7gnXjb5e3PZVEVhSclFx1lmw76aEtugKqRJpvnAjUX8S5nknSNSvdSPe23r/ZV9Y5Iqu2haHfY3nGz3x+JD+XB0UMtusBGk3Rg+S+8A2/5IuzEpE9TA6dYVt6dzIPxJuskyIhoteH6q3izhkm4AanoEpvB9qGQ14B9MfEVPbgMoc0tAjTY8SDSAShFCLraJPT86CoXDN2g2hEnEepRkCz6E6Mo3C1ibnl5xd9VfONqipDzOxgey6Q9Q99W9w67jjNHOh++hT+ZJC2pvbpw5+7SPeiyLSEtwKV+GyfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKJS6ZU0lAAC4yRt5gGJmNh/ERznHKL4q/OVo8M98/A=;
 b=oV8WmW2qJtFSBhxbBFeTKEtFoBNZHLJSIR379dcMAIzhorqxbVgiGwySg39LpqdoeDb1CH2EGApVz7vqmePofyKmtTlfTKf/AZuXOJj0oiDUxff2n9TCdb4f+/lFwVAp4+VttqOSwy2mJmm6PC9u47L3Rs12PR33mZfjDMa8ag3Da/RwL6S7nmDLrmmVQlQ8AKS4379BHuBOWEeQQLk0bvuOfznGDw5M6ODx9HRX/K9yvTQgQoi1SWRr1iEIP9K5InSuBvxqxqz5YWUTv9/X0ZDlLu1/FI87dYm0TpR4kIETRM+W4BGlHk9lQR1YlnynQ5BXgpYtxRqb1Eau12e1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKJS6ZU0lAAC4yRt5gGJmNh/ERznHKL4q/OVo8M98/A=;
 b=bCYX9Kx0Y2UCVsJ2x6qNIEOfPsjZ5pbtd1lJ4D6rYeYT/3atVNAa1AejUvCKT9NzRlWrl/sdLFQh1a7n2s2TxySsH28Pp8lFbAsAeEnwIyaia5zoF3u+GuWQQGMrrsnhT3TihpPH/aUtosQP7JXeUB0TjP6ec1+yf6f6sJPU0Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 13:23:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 13:23:00 +0000
Message-ID: <00e2440f-0f01-5d25-a5c0-d10ff52108ca@amd.com>
Date:   Thu, 29 Sep 2022 08:22:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <YzPMorJQFKPY+n4d@debian.me> <99bfbeac-1454-a453-a2ef-36eee2aea34c@amd.com>
 <db30d4f1-31c7-6cbd-f87f-abefa7f4e781@gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <db30d4f1-31c7-6cbd-f87f-abefa7f4e781@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:610:b0::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: ff87bcb0-0d08-44bb-fdab-08daa21dbab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0d1Em3Np6FMTIsKhh/BAF5ovorh5YkZ12Pz18wPd7rCrwpn9SjsmOg6J7uH5UG/U8V6KnuZIWKeVKm+Mefwe90mxad8lM7g773rF5YoG0ildcwdAA4U/doqFpYRM6bG0LQftNfS8INfL4Ghc6nfIHKuCPA/RsiMzWo7KApugN+ux8vFNDCCUrmuJWEiclbwEqLizrxgffKA1m+ozOtYO+te5ugYVLsVId9NseDS3/JF2q3+EQv4OIEVdvcPY5sEv7+c7GcPYXTCDS+ROFRrV8E3iiNwbN1CoG/b40WQAglVAbYDbsjO3ZFZUJO5gMXDkj8xoFCyUy41gnsoxqvRkw4nXIh5E38SQbEfv3PLEyoW8ftd1E/bmUw7+R/n499BHRrZX+brSkTb8OSS10ZIt9FrB/eQBEe8NIC7nODP4bZPLPaqedSh6d0bsziOU1f2BDn/4yWKzFjRTsvjiTgYEoVzhllPofDKoaXuCzz/fjbMib2Egp+XRsTHPJ4i9RbuBU+FgnanqpK9HvOHEbPRczOVeADT9Yu2TtlbqfrKhcMZhGEhpANEhBBOZjriYKHBofMJkywZwAU3dG5wBvykpoknFmdrlhGE65UUuyUIVgjY/MMDEpjDSvPDJRLWonfs+/6hO+eJxDJ8sAxey27RcwXuzceHJ/Bje3cPeoVcEfL5VHvsvXoK0kONhk0xWXbTTTK4cr0iVygTINf26v/AtlTrMUd0t+Gr0faECz8jPkRqtBmHowVvqw7wIQ2Cjq+eMx7i1s+HaZqn7auhMXj32lD5dCNyfqdrjSeIKl/bviQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(8936002)(31686004)(66476007)(38100700002)(36756003)(53546011)(2906002)(3450700001)(86362001)(5660300002)(7416002)(83380400001)(66946007)(66556008)(4326008)(6512007)(6506007)(6916009)(316002)(41300700001)(478600001)(2616005)(8676002)(186003)(31696002)(26005)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9EZHVoT3Q3M2pRRis0QzQ0a1pMWW40bUQxR1EyeitTNGNjMHpoMHh2NFFo?=
 =?utf-8?B?MzdhR2xrQVIyYUJkQlNmaXpYSE1rak5KNXhGVTNkc3FoT1lGb3p5RTk4cXFY?=
 =?utf-8?B?bUEyS2RUcTgxNjRFUXRRSmRYNGZXNkRmYnAyczUwVEkzNUxVWityRnlDZFVM?=
 =?utf-8?B?ZThFMlRtMVR4bXhuM2I3T1dSU0ZSOFR0UlFWSFVJK1pXUzVSeHZVY2JzY3pj?=
 =?utf-8?B?aE1obmc3N0pJQTNqZEVPSEV6bmRRM0lXeTl4YVBoUWgyL3pmVnB6MHN5OGEx?=
 =?utf-8?B?NkhscGRtQlc4MDU1YkpIREtJREZUSVZzNURXTmtaVEJRMHJObXJKTFJFcUNE?=
 =?utf-8?B?SEszSlVOdUFTMEZWbTBQaVJqZUVZZkYwK3RZWlNwTVFSeGdmMkl6Z2QyV3B0?=
 =?utf-8?B?bXNKSExqaUIzS0owbVdwTWd6S0tWdENRamNoYzNUaTRuMGdaeXRYeklpdlFY?=
 =?utf-8?B?dVdWUDBpbU95eStWbkV5cFdFUTBuREpBWnlWemkxbGxPRlVNWnd3R0Yzb25O?=
 =?utf-8?B?Q2x4RlJTOXp1Wkg0NmQyRnpCM1R1STZLaFNwc1JhcEVqN1ptUVZGRUUxQzND?=
 =?utf-8?B?aFlkMUkxUVpnbExmYUlocUVLWk5XcFFqV3F6S3U2Z2dJZExXdnhaY2tsZGM3?=
 =?utf-8?B?YjhNZWNDalhVcTYvUERKZDkzWEM2bHovTkhLT2tYVGQ5WktNalBGbW44SjJK?=
 =?utf-8?B?ZlUrNzVsbTJZU0hERkJ3ejBLcTEwNVJ1R0svdy9tQ1NUUnFzbUd6eHF2SCtZ?=
 =?utf-8?B?ampOSy83cytVbUp3RTZYR1dVZ1JRNHRqNlZZQ2U0bUZuUVhZNlJlVnlmQytt?=
 =?utf-8?B?aTJmQVpJNDB0SFgvTmxQQTRKN3k1N2NOMGpUYVNnY1R4c3ZtVEFXZlNIR3Jo?=
 =?utf-8?B?Zi9vTGpueDVVdEtLWGp0MUZXY1hsQ0pOd3R1VTJ2N1Z5cThpL3RiblpTcCtJ?=
 =?utf-8?B?Q2prZjFXNnVrdk5rK3NUU29uVGNvQTFxWDFneVVuZXJQZ252c2ozcGtjdXJX?=
 =?utf-8?B?ZmVFbVZuR3pEczgvSGRMZG9FQXdWUFBvVkRrRmRmNDIxdFBVT0QxcUswN0sx?=
 =?utf-8?B?ay8xTjA2eko2OFljbGdrNlA4NDZJOUgrOXFuU2l0dHU3enllejlHMW9ZMlNJ?=
 =?utf-8?B?MTI2NnNQRE1KaHJBRUFCMm9JZzhrcmxRcFhCSll2elU0clBmdDM1NEJLSUtw?=
 =?utf-8?B?UUpNMDJ4elJqR29xeGpFeHMrUURJb3A5UzU1OER5NEc1aE02c0YwRUU2b1Zv?=
 =?utf-8?B?YmMxN1ZxNnpMc3VKcHFRMU1HeXpxbk1RUTBDc01HbFlSOTgrMW5CSXZTZjI2?=
 =?utf-8?B?MWlsYWxCcU5VdllSY1d3TGZBL1J5SHorU0tLdDBGNnJ1eU5FMDZxRkk1OGZm?=
 =?utf-8?B?cnZHd21FUVVrbkdMTm5UdjBZQ3g4RTJ5akNYUXV0dVd3MlB3T3A3VmJ3NHN1?=
 =?utf-8?B?UklNU1o5S1lPRDhMZ2FqUFE5U2xUWUMxYTZlbXVvUUUyRUErQncxeU9PdlNH?=
 =?utf-8?B?cE9RazZ0Z0w4Q05tcGVEdkZRSE01MkZiL2tja3FiZWRuZGUyOWptU1dTZ3c0?=
 =?utf-8?B?K0RCODhBVFlEcG0vNHNlRndubzZZV0dUTnNKUDBWdWZBS29TYjZnWWJGajdB?=
 =?utf-8?B?THI4cDdCN0ZLaXJGVG9OZklxaEVWTVNXSVZaMG9MMnVoa1hqcnJGOGVLak83?=
 =?utf-8?B?blc0STVvSkJHY2hpTG5HditOa3p5RHlYanlTejlBdnpnTkp5MFRneUNhb0JE?=
 =?utf-8?B?VzR6Vjk5S1JpRjBHdzNobE9sT2x6bjVCZUNyNGptaVdFdkJESGxGYmQzbDFZ?=
 =?utf-8?B?T25UZVZjMWR1YkhOeFJVN0ZNNHlDaFN6Zm40cXpxK01xclFrM3A4QjJ6SVpF?=
 =?utf-8?B?d0R6eW1laTFYbU9nUWJYUnFNRERnSEk1Sndvd3ExSnJrT1ZUYzBML0JGMUpz?=
 =?utf-8?B?ZUlPT2M2bkQvMjY1b2FmVGNWc1QxeDh4NXdFZWdCV1RIbUNaTCtZUlp1ekwz?=
 =?utf-8?B?R21qYk9IUlBFdTVDLzhQa0E0NE1LbHFjZ25jZGxtQUFkNUJ3YzFoNitPUmp5?=
 =?utf-8?B?Ky9YZDdBOEYyWkZvMHNBcU84djVJSGpQYkpUVG5INDY1MytjTFRVYjhZK3Bv?=
 =?utf-8?Q?Un3w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff87bcb0-0d08-44bb-fdab-08daa21dbab4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 13:22:59.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBiqPxocLPPG9qZTyN5MWkZFzAbCuREE6VEsqzqDcw7Fa8Ev8sTnJgQj4wztfL0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanjaya,

On 9/29/22 03:48, Bagas Sanjaya wrote:
> On 9/28/22 22:23, Moger, Babu wrote:
>>> Hi Babu,
>>>
>>> The description text for each snippets above shouldn't in the code
>>> block. Also, split the block into three code blocks in the lists:
>> Did you mean, I need to remove similar texts from code?
> I mean extracting code description from the code block, see the diff below.
>
>>> ---- >8 ----
>>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>>> index b4fe54f219b6f3..ec578b069276ce 100644
>>> --- a/Documentation/x86/resctrl.rst
>>> +++ b/Documentation/x86/resctrl.rst
>>> @@ -206,25 +206,26 @@ with the following files:
>>>          all the event types and the mbm_local_bytes configuration is set to
>>>          0x15 to count all the local memory events.
>>>  
>>> -        Example::
>>> +        Examples:
>>> +
>>> +        * To view the current configuration::
>>>  
>>> -            To view the current configuration, run the command.
>>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>>              0:0x7f;1:0x7f;2:0x7f;3:0x7f
>>>  
>>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>>>              0:0x15;1:0x15;3:0x15;4:0x15
>>>  
>>> -            To change the mbm_total_bytes to count only reads on domain 0,
>>> -            run the command. The bits 0,1,4 and 5 needs to set.
>>> +        * To change the mbm_total_bytes to count only reads on domain 0
>>> +          (the bits 0, 1, 4 and 5 needs to be set)::
>>>  
>>>              # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>>  
>>>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>>              0:0x33;1:0x7f;2:0x7f;3:0x7f
>>>  
>>> -            To change the mbm_local_bytes to count all the slow memory reads on
>>> -            domain 1, run the command. The bits 4 and 5 needs to set.
>>> +        * To change the mbm_local_bytes to count all the slow memory reads on
>>> +          domain 1 (the bits 4 and 5 needs to be set)::
>>>  
>>>              # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>>>  
>> Thanks for the diff. I cannot get this right for some reason. I will
>> probably send the diff before the final series.
>>
>>
> OK.
>  
>>> Also, there isn't description of mapping from bits from the supported events
>>> table to the bytes input for mbm_{total,local}_config.
>> It is already there. Is that not clear?
> No. I don't see why setting bits 0, 1, 4, and 5 on domain 0 translates to
> `0:0x33`, for example.

It is 110011b(binary) which is 0x33. I can make that little more clear.

Thanks

Babu


>
>>>> +Slow Memory b/w domain is L3 cache.
>>>> +::
>>>> +
>>>> +	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>>>> +
>>> What b/w stands for in the context above?
>> b/w is bandwidth. I will correct it.
> OK.
>
> Thanks for replying.
>
-- 
Thanks
Babu Moger

