Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895960D9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiJZDZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJZDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:25:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE731357
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIP2YZkf4zIECP3uPhe4eZ18EqxD/Xep2J2+mLrhgL0y8pCqJnhhlNFsAd6NJH12MGnZkVoAHM5GWDVoFFaH4QNFX3GNPRSVMWtElZYILT+j9UFKqx2py12sHdPRLbEsnznKBo5uZIKWisMuh7Auc/MnLMLFTwg58eagquqMLBnKtF7OQSw5ffpMqX8s/snTDGZOpK3+iGGY2w08TXhvKS7RAscWsF9/UZAmeH3xDoOVBdVAG7sTUyatDTzjJXKOXcMpWqILUgFf58hKSGew9Pxh7w36dzY9q1B9jp3O/MJO1p+LlvhtZsx4PoS9yyXc94S+xB8i1LL5vVK1ELfgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kxXQZo4x3TdwdLktFfMFcQQ6Lv0XTC0gDEfVdLnyZQ=;
 b=WmY+SfUtJ5NRczbyDsAOFgAHc3EiCzbCSMfJS97jEQPJ9Iq6me+NvkOyhf7J+fGYEuwyfT3mqqeQSejjT+MBzCDnH/HKfb6fodnEWJSVWEwzudm12t5zMsCCSzpAYu4jx0vdmqiwxASzb/ikuvZIDcFtwS2HbWEveF5YEkEN9q6Ie0xed0i74gNHh/Pa8++805UspSj+/Lsjff1Q0C9Wlt+Q2CCEgw+IUwhfO6wbavcQl33gOUr21qAIuRa3nBBWHbcLvugOxEfvNfFnHSwaeMwUjZsV45rT7QKHDnKeJhQ6mO6T55jsUfeExwTF8URfmALdzh9a+e1aNtpbOwTFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kxXQZo4x3TdwdLktFfMFcQQ6Lv0XTC0gDEfVdLnyZQ=;
 b=44hWbzfsfaLb77avMmB1Iv6gHah1fxW7jBRI3foKqK0lREvuSLqZ8twcFTptqBA5n3XMvDQJGJ8IXqeQOxaBesUKUqarbJ9ejcXG7reYk5NbH0WlFkZhn0gYBiYzeJKCu86/ixKovMg/Rs5gwCMYS3kJ2Q7BmFO27HDKBkRBK7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 03:25:05 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 03:25:04 +0000
