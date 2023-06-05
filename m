Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44B272224C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFEJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:35:05 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801FBD;
        Mon,  5 Jun 2023 02:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caseTc2WaYBX1SRFN3HurSAYg6DqTu1W1dxVSJTX84KUSSgg4IhU5xIXezgRzlw0Vm19nFu2I9U8BLL+q3mRWxr0GtYMoUO3Z0xog+X6gVjI+Um0mLyQW3tpBeho5Wj2PQvsPUv+rrgvdQRvUI6gcskXMQuSbv5uu1a8I2J/ttH+Etq9OlyMBRN5pdk6Zy9SEpt0nZJdUT5ob2c5FvHsGNWRXpi4oq5wSrv++L6yOfOX7K4GV8IQ2oxuntnfGmDX+HHvl4Kc0pT2TDOcV4fwKfaLElOnwAQVFtBsmJsg+iEbXuTEuMsy93nZeilfXWs9y4v4koYSYxiyDNNfpZ3o6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn5FJVFOwDdzzcGqvjGheJr1jIQPPyGPbcu2ydYHcac=;
 b=IE05f1WqtwmCYoLBkhucji0Z21I8H73uvW6tGyBkSAdgM2AVSwKyj7Dpt6EH/UldKub4Nw1rYP/X7mFbplfDF5zx++YiTgnZOEElbPOMPYAGnVgxDkEKH6BJ0V91/pSlmuRe4jhbeypink5/CwQR90t7u8T0glymcof3majjAokGThF21LNOiVdCyHKMfAk8Z91LOpj4WzYCzGkv9qeSNJA6OID7vBombs4xPz3GDYFdIpw2d+5vWq8zbCeBEK87kA5akBTXKEWQRpemFeQQOpufRn769jTwWObE0hp3oFIuG6dEqFoAbi2nTYPgfr9m6OHJKomZPq+V2gTb8/RhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn5FJVFOwDdzzcGqvjGheJr1jIQPPyGPbcu2ydYHcac=;
 b=hee+NLiMKZjw5LSNujPOlrDY0AQ0u5ZrP4aapIdVVC6nQiaicEoOTlSnqAcb5sar3vsfwQidskXXqmZwJAl0lLbFBYCEH6QNiEENAaKYK2BGPVnbDyJuop6cSs/15PhYZ6BuFe2GLCIZHwSv9uf3yCJ7uD3DpMYDwZ/6DpqU7EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 09:35:01 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:35:01 +0000
