Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16662B2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiKPFqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPFqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:46:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB762DA;
        Tue, 15 Nov 2022 21:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwZE5KkFOQWGAMfjSz9hV1xHU8qZ7l3df87ethOuTwo/FvoVLpgCRuY5OJS6N6EUZGWw7lQIV1ZY/pj+XhGos4O+m0Ig2dqhJN36NgwEeKg4D2rUdshk9COxgkJVC43LO4lweDg7YO/q4Y2XPhu9+vmQLFbHH1X6dgUwmqltVQ9D4ZFMQEOx1uyz98qPwHfPVhbrmi/DduMY0tBNSrOsFm5I5v5YyVcQd1+ntHu79n+StBH7Y1hEh7AYe//hzY5rmCj3T26MQtQEc3K0MV9zcf063DdPDOEj1hL8+pCsgFze9cUiybG+s/Riy8HmuBM6093vlVR8ngUBZlgoO/8OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgsMhVU/VF+KS0Jt5J48KL/qHW+1VWVOkWSVrkO9rzk=;
 b=dsBiBuYewllbmYF0PiNDbspuAmbnRnrOUtBKND8SqSZTt9hF0rNp1tI5QKd+FDrei9knvAWvcMbCzQQsg67e4HEXmOAUQxZ0xuf6Ur7arqxKbJxL3pkNyzy1KblG/zbKUWaL2r+Gxnl7biTLldROV+/nyMv+Kw+X7jO2U0jGJQCNO/kD4BmOj5mbr9hnvzRwKo0LPsgtrtIRcyoj5E2QTQULwX5mOBOxWBmZEN9fbneR006K/KDMGJECLp4kMtIkGf7wY44SZD4Hf+bc8LRJDBdwxWPcd0skL2hE6jB1qyOQDfr5exg+y4LYieTKGhg8fZwng78ko54b49X5BwzAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgsMhVU/VF+KS0Jt5J48KL/qHW+1VWVOkWSVrkO9rzk=;
 b=dnf2zIktApcgfIpYQxTfdmQvdiZEggsmpWiC/9AB8iV9RFMjQs20px1/XzDwhQY6WsIEGEDe5zmsBh73MfJn/z+QI9FtZMr7LayhstGKRdPFKyjooTdzyFpasOtxWZ+26Up4yTqxVDD2hrSpVolk0GUfjAjtNWzep6IIk8i+xCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Wed, 16 Nov 2022 05:46:08 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 05:46:08 +0000