Message-ID: <e61eeed0-0b93-4bac-6247-55fabb70eb87@amd.com>
Date:   Wed, 26 Oct 2022 08:54:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/1 FYI] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Content-Language: en-US
To:     arnaldo.melo@gmail.com, acme@redhat.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <Y1hBY+51vpyERSrZ@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y1hBY+51vpyERSrZ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::28) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: e756ef3f-cd62-4199-a714-08dab701ac4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYgDm4F4ncZJpw0yryfkyPYcUe0ed/Niai1XISgZq9fm+nAzw7jTA1+Gr6MVVTEIWjNsal2jijFIjeclBgY44N4/laya2ZMToqk9JxedOrtJQXXzyAJaP+m7tQ3CDPIoTH+QaFt6Eg8HPTWDe+iakwyafvUWFiuXca/+HkGhUVIzog49BF0E9M8WGRi71dYBi+U1wG3UI9dlGh7EZ//wK5Lp3v7agav+eAWz/pxFPeJxVZnwF2z7+sCQnq+l4nxsm0jn8C6JCLWcFu87ZTUc75lmDQZwWAHw05tE5sQcJTWqTodwfYUYW++FhfJwb1hspl3vihnZ89F7uNxtNSMT2kQQsSzIvW+AlwzcMyEK46SPonpF0ZKmgB3PCvJYKifIdeNBoBJonBr5401KL5AlqV9bNJhxxx0JTeK5i8wuOCfJy9mKqR3e1fPPhpFMOQrKE5mWFoF/Dg4e9nDTmiAt9h2eqh6wdmrbvteyZN8B+2WSsRWF8Zg++vRj8KOgeEX5S2NzIphVzCBOHN7aTJFQ6Tc4CGlBn099yJqATxrovqOJQQlvp/iGGp6uzQWYPIQtkrDqHzIninFB/qXYeZidn8Rno0q7WMmu5ZnWvyOkTNNpvH6dvL895NKh7SeN8fGQOp4GcUIxBa3slYvREO30gbKHhSHoegNvVWv8DELjxEX0K8CWPVgktdjsJGwTCGmcHoxc9g03gyyW2FCzVwC8vDeH+tT0gG0aIgdcz93g8ATu2Ka8MwJcBIEhJf83+MvuYvgCrgDMxzzGjhv7KAXaHv99Z58O1XGpX2WYc1a4Y8uJltJ4IOngDQJaqOrxbpoT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(54906003)(38100700002)(6506007)(4744005)(36756003)(44832011)(41300700001)(53546011)(26005)(8936002)(6512007)(86362001)(66476007)(6666004)(4326008)(2906002)(66556008)(8676002)(316002)(66946007)(31686004)(55236004)(31696002)(5660300002)(966005)(478600001)(186003)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JHclJQeG1CZEJ2WU51ZFFBTlpyVmh4azh4Skd3eWo3WURZZWwxcTB2Y1Ru?=
 =?utf-8?B?WlVwSGRtY3h5QWJPc0ZGV0xjZUUwWDduZ0RhME5uemlGN0hrb3U3MlFFNUNG?=
 =?utf-8?B?b3BKSGZUU3dLSkdBV0VEa0JBQ0tvSGNEbE9JNGJ6b3J0S0xuK3RKclJnVE1n?=
 =?utf-8?B?azZ5ZjN1TFB2a3pjM2FKUTBCMlZYaTFNdlMxMzB0bXVkaU5oMVR1ck0zdXky?=
 =?utf-8?B?VHlmdk96RlRoQ1JqelZjdVZKeTFKY3JPR3N4VDJ3YjdvUnVRNjZRbVhCL1Q2?=
 =?utf-8?B?UXZSTUphdTJ3WFZhdm5RK0hIWEs2cG1uRlNPd2xCTHNmaFI2cTZFV25qWUtr?=
 =?utf-8?B?Y3BkdkRWcmd4YU5QMytHMWt1QnhOc1EwTGhIZ2FvdzRDZDUwOUJuL1htbDVo?=
 =?utf-8?B?S243Vm1ZZXB0ZTU4SHlqUnMwYVBJcXBUUFMrcnJzaFV6K1BON0FtR0VpY09y?=
 =?utf-8?B?dUtnUXFHcm1weWVaampaeFhEWjR2WlFhRUNJZklNMnV0emVJUlhmS3hocXlh?=
 =?utf-8?B?dC9zd0QveEo0RzJZZkszVHZaa2dYOWl3WVZMd3VZdm0wSU5WRXVLNFhnNko4?=
 =?utf-8?B?MmJaalNVU21pZ2FxN3BzUlVoMENiVTM5Zng3d2U1NXl4ZFhwL094bmxkVHZ0?=
 =?utf-8?B?Y0pVdDE4SFpwMmlVc2dRTmlRWG1tOXBDVjF6dW5HcE1nVC9DUHlXcUcxWFY0?=
 =?utf-8?B?ek9hV0g3WXBZaUQyS2ZmTEdoRUxUTGRHK0w0ZEYzbGhOMzhUZGZYSmZlWUVh?=
 =?utf-8?B?T3hFMlgxejNPV1BKZTVjQVplMlJEOCtHeG1zM0NtdWYrSHNFTzhtSGRCNFEw?=
 =?utf-8?B?SWY0WE5SNUQ4T29WcU84bTBVRUhZSEJsemZJY0R3REJ6WnJ5aEhhWFpZSEll?=
 =?utf-8?B?Q3NqbG1CU1A4VktsT0Nyb1k0aG9lNEFhWTVrUVU3d1pwR1JTWnZSd0lJNGJW?=
 =?utf-8?B?dWJZQkVXbFRIMWJUMzJZRWNDWWZyaytZYzRzQjZUek5rS3c5TmpyaUZid1dE?=
 =?utf-8?B?QmY2ZGc3ZVlyZEZkZWUzQjd1cytQbEwyWVE0SGFKTnBFQzNIeTl5R1FjWFVQ?=
 =?utf-8?B?cmRJWFRXOTBUTHNmbWduN3dHY2IwbmkvRnU0MVdzY3cxTWIrdHNFTTlRaThy?=
 =?utf-8?B?NWtHbU9Eb1c0bk9SbjQ3ZElVaGh3amtmTm5odEpxcEpOcXlYK3N5a25iblpp?=
 =?utf-8?B?Q3JaNWVmTFpiYnlGWG9pRStEcHNLdi9oT2F0RCtaRk9PeUdwVnlkNGNtYlZm?=
 =?utf-8?B?ZWx2TTRXVU1zTWozQjZRRitqRHpuNmxBdFFaam9HQ2ZoV2RJM3l4cWl1T2dN?=
 =?utf-8?B?RGlOUjNlRzRtZWtLWE00em9GWC9CMEx2WTN1a3RGRWVFaU05SmFFc0RPeGxT?=
 =?utf-8?B?R1ptNzcvRU9Cc1NwdllTTFgvakcwZUZmSTRtdEVOTUZqQ3VlVU9hNlhSeEt0?=
 =?utf-8?B?ZWU1dzZmbFZJRTd1UmMweStmNDlxUnZCbUNCMC9pRWFNNXR4Wm8xYnZ4ejFO?=
 =?utf-8?B?bWNEL2xyNEhxRUcwb0hiMGlZVzR2M0tVQ3pKNTl2Qm1ISTh2dmZacGdhSmsv?=
 =?utf-8?B?S3dCVUZFVVQ2b1B4bGNwYlF1bGVIN0FIVVQ1R2JGUEdxTGhid1h4SXMvZ2Rj?=
 =?utf-8?B?bG1PWHRuWTR3cXk0OWJZTnhqVll0dThwZzdodlNOVG16ZDNiMWhZVUtOUG5r?=
 =?utf-8?B?dVN5LzFLQVZiNXpDMEM5dTEwQjJ1KzI1Mzd0YWV2WXJ6U1E3VU40MnZFYWNO?=
 =?utf-8?B?c1F0SS8zQWtzQ0dzczdYVEJibXVLR3RrQk9wdlVJUmk4dUI3UU9lS3lZMzdO?=
 =?utf-8?B?cjdLZjJhY3BIUGw5ZUQwVkkvZ1FkNUxYdlJWQVZLdXFWUkhmMWlVZTZwdmtH?=
 =?utf-8?B?aXBmNmxXcDROc3cwSWRJYVcxTjY5d1JZVVdnR2FLVC82Umg0WTl5T2Zqd3BU?=
 =?utf-8?B?SjlMaXFHK3V4eHNDMHl6NC9RTEpqUldPdTBkaEJFUFVyaGkycUZMRm5GNW9X?=
 =?utf-8?B?LzNPN1BVN2dvL1o3ZVlXMitCYzZlcFBRcnJhenNYQ0NlNmNrZHZ1czI2bisr?=
 =?utf-8?B?KzBzeGZlRG5nRG1JR3RndG40LzM4ZGI1RjVtcDVkdVc1dDZKMm9qdk0yWENq?=
 =?utf-8?Q?nj/Xh5/00DObqrm5/1SRx21wM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e756ef3f-cd62-4199-a714-08dab701ac4f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 03:25:04.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/5FjVmjffFJdz4dgIwJgiVi2c3ssqqv5s05mJHkQSktAXfWbDURzz/d22STKpFrX+TdqHbR5gnydqmn9UbNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 26-Oct-22 1:34 AM, arnaldo.melo@gmail.com wrote:
> To pick the changes in:
> 
>   cfef80bad4cf79cd ("perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file")
>   ee3e88dfec23153d ("perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}")
>   b4e12b2d70fd9ecc ("perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY")
> 
> A previous sync:
> 
>   b7ddd38ccc723f0d ("tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel")
> 
> brought a PERF_MEM_LVLNUM_CXL, and used it in
> tools/perf/util/mem-events.c, but when the feature really hit the kernel
> that define had been renamed to PERF_MEM_LVLNUM_EXTN_MEM, so reflect
> that on the tooling side.

It's other way around. I proposed PERF_MEM_LVLNUM_EXTN_MEM but it was
vague and thus we replaced it with PERF_MEM_LVLNUM_CXL. So tool side
file is correct and kernel header needs to be fixed:

https://lore.kernel.org/lkml/f6268268-b4e9-9ed6-0453-65792644d953@amd.com

Thanks,
Ravi
