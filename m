Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8671FAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjFBHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjFBHFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:05:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2113.outbound.protection.outlook.com [40.107.96.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44056E61;
        Fri,  2 Jun 2023 00:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GV6Wxza10V+FXzXIJmO0EkWsx1l2opDoWHW5WGXpU31/xD03DjeoIlHRtlkFZzUFDTgK6a5YVTtObOPKGgULkVxOkhLHFxwy9OAcAn7hoirJY/loPQ7g6pMdnr6ytftEFDVCmZhOgnxc7IGpzSl/LBHE+fRfzheMJy2c0/69kid/UoYjgQLjWJYimpAAYjbjL5DEbYuPu8BStmbYfjM7hRNTXJh2sbGw8YEdh7Lqz3mkgRLmVSPqQ7szqwE+0UbtsZ2wNO6TV/hLdxDQ8jJBRUFvedx3G87Fw0E32tbJNznzQhnzEkoC1okrwmQM0cC3x03pno0+ef//WRw8deemSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Xv7N78wJJF8v05BSpHgkG+s4731CZUi2PU4as4Yi0=;
 b=e5mXrs2xWvkJgnCkZXJ8SdtfCNW+2Q13WgLNdtGHQxjxAfKd0BJllG0enBy36r2Rn9NgcSYikq5BlEgDyuCvtw0vV3MJGAzZaV9vdY3KClEBKcMipMmzuzP24TUku/6EQEKC2/f13KaBDXjA4x7zg3MIN6qhJTZDQSFz/0L9to/tFVCHn7BXFf+NdMDSAgVAH5OpH13XMiz4ZlZ/RMF4ZQK2scf66iJ867kVIbEF5PQ3Eka4HpIkq90hSlBL7BqnBfSPtqdbwjB474SKGVMHebkbYupZZ0zyMwb/40HIa80NWJIBLlu9j6MZ/1t0MilwqnFEPsdiFxK7sDL0La8QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Xv7N78wJJF8v05BSpHgkG+s4731CZUi2PU4as4Yi0=;
 b=BmuHOHghwuOI2+uZuqh+zB31N015R8YpCzVSOwym30sgRVTVpr5ZXvKmVStFzTXei83zpIUWPhzph2BEL6YL5odGc3Q9H67icZm831GJnoQN4IXuqbaUj5z443GA6HiZJgIIVKV6m1wThwUr5Bd1pjHjkEWFqSzcE0bsSpgAaE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB7581.prod.exchangelabs.com (2603:10b6:510:1e0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Fri, 2 Jun 2023 07:04:48 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 07:04:48 +0000
Date:   Fri, 2 Jun 2023 00:04:42 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/5] perf: arm_cspmu: Support shared interrupts
In-Reply-To: <e2f2c524-c7c5-7a55-aee5-699b069a445a@arm.com>
Message-ID: <77b19b2d-a84e-eb13-db38-78cb34a444a8@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com> <20230601030144.3458136-3-ilkka@os.amperecomputing.com> <e2f2c524-c7c5-7a55-aee5-699b069a445a@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ef8539-d417-43c2-888a-08db6337a70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqZQsBWpBLgPuY26fXu9GoOZ0vpPGuRhuNantwMVaufoeBjrL1w6WOwh/SVunnck1ae8h9nw2HJn7e7FRyE94m8pd3Z72/ECdcjmBeNXyu+FwEYqYm1iZSU505EkB0T/YBZOF4jMrG+6mYBtRqBqppdTT9mhuVR2YM7j41s9J7Xz2wkF6/dcClMdtiEyt6RPOVWGx4Ib47TPo8hwng2LmG1XDavVQ12iRFtdJ9nFBP6yyIoC8dAsdaSok5Jr73tW99HyiweQMXAnQDiPw3UCssSvIgRAzOtSt205TlDH8VkGMY9OaANFN1zj/dtwgfgrIf9R9t3vPCIeCwcbUhM9zwsMseL9+1RK2Z+ktLzx8ZhT6uONrLNNk9/zRmlxuk9CxsGUvzyhaRtqtf88nJA7s6BhUZpAgpLsHOJwf+Qmxk4kpQGiOnzAjMOUJZad/ME/deC562qqbR3MetsIFRnRQJDx5ioVrOg3uuiZna/hXmZtedXjy5my53ZLL5cn1NXCp2zDsxnei7v+hnPX9AjlW9PMaDwEyM+yeQ9qZuBGa9MABn0c2lFXrXib2jSI6ZG90mlwcSVuF6oVDcSKOyr0EQ5O0tK2nhid08ZjX1EISQyCTwfS0fP2D/WHKVoMCnk8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199021)(54906003)(478600001)(66556008)(8936002)(5660300002)(8676002)(66946007)(86362001)(31696002)(2906002)(6916009)(66476007)(316002)(4326008)(38100700002)(41300700001)(6512007)(186003)(6506007)(26005)(53546011)(52116002)(83380400001)(6486002)(38350700002)(6666004)(31686004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7kyQ7Q8MU8BDySZWEzr9EvY05E+PIw78sGSWAJaWVvl8i/mJXL6tvezf5rq?=
 =?us-ascii?Q?ZIMZ2Ettx7IXIl/8trvC5Y4q2rz5+/VaDC9FCkGPxpKsqcim9OeO5PNzyUsl?=
 =?us-ascii?Q?nutZRwuyQWH34GMLPtGfP7pWHgo2LqlKqfjGoiKSbNJlwTs5U6piFnLX4quk?=
 =?us-ascii?Q?zc7XdJEqpJo08ys2lWpoVl6jHZmhNnf6BI7/1q+XXf8UKvHBFf9Y3iofjXu6?=
 =?us-ascii?Q?6jammOnQYDDH4mx5FhVPg0+RXCKZAkLrvzmyTk87+lVkdKIkTagqxUtHUkSo?=
 =?us-ascii?Q?/SYqx8i5qHnXXME1Jv0gMlY0eaE7LGPJVtl/utoCJdHWPkDxuPZZPOHUAy5Q?=
 =?us-ascii?Q?mYYRVf0Jro5OLCu2TK6lHwXwh9yWWrgdE7qztiC7utdGgVtWMgmmpf4PtU6k?=
 =?us-ascii?Q?qBkKWNYEWsUrHpxugcvnww4TUyLPDKGgXFNgEhc/rAC+IpQHpRNzRzePJlGO?=
 =?us-ascii?Q?PAqxcM3oJXQ10jiPhdy0tT4r6vqEIycM8wKsT22qLU6SCPLIqzg1UdqkBePn?=
 =?us-ascii?Q?Vlnzu9KzVvEzRqHZRtH64/ZqLNERE1/yD4y4bAxWNHduLXvBfZFODqJSAENP?=
 =?us-ascii?Q?+TZOlCF88LeD0I8zWYfCejhAdScVaUYj2lEZxV2gi7GX829GllHaPnXDSBG2?=
 =?us-ascii?Q?9wPNMdRaBhCOcik0g22Txf3vHLjwfAX3NJE62WMgrRrN2kZHR0RBIj8ST/uO?=
 =?us-ascii?Q?lRfkYilyKpe9LbfL7eA4rDZkgGAhiF+/WVoOm8vjk4hbnQfwQ9QK2lHTtI3+?=
 =?us-ascii?Q?kMubW6J5aVCO3U+Wlm5Gqk75gfrS0keX9SqjgPR52yX7oOVrlrbxHG9C1HId?=
 =?us-ascii?Q?kJMBpLKYLkYRVBrepnxdIDqZOxBCvDuyMv0CRZ0jgyor470XwpkQ/3UZHsTq?=
 =?us-ascii?Q?pGMoj4f+hORt3Wk6MUdamwxW9Q3hT3l9LxdC7WGxhx/Zekv2TiMRW3ZvAegm?=
 =?us-ascii?Q?nZtEUDUb2Upvg4jpigv9nVdfR3AOnqz4yh2tWpXkLT276YoDrXVQCeIhL3N0?=
 =?us-ascii?Q?yPOE5Mtj7GoX7cE1/LlT0+ZoikTiEkvmC5JPKMnKUU6U0pHlLpCjxj6GCCJt?=
 =?us-ascii?Q?JgkDce4DTlQlEgfAAe5KcrauwH7/nMs6HzaNFXsMflRPP1qL0CFo3/m8iWEP?=
 =?us-ascii?Q?Y73m8UZG1abY3j0Z7fu5cQSifze0bhcpXUphyzqTnMJ5i0ocNlIn8mvkVB1K?=
 =?us-ascii?Q?vxye1ke53AMfC5b0xUJBo9vjgTEWwes9e6meF83B2y/JAA9e6JNqE+3JXta1?=
 =?us-ascii?Q?poRFo+3x2+jyFhT+jA2LrQabi3HsU76KI5QFKr6ncxJHyTCDCfF/qvMcFPOw?=
 =?us-ascii?Q?WXW2bZmDm7qJWGI4sQPLjAxlH6co9Gr6o3MuRfbvk3FYcxW121W3GdE4E4L/?=
 =?us-ascii?Q?x12o7JcPUDz4hSHyWbh//TVXKoBuNy0bamkNGkLvx25y9CnMgwcNeSVbxTI9?=
 =?us-ascii?Q?1Fb1UCujujMgt0rHPfPY5YnIGCTfdVCTMjo/3KG/e73SINbfu2AoEMv5AJ74?=
 =?us-ascii?Q?0w6//UmPV9hRUbtkjPYy/7GBg/Ys2GybTe9DEH/tkHKdWtKpO9Q+LUfJR2eR?=
 =?us-ascii?Q?w/kTNDFIPsOkBHyrcTxe4te6JOKRKIXFtNBhoRip0ahAHc/H/NW5fD0KB/dw?=
 =?us-ascii?Q?/azXgrtW0mJKBLQJIRlCbu0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ef8539-d417-43c2-888a-08db6337a70a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 07:04:48.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY53U4+BAZDOgitZLoAkIYXXGAY+O/qHIh//7rBki+lzKFOLGv0TAEvpQidvGfWmlMoaqoNxdCHReVnr0cSGyJfCq5/qTBg9h3NeetV5UwWEwOOjhexJTBXmZqMOMupM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7581
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
>> Some of the PMUs may share the interrupt. Support them by
>> setting IRQF_SHARED
>
> This has the usual problem of allowing any PMU instance to move the IRQ 
> affinity to a different CPU without also migrating all the other PMU 
> contexts, and thus breaking perf core's assumptions of mutual exclusion.

I see, I wasn't aware of such an assumption. Sounds like there isn't 
necessarily an easy and clean solution for the shared interrupt case. I 
drop the patch and get back on the issue if we come up with something 
reasonable later.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 88547a2b73e6..cc5204d1b5fb 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -1067,8 +1067,8 @@ static int arm_cspmu_request_irq(struct arm_cspmu 
>> *cspmu)
>>   		return irq;
>>     	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
>> -			       IRQF_NOBALANCING | IRQF_NO_THREAD, 
>> dev_name(dev),
>> -			       cspmu);
>> +			       IRQF_NOBALANCING | IRQF_NO_THREAD | 
>> IRQF_SHARED,
>> +			       dev_name(dev), cspmu);
>>   	if (ret) {
>>   		dev_err(dev, "Could not request IRQ %d\n", irq);
>>   		return ret;
>
