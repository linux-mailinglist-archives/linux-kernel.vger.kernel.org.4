Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EF73AD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFVXVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjFVXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:21:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FCF19A6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGm7Ibf8wNajBnoQ8Pucl+H/sKLAj16HQRVeSTzRBPLSYCuMGKrWYT5SwkWsCLz7vliy5pqotvrSfJT1QkAEkk5Nx4HLANtHg1k0sJb99f3gaXcBcfnZhd7aljeqxTiS3J6zNL/Wed/rmn2LtKtz3Vr5pEMaOrwvs9en4pvGXCKi8LMqHgnBPOPZDskLU5JY3RJVzbZlzh3znfayGGcR77ISNY78q0lASkteB1TJzkYOFgDyZajO8ySVmSr+1I1LNnePPcT7+MbSmI2bCjD33t84s9N69qfqQqptNuWtf/29sw7KrXutlCZE3kTgzdctBb658y/fEjY+5B9VgWVzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD93rjy+xSNq+7/hXsT3Y+Xk36VsXzyd3ROqAePS+6o=;
 b=Kts7Q+EUbprz4Amzrq4KyF/m9vfNtifVSeyA6I4Kiojwz/uEZi+zTH0ZFZ3J6nFSrx9V1+ufMo7dCUtAWOF5hdyqPwJmgKgGHcxzpsbe+aBdEJdqlbkpO97iHIuhXHE9pzSjcnj8YyFnELsKlaFw15PQ01BHhzjrfuugIjkB1Mre9ax3tFsjh5D8xjf6en/yYA6GgtmpBjEpcECZRaAmXAOvJiE5RmUKRCqcc8INgWk+fkVxA9yQmguPBuV9e31tBQp59NcQ6Bt+Va7X2+9w1rmL/E3dKLAxbZj13uPoN0V9DdcFOKYSyFVdYFqoHFJSKGkXqgKpQzqtUMAfha170g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD93rjy+xSNq+7/hXsT3Y+Xk36VsXzyd3ROqAePS+6o=;
 b=MdjDiKas/hvw5wXdEyC95tdoaK3qq68DMw1qckHqaNcF1ij4FoKKiL7nIkb/asLSjQUIxwI9lw88jW87W1vXhcFcrcULprM2yRkgJCi0k1z1Wt4cHofflx1QbCh9TOhjBkSbPINiFDrvwuEVI7mD0BYU2svdcHngDzK6JRQystc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 23:21:26 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:21:25 +0000
Date:   Thu, 22 Jun 2023 16:21:11 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere
 SoC PMU
