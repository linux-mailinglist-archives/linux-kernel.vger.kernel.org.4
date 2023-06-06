Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2848F7235A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFFDNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:13:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AA127;
        Mon,  5 Jun 2023 20:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY1wSUpKGa2cqhZ2oHg3jDiD8WP/ar5JY+dpvcDmK2bxKaBnpHwhkkMFW7RUt/OeG3cnJ+7f7CStnq+tnUcfWFSv2E600IZd//ieHxSlp8mSsHUrOIpwPt5nk3oybBMIMA91C19NNpDy1gIR/sc/pk4Ygle5qVtCUpyvbMYwbl4MxA5GjN9ZFh5fIYu7nZ15417bQofo63zBcDbCqo8L4JFUPHdzwk0id4ti2Oy9Qc1a8F1I4aVkezeW0RPnQPE1HHDJCnobzEeEIMhpyoyJTub4Su7AkDDyZEOiwVACXFGaUA8eZYxYaBdHPL1vS9Z22qD6nPQgenIBOOI3nTqxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGGGjFZpAD76C3haysxStaLx6oqfGvPHBGD7Ut7jf8c=;
 b=CiAnivbYajlZ+kdj5mTwuC6sdX413nSYV39AKBfcqR7u1fG+VA9VzrnAVMflEae1pz7xd28Lu2kyLay2uwioBZOXXA+bnhjV6jH16LnpqfU9m7lN6gVggvfDnh+FLpK/SI3Z1yRvXbc4FExA/VQ/qsuCEm7tyB58BdRwtBC5iREzQsb2mLGi3O7pIBuoRcXG5Ym6nl5zJlU8Ej66hdm0JCHFYNDE5OyFQGtXTDf7y0cCjIOFeNUbdZIlxCJdX47wPRG0Qi1V73X+d0Xk2G/GtCSD+b7uBr6SQ48eRjlXqgr0JbjJRrplni7OwTiYTNXBOjkPbokL7KHYMgNqIq7MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGGGjFZpAD76C3haysxStaLx6oqfGvPHBGD7Ut7jf8c=;
 b=PcLhZtCadazsW1glMuvApwUuBhnTD77iCn3WZC+UIam9+xiZ/Oi7qmh0ya9l9r0iclzi+BDJEQF+IL6eAoJas5kNnNjxYqdkY0BoYo5A4Vp/DT2nWjRtXRITOND9l5umAWX8N0yg59Bmy1ZjF5gnokwNtJ7LWKj2Vo1hwnZMkIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 03:13:30 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:13:30 +0000
