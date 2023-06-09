Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0259B728FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjFIGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFIGPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:15:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC11FE6;
        Thu,  8 Jun 2023 23:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU1ZewMe64+SGZqM/H0i+RkS980vFqqNWf4WFG5Yt31/JSXbMg7DzpWz969WQr7+JesxNseJu8vQ2qdCzEP9HwhkiRbEvsa0EAPhUELnjizJOKLnVBJXgBCmTvP1ey7a7+Y42VJsuOWK1MsxLccWX0tySo7UOZeH+9Fk9Q1E7Gv4B5gRfZ8GEaTq6cQir4QTAjjV30LKNMV2dV3qFUTTDQ5Hoag9hgy0bDFga8mPAcf7N5hO/nHJ8GZGiHPlhOG4fWQDAPAighq/RHm3/z2b0GEoeS0c44x7Jp3NNlKmawQATG8hcMSBjOCPG++m3qHZrFvzlFoCIJYWpe2vTqGIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYjukGFlYBU9IJwLN5mWWbqBp0Hx/7lLM8FgZMPe5d4=;
 b=QyaBgIyyszstZbved5NArI2ylok7KDzHJLvrTXX03lPmSIbBvUHiGphY2B/Uoh693qGdpTnHk7wHVVcKG59Qiq90iWjk/OPZt9LoANLEOUmDMgJhMMF9MEa0T4sA0/4Td4yD3Iph7B9TlDrIXz5elejGHUKcvQ6sDb8rs6/X6wpV+ej+M8neR8hYM8l7OEihVudxdT7q2vaJ6drfeeU4NGX33MzHKEr3kIGjRoIPPNiLhx8uNTHcr0zFbT6ekFboHuT/F+EnC6yLLd5txQpKp2pQ3nUInBcLOKa6ctPN4+Ep8igGZvK0DWIQmlqpZJZIMiLFRSE7riT6ldgxx6iJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYjukGFlYBU9IJwLN5mWWbqBp0Hx/7lLM8FgZMPe5d4=;
 b=O/qIgYzzvMhGRES9zQBYK10WkyXhDMZvZ5l/JRba0pUvXAOrHTOi+LHOoAmL/4Od/HNRoc0sDycvGIZEgeKtswjCrJMnPxF3HK9RF05OKV6utmUjmRRvstzr+/QT8AJLLW0fGJe80kBRR1Qy9Ea8Nb5XipceM7Usu8mfpTUxz7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 06:13:13 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 06:13:13 +0000