In-Reply-To: <20230622095143.0000009f@Huawei.com>
Message-ID: <d721983b-f25e-e27-795d-b841ad2fcf5@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com> <20230622011141.328029-5-ilkka@os.amperecomputing.com> <20230622095143.0000009f@Huawei.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:76::18) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de6b27e-5f66-4348-0c64-08db73776609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDfpD0alp71oVKMbMxxI9EFIvEGzsJfYm+82MUZi/biSOJS31pcI0VbS3K/mWZPLdZYihJdhkqFHlsYEhkWewMdQ/cdXFKaHjz1r8kgZEGgZgazm/cLH7ddEH1DhXsmnERz+60CISW28z6o9BEOajP7vx+wSjMM52pgftxtUPkK/5bba+ua16BRUenbBUIxumAqrqye9DQJHo65ZOvnaoI/LO+rgC8RhYnTC/c2lHUudK0E20C39koN/cE4KLhJZhsl8x+VZZz1g8JWFYbggbGutOhwE33L3L+lpALLgJNoI7Ec5+mmyP3ar7QehVdbC+neIEYWWsxYctmJAR0Lc0pUb8s7alv6k2qvfTW8hn3g6brPXSLRutxsyXDTn8PrFYyJvDZzyoFWhdPtqEzYq5D+diWU8ZzZuRpo6oAJaExtEeO7ehm1wYqZyQytw0B6TE+BEbHDDRqmbmt6O36AqI8qIkt6c/qV/6ZJBms6csUYrlBnDE1yhKYM8jW2ZjAABieW8ain+kXrp2fJ1zl0X/LbRK8KG/6fXeNYBhWE1L5X6SXDF1ows3r0HwrfWxjCgdHXXLKhvFDGqYTHHUKRYdxJo8j6QTcbDXFme0IdOaH0PgPPb1zYek8icbCMGRDeP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39850400004)(396003)(376002)(451199021)(6486002)(478600001)(6666004)(54906003)(2616005)(83380400001)(86362001)(2906002)(66946007)(186003)(26005)(52116002)(6512007)(38350700002)(38100700002)(6506007)(4326008)(66476007)(316002)(6916009)(8676002)(8936002)(66556008)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8bMspigsBp/+4+nAtGO2RAwa6Ijj2e/TGe00TuevkTQnbujU9Xh8G4N1ygSZ?=
 =?us-ascii?Q?NfAotl5pZu6FBdL0SPchcNkpZczcupxEy+eTNPgZ71FMTl3zHHituy+4IfKR?=
 =?us-ascii?Q?yBDjc4AX295y+lgS4pjBijiNrKjOlgXvZtK62mx4pCjYvW5GKYDO1IAivcIt?=
 =?us-ascii?Q?BNVR2zZUwheyQ3mi9tgY4lBnBKkwXOhV2wUbVRxyedVYq2BfUYncooV/cWyQ?=
 =?us-ascii?Q?VQTT/lynsbVJywfo6dCGS9TFpLGleXWHBoVdZjUVbyyZhsLdHHuJUgUqTRfG?=
 =?us-ascii?Q?3KOvJak9VevjFvsNXWHzyAc1zY7jtNfwc01n/c0iREPNPhkoEtMRutwKiEAz?=
 =?us-ascii?Q?MVuyH5hym8adyEwmHa2+6Y8Lpdc9UcF/PNflii1fMNU7tJu7hgjsQjvQ2K3m?=
 =?us-ascii?Q?Cem7x8GxjKpn2bf3LWxT/5mJSVI57oakkTcOG97qoBTmXISrTXP2TjQ1S6LP?=
 =?us-ascii?Q?2dyDI+w5s0GXIWVEY8UqAy79zN3rDNSUfYnlK/eT0EecPd2oZpVGS1WN8RYn?=
 =?us-ascii?Q?3vNb+j1+GX21dBQ+uJnKQFp0CRWrNKDV/912P32xLDgMYdVJPzx2RW/lpRte?=
 =?us-ascii?Q?g9IxvY100xb1Fnndy0wBY6TvYPGaGnRRWub9Yi4u0g+VpE2LX/PvKRbv14XH?=
 =?us-ascii?Q?OTpsdcT+9j4ftFa6srLGMvNpmlJ5ehFejaHPSLuTIXLOSg32jBZzHOskXse3?=
 =?us-ascii?Q?6yxEdi9q5sBNKV+VWppToaEorZFuc003WeiBo7BjZOUTI1j/j7i7Au2mYMve?=
 =?us-ascii?Q?eGBVPGPCIHaZlcz5mgoe3tz9KvzXAKrXWFBVSQoa+akiScAijMqIjf/cCQbC?=
 =?us-ascii?Q?k0r7q/Bg3YRkKEer9ioh1Gce/gbMdnRypaVgrD6KyplpDfWmz7vDOuheJsZ0?=
 =?us-ascii?Q?Y7CLX8UuCVKzVMsuNKC5HN5/zYbP6dXELLm9OvRizO/ayokQtFcvBy31Wcdo?=
 =?us-ascii?Q?h50wdb9PYpFr0whUHfo+KVJ8AFC/f0f0K3hEWUl9zui2fouYy8JhxK16E7YU?=
 =?us-ascii?Q?r4BjNPELMhXd79UQKA+eUXZIrDV8nPiemylCxVXspIsA5I5HJahAMTqx5uWG?=
 =?us-ascii?Q?RMlxmZ8RVvl9p5CaEoHm1fm5980i1eUgGDrjaZqZJcGBUAc4AnqyT1ZCdmCg?=
 =?us-ascii?Q?5WeZ7Eb2KGFyXtK0oCLZbWqctK2L8bNmwQ2HRLZzCARVcQBSOc1kT6NVtdPD?=
 =?us-ascii?Q?cibrQWzF2cX/NuNGcuglu56S+dHCpsIA05tiIS90EIwIb3EfyxRKdFqjKvyj?=
 =?us-ascii?Q?YNvgmQyW2psQq3o1shTceM3QslaQTqiXedqVhhKAyop1vnO6zgt17pFMIjr0?=
 =?us-ascii?Q?cx+oor+P+sjhNM7ywS61lvUAL8pGNJLvMWZdNWi788bouKq8dg+YMP7oUSTq?=
 =?us-ascii?Q?qa5lZbsOdji1Z6ddtz4yJ/N6+44KBMO3FseOd7js53hRewBMly+lx3FYNfG6?=
 =?us-ascii?Q?wnucCrRn9xCaiKZNfKugJWaBz4Ym5y9a4mtdlfGu1Sd3MWhefrnJ2FuIJbLp?=
 =?us-ascii?Q?cnTA1j1Fv9+YbQSIPGwCFDZbGpRzzJUhoSid1aPFzQ6Ct2DHaZOUwcq07TG0?=
 =?us-ascii?Q?zOIV2/L17fxfRQBB27+Okp582VzasKk0cUQPJ2K7KUAWFH93TtEM5qkAzV5O?=
 =?us-ascii?Q?CjVyGyAfZ4dGpJWAyeDEWfM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de6b27e-5f66-4348-0c64-08db73776609
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:21:25.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj0ZmWjhfO9nI9TKLlIRuAaDUhFoj3nfX7pjoZOwVpNlrZd+SPKj6JdfNdCIn1MUM6M7WJwpL7N1rQwrcHxrABmq0CCS+KWRgLcT8LbOIpeTcgyH8UpFevXpVfuD6NRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jonathan

