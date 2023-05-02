Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7CD6F41F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjEBKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:44:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A89193;
        Tue,  2 May 2023 03:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyzEV0kpNGc3ALhiX4xYV11vBrfsIWWzRiuRgjg7gL+aerCukKRTUjcjJNFgr3/ylOEiJQIth8rS921tb7/WT3NdJs7dMAX6mLXsY8vV/5sN4/xUe2cPuxQxSJ1pXTub9LtcSZ4ZvSqWgHHLgMUmxYNhqeyQZ/Mbr5y3vVt2vhh8id3umERSluJmY187uU/4DhWhaeiIB2HG2rzjnuo7cG/xsXkwk4P5cbmLmRGeM7w27x/HxCYvmzmU1QbYaPwpaxC5MX7wjjkS20DbAKUr6rI2uSC5GpM2LDzxWXumO77x3yRXnwja6Yo55kWOXPgVupBkQSHMa73OGgsdi2sC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9VHLAL1hQLXamOXByDwQ3yt41LfldCgFq5QeqWkkEY=;
 b=mcnc5ZBZYtbZGXGbqqSI10WhpxxxTFAFK40Nj+wFbkF6mT7hXtWzhg8lgJ1WbNHhTZBHRrywxWdsAJN0cm3M+VveXsfhPt9hyRwz6mYPep9Ok60Uy37zYLV7fzwsMVJrmFio96kk93hYOZZzFYHXeL56alF2wutzTgGtJ9ZFaT39MBhelTYVUdgxRDCAxlh9it+6VMOOsjP1E4Pw4AdMeCQMbVxH8uKjbRlzj5n05oax+ELhHMs3luz2f5yr3glRkE7ztMP9FwcIMOfqhZqDKfpAcRnAfLzDXNhGWvpA3srbCAHJGGiYIcGahRMmLCN+1FJcWNwfZ6CFka77NuaNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9VHLAL1hQLXamOXByDwQ3yt41LfldCgFq5QeqWkkEY=;
 b=vEcWsmGkjNZ2BUrVMHgIlseNdpKN0kjiYgBHeL+dYwQ1vbxhB2FVKYdsaHz0UfL0SkVpT4Pg2OdwPHR2x/Fc5pijjsZwP08RLv3CwSBC75YXIWGvKaRgofzqR3Iq6Qis5FzxAhCfOwEOXUQh4nfNdcSZ0+kyw/f94zbNyZbeorU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 10:44:43 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 10:44:42 +0000
