Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D955C61F0A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiKGKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiKGKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:30:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB318B25;
        Mon,  7 Nov 2022 02:30:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYVzS0gIohsn/80VoZfF5o5cVysF2kSzHV94aiiQ9kZo6q/6i7tL7bl9DvLkd6ulxDCpixjw36YI7ngDzR9CwOSavccRgDIfqvbc+qNeDaLvK2S20LHVYA0Ntcgo9bpE9mCxOnZXuV6dWPo79MFUn3M7W18bGrXKK83WEXErPZRZwu2gW8N7XcqVnd+WwzawImmbD4ZDrYlpBLLuBYl7pAmCsxmPArOugvUCMWLRRwWyt2pCoki1BTyUE3KPmUJUhu0ZxcV743fbBv71jckEM5eSqY2H5t/t4boiW4MM301nFJlewxqMcPTxC0gctcUTkhc+8a4DJ7CEX6L56eNgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgKXRv3tYgv9kQbwsRxltyP6UjDNVtvp6il0/L5oJZs=;
 b=QZvrYhZvJkUX1QajTrrM5DpiKSQ7KTPXdrrk0SinfiuYC72/ziULblJ1E5ktuS5Eu51DqQH4wlJY+Y4GfUgtq1krIQyvpTGYIYCl4QQczEd6nqYBE6ONdetBgX7lxlqlUJNQgBxmIfe8YSYR6eSdMMF1PdldX5gN85BQbyQIi10wWA1qKqS//UpIde6GFoCW8Tetrr5RRGdhEFqi2oi1Cav9AnBCbW14UfyZBU02KWsioJeSMlu6u7gEEc9ThEIdn4Nq4NVjjiCbnSLeg4Fr6lAE8NRBKebczhzMYpG67DM4nnTcRxGeeNj+jyjsghjlOLF+tdULiBEAzonTm1ISEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgKXRv3tYgv9kQbwsRxltyP6UjDNVtvp6il0/L5oJZs=;
 b=QIsOOn4DW2100hT0oA5csnqoPQo3UthBjmJWH4nMtjvE86eEfHynr5UkgtLbqemg1ABMP4OueZ5tJ55EX6PGhOJ32DUDNMXQ0U7pAeqgEcApgmCMN+O4dLRJalo+sN3W0Wsqh2+E/0Nsea9lx19Zbo9Mgn2b1rzkvHtIXI+ylqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 10:30:01 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5%6]) with mapi id 15.20.5791.024; Mon, 7 Nov 2022
 10:30:01 +0000
