Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEE72CC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjFLRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFLRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:21:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B0134
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8emPeVqVj83n6wm2mRt+gQ2kvTcwyKd1H7ofdGilc6l8WL1BFtbPaO4ssnz1AmKPkFs/hScbAkZ7dEzCxEdQBbsN+23FjQlqXdN6+diZn3hY/X6QS0Vote7/FOc+ZHzZk703t7CQ4lkW8QzMA2g52ySnbxxReQ8KxBCHdD7kwAc1KLAH7M4MKH365cj0VJ7DwsYaoSoPhKVFqjbIDWTwWbTTwjhRajyL2dk1enaVcvmZNZg4XAQCh6/DC71UfEjHrXRmeIM28+sLl6FsOYUtmXmGFix6LFp+nFgA2mLek+MRWj6cO8yKDm9rX3gkykW9+7DFD2XZZgmMWmvfYydOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFySwoQHjrMMVfMImu8TuchtohwLMscuXQ21HRctzCE=;
 b=D+EmL+b9tYxHrWoBHdRwpV+pL3OXak9noaDvU6s2Gv5sXE9QWVsrW8YHmgR81BAi8XMWUhjI0Cm/MHDTt3NrkcLPZQecti7OUiUsiK8j/NewyaWoEHbgxEf8tlAtKWTsWwDC9fd/IspHaQSxztZ+3u15DALJryhl9vosOObRMREUV0VEKsbCKYbzCACHvv7xszAb5Vn+eQ1KWJGVQPa+dRYWW4azKbBmajpVsXpHQEdDT7wi5Sk2ps+58Vj3JmggE4NpMxgrMVWHJ6vVjQr5KG2rrIeNDfinSTrqJdjsGS7WjkKSo1lHku60FuIvlFbCsJw4uVqjdLxRrUqpNELpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFySwoQHjrMMVfMImu8TuchtohwLMscuXQ21HRctzCE=;
 b=TAtP+xWR6dZsjanWCycn75pdZja5V4iHq3fM7s3U+Br47jiybT1iZIm7qYvJMJjrBY29W67rejgVivSV69ovhVQovIX2c8ZdIL5bEwvbwLkh145gJ7IEtlFVPngFuJD0LQEmfwYKK6wb6ll3W4PLS+ec/2Zzd3qyRq6z/C8B8oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 17:21:35 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6455.039; Mon, 12 Jun 2023
 17:21:34 +0000
