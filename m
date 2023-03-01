Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B76A736E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCAS1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCAS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:27:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE348E09;
        Wed,  1 Mar 2023 10:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJoef8jXBJ40SlYGGFIn/JaPaU30JyYuVn7ZL8sMYJ9FeTR9ZacM6Xz0Qgb438Np7LmUzILhO2nvbeZHjUNzU58becV8OovrSXlE15fBp1ZDLRuJFkIKBfaIBpa1oAQMjQDpxUIAhGnBsNlCPkkfpPNfPm6KzU+XWDnnE5b8+oyebXj4/PYNjJDVY8rVs0wprdb3cPI40bCnO70RfkNldTS0PYmpvYs44+a1vPDNghuOUdJgGVvcrm1ZyGNOJI24B21xxwS+10HhKfcqKEcK37qvmNQK4Dtd/rmQdvSgj4nPHAEiRDYWW5tiFtWdIdNyslRAD4fW00iV5q3Dl1eiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE0BwAPlnsjzuxys8SoK0d0cxsuxaUSCiGzi+68fD0Y=;
 b=cjAm+01ysFcBNiofDiqrYJQG68Eh4wSCKuQSjnot4CDBREe9bbmbcG/xRMIvSzcAvenUAOrVyj/p5sR9OB7q3YWzZ0m2P2S9C4YVvo7Px7+VAO9rJqboSsjUeKJeh2ZxpjqRbmFOxSQl3NN4VPLNS9M7VDHsPMe/vpXG5Geo+gtfOY+XZBY1rOap4zCgTEoYgppZJgBeLx2XMOAbuBwuXM3d/00OculOuWLFRkQd8AWwh6/0/tpysEfg4DfiZxAiHj3OZAuz2POU4hIE80fwZaeHueXtUH/KL626qF+PoUo3dcOoRFCTz7JUeYoWynuOeLyYsXc+/RcsR3MyhEPGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE0BwAPlnsjzuxys8SoK0d0cxsuxaUSCiGzi+68fD0Y=;
 b=hI8m2DtSqh7mmA3mFnDsTI6pSkt0ReqhieMW9ultl24WwpVoBtbMlOcCuHiNy0RCf+CEjcAooIVy5Na9ryfEcl64fDhXHPwYS0WOFmKN+wiQpjUeCxuMFPB9hoL/rhSNqkKs2S8lZ8+WwX699H7kdsIFMJ71vMKyAZl731uONZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 18:27:41 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::c1ee:6529:69ca:7e63]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::c1ee:6529:69ca:7e63%5]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 18:27:41 +0000
