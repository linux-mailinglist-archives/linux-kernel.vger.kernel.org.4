Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9671FAB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjFBHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjFBHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:09:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD71A2;
        Fri,  2 Jun 2023 00:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJhmLP/HQr0ofTnkyRHlo0IQD2WrSwsrw8F4C1y3T937kUBTqnyEmwV3j2XGRKHyWRFYI8CjmGW+I3sSN+M7CDK/DSx/gnwRgY1HtW/gTWING4iLd3n/D2MWF43SKbijhKGr/5EUMNavk7nqu52EKIdvkqsxPZtkyVCtT0xsAYIQW1unCtstjMkdwY0M2L10HDwO8YLMJAynuSOxFaS4aCZRqFYhoKarZL2JyKzrNjeND2d5eomtN99mSlwbqSLJOZRDh1xcZ7fde7sUqyglFgzR76UpfXj/gzNnfBQYq0vaoYarYya1rTpgaFEABwLHCnQOgm6n2D7CzX9/RdqeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66MkbLZvFQw83i8OwhYRGzUYhGnObS7HmCVJXFC/pFo=;
 b=H5Wj3xjhpWPV8b6TxEzNxudE6e/3kkQ5OD2Ae5WGKxShdtu/eVVIB+8oB2nIWl5ecergh+LKVXb/720mMoU+f8zD74CBcnLsO9DFPh/1kTGHD1of5AjsppYOIxWiyS3EsYrzbCCz6Qede2xdn+vIfzh2o+t5BtzBO2YrTKlvmXzFMFjt54QY193vpSpdQWQJJiEwiO9hasefZDRLaRfRLBam8Fp5zHYUsTz25Agg5Mc39oWHDNFBjV7GKGCm6RYHckPbEjiHfeP7oXlU8o5sAbu3OAfSm49ZGaTDsXS2glKkvQhKjZYZIjqLtcuDNLw244bV5BNCLQexVeGIALazdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66MkbLZvFQw83i8OwhYRGzUYhGnObS7HmCVJXFC/pFo=;
 b=U/UkUS+KsjXx8LYecI8G93JIHFY03Nes+vQ2idELSNDr4r96YqH9vajyHWbk7T5i26ctNCvScuRw5O7rj/1kTtGr5UpRswcPIKKZhnSy3LzoWgGkgl1MkaInlCVpvusFxjMHA+dY7Fj82BHh4pbWWrJutbpqj4Oj5I+SkUFvI7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB8541.prod.exchangelabs.com (2603:10b6:510:2ee::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Fri, 2 Jun 2023 07:09:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 07:09:31 +0000
Date:   Fri, 2 Jun 2023 00:09:24 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/5] perf: arm_cspmu: Support implementation specific
 event validation
