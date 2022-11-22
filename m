Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1ED6336C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiKVIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiKVINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:13:25 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2B1FF82;
        Tue, 22 Nov 2022 00:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1oJoIfmEmCLyUUz1nI6m96DIh2M7FQsWBDJSMRqdWJlffIVj0CfdvTgfRjfRHmSORRBgJPSJn046ASFIun8vZqa7f8fkdqYewWGC5qPg81Zk6xRCy/0LhLci1bfLtC9vFOWF3rlr588gDLpCLvSTGDbToQkmsVspQvHIcDoZ8OPAaelDJwg3M3juipWOn3d4EKh1pB5Bect5hx47XAmiZLfhUDYdzaYFT1xE0TCDfgcDTAwFjBECw1/CEDZzhPy1h+ZNJCbCrmhKyyAd2kjfEkkGVt49xBFp5rUvqgId8Ix3nQ5/Ig4HB4geaN9lOxKs03vnbKpcAoGND6N9A0Gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z56mdp6XZ6DA0JjRDA8rwKlPxkukbS/2Df+wORLZzk=;
 b=T7XAurVwN/MmTP6Y9/6PHjnG0/uddkV4NVl0pQMgQKg4yrAkYrJISqM5uvKd0l0BC4KwwpnXz/+swY17k9/mYvSaDQyRieb9nSMfLWmBZo+b/TFxQ53ZjnUSlfmqVy4B7iKkksqf94GcDYVD0gcuYmjYpHAc2enwQnPTEnYEf1tbTuQSF9YAnqXiunsELpdHR2hYs6LKjyVotoANlurTFU52L26b4Ev8pD4SMx3mTirCJCbnKpycSq8oh5CpceJIoHLPD4vVIl+N8cjCFfzAJrHpE2KqS/QpPALd2lDRKGwEkJx6t/QZOqEQqjcP5Akay+mV0Gh0mB4m83Xd5t7MKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z56mdp6XZ6DA0JjRDA8rwKlPxkukbS/2Df+wORLZzk=;
 b=eKwhlpGfxxVq6bZOBAMzdmZAcwns/Rhbz8VEPP6q48tDXPAmH8spTVXu9VzKYUwD5SMVU7cAWeZNhaJ47wYDkMXDjYRxpzChK8jquhDcFUrthVq3aXAGSjv2mLNRv8l0pKRREq2zVu/7FRLenYBzujbDFauadLj+3tVs18qp8C4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 08:13:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 08:13:23 +0000