Message-ID: <8a1f34f7-1835-ee89-5ff0-1421ccc2e07c@amd.com>
Date:   Tue, 6 Jun 2023 08:42:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf test amd: Fix build failure with
 amd-ibs-via-core-pmu.c
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     irogers@google.com, suzuki.poulose@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, kjain@linux.ibm.com,
        renyu.zj@linux.alibaba.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, wangming01@loongson.cn,
        chenhuacai@kernel.org, sandipan.das@amd.com, 9erthalion6@gmail.com,
        seanjc@google.com, robh@kernel.org, tmricht@linux.ibm.com,
        tegongkang@gmail.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
 <20230603044650.286-1-ravi.bangoria@amd.com> <ZH3w7TWRQZsPqhB2@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZH3w7TWRQZsPqhB2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 406be41a-ab07-4425-ae3c-08db663c006c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhUCPRNgnfxlm7V9LTIsh+nxKlTI+lyZC3O5O15bYQVlWCPrfc4yFyPnY7YaVV6wn/E3Rjk+fE6ic0l3mU4W3Sp2AF/zXYZE/Mm3b6XyImm8iAi+QWx/rKozZr9Z8+nEzoECQdXHb44KghzDaUkISvshLbB1CMZgYJxhK9KYSuhLjQY9gDUQLsUfHgkHvuubqYpfUFwz9Re4hrdoAChrs4TVm+V1TlYpF3+/rz4rfeVEv1UoUXLSN9TBt/QW/ALH/0TKL57YKakSZiCJwSv6Vyxut14iR5vAVOKUh85xfmHIDnvx+20r9Q9rGNzSJncGHtm1XL2kFuYcaEQ05LnoLlFMc+9GfWUUD0ll9QjamX4O/PsroIdUGMoPCzTjuFKusos86E6ZgLGhf0kI/fU/zo+ozl/Vjyp/6btZd4nq3y9SMKItronGQOXvg4HdhnTF8FsK8RyeJhHSiyR9YKCuhuyStBFIX09P/U9lRJETkfZM6OqVtCTXFWbOD/28nkBf0giwmtFplFdzp5s9XffKp9cTXRl4UMNCjBjXbnT2IYdBjb5H3p/lO5iHa/UfcDFEj3EB9z9fg71vAZCfvHT0HM3emtn0B2FsJghkojAisnPjZQDp8PWGLztRsnlHyEvPnaWTpupDhi1sIXAx8SPmfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6666004)(2906002)(66556008)(6486002)(66476007)(66946007)(110136005)(36756003)(8936002)(7406005)(8676002)(5660300002)(86362001)(44832011)(7416002)(38100700002)(31696002)(41300700001)(4326008)(316002)(478600001)(2616005)(53546011)(6506007)(26005)(6512007)(186003)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdjYTZwdm96djRWSmF3QkREVGF6Y3BZeGxjVWNIampzeXZTQk5RU0EzSk0w?=
 =?utf-8?B?QngvUTdNZTZGV20xR3Q3WlFDMWVJbzFiaWJPYUxEMURLd25JY1J3aEVBSDdM?=
 =?utf-8?B?aW9qSUs2VDlzaDllVHdHaGIxL2VHR3BYdVZCZkNsRndDeFNZVG9CWHdDeE5p?=
 =?utf-8?B?NC8vb1RhdFBmSFBPeXQxRTZ1Y1ZLVFRWWWMyVlRBVVYvaDhhcVkzTmhzcjFT?=
 =?utf-8?B?WEI2cERXWGY5bm1mV0pwQjFxbjk5b3FCK2ZzNG9ZVkNWU0hWYXptSXdyc3FE?=
 =?utf-8?B?UzlSdFFFV2w5NGREUWdpQWt0MHIyMGdoQk0vdVp6RkFmQkFYbXZEbEtHeGxQ?=
 =?utf-8?B?ZVBNeVl1L3hEVkZoUStxOFVaVklCREovZUVZNDBxNnYvWlllcHJZeFBJZTBl?=
 =?utf-8?B?MnBNTkcrb3RJNjVDREZHNE5paWQ1ZUZvWUdyZzRWdlZmSU02TkNLQmN4enFE?=
 =?utf-8?B?MGpEMXIrYlNDSUFxbWhVRlF2eGVOREtOV2pMOS9zUzNVUU80aGdZOWg4MEZ5?=
 =?utf-8?B?eUZOcGh0eFJqUm45cEpYODlQSDVnMG9xOEhhVmVDdW5TTzd6R01lNm1wMnk1?=
 =?utf-8?B?eEU5QUlCWENCdnlCbUU2bmdoNDlhWlYrTWExK2FtNU92VWU3QUhDTEFRazBV?=
 =?utf-8?B?VGZCY2V4c3JvUzlpRXc5cVF5ZU1ZSlVTcmxkVnMxR2tkRUVQSkpRMUZ4NnRT?=
 =?utf-8?B?MkMxaUxzV0gzODBjRzg2bm9YamlLT254bHdzUDAyTGtOa3RVL0x4cjRXOHFx?=
 =?utf-8?B?ODc0UE42TktYeDVrN3Y3SG1VZzZ6a3FlMmIvVTlKblAvRm51Yk9ONFVPU3VT?=
 =?utf-8?B?c3dFS1FVVjN6SGxLVHBPcHAweVJmYTdheXNnYWZNQlpxbFU2RW1DU1FScUQ5?=
 =?utf-8?B?Q2tsbnJCZjJtdFNCYzZsZTlaQnNWMXcyK1FCSkRZUjJCQmNHWitiVkdCN2Js?=
 =?utf-8?B?NVAvTFI1OG9qa2lVU0pHMGt1UkJ2ZlJJVEdBOVNFcytsNG9iMWIxZDNtUTBN?=
 =?utf-8?B?Rlk3UnNHTEpKZjFTWFY0a3lkOXRBdHV0cjNWbjJ4T1BvNW41eGNNM3RTS1pK?=
 =?utf-8?B?czRFRFMvV3lVeGNlaDJBNGhGZ1pIRXpGWi9BeGJNRTZDYnpMM2dpZGE5TWRO?=
 =?utf-8?B?TGhrM2pERXh1ekw4YU8vdmtSaFU3cDFEY1FaeUlLRmZCTDBaOGMweGkvaDB4?=
 =?utf-8?B?d2Jva0xIK21IaUozTXppbDRRaE1qWEQvTFFjcHI5SG0wT20rZmRKV0ZxZUw2?=
 =?utf-8?B?TXpWTVlNMkliN0pzYjJFdzBwVXZ6Q2paQWY5NjNjQTIwVXNTRTB2Wk8yNVlk?=
 =?utf-8?B?OUNYallhQm1Pamg0UGNheFBYNzZDdFVsTVBSRlk4eU5LQm5XU1AwemRNdTJj?=
 =?utf-8?B?V2VnNFpEQUhxbDlhYWdDd2NkbjFpREdtbTVwZS9xdHFOcXhGcmVGcTd2RlhE?=
 =?utf-8?B?L0R2MThpaFJWV2kzUnZvK1I2RUE5eVFnM0FzbU1MTzljNlc3WXcwVnNXcXdt?=
 =?utf-8?B?NGJQOXRDWitXbS9ZLzIrR2xqbGk2d3I3NDEwYTBvZnRyWjFVVHBqTjVhQi9m?=
 =?utf-8?B?czQ3WkF5ZW0vaWdHNEVzU2E5cGlQWkI0THVrcFcwemNUZDVGekNhTm9mSDFD?=
 =?utf-8?B?MmVhaWowcGNLNVc2N2hNc0JQNGNwRXpBUWJUbUlmRWN2OStmdnMwQ2tBaWt3?=
 =?utf-8?B?eXVITEZHQ2Y5VVBTR0Niek4vY1ptOWpMNjNiRjNHYzdyN1lzb3VNSkxRLzk0?=
 =?utf-8?B?Y2FZT2xLb21LN3dtNDVWMUkrU3dPWmJrRnVMYkhpRXJDNUJlVE8vU1NLbWJr?=
 =?utf-8?B?ZVRnRElDY01MdnZlblNXMWlrZkR2MUhvNUJ4WTlhOXJiM1RLY1RBa082TjZu?=
 =?utf-8?B?WDlSaVFybXZCTGRRNW53Zi8vSjFiN20vbDIvM3gwWTh2QTcvcXlsK3h1V2N2?=
 =?utf-8?B?S2wxaWNaYnZabVNEUTdiVkJrSFhMVUsrSlBEbnVmMDdSZjR6QnFGWk1HSE9l?=
 =?utf-8?B?aG1JT1lxekRRT2t1bnhRaEpuazVJaVRoR3ovUkVmeUhjdktCaE9iTmtGN2xs?=
 =?utf-8?B?aTRqenFYWlZ6T0o3UGpRa1IzdHhGejFIeHZPaGRnRktzY253dnl1ck8zTGNH?=
 =?utf-8?Q?xgAt3gJlkrcVcQNmdh04ZBBzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406be41a-ab07-4425-ae3c-08db663c006c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 03:13:29.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f2FumqUGyYpjl/46+pgGUx9TZKdGXSKAyvozU9fc8gWkinLZozp/lAONJEDs+AnWybkytLwmSEDjQZuJ9vhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

