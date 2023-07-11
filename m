Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8E74E47A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGKCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:52:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF6E4D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8NfL9H37lsRqqp2JyzeY0xb+WajP5GPzueEua6lpsyGNgsdGeM8qGm/ff3kjUVqaoJUyQqHiIjrvr6b4MPs8WrPk3Z73bKGYwCTjUqAPpmsaAh7Sqo8CdBKt3iu3Thn+900sqpJGXCvmas/O/6ZidPEiytHh7dL6cCm9jbb6O5mlHoA/4RUi2oid0r2v1aPbJWkD1jJlZFrecpR8KnWafiQcliB8YKSGD43hAsBVfCdtO1hnZi/LPkILgOhzy1gFvehPI4se613VgI1P5McDdZ9+0gbuvyl7Gq9SAMG5tUkWzQ+xDQdidQRJD3EZUysxczEo7bmk/rxDSbZ7FyFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZCVf0l/wzi0zDe7oNm8DY9uqX+1kMPU4P838APbkgM=;
 b=XQGow7qClzced5Vt0QBKChmYCH9TlBp/VnfMgOzklopwcgF8aAnzN0fe/GuKkRE91bqBH8+2uhU+1cKe8WMzJRYjsY2HYFK1oUrtd96rKYvv/gSRFOwJZ9VyXKX3DS6mVdU3CxSdoZFDoKYSu9Ms2D7N48nDhfhz7/ACvXr2fFdfJrfRnv8f03VgtII1lPz5I7KnAX1tD9cOXSOTKm4h/g9CQvW5iLdz1VRxAa+5iFA+UEkHGtIrnwoAuV1XS3BAJQI5la1VYhqA3NwXS9UKryCSOSWS1cBGwy+WT1m05pacH2VoLvLu0+umjo6+d0OYM5qdXFngjyMCd7LCB1wDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZCVf0l/wzi0zDe7oNm8DY9uqX+1kMPU4P838APbkgM=;
 b=bQY4LIoZ3QJVrtCQn6vmuveXUtvalyjIgtgCKJ4l75vfr8H1v+AFE8BJS/ka8WCHrC2efc1bpGmIbEyxOAj1UYxRNGifvBPwt1EXL3LGOfTVaTHvxrYf47DjvebIloF7oDbgGVlu6KQcigOMhX2aJLF2FP5MC7adPQn0s+pSP6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 11 Jul
 2023 02:52:27 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6565.026; Tue, 11 Jul 2023
 02:52:26 +0000
