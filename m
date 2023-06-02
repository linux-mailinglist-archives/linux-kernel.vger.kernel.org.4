Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652F371FA56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjFBGsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjFBGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:48:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65519B;
        Thu,  1 Jun 2023 23:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtxFjcb7fg12DMmWnPkrjF4NXaCbzmGtrJ+OVAcGUN75JewSaJk1m8Xh/hkbBY2h6wcWuaZHa1KdC6xnQhBRYys7czNVcWNVs/ThmhVYaQcPsfjeptE0ASCyCVxHItTf/bnZGzEsKL2SQWA8mySiSkiOC2oryNAl4jlBmDME76Ys+YTf0p4myCAPJw/2uZFpvjoeZYu3LeJsfh3InGK5AFPuZgH+QshtZAoXLBZy6MsjS0+SJ36tnf35su8C49mrp/HObS3syR8lpJZP4TrqfK7AgI+ERa9GCGy1Jqz5knaBRAAKcFsFZZmpCEGgN2vuNGg+4qvezuji1NkR5GLLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msC63tILuaO4zRzuOnNg4ly2Q2RY0tgT4eTGb/YgumQ=;
 b=KAqpS29Eak9ncFJLeskEz8jlUweZP3fjYSFFRZ53XItzZxtTHJco0Chh3u7LfUEWFPXRjEWekFtWNhSyYVOfY0XX4oJlms+P/WrFY7SjVropKD6ebDRQhTnORP38XlI2fObC5gefru3YgiacBFvJu9pkGFiMUWax8HLHBhlL4jFTuYTcd6g6gYTYz19VUIIieU8nNGJsqEa5KWBCZ4R9ySbb5RjxjH9KFkbSgtFNx3f9y06IkCigajrNd3yI2vEQaJKG0+6gFS717dSE6DG4sowRsigzeCNiZGXbhMdcedilUh/IDmUk5mIsnVKAi2YhLHBW+Fx0Zm2yVZC/VhSNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msC63tILuaO4zRzuOnNg4ly2Q2RY0tgT4eTGb/YgumQ=;
 b=eKK3F5cXeLoTZvA5/bWOc/Aa/5pRanRAf+UJERUkDW+KEfcjFjoAeTa4BReH4gLsUlmOt60EkRwtmwW4a4nMadpZXdQo+0zoEGJ/XrRua+2FUSwlz80/c4vC7tKVNM+mI/zN9Bm8Hhu5C7fjqwGZ6bff+MFQ0hc/e9kGw5LIMzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH0PR01MB6970.prod.exchangelabs.com (2603:10b6:610:107::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 06:48:02 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 06:48:02 +0000
Date:   Thu, 1 Jun 2023 23:47:39 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/5] perf: arm_cspmu: Support 32-bit accesses to 64-bit
 registers
