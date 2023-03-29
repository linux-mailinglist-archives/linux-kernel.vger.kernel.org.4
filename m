Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC36CF2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC2TIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjC2TH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:07:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A81BEC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4+7L81h3B9grksht70m48c08sg7LQz+kktTYi9OKnimSOec1rdtsS6ML9uPC1JZP99+4tec6EMdX3z87JuujNy7fkQHcF8sHZqSn9USfwXq09uQG9v/6h57XKO08fUdlUDZqA13jvi186w2jUHxKX4T7c3xvBTvKuAm3JmnNKrXVMyjYefMdBoqk8OyHF56tu78keYJyc3B7ObE0CBdEOdt12Yqo7FMNpdRb7d7Z+5AklYM/qFg+epU5W2grS92KtWbod49hz85+1qZC9emLWJbO/8yWkej0Y60RMMjMwJbtogNWYE9Nv7LWWd8+ajFcKayqf+w7KjogTQHPRIdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edws7ATZK23GlUSxp2doGMbjXGWVaJeTC2+rvTuqKQI=;
 b=gGTImFPUK9sEvQ4XbaImLmr1AjyYmJZrNJDrH/gMPrUexALbOyGmECq/6vGR8z+vKX2UjE6shRjFP90oNRv4a4jBIO/ac69s4NGSa1fijMVrnEIoNXIEK3tD2LA3jN4BugVDzN9CucVoAvVySYN09dNL/1VwdUMn5DZhhr6ocKhS/Op5/+inTuOzNcDeOCN8SFc2IMaSzQLAGjKKV4QjJwKu+Mp4UVwaVzbKKVGDiP674X2jXhulPFbrnpQaZ0Xa44/gb8Fx/l5rZIXpdLW3XjP7lNxcdfvdJ3axredKjjvq0PeYPipW/M4fxttUMp0g9omrwivh3eI0q7cxwLIzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edws7ATZK23GlUSxp2doGMbjXGWVaJeTC2+rvTuqKQI=;
 b=gNA+k1yKGQ/cLBtaeEF9dg4pADJ292QVtJzbTgWeizCjVf5Zhrf0QRyif5Njtfwz/zQFdwm8TdtW8t0uw5m4H0Q7JXDPQAkPYm6klybkoOiYFAJlQdmfExhJg8ebZ3vTsHDA5d4yS5LSJsTbYSEdl4wra775BAWmL2ozY6W+pMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 19:07:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 19:07:50 +0000
