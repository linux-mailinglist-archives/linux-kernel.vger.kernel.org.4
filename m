Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC46CF318
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjC2TYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjC2TYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:24:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE27F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVHjQjl4TA1SFj90mWAFw6xvDglAeGqFCj15AAwikjXZb7Fpu9IZbwxG1I8axEkYo/28ahl3qFUFXWCYEY/NaEBA/zBQtYxiRaxd0P35l0oFXL0V0e6V9Wg1p9xQKU3x8QGHVd1D8Nifhwq2eUZ4wtzW2oH638UGb2UaPY2yweeQni+7dSmlk2sQF7WdTFbIdmyBj/WrzptPRzYoUZHbyIP+4u2fCmZGhudD78T5T+ePGftcA1nJuaBE985lkI/kDXDVNqPaiyAuAPqOhvDfoAt1u1BmMHe7Jem+rBRXfCq1Tkkp23mqIXRWrG6Gcb9YD7LdOLSIx+MkikYIofXYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Rf0SsrFXgeICi41HYk50gWJrRT6PX5k4NTo7AQwqg=;
 b=jGeZ9xqfGfD+6hEN4zXT8EkY26mHv5ZeFwV1X+7FZYp3Arun7Qy2Ai5gk8L41FWHcAX95TcWREpQJz2MpCT3d0TvduK+Y3ItnuU+OtpbIO3XCHAsLsmiHpLKZavBNQlyGj3yIeKhemr76oYVTTsjpcyIA61ra2Dy0ryNgW2+Dy7IAc4EKkCYPbD7J3DXV1FjSFGNaKq9MR+c7JdygYm8WNJEiR4OvexWTBTos5kyMAzJ33rsQz6Mwe65LCM+qCqip4XAUcDUMeaq4sswdJu2nsKejm/rAZbo0u2PNJm0HjLtcOcUhNOceHYfpykQrkKpmCbV8pA0NQES/cI1CoknFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Rf0SsrFXgeICi41HYk50gWJrRT6PX5k4NTo7AQwqg=;
 b=GiTfzAmDH+HizZ+rRlctcQjfcGQd+94kRTZsGHKWCO8pkJbaNvePWoVNg9cgXO5WqfJArYDNx/uN+tkhoJpEj5hG4hpJIZZif0yqh19/Mkx6Hmx0x2BjGCBQqbHQTbv/fv2ex57w10e6zmVK7Y8tBCKFgHzVyatSmCZojn3RZPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 19:24:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 19:24:05 +0000