Message-ID: <7d0ddbeb-c7a1-a5cf-9275-e1d9634cad0e@amd.com>
Date:   Fri, 9 Jun 2023 11:42:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 29/34] perf pmus: Allow just core PMU scanning
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20230527072210.2900565-1-irogers@google.com>
 <20230527072210.2900565-30-irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230527072210.2900565-30-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d439562-e136-4a4a-360b-08db68b09b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HLx16aBS/rS4lfCKqT9kMROBX0CBX70q26DiQ/JDGF+Cxkkw2LASwE0MvjefnZEDr8Z4KoOHGJGK2UFKHvJdXeoaEgwoEf3T0sl6y7D1c2z8hlWm/+nn9w2YT9IRaUuJ+aPr0QPW2x7SP/XcxYyqviVSP08I9L93EgombtQECqVAV6RPjDPQuTcVcLSk8yifyFw9cPFQvEJRT1yEmM80tm2LMHvpEZAPpDTz1PeHPyoBkArj+LhjfITgUq40+CX06GkMNxLv5ORGZRRAzalv164nhIk1lVCNXGbrF0LDRxvoomhxKb9mjpUHaPdSYjilCXoVM3lx18aGyFCcsqI1fD5OcwyaPXM5NCnY3kUmugQCJ4xZth1eJXcSjesCo1BaRSa7P81QXRe+B9Vv15CUmMoApuuPygqcBNQ5cscieUajqLkK8/ngPZc5orBBWXWyqU7w/xtuoBfRWAf/7deUJAt+p6Vbg6FN6NI1sJLxU91AqpzoL1lbP1qsz1c6pOqg6LArtvM1wbJJ4GqsBp+nCjFAn/pJ0tWi8IkgdDsrJ1CVgq8C8U+4WZeUpaCJad6fJKUV9EbizXqRaQgNG+wk/6vHbcZmWPFTbtYIpeiz+LIZlz3OzM4cGxojU33G6XqXBPCPzorDjxZIfjm6gdBOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(7406005)(7416002)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66946007)(66476007)(66556008)(31696002)(38100700002)(5660300002)(6916009)(4326008)(86362001)(6486002)(36756003)(6666004)(2906002)(31686004)(6512007)(6506007)(26005)(186003)(2616005)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UExZbThxTXF4UWkzazdydXFJaTdOYWtCY2lCWjFxaXVrRkFBNzdETDQvZXhy?=
 =?utf-8?B?N2szQ1JpUmR2azlUaWpraFIvRXhwd0RNbW9jNmxBbHM2MkxVRVFRcG1iMXFF?=
 =?utf-8?B?a01ZbGVEU21DM2ZNZ0E0NVJjU0VwcHQzTUNLdWZKQXVFSDUvdDB4NEdpdisx?=
 =?utf-8?B?Q29jOUMwTE1MS3o0ZWtmY3hmWE4zSDh4cDd1Wk1HaXlPUHJSazFYREE5UW1w?=
 =?utf-8?B?UnpGbnR1dnNUemwwbEw0bU01THNBZ3YwT1ZoTG1PZjVKZFRpVFJ2VFZKb1pR?=
 =?utf-8?B?UnJkV1MybUdMMjJLenJYRkpUK2ZycTVzSFpVMTZYNGRqWHRQdU54NEZxNGNp?=
 =?utf-8?B?YVVWekdnUVgzRWRlYVUwckc5a1E0VllYOFladk1jOW93RldQOThpZ242VzZM?=
 =?utf-8?B?YWVmYzd0QUF6bnBrN1BaY2hUWFdaWnBZaW90ekpTb09SWU10Z0RGV2t2T2dI?=
 =?utf-8?B?Rk42QkQxR2RZVlNvUHE3aVhXdmhiblBDTkVqKzZDSytMYUZIOWgxcEVoblJk?=
 =?utf-8?B?aWtmcm9XcTBKQ3BxT2gxTExGRWR2RHJwc0w4LzdnL04yN01pVnk4Zzk0VVJE?=
 =?utf-8?B?MVdhRUFPeUF2RjQ4Q0Z4WEVYZGNzTG9uWHg3ejBWcGREWUxNWEtKMERJM3BJ?=
 =?utf-8?B?aWhlOFpaaHhRcHRodjh3aDFxcU81cHpQd0xNNDVqWFBqMEgxLzlHc3I4U3ov?=
 =?utf-8?B?RlhOMThoMTNwaEkwaUdPdU5STWVLckNDZk43Z2ZGdFFHN2R2NEl3QTB5V0l2?=
 =?utf-8?B?K29aQitTOXIzTmFoZTNQazBYK1IwZlJ4OXdZVThta2FObmt0ZGUzYnk4SWJR?=
 =?utf-8?B?RE9mS2FMTWNBR3k1UENBT3R6Q0o0UDhCTGs0M1BORy9vMWMrMERHQkl0MnlI?=
 =?utf-8?B?TUVBbXlGQXJseGl4M1RDalZtNk1xWDdQMVlrK0lFWFJWWDVqczlQamFNREU0?=
 =?utf-8?B?SjF2cGlwRDZybWxJZ212aC9JN2ROcWU1L1ZHSkRtcUFmdFFyRzVRaGtEQnZQ?=
 =?utf-8?B?bDIyUVA5VS9OVTNCbjVObko0bTdHb2hERE1nMDZBa3BjL3p0Ty9lcFNqZW9q?=
 =?utf-8?B?ZDZGUlVxQkUvakRrUlUxb0FFRGg1REpWNFEwQU9pelA1amJkWHBjU0dHZ0Zh?=
 =?utf-8?B?OE04NVBtekh5bkRGYkpmZjN4YUhMYWtWTllxKzZIUXJUZ2dVakF3OTZnSWhO?=
 =?utf-8?B?NU9IdHNsVlJHc1lsQnE1UlN2V1NUakIzNnpMbEQzb2hma3FTMWJ0OFdJWjFS?=
 =?utf-8?B?N2xLVHpuaWpRVWkzbXFPN3puczUvVW13MkRFcEdhcUowV3NPUXFROWxpRFdt?=
 =?utf-8?B?VlozNitHRVlTTmI5RXBLY25UUXY1OWhCKytDYjRpeU5BbEh2ajEvWHV6TlBF?=
 =?utf-8?B?d2RyVTFMcmVEamZ5dWNKSndlUVFCY213b0F1amhROGsweklTdWFXQkxyY1Nz?=
 =?utf-8?B?ZnovbGNLdDBlTmR2aFFaaFI3UVFNc3hYUUJ3VGJkZFhKRmZ0Y3ZDOWQ4SEpM?=
 =?utf-8?B?OG0zcTBOTytLakc2Z2hONmIrZ0V3QzZqVUdsRSt2TWh2TFg2eXF2MU05UTRS?=
 =?utf-8?B?eU02L2t3ZW16cnBnN3JSQ2U0My9tciszamRjMmUzR1greHlaeWFJOWhsN2dF?=
 =?utf-8?B?L21vR3FuNlRUUU84RXlVbFFhWE03TE8vcWFuRG9kYTY0YmdHSlpYL3BMZ1JD?=
 =?utf-8?B?UDdZRERkaGs0OE1lQkVkcG9FdGpOOHlyWFdsYXlRcmtFM3JZUmt6NDMvMnYr?=
 =?utf-8?B?K25aVDIxRFV5UTNobnVwdTJ4REF2cVpPdDhpeWZ5cXR2dDZIRnFZeDBVWWRJ?=
 =?utf-8?B?RXJDY1dTczZyUzJwckt3b0psbmVJV294M0tSVEFjVEZaelk3cUxZYTBBUFJv?=
 =?utf-8?B?UU1qc2VJUGR0RXlWN29BbnpXR1QwckNoWDl5Qk5zOEdteXpVOS9BSVFhL2RE?=
 =?utf-8?B?YjcvT2ZxWkEzODkxRHdvL3MvOElzYjc1OWVGd1dnT3Z3QnNwNU4xNHd4Z2d3?=
 =?utf-8?B?Mml1M09qenBKUjA1U09keHkvMHBNS21xcERJbmw4ME56Q0lpblhaWkRXTVpR?=
 =?utf-8?B?NkNpNTNJTXhuditIWnlJc1NvaWh3K1UvRy93cEFNQmZiaExCY3I5b0tLb0hi?=
 =?utf-8?Q?T3A8pcadPp4r6wPdsBm5hiOYs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d439562-e136-4a4a-360b-08db68b09b34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:13:13.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18unLZue6oFlNpeqZyYNukrWM7nQfZZvvXsi1lEKnj4nrf3N46sge6x7I5YH3Bfu1ezbrRmbobDfv8Klvs0O9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
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