Message-ID: <823b8819-b808-d11c-acbc-9caff9e2f535@amd.com>
Date:   Mon, 7 Nov 2022 15:59:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Stephane Eranian <eranian@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
 <4429582f-155a-04d2-d139-a834bb325612@amd.com>
 <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
 <5bec4620-2e2b-abe0-1e82-528c084d4d16@amd.com>
 <cb40c209-9c4c-f645-8454-bcd74cb72405@amd.com>
 <Y2O1GDRrJqIu17vM@hirez.programming.kicks-ass.net>
 <f00ecc51-a387-1801-0db6-e18060c620a7@amd.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <f00ecc51-a387-1801-0db6-e18060c620a7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a02a0f1-cefb-4677-34e4-08dac0ab068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeJ2ywWzzUU1RjXBMjib0Dwuex/+xlm7oH3ebLbYiW7E8/B41+26k54OEvhqphDUt52mbt2USkfG78+zJN0fqVLAdW0cNae++7Zh3vPgprYeUk/bnAuMxZI20aZdT9GxiBdlvsyM+kyW+irweW12EHCY+FzMWvmX8Z3P9MQkUiUlxgEZmlaD0dWzB+ymjYXCGv4A7AUoBgumFBGxyaEbUag4lYw0F1BNrhcPc1tIgeKSTpxLgjnrZMI1tYUij71ARlsdc8J66ju2CaMWmjKw//QqIxKVJpXVKjK54M4m2HM2vAv/RQX7pT69vLGkKOm01mpgGlXpp1esVKHKiBARbDVGKvUJzQu3sYvBI7f/9RIgQr80xtEQ+OSER1cWyCtJNas58xWqxC4H4sMSvEBWsIBhIA5ITB5dy4vLIj7J8E0bryvrQU33qNdpga6I9ODN1fUth0FaSDpcXf79Zh/Sxo7TuDihjX3RmC8NAzGJwtF4FspuutHfTL0lBw5zdi/8oAmsLisvjnd/wXoAkQa60GxYXqsb3rsWII/HLFiXytP+u73EpLElagBujhmk34sIjAgcnTaz7BbLAoBH4S/DqHyamI7cL57frhsMIGIqoTXXYJ8LObzBgo5ewxj2G7ESQaXslMkrddUKuErHfkWgQD450M4C/eQ7BzORWTGTUqcGZQRfvPcr4/6JDf2cK5tc/unl5PCwrxvBBVKjxWr2svXL34ee3Uye2YYvfV6lic5ZQQ0+a06uurLPb4Nc+mMA/IbqbuErMww7ZlsrCGZ/tDKye+XfbksHAwRvNMkMQQTml6JKpLSzYJfIf/m3Qf8KOuY2MKox8vn2xIK8O8ronw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(36756003)(6666004)(478600001)(2906002)(6506007)(53546011)(6486002)(966005)(31686004)(26005)(54906003)(316002)(6916009)(38100700002)(31696002)(83380400001)(86362001)(66476007)(66556008)(4326008)(8676002)(66946007)(186003)(5660300002)(8936002)(2616005)(41300700001)(6512007)(7416002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVmenY0YnNvYlpPK2crQ3ozRnMva2M0R21sKzNtZVNNVEc3VlpSbWcxZVl5?=
 =?utf-8?B?dkI5SE41NlhFVmdEVHlDdHRwOXFQdCtKWlBpZ1JkVDA0ayt6Q3JMdWVjU0Ja?=
 =?utf-8?B?bmhIYVhXMTR1UG9yYVphMzcxWmhYMnp0d1UrU1EvNDVCM1crY255S2xwM3pL?=
 =?utf-8?B?Tzl4YjVNMmpiZURqa0JWRHVzc1dLbHo2SEpnOE9DeDFYa1M0RFJYSDZ6QTVu?=
 =?utf-8?B?T0ZwOW5neTJSZEh6R3JrYS9EOFZxRVUyN0s0WUV6MUZVQ1VsR3UxcEphWm55?=
 =?utf-8?B?WGhJbDlHSDVYNy9xN1d5YkcvTURKRVFWZUJHVTBtSUc1VjJkd0o3REI1RzBy?=
 =?utf-8?B?V2haSmc3RVlpU2lPVWoyVEw1dnZ1WFlVTy83R0ljOWRSTmU4K2M4YXhoYVFP?=
 =?utf-8?B?d0l0OTRBcFVBdHY1K2NBYk1Cd2xXSVBOdDZKdU5sSjlGODQzbUxOc2xaNEdQ?=
 =?utf-8?B?bnIrWTdIKzZpK2ozaGVMMUNpWmkxSEs2RTU0OW53ZllqS2N6VjdaeTM2eG1E?=
 =?utf-8?B?Z2pxd0N6M283cXVGdEhnVU56bElMMFQwRDUxazdDUnZCM1pJSUdUMzg1dy83?=
 =?utf-8?B?T0ZOalVpVWUxTEM3Z1dzOXFLM2dWTUdJbkJPTlQrclQxTS9McEpET0t2UU5D?=
 =?utf-8?B?ZFZ1bzVnbFJkWnhwR2RJSHhWY1VvVHRHZnB0NzNiQ2NGNm96QmNDeGw5c1ZS?=
 =?utf-8?B?SG1YeDFYMEJvWFVBaWp3d3REWWtIZ1FoL1BIVGVpZmhrVTN2NHR0OUxVTGRa?=
 =?utf-8?B?WlI3dWhoS3E3T2ROckFvOEN3STVHdXhZTDlyZTh2d210VDJpUzB4dVhxNUVM?=
 =?utf-8?B?amk4b05Vbkg5SVFIREVkNmNtcUNEZHgwbFNjSy81ZUprbDVrYnZmeDhpRGpx?=
 =?utf-8?B?QW05RFFUNEVkZGpYNVdzazJxbmtROWxhSG16cXllT3g2LzdCS1JzM3hzYnpr?=
 =?utf-8?B?bVpmNThlNnRaZjFhZHAvcHBiSWlseXFiQmxFMUdUU2lMTU5XdXpFNW1hZUdw?=
 =?utf-8?B?WDR2MUsxL3FDWS91QkxOa2FpM2syZEFkZDEvdlozTGlXb1gvYW9iUmNVSlN0?=
 =?utf-8?B?UlM3K3p3QkdUTlJLNXRxTFpucW9NakQ5aFB1bWVac2h0cTdBOVlhQUJUbkNP?=
 =?utf-8?B?U2FGaUxiWTJTUWl0UDFsT08rYnozMG1rbkc5V251azk5dG1YWjlqNVdnVmV5?=
 =?utf-8?B?Z1hBNmNWLzdrTSt1bG9rd1Brc0VoTUNvNndTdEZmT0NYMUFVaWE2cW5zbHBk?=
 =?utf-8?B?YzVIWUIzVk9YNis5K2NTOW1IMVZiQnE0SUhXdkdrTnZ0Y0JVT3dVL0lQa0di?=
 =?utf-8?B?TEpuR1FJLysyNzhsbWM0MUtIeUplMkhWa0dib0pOU091TVUxdTV0ODA0QUJE?=
 =?utf-8?B?Wk9hbjJkUnViQU9GUlovYU56UWJaWFlJQys1dHFyUU9HRkc3SWgwOXVhVURT?=
 =?utf-8?B?Y3N4Sk8yVFJSb2EwM2svOHdSL01BWU4vMnhIZWxJcUF3WEc5RFFrdlJxZ3dl?=
 =?utf-8?B?Z1RkaGRxbmhiSm9mVG0ySEVadFVzUFdEVEFpc2dnK3FxYytRQmRyRXZZNGxR?=
 =?utf-8?B?MHFjZGpoVjBxNWlJZWM2d0o5a0t6SklwVXFIS0d5d1phSzNuekljcFpmV0dz?=
 =?utf-8?B?OVNmalBaRDdIWUpoVGVVRExwYzVQNlVtbkJxRGJtV0FZcFpYckIrWnZ2VlVv?=
 =?utf-8?B?MXlnN1hJN0h3US9qNVpObCtOSlgwMUFwMW9nZGZKQU5IR0ZySitnSDNnL1pk?=
 =?utf-8?B?NmRLdWJBWnZJMzV2WjV0QWkrc2RwNSsrNG45UDVsYVhmK0gxL2RFZnh5MUhH?=
 =?utf-8?B?Rk51TUpraDN0SE5jWS9sSW9UdWhwTE9XT3FxdForQWgyejFuY09xWUc2cnZH?=
 =?utf-8?B?TTdWZjlwSDRzb1hEWXhSRWw4eHJ3QkIzR01uTmtQSkI4VHhYcDRFMzh4ZWls?=
 =?utf-8?B?WjRzak1KWlhUYUlHaFRUMjJsRGlPcWNIR0t4M3hPWEFNelZkZkVybTd2TXYz?=
 =?utf-8?B?SmRPeVkvckw0aUpKMHlCQ3VCMXRqZU5NQ3Q5eXF2Ymk2WE1ITDJaTzNJM1Ix?=
 =?utf-8?B?SC8wWmZzNnZ0OTBTTTJKbkVPYkNZRFZydVJleEhtL2ZGNGxQVlNtZXpJajNl?=
 =?utf-8?Q?XSUhe6L8whE+SD/Sm1xMVD45D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a02a0f1-cefb-4677-34e4-08dac0ab068b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 10:30:01.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV2Ij76jgNMXzLk4CiODEiYVMdo0Ztfu5NmYtfyV1m7yqC927eg3V4w3tNSTVayfEoJqk9nZvKcH9uRSuinXMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Nov-22 9:42 PM, Ravi Bangoria wrote:
> On 03-Nov-22 6:03 PM, Peter Zijlstra wrote:
>> On Thu, Nov 03, 2022 at 05:15:30PM +0530, Ravi Bangoria wrote:
>>
>>> Sorry was distracted a bit. So, this seems to be happening because of
>>> race between amd_pmu_enable_all() and perf event NMI. Something like:
>>>
>>>   amd_pmu_enable_all()
>>>   {
>>>       if (!test_bit(idx, cpuc->active_mask))
>>>
>>>   --->/* perf NMI entry */
>>>       ...
>>>       x86_pmu_stop() {
>>>           __clear_bit(hwc->idx, cpuc->active_mask);
>>>           cpuc->events[hwc->idx] = NULL;
>>>       }
>>>       ...
>>>   <---/* perf NMI exit */
>>>
>>>       amd_pmu_enable_event(cpuc->events[idx]);
>>>   }
>>
>> Hmm, do you have more information?
> 
> I've extracted function graph logs from crash dump and uploaded it here:
> https://github.com/BangoriaRavi/function_graph/blob/main/trace.function_graph.dat
> 
> crash was on CPU1.

git bisect let me to a BRS patch:

    commit ada543459cab7f653dcacdaba4011a8bb19c627c
    Author: Stephane Eranian <eranian@google.com>
    Date:   Tue Mar 22 15:15:07 2022 -0700

    perf/x86/amd: Add AMD Fam19h Branch Sampling support

    Add support for the AMD Fam19h 16-deep branch sampling feature as
    described in the AMD PPR Fam19h Model 01h Revision B1.  This is a model
    specific extension. It is not an architected AMD feature.

Thanks,
Ravi
