Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C762F6F721E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEDSsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:48:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA859FB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0RCCf4+h1MC9uOz/goIOqiTy59QmEP5tiR+0IvcsN7CrquT48Q4iyquQmsZjsXApvGEoc4fzhnPJvIiPGndAYzuLP6plJK1oUhDELQ61qYOA+/wQDqtNkk1kHKyBv46Fg7uwSL82jy+MF9zS/lmHDTwmh6BU2EYlxGmSSs9an8tvlVBTNkfUToxI5xDNTEtD29KQ3V2xnnebzrwXJLPgaU/dQ9X/mEMpknLYTkAYA/ANwc9AIpzB8xgDa4WsNv7B35LSvIn6rncWYVsKI5rXdt0ri912L546fv+E0IeK6+HVUMsZKD/A4vK+7e9QL/3D/VGJcXkx02cYHKgjGbcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86XymlDIEKlGJu17cIARu617+i+8W1nWwITXwGQDWDk=;
 b=TSf0XWeZZhjr1NeIWfcc1wH4SKONRE9kMyCs2CdmHO+YV8x+7+22NxHQ3Lu5+9jHAwYSFZnNGIIut4Jf+dyeAzaPrVwCrW2lTUdHHO0H5UhQGmd16RQWQcbsdkFrg1lINDNE8mdHVe+XdyBXmPhq/1XWwtVKtKesICzrm1eT27Rv94q5XtJlsTQXly4M678vE8YCMgPUPpXkJpKMuao4/9uXDq00Wq92Nm4kuue0BF3MlYaBdJJn/CAtrX87+dWDhdf7rzZp544B9JoK9dI3EcBUIojNKDxl1Qe+BO1VFR4fsq/+F//Lr6ZhwHRZwoyzD7wyiQoJOMN3sayqba78oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86XymlDIEKlGJu17cIARu617+i+8W1nWwITXwGQDWDk=;
 b=btEYR4FSrJFMczK1v0Q/F+hlmhLIdlUdm6+p2srY0nNOK2SKLIfwNSl1tcYwaSW5jTmWu1IPaGcgFnVnvqT6dbrWlgXR9OpacB8C5Mqi2ni/rlBsECwKnh4qqqNgmwBSEgnW5orB+LyWCCjrjz8Y4DzrkcsdLAywNRdoinw3igA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Thu, 4 May
 2023 18:48:45 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351%4]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 18:48:45 +0000