Message-ID: <ecc69e40-f975-69e8-a372-6aafde66e0af@amd.com>
Date:   Mon, 5 Jun 2023 15:04:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
Content-Language: en-US
In-Reply-To: <ZH2KVyyC5oMr+Vk2@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 965288f2-4f1b-4d54-9ad3-08db65a8228c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNEH+vBW/IniPJKPXCBzq5JZdaBW/lq5ZOHH10MlTS/2LPmGhktRvy7GQlyOwztQx0qogdaSAiGhtA9qFUel92WG0ncF/CEbA7B3AIv2RPS1H0gI9slK8RonOeCJwyHVlTJf2D3PSMTb+2UyN1cIltsA90QtgGht1BFvzUd9BcT6LaVVRnoApS0fhGWUZQdAQpPrGvFcIaoWQQXEnMMyY8IDi99YmrEIlMMZxviMwtIyLm4xpkUahuwzG/Q3wFTVd+elem4jSvLL4Qn90+xKbGolBuzY6WOe1lG87l0ZYALd6LZR85LqYpvm38Xc/pomCwv841AW3FzuDDnqu5kW6c0A3Qmi0ww6hLwXchkFzURedNFH5B/83xNGNCSnDmTqDn8zqCrNVkfCJdhT21BjOdUF3YeiNIqoSreuusjbmXfkq6IaGUeRL5+GggvvdXRz3TYOa9QP1JLKhg5ndzZ25qQw3VPyTDuH9dSThIHKwtGWKuDmYr7snW7aXhKb27hJcMlVzfIdNx3rXslrZzeY1ByMUI9vuVmSFyaRcJwEQZd9xeCxqyI3reJdJ7JBZEV6diqaTklDX/luq+ON4PfrI3QcAqWUKd9WajsL+FLVX6oA052Eqz4bw/sL9rWR5966fxlj3oaOeg+b2ULL5LlqjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(6486002)(316002)(41300700001)(6666004)(5660300002)(8676002)(8936002)(54906003)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitvUWxXMjVTYjRRREM0cUpvSnpGMzJxVGZGbWcxMFNlZ2dtay93Wi9TRTNI?=
 =?utf-8?B?NWhDTTkzajBHQWRRVFNHY1Rja2RvNllNQ1BuUW5mZGdYakRBTThNbmhZSk5o?=
 =?utf-8?B?T3l5a3BROEc4bHplVzdwNXEvOWh0Wktkdk5UUDliYnI0Z3UxR1hHVjFmOW1q?=
 =?utf-8?B?R0p5TGVaOXNpRGJRVzhPbW9qTzl0eWpRU1BCQ3JDQ2pqcVE3QXhMOEVUTC9F?=
 =?utf-8?B?UlIveVVVeTZyWm13TWxCcVMwQmd1MWdaVHlNWWNMM3NZdUpqbmxVNExITVhw?=
 =?utf-8?B?NE1NVUw3Q1VMMU1DOUtBYnQ3c1RjVEY0dXloVkVCdlFSbCtTY0J0UjhIek9X?=
 =?utf-8?B?MWVMdlNXVWt5bTdHOWU0Wit2eXVVdjgwYng3aURtOVovOFpnSFhiZU9DTjlB?=
 =?utf-8?B?Qnd5OTdQNFpHaVkyR012aTl1TEZiZUc5eUZ0M0FNTnoyVjViMFJmYnJoK3Nw?=
 =?utf-8?B?Ykl4NTg2ZzVXQWl3RklJaDE0UHBuMFJtRXdBdXova3prN2pNdEhUVkFydkdt?=
 =?utf-8?B?bFl6TnB0aVpoamxKWUlNTHZXSnRPZWIwK3RiUG5DRmh0L25KTUtWVmtvWlFD?=
 =?utf-8?B?Njh5Y3BJY3N2NXJMMWN1TkpKbW1WZGNnRU04eEp3NXZWTUZaZU5PbXk5WG9x?=
 =?utf-8?B?VUpaenZZZ3FndnpKem5lMnM5TlYvQi8wN0Z5NzI2ZmdsV0J1bXhRV1cyNzYw?=
 =?utf-8?B?N1NGM05IZFBTc0I0TmxDMStyVCtua2xEUUVlbEc4dUtZN0dZdkdPU002Rjls?=
 =?utf-8?B?QW4rOUtkOVJNNE1MbEpYNkRPb1dydW5sclhvWWRZKzdDUUtOYUpzaTI0cWQw?=
 =?utf-8?B?Nmk3QXhRdVVYdStUZ0xtQ1orWFZoQ2pEZkJtT0ZkdHhzSUpOSkx5M2VOVFZQ?=
 =?utf-8?B?aXNqZWM3R2k0aHZXa29XZERWYzdhRDZCcTJWNVJDQmlFbTIxVC8vb3VEa2dm?=
 =?utf-8?B?RmsrdWJsTHRPbm1meTFpZmt5MCs1TVRCTmR6U3BuUW1pZkxuYUVOcjU2Q1d4?=
 =?utf-8?B?bk1uWW1EOXFyU1A3VFBDTWMrWTZTV0x6SGhJOTlGYzZEZmdmL3hDbnBlMkxa?=
 =?utf-8?B?Vnl5RFZFZW02aDBocklmNUY3MW9PZE4zOXFLUFRIait3ODRLTm5OOU4vdWJa?=
 =?utf-8?B?SURNUVVYWk9NNnhjVENWTjlOa1cwa1FDNS9zeTF3Y0psQjU2MmRWaVduK3VJ?=
 =?utf-8?B?dnhxQVpPamgvanVkKzZxN2QySjVrY3NkSGhFWkoxOHpITHFic21iK3o2SUk0?=
 =?utf-8?B?YWEveWQ0cTVPYmZ3d3BUbzcyTzl6cjQxaWlFYUQ0VEd5VnpTNTZCNitSQnBa?=
 =?utf-8?B?V0FvRmtkQThVOS82eEczdVdFWTJpOVo4Qld3M04wdHB0ZTZiUFY3blBtUFBr?=
 =?utf-8?B?SnRqN29jRXpoR1BaQ0xnZDVqdDdPbEg4M2xYaEFYRFBpdWJocXdIc2M5d3Zm?=
 =?utf-8?B?Q25GcnM0OWw2Y3JLeWpMME5qdW9xb2hFTFd1bmEvbTNGcFQ5bEJxaTVUVmo4?=
 =?utf-8?B?Q1U1aWN0c21uSDlmNUYzT1NYU2NkaWgwQXlWWmV5TStBYmR3K3ZvODExWHhW?=
 =?utf-8?B?K21NcDNWdERrcHRSczYzMmZ4MUNPVzVtdnJsWTJDeTg2SlVYaHFBMWlIWVNj?=
 =?utf-8?B?OWc5M0tLc1hoSTRvc0dVUTZHeHVEZTdsTzhQdjZ6Z3pOU3hud3hZZk5tdFls?=
 =?utf-8?B?bUt0bXRnWnlsU2NEbTZrRzlWTFlSYVF3QmFHODJUVHR4N2xRamljTXVsMWsw?=
 =?utf-8?B?WjF5ZHk2N0x1T0RHanpkSm5VTnRYUHdHVXJQRyswK1NXUTVVdncrbWJZWXdv?=
 =?utf-8?B?Z1BObm9DWlhWSk03Nk1VbHNlMGJVSjl6ZXlNTGdTaEpSVStaaldKYUY5ZmdN?=
 =?utf-8?B?SmhrUTR1YjNPNVc1cGxPME9KaDZXL3gxQk5SU3BPVmZvdmNmVUZHRWVzbjBS?=
 =?utf-8?B?c1h0Q3F1VUpIL1FqVkVlWnlxQ1hNend4Z1pPVS85SS9ubjl3VXBYbVg0S2hP?=
 =?utf-8?B?M0JoK2JvVGpmM1F4MitvRkdPblRJMzFQWTRJLytOK0tUZlgxd0lqcEVkT2k0?=
 =?utf-8?B?cGw4MGFHQzI1dnZMN2JaUjNKaC9OQkhmdWY3RmFZY2ptaTlEdy9UbFNUenVT?=
 =?utf-8?Q?lmjbguylW12AtfGRD7fgBM6G1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965288f2-4f1b-4d54-9ad3-08db65a8228c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:35:01.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaO0QV8hHHxUgT/M01bzdi1ExbZl+AtrUlqIVObPxktGAAfYHFgcVaoPKp08n6WnRXaq6MW8tDZoHCqffta2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun-23 12:40 PM, Mark Rutland wrote:
> On Sun, Jun 04, 2023 at 01:38:10PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> #regzbot introduced: 9551fbb64d09
>>
>> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
>> searching code") as first one where all hardware events are gone from
>> perf for ARMv7 Exynos5422 board.
> 
> I think that commit 9551fbb64d09 is just wrong.
> 
> The commit message asserts:
> 
>   Searching for the right pmu by iterating over all pmus is no longer
>   required since all pmus now *must* be present in the 'pmu_idr' list.
>   So, remove linear searching code.
> 
> ... and while each PMU has *some* entry in the pmu_idr list, for its dynamic
> type, that means that events with other types (e.g. PERF_TYPE_HARDWARE or
> PERF_TYPE_RAW) will fail to find a PMU in the IDR whereas they'd previously
> have been accepted by a PMU during the subsequent iteration over all PMUs.

Not sure I follow.

PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE are aliased to PERF_TYPE_RAW in
perf_init_event(). And PERF_TYPE_RAW should be present in pmu_idr if it
was registered using:

  perf_pmu_register(pmu, "name", PERF_TYPE_RAW);

In fact, all static pmu types (enum perf_type_id) are also added to pmu_idr.
See (type >= 0) checks in perf_pmu_register() code:

        if (type >= 0)
                max = type;

        ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
        if (ret < 0)
                goto free_pdc;

        WARN_ON(type >= 0 && ret != type);

Thanks,
Ravi
