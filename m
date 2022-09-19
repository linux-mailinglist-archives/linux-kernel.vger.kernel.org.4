Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B165BC29E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiISFy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiISFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:54:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A313F32;
        Sun, 18 Sep 2022 22:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOQFTPIvjseqVxx0aq6u/hTd7YmEwjY44GrSGav4+oKzf0abH6Iy4Gh17p6uUbTMMltZ0CqU9FBjKdb7vUHA6BBn4yClu9qEO9pxyj4nB0dEoWnnzGxp9ECQ1Q0H/GzFJNmOX58GwH3ubsrKqHVm9uDPhYFZ88fB/7+VOGeUFe20+gEz7RaOP+WaS0ljoED85CMoDGVsn/kGNOm64m7+LOfKYf/hVrY1YYFUwT+4BCQSHUwEAqItEE1hqHBI6/4hmdfGhDws3T3n+/OxLyTFr3GH1RegzVhuIKapXoeDnQobf9iqfLCrmAGir4t4J0x2JYNxk2fK+l4cxwJ3MeGY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr8IHySFCPTeOXNSOCpcp3HK3jnefZ/UIH/m4Rw3vBM=;
 b=l03PgMycSMyxVMWGVYLhZIxAVOrtVnjtf3MJzfIZEcIIF7cXuEnLFsHPo//GxdlHvHN5ejUvbIlXr/BYm7X7pUOkvHjZszjfHtmd0nf8akZTy+hjBMXHir8ferKJsrsZkNeiUyQ0cyNUpcxKx0gCE7pB2WYkT9/wzrV+H/0Wf5+gEZV6vUtfRg+WtDVzZHemlWEJi9AUAGYc6RmqD6v0vAAOVSjAE7aufiEyv9I6P5WHB051Oi9WegCcbgcwv6RFKMzd9WJM/WdK7KdeNMIXA8ZpunNK43Ls4XOyECar3qXUXCSWvC74dbsRMRscyURI0XegaPsnoRKKe/rsvmxh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr8IHySFCPTeOXNSOCpcp3HK3jnefZ/UIH/m4Rw3vBM=;
 b=toGGXRXnv4ijoMqm/ME5yw3gZq04T12HJkEGO8yf01hk2r9AbkyIgHWIoQ/ck6ptPTSRDZZFx+xkiAu0ruwXNFi4tss40tquo23D5URqZNJDPB/Q3oY8DUP2xBZLWmXhlHduH3rDehpfD3Y4NUjEG26wZDy0c7iF/dv6iivrC6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 05:54:21 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%6]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 05:54:21 +0000