Message-ID: <978efacd-ede6-fff0-49d3-77bd39590666@amd.com>
Date:   Tue, 11 Jul 2023 08:22:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
 <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
 <7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com>
 <ZKwlomD5Xez7TRhy@chenyu5-mobl2>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZKwlomD5Xez7TRhy@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c469ea5-51a8-4684-35bb-08db81b9db42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQP67ye9LRrYiBzRngpR6O/wRVPOgOP/ubbeqP/vgtqKFCpIDPgD5YqSDFpzkVh4aSSAq79OH2GB1vtsWDTUAuppA2bQ0sveNeEi/uguogndMG1lLLX3GvM2U2K4AzjoavIzkeUE74gZRsDN0ZgemM6exS9Ht0kEoeMOkquarmxz3/N1iHcOqGbGwGDJeCsJOBUBrlxg1J7G9743c97oUaCU2bxd+izhQNCdRdOa9xS5zstnI1fDWCgBsRwd08QataGR38JGCP+5/qg6GB//TU+bDn9Di426Qikn3fGJv1T4+21uQj7d8uuwCOKvvDpub9QiGV9o2bzNg2saIn+DT38e2CEf1Eokb8LjDjt/gfKA/FD0ww48jNeYkh0R0784wPgz7vyNAuAGJkijFcuC+LP+oZN+c7WLXx+DwJmNb41hoTxWgR9ugqGf/kzMkKtYXk1fAdkXbr1tKRcYZaMXh0ng0QwjB9RGqCzA65cmLQ/znQiUm/mh34Mr0AHanfknCZY2n+5xc8v8ELC0/HgTAPHXJ7DDmMtrfp8VZDNgaAPoCKnQzZ9I722ZoPevAaNjWqcOlm5jCqiLms+b8wLickbwr7nbNEM8cVIQq6wjYGUaWE7UTxvZ1iXu32CBGPGu9N8QQbiUGOx4kPPvnFNp9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(4326008)(7416002)(31686004)(2906002)(36756003)(66556008)(478600001)(316002)(66476007)(6916009)(66946007)(8676002)(8936002)(5660300002)(41300700001)(6512007)(31696002)(54906003)(86362001)(38100700002)(186003)(6666004)(83380400001)(6506007)(6486002)(26005)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdUd0o2TzF0MXkzQ29VZEk0QW41aGc3K295Z0lUTExFTGRGank5QjJLVmRB?=
 =?utf-8?B?WTZNL1U0UnEzTEVBZ2pJbFdEZDFkZG9Lb0RZQkVkZExKSkRmWjdPd0FLQXJs?=
 =?utf-8?B?VDhFNWFIUlMrS2xtLzMyTklHWG1OUVN0a2RGd3FpWi81UElISkNhZllwSFRs?=
 =?utf-8?B?a0taMlFEemVEYjByTE55N2FZMUZZbjRodkxoMmZ0OVowY0RLV1I4S3ZUVU1z?=
 =?utf-8?B?U0FUTG9DMFJ6WkJuV3NwdHNLZXBxa1JXTllSTUVLYldObmREOEZiaU1rc3Rw?=
 =?utf-8?B?STB3WmdkUXprcUphMXpBRjl1cmF1VWF4aktUQkEyUDlVcHdNUnRuT2d3NW9F?=
 =?utf-8?B?SzBFYXBIeW9kYnd0dzdtT2d5YTVaTTUzNHdYaStaVXdmZmp4QWJpdEpKeWJ6?=
 =?utf-8?B?cGRjR3VtSFRPOVc2WGgyeE9GSDR4Sm5FRUFpU2RBSjFveTJidkw1VGhmejUv?=
 =?utf-8?B?bVBzZEMvOEFGT0YrS2thVk8vYUd6cElJV1dvaXdxV2ZaLzI0bkxpZnl3RXlQ?=
 =?utf-8?B?RDh1Y3owVVpwYjZzYVlMOGxobTRRU2YwWHVJWEI2bTBUbDRoUStIVGhodERl?=
 =?utf-8?B?R3d5aVg4b0FnYkU3RnYxQnNpYVdlZ1JlbUNCS2dRa3NvRk8yV3BITVVDemYw?=
 =?utf-8?B?cmtmM2xRQVNGSGRmT084bk95cEZiZkhsblFPaGlQOHB0MndROVZ0N0thREVm?=
 =?utf-8?B?Y1NjMjYzdUdQVjB5cHhpOUNsZEMwOFRHK2tXTEw4bzlsRHRUdEFva1hnZHBs?=
 =?utf-8?B?NTNSMTM5MzMxNlljeG1WRUlKalhESHFpM2RnZy9waFFQOFJ1L0dvNFJiMHg3?=
 =?utf-8?B?d2NlcFE1ZjA4NXdrYmRVaDAyS3lZT0l1Q0NYbGJJMmdsMm40REZWcXNxOUxz?=
 =?utf-8?B?TEVrRmN0TmFuVENxR3h4T2p0UE93bUd3bUpiY3RCc3M2bkdEQkY1dStQUm1B?=
 =?utf-8?B?dUtGODN5dmhEVkNsSWQwcjM3T2RrU25MMU44QU9GcktvMFlXZlJCZ2x1RjlX?=
 =?utf-8?B?Z28xaW1WYXd6NHFxaXNkaWp4ZWJFUUp6Y0VhRm5ndzFiNTJac3lxM1NyMjU1?=
 =?utf-8?B?aS9DSHl2QUlTNHBwOWExb2hxbEoyeGdFZXRyclRXZ2tjL1dtRllkNGcvWXRL?=
 =?utf-8?B?SytGcUFPOUJSYkh2eko3MmN4T0pJdnZYT1dqZjREWUwvYjA2UWlEdkVienN5?=
 =?utf-8?B?OGFXU1dlOXNGM1JlVkR4NXV5SkxhYVNudWNndUhob3ZKYUlyd3hvQzFSS2FG?=
 =?utf-8?B?SGxabmNmMlk5d2tWZ3M3VGR4RlFqUmVqcDltK3RrZFV0TmRMaWZNOStJMmNI?=
 =?utf-8?B?cGJqOXM2V29iKzdZMHQwcGJmeUVEQzNhUzBWdUtwYXZnVTk3N1VDbGRwaTFr?=
 =?utf-8?B?MXJaYkFBMXBIQmlGRGg0cjZZS3E0V0oya050QzRVYlNCa3N4K1ZzVWFvKyto?=
 =?utf-8?B?VjhDWXYxbGY3aVNqWUtnNlVwMjhSK3o3d3IwYWZDalZOaWVZZ0JTMFhsUGxK?=
 =?utf-8?B?Rkc2enJGRzhjaGNFdDRyU1E4UFA1amIzYzRCTkh5Sk95azJZMTQvd1NBYU56?=
 =?utf-8?B?RnArakQyM1NJNGxISEpRWVJyOG5zeFJIaVZaTmlXN2R6RVEybjhJNUZvSEg4?=
 =?utf-8?B?L3RUZDVQT2p3bVFlLzZNOFFSVDFPaEh0NXp6Y09FQU5QUTJPcXkzNlRXUU9u?=
 =?utf-8?B?WUtSK3FGWDNxY0p0MERqMXlUbEpITGhXSGtWZzJvTDhuc1dwNWZmbXRBd013?=
 =?utf-8?B?Skc4Y291QUFMTkZXVVpzVng1eW1NQmp6RnhiNG5hdDhrbjYzT2FWYndkWU00?=
 =?utf-8?B?K1BmUS8yRGVKbTZDdzJseUpqUUdYY3F3dmsyeHRPdHdKYkx2RFlXSk5xNEs2?=
 =?utf-8?B?N2pQWXhSQ0FGSmwzM2p4VWx2bXBMY0s3NkhuVENDdHdXRzZSUkRoWG43L3Vy?=
 =?utf-8?B?R25TbGZhYWJqcEo1L1U2ZmkydGdmTWNrUzFyM2hLL2dWK1dIUTl0YnBYVmta?=
 =?utf-8?B?TnVGNnptcTYydTlaSjR3UEo5VkU5c2ZGeThCS0VGNSs2VmtVV0tvaHpBWFhF?=
 =?utf-8?B?eW9ZcExvQUNYa1FFeFoxVCtDLzM4WEcwdS9sbFV4cndvMTVvWkhMYzdlbVZU?=
 =?utf-8?Q?I03xt++ma5IMNvPhfNViT/7lL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c469ea5-51a8-4684-35bb-08db81b9db42
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 02:52:25.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fQuMsmcwt1LFD3/JXtvV1Nb3mcowoWzMIOIeptwnEFEMfqdD73bqMHoTxJVL/JyFUWzu2JCH0ye591ybx+eKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you for taking a look at the results.

