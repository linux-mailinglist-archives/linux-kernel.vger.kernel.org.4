Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4AD645445
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGGxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGGxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:53:31 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB70F5A2;
        Tue,  6 Dec 2022 22:53:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr6QTxZwJgkAQfplTOUq7BGsub/DFpuqlEP2ypwoDwWBHYxty7iFp7ecur9+20GX6Y7n5It4Y6qbGpQUKGaDmiiUSxDr4wdFjuL78/GZerKvkn62sNWCpYa3X+HpIGjmiqEWJeFGKxatoWJ6fnPHlav25ro85i4NaZ8RHOI7xc7RO7wSRiFmaHEQNHl8lYnmcXVjlk9+rrO3pfi0HYch92b9y6zY0f/7YugOzcctB5RuReeuX5N8i//Ui1kO0hum5kHSNnxO7CtqFn6dI5PgM7VSLaB6nhHXsa7fp39OOy24+0o8H2+QNtpxd+8dWGWZoiglSQYjOIB4LVk46xx27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcF3f/hwZsC/P9ABjxND+i60i8orUuZeI3WcHHBUJbo=;
 b=dLo+bhxo6Qe30TFyQV+v3HUiJ1zIwEBhojai7UjOdLetB6CSJQKQBtqh9xDpG77ljjNs6fEX7xM1nXH2XApXCISzZYK+3Sc5LwzhVQHVwPwiA/tBtEydQE8nhDLkyzloamfqCvt4UKJ/xV4LoFg1oOJMd5Y9XhRIgeGZCPrdrFgpZ+YuTzR4sW/hBcRm10OjodFt2V4ddguTHjHj6D/6BwhZTU6CrR66DIuEJiX0UaGRlsvupsGmwSMx8u/1JmWvK1FkGyC1ACxva1ZrRbzCXGoAueZHmLcEKoP0O5eTeQCk8I8Dc8uUmUBl1WcaaM5pMGF9DT+fG1gISslIsiPpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcF3f/hwZsC/P9ABjxND+i60i8orUuZeI3WcHHBUJbo=;
 b=zSX7k2VSGMsI75Dc059xCVGLVPsOt9oMclnxMPywH6UqOLRxqMnKrtg7IOEesA1MjSsJniIQFBM2EAfLCYNzwiRYtYyw66mdWPio4BG+r1yDtt2YX9SZ2lfcKJf3fXU1+dQkbHX4YSsyNLG0TL7oamRklDpYQxgbZooP9SxBdMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 06:53:29 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 06:53:28 +0000
