Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1683627B16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiKNKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:53:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D781271C;
        Mon, 14 Nov 2022 02:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EleY9GBuHm9QLaXDERgmUK8e5NNkWyikMj5nwvPj3xz8CeuMjRFsJNyFvX0i0SLggh72lSiAdwDY2kDUTvU/9r1DHkyx588Cmib9INDn9iX2nfeHe+3GXRudP02zlK0HwWP0eVCjEO3S9ku65SaYzoLQ4XI905skwNRQ2FaLkOOAWY1GMGbeWmZHtbSnUi21y8kcmcTtSBib2FkuXKB3F6ukl7G7nOPyGEz4NpewSk9RsYaZmRc8qd6DmdQBFF2kStU40NEs2ERpEOI+1j/9DlG/wtxUZEgYDa7XYySgXn0ZGxo6TWfxlWpM4LBatnWLrUBrNDW7iS8Ssui+dZyKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcaeFwHJliz+iVp5iuOIW/g2rTAqCS/o/Z6fxfyTdxI=;
 b=jciXLMmcLgrW0x5eKbz0l3bHCxLdVdjb+Y3W19ucwxwzMgpdYIn+c6VLwH1E2a/fk4ZGuB8kwpzIhG1Gz74XebndkeRF7Jx7Ip+CKnlM4MNzxlA9q6BpagaBPfUzKWnIEW6b68VYXphFkTfQZKwN2pukcZjnR4nuM9WSps7kso2wDXH+PUXYDOVsaKUwOFOh3MdDh+x0y65WxKDJNRvl8F8hAdV7r0awtmeYpHrcf0GeVY2GYOILGxh87W+fRzyVGFUSJR1AsOmroqJ/SlwqnPlF48J/5r+uquXMWfwNk6Z8T0iZMJHCsQ7+JAu6v1R99vbOkMv0vdvMMBzUKSS3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcaeFwHJliz+iVp5iuOIW/g2rTAqCS/o/Z6fxfyTdxI=;
 b=WR0Zm7YXPPaGITAYzajRIWHZmzScA0Tnt+7Xuy4kf9zSY/tuoAAa1XtYFfav1bdt6VCORq/douEOcAoIuy/0YnV1wl9cRbScvyVjituSlQ8DDVtnNqVhajcNT5gmVZmqpqGjbEchPRkTJTlut6MdsGisWE7RcLaPEqIRYtnEFy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 10:53:34 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a3b5:7bec:ebd7:b30c]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a3b5:7bec:ebd7:b30c%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 10:53:34 +0000
Message-ID: <923336bd-9669-88fd-9c18-159f2b6c4b00@amd.com>
Date:   Mon, 14 Nov 2022 16:22:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does
 not have PERFCTL_CORE bit
