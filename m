Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE027395D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFVD2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:27:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B241A4;
        Wed, 21 Jun 2023 20:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv2+ThehBEtwySybBP2RAiJS8RYKUCNtu53fN0sHCycZ39ieYNT+5IVnV0tkCZ/N6y8AKmjYok24tVHozsSgzFTCQGd08MtvZZGnOTewU0bAnZpaErFl8Yv9JbLN3NNK+z9QDDYVeR4m8SsjN/zvr/egznTsEIDqPiIxZkhrVlLWewlr+dpHtkReywgFr8YpiPeAe5SDzmjdLdUZsDgJwksDXUj7Lkd7H6wx74KE2Uwq7fUdSamCJMGYacjtPPVD41F2IJ3rkzWWy0pxc3NADnOvAt8npHWgEG41GwWQkMx9qMC10I2EIX2h9IYvEU8MSj1PugWu7W45dgnC+saj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS6KjuA/ocBphZQ6k8bzgz99fHmfmbPZgubNkqWr3Po=;
 b=JCVK2rlR9ccaAnYa+YYOtEuhZrOabgbxkTNELht1eV6qOlFodZ+9KiWc0XgTCKTYsdxMrqqnrjzmbFQ7JGcVws5nr8tT5DZKPRDAcfKmyCOzJ/Bd3zfqGxtAnKCerqQIplZuQkUKcL8BecD/Z2iRbcs3Rl8WzAi03Z1G41muT+wo+BjT1e41ytBRn/FRbXRQoQOyDjfvq4TPniYq32IYktnK+6sjHp8ATXxIGzyiOhONcwdRxn7KX1H7AVcXI4i+IgUmKixnUE+lWy3k1L0kwek1c+Z8f/j83PJzWZx3/IgjJshtBao10aPzLUhH8h2PHxMJIiXLVU6j2EQG8ba+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS6KjuA/ocBphZQ6k8bzgz99fHmfmbPZgubNkqWr3Po=;
 b=HckOOpQtk6r+cLa4G+1RKzYyuMy9JjUReOtRialC6COHWJIzxDeomB7IBhwEbKXJWO6zg0PV6lULu+6/V9bVM83hvSuH4Ssnakgh3Dpfj4RIMW0dmtmwKqKYQLVQ6Zs+NNaH+BMqN6p9qbUqPSR0l5xet+l+jzVOoZDUOVoPKPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA0PR01MB6155.prod.exchangelabs.com (2603:10b6:806:ee::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 03:27:54 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 03:27:53 +0000
Date:   Wed, 21 Jun 2023 20:27:40 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu
 events
In-Reply-To: <76bb2e47-ce44-76ae-838e-53279047084d@oracle.com>
Message-ID: <e8ad583-9650-2ad5-5447-a95ac9fb686a@os.amperecomputing.com>
References: <20230427223220.1068356-1-ilkka@os.amperecomputing.com> <76bb2e47-ce44-76ae-838e-53279047084d@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA0PR01MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 293d270a-1471-4776-6342-08db72d0aa14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjTVEk/3zt5qnrcXF7lKxIVN1sNIUMmbCj5VJgKcD6M744pG6TBr1vdxbslVTIhxyjUJsb52rqmtLQMW+smHKTIHtrl3ltd1eAo4LPQTOzxylUuAta2LyBxsaqVBvGcJnV/8KNUbNuQA6Rc9WHJLqOp+9Zu7cDI9726s53zGhiL7pIjbcsPCy0cMsUH6NbFpemKhpQ8vZ915IzyvwNsvrriHbqherSAtLDHXM6w2MslfHFx/fC0t/5IHuaBZ6w1OKWdslO0TOpveIMiJP3nhoZgdjaA5TiEHVsiUsN+vUtncF8Q59/Tnof2DBSCxxD7UVf14Phk+OywHdY8uRKrGCp4Ud6EW9HGsSlUm9ccHakOz7UrpxcrqHR8NKsNXX9KpXCJYAEWGl82bQHFr1Ms2HCGdsPWTIuKgofzVEKw155bOvJ527nEGuRL4die2DlyoiJA5JFR0apHkUoB42IiB+hikb4CbOrOofjW48WPDAg2wJ86ArCHaGwIpowHsKB7ZNwS8VePJx9iG3/Y+snO2pALIDSal5mdKU11s7cgu6feoywRCsK06fgGx2GWR8u/AZGtVYov9M92TekysWZP5BcdkBHD+7KrH5W495/QyTpyAQh3TZx117EicvYpeI5H3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39850400004)(451199021)(2906002)(8676002)(8936002)(316002)(41300700001)(5660300002)(7416002)(66476007)(66946007)(66556008)(4326008)(6666004)(54906003)(6486002)(52116002)(478600001)(38100700002)(38350700002)(6512007)(6916009)(186003)(2616005)(83380400001)(86362001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51MZ4aNbRBi8wO4/MDOJHOfqD/6T3BWYRg2bnVGUbg0VWIdoOSiV0/5nfaDY?=
 =?us-ascii?Q?Xf550e+ix8uNA9oczhgs3WLe7E9hrYpmC8i7iPiDSHbz221bgYFLYqnhqDbK?=
 =?us-ascii?Q?6eX8L3hLGOjESmjMigX3ciZErxdt4Uu7+AZ9p1sGN8xZWz8cpvB1kWTISwZQ?=
 =?us-ascii?Q?VphH8Lieb0CpY1ec0F33ILWSA8QJblbTcFIny8HJ37h2o6lni60yfI7SDaBE?=
 =?us-ascii?Q?QGpleRzimNhGOLmM1gZFRcJNcbF3qqDQAzzO0Qfu4pl7mm6C9RFktEAsDwnl?=
 =?us-ascii?Q?WukUGCwM4tz6C8c/7Q+OqYGF8LC19XaMLibnwlVVNybdMljOLH662idAaMCd?=
 =?us-ascii?Q?tATq8lbcduQOsG0uETrvEXYYMMNOmIHjV8Cc/ocs4VERqU+lE4vUESCa/sb/?=
 =?us-ascii?Q?oXVLZdqQ5oVbhQpDUV7Ax6rIMJR9I90ItXyVCm+HbGXPG/FNh1Rx5/WuGANc?=
 =?us-ascii?Q?4tJULGgtoHkPmC5Go/gboGPeTbwvOy1gtZvfSe/QjytP/RbG7UWR+ePfgBbg?=
 =?us-ascii?Q?poWOSp7CIKO928186m6hUFRSohgc0Gs7S6mwrbVnQHw5ReUW9I3CXI1SQhsQ?=
 =?us-ascii?Q?DW9nUSmFn/Pxa0D+4C3Ku81APLjb4tXDGAtUfFkglVGhMKoJdS+wfpRrG8Tl?=
 =?us-ascii?Q?p1qMYTr6vE5h6erHG+7HSIdQEWxu3lJlgPlzRGuHO1AhYI7JtxlcZUg7F0vp?=
 =?us-ascii?Q?VBK8HLAs5qqcFakIvMFLsERTHNUHMykwkcb5VIRmRi4pTBIWNSETBIT7b/8u?=
 =?us-ascii?Q?HogaZF4lwpL40p2alrJlQXHPplBVYavlWEL9CyGaaQAf+PgtvYS1n9mb+w4y?=
 =?us-ascii?Q?XJq03r0QErwQfC938R2iG+aKJH+KFxNfHPPR3x4bQyT5Rty+E3cImblff4YO?=
 =?us-ascii?Q?3SWNZyMK06EgASjf5oPB19Pm87w60AdWvtwQ2eYNp16I+8x08fLOqyhf3bQw?=
 =?us-ascii?Q?su5qlvctw3y36sy1HlwRpp+WG0P3wEPhIdBLm6SPcdh+hiXLdAhLu3kuPUKR?=
 =?us-ascii?Q?Amjv5dZxrVCxtYUKdiDKgF4u6VqJr1uaFvmri8uswToigrgeTV6twIbxpPWG?=
 =?us-ascii?Q?eIfKgbQHSFQxj0bWbjPowTF0dvyrb1SWeV8l8jjnm4Yn1B7hfojRS/SpTtbr?=
 =?us-ascii?Q?UdeM3EwUab+PWSUFFpLif9qFkJx1uFuaVhAm2hIJ7cUvCdgeKPdiZegqSmm7?=
 =?us-ascii?Q?dMVBOL4jC54tiayO+stZt3/x9vCb0oqygxr3ZUtos1RQPSM9SB/RWPMHbBHS?=
 =?us-ascii?Q?iWQR0444BI9b+xhgE0qDEYKlpdHZ1C7Ip5+bUmSZeDmljp8+kpGwXnD1r7wf?=
 =?us-ascii?Q?wkc7x6Luy+fEuFGfHfdo9GKNvGwaew8SLkV7ZKwsqyqDdZe4UsmFjkt+zr8Z?=
 =?us-ascii?Q?M+W/lueFbs6S0M7SCOXgrguUyK4YzLb4SbiKB+XAvtXo9Zr8ei641ZtH35fp?=
 =?us-ascii?Q?EoJXNH8VonqTf7s+Sc7QT6opgyWyn9x30UkzfmTisG0quGNfTCMrAZkRsKzb?=
 =?us-ascii?Q?u1JvMjwQkOGS4VJo0/18Zk+2bB4hiWYfhsRrTHIDQMbotE4nGafLGLrl1n8T?=
 =?us-ascii?Q?9BFjYen3IVaF0nQlWmNLBdL+b1w1QKZTsdd9VMgbkQZ73D2izOZnlRMhyWGP?=
 =?us-ascii?Q?8/t4m6nmki7oE4gtmJQ1s+k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293d270a-1471-4776-6342-08db72d0aa14
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:27:53.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO5FzLvFsBgXcd55m2o9F2+RplVkA5/vhz9j2JvJ/5Y/2wA7nh8EdGi+f/xI0Np6c15u44u8apCRamq/PC6deFL9NdlgvsE4MQGO8a0IvD7B58cSEI8v5FUUrJ09yr3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

On Wed, 21 Jun 2023, Dave Kleikamp wrote:
> On 4/27/23 5:32PM, Ilkka Koskinen wrote:
>> Add JSON files for AmpereOne core PMU events.
>> 
>> Signed-off-by: Doug Rady <dcrady@os.amperecomputing.com>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>
>  CLIP
>
>> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json 
>> b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
>> new file mode 100644
>> index 000000000000..fc0633054211
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
>> @@ -0,0 +1,104 @@
>> +[
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_RD"
>> +    },

....

>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_LMISS"
>
> L1D_CACHE_LMISS is not defined anywhere.


Good catch! I must have thought the python script would at least print a 
warning of missing event as I compared the build logs with and without the 
patch. I can prepare a fix for this and submit with another couple of 
patches. I'm hoping to be able to do that by the beginning of next week.

Cheers, Ilkka

>
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1I_CACHE_LMISS"
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
>> +    }
>> +]
>
>
