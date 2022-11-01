Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347F615517
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKAWeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKAWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D618647A;
        Tue,  1 Nov 2022 15:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiafn1OPb6B2ELeFTu2LvuLIwYxOi1BWjaSDpoe7HQY2IrlOGQrFrUVzgvBJQ9fT8fL4hYxpsRP8Ye5Vz4DQC8yC1LpwMjK0PeHV+D6ULSIFJNBgthw+RbsUgghVpTXbpaPePaY57JSu/tta1ESOXZ259S1LOtnyU83IRBQ/Z7lCt8u9Q/kBKNd4XVAcTW5OZ+oJnvqwyKMgUCe1YzuWGSzsJrnUqBYQMRpMpsFSpNslWd3/0+PwwRtJe5ta5GGfymq5OPe56PoXx+m1ns5NOAbS/vUORbMHvGo99s/ic8LpdkZnBUT+FC5veOYzNrwtjFu97JgeSMf7LxelLUHcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtDMwu0olHQ569sSTmJ3pQr8uNyt69wZnix2qyAwrCA=;
 b=EiJ+obwOtUUhM6ZO3Kv2gYWVtihlk4YqG+YTb6CdBLPLktOJbByAvkYKCmCk72PHHSu0yn6CoKN6nkz3PDYoiaNREMd+7bltNhhY3y7Y7BLVBQx1RPjrI40ZMpEGu5UwxP/DHgD8wYV7Yvzuw6a7YwWfHDJZnGrvPbDzUpazPMAzKBfG/w90MMqZ7mKNvix7y7uRh2IZ54aNEcudACYb2CWUAasGA3keYkEG8FfWTXl7Ww39s6QRXHtmbrdgMI3G52+uliTRSegN75vy83jAflBHbOAfmxgCgk0kAg3Q4lE1i0tb1MpX3/OrnuCSO8R4q2Tvm1FxBj9XPqjtojh1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtDMwu0olHQ569sSTmJ3pQr8uNyt69wZnix2qyAwrCA=;
 b=aJGVAzbL5TapIMv7qRtFL2FhsPWPDTzJq9/WFynW4CavjKAyo83NdWeIi0OMxKE0EDPhSI/UWaG96CmWWa+4h9PWvH3zahPT7tu09bE/UT+t31iUvd0IvlNoLO/jhy53YQdS2CVIDOi9WkScHKMzg98ZWDJt9mLER4r1awzHMnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:33:30 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 22:33:30 +0000
