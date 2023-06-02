Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9471F999
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjFBFRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:17:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99E19A;
        Thu,  1 Jun 2023 22:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIufvs1s8PWkEKaAxflek7q8H3TNnRQ5EH6jtTf64MvsL+R97Seio9CWDAEJxoi0a2KwyjfwsgZHEVXwPTrKtwVWM5PbS4lC3XMbWVqYbk54Vj9fJ+P0Ca0zVqSjDKw5bJIjxTCs53VNBRgN4rlWyMP6S1MVYFQ7N9Grqren3UQ/DtRw4TdloerRCRB+tkZZ9GZguhBSOl/ERB2nAFQqR6trg/v1WlLKURRDxRdu6w94e2zgYnVUkDSfdBgpd8VJOz6fX6PbAZEm3JzlxjmcxWELYQcrG+9CjpBOLleJSQYg+cwkb4XuFeIsEC8E5hnrB5P+ATCj1477p/mSdyu3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq9IrE0HYr4RXDpfcnj5a8Vg6fK+aVPUazBGLpNy4dg=;
 b=CZ+sgZviNRV+0AQwCNkYbkkHfCZBRrr+229rdKU50F0xl53RNhLVHqvtdJV+nyrYb2ZXpPpVhtt+vlWOpujIQcuP5F6bd+MaF0GKwmjKFWkE5XgBtFan7ST0JDMcpPtRNBRndFkXVrLajftAZLrpU9ZpWH47VoWW/LGIJQ0niFZWKUGH90mMO40+6n2bvQDL+WOa2Gv542HzOdeP6kNhxqPb0ePtTDMWs7wFIRz91ZuLq4paHMV8izmxZcrljSqnXCjB1HNdWugoJbGB1Qha5bXZX++P1v4eg6FNlWPs540DLDYuCSTijlfwVolR9nen0ieW/Kf6PWJwY49U7yZybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq9IrE0HYr4RXDpfcnj5a8Vg6fK+aVPUazBGLpNy4dg=;
 b=esTyLQrZfnHyOJQa06QJt/CXFQSYetGztMn9QXZ5KADJemHC80xu1Yupi+ddlKc6z+GMAxTJIIkGLOqLSz9j7aVt/88SXOVFrn9p2QGocm64x1seYOf4fKnoeHxmDI0gUPVmpVfHv/Q47cxaxv2/pplvYeDZTYkrSNbXfx9w3Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 05:17:17 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 05:17:17 +0000