Hi Ian,

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 08ac3ea2e366..c5596230a308 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -136,10 +136,7 @@ int perf_mem_events__init(void)
>  		} else {
>  			struct perf_pmu *pmu = NULL;
>  
> -			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> -				if (!pmu->is_core)
> -					continue;
> -
> +			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>  				scnprintf(sysfs_name, sizeof(sysfs_name),
>  					  e->sysfs_name, pmu->name);
>  				e->supported |= perf_mem_event__supported(mnt, sysfs_name);

As I mentioned in other patch, AMD ibs_op// currently belongs to "other_pmus"
list and perf mem/c2c uses IBS on AMD. perf mem/c2c on AMD are working even
after applying this patch because e->sysfs_name contains "ibs_op" and thus
sysfs_name contains "ibs_op", although pmu->name is "cpu".

Let me try to fix it. Suggestions are welcome :)

> @@ -176,10 +173,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
>  	char sysfs_name[100];
>  	struct perf_pmu *pmu = NULL;
>  
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> -		if (!pmu->is_core)
> -			continue;
> -
> +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>  		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
>  			  pmu->name);
>  		if (!perf_mem_event__supported(mnt, sysfs_name)) {
> @@ -217,9 +211,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>  				return -1;
>  			}
>  
> -			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> -				if (!pmu->is_core)
> -					continue;
> +			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>  				rec_argv[i++] = "-e";
>  				s = perf_mem_events__name(j, pmu->name);
>  				if (s) {

Thanks,
Ravi