On 05-Jun-23 7:57 PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jun 03, 2023 at 10:16:50AM +0530, Ravi Bangoria escreveu:
>> Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
>> the changes came via Arnaldo's tree did not reflect in this file,
>> which is causing build failures.
>>
>>   arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: ‘pmus’ undeclared
>>   (first use in this function)
>>      47 |         if (list_empty(&pmus))
>>         |                         ^~~~
>>   arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration
>>   of function ‘perf_pmu__scan’; did you mean
>>   perf_pmus__scan’? [-Werror=implicit-function-declaration]
>>      48 |                 perf_pmu__scan(NULL);
>>         |                 ^~~~~~~~~~~~~~
>>         |                 perf_pmus__scan
>>   arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration
>>   of function ‘perf_pmu__find’; did you mean
>>   perf_pmus__find’? [-Werror=implicit-function-declaration]
>>      50 |         ibs_pmu = perf_pmu__find("ibs_op");
>>         |                   ^~~~~~~~~~~~~~
>>         |                   perf_pmus__find
>>
>> Fix those.
>>
>> Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> I wonder how to solve the various merge issues here:
> 
> 1. this clashes with:
> 
> commit ae4aa00a1a9358e0007f6edc71b018a0b0d21190
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue May 2 15:38:27 2023 -0700
> 
>     perf test: Move x86 hybrid tests to arch/x86
> 
> --------------
> 
> I tried cherry-picking the cset that introduces amd-ibs-via-core-pmu.c,
> moved the test__hybrid lines a bit and then tried test merging the
> result with tip/master, it works.
> 
> But then I tried applying this fix as a follow up cset, perf-tools-next
> would have bisection history broken, but nah, but then I hit:
> 
> ⬢[acme@toolbox perf-tools-next]$ git merge tip/master
> Auto-merging tools/perf/arch/x86/include/arch-tests.h
> Auto-merging tools/perf/arch/x86/tests/Build
> Auto-merging tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> CONFLICT (add/add): Merge conflict in tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> Auto-merging tools/perf/arch/x86/tests/arch-tests.c
> Automatic merge failed; fix conflicts and then commit the result.
> ⬢[acme@toolbox perf-tools-next]$ git diff
> diff --cc tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> index 78b1902f6f59d8ce,2902798ca5c1ed1c..0000000000000000
> --- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> @@@ -44,7 -44,10 +44,14 @@@ int test__amd_ibs_via_core_pmu(struct t
>         int ret = TEST_OK;
>         int fd, i;
>   
> ++<<<<<<< HEAD
>  +      ibs_pmu = perf_pmus__find("ibs_op");
> ++=======
> +       if (list_empty(&pmus))
> +               perf_pmu__scan(NULL);
> + 
> +       ibs_pmu = perf_pmu__find("ibs_op");
> ++>>>>>>> tip/master
>         if (!ibs_pmu)
>                 return TEST_SKIP;
>   
> 
> How are things like this resolved in linux-next?
> 
> Removing this test from tip/master and I carry a fixed up
> tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c introduction patch?

I'm hoping Stephen will reply on merge question. But if you want me to resend
the patch rebased on a specific branch, I would be happy to do that.

Thanks,
Ravi