Message-ID: <a78b5df0-2374-29bf-f948-3054f1e7e46c@amd.com>
Date:   Fri, 2 Jun 2023 10:47:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601145113.GA559993@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230601145113.GA559993@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 7320322a-fc0e-4708-e24b-08db6328a235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQhIYRcd29DE0Iee+mGslaUpH0X5ovisoQaA/mwRLInwGjQxiDvLMP1zx2MRji1kRrraNmS1mpUEndRWqOoeO2SCczbgZH3vyyipqn871jlqWzKGVmicdbSVKEOGVv7mc8TuD1sP4LJkf+Z1D7UX3HpTPUyHvy54zVJ7NQigbgZmZ9VR2OteQuq10rW/Z/3Wb7ye3OdaMHoF7D+4wnXzLFeeojDLaLs0xZE8tkt3AZizVsfLEVZVJgRYXDdAaoNzm5EfGdy6eYWQ5xfILhhEpCWxlcG0Ghw7nZS5TR0KQ88rnxga0XFppTLaXerrH0bpZw6iq9qSSMBRbDVfjr1i7NVXxl6uXxxqhk5Ci29//LjrH30b8q11bSewxSr35MiI/U8yxLeA3a0LC/gVqd5NlhyHS2dhhkRHhi3Igkv6Y/QOpZdoQPd5cHZBOR4uFt2alb4VHKht2A1/udQXwSsZj1bS+ojhUVG14kecOoJjvBBR6D8eXd1Ngmarp6mj//FzGuQmBa+mDEehzWnqA6csA323/xjUhXhYzQjq6FIusJUvf5mDaPcIBYJ/pT02bIcz9WuF0FDeUGozArh/J2MDLXgDJ16Y008Mdt+bf8mTHFmsmGG+y5avevdMZmYWaDYA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(186003)(316002)(2616005)(31696002)(26005)(38100700002)(6512007)(86362001)(6506007)(966005)(53546011)(83380400001)(36756003)(6666004)(54906003)(478600001)(8936002)(8676002)(2906002)(5660300002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNyVmRad2o3NUNPZWlZQTZKL3NBc3V1TTlmM0NwZEZFQng4cThJVDIwMUlU?=
 =?utf-8?B?U2hIUEhVaEd3eER1ZmFWbkhudUFaNEdiU1pLTlY5c2hDakZqVnRvaFBBdmo0?=
 =?utf-8?B?YmpVczViNVVFOHZmRkltanRreHlXRTVqSFRpOHc4U2lpczRqdVA3RHBoajNk?=
 =?utf-8?B?NG0zak5SeWYwRlhSVGNlb0phSlBCQWhxN1dVSFhZR0FCUldzOFdIVWpNWmlr?=
 =?utf-8?B?NzMzMitjZ1M5cFliM2oyWUQvbk0waFYzT0o5NXJMTWpBS2ZjUmo1UDJrWGZX?=
 =?utf-8?B?bEMxeXB3T1FXQjdzdFRUQVM0LzY0Tzk0NFFrOUFya05yK0pPSEk4U3d5bHll?=
 =?utf-8?B?Mm9IaXJvdmxwWU5HTllvTjRleHZpMnJKVnFxdnBLTUdJY3dwbElDYU5kUTYy?=
 =?utf-8?B?UVJ2VkZMcTNLenJrdU95c3U1WW9PS2ZZNGg3bW1xMmUvR050cXZaNFppWXFz?=
 =?utf-8?B?RHkvcm5RK3JMWERDTWVZTFBEK0RHTDhtY2w4c0xDKzhSU0xqbVZKM28vNjRn?=
 =?utf-8?B?RUpSZmtvejBOV2hRYTBwbE5vWnVSN2RyanEyL0kvblgzVVN3b3BFc3ZWb1hB?=
 =?utf-8?B?U3BZUGhVWWtiMEhKdFc2L0RGYUo3OEhQWkNRdXdYQzEyK0dyUVhjVVZrazlr?=
 =?utf-8?B?WU5Ba0hmbVpwWnJISjZTdmx5RDFNL1VSdUZjd0RQNUNWWnJIbW5sUHlyNy9Q?=
 =?utf-8?B?U2FsQ2tlei9tMGgwNzYyazRxWVFnMTlvck5pc1hWQ3lISUQxTHV1OXQxQU44?=
 =?utf-8?B?OVFoTUFuZkUybU9EMzN6aE9iT2lZOSt0dzdlRlc3clBDV3I5Z3pVZFk0dWZu?=
 =?utf-8?B?N0pxQXhIendjcHJ0dVRNYmxlS0cyVjBpbmJKY2dlRCtQZ3NiY2VZdzhqK3RP?=
 =?utf-8?B?N2djclFpSUpCMGVqQVBhemYrbGplbEl0SDJrVGoxN2Z1VzdPOXNpSDZnV2Z2?=
 =?utf-8?B?WDhmb1phVjhKd0ZhMEQ2V3NzRWFSQkdlSVFwVGIza29RVEdUWUJCMzNWamlS?=
 =?utf-8?B?SGJFZlpJakRoNmViMGtBYmdKM2VNRHRBTEtvUStPVDcxSnBXQWVmQjA5cTdX?=
 =?utf-8?B?V2c3TGF6MU9ydVd0SENvUUg4SkwrbWZkeDRqcjU4SUd2YmtZUk04UHY4bTlt?=
 =?utf-8?B?NWxGODRseWErNUpWZnMvME1BaGV1UmRrODR4YmxvN2dHNlp1MXlybmtWZGor?=
 =?utf-8?B?bzBBS1NqRjhBUHRsRWZwUnU2UHhoOXJMSnpjQ01EeGRiRVZNMmZVVG5TRkhi?=
 =?utf-8?B?WEFqYkw0WDFDZ2ZLdXRFclB5eHRTVGRCaXphRFptRHI2MHNheU5ib1FFTnFi?=
 =?utf-8?B?RnVWaHNOUllIelUvckRVRkgwNnNkeEJNUzJuYnUvbC9WYkxmb1lDdGJ5V1NY?=
 =?utf-8?B?N2tseG1kempNQVBrUjJQQ3lybWhhYStjbjJyREQvQkV1L0c3VUhTZ0tiQzd3?=
 =?utf-8?B?cG1aZ0IyMmIyY2xkRUZQSmNob2dPckY4NXdZOThyUW1RMkVGcno1WktPVlJm?=
 =?utf-8?B?a0xnc2NQYXpvZVZHSXRuL2lLYzE5NVlZODBtK3NaWXVvWm4yT0RjKzliL3Nk?=
 =?utf-8?B?c0dsN2NMQ0xSWGZkSDVtTjZFVS9SRXE5Q0FsL3h2YXRkZzZKUWRLZnhEa0sw?=
 =?utf-8?B?cXJjSHpaQzlGR1QvZElMSHhVdFN4NmNLd3l4ZTcyVWFHL2YzZStrMWE4N0ht?=
 =?utf-8?B?Z2h1VS9JeWJ3dTdxcld5VFQrcWlnSTAycHViS2dNenlKNjVNV3MrY0xFb28z?=
 =?utf-8?B?bXFqdWlWY3U3NU1NWFZlR1RHcnpJK1dZYjdGWFNoTStJYlZ5QnBNOWV6NEFQ?=
 =?utf-8?B?dW44V04xYzJhWktrclNPOHNqMGZFVmRKU21SaS8xVUFaUmNFQkYxb1krUU5p?=
 =?utf-8?B?aE0wYll2THRXdElDQ0pOajVNaEtnN0lzR0hUWWsxeWI4bk9JdVI3S254YjFP?=
 =?utf-8?B?UFdad1lSYkxGQUc0Z0lvbG5zdVZwRUxTU0NRZWpiVTRxZEtKd3VGL3owcnc4?=
 =?utf-8?B?V3ZxOElWT00rbzNiVWNVL2ZadERzVmNWWmJrYzNINHhKVXlZSVFuYjNINE45?=
 =?utf-8?B?NVZZQXlrVTM2eElQZTV4S3JCTWY2VDJlNXJiakZNcFltdmF6Z1JhYis5eEZO?=
 =?utf-8?Q?7OW0vW28j2pAkuFIwws9FuN7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7320322a-fc0e-4708-e24b-08db6328a235
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 05:17:17.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYw+uAg+HGGuWqjaW518rBAYOj/YubfeIJpty5V77CTOgZcA+w15wqgmDhnKtoHWrfiPfPEFhJzuWWL14sRSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 6/1/2023 8:21 PM, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 02:00:01PM +0200, Peter Zijlstra wrote:
>> On Thu, Jun 01, 2023 at 01:56:43PM +0200, Peter Zijlstra wrote:
>>> On Thu, Jun 01, 2023 at 01:13:26PM +0200, Peter Zijlstra wrote:
>>>>
>>>> This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
>>>> isn't too much of a bother; so perhaps something like so?
>>>>
>>>> (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
>>>> this patch and force pushed the thing)
>>>>
>>>> And yeah, random hacks and heuristics here :/ Does there happen to be
>>>> additional topology that could aid us here? Does the CCD fabric itself
>>>> have a distance metric we can use?
>>>
>>>   https://www.anandtech.com/show/16529/amd-epyc-milan-review/4
>>>
>>> Specifically:
>>>
>>>   https://images.anandtech.com/doci/16529/Bounce-7763.png
>>>
>>> That seems to suggest there are some very minor distance effects in the
>>> CCD fabric. I didn't read the article too closely, but you'll note that
>>> the first 4 CCDs have inter-CCD latency < 100 while the rest has > 100.
>>>
>>> Could you also test on a Zen2 Epyc, does that require nr=8 instead of 4?
>>> Should we perhaps write it like: 32 / llc_size ?
>>>
>>> The Zen2 picture:
>>>
>>>   https://images.anandtech.com/doci/16315/Bounce-7742.png
>>>
>>> Shows a more pronounced CCD fabric topology, you can really see the 2
>>> CCX inside the CCD but also there's two ligher green squares around the
>>> CCDs themselves.
>>
>> I can't seem to find pretty pictures for Zen4 Epyc; what does that want?
>> That's even bigger at 96/8=12 LLCs afaict.
> 
> Going by random pictures on the interweb again, it looks like this Zen4
> thing wants either 2 groups of 6 each, or 4 groups of 3.

I would think it is the latter since NPS4 does that but let me go verify.
Thank you for digging into this and providing the patch to extend the x86
topology in the thread :)

> 
> But you have the hardware, so I'll let you figure it out.

--
Thanks and Regards,
Prateek
