Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43066AD5A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCGDWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGDWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:22:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E661129;
        Mon,  6 Mar 2023 19:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c325duPiHY3ESuTqkhZKIrOHzTJpsU1omvaGQpE94tLysiZcfM2M21pIJGvUpjNvIXTs6x6GYYdcIH0RgShNBPNqS1AVjUtuHGjTgYNxNy/F57DLRwjip721kf2eZ1ZTrjwGzjsjurOs5NtqxlDG9f2x+XTWAA0eLCej6hISzWyjHGxw9x88cmJT4kVA+uK5IfBjR0voLvI0NQ9W1y0bmdb2cpfhEhQ9USre3Xy4dKRXehrQnNFNpyt+qEYGTgw1XShaFVdWHenF0ihI9iM9U7ey6/kMxv8s2FJD/C80wzvCb0F83tWrOPItJccdt9NjRYldRw9OS8n3F0LxqjaDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8N929KV6x3v2FB4rD8h8Z0vIoZdMSMGQTln+hHtZk0=;
 b=PH7W5QFMBMwlB2liy2FB5ohOFtjRKIUQJt6W3XKdi1A6t/9QrQZ4Q2RZY9tRkqQflXlAXV9OySo6e2fQvBhUAwtd1kVlBvSILFUdV+iGOyg3IMgatsR0ituKHsP6iAHFTEaHOD4ApHv0OUx3aQMaDCjTj1sWd5TKGuin8FzxdhYKhH2ZdcQy8Ncc+/aogzYFmHOQ5Tqu230SZjgZVED+gjlySCslRgXbwy3RQOIPzWYAnHjFgV3A7ogoQuJavslLBzjpzmIwqEct0VTAnI0mtCMWjRVhzT5rPwBP/grPK/h/15J4AK1b+6nK0C6uR1x/jAZ9uc4gwhL/pbiBgUECEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8N929KV6x3v2FB4rD8h8Z0vIoZdMSMGQTln+hHtZk0=;
 b=21OFHxoFButds6fd70ZnC8ZzLd255Dm76wOwSP00Rz1yBZ+kOEE13+8mX4cxu0jHJHYfvnOFj6OzdBSX4KxfI3LeOcVJc1sw1NJSkp4z6E+tfhUOm9UznR587/t/VIqOrAEzatPwCAT0Zq/DFQH2tDO0M9WrOrv7yJGAEH/rG18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 03:20:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%9]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 03:20:12 +0000