Message-ID: <7368789d-e2a8-ff1c-f224-b9f1b7896877@amd.com>
Date:   Fri, 5 May 2023 00:18:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <835c3de6-7460-226c-96e7-839aeef6064e@amd.com>
 <b9acff08-913b-55cc-75dd-4a1bbe63e330@kernel.dk>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <b9acff08-913b-55cc-75dd-4a1bbe63e330@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: f8518efb-3a03-4ef5-ecda-08db4cd0302a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqU5wkmrAgdK6j/p5Fp4zdlpoXqpQXS3Q+kUhUaMGXeZO16Fd29Wpx79Lg2d/J7R2nCBF7oMTWT5I5/QsxGG3+OZo7yZDlCwcT0HNfRbnXGptmbECqi9LnRD9tU77zYxL6ueItKTHEGpg6rIQRckyw3shmeLI0R8/6RWvxNODfNkP8U0z3Eww7eTp7PRuvwjW1GxpjCKSTEUNxWQ7K00cCGRmMiqcaPwPHZiXEQsBrrYEmolATxJpUJXD3P793NEU6nWkvXehWttYqzRMsqlA02ooJyzFVjAy8oLZ2vpmemZE5zPu/IznmLLQjSuZHYYZ9CaOTzJqGggX2QhAeuxrqfQpmPC7L8lXWKxFkpB+sKrlluVtXsy+33LzyIlN2u4WKg3h6LIOiyQgT3YU7LCcf+IOm1yEGrP26bToMNoAjJAb64pWNot0k+CXm2S57IcJjFPNqGb2j9KPPRUVJjtTFhbYkLh/4MLqTOo8A4Fpo2tz4vUqYTb0fj8Xn0QI7Q0mJJrdk0Ai5vpjrnqX7ZLoi9VUtxog9FMZivrB7rVnJ/0wRwmZTEpwNcVFDE2uhYivlES0q1xy+dlNKIbxCesIrB71DHcCrLL0bpRD5CvatcO1gPCH5zAKMSIwxT+ECdica+biS0QSmEFkbLVp18R/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36756003)(31696002)(38100700002)(66556008)(5660300002)(41300700001)(66946007)(316002)(8936002)(8676002)(2906002)(66476007)(2616005)(186003)(110136005)(6666004)(478600001)(6506007)(26005)(6512007)(53546011)(83380400001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtFdFgydkwwbU4xMUUwdzc3cEhzQTRPc0JhR3RXZUhkbnpMcmhCMEZyNjhz?=
 =?utf-8?B?MUlvT0JWWk92VzE1TmoxM3orL2dybEhRNElLMnFxVTJkQ0gwV3VmVHl0aSsw?=
 =?utf-8?B?Mi9VdEJJWGhBcTFtRUJPZjNrUDNUWHlxbk43R0FSb2JYNEdIUlhuYXl6R0Uz?=
 =?utf-8?B?alhxcnBaM2ZBQ2d5enFDYkVGUE5uWjlJMWR6VXczWm9GTjZNOVFvSEdEWFNT?=
 =?utf-8?B?Ynh6YUpMdTlEZjdZbnYxTUszUHplaHBaNkgrNXNydEg0SlhpNHg1Y3RnZUhP?=
 =?utf-8?B?Z3RnaGg2eUVUUW12c3RMR2s2aWh1Vm1OUzVQczBhc0cyd0Y1dVQzb3BINm4y?=
 =?utf-8?B?Z2UrOEhYMFJ2aVZueDVvOFQvMkV2bE9RRHBsZTg4RnVObkNqL0lUTmhlRWc4?=
 =?utf-8?B?N3JMNUxlY2lRTE8wVUNaZHZsY0htS1VJZU0xa1RtaEcyYXgvM2tJWUJDSDRp?=
 =?utf-8?B?SC8rSDFLeEVPc0lIWjR0U0U0OCtjbEVMRi9ibW5FSHJXeC90MDlBLzU2MTkz?=
 =?utf-8?B?cmcvUUpobmJqK0RTZWdyQzlZWjVVNHNrWHFkSzRkdVBXTlhzckEzRVpYcmxQ?=
 =?utf-8?B?TTJrTXY2UC9lN1FMWkpmUnB1cWkzbVN0b010VktXZlFmVzAySGR5dUZsNUlI?=
 =?utf-8?B?MUYvZVFsRnBpdERtdGdNRUxEemp5azYvV1FnWkNvbENFSzE0cEhkUGJ1NDlx?=
 =?utf-8?B?UGx6Zy9jdXRJcEJNUGxJa3JMcFlCQTBjVUgzb1lYTGJESmJsM1ZOS3NMaWNV?=
 =?utf-8?B?bUZremxqTVM1YitLcVlBVVdtY3Vza0ExVHBCNDBMSjd0RGZYZDFjd2czV2NO?=
 =?utf-8?B?dCtmOVJsVTJnREthZFRiems2cUZGQlVycGRRS2ZkSGRwS2VjRzdCNDFEcFBY?=
 =?utf-8?B?QzZSUnFKQ3puRkpFNjU3QlRvUUM3WUFoY3dvYjFRRWJ4OTZYVVZZVFRKTVFz?=
 =?utf-8?B?VjNDa3ZCOWkzOGVsY0dxSWNtOHhyVldtcFJCZFFJSHNvaUY4MzVlS21WaXpr?=
 =?utf-8?B?b0dja2JnTXdRdncxK0hSbWx0NGRaRGNidXdPZ3R2RmZ3ZDBXMlpPRGRtUXBl?=
 =?utf-8?B?clpUQ2hOWERjT1l0OEI5L001aG9hYWdaMVZlY0MveTRXbFhHL0ZUaFhaRXll?=
 =?utf-8?B?eXZ2UnJrdTNNaEFFb1J0ZkhKNXkxM1lNVDFSNUtvWHdhcjloa3pHcXRLU2Ji?=
 =?utf-8?B?NXUybHZyTllETmdPS05JZ2ZKNjRFZ0dXSWdqTmRDa3J1aFlBZjdTbzh5SW5i?=
 =?utf-8?B?WGtMQnBxT2hLMzBac0JuelBFL0psWTR5Zk8wSDNrS3dBTi9YV2ZqZWVDU3Q1?=
 =?utf-8?B?Wld5V2RrWVVlZGhMRVVINzRON2loQjlCaldSdy9vZXZwZzRreXViYTRQM01y?=
 =?utf-8?B?S0hkTWVFRGpHUHcrb1lNVzdOM1kyMWhIM3RXM1lGNDFlYktuNWFCU1l1SzYw?=
 =?utf-8?B?OFdobkZmUnlXY1ZhMVhaTHdGWERTYjM5Y2JnUUxFQlVLL0RvSU16aUN1MS85?=
 =?utf-8?B?bUV0d2lTZDBtS3ljeCtzeHlEOEN2Zmd1Ym9SS3pqbGdIdEhzY3RMeWhETEYr?=
 =?utf-8?B?UXRCVmRqWldqQTZQQk5RQ0t4RktmRXAxdk40QzJVSlB6MU5MZytQUHowVjgr?=
 =?utf-8?B?MTRYQlg2bnNNa1B6U2xLNTZCditBNU9VMGJkY1RjNTRNSXFCc2ZhZzJyU3Zz?=
 =?utf-8?B?QWFIN0Y3V3hrbDFUWnZNN0xMMTNYYmNSekxtdFR2a3JnWHBCd09STnRzazVY?=
 =?utf-8?B?ZUN2Y2h3RjJVQlJmeFBZMmIrYktndFhLczRIYWMvamZRcnI1WVVPZC9tMy9T?=
 =?utf-8?B?M21UUUIvVDEwenUrbWFaSjFlUlAxMUlza2w5KytKZk5sVXlZUThVSkQvdSsw?=
 =?utf-8?B?LzBUZ3d0bkV2M21MYmlnSXlIUGM0SkdYQlJlaWtzazBNK2FzbUxIbmZvVVlr?=
 =?utf-8?B?dmZTNmZqV3E5NWd2RjY0a3hXa0taR0MveVE2MFE3alpHSTh6ZE5PWm8zU0xC?=
 =?utf-8?B?MUZPZVlibkhUcXNOUXBkVnJRemJ1aFZkdHRyU085SHpWUTN0cnJTMHYrNUZn?=
 =?utf-8?B?WGtEMGgwTWZEem9IK3VUK2IxbThsajBIWGVsbGpzSmV1N0puazdPZTI2bzlx?=
 =?utf-8?Q?ZfdiIwogiDS/M8/VX+WGeTB2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8518efb-3a03-4ef5-ecda-08db4cd0302a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:48:45.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkJw2ZaqqIAHs3E3Wv9cgZx6+BDHr3uu4/1BYDa17mSF2zF/YHisoHxif4L5sQt1zbUWCil/qiTqeqVXGDAPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 10:14 PM, Jens Axboe wrote:
> On 5/4/23 10:38 AM, Raghavendra K T wrote:
>> On 5/4/2023 5:19 AM, Ben Greear wrote:
>>> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>>>
>>>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>>>
>>>> Just to understand this properly: you mean after the boot loader said it
>>>> loaded the initramfs, not when the kernel starts using it?
>>>
>>> I am bisecting...it appears to be .config related.  If I skip enabling things
>>> during bisect, then I do not see the problem.  But I copied my original buggy .config
>>> into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
>>> the .config settings....
>>>
>>> Thanks,
>>> Ben
>>>
>>
>> Hello Ben,
>>
>> (CCing Jens here)
>>
>> I was facing same issue too. Surprising I did not hit the same on the
>> guest VM.
>>
>> After bisecting, found that Reverting
>> [9f4107b07b17b5ee68af680150f91227bea2df6f] block: store bdev->bd_disk->fops->submit_bio state in bdev
>>
>> Helped me to boot back the system. Can you please confirm
> 
> Can you try and pull:
> 
> git://git.kernel.dk/linux for-6.4/block
> 
> into current -git and see if that works for you? There's a fix for that
> commit in there.
> 

Jens, pulling for-6.4/block helped in my case.

Thank you :)