Message-ID: <e3a87977-02a1-eb34-593e-844adc6669b7@amd.com>
Date:   Tue, 2 May 2023 16:14:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 14/46] perf test: Mask config then test
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-15-irogers@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230429053506.1962559-15-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: dd577888-f0fd-4df5-c1f6-08db4afa3cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtjIqYFkWq2+2KyRYLpNJ4TYvsHWvEZWnUbMVvfeMeSx+RNwOqTmPwwvJ0ak2OZkQJCh1trTNgo15pLjUzwyf/Gg54NTMI3GkRM7SGB+Qm7i3qAIKcutuoxj1/dmqujbf0wW+RmgQGwmPHzGR2ZCDD4nX5E+/26Vc91OAlgaXwNCaIPwpK90H1Gq+8bO3JmBY3xyr5s+XwEY9JflB1WOOGXu0t2UUAqGAlJa8eP7OWveR4i4gQuJ8MvuykIaEZSDv7TAZRGJ8IoTpMHPJJIxn+WlfJMIukVqVrBGAaSgZ0u8es9asrKGxHiFtAroEsucUtExQI3I0zoEHnqkflAUs0Cia144+HgWU5GMzZr2tvNGnp2jhCDgq/5rxJEvRjalMUyNIcVHn7KBUiUIlntqYPm9YIl45KYxSWh0VHzUFtIqiRz4oZLUy/TDt9gBymtbI9PRTsuJJ0zVYf7znWOSk7hzE52lObK4biU2Svw6sG0Uzj4+MLkAutgKxQ0mv4KK6KLGj9J6fpq0I90+OUc89l+Zv3Ch/29/e3hDHTVHUi7LnPoQRfZ1FjPp9Wx81YyUaLV+vFZQHiYNmodxWkC/EK3uwYM+Z5m4RHTn5bPaD/8a9Z04cTH5Njf/2vtVMF8FhWJjYizw10Ckqgr/60T9BGeUtXLMS6oicMCd6XbVVIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(6506007)(921005)(26005)(186003)(38100700002)(2616005)(8676002)(8936002)(7406005)(7416002)(5660300002)(41300700001)(36756003)(2906002)(44832011)(31696002)(110136005)(86362001)(6666004)(6486002)(478600001)(6512007)(316002)(66476007)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnU3L2xwWFBFWUJSNHd1S1E4Rys3Y1FIeXZicnNvVTNmbG1ybUdiNS9RMnl3?=
 =?utf-8?B?Z1ZiN3hQVGlWSDFEUU4zRlV0U0ZJZ3pKb0s3ZGE4Smw1a0FUU3JzblJ4RW5Y?=
 =?utf-8?B?QzhqT1Z4L0hGOWR6cEtNR3ZSbDdtS2FWQWhuV1RaSW9kVWhNZzk4bkR1d2Jl?=
 =?utf-8?B?TUZROVFoUHdGRW5OVEs2K0ViRVRTMVhSYy95WnoyRGdYMHcyNGdqZDBOQ3Jk?=
 =?utf-8?B?VjYwUENpZWRzNmJNMTEveEVwUndWUU1tS2VJbXhBMWlranl2RWxOUXNLdWRX?=
 =?utf-8?B?MXlsUmVhait2czMwSEtBcEw2eUZjUmR3R0IrUW80WmlucWdpOVhjVEJ6VkY5?=
 =?utf-8?B?T0ZVaThybFNTUmpjdmh5SlBERFpWQi8wR1hvTzR5UWRYRmtkTlVRQzlBSVJy?=
 =?utf-8?B?eFZLSmVNcGUvVERxYnc2RStQVjFTbDhKTEJKN0hEQm5hcjJMVUlVQ0FmQ1BL?=
 =?utf-8?B?NDlrcmtLaDFoalFuVld0OU43dHcvdVNsYlgxbUlDQk9NUkQ1cWMvbGpCREs0?=
 =?utf-8?B?WnJiNm9ORmIwa0Q4VGVzY3QxS0FCS3hSek5xalJONHIrLzh6aWgwdEdzR0ZD?=
 =?utf-8?B?T1VlclNDVzRMV0N2VHpNQ2lPenZyRmx5VjZwd2pGRERMeHNEWWJha2paZm51?=
 =?utf-8?B?V0VZTjRnR21TY3NxVHpiUklHRG1IN1lkVXJmQm5NWTlqNEVwRWdDcWZpOVo4?=
 =?utf-8?B?c05tVGZqdElIaGtkZ2JtWWlSNzJpSnAycWM3elRLYjR2Y3owWDNZT2ZGRDhh?=
 =?utf-8?B?alZhazZmUGtlY1JlY2Q5UjkvQS9tUWk0Lzg4cDJieUh4TmNzajBPZTNYQmJs?=
 =?utf-8?B?N0RqdGF1ZEdtTzBjRGtOMTYwdURwZnMvaEVmV0o2S1VIOEJWdlhBcTFNL3B3?=
 =?utf-8?B?NURGOXlja3Y3b0hyUkZ4UWNnOXUyNXVKR1hBYXpGM1lxMDlYY2ZRWmYxaDAw?=
 =?utf-8?B?Z2pTRWdhQ0RvVmdnNThYVXdIRUxlMHZENjBiaTh6MEpOWFRPcXhPQ2xOdktQ?=
 =?utf-8?B?YjI5S2Z3dEp6K1pCREFkNXRWY0RxYVZtSmVMWXJCZjVvVTN2RzR5aXJNd0tU?=
 =?utf-8?B?T1VCRCs0dnJrU2hMbWgrVGxOY1RFOWtHWnMrTStidkZwU0Z1NWROdkZwUGdx?=
 =?utf-8?B?bEFzQTd1aUpCTndIOVI3ZzdYdWZqY1NLZlZwL2REMzR6UEEwbCthNG5LcDMv?=
 =?utf-8?B?RUJOSmh1M25wT294RmRaSjl1Wm9OZGVnZXdsNTBXajRuU1JwME5hWDZsZW1W?=
 =?utf-8?B?dXdFcGx5RmhKK0dSTmRlaHJPYnJuN3kyRjdKMEtnZ01qd0FCZHNCU3AyMEl4?=
 =?utf-8?B?MDdkYXlsT2dsWjA0bXBnS1VwVzZzdzZlZnhRV0R4TDRmbWwyaGVCTVRrS0NN?=
 =?utf-8?B?TGs5UzloOW9RVk5abktLNU1rVSsra2JidGNRYW4yNHpSUjhMRHlDNzRMRVZj?=
 =?utf-8?B?bDE2Yzduc0x2aDVGWlVuelc4YU5sUEpSZWZZaTZCcldCL0JFemh6Rk9yek1M?=
 =?utf-8?B?OFRTdWEwNnFvN3ZJcGJKUHVlTWVmTDV2K0xBRk0zS3g5OGM3YXRGb1l1cWpL?=
 =?utf-8?B?RUlEY0o4cjN3WVdQM1VucUx2OURxYWtoak9iWHZJanA3OTU0NVI1Vk5EVmFs?=
 =?utf-8?B?YUt1Vy9MSHVVWHVtNFk2WEtVOUV1NmE5R1RESFV4YWU5cmFzUVA0N2U4VHlp?=
 =?utf-8?B?UzlkUW8vVWRPUndHNm96eUxkVVFFN0NQb0FVeWZ1bHZnUm82ckpLR1N5bmxQ?=
 =?utf-8?B?VDcyVEptL1BwZ3JrRm1hVFVBaDlBbW91Y0JQRXZSOUtTMUJORHI1YUFrQ0ps?=
 =?utf-8?B?cWUydU5FZWpFVHRvWlpyeDZ2R3lpQ3psYktwblRUNjBuUEdqUVovZkFGUy9S?=
 =?utf-8?B?aXFTeXFHVWZVQnkrU0lFdzBtelJlYTdDNWYxbGRoK3l1NWxnWkdYdnRlZVRB?=
 =?utf-8?B?OW9Mc0EwdmlXdDF3QjlDNDhoMUk1aXRUb1VvS0RPOWtwd3lSQmxTUnF0Rlp3?=
 =?utf-8?B?cDJ2dm9MYlBDMjdLMzJTSFJxakJhR1BDVEREZGZRdWFyWEFyU0pyS3JPZEF1?=
 =?utf-8?B?b1dzUUxZb01TUVhjd3c1OGtJQmhqSyswUnpnWWhKbVZKcUVyOWVqa05NTW5o?=
 =?utf-8?Q?L9upDX/TZOMkgn354DWJUCdlt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd577888-f0fd-4df5-c1f6-08db4afa3cc8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:44:42.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQwBdfDbJF6kT9bLkwtBtHgbQZ3b3R7q6KjamzWSUKcXZRCetO4XBbzsmcRy9oo/qXeO0MwW9CK1/5qMhOPBZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -87,7 +92,7 @@ static int test__checkevent_raw(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));

Extended 'type' via 'config' is applicable only to HW and HW_CACHE types.
I think we should not apply test_config() for other types. Even if they
are ineffective in these tests (because we are not setting upper bits),
they are semantically wrong IMO.

In fact, AMD EventSelect is 12 bits and upper 4 bits are located at 35:32
in PerfEvtSel register. So for RAW events, upper bits MUST NOT be ignored.


> @@ -139,8 +142,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config",
> -			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));

Ditto for PERF_TYPE_SOFTWARE. We should not use test_config().


> @@ -160,7 +162,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
>  
>  	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> -	TEST_ASSERT_VAL("wrong config", 0 == evsel->core.attr.config);
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));

Ditto for PERF_TYPE_BREAKPOINT.
