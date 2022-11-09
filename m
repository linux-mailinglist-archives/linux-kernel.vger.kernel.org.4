Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0862297C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKILET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKILEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:04:16 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3625644C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8NjeAR/LsoBAXjjcTMZDfTb9O4wgC1rFdDl7Gs9hKevIZ6qEnzFmRUOg2bTfoPdkbHJ5vwPvbWeKKCEOoeq+zF04cGWwqGN8fcyAyYtvNJExpWpQSnaW3AVLHTNs/Y72Dpbud8XG164an+L9LuM+weM9THdVrmoK/J+fkDzkviep7VUB2U/EbVL6jRr9ONfW6C3D9Ecx37Ks5Ib1tJ5cUHOadfDAOulRDtF/MCVzRWRpFlhZ+CyMwZj8JS8PzXa7t1who7dlTusfckqd6sdtxWZEPE/cRrrWAIgMXZEntmA6kcs3APggHyHy4IEzcxbJBFaKz7rQ8mupaSLFqJk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+HYNRYQ5aal4imzrZTlVZJEHLH8+7R0N+62hommGEE=;
 b=oau37dh3Gh/j7PRb9jjeZhuXqYIuxjZebA6d3UX0KPA05f6QR+PPbEy95kGZFSq9x6t0zuYAw4gIywmjeth0Nwo+Got3ydc7Rkdgq+q56FDShII66jjpiZ2ql9EKxxCqYOr9ahQbI29kjgod9z32fDsF16RFDzSe1aJ/nzFD1WjvtZbuJkubKkgMDJiwz/E3sVIhGiZIIOSD9gUCrqVCZgjeJvk1fnw9JQT3vEv0EjwlImK1lTgF+yWDE7i2ZsmJafGW1DEsEWSuFzXrYf0SyMR2wnhMORmgCP4Q/+52DuXGWGQnXOb/Ej1kAVqIE3KbBp2AewUf87ta91gg4J9JKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+HYNRYQ5aal4imzrZTlVZJEHLH8+7R0N+62hommGEE=;
 b=uuTcJmSkDXJhrwh70xFVX5kMEZ7xEc7Ay8nBAsGrDcVrt3oU3g/ogAGypfw8ReODuZ5ygZ0AfTrpK7c6Xs36Jh/xAAtDimNT65oCZwtkbTpJcZ0LUYCBXBsLPb3wz/NyNt/7Ov7cDaeONJDbBQql7gIqe5v8l9izf4geF8cyzdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 11:04:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 11:04:10 +0000