Message-ID: <c12889cf-d57e-90be-54a5-0329183817fb@amd.com>
Date:   Mon, 12 Jun 2023 22:51:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy
 Execution v3
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
References: <20230601055846.2349566-1-jstultz@google.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230601055846.2349566-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 1654f018-8edb-40a0-3e76-08db6b6978b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53EYZ4cNGRobIBP00g2AxSxEJFJmgvTv64WXUiztFyLI50v0PJ4Tbsy4KKldPT+axnB8keAtlizgxl6KeP2ucILYWlgenjw89GAUmwD19J+B9xV8+HclZLYzxD3+N1qrdN2IRpshFixRbywQRpcITOYOgBgsdJ+m9y0SqDjNZ7kdJgKtx/AyFVmBRZlxvRbAffVRFS3C8PGEDOUnnjMn2L9HJ0rvAVshlqCYdm0BVEU5+4sCUB5Cvolvsd/WfZ2u/QrVYuxpr6MAfI81B4tuiYh0LD8Q1L8sNqM9GZuALMMlkXvShwIoim99KnSQDtTmE5y5FotMwCyN9yM6hq5R/k+XPAsqQoHI9tWCSFEZO9t6dTOOnypYCsR5SvGxA2uAhvbiw0o1AcedCDt1DIvpxiKVvhrzQJlbLjrRrv4YAUc3C+/3LyxfMSVfjiPzmAQ/QfIYC7tC6QGIx5O65HDLoIiVMZ+VMbKLBfNMq3tQY4zyIaYCzzNI/mdo8c/Jh6KSnmqz4pxAvuswb0oX9GSD/2eahkY0nwFVwZ3polLwVWwSG9XSKUmPQLiGIEI53AsXr6BjGPS+wlKrMTteOSgFs6HrPGotU22ugLRIjoHXbYUN/+lrWnqLT6z2TZZJ5OcxJ9tsXfw73zL+kSfwJCjGQVu8rUIQJClZHPfkCtiLYwqUvr92IM0RkPhQkRtoWs/BUxJL6j+ZvEMwCOeVoKM/cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(6486002)(6666004)(966005)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(53546011)(26005)(186003)(30864003)(2906002)(5660300002)(54906003)(110136005)(8936002)(7416002)(8676002)(316002)(41300700001)(31686004)(4326008)(66946007)(66556008)(66476007)(66899021)(45080400002)(478600001)(218113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBDV2ZCamNWcE1xekpUdkxOaDVPNE9XWVNiNlpVSW1aaG9YYlhaRGs4OHlh?=
 =?utf-8?B?aDBGdDVZeXB2eVdDT2pqVzZDcnZSV1QwLzBVbkVvSXg2UEpOMkd0dkNMeEpr?=
 =?utf-8?B?dGZjU0hNSU9SQWN5Q1NDU2tyVUFKUUVBTmV4dVplZWNuNklPV00wTXZ0Mll0?=
 =?utf-8?B?cTk5akFrTEZXZUM4Uko0SEM5cVRIQjloTXNtdTVxeFc5allpZHEwa2FhTWc0?=
 =?utf-8?B?clU2TG0zalNPMnMyT2RqY0JNYlVNYndQK2srUUpzaHNndTN3ZkJWYk1SaE5h?=
 =?utf-8?B?ckovRTUrTldjL0ZXN2M3Y2VSZ3FaS0l6aVpYcEJDV0dpeHZkS3BXRWJ2Z0Vh?=
 =?utf-8?B?Rk5aUUE4RlVsU0g1LzdiRFZRa2oydXRXVGg2VzNVWkZFcE9CcUhPZ1J6M2N0?=
 =?utf-8?B?VjFja0htd1NQbXFjaXNkUXdGYXFrRlNGQTIrK0FIbzVuU1hLNVZzWDkvclVG?=
 =?utf-8?B?aU4yWHZER1BCWTZnWmowRGVhc1VwbExKcS9WVTNhMHRmYVVYMGZkc2tSVE1F?=
 =?utf-8?B?ZC85WjNxbjE3dllPQlMxOUNDeUwwVGxwS0hwUHBiRGVuaEtxK0NPNEZodFVU?=
 =?utf-8?B?UldJb0xFdWFDNGVEVkFFMnUrNVVZUGRzNmdFMzB2cmRNY1VTRmVsUkhtU0sr?=
 =?utf-8?B?aEtZNk1FUWhDaEU4VzFpdlBmUSsveVRJMHQ4VnAzbE14bGV0emRINk1DclBx?=
 =?utf-8?B?RzZFWkxvTEhrYnRNSjhIMnRFZlJrNGdiUWhOR0JmUGhoKzJFTjJXdEtxS0Iz?=
 =?utf-8?B?a1dtZmxlaWFMd3g2aXRPZTVIMXZOb01WeTV1V0FDVVVjcFFsQ1pScUNaVU1B?=
 =?utf-8?B?OVBIMTJob2dJalBEWHVEWjM0UXlXemozYkZEcUZZUGcyUGxnVmZ6SDlOS0VS?=
 =?utf-8?B?dGd5VUFmN2FzVFVyeGFoN1BNRFN3Z3FPWExzZHpuRnpTSVlyV0ZwMGpCendI?=
 =?utf-8?B?azlSakFmSHpSSzNtTUh4czZOM1RRNE92UGR5d2ppN1BhcVdOWUZxY1BvNE5U?=
 =?utf-8?B?cWxCN3V3cHRXWEVJTktMcTNCYUY3UHhhczN4MVMwVlFrT1hZSDU0VWJPS2pU?=
 =?utf-8?B?TlRhZEhjSmwyWWlsbkMzMGFxd28vRjRRYVpYQ3U4WFcyUGxBZ0VSNE9vZG40?=
 =?utf-8?B?bTRkdU5WaVZjbEVxdGsxVFY0OFdGMzk4MEF0L3JhVTgzRHR4SW1obTJHTVlV?=
 =?utf-8?B?eCtab1dqcmtFODdGbXUwSVJCREMrTkRrU3RsMldodEh3Z0F2d3pOeHA1bnZl?=
 =?utf-8?B?VW92K1RWOWhrU3RkL1VhYWxPbDZlejRFdGNiUzR3ckZUUHBONDlDOVpJeUd2?=
 =?utf-8?B?T3FNL3BxZXc5QVQ1SzF1K0hXekdYc3krMUp0L0lMQXpQUUdETEEyT0NFOTVZ?=
 =?utf-8?B?UmZMMmtxS2pzTFZRU2dNeGF2bE9aM1pkVUlSbC80K09QRitCOStTTFNpLzhs?=
 =?utf-8?B?clJzeXdlbDV6c1NpanlrQmhCQUp2anl4OGowWVNPbHpzdDU4NHJTdzdZTjhw?=
 =?utf-8?B?enVOVVovMGxEaGN5RGN2c1FlWkpJaU5Wa2F4UURFTlJ1eDJDa0xZa0ViZTJI?=
 =?utf-8?B?K0czbmx5OC80VitDc2ZYRlRmMldPS0pqSWxtQkNaUGJOOS9aWmFFeHo3RFV3?=
 =?utf-8?B?R3pHM3h1MkljM3dKYktkQzNlVFJETXRIeGJuME1JaG40L1hVekRIK1NxOXhW?=
 =?utf-8?B?YnVlb2JvOE9hbGVhZENzZDA5NTlvRU1WZTRLSERQZm9WWE1OSzdDR3BRanpu?=
 =?utf-8?B?MmlXK2J1aVdlSm16cUIwbkc5UUtiRmxmbmo2YXRFSlRjL1JWTCtCaDB0RWlK?=
 =?utf-8?B?cWRuazUwU1JLK0xaRFlyWnE0UzlNUHFRZjg3UElxb0hnUmo5SXY1TE1PdE0w?=
 =?utf-8?B?ZXMxZjd0R1Avc2xMVFUrZEpDSFJvNWhpMVFXRE1iRXk4NWVCTlpkN0RIRWZx?=
 =?utf-8?B?U1lja1d4Mk9UWHpLV2wzUUpYQmxXRlBPU3NoMVQ2Tmh4QkM1b1RpNFZGeG1P?=
 =?utf-8?B?Yk8rOWo0VU5lbEs4UGhuSkxXWVZvRVFTVEJNcVlucmR6OXZJd2o2bVRCWWdo?=
 =?utf-8?B?NWdBUHllaUZsbUxPZDVDT0RxcU9kdldUVmR6TFJkODVQMjZSKzQ5cFVZaEpP?=
 =?utf-8?Q?ue4Iv3artQ5S3IEF3dtwFZxwK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1654f018-8edb-40a0-3e76-08db6b6978b4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 17:21:34.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GanH/yDrLdg0Vn/gHwgi//F37/PmUx8UliqIdWdsMAQr4gXjew2dcel3H6v/j5FHvMtnbEo4JNj1Cpg2nGqJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

On 6/1/2023 11:28 AM, John Stultz wrote:
> After having to catch up on other work after OSPM[1], I've finally
> gotten back to focusing on Proxy Execution and wanted to send out this
> next iteration of the patch series for review, testing, and feedback.
> (Many thanks to folks who provided feedback on the last revision!)
> 
> As mentioned previously, this Proxy Execution series has a long history:
> First described in a paper[2] by Watkins, Straub, Niehaus, then from
> patches from Peter Zijlstra, extended with lots of work by Juri Lelli,
> Valentin Schneider, and Connor O'Brien. (and thank you to Steven Rostedt
> for providing additional details here!)
> 
> So again, many thanks to those above, as all the credit for this series
> really is due to them - while the mistakes are likely mine.
> 
> Overview:
> —----------
> Proxy Execution is a generalized form of priority inheritance. Classic
> priority inheritance works well for real-time tasks where there is a
> straight forward priority order to how things are run. But it breaks
> down when used between CFS or DEADLINE tasks, as there are lots
> of parameters involved outside of just the task’s nice value when
> selecting the next task to run (via pick_next_task()).  So ideally we
> want to imbue the mutex holder with all the scheduler attributes of 
> the blocked waiting task.
> 
> Proxy Execution does this via a few changes:
> * Keeping tasks that are blocked on a mutex *on* the runqueue
> * Keeping additional tracking of which mutex a task is blocked on, and
>   which task holds a specific mutex.
> * Special handling for when we select a blocked task to run, so that we
>   instead run the mutex holder. 
> 
> The first of these is the most difficult to grasp (I do get the mental
> friction here: blocked tasks on the *run*queue sounds like nonsense!
> Personally I like to think of the runqueue in this model more like a
> “task-selection queue”).
> 
> By leaving blocked tasks on the runqueue, we allow pick_next_task() to
> choose the task that should run next (even if it’s blocked waiting on a
> mutex). If we do select a blocked task, we look at the task’s blocked_on
> mutex and from there look at the mutex’s owner task. And in the simple
> case, the task which owns the mutex is what we then choose to run,
> allowing it to release the mutex.
> 
> This means that instead of just tracking “curr”, the scheduler needs to
> track both the scheduler context (what was picked and all the state used
> for scheduling decisions), and the execution context (what we’re
> running)
> 
> In this way, the mutex owner is run “on behalf” of the blocked task
> that was picked to run, essentially inheriting the scheduler context of
> the blocked task.
> 
> As Connor outlined in a previous submission of this patch series,  this
> raises a number of complicated situations:  The mutex owner might itself
> be blocked on another mutex, or it could be sleeping, running on a
> different CPU, in the process of migrating between CPUs, etc.
> 
> But the functionality provided by Proxy Execution is useful, as in
> Android we have a number of cases where we are seeing priority inversion
> (not unbounded, but longer than we’d like) between “foreground” and
> “background” SCHED_NORMAL applications, so having a generalized solution
> would be very useful.
> 
> New in v4:
> —------
> * Fixed deadlock that was caused by wait/wound mutexes having circular
>   blocked_on references by clearing the blocked_on pointer on the task
>   we are waking to wound/die. 
> 
> * Tried to resolve an issue Dietmar raised with RT balancing where the
>   proxy migration and push_rt_task() were fighting ping-ponging tasks
>   back and forth, caused by push_rt_task() migrating tasks even if they
>   were in the chain that ends with the current running task. Though this
>   likely needs more work, as this change resulted in different migration
>   quirks (see below).
> 
> * Fixed a number of null-pointer traversals that the changes were
>   occasionally tripping on
> 
> * Reworked patch that exposes __mutex_owner() to the scheduler to ensure
>   it doesn’t expose it any more than necessary, as suggested by Peter. 
> 
> * To address some of Peter’s complaints, backed out the rq_curr()
>   wrapper, and reworked rq_selected() to be a macro to avoid needing
>   multiple accessors for READ_ONCE/rcu_dereference() type accesses. 
> 
> * Removed verbose legacy comments from previous developers of the series
>   as Dietmar was finding them distracting when reviewing the diffs
>   (Though, to ensure I heed the warnings from previous experienced
>   travelers, I’ve preserved the comments/questions in a separate patch
>   in my own development tree).
> 
> * Dropped patch that added *_task_blocked_on() wrappers to check locking
>   correctness. Mostly as Peter didn’t seem happy with the wrappers in
>   other patches, but I still think it's useful for testing (and the
>   blocked_on locking still needs some work), so I’m carrying it in my
>   personal development tree.
> 
> Issues still to address:
> —----------
> * Occasional getting null scheduler entities from pick_next_entity() in
>   CFS. I’m a little stumped as to where this is going awry just yet, and
>   delayed sending this out, but figured it was worth getting it out for
>   review on the other issues while I chase this down.