In-Reply-To: <2a081ab9-f1f3-569e-72e8-1c743e8357a1@arm.com>
Message-ID: <30a649f3-f787-56f-38a0-9ce0ef87f4ca@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com> <20230601030144.3458136-5-ilkka@os.amperecomputing.com> <2a081ab9-f1f3-569e-72e8-1c743e8357a1@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0434.namprd03.prod.outlook.com
 (2603:10b6:610:10e::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce9612e-0a9b-4f61-25ac-08db63384f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hmtBOphQsailJgbLeEp3yq0qx+QS5Bpucs2Fku85P7JSI/IN0rx5yvB/K7lXoAI5YGTkgFT9C5S/io8JEass3KEbr+BI1TcFpJqiSlSeBQ9//R0Vi/lf42QjYhtd6+MSbdAZSV3yxRA0MQlpctXeIR0u3fz7fWoTqundCP3Me0TyNl70gmrk/VNJoSc800JoE68pPs5i5uz33ZIyyHvdI0g3z8UguC3CWX2JxlI9svgw5YuUQAODylUGdpDMLoB+YjzrecI3bvPZPGaMsPUjzxWQM95m5jLtbjf2SmowPbRaFGOFF9td8qJ3zKJ8xhWQS9HeIU755zM136iJN+Dk/sFVVun2uCigrHDJle+o6v8gQr4K/+pAfHb6oAO6dUOhJUJQbyQ0OVmCIIJz7T+rTtu/hbFu//LAtBtIzdW6vnFZkdGeiLpD8fPTZWvNvDVCzYpptxw7F6lk0Dkzy71uSfx+OVEOh/p9P4jjE4HG9o4WGiIVFyedk1pFv0GljDo6nux3i06S9l67gfFzGxHzFEUJSp7k4wd59K+EopV0fNmNPLrLOJQCtOH8O1KbJZrx6xAuUNlFcIP2MkDnup8cKwfg7yqZiAvSvbRpKBYBusUQP6IdHi8p89VbJPoiM9G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39850400004)(346002)(396003)(451199021)(38350700002)(38100700002)(5660300002)(8936002)(8676002)(6486002)(54906003)(41300700001)(478600001)(52116002)(6666004)(316002)(66946007)(66556008)(2906002)(186003)(6916009)(4326008)(66476007)(86362001)(2616005)(6506007)(53546011)(83380400001)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDKl5+RcjpU/RJJD18+tDhPnS/bXRE2n0jgxeoheMMGfls3S25vDzZOzdWji?=
 =?us-ascii?Q?J0Ju1hNrZGAYGOdzR9LNBLoxmMyHMDIK3dTGzw/IOuqU3kx49zt2lt/jfMTu?=
 =?us-ascii?Q?PGTnvFCyYU8hjUpoYPyDAvKSDqZGbzQTfHXKEkWD9mH3lGW2hOKS9Jz9ygJW?=
 =?us-ascii?Q?aLopAP1Z7et1bfBQoUkicA8eGh06jjcUvFID5BgJBezY6/gvdjvVv9VmF3yY?=
 =?us-ascii?Q?AOW/yR8xJcBuEiPtCBTKmdBBYADWDFxWc1+AT4Oz3S5YSm/BRwrjp+LTLGAO?=
 =?us-ascii?Q?6/a0DnzEGWb4w4XZAPfRJ6YCFKloL1T6N/nbEI38l9L9SLtMA7ZlRX6kHPQH?=
 =?us-ascii?Q?cCo9LZZdjMq2/oH5C1/Bjn2bMUWiQn8c2zuqvxryf5or+wtVMenYbRSEXjyx?=
 =?us-ascii?Q?VdqZkABafAa3FTkL0xl+zLHrdIjCG0Q5ncV9y0T3b6zVsYgfPbGYbhPxO8n5?=
 =?us-ascii?Q?f/+UKa+gUD6uCLHkUzcZc6anqozhcc9cDjTCFuUUVQnGdYYRarEuUl2kjULa?=
 =?us-ascii?Q?p6iyML9R0gPH1+6BQXB51dz0/IN35O8gnUisTNttwO3wc/I5WDNXW1qbcmZR?=
 =?us-ascii?Q?vuGLUeO2aKraxwSMEx4Ct473Ir7WbYQfDWjHcqUWGlKehRlQIfcQJPRMNiXK?=
 =?us-ascii?Q?7vToYeM9pbA4Fr7yL95BRlJ3ihldPsEmS3ncnaSTPqlSkdZG2b/7APunqXsz?=
 =?us-ascii?Q?GQWpWzzVkfaqMFtPps/sVHZuJnM4oomgEZMWKjnXIeGFlTrW2twjHWq946+t?=
 =?us-ascii?Q?WAPrNZS4Sd4K1H9fZJOOX8+0houfY/oVD8P9Uo27FlV4z06vCJnYZEOmYLPN?=
 =?us-ascii?Q?LMkd23zXk/jA6P+EhIxYjuQb5XStT8pF56cjRCrS91FKjbyA4ReOUW1aT13T?=
 =?us-ascii?Q?exGlZqqu86h9xnleS7T8f3bCZkwQTvRva/GIVHakn4EvRJxqaBfUdwJDlXM6?=
 =?us-ascii?Q?yUISBukJa9FWISQtgUYvXvFU/AYzqEzZswMBPulh9rcNC1wTY4gUoDaD4HsC?=
 =?us-ascii?Q?FYNRhwLJENk9VeKEOXFqItNyps7Yjl5rHbLCg/fH7Z49vA0A7rU6izexPB9x?=
 =?us-ascii?Q?nNor6/j9qpGI5pmAHik6R6LIwG0ekZ6Uz48bSZPycJRpNQrHL/HJ3rqOqkGO?=
 =?us-ascii?Q?yqnD9tU/8kBbYUnO4r4mdo/Q0jpJrBOanFRd0rz8OwQZ2IFbwAEKUOFjAVjJ?=
 =?us-ascii?Q?vU5Rq/09NmvBuEs2GO8oCDkTCdgF0QXF4vIfGGdmpAcG5xh8o8+WZcfgx9E0?=
 =?us-ascii?Q?qUxU6l/TuuB0hyT/4yTdhBVx7zriS2MYmXZ2hJBDdpfviji4ZS5fcdZ+hyfJ?=
 =?us-ascii?Q?BdyGtXwANVOhNnJxecyOpk7GiZ8tic3kmQz7BMspI60sOFSYSig2n8Dd6u+0?=
 =?us-ascii?Q?ntDYl2VDkSAYc+3LGng+BYOeuETC64rgeOg5u227K1Q0/2u4m3SV/tOzcshF?=
 =?us-ascii?Q?ed7XqI2NwESdgI82i/oT4sUSkbwrd3sr9Q3rDu24xUPPYo9oytLDctM+oR+R?=
 =?us-ascii?Q?2aB5zFwCjflUZXBSTp9g9mjg8IN7lggtPuApGM7SWcOG1avXPA3VGwgvC308?=
 =?us-ascii?Q?MToznkoQnJf23H6qhzDfra1sOHBKav40j+NXp9Y4VnSbuY+sHsp6A2HR9jVc?=
 =?us-ascii?Q?mGiWy5ZdZgwTNQg6A2mHgw0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce9612e-0a9b-4f61-25ac-08db63384f89
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 07:09:30.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lnTKz8K1DooV0FErk7y9Kz//9vtBwYjyGQiUf7i5fT7dUaeW5WolwoNPIcFwyZUHj8D/mNB6j4HKlKtYf/OfE95NpaRAGh3I9Swk9iJOTAhjGnZv5nfQGh73x12lSeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8541
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

On Thu, 1 Jun 2023, Robin Murphy wrote:
> On 2023-06-01 04:01, Ilkka Koskinen wrote:
>> Some platforms may use e.g. different filtering mechanism and, thus,
>> may need different way to validate the events.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 4 ++++
>>   drivers/perf/arm_cspmu/arm_cspmu.h | 2 ++
>>   2 files changed, 6 insertions(+)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index b4c4ef81c719..a26f484e06b1 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -593,6 +593,10 @@ static int arm_cspmu_get_event_idx(struct 
>> arm_cspmu_hw_events *hw_events,
>>   	if (idx >= cspmu->num_logical_ctrs)
>>   		return -EAGAIN;
>>   +	if (cspmu->impl.ops.validate_event &&
>> +	    !cspmu->impl.ops.validate_event(cspmu, event))
>> +		return -EAGAIN;
>
> Seems like this should be -EINVAL, or maybe the callback should return int so 
> it can make its own distinction (yes, I know the outer logic doesn't actually 
> propagate it, but there's no reason that couldn't improve at some point as 
> well).

Makes sense to me.

> Another thought is that once we get into imp-def conditions for whether an 
> event is valid in itself, we presumably also need to consider imp-def 
> conditions for whether a given pair of events are compatible to be grouped?

That's a good point. I'll take a look at it.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>> +
>>   	set_bit(idx, hw_events->used_ctrs);
>>     	return idx;
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h 
>> b/drivers/perf/arm_cspmu/arm_cspmu.h
>> index 4a29b921f7e8..0e5c316c96f9 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
>> @@ -106,6 +106,8 @@ struct arm_cspmu_impl_ops {
>>   	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>>   			      struct hw_perf_event *hwc,
>>   			      u32 filter);
>> +	/* Implementation specific event validation */
>> +	bool (*validate_event)(struct arm_cspmu *cspmu, struct perf_event 
>> *new);
>>   	/* Hide/show unsupported events */
>>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>>   					 struct attribute *attr, int unused);
>