Message-ID: <d839086b-826d-3642-5be2-a62714457b62@amd.com>
Date:   Wed, 16 Nov 2022 11:15:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf/amd/ibs: Make IBS a core pmu
Content-Language: en-US
To:     peterz@infradead.org, Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
 <CAP-5=fXq-YNKogH4DYQuf7rz8TZhu8=QnEsA2pvzj6YS_DQO7g@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXq-YNKogH4DYQuf7rz8TZhu8=QnEsA2pvzj6YS_DQO7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 497cec1e-1d37-4f45-7c6c-08dac795dc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwzDmaqEQrEDIi29NilcUcSxqRGyPze4DW0ohvIARIbu4JNpRDZfWmifXq8tvwWpD51SEbFSqBph8p40n7t0o9Tie/q+Y7Kc3vOYvR2i1nudDI8BlEFpj+uCpZBHVgZgb2chJ+FkK3ldnTOFpz3OwaULlhBsyzcyrcbyRbwyD+jG8UhCbQRN3Blx2RbHF50CWYe0Np4X84PheRqD/8wK1LCYxwYvoMVAPKjQeNS7DepygTZV43GAapg8kW3/7DjHWsyKRw+FlgH7jobzx0TAn3uo745AaP3BRTUdZBdK6DYt7byAnrmxIJd9CTPeWi9LGgqKF3UapunJJtwUf/zgfIAZcBuPehJZH74cbGSTA5hNL7PWoPlFL8bSVtV4JlPr/9AOGIFe1/3ACVvqML9zbtwNPQj7duxISx4ZwqeA+Okg3F09sPBDMlRSQVFHZNvLcqRXvqQgitpRRafC4aSuu6Xp5c9wZTxj90hvZ3qrD+n2St/xNQUSYkTY58QNbZrEJ4izlMPcosFu2GEjuB1rVCKUoA3GucUmE2l4+7OsEJCXdwf2y+s9xVG1KkeSZg1BCuWpU3BuYZJYFxlTTFN0a1OIjrkI4Qo75ixpN5AI3sLD0aRTLpHcnqB+Ha0c5jRUPGmXhmNfJ1ySaIozyZV4NfzXASUl6j80ktAGAvVCC31si9KBHjRGoHW9S7iZrASoY223Bc4D5oOfLs/q2vdUlYX7u+ub9+75fzvL4O69cRgnwS153vYJoI+c2ZlH14cZIpzSgugJnw/yUKw3Upw2XTDG9SPlPtx477TK1DK+duw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(2906002)(8936002)(44832011)(186003)(7416002)(86362001)(41300700001)(83380400001)(6512007)(38100700002)(26005)(31696002)(5660300002)(66946007)(66556008)(6916009)(66476007)(8676002)(4326008)(6666004)(6506007)(316002)(6486002)(53546011)(478600001)(2616005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZOMzlhbUFxL2E3dGE4dlFhazFEYnJ1anVXVjNqc3dBZ1JETG5Jdm5qQ3VM?=
 =?utf-8?B?b082UXhZMDBMQkFwSHdDeVVyWjBIY3E1UlBqbUZuTkVvQWR5WXJoOGRvRDU4?=
 =?utf-8?B?SGVQaXZDWGhhemx4enlPMG5sdmJtZXFwOUlXYWt2Z3Z1U1NMWjkxcjc3eGVl?=
 =?utf-8?B?WEdHUkdIYnRhbWxPZDl5Yng0WDYraTNxUDBKTnkzVnROUU84bi8zOU4wdGE0?=
 =?utf-8?B?MjR3M3BETkZBYytDMC9RQzVrVitCbk9xS0lBdmU4UGk1TjNQZTRwZFh2b3or?=
 =?utf-8?B?cjFtdE1XVVBodnFybGlEd3VFcW8xMFdaREc5dFRSOU5aVGljSkkwVWtWS01l?=
 =?utf-8?B?L2ZpTVI3VUFscTdsN3JkeDkzWGZSclhDRGpGVnZ6VjI3eHhGNlBOaUJ4bUM0?=
 =?utf-8?B?cG5PbFE1KzZrN2xmbGIrRXZVQWpzRW45Q2JVbzFOVUFHZ2NWSjFIcFZjenZL?=
 =?utf-8?B?NVhTcW9QUk92Q1hwQlNWUWdvWHVVdFR5ejIxYlpYV3V6QzNhN0k5S1Y3ZW5R?=
 =?utf-8?B?MyttSHV0RkVNaWNpc0ZMSlcyaDZnR0ozdHFVY2RxOFVvQnFjdU8yZ0o5b2pj?=
 =?utf-8?B?bEdhQUg1ZjI1NmhnNGJRbjNmNkI2TlpGd01OUmUyU1FsMDZKbHFNMHJVNkFt?=
 =?utf-8?B?cEI0V0hvUzc3dEh2Y09CWHAxMTJWT2xBL3lBei9CWlRrMWZKMjREUkFHQjVt?=
 =?utf-8?B?SEoraE01aHJRQ3lsUHUwS0N6NmI4UUVYQTliZjFYSUloMDZkZmtEVDlOTENQ?=
 =?utf-8?B?b0xSbHdxZkR0amRUWDh5NXdrODQ1M3hhKzZoVUtESTBWT2E1NS9XZ2MycUNp?=
 =?utf-8?B?c1ZGNjZ2R3lLNEpkYW1EdVFPSzJpd3I3aVRXMnljZ0hqTThjbW54MVJRdUEr?=
 =?utf-8?B?TlF0cGxWRXltelJ6RzBaV2I1Qi9CWE55NFNkZmhKdm9WeERiUCtOaWRGZEQw?=
 =?utf-8?B?Y3ZkYnhYbDJQVm9tUzE3eUd2UXRRbmE0N21QZUhRakZxd0VOMnlZdzdnb2Jp?=
 =?utf-8?B?cDlraHZiVVVRTVVTdkRSOGNLVDVvRUtPYnl3MS82THpXNXRFSEJxWnBkbE9C?=
 =?utf-8?B?WFFIbmlLM3B6ZW9WQmVqRFIvVXJkMlUyeGJyR29iMG9QdlVCQk5Rb0ZQNWF0?=
 =?utf-8?B?dk9YZzVJSDlBMTRhTzRReFZWdU9mQjlINGRjUWtxRDNITzlPL2RaUnlQejlV?=
 =?utf-8?B?U1NXVCtQQjBQUmRIMFZyTFkreDFZSlZnWmlhVjBYR0JJS0w2Q05QbmoraFFU?=
 =?utf-8?B?WUxSL3FEMVNOcWtYSDlka2JBaFNMbFlTWXg2VG1kK2lCcHk0SHBHQXhNSkYr?=
 =?utf-8?B?ZzBQRWVldnlBZGFhcG9PUHRZa3gyaWNVUExZT0pZWUhFTzZINGIxak9PRzhN?=
 =?utf-8?B?dnZqb01lT21yb0dhZEFTTnlRWUNyb2NPVW54bWVKdUo1aldKb3NzU2NrNkVT?=
 =?utf-8?B?N3lSbWRGanZxaFBkV0lEbXhaZ3E0WG9PbVoyVlZWUjUrblY2bTZqVE5OaVNX?=
 =?utf-8?B?Zm9iY3pLQkhWSHEyc3lMd3QwbUFFNnhMUGZrMCtKQ0oweFhxejRPN0lQdHk1?=
 =?utf-8?B?a1J6V3pmS3ZBV1FiNmpobkxvV1NnYjQzNmhvUWF3TUpjZ3hmd2FOWjY5Uld5?=
 =?utf-8?B?TWlBVk1rQklKTzZmYVVEQVZmdjRlaUdjcEhJcm1CWkp4Kyttekg2WGVVbFR4?=
 =?utf-8?B?anlDZkFJOTBxRUZJdjVxQWRSVTVwSDhCeFVCOUprTk4xZ21YTlYxaFlBSkdI?=
 =?utf-8?B?R09VS1RGaE53bXVndkFNMXljaTduVWRGUDAraEk1cEVvVW1uY1RPNytpSFFC?=
 =?utf-8?B?N3BwZUZORHk3RUJ0NGQyK0UwYVdkWFViWTBKMnB4UkVLVXNYczhmdmduMjBo?=
 =?utf-8?B?eFMrTnRSZUp2ZFlNNHEvS0p4bHlVWXFkVi9ncWFuTkJiK0V6NkQyekxpSlFN?=
 =?utf-8?B?czFuNDdsWnE0TmxsYUpiMkRzVzM4dktlQ1V0QzhlcVRxOFp2akpzODlSTU5l?=
 =?utf-8?B?MmJwdDc3QlJBQTE3UE9BOVhFV2U5ZisyYy9kWG9zMW96M29SNDY0anBMd3Rh?=
 =?utf-8?B?ZzROdm9HTHdkcnNKUWNzZ2lWMmF3WUIvbGVTby9mOGFaS2lqclNwNWhyN3dI?=
 =?utf-8?Q?+SOrGW1UF2tCdzUaemdNFrUPj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497cec1e-1d37-4f45-7c6c-08dac795dc02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 05:46:08.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79YRyLOMQejTS8JnnqQLyEcRnpEV8u9kjLiTGBVx7NGyLEX0TdJzjO38wcF8ylCPSGY12omV2B1VZL8zyAU5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-Nov-22 10:37 PM, Ian Rogers wrote:
> On Tue, Nov 15, 2022 at 1:39 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> So far, only one pmu was allowed to be registered as core pmu and thus
>> IBS pmus were being registered as uncore. However, with the event context
>> rewrite, that limitation no longer exists and thus IBS pmus can also be
>> registered as core pmu. This makes IBS much more usable, for ex, user
>> will be able to do per-process precise monitoring on AMD:
>>
>> Before patch:
>>   $ sudo perf record -e cycles:pp ls
>>   Error:
>>   Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'
>>
>> After patch:
>>   $ sudo perf record -e cycles:pp ls
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> This is awesome!
> Ian

Thanks Ian.

Peter, can we push this along with rewrite patch?

Thanks,
Ravi