I'm consistently hitting the above issue early during the boot when I was
trying to test the series on a dual socket 3rd Generation EPYC platform
(2 x 64C/128T). Sharing the trace below:

    [   20.821808] ------------[ cut here ]------------
    [   20.826432] kernel BUG at kernel/sched/core.c:7462!
    [   20.831322] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
    [   20.836545] CPU: 250 PID: 0 Comm: swapper/250 Not tainted 6.4.0-rc4-proxy-execution-v4+ #474
    [   20.844976] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [   20.852544] RIP: 0010:__schedule+0x18b6/0x20a0
    [   20.856998] Code: 0f 85 51 04 00 00 83 ad 50 ff ff ff 01 0f 85 05 e9 ff ff f3 0f 1e fa 48 8b 35 0e 0c fe 00 48 c7 c7 33 a1 c1 85 e8 ca 37 23 ff <0f> 0b 4c 89 ff 4c 8b 6d 98 e8 1c 82 00 00 4c 89 f7 e8 14 82 00 00
    [   20.875744] RSP: 0018:ffffbd1e4d1d7dd0 EFLAGS: 00010082
    [   20.880970] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000005
    [   20.888104] RDX: ffff9d4d0006b000 RSI: 0000000000000200 RDI: ffff9d4d0004d400
    [   20.895235] RBP: ffffbd1e4d1d7e98 R08: 0000000000000024 R09: ffffffffff7edbd0
    [   20.902369] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d4d12e25a20
    [   20.909501] R13: ffff9dcbffab3840 R14: ffffbd1e4d1d7e50 R15: ffff9dcbff2b3840
    [   20.916632] FS:  0000000000000000(0000) GS:ffff9dcbffa80000(0000) knlGS:0000000000000000
    [   20.924709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   20.930449] CR2: 00007f92120c4800 CR3: 000000011477a002 CR4: 0000000000770ee0
    [   20.937581] PKRU: 55555554
    [   20.940292] Call Trace:
    [   20.942741]  <TASK>
    [   20.944845]  ? show_regs+0x6e/0x80
    [   20.948259]  ? die+0x3c/0xa0
    [   20.951146]  ? do_trap+0xd4/0xf0
    [   20.954377]  ? do_error_trap+0x75/0xa0
    [   20.958129]  ? __schedule+0x18b6/0x20a0
    [   20.961971]  ? exc_invalid_op+0x57/0x80
    [   20.965808]  ? __schedule+0x18b6/0x20a0
    [   20.969648]  ? asm_exc_invalid_op+0x1f/0x30
    [   20.973835]  ? __schedule+0x18b6/0x20a0
    [   20.977672]  ? cpuidle_enter_state+0xde/0x710
    [   20.982033]  schedule_idle+0x2e/0x50
    [   20.985614]  do_idle+0x15d/0x240
    [   20.988845]  cpu_startup_entry+0x24/0x30
    [   20.992772]  start_secondary+0x126/0x160
    [   20.996695]  secondary_startup_64_no_verify+0x10b/0x10b
    [   21.001924]  </TASK>
    [   21.004117] Modules linked in: sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore 
    ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 
    i2c_algo_bit drm_shmem_helper drm_kms_helper ghash_clmulni_intel syscopyarea sysfillrect aesni_intel sysimgblt crypto_simd crc32_pclmul cryptd crct10dif_pclmul sha512_ssse3 xhci_pci tg3 drm 
    xhci_pci_renesas megaraid_sas wmi
    [   21.055707] Dumping ftrace buffer:
    [   21.059291] ---------------------------------
    [   21.063697]   <idle>-0       250dn.2. 21175635us : __schedule: JDB: BUG!!! pick next retry_count > 50
    [   21.072915] ---------------------------------
    [   21.077282] ---[ end trace 0000000000000000 ]---

    $ sed -n 7460,7462p kernel/sched/core.c
      if (retry_count++ > 50) {
              trace_printk("JDB: BUG!!! pick next retry_count > 50\n");
              BUG();

Hope it helps during the debug. If you have a fix in mind that you
would like me to test, please do let me know.

> 
> * Better deadlock handling in proxy(): With the ww_mutex issues
>   resolved, we shouldn’t see circular blocked_on references, but a
>   number of the bugs I’ve been chasing recently come from getting stuck
>   with proxy() returning null forcing a reselection over and over. These
>   are still bugs to address, but my current thinking is that if we get
>   stuck like this, we can start to remove the selected mutex blocked
>   tasks from the rq, and let them be woken from the mutex waiters list
>   as is done currently? Thoughts here would be appreciated.
> 
> * More work on migration correctness (RT/DL load balancing,etc). I’m
>   still seeing occasional trouble as cpu counts go up which seems to be
>   due to a bunch of tasks being proxy migrated to a cpu, then having to
>   migrate them all away at once (seeing lots of pick again iterations).
>   This may actually be correct, due to chain migration, but it ends up
>   looking similar to a deadlock.
> 
> * “rq_selected()” naming. Peter doesn’t like it, but I’ve not thought of
>   a better name. Open to suggestions.
> 
> * As discussed at OSPM, I want to split pick_next_task() up into two
>   phases selecting and setting the next tasks, as currently
>   pick_next_task() assumes the returned task will be run which results
>   in various side-effects in sched class logic when it’s run. This
>   causes trouble should proxy() require us to re-select a task due to
>   migration or other edge cases.
> 
> * CFS load balancing. Blocked tasks may carry forward load (PELT) to the
>   lock owner's CPU, so CPU may look like it is overloaded.
> 
> * I still want to push down the split scheduler and execution context
>   awareness further through the scheduling code, as lots of logic still
>   assumes there’s only a single “rq->curr” task.
> 
> * Optimization to avoid migrating blocked tasks (allowing for optimistic
>   spinning) if the runnable lock-owner at the end of the blocked_on chain
>   is already running.  
> 
> 
> Performance:
> —----------
> This patch series switches mutexes to use handoff mode rather than
> optimistic spinning. This is a potential concern where locks are under
> high contention. However, so far in our initial performance analysis (on
> both x86 and mobile devices) we’ve not seen major regressions. That
> said, Chenyu did report a regression[3], which we’ll need to look
> further into. As mentioned above, there may be some optimizations that
> can help here, but my focus is on getting the code working well before I
> spend time optimizing.
> 
> Review and feedback would be greatly appreciated!
> 
> If folks find it easier to test/tinker with, this patch series can also
> be found here (along with some debug patches):
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v4-6.4-rc3

I'm using the same tree with the HEAD at commit 821c8a48233f ("HACK:
sched: Add BUG_ONs for proxy related loops")

> 
> Thanks so much!
> -john
> 
> [1] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)
> [2] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
> [3] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: kernel-team@android.com
> 
> Connor O'Brien (1):
>   sched: Attempt to fix rt/dl load balancing via chain level balance
> 
> John Stultz (3):
>   sched: Unnest ttwu_runnable in prep for proxy-execution
>   sched: Fix runtime accounting w/ proxy-execution
>   sched: Fixups to find_exec_ctx
> 
> Juri Lelli (2):
>   locking/mutex: make mutex::wait_lock irq safe
>   locking/mutex: Expose __mutex_owner()
> 
> Peter Zijlstra (6):
>   sched: Unify runtime accounting across classes
>   locking/ww_mutex: Remove wakeups from under mutex::wait_lock
>   locking/mutex: Rework task_struct::blocked_on
>   locking/mutex: Add task_struct::blocked_lock to serialize changes to
>     the blocked_on state
>   sched: Split scheduler execution context
>   sched: Add proxy execution
> 
> Valentin Schneider (1):
>   sched/rt: Fix proxy/current (push,pull)ability
> 
>  include/linux/sched.h        |  10 +-
>  include/linux/ww_mutex.h     |   3 +
>  init/Kconfig                 |   7 +
>  init/init_task.c             |   1 +
>  kernel/Kconfig.locks         |   2 +-
>  kernel/fork.c                |   6 +-
>  kernel/locking/mutex-debug.c |   9 +-
>  kernel/locking/mutex.c       | 113 ++++--
>  kernel/locking/mutex.h       |  25 ++
>  kernel/locking/ww_mutex.h    |  54 ++-
>  kernel/sched/core.c          | 719 +++++++++++++++++++++++++++++++++--
>  kernel/sched/cpudeadline.c   |  12 +-
>  kernel/sched/cpudeadline.h   |   3 +-
>  kernel/sched/cpupri.c        |  28 +-
>  kernel/sched/cpupri.h        |   6 +-
>  kernel/sched/deadline.c      | 187 +++++----
>  kernel/sched/fair.c          |  99 +++--
>  kernel/sched/rt.c            | 242 +++++++-----
>  kernel/sched/sched.h         |  75 +++-
>  kernel/sched/stop_task.c     |  13 +-
>  20 files changed, 1284 insertions(+), 330 deletions(-)
> 

--
Thanks and Regards,
Prateek