Message-ID: <7c721c17-1d72-5fbc-4d69-d8d6bc12b404@amd.com>
Date:   Tue, 7 Mar 2023 08:49:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] perf/ibs: Fix interface via core pmu events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230302092109.367-1-ravi.bangoria@amd.com>
 <20230302092109.367-2-ravi.bangoria@amd.com>
 <CAM9d7cjEvjcYwjA+HfsDHKDX8FGZCECTZ8vDMPHBUSqfQSCOfA@mail.gmail.com>
 <c5f1c3c2-6de3-a40d-9cf0-c1c7638acfc3@amd.com>
 <CAM9d7ch9OsFz9N71QG5DOyygctK+bVAFGQByUGAvy=d29rzWZg@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ch9OsFz9N71QG5DOyygctK+bVAFGQByUGAvy=d29rzWZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 518a546b-75bc-47b6-46ae-08db1ebadcd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxQr4Rs8eHDadJHT/bI1JU7DTS7nawSLEAIevZ0hMh+0lBaiIi+YeTzP4H0hPPCWXj1olFt5vPkoMZuUza7IOdiIm8jbSyFRmJUFTHuHIo6i9zVi+24t3Iz8KheyRYoy8xLsbCpiWyDeJoehGbkk2vf+9OTCQjdjQcqOwYO81anvpYfeMVdAmBaO4jOv8NyZDbp5ZcJDEX0o6c+sSt7oWvetczCfQ3u5p/OQnwAXWlQ4DN5YTeCibd8Q+sFb2clUDPAPqFSJ7JtPkERDLilebB+f5ylyT8IDrwyuueElFTbSuvnO2fmpInBlN0lt5DPssWyKyYELanCzHqThdlgsFUvJ+RhSc0of8cmCGVqI+lxmGADjdRTZey6Du/nT6SSMvhYK/k8rWn09nO6FGK3YzDIhVgGie4NA7YGbc0/7cl3dcLuSDbMQrkO6Zz8SqOBP4o8wfj4qPGGSgFtJfuIGJiOrYpVHaVeqN+HDvm2LKn2cyVz2sAWEMnqkj2lwBr+RtrCFHyrAwd+skoHEYBv0ORHGamByvMhMtLmKnjnzHkkcw12HOortLFiqAhAKIs5XFlD+7OsFbIBGRMnlZ8lqwWKJlAh/IFh8m/bO48fy6+EQttwQUS2s3ZMHwwdL1cj1qQLkBvyz9lj34oRp085xzcQS+pQJJV4Ew+hHn6JSrDQgqk6B1dVObhNrVW3uuAm12Y2k0E8UloqNV8dj0D9WJQ7fISwlJFDDYQV5pqADT5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(41300700001)(186003)(6506007)(6512007)(53546011)(2616005)(38100700002)(478600001)(6916009)(8676002)(66476007)(66556008)(66946007)(4326008)(316002)(36756003)(6486002)(6666004)(86362001)(31696002)(44832011)(2906002)(31686004)(8936002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRQeHIrSzJyNDJLcG5FbDF5eU43RWUzWXlRaFNEWi9POXFxMTZXWlMxUll2?=
 =?utf-8?B?Q2tlZnhxNkJUNzFKYXZVMDRxMmQ4S3pHZlFVeGVzVy9NU1hyTEpyM3BtWEJ2?=
 =?utf-8?B?TFNLN2xSSXYxa0hiYTZpSXRuM3p0NVhubzZnN0xVM3FPUHJLUEpna1VHZWFB?=
 =?utf-8?B?NjdMOUc1ZGhXUkQ5ZDdQN3NtMWpxcko4SkhrWUV1MzdCNVF6bW5RdVhQbzVW?=
 =?utf-8?B?NXJZRHhVU2k2ZXNUQ29ET2hqeVhWUXpMWDBRZ1VKaktIbWwxcE9ia2NjdC9u?=
 =?utf-8?B?ZGljTzFHMkwxK3RYVG9mZHZpdGVjbEhWSEFmUU5Sc3U0SFVESWhmZ0E4dUdq?=
 =?utf-8?B?UWdBWHlwUzgzY00vL28vUFBqclRHeGgyWThUUllxNEhXZnlCcmdVTVoxdWZ2?=
 =?utf-8?B?eC9oMFNTY2RoVjFXb1pUR2xDb1RoblpOQnduV0htbWNxVjdFRkFDNlkwYVNK?=
 =?utf-8?B?QnEyaGluTUNvT0NoV1lvVVpDYjdkVGlPMSsvcC9HRnpYT0p3aUtteWZ2ZnJJ?=
 =?utf-8?B?Mmo2aEgvWTRtSzVkSjA5NDhySEhaL2tVMWxyYTdyRUVxWkoxd3BGZlJiRjd2?=
 =?utf-8?B?TlRWSXFGMVA0YzQwKzhQc1VMaUVwZUNQM3NmemZBYTR1alYvdXBmNlliTUVs?=
 =?utf-8?B?Q25wNEVKWFhUMUg4UnN1OStCU3JHSEdHcERjR3dFcTM0YkpESFVrVUNrQmxz?=
 =?utf-8?B?TTNaRVVrMHFkRVI1cjQ5V3FKQnlLeUgyS0l1WkJ3c09hS3ZtMjE4V2lkWk5I?=
 =?utf-8?B?S3VGMU9OYWRwZndZU1IvUEFLb2pwYmpJRWtJMnc3VmxWNS8vSDRQbW1ld21q?=
 =?utf-8?B?WXpFaFBDakhwdWtURUtrdGZqdUlNTkh5TnNtcWdoUEFOM1h1UDN1eUxvdFEw?=
 =?utf-8?B?NGxMVGJoRjlZKy9icWZER09CQmhJR0trdklKaDVoWDZMQnhiYXQ2TUp2WFRa?=
 =?utf-8?B?cmUvb3prQlRiYTdWR0JsN0dSbDhHQThpM3paVDVnZmhFQlJRK3ZLUE9ucDM5?=
 =?utf-8?B?WkVMTG1GUDhqWDB3RFBjMnJicGhpWG4xa0UvbitkMGxucERaYlJuTXVnd0tZ?=
 =?utf-8?B?cDE2SzBBWUJubnpWUWF3NHlKOXlWc29YRWdpOGEzWjQrTEJsTW1oYjFqWmdJ?=
 =?utf-8?B?NjlpR0wwbkYraVNtVUF0eXloK2lpdU5mZEpaTFVhZGRORVN1L01IclkyWHNs?=
 =?utf-8?B?OHIzdUpBK3ZidUhJQjNSS3Jpc2VacVcyZXlrZnRKdjI3cWV6djVZdHI1V3pL?=
 =?utf-8?B?WFZVUTVvS1RhTTAvRkdlR1JJR2U4SXVFaC93SlVhaVIvUzlNeHpBdFFocHlw?=
 =?utf-8?B?dXc1dkplQlNiY2svUHVJemNjVWphSVZ3MXpHWGJCaE16NG5KcWNPU0xHMWtZ?=
 =?utf-8?B?NHJOUnFDUWRpS2FGNVcvek81UUZvTW4zcGV4VWlmcmFhVzJFRzVMWVR5cDRo?=
 =?utf-8?B?dWQwOGlnM3YxMHBkRkl4bUI5ZVk1WDcrbU5wRGgyeHgrcXJueCtYa29yQXBT?=
 =?utf-8?B?VTdyY2VvUVRhNWRDb05YQjArNTM1dzVDUVNZZVFMYkQ4NXh6ZmtYM2d5WGhr?=
 =?utf-8?B?cmVkN3F5UFJlbnJldmJDZnFacUJ2NTFXUHMrZE4ybHd5MmZkRk1mWkdablFY?=
 =?utf-8?B?enNOZnFFOGgvRWxNOVFlZDhlb25HdERIdk5QeFJ6SzhYeFRKTWozRTBUZ1Z2?=
 =?utf-8?B?V25rZU5aZU8zQlg2cExzSFRxcEdKdE5jd2hHdDk4aC9SQk5QS0lCdEVRQlpW?=
 =?utf-8?B?L1pmRkJvdnppK2VWTEdLalJadjdJUTY4cWIrSWVtNWhUbitWbEZEVzh0OFU0?=
 =?utf-8?B?dEM5MVBSOTZjY1JNQVk5UElSaXpkNWFrV2x2ci9KajVZd0x6Y1cwbWxTb0xp?=
 =?utf-8?B?UWJxRHE2VEl0SVY3UzBmWWdNQjJYS1VvZVN3bXA4RGVkOS8zYXZHcmc1b2c5?=
 =?utf-8?B?ZXhHcS9JMVRORXFYTUkrNHlNZFBLZ1ZlUE83cmlLMGpOdXNOVzQ3SWFWVldX?=
 =?utf-8?B?ZGNCMWhzVGpVY0JuTUk3WDh4Mmg5Z2llUCtDOS9XYWtuTW5ZYXZkVWVKeXFy?=
 =?utf-8?B?clNpR3grSDRDOE9tS3NsWVhFVW05QzVldzZ2a3U3QUJhQTJmN2kyZkp0YnRV?=
 =?utf-8?B?UzNQRjdJWjFhVkQwRk9OWTQrSVdXRTh3Q0hibEpKcUFRalFnOHN2MktuaEw0?=
 =?utf-8?Q?309o1kVbOajESnlZr62mZ0wKX8gUP/nd2YMfQMDVwFt0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a546b-75bc-47b6-46ae-08db1ebadcd9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:20:12.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBRwtzX2RSBOMCBdhmfTXadnElbb5/SYC/q7XlcFmieFuhhzkXX05pcGMpQKP+ASS68tZ5ZW+nLoX4YS/cAMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Mar-23 3:59 AM, Namhyung Kim wrote:
> On Thu, Mar 2, 2023 at 9:54 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Namhyung,
>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index a5a51dfdd622..c3f59d937280 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -11633,9 +11633,13 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>>>                         goto fail;
>>>>
>>>>                 ret = perf_try_init_event(pmu, event);
>>>> -               if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>>>> -                       type = event->attr.type;
>>>> -                       goto again;
>>>> +               if (ret == -ENOENT) {
>>>> +                       if (event->attr.type != type && !extended_type) {
>>>> +                               type = event->attr.type;
>>>> +                               goto again;
>>>> +                       }
>>>> +                       if (pmu->capabilities & PERF_PMU_CAP_FORWARD_EVENT)
>>>> +                               goto try_all;
>>>
>>> Wouldn't it be better to use a different error code to indicate
>>> it's about precise_ip (or forwarding in general)?  Otherwise
>>> other invalid config might cause the forwarding unnecessarily..
>>
>> That would make things easier and we might not need this new capability.
>> Most appropriate error codes seems ENOENT, EOPNOTSUPP and EINVAL but all
>> are already used for other purposes. Any other suggestions?
> 
> Maybe we can have more liberty for the error code since
> it's not returned to the user.  How about ESRCH, EIO or ENXIO?

Ok. We can probably use ESRCH, although it's meaning is little different:

  $ errno -l | grep ESRCH
  ESRCH 3 No such process

Thanks,
Ravi