Message-ID: <9002989d-3d87-dee1-23a3-6a652243d5b0@amd.com>
Date:   Tue, 22 Nov 2022 13:43:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf/amd/ibs: Make IBS a core pmu
To:     peterz@infradead.org
Cc:     Ian Rogers <irogers@google.com>, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, bp@alien8.de,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
 <CAP-5=fXq-YNKogH4DYQuf7rz8TZhu8=QnEsA2pvzj6YS_DQO7g@mail.gmail.com>
 <d839086b-826d-3642-5be2-a62714457b62@amd.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <d839086b-826d-3642-5be2-a62714457b62@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9e5338-2843-43ab-af70-08dacc616b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsMHs34NouWeuFhcwzG5UaPofK1rrikCRZNks7nplfBzdIN7wuxbAhWkAl5Wnc6M97UOTS+J5As7KO3hUOYoBvZlsaEopaZxalwgCcx34o7Vpv6ebTGa9sWt3nxrKMwY1WKVz8/862QJvkAzVTUlMIDJM/H+SenqHLVCJZn9TYRMwvGv+bAx15D+7XlCZI/YXzKA6F48IfPLObMiKbmZPBzwY6H5YVk0SgldjnhUcMaF1V78pUOAJE90FiYXuWuY4ysb/al1RcJ3MlfMSFW+fPDLxSb2+YXAvHU288Z/O7pX3h68zYyOwAaEdPlF+AGPibXJiqgPMfQ7DCzOkbWXQgMb1AoSRb6weU0ZXtfCsPsfeoQn/6WNqdpcyFT334mCmlu4qaD4Bhjm3EXng2MQ/HGEKpK94oNgkmQr5YK/nQtIyQxD6CaFyPCsBQ++2HlXdxfFwEr7wbdJKt2zwKwxk5C0vM8z2cHjl6AOtrydWydqq3t6dPfZ1oXkDzXz1s4xXEFb1+PyjTzsxTKP2Q1YP9gUlg2QrcnrBAVsJnzneEUOrHxcmnuy44aVnm+cj1aUX7/QNzmPsKNxP8u55vElibNMwcvjLScXgx5pXqGr3oXOWNhPy8rea7OQdQ+V/Uj5F+kgNAWOA8LJT8785ZehShxZa1VauWd+6hpo3k7TJ7Y1EhWzefn88ayOPL7k058J3hTabPiRWuC0+cIjqJMSHspIRHYDhCMVkA/wrGNGF84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(66476007)(66946007)(66556008)(38100700002)(8676002)(4326008)(6512007)(36756003)(186003)(478600001)(26005)(83380400001)(53546011)(86362001)(6916009)(31696002)(7416002)(316002)(5660300002)(41300700001)(54906003)(2616005)(6506007)(2906002)(44832011)(8936002)(6666004)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1VdnVaV01udG1WNEhlTjcyeXM5YUcxQ3JlSnhSaDBRdHl3VW9CUFRvODZn?=
 =?utf-8?B?MG0wMGxpVkU5Z3cxM0JySXZQU29xdmE5OWcyYXEzaEt3ZWwvY1M4UFg3bUs0?=
 =?utf-8?B?WFNjeUFxUWFIaFZhNnRJSlZXSFF2eE5EODVDYnJMN1lTNjZwU3dSdjVaTTRj?=
 =?utf-8?B?ZC9yZEt3NjN2TmcwR0U3OG94R2hmbWNnVEVydHB6K0xqU1FEdEZIeXJBUFlM?=
 =?utf-8?B?NTlGQ3BDTE4vVUNNMXR3WDQ2M0w1TTFRUURMK1ZUZUpwWjc2NHNtN2ZoWnNJ?=
 =?utf-8?B?eDJRZjdpblJXdEtUMDVINDdNWTZ3MGlVdXU5bHl6OVRPZG5mb1RITWdiUDh0?=
 =?utf-8?B?SWRxaFBmQ1h0TytIYWRuK3lUaEMxSTIyczZnNzRNMmR6SnZYb1ZXdU1sTDJ2?=
 =?utf-8?B?QlFFTDRta1ZpWkJoZEo3RFNvbng2ZHlQLzYrWDlBWGpOK0R4VU1RSG5hOEpy?=
 =?utf-8?B?OTV5M0dLbVFpbHFhVnNINHQ3WDVIS2tvUCt5azlZeUdiMGJUKytJUWZsa3dj?=
 =?utf-8?B?SjkrNmdmMUF0MG5EVG1HZ1VYUGhGbktsK0NERlY2T3U4ckRXSkxFZTQyVEFi?=
 =?utf-8?B?RXlMeWdJa3hRM3I1VlNtUGd5RTcycjNvSHdsNDdvTmxraFhRSTg0MWdWeE5r?=
 =?utf-8?B?eHJzdnNZajVyYi8yU2tLbGh0MU9KVEVOWS9VK05TdUZ6aGVqYjBiWEJxNith?=
 =?utf-8?B?UDVxYUN6cGkybVd6RGR6VlVtaHhITHFVOGR0RTVxSjJKSkYraXphdGd1ekY2?=
 =?utf-8?B?V3BsZXNsOG5URE1XV3dNSmhjWkFHZ0loN2E4bU03OEp5T2tVTDNSR0pmLzJa?=
 =?utf-8?B?MXJPMWZ2NDRqUnFPQTc1K1VwZ1dCdC9yNEZFVk1vQXRKNWNTZ1VycnQ2aDE4?=
 =?utf-8?B?cG41UjhoM1M4ajE1UUloamh1bGhad24rT0xZQUl5ZVp1WDZ3N29KWEEzWCtZ?=
 =?utf-8?B?SkRFM1JNUWxNNWVpeHY4akpBdzBiQTNNVVBFTzN1dVpYZmdFS3Y5K1VtcHk4?=
 =?utf-8?B?QVhTTnh0ZVUrQTdsQ3pXQTRiWVo0U1lxNStUclhTMG9DRFZBU3lhVVlqbnMx?=
 =?utf-8?B?RkdvTHh1NE45OHhIWmFSckM4cWZxbERmS3pQRmFSNElUWkhyeFpta1RHMVpM?=
 =?utf-8?B?TmFINXVibjJPS2dYdXZOUVJaUGFYcWNoTXdiemZMS3l6VDZjdWE2VWN0ODVI?=
 =?utf-8?B?Uk82WkR4SFM0SFlzdFhhZGltSk5LZjV5dlVKMHRxY3ZmWFUzbWJMY1RSNXEr?=
 =?utf-8?B?TlNHSElMRnVXRU9icUMyRkJjckV2ZU9vSWUzM2Y0MzNKQlNlNTJsd2IrMHNq?=
 =?utf-8?B?U3Byam5PYXJHNFNmYXpiSmkxSFpmWEQyR0RwQTFVRTVJMzA4aEZ1ZWUyWUhy?=
 =?utf-8?B?NEp2cGl5QXpleWVUZlhiKy9zTjVOYXVJbnVtS3JVZWdXWTgzNUxrb055czFm?=
 =?utf-8?B?Zk5HNm1vVy9OQisvOXdadDhJblFTV2ZGU1RkdXZkR0RycmxmajFTZkRScm5y?=
 =?utf-8?B?WDY4MFZQTjN4bFQrR1RkTVFNanFRR255QXdmT290czZWWTlDOEI2ZytTUjhk?=
 =?utf-8?B?ckRFL1lJZ0ZlTFhLZ2hwNkp0OGNGWUF3V1MvbHJ4a0txRnFBMmZRQTlHU0VC?=
 =?utf-8?B?bjJNQU5kQlRMOUd3OXRtY2hQWWI1VVNqSGdXSEhBUS93enRIV0RaWGJmemxF?=
 =?utf-8?B?UWJpM1hoSmg0ZHorUHppS29nTTBCWmRGZU1JS3JNVXVCTTNtZXN1c21tRVhK?=
 =?utf-8?B?Tzd2TDlFb01wL0RUdHlHUVF6eStydjVWZVYvbXlCd1JTWFV6YmlXOW9JS0hx?=
 =?utf-8?B?SklxU1UvUEx4UmQvVHZLLy9meU9xL0FMWE94M2NUS25ic2xNemJLOHNEZHFk?=
 =?utf-8?B?K0VUNWNZSnRGSzFsbTFEcmRKWG9COEFxNit6UDY2VGljSkhLUy9zNVRPb0tZ?=
 =?utf-8?B?bUhPa1pXWGRCZ0J0NGZsaktVdjlkWnZWaHQ0UHk3dUZoOUQ3dG9ubVREVUxF?=
 =?utf-8?B?RjdQbjlRamRSYlliNXIrem1VVkxRdTFFcUN2RlY3cEtQdFVKQVZidndJdkY0?=
 =?utf-8?B?dEQ0YmVVWFNJeG44SVhUaWVTQWE1TjdqVUZ4TUZRK253S1dQZ3NEcmlOY0li?=
 =?utf-8?Q?BHaV9DjBr6j4/p0IJWNHmv2X/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e5338-2843-43ab-af70-08dacc616b80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 08:13:23.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8319dpP7hw+x5x+u9W8Vr7pEaKXaySrQiok+epFJHSTM6y48z0u69wJUs87gd/LmqK5nmbcMc/4k85t3Rr2jCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Nov-22 11:15 AM, Ravi Bangoria wrote:
> On 15-Nov-22 10:37 PM, Ian Rogers wrote:
>> On Tue, Nov 15, 2022 at 1:39 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>
>>> So far, only one pmu was allowed to be registered as core pmu and thus
>>> IBS pmus were being registered as uncore. However, with the event context
>>> rewrite, that limitation no longer exists and thus IBS pmus can also be
>>> registered as core pmu. This makes IBS much more usable, for ex, user
>>> will be able to do per-process precise monitoring on AMD:
>>>
>>> Before patch:
>>>   $ sudo perf record -e cycles:pp ls
>>>   Error:
>>>   Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'
>>>
>>> After patch:
>>>   $ sudo perf record -e cycles:pp ls
>>>   [ perf record: Woken up 1 times to write data ]
>>>   [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
>> Acked-by: Ian Rogers <irogers@google.com>
>>
>> This is awesome!
>> Ian
> 
> Thanks Ian.
> 
> Peter, can we push this along with rewrite patch?

Gentle Ping, Peter!

Thanks,
Ravi