To:     Liang Yan <lyan@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027133511.161922-1-lyan@digtalocean.com>
 <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
 <a9677c3e-1f2b-a18f-97f5-9cc1a216ed9c@amd.com>
 <f5793630-f13d-42d3-c045-276311230682@digitalocean.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <f5793630-f13d-42d3-c045-276311230682@digitalocean.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: c382a9af-2def-419b-8cea-08dac62e6952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWNOOAzCUoMcnRkx8uiHoh9rN7XQYB6nyXdCMC07EKIv1hbePcj0a/4ZHDYUN1HMPi3IYghHxQWvlPBXwIfAyVOfoav+pfYn4A095fNXuiC1HXPvmge8q8sbjGVuh4Oebc9CM+93XW9BLZmClani+pu51CgkqNGAil/vCap0VZ6xwokjK8FaqCal9eYHKWeCPQ8gfP1gKPvTnwk4KsLq4bbc60Qa+zufIeNrGZQ7aZ6Mz/7rcgg7e/Vt6zhrSBYEL2Ot8RqsOgx6GIGhHbThwRGmzUmGfrHX0hYSqpdvUkr/3uj/NH6SVQb3YwV0TRs0OabdIOvUPO9YqfCxyyyBud3XQjRVtlP3bH7lBouRL++GhoZF6NRP+wf4plxZK8BTTqNBg1zSnk6ZPrVwFaGxbAixVvAYsp1VwrKXO6xRPTAkiUG2LxO1ukIjjN0ZJB8Id0WujbRFObCv9loh3jUm6PkftPTKUqY8n4fjSPSgsZDcHbmo7dYomslHAFO22vsSFP6gt9/zXt+c8Vg+CyjJSVUF+zQZISPQwhZPEbVi2NjlfCZ36pEqLPc1/aCtW6KQTpsbjK9XkEk7R5PINtgNOwFq0eLwa/rfZ+muFXxlSKtXPsyGJ7m8pP8j8hULChoggB62dPClTwhYpusM2N74Dy3qAM2UQuiLP0SaSBth6ixEUhHUpN1g+ZbeVZ8c9Q/fXTWuRjoQopoY3pgsd3g15ulMFiDdq4LASLZnKcdGfimBLSwS93TJMLUASfZIqOe4ef+va1AKTeR2VGtp310+miftmGe2cjFXOE14bXEOsMEvSu6FkvtolArkNRAu0F5LSXsSzlLiYVpYFL6j51OVPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(41300700001)(2616005)(186003)(36756003)(4326008)(5660300002)(7416002)(8936002)(44832011)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(8676002)(38100700002)(31696002)(2906002)(86362001)(478600001)(26005)(6666004)(6506007)(6512007)(53546011)(966005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTV2aFdXWkJzcEYxZTAyVkhmazRVN1hQS2p6QjFhbUN0SUNXYlJIZk5FblYv?=
 =?utf-8?B?UVN0UkJDOFdNUGxaV3dDbU4ydGtnQW5ybkRkZEcvWkdLRitIcWljNEFvZ0gr?=
 =?utf-8?B?WjZXM0RqYjJrOWFBY1Y5NGJxZStodTdpaGxFUEd5emNBM1BYaUk3Z1ltbmtW?=
 =?utf-8?B?bVRmL0RDRmwwNGh0SE15d1lWbWEzWGVmQStwSk1ydzBrd0tGQUlsVVRucjhs?=
 =?utf-8?B?Qk1PTEN0K1NQS1FJVWRMWHBxUEIydUZJWFgvc1k2Mm11bGpZSHlLSHdoeTNp?=
 =?utf-8?B?aHpkT09ZNHZjSDc5SEo3dWZxS0REUlJJR3I5THlDTUNUZ252L1pmSStUb3lu?=
 =?utf-8?B?ZTBoSWV5dlVwNlMwSU05cFMyMndnUmZEN09kU1hvWUowVTU0K1RnOGM0RDlr?=
 =?utf-8?B?NXdMeHdrbG1Lb2JOSGthKzNTUEZrbDlaOHZtN2YxcWZaMHZ2dEsweGZibnVT?=
 =?utf-8?B?M1JycFJTYndqT1RIcEw3RndMSFpjSUh4TDY0c296RmNUN0lScis0ZldMRFg4?=
 =?utf-8?B?ZmMwVmxsd00wWStqb3I2NTBqZkFWbnpMa3dkYzVtNEtjZmU0MEZNYzJpUGRE?=
 =?utf-8?B?ZVB1ZlFZNzZ6TmsxRmlKbWJPUUdxZm9FK1pvNnFITDBMR2p0Nms5MDN2eXhj?=
 =?utf-8?B?NEZGOHpKT3hQOGZWL2tYaGV2dkpxUlhJVk0xRzBXWnpyQnpleldNRmkrZy9V?=
 =?utf-8?B?RXoxaVRaNnA3aXBIeW0wZEg1WHlMWmdnNFA5OXh1bjVGalZ1S2xKQ0pCSkFT?=
 =?utf-8?B?eXl0MWxCb0NHcE1aZDdvTEowQVZaTG56SzlYb0RJUTRGTHNzaHhURzBtZitS?=
 =?utf-8?B?MVBCdS9NYVJBRTRhYVM3R1FZcldzMkZ5V3UveDhIODNtL0Q0MUQ1KzhlRDFY?=
 =?utf-8?B?eFFHOWZ0SXJkZTlYbktKUU1Qc0VvbmRZSHpJZ2RJUjg4NFkrbXlBRDJ5Z3hR?=
 =?utf-8?B?eXFJZ3IvZENESVBsWEM4ZlBuN3c4bnlMd25VOVpzOUErZVlnb2U5dHJzUms2?=
 =?utf-8?B?MEpDT1E0ZHdMMzFRNFk0N3k3OHc0NmxoaFNWSys0NzVObDI4WGFicU0xa0xn?=
 =?utf-8?B?UWoyelVzY1NVbGZrOGxpQXlvNTdCNE1oSTdENW93RDY5QnByN21UaEdCeG4v?=
 =?utf-8?B?ckN5SG5FeFVZV3d0b3d2YmVpbVNJcjhlNWZYdnR5Z2lQQ0I4OFR1Z3NDUXZl?=
 =?utf-8?B?NlYzZm04R3hIcnBydWsrdlNpcUgrMkE4U3JqZHV6K0ZCb2ZFUU1ybkJBd0xD?=
 =?utf-8?B?R0RrcUs3T3M0UDRFd3R6SStKZVlaMkNYYUw2SmZYajJ3T2ZOaWxLME9IWERw?=
 =?utf-8?B?TXpOOHFpbmhoK2FzRHV0WEhZenJxRVFuamQ5RnFDeFBUMnpSWlM1OWx1anlz?=
 =?utf-8?B?MzJ1MCs3bUxWcE1mekx4dkdYK2s1ZmxUWnFCeEYxVW9QaGwrampxK1FMZFYx?=
 =?utf-8?B?TnduZjlTWXdHYWRVcmJuQ1pHdzYyYlMzT2xnZm9BbzUyL3JiaS9tUzVtMnA2?=
 =?utf-8?B?b0hXTVVXWVVCUnJOK0JEaEc3OTh0TVYrb0V6eHdVVGh0TFFwdVpWZm5PcmM0?=
 =?utf-8?B?T3ZaUlo4blZhbTNWNmtZcmV6SVk5ZFlCUXh5TWdzVXNFcllTelVPc1ZPcFZB?=
 =?utf-8?B?WGR4SVRtY2hKZ2NRdzhHcXFLeTVIOC9CdndYWFFmVUZvM0dhN3E5NE5pU3VE?=
 =?utf-8?B?RDVOYVNzcEo1b28vcHNLeUptcVVRUE9FNTZnUzI4ci9lUkQxaktJblFYSDNm?=
 =?utf-8?B?Z0FZa0JEVmVjb0tQVGNrMTVJZHhKREIrdmI2c0NBOXVEQVltNElpV1M5dHBj?=
 =?utf-8?B?blNucVJPelU2L29LbFV2ekJCSVc0QllpcmFFcGI4YXMwc2NKWmlIMkxPVUNq?=
 =?utf-8?B?WU9lRkhkcmdiakRVVXk1WjZmTlVqc294b0JuMUFMWGd6VWRsdTJlSGllNDVG?=
 =?utf-8?B?RmtCT2wzNzFjbE9nWUFWSmxzZCt3QlRzNE1rT2Faa1hVNUZCUW9qcGt4TXBP?=
 =?utf-8?B?M2lXVWNlS1BnOVVpTnM1OHdSMjB4UXhLR0c2bVQ4Uy8vekRvWG52Umk2cHRO?=
 =?utf-8?B?dEFiUmN0Y1U5S21SNlREQWFRM1hVM1l2V2kwMmpnVTFzUk8vZ1pRdHUrWTJP?=
 =?utf-8?Q?162ZY6PURmxIJ4hxl8VmbRAYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c382a9af-2def-419b-8cea-08dac62e6952
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 10:53:34.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fhgNJTiWbPwcyyACsDGSEVcv8DgqbByWjwNOFLOMko/X3QeuHsG/qcBqWL1BTFHMhm37C/8cN0aX70WMZ6zFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2022 4:03 AM, Liang Yan wrote:
> 
> On 10/31/22 10:28, Sandipan Das wrote:
>> Hi Liang, Peter,
>>
>> On 10/31/2022 6:29 PM, Peter Zijlstra wrote:
>>> On Thu, Oct 27, 2022 at 09:35:11AM -0400, Liang Yan wrote:
>>>> After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
>>>> still loads the pmu driver while the cpuid does not have perfctl_core.
>>>>
>>>> The test is running on an EPYC Rome machine.
>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>>> [    0.732097] Performance Events: AMD PMU driver.
>>>>
>>>> By further looking,
>>>>
>>>> ==> init_hw_perf_events
>>>>      ==> amd_pmu_init
>>>>          ==> amd_core_pmu_init
>>>>              ==>
>>>>                  if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>>>             return 0;
>>>>
>>>> With returning 0, it will bypass amd_pmu_init and return 0 to
>>>> init_hw_perf_events, and continue the initialization.
>>>>
>>>> I am not a perf expert and not sure if it is expected for AMD PMU,
>>>> otherwise, it would be nice to return -ENODEV instead.
>>>>
>>>> New output after the change:
>>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>>> [    0.531609] Performance Events: no PMU driver, software events only.
>>>>
>>>> Signed-off-by: Liang Yan <lyan@digtalocean.com>
>>> Looks about right, Ravi?
>>>
>>>> ---
>>>>   arch/x86/events/amd/core.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>>> index 8b70237c33f7..34d3d2944020 100644
>>>> --- a/arch/x86/events/amd/core.c
>>>> +++ b/arch/x86/events/amd/core.c
>>>> @@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
>>>>       int i;
>>>>         if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>>> -        return 0;
>>>> +        return -ENODEV;
>>>>   
>> There are four legacy counters that are always available even when PERFCTR_CORE
>> is absent. This is why the code returns 0 here. I found this to be a bit confusing
>> as well during PerfMonV2 development so I wrote the following patch but forgot to
>> send it out.
> 
> 
> Hi Sandipan,
> 
> Thanks for the classification.
> Do these legacy counters belong to the AMD PMU property from a VM perspective? I mean, if I want to disable PMU for an AMD vcpu for some reason, is it possible to disable perfctr_core and the four counters, or is this not logical since the four counters could not be disabled from the bare-metal level?
> I asked because I saw 'pmu' could be disabled for Intel and ARM, but it seems not for AMD.
> 

From what I see, the four legacy counters are not tied to any processor
properties (e.g. CPUID bits). Disabling "perfctr-core" only brings the
number of supported core counters down to 4 from 6. So guests exhibit
the same behaviour as bare-metal where the legacy counters are used if
CPUID 0x80000001[ECX].PerfCtrExtCore is not set.

The "pmu" property only overrides guest CPUID. Hence it is not possible
to prevent the discovery of the legacy counters using that.

> Also, could you please list the four legacy counters here?
> 

The MSRs for the four legacy counters are:
  0xc001000[0..3] known as PERF_LEGACY_CTL[0..3], alias of PERF_CTL[0..3]
  0xc001000[4..7] known as PERF_LEGACY_CTR[0..3], alias of PERF_CTR[0..3]

You can find more details in the Processor Programming Reference (PPR) that
is appropriate for the AMD processor that you are using. PPRs can be found
at: https://bugzilla.kernel.org/show_bug.cgi?id=206537

> 
> 
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index 262e39a85031..d3eb7b2f4dda 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -1345,6 +1345,14 @@ static int __init amd_core_pmu_init(void)
>>       u64 even_ctr_mask = 0ULL;
>>       int i;
>>   +    /*
>> +     * All processors support four PMCs even when X86_FEATURE_PERFCTR_CORE
>> +     * is unavailable. They are programmable via the PERF_LEGACY_CTLx and
>> +     * PERF_LEGACY_CTRx registers which have the same address as that of
>> +     * MSR_K7_EVNTSELx and MSR_K7_PERFCTRx. For Family 17h+, these are
>> +     * legacy aliases of PERF_CTLx and PERF_CTRx respectively. Hence, not
>> +     * returning -ENODEV here.
>> +     */
>>       if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>           return 0;
>>
>>
>> If this looks good to you, I will post it.
>>
>> - Sandipan
>>

