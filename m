Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB06FCCED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEIRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEIRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:42:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6EF4209;
        Tue,  9 May 2023 10:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMljjGgJ2eKv4sqb5nO49vs/XW7VPBb5ni5B57q6HC8UC0I0uk0uM+WIZDttTAOoaELoIt3vxr0FWZ1ecDY33mR8HxEPvDSaMPzl83oFSUKjeoHd4tfYqIyU+9KomCZZOfCo5UEySfjDmfOegLWCh6S7lBiTaM4GsJ6+HPuBg+LjL+5g1lk+K5EhVxExrGmMV1obydvofBChZI7SHVYp2fbGtGsLD/fe6wZIXIO5v8LuUNev5FUyHooXSu61oIIb8Sbjye1qg3JWzEBPWpsuSIw/1gUNiWG8Vn27eTuxWt+N1aYL4KMmegxCefSbgcfRFEc/fAlRCWx1EIRxjV15qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWotvMGId2Ego4V3yg/rTyzUiOGSHLjwQkEkN1gTX2Y=;
 b=ahRfiCgjFpJ2lLxqK4Gl4NKEMOu/7c3uLCfMNQHbaYrEqFFdOqexEHe2PmjlLJBudCzK62hafPhiGAXfULg01mnIA54kKUABQTnObIHS8RePYKwPfb+vSTI6UXa5bvc0eGCw2jsG3uIBR48xwXkIedjaSNnHfAyRNpQmfa8Z+Dw94E4LMcVbqxFi2Tm1CCC0/2epJnSsaq4wipz2/gSVBKAUAUT83STrMuYhrRmkttmUudn5X80PhiQSJhP+KtdMSZpLaBJtr+fRQZKjMJHu+wzRAAIuxE0ljHtTktMHYb0hYGAe7K8Q+WcKwqKXjJxZUDc83M8y7tdV2b1yO+tkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWotvMGId2Ego4V3yg/rTyzUiOGSHLjwQkEkN1gTX2Y=;
 b=hSKlu37vanej57em6fdtqbj5uof3wFEHyzWh9xnsGk8liwXaNMBbHMpIEFWQWlWf4DDMAlUlJWVMiNE88EFryv27Bn/jT5t99VDu95LDl93yX5AYR0RqocsZ7fCWCBrooqQdriNO0eNJfJfSlatswFc/FNt2LsWs0plnLDwg1+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 17:42:06 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 17:42:06 +0000