On Thu, 22 Jun 2023, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 18:11:41 -0700
> Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
>
>> Ampere SoC PMU follows CoreSight PMU architecture. It uses implementation
>> specific registers to filter events rather than PMEVFILTnR registers.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Hi Ilkka,
>
> Drive by review so not super detailed (I was curious) but a few questions/comments inline.
>
> Jonathan
>
>> ---
>>  .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
>>  drivers/perf/arm_cspmu/Makefile               |   2 +-
>>  drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
>>  drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
>>  drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
>>  5 files changed, 286 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
>>  create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
>>  create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h
>>
>> diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
>> new file mode 100644
>> index 000000000000..bf86bffeef63
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/ampere_cspmu.rst
>> @@ -0,0 +1,29 @@
>
>> +
>> +Example for perf tool use::
>> +
>> +  / # perf list ampere
>> +
>> +    ampere_mcu_pmu_0/act_sent/                         [Kernel PMU event]
>> +    <...>
>> +    ampere_mcu_pmu_1/rd_sent/                          [Kernel PMU event]
>> +    <...>
>> +
>> +  / # perf stat -a -e ampere_mcu_pmu_0/act_sent,filter_enable=3,bank=5,rank=3,threshold=2/,ampere_mcu_pmu_1/rd_sent/ \
>> +        sleep 1
>
> Why filter_enable=3?

Thanks for catching. That's from the first cspmu version and got 
accidentally back there. The rest of the patch looks like what it was 
supposed to be though.


>> +static u32 ampere_cspmu_event_filter(const struct perf_event *event)
>> +{
>
> Whilst lots of other comments on this - perhaps add another one here to
> why this is a noop.

Sure, makes sense.

>
>> +	return 0;
>> +}

...

>> +static int ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
>> +				       struct perf_event *new)
>> +{
>> +	struct perf_event *curr, *leader = new->group_leader;
>> +	unsigned int idx;
>> +	int ret;
>> +
>> +	ret = ampere_cspmu_validate_configs(new, leader);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* We compare the global filter settings to existing events */
>> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
>> +			     cspmu->cycle_counter_logical_idx);
>> +
>> +	/* This is the first event */
>
> Maybe add why that matters to the comment?

