Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE36C8C17
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCYHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjCYHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:08:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC6114491
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS07VM5mXe/y2pTAqble8jPgZNsOIkysPOEcZma/+bwLpgFMmfDZ9yNIk2iZDVKa+ega3KosREAj27aGi/5jP4U57p18Kbe/8EggsDoEsUGij/OeQrobE02xgTwVhDnFiZJFiP+VVXLjJsecnt2QMDzrjqI+xW/CRziva+w7goq40boqQrnFsv5OWsAFr90/cPZCQXm83pEk+et9t2zZDjNrme4KKvccxWKxl7UC0h7QiPOwMoWYFefG+4Zcg28qc3h8mPAdA1gMbuZrO2MaxeoswvJv6hqXcBd1LUfa6Ul/HBWbCxM7EHZuUEs5j0lCQWyFAKYHiuFRcMHcU1BJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFtScfB6/i99PNxPgUFaT3/XgX3rIfuzZAVPFzSXD34=;
 b=gaU16nOLJPgvAfJU31zd1bhPYOiPevYXRYWzIOWfK87EtrtFqOG0/fW3XIIACqXXqBUOykmvSnNM/OO0893qxssnCnDQNco2M99ow9vj/Kk5N8ir/k8mUTS4re94gbwPeaAwf2uvWTY42jjm7RsCEWuwTcRZ8QgelNgZrRCnguMIgtf0NOznOXtUImHBPXSuRHevVyQqVEZi2O6v26TClq6ETJxZAMlUcr1RNR0Qsgkm8WGAA1Co4LrWWTH7kIqh4lsq0sH4dVCbsgOGt+tYy2ggdEn5yfwAE5OYo2i+lolliDXyxeP38vB10rPaO4wix3b+UE+D0q3aZ290Fq4l6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFtScfB6/i99PNxPgUFaT3/XgX3rIfuzZAVPFzSXD34=;
 b=0E2GhDM/QsIsr7955TMZmY1yA2WwrNA38sW7FkLTRKRpdu5khCQkiZmY1iRqpjw18gd2F3hEOLD/2rjvl07mMxlghBubASeE0PdCtXzTAAdJXWS7vbBxuOJTgLl1K66KE4y0GbPMFSL1Zwg1YV3IOO8X4yrnHNmRNptwFuEkdRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Sat, 25 Mar 2023 07:08:39 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::f2f8:a2b0:8e91:de7%7]) with mapi id 15.20.6178.041; Sat, 25 Mar 2023
 07:08:38 +0000