Message-ID: <b65c4f1f-4990-f7ce-e4c0-85912d187eaf@amd.com>
Date:   Wed, 29 Mar 2023 14:07:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-US
To:     David R <david@unsolicited.net>, Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <eaa97a25-27b2-187c-1db2-9c56e35d3463@unsolicited.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:610::41)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: ec153154-3529-479d-7b6a-08db3088e3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SX8SpF7HXZTBLG59nuYO0kcHTo0y0ZdD/AFhYfOB1KXqu98oh3kBgemgB+ca8KALLLbuF2r+Z3Rr5JxN6oZW5ycyZWboBiN+N+1LMBdA/HFvPHErArz0JEJZQZHWkhwXipVqVx0SGT/NCS8nVtPXLZt8Ow/7/rQZUxhVR1DZyUblAsV/jTnaJ5YyKJ+PHM638L6prXAuJUqGF9OKpPdqDAtbO5UUk5ZBKLHCtKtXml5UeUN4nN/oja8ZLKlzg4gZsMC3ZQjlwcLF1T2Ju/Y4BoQxAACb+Y385eGwYxqjgBKu+1+NxGiNpQ220OPO/ktfJiNOzP3mFK1pkCH+jb2GPi9k0ueMF3u4wOyFEq3h3UWTHMQnpY3JXapp2hmO7cettWhGfT6/ZWxV3ixj7VWTg1PQ6cjH2FJm9m6KSR4DFUTrltpG69HnZgQtPQHRzCzmqfxlouu7I5SI8i3LeN9yLUU+3f5B6pyTn4gsyLgGRxI+Y8hPsgrQYrAxeV/jnEawYtnejnmofzrypSSJKAVsEJjQtP+TVfIKNp5rTG0J6BmKCl60Co+yEv6IPpXDZwXnMvUdMp8K3Zx9mwmYlQZ541cLR1KTunhxtQvBj135N3zETFa4xIPLtcpGTF+156U8/x7X5pJpo7BbxOxAqpd7jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(478600001)(54906003)(6666004)(110136005)(966005)(6486002)(316002)(186003)(2616005)(26005)(31686004)(6512007)(6506007)(53546011)(4326008)(66476007)(66556008)(66946007)(38100700002)(41300700001)(2906002)(8676002)(8936002)(31696002)(86362001)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHM0WkVEcWFQZUNobXBwM1FTbFhCZ0EzRHhjbm1qWnVLek1HRGdMUDAxM3dn?=
 =?utf-8?B?Vi9DNloyTnpxVTJrM3pSMmYwWGhZQWVYMnBiWTUwT1I4SVFwdEFNSjFxZ3g0?=
 =?utf-8?B?dHRBNVI1OVh1QnZrTXlvNy80UVVYemxEalh4NFhNdnY4Wnp5TFFpWDdsTysv?=
 =?utf-8?B?SHIwb0c1YXpCVjRBRFcwc2pWZkwxc3FCT283WlN1VEN6S2hkSFRUaXpWL1Nj?=
 =?utf-8?B?YmZlVm1MZVVpMHVTaFg3cjVHTlRhejZnN0trNGRncE0zSktGNmpWSnMvbHAr?=
 =?utf-8?B?eDhEUTd5TW05M282djQwV2lBcE4xZ09qRGxRWjZxUU9vdFZteTZ6N1ZQQkVS?=
 =?utf-8?B?aGR5eHJSdUdWd2NqMDVHNkN0dlIzY0M5RTVSZFpMcGdqelJ1K2JsNUxZWmhF?=
 =?utf-8?B?ZG80ZTdmbmFxZ05NMHJVbDZQSlU0U05qZnYxbm45RnpaR2NLY21YSEpWSnlU?=
 =?utf-8?B?WU84OG5pR3k1by9VU3BFZ2tkNXNFdzYvK2tOQTI3NHZwVjVSM0VWK2cxOElq?=
 =?utf-8?B?UUlvR1dFeWs0SlhYcm9qK3I5dVAyaDZmdGs5dmlIdzg5UGhkelJKc3FpWHho?=
 =?utf-8?B?OTRuVzF1aVIxY3BidElheEY1eVUxaXAvTENpako3ZDFOWDI5TXhiYno2US9l?=
 =?utf-8?B?TER0SWJodS8yUTkxRW50aXJNR3pFRjUyb0V0VDVMWm03eW9DU0xwQVNzLzl2?=
 =?utf-8?B?MlNwaUFINUNRQzJIVkVFQkl0ZUY5eGEyQXNXUGNmUnFCTEVVMTFrKzdxcGcw?=
 =?utf-8?B?Sm5YZ1I1d293TTZLNEJLT1lVRlNPRTJHMHVFSU5jSFk1WFA3aGNQV1lrQm11?=
 =?utf-8?B?TVZ3d1d4VmRja2xlVWVYMmw4NSs2ZUxkazA1aXFzV29BYjNNeXUvSXQyejFY?=
 =?utf-8?B?cFFEQmR6dXdoSEFNUm5pOWVMN05NVVVKV0RIT3M0b3RadkgwMERuMkw4M2ta?=
 =?utf-8?B?blJjVFRrOXRIR2RrVjV6dzhDM2xRTkRYaTliWVZyWnV4bHB6WEdIeCs4VllX?=
 =?utf-8?B?bUdnOWI1ZytibEZUUjBlbmJEdG9seE5rYm90WGJiWnlEK3pCVzNaWDN2RHAr?=
 =?utf-8?B?OGZRUGowRTgzN2lMMkZvTnU1M0xJR3FHb0xWYWh1anVndjBwOE5JdzVmblRk?=
 =?utf-8?B?aEVIN1M0aDFKZm03UHNYN0MrTTJ6cnE5SzJpRXg2VENIMHYrWGhxUHV3OUFl?=
 =?utf-8?B?eGtsK2VtV3dmbG9ob2c1dnBuMXlHdG1LTmU0TkRFYndFQ2hmUGFURG15Uncv?=
 =?utf-8?B?aGFZMVZOdXdmYWFXeml2WFZjakFWK3RmWE1taTloYkZDK3ZZbW5OK1UvcjJw?=
 =?utf-8?B?eE5oY2d1bVZLZjZmNlJrSHBMQ2kyNm91eWFuR3kyclRTaFFwb2Z6N2lPSWlh?=
 =?utf-8?B?a29QNnUwREFLQjFGZWF2SHdtT3JkWFB5SnN5VHl1dnNvdmltZUozakZuc2Ew?=
 =?utf-8?B?Nk8yUkIrMVo4ZEFTUjNjT1NHSmJGM2w3R1VWWGwxTkhnZUIvYUVZUGZSUzQv?=
 =?utf-8?B?ekoxNzd1YnBSZ0MzTGkxU1VNSzJudnVMSHhub0JFQWJFWTB5Vm44MEYzdk91?=
 =?utf-8?B?OGVWVHh3NVl2TGQyb3NzNVR4dEY1YW5zMFFib0ZmUktkWXp0K3lDSFlSOW03?=
 =?utf-8?B?eWJLM2NzeitrUTFVL1UwL3FIaVFZN2toNjFBSXRZNnQ1a3RCRHl2c3ZBQXBM?=
 =?utf-8?B?algwckU1M2dWUHVnMi91RnFHYUxKVUxCdFdnd1VVcGFHWVJyR3FkZllnYkRD?=
 =?utf-8?B?QlNUT3JqUUFEZmU4ZEgrdVhxSGV3MS8vdkJMdHV0RjUwMTF6UHZoSitUR1gr?=
 =?utf-8?B?VE9KUlRFK0FiWVNwWktyTW1Ndklqb2NwM3RNYzBycjY1SEhKak1BMmJvYTFK?=
 =?utf-8?B?Z0ljV3VvSzY1UGcxYWRFTE5heHd5TG5KbGFocmdkUjFyQTZ6VW1tY0RHZXdq?=
 =?utf-8?B?TG96WFJJVGFOT05OYUo5WU5MY0RoU01aZU9SMG5FaDdFZG92Tm1qSnhwMGp1?=
 =?utf-8?B?WkR4V2ZpKzMwVnZxeU1YaisvU1k4cUU0UG9MQXJBbk5YS0ltMGxTR0RIWmY2?=
 =?utf-8?B?a2pCaGdCTE14M2UzdFpaKzNpSlEwUEh1ajhScnBrbjh4WTNNcXl2Y3VQVGta?=
 =?utf-8?Q?37aQL/p1QamMR2Y79avkjk7qs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec153154-3529-479d-7b6a-08db3088e3e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:07:50.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywPzdQu4B3+CaK1uQgjP/SyngvrZUqyWvlDfaqFSGOnKFO1SXEL+AelBcoIHUtu8+WX74mSPZ/IS52UfZ2ZkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 14:03, David R wrote:
> On 29/03/2023 18:51, Limonciello, Mario wrote:
>> APIC @ 0x0000000000000000
>>>      0000: 41 50 49 43 DE 00 00 00 03 AC 41 4C 41 53 4B 41 
>>> APIC......ALASKA
>>>      0010: 41 20 4D 20 49 20 00 00 09 20 07 01 41 4D 49 20  A M I ... 
>>> ..AMI
>>>      0020: 13 00 01 00 00 00 E0 FE 01 00 00 00 00 08 01 00 
>>> ................
>>>      0030: 01 00 00 00 00 08 02 01 01 00 00 00 00 08 03 02 
>>> ................
>>>      0040: 01 00 00 00 00 08 04 03 01 00 00 00 00 08 05 08 
>>> ................
>>>      0050: 01 00 00 00 00 08 06 09 01 00 00 00 00 08 07 0A 
>>> ................
>>>      0060: 01 00 00 00 00 08 08 0B 01 00 00 00 00 08 09 00 
>>> ................
>>>      0070: 00 00 00 00 00 08 0A 00 00 00 00 00 00 08 0B 00 
>>> ................
>>>      0080: 00 00 00 00 00 08 0C 00 00 00 00 00 00 08 0D 00 
>>> ................
>>>      0090: 00 00 00 00 00 08 0E 00 00 00 00 00 00 08 0F 00 
>>> ................
>>>      00A0: 00 00 00 00 00 08 10 00 00 00 00 00 04 06 FF 05 
>>> ................
>>>      00B0: 00 01 01 0C 09 00 00 00 C0 FE 00 00 00 00 01 0C 
>>> ................
>>>      00C0: 0A 00 00 10 C0 FE 18 00 00 00 02 0A 00 00 02 00 
>>> ................
>>>      00D0: 00 00 00 00 02 0A 00 09 09 00 00 00 0F 00 ..............
>>>
>>>
>>> Cheers
>>> David
>>>
>>
>> Can you guys have a try with this patch to see if it helps the situation?
>>
>> https://lore.kernel.org/linux-pm/20230329174536.6931-1-mario.limonciello@amd.com/T/#u
>>
>> Thanks,
> 
> Your patch on top of 6.2.8 brought the crash back I'm afraid.
> 
> Cheers
> David

Humm.  In that case I'm a bit worried there is some conflicting patches 
that caused this result.  Could you try with both

e2869bd7af60 and aa06e20f1be6 reverted?  If that also fails, I think a 
more complicated bisect removing those commits is needed.
