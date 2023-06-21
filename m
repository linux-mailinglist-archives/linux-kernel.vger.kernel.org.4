Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9363739246
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFUWJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFUWJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:09:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2093.outbound.protection.outlook.com [40.107.95.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97FE57;
        Wed, 21 Jun 2023 15:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsf8PpcBD240bh9jvR6EqvhIIKGkBMB//1Sn/vym8qGwLiQvVnRAaQaIGrv0zJO23Qir6E3dybE7K064wXnse/q8tP+cmUubgVLwhSCttaEexGHa/NEFFzcDBAd/EY9Ak8m/S3ZfVgzrWbb7IVImyO0HoJWG0fO/Z2ELqTLDrCjjd5LsIjCc80f+8ngRTd2oN4GM5IfRRHOk0Urzh/V/W+06fpgnvNg0wq6JBT6zLGTC3R5j48FvG2++68V5lZzZqWEZ4ROaasxs7/witKM2nM5/DCer1bjrSSGivTWd5SAQOCNsdO7mAV8wajlJxOMAcnvLFeljekdFucPNBT/HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccb6rw5cj3cqw5dQwqpySrtvKRidsMiz+jAvsI37mII=;
 b=DPJhE/vcyS9bDOYrWdjjEWY3SHgcAzKqsSRnGAF7mYOeoaPqfc+3ckm5DOjZz490anEqCNX6/VCH2uXuTTYxFopkA9EplUOb32cHckrpOmycM9tD4cG7Vj8isetEqgj4WlIgPEwzxAXqM6AOTWwNbKiA6WLYOrajq8zU5tz/wlGN46QnNHEp625JLXlqnou0wllGHk+3JbRVnQ3+gSAk/J9VdPvCohPdRCEqWPQZze+2eroU9vwSYFEMQTgi3upMpEjRoOOKYk9//MheS3ZtFsT0z9wOV7+6Aq6jTbVZEIOxxXIopRADSn01pbQnHBkTYkWxaFhDoihXF5xkElFgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccb6rw5cj3cqw5dQwqpySrtvKRidsMiz+jAvsI37mII=;
 b=snTzpO9/fWF4orFJ6KNkA7by1LisCeCiuawjbkMRmSZY4YJscnJY43rlNFjQ1zUvbuFqcqTd8gX1uOUxihtC8oEcuFoGwWZ2sWxZnNAHS/jYTfOs0kherZINbk/TGb+rLRcnJGHpkf9/rd8zjM/cIyHwhB5xIEE7WV85HPYzbX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB8110.prod.exchangelabs.com (2603:10b6:806:33e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.35; Wed, 21 Jun 2023 22:09:13 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 22:09:12 +0000
Date:   Wed, 21 Jun 2023 15:09:00 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] perf: arm_cspmu: Support implementation specific
 validation
In-Reply-To: <7a8c0ac8-4e5d-fd55-92bc-c42064d34a66@arm.com>
Message-ID: <27cd7bbf-bec7-2a68-1a90-55e764cab0cf@os.amperecomputing.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com> <20230607083139.3498788-4-ilkka@os.amperecomputing.com> <7a8c0ac8-4e5d-fd55-92bc-c42064d34a66@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:610:55::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: cd36a853-ba31-4534-a39f-08db72a424ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVh4vXTVDRpK4DXZk9MmcLCOKXb/4AwkPmvfqg+wqya4U1PQmfCwqi2PSnCcQ04MJdf97FJRsb5pO7Lj89bFqNBla3wUv4PiwI40biPOGYknueEvhh2NjtNsXP9i4qzV9/DaGHBo3/SXIqbSpSleSjb7zqUGFNb5NyFcBXM5Ys6iq/cWK0qT4XaZpbwD7T9VZBweUCAiLiHlH3N78bMuonQsZshalMBRi+l3AS/GuUn5wd4OrcytOktjgQ68ysU1Ybefsb0MaE8TgpmV37jcdpX0l7VaYPVYtqW1sXHGrf633UYsBd8s3MX7aQH1EwrXvqbggsLdE+ZrjMq/8qX1+d4C0e9VFSlnLGX+UoC1bNHvD6j0Pu+vghaAkKBdhX1Cd1HddDkHjVeUPKPUpIMwkI1IFlLKtAzmZVSGy2Z+SDVUwyLd2ZHkiSKw0wSlDZvKiZ7KS31seEG2RYLqQW7XZoSPz2AAmhkRrlfhYp5Trze2IAjBtMYZlYWXQGLRx8oeYJv3+YDaKiQjxfgV2q59D2XCVqxpGw/wysUYohBYGWTUP1bK5X9Gx0uFsdmAo23bgCW7dSSYydEW4b0U4EL/JRk5P6kspm2LMSxqoFhHNC10Sq4O5UMAc0qmUJHiu68I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39850400004)(136003)(451199021)(38100700002)(38350700002)(31696002)(86362001)(52116002)(6666004)(6486002)(53546011)(6512007)(186003)(26005)(8676002)(6506007)(8936002)(5660300002)(478600001)(31686004)(41300700001)(316002)(66946007)(54906003)(2906002)(4326008)(66476007)(6916009)(66556008)(66899021)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ug0ZTPnJdHastPDCSFDwDj1RDYKYRJVMRjEODFr52RGTSisvr9WTle4rXt0k?=
 =?us-ascii?Q?ZFZO4k/WUm4TFAh+CDd1u6/c384OVDNFh32lOwlml31xeWINf0P5Gkfja1bv?=
 =?us-ascii?Q?ThhBJId9K9Zu98DK9uipv46fxBQACJ2i+AeV9JxPtIkvUnBp/F/mh/Wpz4sx?=
 =?us-ascii?Q?ID1jb2loERKS7ib7YvROUb8euYwjoSPS9PBul5p967SjZmlBlCUOuLPOrIc8?=
 =?us-ascii?Q?qbkvGb+3kbpoj20PtP2isJ0Dd9m4E4LJOBYUybrZXa3gtuQWR/KgYx+3yx2f?=
 =?us-ascii?Q?xHO/QknEB1mDjeuanYALO5IAORMgtC/g6hEOFP16VmktI9HwTvQmwPrUsE8s?=
 =?us-ascii?Q?Celt0wj/lwZkia/uV8e+ou2+XWFDKkIvo9mXhQxCD/WaxUixw5iBnhpZPPrC?=
 =?us-ascii?Q?+X7iv1RTgvWzC00AsXInSuCHrbhfQt/jSCP9v+FxyblEZNwPYPiVIOtp3Xz/?=
 =?us-ascii?Q?FAftJdbDiUIBnz3I448yfr3C03uLrPE3+XeRRVQCjAR3MmaZGuN28Cn1Q68O?=
 =?us-ascii?Q?SDRQo/Z5ILGjN8Izp9vnKHcWMNqHztIfnYmKGpC7rg1i88+Nl+nvkxCooogq?=
 =?us-ascii?Q?Zdg5mubR2mh6rl3Z52nNQtwivWhIIQ4N5REzAPCnxG8vtZ6zp9Rdh7FcfzQ6?=
 =?us-ascii?Q?ezzxnbcg/wtMQW758dMzOBOktOheTE0JqR9tJVUF6gRkznMCYKENxnFTlQXT?=
 =?us-ascii?Q?lkBHQvPJ3SGKP9l4jYZLz0NZsVlERBrIJVlblA1K3YY0KZ3NPz6opGGBN9n4?=
 =?us-ascii?Q?QqSDzSVIbn5POii32P801xoc3IESBOyUduoE+JhEGfq7qpVkY32/TIB2SwGQ?=
 =?us-ascii?Q?AKvuiJCZwowZQ5+nAjs82AE5Q0xNn8JdeoUXoiwhRdNlkoalKecvN1F9s1Tj?=
 =?us-ascii?Q?QCPpK6955miMvy9URzjVXdxaB6Zs9ZMvEc4vCZvwGiHyqw+W+YvyzwXGejb8?=
 =?us-ascii?Q?TyS9Wz3UiRdV9OlbqnZABV4PUwiwtRa14K9ERp85lusiquE8Yu6CeQ2WxgzH?=
 =?us-ascii?Q?6pwu2gE+GXs62j/V049h0JznUN+gRSUxVti2LffDouYP+ox1sBR7VLCI43MU?=
 =?us-ascii?Q?R4ewWGuFdPW8aduluE8n7Ugrt6f9S3mUm1BV72XzrgRegfJfStRJGrz71O79?=
 =?us-ascii?Q?39yJrtQO5CsVDnutTTU6BZg5dkPIxsre/x5iilF7etzLsJ/AaqyKxjujJaA6?=
 =?us-ascii?Q?wPl1r7h3iWzhoyAm+O1BFnOAAF/yINkz1QmuX8wBZ/8MFQYK0qhbG1Ea4Jgd?=
 =?us-ascii?Q?EHWy/cvLzL5iAy3bwvKjGA4BddFY7J8+yT0L+lvOiiRK6o+nwxnk4ktmAdW3?=
 =?us-ascii?Q?Cyo5qLt+gy9uSQqz/72mhy1WseGv5b8soHDsgJQNPRk97w7miO9ThChthixG?=
 =?us-ascii?Q?FbFA9LZ9v8YtHGmxq6QglLMSLI0gJRRwQMTMVA5qqjIckvM8lO4qbVjp+hd9?=
 =?us-ascii?Q?UVPSVPkhdKgbuYXIdydO7NI1WpR5r+gTPd0vnqGCDLzkvE5VLdZve8eiNRxV?=
 =?us-ascii?Q?ZnljsHCZBG2HMaweU1JjZ9yo4+qgIMqhzsxm8hFUbPF52kPUOW0rg64ss1VQ?=
 =?us-ascii?Q?UskKsaU0xs8jPByuCLeM2BOC59Cvv9rm82KeuSrApARQQy4uL4DvOX9unT32?=
 =?us-ascii?Q?zlzu6WO0PeGeFgtb3EAP044=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd36a853-ba31-4534-a39f-08db72a424ee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:09:12.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr4J5XWmfKgo6WAr+Xa3q0igV+kpn6CfyMeagMAhnHFXtKvWtCvaCfBd7GiBQ9zOodj2bj793hxDPays1OpjKtzfUPxNVuKykkylVlfm94WM2aSkUANT7k1c5GXv7x/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