Message-ID: <d9151806-c63a-c1da-12ad-c9c1c7039785@amd.com>
Date:   Sat, 25 Mar 2023 12:38:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: fuse uring / wake_up on the same core
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Bernd Schubert <bschubert@ddn.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230325002815.1703-1-hdanton@sina.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230325002815.1703-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a69d16-c31a-40be-4226-08db2cffc188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSuOeIAdhSzDLFQ35nsQQlSqNu3aTFk9LF0RQfurXUAid7i2aTVw6QyewmyV2X3NIrDyKk6msT5qq09whj185A70wsfK2TaVKecyuYrqtBrbyW0eGPxM0OjRTC0BYH5l6xUo8ghEC1CISxYHMdsW1j89pSOafHQ3LCijwVzAIqEUdyVDYwUgbxL5dfHdwD3k1S9T+hZICklcN22j5EQZnZfGxI2orqN4y6y+b/RVnjYuf7QdSbt5qL6eAwkH0KM3HOtCuNiSW1WEawgeQytq52qJzbU51UY6bmCv93LpKURi+D6637FjJXx+kvyP8dKtyhs3szL9d/SHWhGFEZTun/zCjOHClGolqFTl1+kB0SulgQ2y2aaUy2Iqvwiat1l2qaH++9/ayQmc86+5EF6+h8fLqFA+SCDtzjIpIHtF1rKJPEkpg5qNRtBwH9j484rglGvk+sVeUblnZUzAnppvaFYuPvB1OHmcMmtkGQSBuXQvRkKo+QpT63iu53VCGhBKbvjrM9IMxUHIJGyz0mgNhmVGFc+JNa/ulg5UrBuB6p/sr9l7ObORtQGfc+mlxhEravr4jbMfRDQwUjR1fUSKiky/FonKoWvKeuDTr448xjzrC4Akp8gABfbB76G4ktnBtXID8xA1avNcwgiH6ueP4JLecq8BvSU263p1jLSYHmGm6lebV6FNG9EQdIwvezSeRzC8xfTBsN3JCUmEm2FxWwmgjH9UQ5fotyhMrSx+HK04gpNyFVasApabJyQGwoIPzuiLlnbkIiLHVgtBt6AH22idN+bRRrSNEr0hPWuAYus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(2616005)(31696002)(478600001)(6666004)(31686004)(966005)(6506007)(316002)(6512007)(66556008)(5660300002)(2906002)(53546011)(8936002)(8676002)(6486002)(4326008)(66946007)(110136005)(66476007)(41300700001)(54906003)(86362001)(83380400001)(38100700002)(26005)(186003)(36756003)(49934004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZWdkF6ekJYYzBOU1hZeU1JcjhuZTVWTEhjTFRlUmdTRDBBMmNwNXJWWGk4?=
 =?utf-8?B?eGR6c0RvRU9tVHRpUGUzTUUzNmRJYUpNaDJ2R0U0M2s0VEhabm9kMDh1NHpN?=
 =?utf-8?B?enRSbkRLNFJmUVZRNkF3bDl4RWsrNTVQQmY3NzJYQ3NoNm1wa2thVzEyOTVk?=
 =?utf-8?B?NGxUdnIxM09XOVpUbW1GbnRTUTM4R296YWRndmhEZ2FZbmM3RUs5dGFndnhU?=
 =?utf-8?B?T0poSGtuYXZYZ1FqTElzRS83MHZUQWNXbXNHWnAyRUlpNmxrWlBwckVpM1Jq?=
 =?utf-8?B?ZHl5bnM4VEVMNFVsVGR3ZGhPanRvMkFTbzVBS2JmYXZ6d2tXY1BJYW1WdTdH?=
 =?utf-8?B?NDJpOXVVYVJ4MXV6T0NManFybFRqY0xqRTFnUXRaQTJ6aGVqNnFmS05oMHRS?=
 =?utf-8?B?Nlp5alRDMXdPeDRVL2F5VjByZVk3RzhmWEFXd3I4VmpKM0dxZGtwVUp0YWJl?=
 =?utf-8?B?VlVYYzhjN2hUdjNlRzFHRzE1dHZZOUVQb1EwcHpkT3ZXQW01RGtpVUVRNXhy?=
 =?utf-8?B?bUM0N2xKWmV0c3E1aDcvNTFuQXozRG55TVBHa1B0TkRLWjlEN3BkWUU5R09F?=
 =?utf-8?B?NDNrRE5oSGRFZHRnSnl1dHo1VFVORlhiZkxXYVRpeWlyaXdUeTVJZzBNVmFL?=
 =?utf-8?B?eGk0bHA4V2FIV1pwY1VNZ1FXUW9MYlJtZSt2cVh4Rm1ZVkUremEvbzBIRklr?=
 =?utf-8?B?c1AvTHpDZ0xQZVRwZEV0MzZjUllFSUZENjRLQm5kMGZsV1FpdkxkL0ZUcVFq?=
 =?utf-8?B?YjRIRjlqSFZ4MXdhay9jWFdGS1dlSkxRaTFrcGFQRFV6aTN2QURLSVBwWk9D?=
 =?utf-8?B?OXcrSjd4VjY4UnZZOUNKSXlQVS9wYURnNWFlaUZzaTBBY0tFK3cwUHorRnl6?=
 =?utf-8?B?WHJyamlBR2hJTzZHbHlPYnNXa0VZbDZ0YkRHVzk2dVhLblFyTnZVRUljTWJo?=
 =?utf-8?B?QTRLdXYyaVpFSGloWDFQcTdPYjk2WnhEN1NqUEUzNVBJVTBUZWJZZ2p0bXd5?=
 =?utf-8?B?NHd0dVJWeitibTBRamMyeTlmSHowVFdmRXRkbllkM1Z6WEg2c04yb2s2bEJ3?=
 =?utf-8?B?ODdaVVEzbTNIbzRFZHVWdXFLT0NnUDJpMUtvMk9EUmNOV2twT1hWUlFubFdv?=
 =?utf-8?B?RzVWU3JIbUR0QUFtcDBnTjFXQUk4cjN1WWdZZVFEVWlnNFh5akJISkp6NWhQ?=
 =?utf-8?B?U0oySFY5TGhHaEhURUpXTThQek9ERGw4UFk5WHpPT0VnMkplbGlocDhXZ2sx?=
 =?utf-8?B?bk45dzViRnJ2RUQzaXY0TytDbllTMkdvKzh1UVBOVzUyZU5yZC9uS2laTDRD?=
 =?utf-8?B?Q25wbG5ZcTBNN3diS3g0M2R3S0picElRQXF6SExaQVFpSXNqWFg4YmtkVU9q?=
 =?utf-8?B?R2FZcjJjM1NxcGkxWmFJRFg3M0dhT3p6bWJJQk1VK2hHL3RDdGVOY3FTQWlY?=
 =?utf-8?B?VEVWSVhoNkJJM3YwMVlFMDJPVmlpM1FjQUxHQkkzSFNhUnhKQnNLOE5Idkw5?=
 =?utf-8?B?N0ZiRng5bXhGTERlTHY5dlpUNW5rbUlNMGx0MHFjMllwaThlY0VsT2UrcFJF?=
 =?utf-8?B?ZFRaaWd4K2oxaWN1Mkl2RERzOUk0cnU5QVF0WHgyWmwxMnlJcXJXZGpJdFlM?=
 =?utf-8?B?OVJpeFducUd3TVhuOUZyZjg4VHZTTWVLR2NuZ1F2Y2pRbmQ4TlorV3oycVU1?=
 =?utf-8?B?TXlaaWRaWEk2NTVJb3BqQ1hqc3REdHg4SXluNjRyY3kwQVREVEd2MG9RSnZZ?=
 =?utf-8?B?WkVQN2lnaUtDSCtBdnBrdHZkUTJISGhhNC9IMU91MTlhM1JOOTZZQ2p0b0E2?=
 =?utf-8?B?dlpKd2tSeVdNbDRRc3NrVVBnaFpTUGVib09qMWExblZuWDJEbjdwM3pjY0cz?=
 =?utf-8?B?Wk0xZU0zcVRnVklBTm0zR1JJRkdlRStjQklpOGJGbXhYcXlXYlN4K0JyZnNq?=
 =?utf-8?B?a09yTjRWclpJZ0JvdHQ3cFZSd1c4ejkrSkNMMklvQnE2WUtHMHN2cTZaZ1Jo?=
 =?utf-8?B?NFdHbWZFT3Q4M2U1WHVyeG5lVlNDUDlZWjdWdkgwVmtkdVZHN1NSQW1qV095?=
 =?utf-8?B?aGJnNkdZaVNjRExiYW0rUmROWG5QcDVDaWJQcmRFS2NId3BGbUsvQVBpamhx?=
 =?utf-8?Q?klLIs0nUlPI659F/Mh7WMFOWl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a69d16-c31a-40be-4226-08db2cffc188
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 07:08:38.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oLqhNYwcDg3d9TveXoruXCHRxXpEnfQh5aLaAGjwVWWXScixEA6KEtfp7ctEuCzd1N32HL6moxpKbrEElBgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hillf,

On 3/25/2023 5:58 AM, Hillf Danton wrote:
> On 24 Mar 2023 22:44:16 +0000 Bernd Schubert <bschubert@ddn.com>
>> How much of hack is this patch?
> 
> It adds a churn to my mind then another RFC [1] rises.
> 
> Feel free to make it work for you and resend it.
> 
> [1] Subject: [RFC PATCH 0/5] sched: Userspace Hinting for Task Placement
>     https://lore.kernel.org/lkml/20220910105326.1797-1-kprateek.nayak@amd.com/

Thank you for pointing to my series.

Another possible way to tackle this is with a strategy Andrei is using in
his "seccomp: add the synchronous mode for seccomp_unotify" series
(https://lore.kernel.org/lkml/20230308073201.3102738-1-avagin@google.com/)

In patch 2, Andrei adds a WF_CURRENT_CPU that allows the task to always
wake on the CPU where the waker is running.
(https://lore.kernel.org/lkml/20230308073201.3102738-3-avagin@google.com/)

I believe Bernd's requirement calls for a a WF_PREV_CPU which always
wakes up the task on the CPU where it previously ran. I believe you can
modify fuse_request_end() (in fs/fuse/dev.c) to use the WF_PREV_CPU flag
when waking the tasks on req->waitq

(P.S. I'm not familiar with the fuse subsystem but the comment
"Wake up waiter sleeping in request_wait_answer()" in fuse_request_end()
seems to suggest that is the right place to add this flag.)

Peter favored wake flag strategy of fixing wakeup target in a reply to an
earlier version of Andrei's series
(https://lore.kernel.org/lkml/Y8UgBnsaGDUJKH5A@hirez.programming.kicks-ass.net/)
but I'll let Peter respond with what he thinks is the right way to tackle
this.

> 
>>
>> [RFC] fuse: wake on the same core / disable migrate before wait
>>
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Avoid bouncing cores on wake, especially with uring everything
>> is core affine - bouncing badly decreases performance.
>> With read/write(/dev/fuse) it is not good either - needs to be tested
>> for negative impacts.
>> ---
>>   fs/fuse/dev.c |   16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index e82db13da8f6..d47b6a492434 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -372,12 +372,17 @@ static void request_wait_answer(struct fuse_req *req)
>>   	struct fuse_iqueue *fiq = &fc->iq;
>>   	int err;
>>
>> +	/* avoid bouncing between cores on wake */
>> +	pr_devel("task=%p before wait on core: %u wake_cpu: %u\n",
>> +		 current, task_cpu(current), current->wake_cpu);
>> +	migrate_disable();
>> +
>>   	if (!fc->no_interrupt) {
>>   		/* Any signal may interrupt this */
>>   		err = wait_event_interruptible(req->waitq,
>>   					test_bit(FR_FINISHED, &req->flags));
>>   		if (!err)
>> -			return;
>> +			goto out;
>>
>>   		set_bit(FR_INTERRUPTED, &req->flags);
>>   		/* matches barrier in fuse_dev_do_read() */
>> @@ -391,7 +396,7 @@ static void request_wait_answer(struct fuse_req *req)
>>   		err = wait_event_killable(req->waitq,
>>   					test_bit(FR_FINISHED, &req->flags));
>>   		if (!err)
>> -			return;
>> +			goto out;
>>
>>   		spin_lock(&fiq->lock);
>>   		/* Request is not yet in userspace, bail out */
>> @@ -400,7 +405,7 @@ static void request_wait_answer(struct fuse_req *req)
>>   			spin_unlock(&fiq->lock);
>>   			__fuse_put_request(req);
>>   			req->out.h.error = -EINTR;
>> -			return;
>> +			goto out;
>>   		}
>>   		spin_unlock(&fiq->lock);
>>   	}
>> @@ -410,6 +415,11 @@ static void request_wait_answer(struct fuse_req *req)
>>   	 * Wait it out.
>>   	 */
>>   	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
>> +
>> +out:
>> +	migrate_enable();
>> +	pr_devel("task=%p after wait on core: %u\n", current, task_cpu(current));
>> +
>>   }
>>
>>   static void __fuse_request_send(struct fuse_req *req)
>>
--
Thanks and Regards,
Prateek