On 7/10/2023 9:07 PM, Chen Yu wrote:
> Hi Prateek,
> 
> thanks for testing this patch,
> On 2023-07-10 at 16:36:47 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> Thank you for sharing this extended version. Sharing the results from
>> testing below.
>>
>> tl;dr
>>
>> - tbench, netperf and unixbench-spawn see an improvement with ILB_UTIL.
>>
>> - schbench (old) sees a regression in tail latency once system is heavily 
>>   loaded. DeathStarBench and SPECjbb too see a small drop under those
>>   conditions.
>>
>> - Rest of the benchmark results do not vary much.
>>
>>
> [...] 
>> I have a couple of theories:
>>
> Thanks for the insights, I agree the risk you mentioned below could impact the
> performance. Some thoughts below:
>> o Either new_idle_balance is failing to find an overloaded busy rq as a
>>   result of the limit.
>>
> If the system is overloaded, the ilb_util finds a relatively busy rq and pulls from it.
> There could be no much difference between a relatively busy rq and the busiest one,
> because all rqs are quite busy I suppose?
>> o Or, there is a chain reaction where pulling from a loaded rq which is not
>>   the most loaded, will lead to more new_idle_balancing attempts which is
>>   degrading performance.
> Yeah, it could be possible that the ilb_util finds a relatively busy rq, but the
> imbalance is not high so ilb decides not pull from it. However the busiest
> rq is still waiting for someone to help, and this could trigger idle load
> balance more frequently.

Yes, I was thinking along the similar lines.

>>
>> I'll go back and get some data to narrow down the cause. Meanwhile if
>> there is any specific benchmark you would like me to run on the test
>> system, please do let me know.
>>
> Another hints might be that, as Gautham and Peter suggested, we should apply ILB_UTIL
> to non-Numa domains. In above patch all the domains has sd_share which could
> bring negative impact when accessing/writing cross-node data.
> Sorry I did not post the latest version with Numa domain excluded previously as
> I was trying to create a protype to further speed up idle load balance by
> reusing the statistic suggested by Peter. I will send them out once it is stable.

Sure. I'll keep an eye out for the next version :)

> 
> [..snip..]
>

--
Thanks and Regards,
Prateek