Message-ID: <ba7d857c-adc2-c22a-0993-fb3a51b3ff60@amd.com>
Date:   Tue, 9 May 2023 12:42:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 3/7] x86/resctrl: Rename rftype flags for consistency
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
 <0a2bb59f-769e-42b0-9277-10a4b04a03ed@intel.com>
 <232c8e85-0d5b-8e24-33d0-eab5eee186f0@amd.com>
 <3da8d7aa-8a43-bd11-b7cf-824e1a7e1fd1@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3da8d7aa-8a43-bd11-b7cf-824e1a7e1fd1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:8:57::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0456dd71-2913-49d6-8820-08db50b4b4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cd1cGJUWmY7jny3Q+WZGNp7/9HSKpkItTIFAjUK6pTJ1Ycc6GxaZMh1bIUwbiW8zI/hQcJfJLW408+CblkwkuwRvc/clHHvZqNSUtzcNmGjZcNJUv+zDKyQsmtjkVIr2OQX0nTFMmQUjA2ivdf1i1v1pM66OrJEbU0G3aGda/n5ZwBYZNHCHrBd9cFr4ib3lmWFU4CYvnCtFsrdQsbmXARfSdNeSJ3KcmPUXRaziPI1X110ceTKWawDVXbRvDXiUX/YiiWiEtbVp8eoY0yrACDA9GDMsSOdF0LAGVdayx/FbyzvJJ5h3x7mkmZWjXZ9I6NVkzy5WVowMxHyfZN12eXhJKlOTXzuNE4hFoMODMV/AhG4aqbcIMngfVhMwHiSimr2/syW7JUoEVRHcJ/0EZckRiUBDfEzzOWOzeqpE52KyJ11w6EgzKqKjUDuAXU3hE5aCswGvbNEsIrYgPn6plBNcZCCDxjiLbvRbQIk/oQIUXJGtuTWnfcfrCPcISVlf+tT+ECreAsudt8N6QWExfKpIyLMF8KdfD8mhgdi50bDLdYKbCGRcf5f+wujc1y1BrfDVlKpE49QrKpDQPjUXUwUdgvCVEqipPRRJiXUuV80kbIk7s/7XpXi20N91Kjsr9bzox88UIePPrw9GF5PT8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(6512007)(3450700001)(41300700001)(2906002)(316002)(186003)(2616005)(53546011)(6666004)(6506007)(4326008)(66946007)(66476007)(66556008)(478600001)(5660300002)(7416002)(7406005)(26005)(8676002)(8936002)(6486002)(38100700002)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cis1cWtkQUMxYnBicUFTSHRjeHdnWVNHaEVVMWFsOHZJeW9Gdk1SRmhabDFh?=
 =?utf-8?B?YThxRkNsUUpSciswK0wybUlmQ2JEOW5NZnc3TkRtZ2hFRHVKU2twM0NKaHl4?=
 =?utf-8?B?eVV2OWs1cC95N2g3MC9McUpESkhXeExvYXRGdTRjWENjdE1lM3E4emJFMzdT?=
 =?utf-8?B?ZWhUTWlweEVub1lnK3VxQ2R6ZDJKL1dOSHJXZldkVk5sTzJxZ08vSlpjU0pL?=
 =?utf-8?B?byt3YjY5d2NGdC9JZGFLaVlJZmloVzBRU1Q2M1h4ZFlzS2VnVmlrVTBxQ2xr?=
 =?utf-8?B?bFBJa1lGSzBFUXlZUURaY3FlNGUzOTI2eHZySDFveGVLYjAvNklubHpqRmpm?=
 =?utf-8?B?aGRhRndOVWY3bjJJL1NiVlc3Q05ndXFrdTNlVHcrQ0h5T09NOXRsWkhMRjVF?=
 =?utf-8?B?Zzl5dFBzYmNhLzlwdUdZcEZBcCtNZkhhRVdBRjZISVpzTTR4QlpZUEFaRE5I?=
 =?utf-8?B?aWRCMUIzcmZtUTlYcldnV1pDRGNKcDhMQmZaTVhzYlBWQ3k4YnV2akY2eXRp?=
 =?utf-8?B?MXVrQ0tRNzliMHpldGFsYTd0a0hqOXp6ZzZxNkpqNTJ2Y1JxdlJwVHJGZkg3?=
 =?utf-8?B?WHhWamV0RmZ4QkRuWGYydzJkaEdORWxndWI1RkNDbERGSFRBd1h3dFNBc1F2?=
 =?utf-8?B?M2d0S0c5TUFsMXRqbXpEdCtjTjFnVVdLdUkrajNPQjJKNENOdTV4UVNUQ1ZQ?=
 =?utf-8?B?Yld3RXdEMnF1d0ZtckJCOEU0Z2gxRlBjaU90SXZ1OENydjYwVFkyRjVQUWRJ?=
 =?utf-8?B?OEtyNjRVcmRVOGE4KzRhNXIzaXppYmJUM3QxRDdkZUZUZGwrUy9uc0g2amtj?=
 =?utf-8?B?V0x1K3ZWNFhrWGFsRGx4Wm1uUW5SVkFiaGNmclRTN3ZIeDNjamNFKy9hS21n?=
 =?utf-8?B?V3hxdWMzTWhCcGN3cVVQSDU3ME5oSS8zSVhNWVFFVk01OXdzMWVjOTc1R0lj?=
 =?utf-8?B?c21Ea092dlQzZlE1WUdac25lbnVjMHkzVGtXSytaRjRWODBEOXpOU3IxS1pH?=
 =?utf-8?B?bEZ1dDludXFGbFVqNFNYQTdPTFhxZkpMa2hvWGxTYXBXZHlLMlFzVGcwMGNp?=
 =?utf-8?B?dnNhTlZXdEpRVUJndCszUWNnT1Q1UDFlZDBrZ3BZd0lacmhXYnFXNWRtMDVu?=
 =?utf-8?B?SzRvK0tXWnh6blJLRmFuNjJIdFF1VnpuUkdycFpVRlJYL1V5MTFPdjRubzJR?=
 =?utf-8?B?UjhZWmJYVnY4bHRNcDRhc2gwVEtDT3Z5a1pZM2RhaXo2TXdPbEx5UGJOMWhO?=
 =?utf-8?B?cTF2dlhvak5hR3dCR2ZLK0xWSlZEaUo1cDA4YlU5TU03VC8xYlR5dVB5cXFW?=
 =?utf-8?B?cFZ0S094K0VCazlHWXFRVm5BRERBbFJUa3V5OXFKNkVNZ2duYjRlY0VpcEF2?=
 =?utf-8?B?aUlZTmtBbFlCS2ZsT0t4UURmM3NMdTA1bEZYVVdHM3FxQ29IZ2FEV0kwYmYz?=
 =?utf-8?B?MUpSbnF1NXNqUzBvaEdVdExlQVRFNWFxUmppWjUraVhOZGt3aS8rdUp0YWkz?=
 =?utf-8?B?V0FUVzlsV3E3a1VoNGhkaUxEcEN2aHNqeXcwRHZONS9FWU9IT2dhQzlsOHlL?=
 =?utf-8?B?dUZ1QUJ5ZG94Q2owOERjdjlCOTRPa3FLalUwa2t0blY4VG1Xcnd4b3R6OEZZ?=
 =?utf-8?B?L0tDOVc0enF0RVYwL25LZFg2QXBoaGNZaC9ocXRMZ05GMUh5SXlvSVBDTkJ0?=
 =?utf-8?B?eEJJVEs5cXFTSC9aL3M5U2JZNmZJYWtLamNuQUdtY080MWVUQXUxMlNnalY1?=
 =?utf-8?B?cjRJTVNDNG5HdzM3Vm9ocFVmdjR5Q1BJRk0yQ1k3MVMrMC9HbEJ0cG84SVY5?=
 =?utf-8?B?bnFIeUZ1MEs2Qm5ybnBXVStsMlY5bXBCZW1YVXk4ZkswY2I1d2FVdTEzQkRa?=
 =?utf-8?B?VlBuTXBURGhyaWhhTUF0ZFRkbnhZKzJnMk5iNG8zbWRBTmNnTlpRTy9rZTJZ?=
 =?utf-8?B?b0ZUMUZMYXlBRzNiWmN1cmZoTnNLMUdzeGY5ZWZvT2Y0THhWa3d3V1YzRGpx?=
 =?utf-8?B?amJIaEZ1K0JIZkd3Mml1bGVwNmVnQndKVmhJM1BoOStUZ29HLy9idDZ0d0ht?=
 =?utf-8?B?SEpjSzMxSE40MCt2TW16U1o4cFYzYjZKU0orMjg0a0xxWWd2SXRoZEJFQmgr?=
 =?utf-8?Q?OVQg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0456dd71-2913-49d6-8820-08db50b4b4a8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 17:42:05.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/vlE0Ab16HWo2AHlVBT20iT5MvEKlaqoMuj6ImbFRY26pX/H22HCrkmDtGk69h4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/23 16:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/5/2023 1:16 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 5/4/2023 2:00 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>>> The rftype flags have two different prefixes even though they are used
>>> Could this changelog please start with some context about what the
>>> rftype flags are? Please note that the changelogs are required
>>> to comply to the x86 requirements as documented in:
>>> Documentation/process/maintainer-tip.rst (there is a whole
>>> section on changelogs).
>> Thanks
>>>
>>> After a context the problem could be made specific with something
>>> like "rftype flags use the RF_ as well as RFTYPE_ prefixes."
> 
>> I can say start with "rftype flags are used for creating the files
>> under resctrl filesystem. These flags  use the RF_ as well as RFTYPE_
>> prefixes.
>>
>> Change the prefix to RFTYPE_ for all the flags to be consistent."> 
> 
> I would be careful with the term "rftype flags" since it is
> not clear what is meant by this. Note that there are RF_*, RFTYPE_*,
> as well as RFTYPE_FLAGS* flags and the reader may easily think that
> you refer to the latter.
> 
> "resctrl associates flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change ..."

Will change it.

> 
> (A shortcut I used was to look up the commit that introduced the change
> and borrow some text from it.)
Sure.

Thanks
Babu Moger