Message-ID: <4dfcb8af-be95-9665-7fad-47a088d5f0c3@amd.com>
Date:   Wed, 1 Mar 2023 23:57:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
References: <20230217161354.129442-1-wyes.karny@amd.com>
 <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
 <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
 <Y/ROTsCSCFtrwwTK@beas>
 <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 882a703d-3f0f-4d1f-7e75-08db1a82a44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4scYXK/kIsAlJxzZqnoZ/drpkWmaiQUYR4oppcAQci7ip4dVSTyxTKn/GrGKyqjI4XGHFCUO2hXSwwTwstoe4cPOUCp6KlnNXxS4P1jNb8lDTD0A8FjzhAtFqzTz6no8Wk890AIESiXIJusspWEZqo98q+LJAiiRyN0kZdRkBrRif6cxQbhrZDz0VgswUdojaJb+kmwFHEYQNK6Q8i8bThX47kaX45RmQInCMn2HRI+MrIwsUJl5Uu0kGcvw9t9DXHb20u9orArRAzR0KSUsOw0h2aCpYJiwEc8DrW9jEO7cEtC1k2y/4M0KH+o6APbmrQj//tSJgNm8NkvglUrV8sk7h04ZY8IL3/N05tMPJmfkCyArLwl4+c1SFNLj7swxebvx8qM93vwHnoY5SM2esP96QVZGk8kudOOUSN3vVwlPuV8LQ8HEMSqHzNY0ZFtd2/3393Yz2Rb++tXL6Y1jtFHTx7J2DyJbsJc9WEE7ojS9QVEiV/QpMihpSnqQtw2jQjSbux42XCNvXDGyE8+nSuXosY/ebHegNuwpyGwQDxcd8kIEteNrFKhcV9MdBBSRdLFUzZZyRv4bFNA2HksKrAoTdHQLn6D027fyKtSeG4lvHTTJSqAzwArbS13TkD5P9s0fzBx22zl2Bjgc32YWmjXv3qdQb0Nzyp19KAHvZdEmcF44uD82noKS1g7sQCPpXxx5IwLEqeP9qp1MZKWBbgiSjIMrRvO6Xv8VKoBZe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199018)(6916009)(66556008)(66946007)(8936002)(7416002)(44832011)(8676002)(2906002)(2616005)(4326008)(31686004)(6486002)(66476007)(5660300002)(478600001)(36756003)(6666004)(54906003)(6506007)(26005)(186003)(316002)(53546011)(86362001)(31696002)(6512007)(83380400001)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1rVEJYanhlWXZEM1hlSFhvYXJaemVuRVN1Q2x3V21HNHVKQjFNV2I1SUoy?=
 =?utf-8?B?OUYxeUhoUnIwMHZEKzFnRm1Ud2FZWW1oS3BTRkxEUm1NRkh1QWQ1am1VbjJG?=
 =?utf-8?B?elFWZGlDTlFlYk9mNDM5QU5WOEc5ZHhEQ21UQmd4RkcrSG84K2F0VlFmNE9M?=
 =?utf-8?B?QVJFSGxsUEtzY2FsMFVXK3U1SmxHQnVrcVRzTHJ3dGUrSy96aUVqSUZVUXdp?=
 =?utf-8?B?VmFydVEybkV4cGw3RUNtUlZHTzYrVnVYaFoxSmlMQnJkUVcrZmUvNThZdkg3?=
 =?utf-8?B?RUxkOWhXMDVMQThPaUZ1dmtuMEc2aDVaeVpkV3puRlBlTTBhNGM3NHJwVm4r?=
 =?utf-8?B?SW0zcUU0UnJrcFRUZ1RZUWMvOFpjMDV1dXlzanphbFZqazNxZjFmcUIycWpH?=
 =?utf-8?B?SUQ3a2hnNm82Mk1FUWxlMXBpS0hWM3ZTMVhMTUhEU05aTTNxVlNGMkNIZUI4?=
 =?utf-8?B?TGMyLzJMeFFobU94QVRBY2p4T0dOYys4bmFNWnhIbWRUZmtzMWhmQndhNFBs?=
 =?utf-8?B?SEVhSG9FakJyUXhaUjh4d3RxaWJNK041TFhLLzRjQ1B2bDhHeUFvZldzSE41?=
 =?utf-8?B?VHA0dWN5MzhrdEp5eGNoK3NET21PcXJPaUE3WnYvMkRhM2NTZGhBUGdXdlU5?=
 =?utf-8?B?MERseU85MDN4bmgwdXh5bFYrUU54Q3V3K2M5NTErZHJuU1NUblJBZmtnR0lX?=
 =?utf-8?B?RUhCQjBhSFdzV1RkeTQ2dHBZaXdnLzRkcmo2bE1SS3NMdllBY1RjWVI4a1ht?=
 =?utf-8?B?cW9JOHdpOVVpYm1ZcldRL3ZKWDNUcXdzSGdvTTVSK2R1Y3p1OFZMdzliM293?=
 =?utf-8?B?Ti9LdlBsREEwNTljVkNTZmVaSTMzYXl4RkRwU2Z2RmxSeDZUMSs0b3p3VTc2?=
 =?utf-8?B?SE5MKzJoRjliRmw5elBKOG92eUxoTUdMV3JCRlJTb3VPNXJoTGpoS2NTanVn?=
 =?utf-8?B?YlBrcjYzc2FNVUxvYmVTMVZyTmlxL2kweFVySnp2eXZ1UXRqaVNyN010WGhY?=
 =?utf-8?B?NTVsZDVzWkVBK2V1Z0Raa2w0VTBndkdMUWttNUUvdm83R0x0MmRnNTdsOTZS?=
 =?utf-8?B?SVkyb1FlZmViSExNTFhmQkZrcTExMC9CeWtBeEtFUVBkZkE3MndnT3JwMEkz?=
 =?utf-8?B?ZnJyTlhBWWhyRTJKaE5iR04yaUphT3VLQlNnd293dXNnVzlPcUtESXZSRHls?=
 =?utf-8?B?UldzREk0ZXZiaG5yakFQKzlLUG90SENrVjFQOENzNDdCUjNSQi81dERoSUla?=
 =?utf-8?B?dnBDSzZ2TFlRMXIzR010dXJiT3FWWjZvWmdrUjFyb3B5ZjNrdzh1OFIybWdX?=
 =?utf-8?B?UU9DalpBNitsMDlkSmd4MFl1eUpzR3Fyb1dvclpzSFNaRjRuOThwRnZGY0RM?=
 =?utf-8?B?YjhIdDBrTXNibmVDZGhhdE5wdkhLUEp4S3ZQaVZxdyttbWZTR0JENHBBSXZW?=
 =?utf-8?B?Z0IyN3dtNGxwdmZ3VmhkUkg3SzFnaGYzM01NM3Zoc09lZ3dqV1R1YVgzL2pj?=
 =?utf-8?B?YWpoQmtjQ3ZNa3lWMWo2UUNsVnR3S2pHa2lrWDQ4VzgrR210TmdnVmM4V1B0?=
 =?utf-8?B?MTNmVG5PSFF2blo1OE1oS1V0RmNKS0c1cW5BNUVxTThjLzJtYVRRY3IyaSs5?=
 =?utf-8?B?MEduTlBNbWcvQWZqVTdaQ2NzblNMZTc0WlRrYUVIN2U2MVhtd2prTVk4RzNZ?=
 =?utf-8?B?Q0w3MFdpNEZRVFdlRFNwem9aL1Q0NnQybytyem5vTVVHbVFFQzJMNzZCbE91?=
 =?utf-8?B?NFBrVXVrNFJHK3JoSmphWDhiL0s1Z3lnNThDeHJpam5kVTZxU1J6dFhMby84?=
 =?utf-8?B?S29aWlVxamlwMWNOMFg5WnAxYWFjVElhK0NhRWpFVjdzRUpsVVZDd1lmT2NE?=
 =?utf-8?B?L1N4TVRpTGJtYVhoVnN6WFpKV3c5ZU1meVRzcVp0S00zU2hEM091SFFQZlI0?=
 =?utf-8?B?NGtqVHJvVTA5Q004dTROWS9FK3k5RWg3UktGZFFFblBLeGJsU3FlS0dNOTZz?=
 =?utf-8?B?Z2kwRHEyUm9ZYUQ0UWdOWlZhS1R2aG1NSFpDYVNpbUE5TUFzOU8vWnFiTGlW?=
 =?utf-8?B?dGQxWURCZ3dmWkl2VVhWQzFPSEllNlRCZy9OdThBM1BGZWl4YVVQRjA1Vnls?=
 =?utf-8?Q?XMY7nOxa2KqtZinUBccJ51c4Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882a703d-3f0f-4d1f-7e75-08db1a82a44a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:27:41.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1ApB1aeoiZ3NA29PLtApeQT//L1Qtu2xGtEU2ysH3wraRUfFnua29LgHXNlaAKcFMWQTmsQa1a/41YwjAZLBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On 2/21/2023 2:20 PM, Stephane Eranian wrote:
> Hi,
> 
> Testing Wyes' patch for energy-cores on Zen3 server loaded with triad
> bench on socket0:
> 
> $ perf stat --per-core -a -C0-63 -I 1000 -e
> power/energy-cores/,power/energy-pkg/
> #           time core               cpus             counts   unit events
>      1.001019203 S0-D0-C0              1               1.28 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C0              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C1              1   4,294,967,130.96 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C1              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C2              1   4,294,967,126.23 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C2              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C3              1   4,294,967,122.50 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C3              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C4              1   4,294,967,129.92 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C4              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C5              1   4,294,967,121.49 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C5              1             231.39 Joules
> power/energy-pkg/
> 
> I think the result of energy-cores is not reliable and I think that is
> why I did not
> include it in the patch.
> 
> Could also be a problem with the kernel code, but I don't know why it would only
> impact energy-cores given energy-pkg looks reasonable here.

This is a kernel issue. I've addressed this in v2.

Thanks,
Wyes
> 
> 
> On Mon, Feb 20, 2023 at 8:53 PM Wyes Karny <wyes.karny@amd.com> wrote:
>>
>> On 20 Feb 13:29, Stephane Eranian wrote:
>>> On Mon, Feb 20, 2023 at 3:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Fri, Feb 17, 2023 at 04:13:54PM +0000, Wyes Karny wrote:
>>>>> AMD processors support per-package and per-core energy monitoring
>>>>> through RAPL counters which can be accessed by users running in
>>>>> supervisor mode.
>>>>>
>>>>> Core RAPL counters gives power consumption information per core.  For
>>>>> AMD processors the package level RAPL counter are already exposed to
>>>>> perf. Expose the core level RAPL counters also.
>>>>>
>>>>> sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
>>>>>
>>>>> Output:
>>>>> S0-D0-C0           2               8.73 Joules power/energy-cores/
>>>>> S0-D0-C1           2               8.73 Joules power/energy-cores/
>>>>> S0-D0-C2           2               8.73 Joules power/energy-cores/
>>>>> S0-D0-C3           2               8.73 Joules power/energy-cores/
>>>>> S0-D0-C4           2               8.73 Joules power/energy-cores/
>>>>>
>>>>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>>>>> ---
>>>>>  arch/x86/events/rapl.c | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>>> index 52e6e7ed4f78..d301bbbc3b93 100644
>>>>> --- a/arch/x86/events/rapl.c
>>>>> +++ b/arch/x86/events/rapl.c
>>>>> @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>>>>>   * - want to use same event codes across both architectures
>>>>>   */
>>>>>  static struct perf_msr amd_rapl_msrs[] = {
>>>>> -     [PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
>>>>> +     [PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
>>>>
>>>> Stephane, this was an oversight?
>>>>
>>> I think it may depend on the CPU model. I remember it returning either
>>> 0 or bogus values on my systems. They may have improved that.
>>> The commit msg does not show which CPU model this is run on.
>>
>> I've tested this on Zen 2, 3 and 4 server systems.
>>
>> Thanks,
>> Wyes
>>>
>>>>
>>>>>       [PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
>>>>>       [PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
>>>>>       [PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
>>>>> @@ -764,7 +764,8 @@ static struct rapl_model model_spr = {
>>>>>  };
>>>>>
>>>>>  static struct rapl_model model_amd_hygon = {
>>>>> -     .events         = BIT(PERF_RAPL_PKG),
>>>>> +     .events         = BIT(PERF_RAPL_PP0) |
>>>>> +                       BIT(PERF_RAPL_PKG),
>>>>>       .msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>>>>>       .rapl_msrs      = amd_rapl_msrs,
>>>>>  };
>>>>> --
>>>>> 2.34.1
>>>>>

-- 
Thanks & Regards,
Wyes