Message-ID: <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
Date:   Tue, 1 Nov 2022 17:33:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, bagasdotme@gmail.com, willy@infradead.org,
        akiyks@gmail.com, miguel.ojeda.sandonis@gmail.com
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
 <87wn8ext0m.fsf@meer.lwn.net>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87wn8ext0m.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:610:51::31) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 28815ac6-bfa4-44d2-b30d-08dabc591a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PySmyn4IaV6lbNuGTXu2zWKCMThiLqgKJzhVeYocsCNO9mj3HV+w8ywFbWQyw+3hOW9ISoxvRHAK7yZxnf3vkFL/JHo1+Ie8eF6/nfz1yGPe5J6SlsGJ86OlVswA6quiB7h0EVPdLyOBM0kgJL2Ph2qb6sEFXeV2rnsnaBc+h6SGCRL70b7BHVoF+9wl2B2AWBsIf0ySdyty4ZsdkfANmiT6Prk87hHys4LdlnCEEtUZArcXb4slLHUzHIMDYygeEZgp0Q3FsdsAh15F0k5WtalnNa40lyb2RivPVGkOQC0aE8FMHE0cId1wLVfpsLYVsAsZy7ZZk866OHHkCJX6fRgjH7YPAOOsEvdkVTrAq9QYs4hYAVUdr8ViqrqZH2Ct3kFqX62OMLsjHDBaXfyoIPUmpD75Q6qZN8SgKXL4kXzqFPQ1f9EBSSKIHNvOihJBC1JKqqs4pMFIGPP7PiKxkEH2CQvmUXhoJP5f0jNp06kBKAuda8IdH5eDc1gmwhk7rS6rSM+a0AcS5EflHwj7BAWXrW6YDc+AHmmx47D9NJDZg3/bKH/Rre3w9FQATsLkm8TWjJSqgVWDVXoZV1OdL3Ht0p+Oc0ZCyMJ4gcbbJXcoGuCaye4u33rCgcAkmi6toZmARYopDNp6J6D8CWD5GI5ycF3TIqU8yg5I1MIzU45A7mpVY0spPxR49u+omIycWg68yY7tYevi4Ne44SjAx4w1YUISTRi0qKMs4V6qu4mrkscZXEU3HfexwL3WrBmx3Hr7V7/vAb3I1vCOikzSiUEXqSEuQkAPeEzu3UC2o/ZuNv3RVrGch1kpMjjITga/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(66574015)(83380400001)(186003)(86362001)(31696002)(38100700002)(2906002)(5660300002)(66556008)(8676002)(66946007)(66476007)(8936002)(4326008)(6506007)(2616005)(26005)(6512007)(316002)(6916009)(41300700001)(966005)(6486002)(478600001)(45080400002)(44832011)(53546011)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNBd3JXNjJJUVByTGVNTFhTNFhvTW1sMXhmVWhmOHFxQ29SYjRCNHNDQjZQ?=
 =?utf-8?B?eUhLZlF1bE5SNURwUGFxOHU2a0lJZmw1V3hIdFhUT2VYZkNYdUtteHZsNVBP?=
 =?utf-8?B?MTJVQkVIZUZqKytRZzJKYk5zSVVuM2ZsTG00Q252UDJwZFV6NmhDb0hrRGk5?=
 =?utf-8?B?UlNvaGxVY09McVdwT1ZXVXh0Vyt3NDFxODdlUnRqdy9OcXFlQmx5cEl4dmdl?=
 =?utf-8?B?cXlGZ3llQUN5dmI3cTN5OXpQdW85UnVENEYwNXMvbWRjWkVqWmp0VkpINkU5?=
 =?utf-8?B?R3ZmMXhtNTFGRnkyaWZVWFhhdC90TjU5amxiSlZwQkNXQ3pqQ0JHeTh2eGs4?=
 =?utf-8?B?K2tDOEsySkxVeGZUSkJ4ZzJEdWFJV2lWblhYQld1aURzbVkvWFc2NHVURkRm?=
 =?utf-8?B?ZExCQUN4K0RZdVdsOW84aWJUeVZTUy9ROGNZeFFVWEJyWlZRc2tOZFl3Z2JZ?=
 =?utf-8?B?aVBGZFNTbUNHalNEaTlWRnFHY2xGTDR2cS9UVGFJc0F3MitITTB4VERZTFNu?=
 =?utf-8?B?VHJ0TjB4enlPRXFzR2JHZ00yNE9OcmY4MmFqR0d4OCtqSE1iZVo0aTJhM3Uz?=
 =?utf-8?B?d2xWMnU5SllJT0dqSXcwOGJ3MkNBL1NFcmpDOWFUejM1TzdUdEx3aTY3OVly?=
 =?utf-8?B?L3RXdEtpaCtqTlBydDZLT25uNlRVZEE5WGdPYkhwY0hOUk05MDcwa25YMUtF?=
 =?utf-8?B?dzVpVW5hQlZkemdRUWUvcm1pZ2JQUnVoSUp1d2JYMU5DMUNpNnVqcTgxR0dl?=
 =?utf-8?B?RThRRllCMFNoMGJrTnV5ekZVZUhIVVZvMzBidXBWWEd4TkZ1Y3o0NjZQeEFF?=
 =?utf-8?B?VmlSYXpMZW5uMVVKcENBd2J6RmxNc1FHZ0NuNXBZOXpPd1poeGU0djhKUkpx?=
 =?utf-8?B?aU5XNmxsamxFMmIwdUQ2dk5VWHN6ZWltUUdDUC9RNWdtWFdCVEVyMGx5bHY2?=
 =?utf-8?B?dVVSOGNnQVZ1NUl1dm9Ud3ZNY3VVWjFQNWhqYldTNUxVS201eDc1TnhWbUJX?=
 =?utf-8?B?aWY0eTdwclNhaERwTmMvRG9tV2xFa0twaXlwSmlaM0lST1dEekhrZm5HVzZX?=
 =?utf-8?B?N05yQk9iZnEwNmJTTjRrQ3ZoK3FlK0JDc05DWmpPQUNLd2wzK0FSTFdFN0d5?=
 =?utf-8?B?OFdwaytpejhKbW44N2dKcDdSSmJZRE5jeCtsTDdyd0lHbUs5RGZXRW5XOGsz?=
 =?utf-8?B?dFZiS21wWHU2ZTdXNlEzR0xXbHFCa3ZIbmRNOGh6SXZIdDJVUi8zMGRDUDFX?=
 =?utf-8?B?eEovRGR0eUJaZEplVGVERGtZYXV6WDBCc2J3Zm9nT0p2OUgzR0pQWi9kVEV4?=
 =?utf-8?B?RjArTzEwc1h4d2NSaUdwUjdWbnpPWU5xZ1ZJZWdyTTRpaSsvN0k2dFQ2aFdM?=
 =?utf-8?B?S1cwSU14cU40c3J5YlBuNDVxdkRZV0V3aWFXYkV5a1ZnZzQzdk5SbDZCN1dU?=
 =?utf-8?B?SDA0UWtHVi85a0hwU1k1L2l2cjFtMnZHVThXWDFLZ3F4dDRGVXJpVHlDV1cr?=
 =?utf-8?B?aEJ6TmpkR2pYZkV5UExCUVkwVVlURnY0bVVxMnZPWDBHRys1MjdtRXlSemly?=
 =?utf-8?B?ZlFZb3Bjenp6MndCU1ZaelcxaGM4OWhVK0djY1ZlMEVEaEl3dnpLK3JRT2FD?=
 =?utf-8?B?eGFTcDcvTVJ5ejZqRjhYbTBuanFFRjBZZm1WZUI0MXZrQnowNVNMYkVEbmpJ?=
 =?utf-8?B?alg3ZThLTVJKd3RIUkxHWHJKRGl4THhtTU5zOU1xUEYza0FCd1pQT25KQ2Vl?=
 =?utf-8?B?WmRqWk02eldST3JBQUdUQWRPOVBvWnM4ODJJQ0VIaElselZ2aURWMmJ2M1hP?=
 =?utf-8?B?OWZKcUE1TnQyOW05R3c3QzlMT21qMTBLcEU4aDJZeUFzekdZMWVweGlCbFlE?=
 =?utf-8?B?SExCNGZuVE1rb3ZQN2RwR3lYZktZVzZ2Qkk5ZnFaYnJLZFhKRG4rUVVIQ0d4?=
 =?utf-8?B?b3V3NkR6Zk9sd1p1ZEo4NThpbkNHLzVqeU9vTlp3RGs4MHd6ZTBWL2pMOC9t?=
 =?utf-8?B?dXp3NDFpaTBFK1libEsxTXJ5M253NHFvZzYxSmxMdVprc0x6OVNVZlhONkpp?=
 =?utf-8?B?L3ZGdTBjUldYM0pOUzhCcGJkejE3S3ZITmk5eWxoYWNqTzc4bDVZMkZEMWlq?=
 =?utf-8?Q?rUUUFl6u5TD2FvRi/W9CtjNDT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28815ac6-bfa4-44d2-b30d-08dabc591a29
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:33:30.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yp9KTRJPIyY8KQZ68QUMidDZDkol7nHezMnGaUnNYylMFqDIJAdIh3F9fRzZsz2CXDFxWQXEctpgYmCVwzqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 16:30, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Spanish is the second most spoken language in the world. This patch set
>> starts the process of translating critical kernel documentation into the
>> Spanish language.
>>
>> Link to v2: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F10%2F13%2F866&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7Cc3cb093ef27e484b78fa08dabc503ce0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638029350093417289%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dKxHmWM4ljRyAZUw%2BpZ%2BxVM1KxIM5pR098RqnV7w2gs%3D&amp;reserved=0
>> Changes since v2:
>>    - Apply improvements proposed by Miguel Ojeda
>>    - Added Reviewed-By of Miguel Ojeda for first commit
>>    - Added Reviwed-By of Bagas Sanjaya for second commit
>>
>> Changes since v1:
>>    - Added me as MAINTAINER
>>    - Fixed warnings of kernel test robot
>>    - Use imperative form in second commit
>>    - Improved minor translation details
>>
>> Carlos Bilbao (2):
>>    Documentation: Start translations to Spanish
>>    Documentation: Add HOWTO Spanish translation into rst based build system
>>
>>    Documentation/translations/index.rst          |   1 +
>>    .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>>    Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
>>    Documentation/translations/sp_SP/index.rst    |  80 +++
>>    MAINTAINERS                                   |   5 +
>>    5 files changed, 709 insertions(+)
>>    create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>>    create mode 100644 Documentation/translations/sp_SP/howto.rst
>>    create mode 100644 Documentation/translations/sp_SP/index.rst
> I went to apply this series just now, and got the following from "git
> am":
>
> WARNING: Message contains suspicious unicode control characters!
>           Subject: [PATCH v3 2/2] Documentation: Add HOWTO Spanish translation into rst based build system
>              Line: +estable más reciente del kernel, y no están interesados ​​en ayudar a probar
>              ---------------------------------------------------------------^
>              Char: ZERO WIDTH SPACE (0x200b)
>           If you are sure about this, rerun with the right flag to allow.
>
> Any idea what the story is there?  Could I get a resend without that
> problem?
Just tried to apply git am and didn't get any warning. Maybe you are using
an extra flag? I'm running with git version 2.34.1. Could you try replacing
the offending char with a space? Hopefully that solves it.

I apologize for the inconvenience.

Carlos.
>
> Thanks,
>
> jon