Sure, I'll do that.

>
>> +	if (idx == cspmu->cycle_counter_logical_idx)
>> +		return 0;
>> +
>> +	curr = cspmu->hw_events.events[idx];
>> +
>> +	return ampere_cspmu_validate_configs(curr, new);
>> +}
>> +
>> +static char *ampere_cspmu_format_name(const struct arm_cspmu *cspmu,
>> +				      const char *name_pattern)
>> +{
>> +	struct device *dev = cspmu->dev;
>> +	static atomic_t pmu_generic_idx = {0};
>
> Why not an ida?
>
> If the pmu drivers ever become easy to unbind then you won't get ID
> reusage like this an eventually you will run into overflow problems.

Didn't appear in my mind when I wrote the submodule. I'll change it.

Releasing devices would eventually require a release hook too to support 
reusing the IDs but we can add that later.

>
>> +
>> +	return devm_kasprintf(dev, GFP_KERNEL, name_pattern,
>> +			      atomic_fetch_inc(&pmu_generic_idx));
>> +}
>> +
>> +int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
>> +{
>> +	struct device *dev = cspmu->dev;
>> +	struct ampere_cspmu_ctx *ctx;
>> +	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
>> +
>> +	ctx = devm_kzalloc(dev, sizeof(struct ampere_cspmu_ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->event_attr		= ampereone_mcu_pmu_event_attrs;
>> +	ctx->format_attr	= ampereone_mcu_format_attrs;
>> +	ctx->name		= ampere_cspmu_format_name(cspmu,
>> +							   "ampere_mcu_pmu_%u");
>
> Long line and need to break avoided if you don't bother trying to align the = signs...
> Personally I don't like this style as it causes a lot of churn as drivers
> evolve, but meh, it's up to you.

I don't really have preference on either way. I remove the aligment and 
combine those two lines.

>
> Given the result is confusing if the allocation fails (name not what is expected)
> I would also check that allocation and error out if it fails.  Obviously it won't
> under realistic circumstances, but a bit of paranoia never hurt anyone.

I agree, I fix it.

>
>> +	cspmu->impl.ctx = ctx;
>> +
>> +	impl_ops->event_filter		= ampere_cspmu_event_filter;
>> +	impl_ops->set_ev_filter		= ampere_cspmu_set_ev_filter;
>> +	impl_ops->validate_event	= ampere_cspmu_validate_event;
>> +	impl_ops->get_name		= ampere_cspmu_get_name;
>> +	impl_ops->get_event_attrs	= ampere_cspmu_get_event_attrs;
>> +	impl_ops->get_format_attrs	= ampere_cspmu_get_format_attrs;
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_LICENSE("GPL v2");
>
> ...
>
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 471d6d7ac81a..587515eea0b4 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/perf_event.h>
>>  #include <linux/platform_device.h>
>>
>> +#include "ampere_cspmu.h"
>
> I'd be tempted to keep the generic header in a separate block then
> follow with the vendor ones.  Not particularly important though.

I like your idea

>
>>  #include "arm_cspmu.h"
>>  #include "nvidia_cspmu.h"
>>
>> @@ -114,6 +115,7 @@
>>
>>  /* JEDEC-assigned JEP106 identification code */
>>  #define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
>> +#define ARM_CSPMU_IMPL_ID_AMPERE		0xA16
>>
>>  static unsigned long arm_cspmu_cpuhp_state;
>>
>> @@ -388,6 +390,11 @@ static const struct impl_match impl_match[] = {
>>  	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
>>  	  .impl_init_ops = nv_cspmu_init_ops
>>  	},
>> +	{
>> +	  .pmiidr = ARM_CSPMU_IMPL_ID_AMPERE,
>> +	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
>> +	  .impl_init_ops = ampere_cspmu_init_ops
>> +	},
>>  	{}
>>  };
>>
>
>