Message-ID: <ecb6c1b6-132e-ae75-88f3-20b6793a3d23@amd.com>
Date:   Mon, 19 Sep 2022 11:24:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf test: Skip wp modify test on old kernels
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, ravi.bangoria@amd.com
References: <20220914183338.546357-1-namhyung@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220914183338.546357-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: c3549d62-6efe-4cda-7bd2-08da9a0365cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObrAIy7ArBc8+BGOAVkl3TuR1mgnRvMw01V09cAd3wo8hzMAcAFDjx1c+Ua5mPU0+nsdc2CRcXpya46UOX8G2tzRdg2iqufYfxm7sGTwXdPtogU2qatRrgMAszsGzMdgwkVa8tXqBBAxNKgqlg6pxFvHmDEAfcT3JUPB7E8po6opyqJThAGg1rxkkMQ3nyYybaG2F7//hmqPLtZEHX76wxdignH1sqohKs8POfUmwnctlgJxsa+0/xPG/FlBMqFLlNKEDWvUqd3cpd852IqB6JjooQHmym7UJ+yMqh9uE4lE4Fp+CXZCO/yfW5ECZ+9PZ/ptCBbLQAhqUA2YC6RCkr6NWDFdVQ4sey75Z86kXCgqvVczt+wAyqF22MvrXrP3DPznm/b6t43n/hS4qTFjLel/tr/yVeJH6VmDtts5jgTN9oYfV+aBABCVl8vGXYo7iiaDOrCS6pf1jOa/hPBSXVIkV/4oTwIglbYWrzOJhW4CdOqsLq3PZYR0cYKOz5cUWWGhB1QxKECco488NfVUAPpZPYjwGmEVlVpW92cJCffd12jJ+1ABababBwR50fuVXriMHqDyLPMgjCWuG+IupUvwuN1a+rcVbwaskOYPIKdmcS9xha+9/radvopSFgqS+yBUspM6pojUuVLk5/KeZ2Xo7YMox6Xz9bu6cKjATpauNKkiY0G//UJoVf4wWoIGAoBcRrXa04G/zsGavUU+39976LRR0ACBdhPT2deh4lqDPI/94L01W1L1F5esKPYXpvgM2Eq8jOn+ZyIsuLebWS/rlVyG7lGeQlWeSbXHgG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(44832011)(4744005)(31686004)(5660300002)(83380400001)(6512007)(26005)(2906002)(6486002)(316002)(54906003)(6916009)(478600001)(38100700002)(2616005)(41300700001)(8936002)(186003)(31696002)(6666004)(86362001)(36756003)(66946007)(66476007)(8676002)(66556008)(6506007)(4326008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JKSFV1WlhPZzAzRmhhaWcvTHNrOWZmeDdKUVIwN0pUZUg5UGhpOE0wUmFN?=
 =?utf-8?B?SG9Ld0pFN1lGbzRacFRoTU12NjNoNnIxMkRGanJaYmtYSVhrRU9lMjhwbVRm?=
 =?utf-8?B?TzlDc1JaOEROd0FvcisyQ1k0WE1rVGhCdXh0TnVpKzBWSVBmVGtTMDJmRmZL?=
 =?utf-8?B?NWJNRGxPQ1hNNE5YZ0RXeUFRWG9PYnRoMlM4dkVUYlNxQmdqaWd2djNIdlRX?=
 =?utf-8?B?alZScy9NV3RKV1NYQzVIeG4vSjNETW96Nm9HQStvWHUyYTF3UnFuL0RkdFIy?=
 =?utf-8?B?dExTTFNoamZHVmZNV2habFdxbXNPQ05JRzFJbmVtM2I2QWprWWYvMWdQM3o3?=
 =?utf-8?B?cXZCcUpHSXR3cUhuVzd6Y2s4V3FVOHQzb01yZU8wenlxekprRE1ZVzR5cmwx?=
 =?utf-8?B?UXdrMDRVVlNCWUI5VERCdXFDTCtkY2g0K3NpelNIRG8weVYwbkNHOElNSVZD?=
 =?utf-8?B?bHNhV09KbEd4ZmpnUmZtWUFDeXBQL0tKVFlKMnFjU0pmaW9Ed0Noa1BmTnIy?=
 =?utf-8?B?WGFHemNLK0tNNGFOWU5kN3N6WUlZT0phWEc3eTU2TDJVRlh2eHFlbjhsN1VP?=
 =?utf-8?B?N0k1WjJ0TWFUcDcvMGtXaDRDZXFKdkR3WitKRDVseHNSYU8vRGgxdmZOYUZQ?=
 =?utf-8?B?dGU2czhoQmp4L2VTSVpyNVdaNXRuaWRDWFM3TDM5SUs4QmdWRkRRODNobUJO?=
 =?utf-8?B?anhNM1BWZDlGTkhqc1Nub1dKT2MrL1I3YTYyaWlhL1RPRUE1MXZXMGVacGdo?=
 =?utf-8?B?NmtzM3g1aGRTNUhYWEpWaklnUjU1OEhZd3hJSGhnTGVqVkxhMUhoRFU0M0JM?=
 =?utf-8?B?a0VoVUR0MnpPOUlUSHUxUmw0TUFrN013aVRXMzNtUWVHVmZUK2ErY1VoRzFX?=
 =?utf-8?B?WTlCSjBQY1Q1M3g2aWNBbW5sSlZBTXN0VlBucHJWRUhybHF3cE9QQ0hqU1Zm?=
 =?utf-8?B?cUdLMVJkVFBFMjhOZGxkUDF2dmdrYVFGVG1hMU5IdVBla2dobG1vblI4ZXlw?=
 =?utf-8?B?UUJtV2ptSFdwcE5QQ1I5VW5pZnl3VHdkcEJGTGdpend0UG53dytQWWxDd0xI?=
 =?utf-8?B?LzNHVUtmQ0VwL29OZnhXRlVhVDlXeUdzMDRmcDBaQlUrek1ZeUdCajh2UENv?=
 =?utf-8?B?L3BXQTAwQmZqVHlLZkVSc0dkOVQ0aU5IL1U5MVVMNFNCc2M2Tmhnd0NDQ2FR?=
 =?utf-8?B?b0tRUDBxZzMrK253V2JWQjZySCtZTUw5M0VGbjFZcnlLSm5kTEJtckZaOFBW?=
 =?utf-8?B?aG42OTJ6bW9aSGtaS1ZnK0FaOHV0R2FlVGlhcGJkcHdEcjVReWhDMk1uRzBO?=
 =?utf-8?B?TkdIeWhZSk9kUDhWWkNEZnJvYzhaTU1IRXM3RE9objQyUDRsMmNwVFZvN205?=
 =?utf-8?B?SkwvOHVhVnFOZGNRWENPeENXY281SGlSYVdFcjcxSitLL05YbU16Yy9rYWlx?=
 =?utf-8?B?Vi9iLzVubVNRVnZROWxJd3ltVzRSYko2Zzd6amUvTUhlM1lvOW5yWk55YnJG?=
 =?utf-8?B?R0k2elZEd05pUzBUZlQvM0lzQzQxTXBzbHFKLzRMQUdVazFYbU9wY2Zjc2h2?=
 =?utf-8?B?cEQ5bFNCN1JqanRHQmJCQ2RtT05pRFpKNmwxU0ttS0tHNjhBOWo1aDBXQmQ4?=
 =?utf-8?B?VkIxbzliaFJyeDZ0UkJBRW5Xbkk2RE9mSG8vU1g3ZWd3Mkwrdm9kYTlNQU44?=
 =?utf-8?B?RTN3b0lrekxmQjQ3WnJURCthZ0hXQzlEK3ZsUHRVUGdnWFZ2V3ozZnRwWStl?=
 =?utf-8?B?bGw4VlN4WHJsTDlrYVlIalJMUDQ2Ry9ZRGQ2RW9QM3BiWmMwc0tVbUEwcDBM?=
 =?utf-8?B?c1BmRmRvVUNENzZIaDI0YWNNWmp2RXdSL1orMXpVdVhOaFN6TXgwL080bGl2?=
 =?utf-8?B?NGtUNUd5RnhSdmlDemQyV2tpZ2l1QXBPRUhaeXdQRFNDVkVSRlVLWUJuR0JQ?=
 =?utf-8?B?NUNnMFdyY21LYmZZQXphc1h4eFpwVi9UUUNUdHRUYjFSOE9vNHE3RnJ0dld0?=
 =?utf-8?B?NzFtOGk0M1lBUkx2Ylkrb3BQUmY1YlVpakFxQUUvdUU2dUgrUUJnVWx5Q0U0?=
 =?utf-8?B?RmNQbTg4UkFiQkIwTmJCa1RHZS81NXh5WllqQVFZVVB1cFlOb3cxUVdHL2xO?=
 =?utf-8?Q?RqK5xTjbYmZcynOmMafjhVVJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3549d62-6efe-4cda-7bd2-08da9a0365cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 05:54:21.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+FGXcwtj/pS8PRwAIWVt2sjTHnza0IIONBA/hrjZWhPP2Ci82SDjle/5T0DBW5+WH+vRb8Y9UfvPW7ZScFnhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Sep-22 12:03 AM, Namhyung Kim wrote:
> It uses PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl. The kernel would return
> ENOTTY if it's not supported.  Update the skip reason in that case.

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

> I'd like to add Fixes: 2e85d5979e8d tag here but it'd conlict with the
> later change in e47c6ecaae1d.

Is it worth to backport?

Thanks,
Ravi