In-Reply-To: <7269d265-154b-e79a-2622-287e149d85ad@arm.com>
Message-ID: <6b8d4d64-effb-2c79-741c-4336a974577d@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com> <20230601030144.3458136-2-ilkka@os.amperecomputing.com> <7269d265-154b-e79a-2622-287e149d85ad@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CH0PR01MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8c9647-1d0a-4400-c94d-08db63354f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDJaXYzQUu1H2i/e9mmSkD/8m1H7S2DwLHv8wxvD2gSB9mWtoYYSwXdj946Ikh17HbdfW+WWVaRSVOFkVFV5VYAUdPm1w6DnQHFMK+qm3e/SEylw/8N9lcMkESyMi4OEIKa7ZJvsq/3WonfkHck0jInwnek0bihx/h652x+MbGTDlt4smWROE0skWSDj0rAci/wp4kOFVpzEDSG/RyyVGrdYoQFaKS+gN8YwWanmi+J2omdszDceS2i3+nX3rRwec4GFJxUT80PhQWYfMUUse39M4hgocfLdcjcFUYp0+85pTdhfSAy0oy85jgVf9sOYEAOr86T/3zryMKkRA5IyHs8TgTeho9DPwQMVIhcmyiKihhcMiZFnbPxX3eqpL3zsT+K+7oHreWA3no/wSxxFL3PwAQklKDcEpdI+IiALnHIPXWCFIStFT4r8fP6BXhWM6yklPL/LyoqY6qPUQxqkoYZARjxG1uZeKJS244RBAe63h/+yG4SJ9Zzw8hREBgUMDsqlIyssUvULScODKqMwBl5LzGKYG70reKRFMaLnmHq+3mS+vRW5GWZ1JqFzMilB/ADQ8t63bhkk54Tg8vQWQrSVonMw7/mscCaIxicsNF6yyFUpfCvdiNVVz8GtXWxl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39850400004)(136003)(396003)(451199021)(4326008)(6506007)(6512007)(26005)(53546011)(186003)(6666004)(6486002)(52116002)(2616005)(83380400001)(41300700001)(2906002)(316002)(5660300002)(8936002)(8676002)(478600001)(54906003)(66476007)(66556008)(6916009)(66946007)(86362001)(31696002)(38350700002)(38100700002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXK4xyK3gqlrUiJxAI2zFg38ZPBwuoY1GL6EISuOW7MgQVU+Kgzzu3EKl5+x?=
 =?us-ascii?Q?OeMz9ajge3JkWmponwyU8BtprYMIK3JCkykW8QiQPmcHTaGU0FoPZZFLNZMv?=
 =?us-ascii?Q?zUQBA3xzfEmoNldVR+Egkp9O+bEMbwyXjJKzjQrnN7KnYQcezsZWhhG4kqDa?=
 =?us-ascii?Q?pR6IM/aRNDjaBbz39nxR6PSytaZLlgcVTKOJnKoC7IYm5m2blOS4XD9S6txa?=
 =?us-ascii?Q?qpwZMpe2R3tdJRa8mfnIYyTf+N9thWgVDt4kiYcUKuns0GJqmbJ3IAjCrBY+?=
 =?us-ascii?Q?TYhhxX6HzAhhEJLP8GlnPhvv/Bu7h6RetTPAKhzjvugCi1lJjaA6bdZAbMVl?=
 =?us-ascii?Q?kEea/9W+jSH2nz/nJYHnbPgG+0hsnBxeRWAvqQ5VM/VCc01gQdQ2+R+i9xk7?=
 =?us-ascii?Q?KiWI9+3RB1dXkaJXTK4ZJuFqu5tntalK/eQy4g2FlPJst4cL5hr6eoMB+nBU?=
 =?us-ascii?Q?euKP4J1N+PZlciYVAlPTpHcKXruUcpbdj3d21z4mGp6mHq8nAgQr7AHCR/zz?=
 =?us-ascii?Q?5dPoLHjZ++1HgRzARZLOdzT+DuFT2/osKm3x0CnaiMnHCRB/csz1Xx+2kdHq?=
 =?us-ascii?Q?msHtfJAwN3pjqqEo3KX5cLV/OJuqo3ixYfFTPvMp9X/VcX9kdbEmD1SsNqom?=
 =?us-ascii?Q?bfsvcU2yPgVMRhHTY7aK6879X0lECEMoAJeKRdITUGo/Eho+91BEWKYeqrBm?=
 =?us-ascii?Q?ZxoXghZSXbN5LciZjjffIoGdShjMxHCcrrWZFTjvQzbeuEhxb9ltYaYmZLD/?=
 =?us-ascii?Q?CfrRQC0Tzr4SDqxm2+X33J16Jg2jM9JYaB4/ldgaOW3MSTJ0Eu2H+5KsIKA8?=
 =?us-ascii?Q?3f/80nO/b+NXQyMgA8uZJ/p/WbQT5pE5HjaGVuOaB5DXkwKNG4mmuwkOKCOG?=
 =?us-ascii?Q?HDu9UHDRInXhm0lcU6eIEfOV5/bYmCvyohF1X5F3T01m+6hTpF72M854nLs4?=
 =?us-ascii?Q?olbuH8jv0jbaqyJyrVJwUpwUY48z6R+5WeXzUH8Gw82poc1+qPIQEpgmsMhF?=
 =?us-ascii?Q?y6uVynXHKHvInJjgCjL15Cj/bangJc6iDlnCtuwxGIshGhqlFkMLM/lO/W2+?=
 =?us-ascii?Q?4s2g7qE5mu6cwGTZlDAwJbv0teGTsESN5Eg9HY3EmYjFq+Nn8aOIwpBL4tU1?=
 =?us-ascii?Q?1RrU8NVcqroO7b03Vbr9LG8iiWUHNQipxomofDDGFcGU1hS42m7VGUapVLk/?=
 =?us-ascii?Q?PTix2LR2GsAr1W9NMRgtxtOrKCrc2e/sEZgURLE8bRjK77xtTW07TUIl1YYi?=
 =?us-ascii?Q?rcoxQC/ehlI2InLjRyreIRBM2P0kVhruFNARnk7Vu+Jld0UQw+xox1wCggQp?=
 =?us-ascii?Q?cCCp/7kogrwSGzWDLf6qsmhlXQpTZRg/zhuI2wfafgPlCymVa8m5LCUVByx+?=
 =?us-ascii?Q?b2/nHCEm413tcvn7rx13YF7bLGqPFFWUm1Eet/1liwmjGJ6T8N7OxUCIIG+J?=
 =?us-ascii?Q?ar1fmRoWzr5OSaxR5X/w213cSXzjIfL0lYmGTafmBPNv0V+POVlwjbE8/E3x?=
 =?us-ascii?Q?ApYQS8+fi2vpt67Tl1Z3yce8cy0FZrb6Gqo6UYfB6+/9JIPhBIZZMVud8oIz?=
 =?us-ascii?Q?tMwnYzfR+Kj4BKRmnjvyQPq+rWU8Pxx0usd7PAJB170GGmPmGZ/MY94Vt1Yh?=
 =?us-ascii?Q?R0gfq6DZmcKOZLKLUnI7fLo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8c9647-1d0a-4400-c94d-08db63354f60
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 06:48:02.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oVcGygWHdx8pFQtROALuWvHm/9VBwJfXvyNEBJvzeeTuejGvx3prvmESVDdZtRqkmLqSMkuZC1pg2NcYgbfd73fs7xb3ty7UWJJuQaqCABc1ThofCnsqFlVDrhN1Ebc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6970
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
>> Split the 64-bit register accesses if 64-bit access is not supported
>> by the PMU.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
>>   drivers/perf/arm_cspmu/arm_cspmu.h | 1 +
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index a3f1c410b417..88547a2b73e6 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -701,8 +701,12 @@ static void arm_cspmu_write_counter(struct perf_event 
>> *event, u64 val)
>>     	if (use_64b_counter_reg(cspmu)) {
>>   		offset = counter_offset(sizeof(u64), event->hw.idx);
>> -
>> -		writeq(val, cspmu->base1 + offset);
>> +		if (!cspmu->impl.split_64bit_access) {
>
> Could we not just hang this off the 64-bit atomicity property to match the 
> read path? It doesn't seem like there's much benefit in micro-optimising for 
> whether the interconnect splits 64-bit accesses into 32-bit bursts vs. just 
> not accepting them at all.

Sure, I was actually wondering if I could use it or if there could be 
a really weird hw implementation. I'll change it.

>
>> +			writeq(val, cspmu->base1 + offset);
>> +		} else {
>> +			writel(lower_32_bits(val), cspmu->base1 + offset);
>> +			writel(upper_32_bits(val), cspmu->base1 + offset + 
>> 4);
>
> lo_hi_writeq() - the header's already included for 32-bit build coverage, so 
> we may as well put it to use :)

Oh, I have missed that function completely. I fix this too.

Cheers, Ilkka


> Thanks,
> Robin.
>
>> +		}
>>   	} else {
>>   		offset = counter_offset(sizeof(u32), event->hw.idx);
>>   diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h 
>> b/drivers/perf/arm_cspmu/arm_cspmu.h
>> index 51323b175a4a..c0412cf2bd97 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
>> @@ -110,6 +110,7 @@ struct arm_cspmu_impl_ops {
>>   /* Vendor/implementer descriptor. */
>>   struct arm_cspmu_impl {
>>   	u32 pmiidr;
>> +	bool split_64bit_access;
>>   	struct arm_cspmu_impl_ops ops;
>>   	void *ctx;
>>   };
>
