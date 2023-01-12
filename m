Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224B6667984
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbjALPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjALPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0892AC4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ08/hjs4Ho42FulhlbU+Qv/Z9C+ewVZlsbVaAWyELF97GLmsMAGFgc9uTHlXqKEJXXUTKiB8G6J361WInCoLvNwwEbUVu0Sq9pDh3xmIJdcj0s/QG4yr2IDzoP5+8XYD4KFzyY33h90h2g7vJbY1Mp6gFvrOQ3uPigL2gpSrwspeAWYAIZJAuqSS9UhpPD/RVJq4AJkuoPZosRNUAgwr4/02HNexcxfSFYO9NZIEakuqWFjoHLUQs0FCUjlYdUwkBxeefpj5efRQaOaXbPQhqxxb5RuKKNhOa/hWyNS6QjORI3uGygiATiEJ0BRfTDpl410zOlMIMtY4CJ+1RajoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q06OvZlu70uNqDJ84wfj5xkHAqBYOJA6IBVr3XxH/6M=;
 b=U3WQmVipLU5+BVdKuHM9Z8PtP9vsCCWz+q6JpQ5KsSXm4GqREhE0LZGgAM4K4Xq/V0WNAvPZMnYA5/0gYhwNpmFVL5e3uGrLJrx1I8nI8tuv6hlOUXG1Y7gt8HlsnBhmKFLspSVzyxc5ZVLhuEJp0C+gx53dgMGCE8CtS9aXJWrkOUkTmFT1NtKb5AM5PajiXPWG4yzM4jDuMd4znsWvB+VUz8gxiyAclTkzS4BYCEBnQPlj6mgMrkYgiIP3ypv4J/jzE5toNHKPX0vHeJaqRfrp6E6rksRgr9ZO3PY0qVo1ho5zYmsesytkZ+y9uN/RSYZEcplIH26YIlGPhHNZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q06OvZlu70uNqDJ84wfj5xkHAqBYOJA6IBVr3XxH/6M=;
 b=2RWmhypOdIhF2ZSxe1bYYSr33umhLK+sSJv03pllqKZoFFBtchhiPb3PiQ+/goSFu2p1UECKbGqi2ubuh7/Ta1x5LfTns8hxiqARx9ailDAoTCR6Uji+yu/AShXRmOEiColmuWsqme5Ir0Na6OTRUHqCBuMoL/i6ilGQnyhjQTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:29:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 15:29:42 +0000