Message-ID: <70291f94-1fcf-175c-fc18-e9b656f55af3@amd.com>
Date:   Wed, 29 Mar 2023 14:24:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-US
To:     David R <david@unsolicited.net>, Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>,
        eric.devolder@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
 <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
 <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
 <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
 <e8fd7cdf-b6a5-1c7d-bd08-0d60a1c10495@amd.com>
 <eaa97a25-27b2-187c-1db2-9c56e35d3463@unsolicited.net>
 <b65c4f1f-4990-f7ce-e4c0-85912d187eaf@amd.com>
 <a0ca1e4e-891c-273d-e2d8-eeb9fc4d0c77@unsolicited.net>
 <e4a6e5bb-d014-aa55-5eee-65f1c5f59875@amd.com>
 <7218e006-9f4f-a9bc-cdd2-a595a8e64ede@unsolicited.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <7218e006-9f4f-a9bc-cdd2-a595a8e64ede@unsolicited.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:610:58::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f62822b-3c3c-46f0-7962-08db308b290b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfe/rVakFFQPsXVYqSBPg3FKS1fU5J6D6UlIWW+a5jGwsEIiGnOyMx1ptx3zTuMW4bU3Y6z1Fdcz3Z4EStZDz0JYZBc9QEALelEHr95NWkiwmf85Gr2WrNgdYl9u7b3j6s7+CCCw8n0XejdPimOpxAcw1boXgDwNZ8u9ZFy35oJYgbAq9KW+zhfk6DPLgTffMqTqXmNkHHk2sGc04lO8wxLHR3CpFqIEJGBxCg5iYiAjT0JuScV5K+z0pzMDklQw8iazDWREhGiyujmoKm9WxvAb4xJxwVShGLwY/IS5CwUx4/ntfCoC23TDW2zPyRrxlR7u1PZ39hBCoNQhHZdlsphYdUCoVqe2sntLEZgBstDle4CHiiJY1LOfDCrL+FiaLi9fGRvxn8Gm5+x0gxzt8dQB2rAJ5tAJG7I4KGiHncrkbMCg1oY87LP9EuPQgX2qNv3jBLTiFroaWb3bsDOq1kiVwXwNg65OO+kl7twwQlZkljuqC7y9SRhz6/6sKLsnfOoYV0r2sK1rJEMlCTVNjd7FMyDtberJMuScNDncX0bvsVksYPS2+dSHYpVxTPrObmB+2p+GGbyJKTRiUFw14vf4ujKO1Gaika3OOFmrXBWv6pfh/Nx1/2Fk40U0mS6ZiPJlHvI3q0kL7taAi/BjxRUxxV9izX2GDKE1YFFBW5dgb/EkMB/wRXVlM7bzsoeu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(31696002)(36756003)(86362001)(2906002)(38100700002)(31686004)(53546011)(2616005)(6666004)(6486002)(966005)(6512007)(83380400001)(316002)(5660300002)(66556008)(478600001)(4326008)(66476007)(54906003)(66946007)(110136005)(8676002)(186003)(26005)(6506007)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNkOWVoS1ZmTGxva1NURUgyTGwxYkJLYkNtdkpsdDdqVjAwY0hjM1hVTURZ?=
 =?utf-8?B?VE5BSzI5VFpXclZBRnlMa0VXbHZxazloOU9KTkVZNjdpQmJhdDI4VnFtQjd5?=
 =?utf-8?B?Y285ZW43eGM1ek8vejdINXQ1d1lRb3lsaDdIcXFjUFF3RnJsaEErdzNsRkEr?=
 =?utf-8?B?TWk3SEY5VmkwQk55NUxxWnk0RFczczMyQ1VEOGlkYWNabWZLSGtBbjlidm42?=
 =?utf-8?B?UENpdFZYRUhjbEhuSktrUFYveDdvUjlXSE1XUjdTV2FmaGF3dm5ycU1BamJO?=
 =?utf-8?B?SVczNlhaaTRsRmNoT0FWMjJXbEZFdjBtTkFBVHJNclQyTUlFQXdsOEZPcDBW?=
 =?utf-8?B?V0pFTlY1bndVRyt1dXNtVEtjZkVud2x4RkJvS0lqckZLbWNFZ2ZJazVHdG1Y?=
 =?utf-8?B?WTA2WHdCVUorSEYvSE9XeW9SZi9mOTdYZmYzTHB4ZXBkTXg3NkR4eEFFa2l1?=
 =?utf-8?B?ZERYTFVJbkZpZ2J1T055OXlxY0F2aXpNemZvRVZySVdpZkdhNGgrS0I2cEcx?=
 =?utf-8?B?RWo0czNHTVBKNXBmbGZpNCsweXJHMEhaaWY5NHZCVUh1Y2gyUWI1NHVUZy9L?=
 =?utf-8?B?L3NPa2xycytDZkJLbmJId2dRSEtRbWFMQkRJSUdmaVBQbHFJZmNlQTYzVk1q?=
 =?utf-8?B?Y2labUthcGVLdFltbDFvSnNXT3V0ZlU1UEp6ektiNDZ3UTd5c1BxY2JNWGZZ?=
 =?utf-8?B?THpjYVdYV05MOG05TUtxbTVQYWFYMHV4ZG1JY2VEK1FLWVRDa3Q2Q3NkWGVt?=
 =?utf-8?B?bnNwOEx6YytjUmZpczNRMzltYm1ieGxJRGRmTWFjSFJLTDZXNW5yaVEwUkhw?=
 =?utf-8?B?TVNYVHpFeDBhUEVJNXZuSCt6L0haMHljMitvVkNlSnNnL0pJMk5FeUM2cjE2?=
 =?utf-8?B?dENjS2tuK1UrTFpXL0FOVGJoWGNxdE9SUjdKV3ZNd2EzamU3eWxsQ1NCNzZB?=
 =?utf-8?B?R3dNN2pMS1JrQ3dkcHJLdlVJVnFsQ1hmWStaMi9hQVlMbG9UMGU2K0xzTklW?=
 =?utf-8?B?SzdEc01zcG1Qb2Y5cDFjalBUWEhvZnVlVFBOblB4SlcySUtZcXd0dUxjL2hF?=
 =?utf-8?B?TldvNXYvSk55WHdoeHhxV0FPY1lzWmxXRFNjRWdOWWNyaE95azVodlJiY2Js?=
 =?utf-8?B?dzdyWW5TT1RTU0hacTQ1ZVU1VktrTkt2emlFUHlEY21aYWZPZ3oxckUxUjM4?=
 =?utf-8?B?TDBHSmNXaG9HZVh5bk5MME4wMTBPc2k3N3VqSzlJT0tieVB5NTE1ZG5iUENT?=
 =?utf-8?B?bzl5cVRKQVozZ3Q3WFJLMmFHUExSaXIyc1Zmd2FnbnZYMDlib25ZVFZVeWpP?=
 =?utf-8?B?b3FnRDE3RnNMZk1OZDFtNWV0UE14OHNFU3IzNGVCUTZoK0dHTnh3eHJRc0RL?=
 =?utf-8?B?WllmOG02Z1oxcUplOGtSRGhDRzlDQjlNUTNSTm5jcWhINXdBMTBGMlpGbEJM?=
 =?utf-8?B?eXN0cEMwUUZzZFYyOXZEM1RzNjdFSS81K0NSb2hDZzFobXdlOWN6RitjNFJP?=
 =?utf-8?B?ZXBoYnlOVWovMm1pZzlKaDBPRFI0WGpzakpoWHRqaDNMSXdTYXZoRmg3b3Qv?=
 =?utf-8?B?ZTVaT1FiRGE5bTJWeitPWlkxTE55Y0NWTThMODY4UEh2eURoVGxlSnZLRENk?=
 =?utf-8?B?bGJINUNUVUxhNHc4cmpQOXZuWCt0WGJiL1J5cW1JUFIrbUpNZ3RMblJXblRB?=
 =?utf-8?B?RXp4c2ZVR0ZydWJEN3d2OTNKZGY1ajB4NmNhQUpEOWRCM1IyMFVSUUo2czhB?=
 =?utf-8?B?NUVEMU10bHFWRkt1T08vQ2RwdFhDL0YyazEwVW9MN0xtS1ZaWk5BK0JXUWVI?=
 =?utf-8?B?dlhERkxWUHEvYmd1eXZjdThuZlpjNmpIZFpTRjJBbE1ib3BkSmsvWExjdEda?=
 =?utf-8?B?UnlZVHk2eUFJNE9qQUJSOGNsQVNFeGVsS0l4c1BzZjFxcXlJb0FRSVNPYWdK?=
 =?utf-8?B?MXh4dGgyUjMwVjVpM1c4VFlJOG5nYlZmeUZDNG15dU5Za0l2M1ZPTFVjaitx?=
 =?utf-8?B?R2hxRmgrWGVYTWJNcmFRL1JkbVM5ci85VnFxQmM0MW1HeE1mYmwwL0lONVdn?=
 =?utf-8?B?UC80d1BkL25VZ2xTVGp5eGsrejZRNThhZThTYnFvWTlsbHRodDd4TFdvb0VL?=
 =?utf-8?Q?v/p7UIWQKZtemG8FnT/gF9tY5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f62822b-3c3c-46f0-7962-08db308b290b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:24:05.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPS0p0WZvxb8jSAfG6hxyN4FJSfdzAiuZCPvd+alvE8yaBbG0dfq2HSTksUe8XY63ZS7YE3lmJ96ymf0ZtHhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 14:20, David R wrote:
> On 29/03/2023 20:17, Limonciello, Mario wrote:
>> On 3/29/2023 14:14, David R wrote:
>>> I note that 6.2.8 still has:
>>>
>>> static bool __init acpi_is_processor_usable(u32 lapic_flags)
>>> {
>>>          if (lapic_flags & ACPI_MADT_ENABLED)
>>>                  return true;
>>>
>>>          if (acpi_support_online_capable && (lapic_flags & 
>>> ACPI_MADT_ONLINE_CAPABLE))
>>>                  return true;
>>>
>>>          return false;
>>> }
>>>
>>> The flag getting set to false won't help unless the patch I tried 
>>> previously is applied ?
>>>
>>> diff 
>>> <https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/#iZ31arch:x86:kernel:acpi:boot.c> --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c index 1c38174b5f01..7b5b8ed018b0 100644 --- a/arch/x86/kernel/acpi/boot.c +++ b/arch/x86/kernel/acpi/boot.c @@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)       if (lapic_flags & ACPI_MADT_ENABLED)
>>>           return true;
>>>   - if (acpi_support_online_capable && (lapic_flags & 
>>> ACPI_MADT_ONLINE_CAPABLE)) + /* + * Prior to MADT.revision 5, the 
>>> presence of the Local x2/APIC + * structure _implicitly_ noted a 
>>> possible hotpluggable cpu. + * Starting with MADT.revision 5, the 
>>> Online Capable bit + * _explicitly_ indicates a hotpluggable cpu. + 
>>> */ + if (!acpi_support_online_capable || (lapic_flags & 
>>> ACPI_MADT_ONLINE_CAPABLE))           return true;
>>>         return false;
>>> -- 
>>>
>>
>> You mean specifically this change:
>> https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/
>>
>> Yes; I suppose that still makes sense.
>>
> Yes, that's the one.
> 
> But the fact that  that one worked own its own implies that my system 
> never had the flag set in the first place?
> 
> David

Right - your BIOS doesn't support MADT revision 5 which was introduced 
as part of ACPI 6.3.

If you haven't already you should add a Tested-by tag for Eric's patch.

I think both mine and his coupled together should cover both of these 
possible areas of breakage.