On Tue, 20 Jun 2023, Robin Murphy wrote:
> On 07/06/2023 9:31 am, Ilkka Koskinen wrote:
>> Some platforms may use e.g. different filtering mechanism and, thus,
>> may need different way to validate the events and group.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 13 ++++++++++++-
>>   drivers/perf/arm_cspmu/arm_cspmu.h |  4 ++++
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 72ca4f56347c..9021d1878250 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -559,7 +559,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
>>   static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>>   				struct perf_event *event)
>>   {
>> -	int idx;
>> +	int idx, ret;
>>   	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>>     	if (supports_cycle_counter(cspmu)) {
>> @@ -593,6 +593,12 @@ static int arm_cspmu_get_event_idx(struct 
>> arm_cspmu_hw_events *hw_events,
>>   	if (idx >= cspmu->num_logical_ctrs)
>>   		return -EAGAIN;
>>   +	if (cspmu->impl.ops.validate_event) {
>> +		ret = cspmu->impl.ops.validate_event(cspmu, event);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	set_bit(idx, hw_events->used_ctrs);
>>     	return idx;
>> @@ -618,6 +624,7 @@ static bool arm_cspmu_validate_event(struct pmu *pmu,
>>    */
>>   static bool arm_cspmu_validate_group(struct perf_event *event)
>>   {
>> +	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>>   	struct perf_event *sibling, *leader = event->group_leader;
>>   	struct arm_cspmu_hw_events fake_hw_events;
>>   @@ -635,6 +642,10 @@ static bool arm_cspmu_validate_group(struct 
>> perf_event *event)
>>   			return false;
>>   	}
>>   +	if (cspmu->impl.ops.validate_group &&
>> +	    cspmu->impl.ops.validate_group(event))
>> +		return false;
>
> Hmm, this means that any driver wanting to use it has to duplicate all the 
> group iteration logic, which isn't ideal. More than that, though, the way 
> you've implemented it in patch #4 I'm not sure even does anything, since it 
> only appears to be repeating the same checks that already happen in this 
> path:
>
>  arm_csmpu_validate_group()
>    arm_cspmu_validate_event()
>      arm_cspmu_get_event_idx()
>        ops.validate_event() -> ampere_cspmu_validate_params()
>
> so there's no need for the ops.validate_group hook to just call 
> ampere_cspmu_validate_params() a second time when it's guaranteed to succeed 
> (because otherwise we'd have bailed out already).

Yeah, I took another look how the framework really does it and you're 
absolutely correct, it's totally unnecessary.

>
> I think what we want overall is an "is this event config valid at all" hook 
> from arm_cspmu_event_init() (which we don't really need to implement yet 
> unless you want to start sanity-checking your actual rank/bank/threshold 
> values), plus an "is this event schedulable in the given PMU context" hook 
> from arm_cspmu_get_event_idx(), which should serve for both group validation 
> via the fake context in event_init and actual scheduling in the real context 
> in add.

Ah, that's true. I can already verify the group event has the same 
rank/bank/threshold settings as the group leader in ops.validate_event(). 
Thus, one hook seems enough.

I fix and rebase the patchset.

Cheers, Ilkka


> Thanks,
> Robin.
>
>> +
>>   	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
>>   }
>>   diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h 
>> b/drivers/perf/arm_cspmu/arm_cspmu.h
>> index f89ae2077164..291cedb196ea 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
>> @@ -106,6 +106,10 @@ struct arm_cspmu_impl_ops {
>>   	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>>   			      struct hw_perf_event *hwc,
>>   			      u32 filter);
>> +	/* Implementation specific group validation */
>> +	int (*validate_group)(struct perf_event *event);
>> +	/* Implementation specific event validation */
>> +	int (*validate_event)(struct arm_cspmu *cspmu, struct perf_event 
>> *new);
>>   	/* Hide/show unsupported events */
>>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>>   					 struct attribute *attr, int unused);
>