Message-ID: <80ef6f5d-52b4-38ee-d161-27743211f902@amd.com>
Date:   Wed, 9 Nov 2022 16:33:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: AMD uncore kmemleak
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>
References: <Y2uGZL1ou+JGu2mh@zn.tnic>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y2uGZL1ou+JGu2mh@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d922d5-d756-407c-4ccf-08dac2422015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPyKkYTrMigy+yzN9OyYWiMY8e0J4BdZL48KG2PkutATiz30EluS0MaZb/dG3aARNrIinocvoFRscX3wtrQAhOGh711bd6XWnb+4SBPe978Bd/RgvSD497G1nqimwWHNTOPfgfBvb5tBPzd4d3oSkrsIUdbkCIC1aubcNXnQVEpKrpuOV93qzHxpWOfjfmKfOuucFwFxMG+yKfn00masYuvGiS6nO/q3OncwiPx/FeURBIvDsb3yc0a5aoqIi0bq3rscb2py/FbFUzc3JKH0q3i3+dVK684m0dm9WMC6uKnFGqPrkL5x83Ejj0ELyIAR3KUPxC9sCkFfQhU6tpxAwvys5ZiISwQV3orYXewKHUC3FWX4bC19y85lJJu4fedMGfPyex6Z1tTRCXmIlLVNpCTTBEI4PlpmDV0CaoNKXAzJnIUmoIMSHF1pV3yWNwEbSuxi0z9wK5uZfXOx8IcctCXcRvEC3EBC945m5uak4bVr7YFP30drTyViKzpbMK2z3vBdfJGDgwmAczFvd3kYmaMXVnly38bFc2wgQZ1szXX29xcp0F0hO03TG+iN9H2wxrn2VssFaefXSZrkSj5zyPQKcheduczmhngDC9sddxvw115ul6bReBCfau804/0N7rNLzp6yNnr47BZMJhREoTcRYXznPjpQPA49nQRk3igE8PBXNfZRoJUKjLaujUewx42W+CqHmEab357lvvkFJfnngQkw/XjekHpqaqSVJKWHxtRBZBRXxi0mR9ZFJ0r63ioiwB1OnAvHQ62hUxKhMwdkv2FgV+JFfQ4GOQxHMlTtgRCCSnVFxeLrTRlekyofz6UXZCh+xMnyI6PjyDZMY9MIKy5Bh0ArVzJW3INwV1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(186003)(6512007)(26005)(6506007)(2616005)(83380400001)(53546011)(6666004)(44832011)(2906002)(478600001)(54906003)(3480700007)(6486002)(41300700001)(5660300002)(66476007)(7116003)(316002)(4326008)(966005)(8936002)(66556008)(8676002)(66946007)(38100700002)(6916009)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1h4dlJad2VoZERzd3VoeHFFd1FBTGI0SUUvQW1KTGhUeE4wU2dlaEJWMGEr?=
 =?utf-8?B?UWswbDluR2RlRGNHZFRtUTdDUm13YklaSkVrd1JweGlhQkRRZG5YaG1uSFpO?=
 =?utf-8?B?L1RnblJKYkFqN3FyVGJGcWJhcER0WUFjUm0wM05iSUVmMFRlYXBMODl6RFY4?=
 =?utf-8?B?YnBEcnAwYm50NzRKZjVTSWtwSlFDTU9Oc2Fua0hDMk4zNFNRQ0xGYU5TdnZm?=
 =?utf-8?B?cHR0TTlqY2VDODUzUmE0aXd5NUhMMzBWQWRpclo1WCsyT0lkU3RRcFdhT0pr?=
 =?utf-8?B?U3I5UDQ4eVAxbnR2UnZDelEwRnhVdlRjRW1qUm10TnErbXFOWEMwM3FLeTV6?=
 =?utf-8?B?YkVRUVMxcWczQkVqZk5WRCtxWnM5NjNuWTEzcmlvRVc4Sm9BM040czNLQjFS?=
 =?utf-8?B?b1BZbHB4dGJHVjd1NlpWU0x5dVFJRTBjVHgvanBPRG9WdVh6S2RNRG9ZWFJX?=
 =?utf-8?B?WDJCTWJBRVBPY0d0NVEwMGRsRVU4YmZ3dXpqdzFIV28rZHNvQmx5UTdsaFMz?=
 =?utf-8?B?by9hdXp5dTlvSjV6Q0RGdU1FOW1NZW94RFV3Q1FFR3Evbll5eVVadjQ2Mkt2?=
 =?utf-8?B?cFQycVFMbW9NZU5DeXZ3allMR2YzVEEzUlRERlVXMUdodk9WdUdxaG12UFdo?=
 =?utf-8?B?V3BuQ2FnV1h0cFVKYnZXZ2FobGVmT3h0RGRNazJTVzI2OHk5YXZzaGV4UDcv?=
 =?utf-8?B?WDFweDJJUENXc09KR2l6bTNhY213S3Z0cFJia0x3dWtxWnNvUkYwa0w5dlVm?=
 =?utf-8?B?RENGc2c2TDRVZ3FybGJxVVVNWktwWXc2ekJmQ0h1eU5GZmdQTGNlVm15Y0hP?=
 =?utf-8?B?SklLMnUzQStHVHBlandaVGNObmQ2MDE4VGJmYndycDZzcVVpeURZV2pYUDNL?=
 =?utf-8?B?eUxHRkM0Qjl1MW9zQ2xCUi9yaVhkenh4TlVjZVdkVFo2ODRUYTRTYmJaaCtV?=
 =?utf-8?B?T210Vm5xT1JTZnBnUVp0RThrTnZhdVFJcHMraE1pQzQzV29GbzQvMWFBZDR4?=
 =?utf-8?B?Z1BkMUpmVU4xZnNwOFZBV1V3cFFHOU1zak9PWm1weUQvRTVLRFFHSkVqcUFt?=
 =?utf-8?B?dHpsMzZ4Kys0NjFpQWI4Uk16Vmw0Z3gvcmFoNjZ5NGsxSHBtRE5aUzh1RjBR?=
 =?utf-8?B?QU40aENtU3hpRlRrWUZGM1FqSDRvVGp3bWxHWUUxZENScFhGeExDeTNDNlp0?=
 =?utf-8?B?THVQR1VtTkZKWllHOU8xQjVrOGQ5M1ptMEMxaWFTVWJITk5hTm1lVTdtczJN?=
 =?utf-8?B?NlhMSFBUY2YzRTJreGd2cVZhdTl1S0Fwa0N2OUFQemFKWXRQSU02Q3o1dTRa?=
 =?utf-8?B?SXZzVm8vQVZHeCtibmVHRFdqL1JheXI1NG9rbFRSbW9Qc056VnlYbGY1V2pm?=
 =?utf-8?B?eE91KzZTb283VU1DU2VPNHZwK1ZjSTlBOUdpR2pBaFlDRHQ2WDRkTjJIU2Jz?=
 =?utf-8?B?em96bE1QQmZwMFFSbUxlUFRDZU9VUUlobzYwWC8xUnorN2tGc3Q2eDBNeU9v?=
 =?utf-8?B?R0x2L0R0WnhXdUphVVNHQUhCdnJBaXdodk9BT0hPa2cvTURkaWNXWnZBZzlh?=
 =?utf-8?B?VEpJdUJLbU1rcFpxQ0g3SXlqQ2dsbm90cHVybCswN1VzS3NUb0V2THRodXFU?=
 =?utf-8?B?cXNOQXM4ampNc3lxbzJvM3hGN3VBb1p2Vkw0ai9WeHhaUmhvQU9KQmhScCtz?=
 =?utf-8?B?ZzE1aHFBUk96Y2RGN2huUkpCQzUvdW5kQ0ZiNGtqcG15OExEb1F3dm1rM0Na?=
 =?utf-8?B?cUw4QlhhOGFkbmpDYmp4Zkl5YUY5WGhxcVd4ci8vK21lbTJJT052RStQYkZF?=
 =?utf-8?B?eDFCUXhSZUphaHY1UnJocTRvcGVnRnlCZzZPNktmTGNLSTFvYnRrVVRJSHhm?=
 =?utf-8?B?bmxvNTFqV3BWMXA3TUlFNDRGTlVlOTZVcmxJN1R2eDBlRnpXbDJnd3Rzanov?=
 =?utf-8?B?a1V4dEZDSzNFb1ZvdDR6NXJpNkhjdVpnd1JmNENJbS81Y0ZRYXZtcTgvdDcz?=
 =?utf-8?B?R2dBc2RCcS9mN0lNeXVTNjB0Qi9WMzJhSnlXTmxVdVBDN2I2dHFXdHZqWEFj?=
 =?utf-8?B?ZjJWUS8yTVNURnZwc3N1Ny9KZHNxazcyUXkwQlptcHNBYitnc0svZXl3WEtR?=
 =?utf-8?Q?Tkmy+2iJ4RoSrpPWjlIRJf7Z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d922d5-d756-407c-4ccf-08dac2422015
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 11:04:10.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMmS8ufBaQ8XjwqxIUmFVpCZweDIfC69BkOkVsMHE9dAOeYq65QymCD40INlKGqq+MSSxiUwrjpLtNk3MpB8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09-Nov-22 4:22 PM, Borislav Petkov wrote:
> Hey,
> 
> Peter said you liked this stuff so here it is. :-)
> 
> On one of my test boxes (Carrizo laptop - that's an Excavator core) I
> see the below. It happens with 6.1-rc1.
> 
> I booted latest -rc4 + tip/master and it is gone so something has
> changed in the meantime or this particular version doesn't fire...
> 
> Anyway, we thought you should know in case you want to dig deeper.
> 
> Thx.
> 
> cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888101a3d3a0 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294892455 (age 294.968s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000002f5fe849>] __kmalloc_node+0x5f/0x180
>     [<00000000066a1fb1>] amd_uncore_cpu_up_prepare+0xc7/0x240
>     [<000000005fa7fab5>] cpuhp_invoke_callback+0xf8/0x460
>     [<00000000d4b0952e>] cpuhp_issue_call+0x118/0x190
>     [<000000008cb1592a>] __cpuhp_setup_state_cpuslocked+0xee/0x2a0
>     [<0000000007534fa6>] __cpuhp_setup_state+0x76/0x100
>     [<00000000d8277f50>] amd_uncore_init+0x275/0x336
>     [<000000004af336cd>] do_one_initcall+0x44/0x200
>     [<0000000040cb5caf>] kernel_init_freeable+0x198/0x1e4
>     [<000000008b0e9fae>] kernel_init+0x16/0x120
>     [<00000000459bcaeb>] ret_from_fork+0x22/0x30
> unreferenced object 0xffff888101a3d240 (size 32):

I guess this should fix it:
https://lore.kernel.org/all/4fa9e5ac6d6e41fa889101e7af7e6ba372cfea52.1662613255.git.sandipan.das@amd.com

Thanks,
Ravi