Message-ID: <e490cd35-aece-25b5-de96-b2f64f6a9b94@amd.com>
Date:   Wed, 7 Dec 2022 12:23:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] perf vendor events amd: Add Zen 4 events and metrics
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <20221207053007.336806-1-sandipan.das@amd.com>
 <CAP-5=fWhqWfwTwnh5SWiLamXkuZbMnefASxkLByH6a44kdc5Bg@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fWhqWfwTwnh5SWiLamXkuZbMnefASxkLByH6a44kdc5Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL0PR12MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 569b9ccd-b7b9-4c3e-3a79-08dad81fbdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaDwplZnuD/hk4gPtcc751lBnU7I0qEsXwtKs0nFZvCM2P8ICl7TINaCm7lTPcMkhrLp7bVs1JfJI2z+pBN3IYjNu0RoRULe+h1YM2byW0aZM72mvoYeRM6m9rFozklgGXykeueFbsAV71khH1aWsHTLr/f3i9HfD2zAud8ZLEyvHw/o9OKzLjT47XviNur8zX7bFSb/UKE2Yj2M54HRNmmA4jIzQ/QAbUiW3aNSAflKJ4aHEnsBBQeA1+8Xj9EgWG0wohRnqjDWkjF1yNFS/7MVRiQ7yzm6LhaM5mc6Nrn9M4NDL4/n47asyLvYvJpr4HzyezFUHyRWsj74bgHd5IAHSscMy/KCTi9iqz6czGtTUd9e/DR7nI3DzQEpCBbkrgwJGwjY1yFwHv6UGJNeF7LOqJXjVU6qFwxTOEmCfw+0QS0jezwUEDucl225sPdkOFq/UsnhoRSMhNaWmMK/d0wa57M8wXfaq+Nq9uqrgQsuafNeebG7zcF5GRg5L9Ab4XvCMlqySOKd8C7hlhlJ+qP+WMqxqErWASKz0LMNspBGWogNsx3HBMHbKAr9xafJ9sYyOhXV6K+dtMzukO3yUMqeylvOvZ1XNyek9ebMrbLu/sH5kzgGHWsMMH24yKY7jFSm3uth7SfKEtAu2zhgHsJhjLglc8Gr+nX+e+dcT7g8jF3TFej0Vn5sZpoBrRmkJ+hZH5lXc/Fc6NN5jjyTVlX8SWngcivI1RNKzLo/1Tj5oyhGMzI0EjsiE4p144fJbTY74PJrgGTbxAs8Isa3Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(86362001)(8936002)(44832011)(31696002)(5660300002)(4744005)(2906002)(7416002)(4326008)(41300700001)(478600001)(186003)(26005)(53546011)(6506007)(6512007)(6666004)(66946007)(2616005)(66556008)(6916009)(66476007)(966005)(31686004)(6486002)(316002)(8676002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhYdENPVVY1YjZ0eXZkMVNKbmI0YXJ4a2w2akFzRUJ3aGlsRndNQTRvT2t3?=
 =?utf-8?B?NTYzcTNwRWNMalJSMjZzajBjck1qS0o0VldaN3dVa2UxOHZTb2ZyMW5qaDJC?=
 =?utf-8?B?b1E2dzRsQ2oxMGhMZmhBZGNSVUhPVXFkM2s5MExpWjZ3eGphaEltMjJ4U0Rv?=
 =?utf-8?B?bEJ1a05LUzlYVEVGWGgyUXp0R1BiQWtoWDZyTEJ5c3NrS09yTllWa2xybTVi?=
 =?utf-8?B?cWRYRTFtR1paOW81blMweHJwRU53cjBseUo1SVlLZkJrSjVOVTRFUHkwbzNQ?=
 =?utf-8?B?K0RyWGsybklET0VqQ0F3MnRtdmVQMGZYb3Z0NEN4Q1VmS0UwZVc0aTltNys5?=
 =?utf-8?B?b2lybklsaEU0aTduYjFpRzhJWkYvSHRrSW5sdnljcU1vR2lRQTB4Vjh1OW9J?=
 =?utf-8?B?cENlc0JSdm9JVlNBWFdoYWZ1ZmFjd2RJWGtzalljQkxGUlM4eGJ0YldWY1Ey?=
 =?utf-8?B?UzBLWTY1MGFxQzlmTE05ZTk2NGRiVGxlV01XS2dHd0U4cEZHS1IrdGt0Mk9x?=
 =?utf-8?B?Q2FwRWhCdjcyV29RcXlRQ3B1M0dHU1B4cTdmaHRqR2JveEV5RGVVcXdWZTI4?=
 =?utf-8?B?Wk91VkE2UDdMdldFbXF2UFdBY1NuZVRtMG9Yb0NWb1pDbnlNdmNEQlNrMlhP?=
 =?utf-8?B?UjRFUkx1N1RzbzBTVHlNb0pjVzRINS9TUGx4VGo5TE9sSlNrMG96SVpBVEZV?=
 =?utf-8?B?UG5pc3FISzh5VW1XRUozcTFiSmNkQmpqc2E5OXZNdDFHV1cvTHMzRjcwU3lS?=
 =?utf-8?B?QkJseXppZlY1eEFXYVo1M2xrU0dWcmFIQmwyTUxTT2JjWjJNSE94dnVpVUdx?=
 =?utf-8?B?WHFJRUZ6Rllqc1kzNUdJUzJVZzNRNFVIRmdyanpZYjNEK1gvSkdDNUxVWGMv?=
 =?utf-8?B?Um9uUVhza1RqR3JWcnp6M0dydlV3Ri9lalU3Z2IxVWpEaTR2a3p6ZXpaalVk?=
 =?utf-8?B?dVc4b0RpMUhnSVFzeHZnZm0wa3BHN0M2SlhUYklZamt2a21kVU9GOEdsSlQw?=
 =?utf-8?B?cTdQOVhTN3A0bHBQOWgvZ1JJTC9ycVVOQ2RtUTlUS3cvaEdFSlp1cGt0L0Q1?=
 =?utf-8?B?bFZPWFRKQVlraEc1eGRmcHV5T3RJSWR5TVRadndQMmJpNElxWXZITGR4dXZr?=
 =?utf-8?B?MVhIbUJOMkhCS2NpTjFCRDR0ZWR3R25zQ251bUY3WjZlajFtSWpiUUQrYmxN?=
 =?utf-8?B?OGFzVmtKeDlIcEhFZVlZY3AxMjBFaUNobjJ0eEFKT3h4OTJHVE1mV3BGUExP?=
 =?utf-8?B?d2JVUElDZlJJMDIvWnJ2VW5idlQ0Tm84TXYwZS9XbzVmWlFodUF1eTlKZm9E?=
 =?utf-8?B?N01DczlGNUlJdjNlTCtBSDlxVmZ1R3BLRTJNNndEVjhSYThPVEhVUDdUV2gx?=
 =?utf-8?B?RnBZeFkrbEdtMHl0cDAwS0FiTW1oeUJrWmptUlNOUUM1TldIa0xhODMrcTJh?=
 =?utf-8?B?dm4zd3BZSlN6dGJCWUdzOEFzMGhBS0JBemlIeFFVWHpmeWY3QS9XaysvM0RE?=
 =?utf-8?B?T1gwTEh2aVl3aUFzUi9YMSt6c3QzK0NVSUN1d0JXNkJIb1RoVThFdlhMRW9G?=
 =?utf-8?B?TkxHYnpDU1FrZnlHQTB5czBXSjYzQngxZEpGSjVra3N0ZjFYeUVDemdBSXIv?=
 =?utf-8?B?RjJYUThqaEh6c3VFLzMwZ2gxZURyUVFTMXZ6QUJpNHYzQnpyRFZiVllLZ01l?=
 =?utf-8?B?RTE3OG0yZDI1MWttS0dhYnFDbFlteGhQMFV1blNGZG9kMTN5d1VmY25raGcy?=
 =?utf-8?B?NXYwQWxoVUQwR09ua0VHY2dRN0JPOTJmUmk0azZ1anZaclowaktFUHMvdE4v?=
 =?utf-8?B?em9vUklQSFozb1M2UXVQTzRWYzIrVExYQzQ2bkczSjFkcDZZMENhb2RNaUxQ?=
 =?utf-8?B?MTBzMSttOExQT29od2I0TlY3Nlh3NkEvWlRmQWdIOWkwMnk5MXFSamU0bFZr?=
 =?utf-8?B?N0JvRzR3V2I0eTlLSFRRSE9qLzNNbEFWc2djZDlnQVNCUzE0UlhCYU5mcTVo?=
 =?utf-8?B?S1R4UlJOZnV5Y1NTa05MNGt5ci8zbDBsRkdvdGV1SmdnTTZ5bnBhTmJFQ2Y4?=
 =?utf-8?B?U0FVa0VXd0NudHFSdjd2aDhIUFppOHI1cEJ4a1R3RWhMTlZLaFZYdVVPOGdv?=
 =?utf-8?Q?o41FXE5VOSsiE8NelwKUQbNZG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569b9ccd-b7b9-4c3e-3a79-08dad81fbdf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 06:53:28.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWxLi2RCDyZNVchw3wX9shwI2icMNeJfx55aaP6OexQVIfsEBwEO4HKjtn1na9FBA7puFI4D/7qMnLP6jkciug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2022 11:36 AM, Ian Rogers wrote:
> On Tue, Dec 6, 2022 at 9:30 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add events and metrics taken from the Processor Programming Reference
>> (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
>> found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip>>>
>> Sandipan Das (4):
>>   perf vendor events amd: Add Zen 4 mapping
> 
> Adding the mapping first may break the build until the core events are added.
> 

Agreed. Will fix this in the next version.

- Sandipan