Message-ID: <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
Date:   Thu, 12 Jan 2023 09:29:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:32::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 28554082-8823-498e-145f-08daf4b1d3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULc9WoteL1gy/5C7L5fRcVsQBJ4L+3qjtuFb435ajWMY7oz+3zWZeKNOtnH06p8AvcvvXlcjODF2Rx+TX7mlvmmSdjxLtlaUcizFCfxVLII6/yUia1+sDfuIzOSsSQDvVB9yMP5SKUAqe8FEreZtWWmL70HMi+Q+kblhDRUG1BolAcjDd2Kvf+QyrLYEobLNA8drJ7gNg2fhWblFbR+88riqlS8U8liYW0uC0yQ7z/HGoQfL9HoeV6laZ9ud+pok6fKTxWCO9lk6rC4uSFHlLIk/Ste2fqxZMxwLBq0bou/g1xmqBO1aJWtJkd9reN+zRJM+k96Hf1kNA2Th8hRZ0JZbMD3mpv7X18ohxD2EvKpU69cigPZHNrW7lmS5yci0IPimx9J+NynH60zo/TvVoZw5qNK6p3Km6d6+LcV2EzsPPcJ6XcV/uHC4usvHhio8XPzqGyR2KvefpputGTzM/BbgzGTlILF1LxTjSMu1D5yKmXeIXVmZJGbz9sWKKkMFFQZnvTObQKzHSj9jT8lJlEfwI6Rswxr8a2kY+IzNUHwpkAEt/sJwvMTQd9IwrM3i2YjL6hA7lIiV80LVra2Ku5j8DABK2sRM+yvRUJZeP0lYPL3FYBN09z+HpS+jsMNYQXGUoDfolkfuzsp0NZOCdtyd6X+aunskb1TuFczAUKcNt5OQZQotnRCLPAT3Et9mZZhjVErctv2QXdJ/uA2zVyfRIbYUDvMOAMjeKrv2JiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(41300700001)(316002)(2616005)(54906003)(66946007)(36756003)(110136005)(66476007)(4326008)(66556008)(8676002)(86362001)(83380400001)(5660300002)(31696002)(8936002)(38100700002)(2906002)(15650500001)(6506007)(53546011)(186003)(6486002)(478600001)(66899015)(6512007)(31686004)(26005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZEbFh2MnU4T1pHVWNQUVIzdmNHQmhhMHhHSUVJVm1oNEt6b3lUT1RHVkFU?=
 =?utf-8?B?ZzZFeFVQNG0zajVUdFFXS3BPdWZObWw4TVNyaWlqSlRCK0RQcFJjUTV1RXJt?=
 =?utf-8?B?S2t3RVpCaFlvcVdSbTZSM2ViamhxaFRPalZVeXVLSnNYenlNcjlLREJ1YVZJ?=
 =?utf-8?B?RUxWV1JLczRaczB0ZDVNT3ZRQi8xalhVNDZ4N2Z6bU1vRzFLTXhaWkpVemtP?=
 =?utf-8?B?OU52MzhDcmpQa3hqRHdXRGQzWlpDaG9PZ25sVnl2YUcrV0x4YklkNjRLTjg0?=
 =?utf-8?B?MmJZSGUyaDFLdGhERWl1TWdhTHRoampXSElXdXVkeDh2WWRIdC9salR1dlVU?=
 =?utf-8?B?M0xKOWExeGI2Vzc5UE8wY3gxR1d1T3YrV20ra3ZpUHJDSm1pMHVnTy9iMlB0?=
 =?utf-8?B?cTZoR2VMNXR4aUZiaDl2eVBvWXU3U0lHVGtZRXM5UzJFS1hvQU1FMzllWFE3?=
 =?utf-8?B?d3hhMk5tbGpSNWlsbUZXR3RBYTdteHQweDdOV3lMbXQzREh3dk5MMHg1UVo5?=
 =?utf-8?B?YkttSlA4ckRvc2taa1BpcUJCbnRqd0FPZ2prNXRTZzN3UnVZZU1FSVRvOHFs?=
 =?utf-8?B?Y2tYVW4wekI3UlR2ZC9GeTJsVzF2R25SYyt4TXk1eFg3emlOUzNZaElwN3Fw?=
 =?utf-8?B?am93MXlrTGUxdi9vekVkVVNMRVFqbFlLR3JzOWo5V0tNMXVRZFNGM2tCWVZV?=
 =?utf-8?B?aHpFK3pUdlFuQzNsVU91QlNwV3VacDFaWnlnb0JwTGhFRE9YdVQxcjNTY3lW?=
 =?utf-8?B?K0J5RW9qOC9kV29YeTRaMHdxS1NMYUEzeWdjUEYyaGJVWjhucExIa3Fuenpi?=
 =?utf-8?B?amR0RDRmaFJVSzRwRURQdDVyMjBvUmJta01TTUpvYlRtY0hXbWpJckR0QUNY?=
 =?utf-8?B?elZJS0E0Y3Eva2VNbXJxNy94M1N2TlFIeXlFOHlrdjNGUk94RnZ2aFBvMlE1?=
 =?utf-8?B?N1VZWStyVjZScDFVMWQ5a1ZRMjF6Qkg2V1hEMjN5WnFhc0dXYkQzZno3a3hu?=
 =?utf-8?B?a2JXMkNpNFlzSVkrS01TWUxiQ1A0RzlvNzg0RGdCMTlORlpHY3ZhZXVLaXd3?=
 =?utf-8?B?R09LeGdIeXBFelo5NEZFdkpuV3NwTVRFRDNYMUtxeVkzMDdBSDMwSVdTMm5y?=
 =?utf-8?B?YmhHZGFqVlM4bEJIRlNDaS9qVzNHU1ltYmlFWGxZTDZXQVNqYVNnMFNtbSs3?=
 =?utf-8?B?L01jQWFJRUhhcDZTaE9BYzJRNGo2OW9kS3Nyb2FZZHNzcFQ3a21acmk0U0Zj?=
 =?utf-8?B?S0pnbzhzVFZETzc5N3FYNVJOVzByVVlSNWhwQXEyWUtleXlFSW8xNEFYTU14?=
 =?utf-8?B?dmNGajFSbldjWERpRkxXU3RWbzg5bitBMllZckpKVVJHRThkVnZ4ZzNUR3JG?=
 =?utf-8?B?SkwyV242OFljcDR3VEU2UEQwSU5XSTlkOERGaThKSTlPUk1uZ2U2a1hMNjFX?=
 =?utf-8?B?bHVLTVpweDNTU203MHFmbE1raEJiOHRGd1Ywa0hLS1A1MVg1RVJWVXVMT1lr?=
 =?utf-8?B?NWlDMGdFcmRXcG5IQ2R6K2dGN0YzZ2c5dVJKRDFGTlU0dmtNNHFpbTJDdHpV?=
 =?utf-8?B?cTR3V2lUeTNIbGhjbFo3WURMN0ZBUDRMVlhsbFI2MGtIamFzaGpCRSt6TjFh?=
 =?utf-8?B?ZG03TVF2M212bzk1ZEsyK1I4YVdRWm9lTFA2U3Q3dHl5eUlBcEtGcDYxWGl5?=
 =?utf-8?B?QW41UTh0UVVKTkpUS2p4ZU8zaDZ5c1hxQ1FheUlIbWhqejBVeVNOdmFaQ09C?=
 =?utf-8?B?WmdGRC9VQ0had0YweiszRzBQMHR6aXFPQUIzZXdNTHBvdGlaa29xcUoxTVpi?=
 =?utf-8?B?SzN0R0VYNmVTTnM2bDcxc29WTEhmU1FCb1BBbkoyb05SZGp0czluVlByVlA5?=
 =?utf-8?B?OXA5Q0xjQjhQL0RRZUlxeFBIM0MwSUgwVk1FYXNyVG9ST1BZdDdKdXlyUWtP?=
 =?utf-8?B?U25HVEc5d1FoT1d2NFFRYzA4Lzl5anpWWE5LZEJDOHIxc2IyMWtjSytOS1pD?=
 =?utf-8?B?MllZVnpaNXQ1Y0lTd1c0QVhDODZ3d1k3b1FsY1hhOEZ5R0l2ZmpmYUl5Vmo4?=
 =?utf-8?B?NGI4dC9GTDNteHhXTkJKS2VoYnA0SC95TGc4bmpYRFV5MXNiSDNhajZLeGNk?=
 =?utf-8?Q?A1x74XtgyrRbnc05iDuQ2wc7p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28554082-8823-498e-145f-08daf4b1d3a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 15:29:42.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg2lWoC5gOolxQPIHFLcmjFW7NPCvFA2GiCgwP3k6q+bLNRfLgnNOINFH0fP7PX0nLnGK4D0Qf+WQAt8Fqi78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2023 08:54, Pierre-Louis Bossart wrote:
> 
> 
> On 1/12/23 05:02, Mukunda,Vijendar wrote:
>> On 11/01/23 21:32, Pierre-Louis Bossart wrote:
>>> On 1/11/23 03:02, Vijendar Mukunda wrote:
>>>> To avoid ACP entering into D3 state during slave enumeration and
>>>> initialization on two soundwire controller instances for multiple codecs,
>>>> increase the runtime suspend delay to 3 seconds.
>>> You have a parent PCI device and a set of child devices for each
>>> manager. The parent PCI device cannot suspend before all its children
>>> are also suspended, so shouldn't the delay be modified at the manager level?
>>>
>>> Not getting what this delay is and how this would deal with a lengthy
>>> enumeration/initialization process.
>> Yes agreed. Until Child devices are suspended, parent device will
>> be in D0 state. We will rephrase the commit message.
>>
>> Machine driver node will be created by ACP PCI driver.
>> We have added delay in machine driver to make sure
>> two manager instances completes codec enumeration and
>> peripheral initialization before registering the sound card.
>> Without adding delay in machine driver will result early card
>> registration before codec initialization is completed. Manager
>> will enter in to bad state due to codec read/write failures.
>> We are intended to keep the ACP in D0 state, till sound card
>> is created and jack controls are initialized. To handle, at manager
>> level increased runtime suspend delay.
> 
> This doesn't look too good. You should not assume any timing
> dependencies in the machine driver probe. I made that mistake in earlier
> versions and we had to revisit all this to make sure drivers could be
> bound/unbound at any time.

Rather than a timing dependency, could you perhaps prohibit runtime PM 
and have a codec make a callback to indicate it's fully initialized and 
then allow runtime PM again?
