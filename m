Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288146A3F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjB0KNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjB0KNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:13:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7B64692
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDx3TCsWYXG54clLFH1jVp0Zl0Q//RPEm1OZnLhq1CbfgBWD9bVKHimIoqM3nxqlr9BgrrM8WMynXLP0CO60xqLPoasY3NdhO37LtqubY2s7B6okGZscs6tC21LiaW82jYxuIWR6K+fv9zDBqV3N7NKOw92vO5X4CazI4klvuoszje7UEHm2C2ksr4u/yLyZ+buvaieyB6WetMSHGyXWqLXT983rvwcpW5adx1CtX0fIP0Xd8jkDANOhJ9Z6tzZk9//mosreJQnAn0DdU5B/CZsCwDYXEBPFOtXEOFONiMEsENwATbbw5Mc4STjtOAnIjucVYVWhlOmOslVTd8vVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHVCgPqM7U2jm3OIRxXrMlGJ9s86BLydVBok2T2xCJQ=;
 b=RGmXYxTeh+cfjzBLQO9RiGz3O6d/SRcr9eoFemdQ8Qm5LrW+TkVopthABU2ILjlW+gAdW8gab1gAMP0RWwAFqlq13sNpfdVySHmR8elOsreACN04mQocL/dHNcgXPv2tZAW9ArzZvqhq7/BkuVM4ZEQ6qLduPde2n+XlPoBjWc34b7OqEsWBIA2+2ghf/asTdPPVXdyhw0FZfMcTOH/Ca/Rx7Ao995TpZ4H85uKNVwS5GrBuV6YjoqiTlOSu7KFgIrVL2secvvSdEsP+XBvxdddbsprqkoehMz1fhP7lbZE52DMZqpaWXEhAsCSRhdH7ouj0Y8GD3QDfqpGybGkgPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHVCgPqM7U2jm3OIRxXrMlGJ9s86BLydVBok2T2xCJQ=;
 b=Fpj+cbNb9GO2QGAPqmhiqWuxKJrfS2Z0RbUlQ5k1wMcxMscjN2KAr4OlTDWUgsA5DEchOk5gMy9gxrahgf3+Ob9kMHDL7Kg87qEQ4NdGZgyRJczmWmpMIxbLlQfkFGfSCfkLggonXKJ9kaW9Dvq3InHEqdQSycI2qa76axK2uDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 10:12:59 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 10:12:58 +0000
Message-ID: <3a9269bf-0d1c-59b4-f80f-afbbdf9c45b4@amd.com>
Date:   Mon, 27 Feb 2023 15:42:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
 <048964e8-179f-de7b-1190-831779d9911f@amd.com>
 <ccba1a65-fe4f-89d5-a32b-2efba30a1350@amd.com>
 <c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com>
 <Y/yAmDj6tQVfOdqK@hirez.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y/yAmDj6tQVfOdqK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7b2e99-699d-45c7-6421-08db18ab3340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8q7sCwHQYIA1RnHke5AX0L9weUSoIE5uTCG0klKF1iL3K/IPdAcj6HYqheheTw16xdZh0A0DirLAkpYbYWZcnOtZJ0l0JN7AZAougswT+f4k8PeMxl8fkSKDwxfv9XO7687JLTGmxJ7HPINFnoJG+meqtGHkyYJ/Tno2FcIescuTTdYMZBgypZIEdytjgwynbU9NwtkdhGlCQK3I/IlQAvJETGhvhKNysM6nw82SmrHlL4BzwxF8rgtNQ3nQtsfUlEUJoqBjGwHHQOliCX67Y1MQPgRwFmEd62b2Y8/NlDyEZETsSNxvurMtI4Q91OQ/743gOJTTo+iUtdI+D/KMdWQJBHYvTJ7eUI9B68NF66Xicvf8PiwbuPLJRMFvScNLXzPjd7CARf8+d1ZsiyOOWnVOyH38yJWHBYuyFTp3yPo3D3c0VGacYyWImgA0rAs32U8JUfvajuVAqtPZk+S/vKImj6XwC7i3hNEpt+3IAnQCzh5PxkYqgw9yrqpFvJjteLUF/NNyCq2TXej1j9C5um5ms2k/BKL77RQJbljKFAlETBWfm8wVvdbJ2hM+pDt+8INJPJGGIXrlEU1FCI0vcatv28hwDZ+pnlu7yQL8DPYKOXc7/8x7bYVQALSzJPVwdxGuJyO+BqtAPw3bI2KNWwjFb5KnZKXEjQqzkSqLq/JyhCmTCn897Mh9fSKxY9oRopjOz282wCHendChdpnxWFROU8Vmn62DcARrzu+wUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199018)(186003)(38100700002)(83380400001)(316002)(6916009)(8676002)(66556008)(66476007)(4326008)(66946007)(41300700001)(8936002)(2906002)(5660300002)(4744005)(6666004)(6512007)(478600001)(6506007)(26005)(53546011)(6486002)(2616005)(36756003)(31696002)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZqNXIzSWlwYkRPeVhYaXVDNUszclFJRFFWdTlCWVJzeWFScVE1ZUlrSHVx?=
 =?utf-8?B?bFl3eFB3QUcvcVdiVXEvOU9BRmVNY3ZLUzZCajFYZlpDaWpMSEJhaFF1Q25W?=
 =?utf-8?B?enhvc2QvelBxaEUzaDJRMEFRNzltUVBLb3dONk9qczRDMkpDNnNJeVdjd3pI?=
 =?utf-8?B?Z21ya0plajNCTldURStFTTlMSnIrVGl1VVdMbkZGSitBb0xGU2I1dWJ2Qmp0?=
 =?utf-8?B?c3NYMGlQZUxVQmZ5cHRnUlpkaElIWHpCR3VIUFBFUUJ3Rk5Fbm1GQko5NXRa?=
 =?utf-8?B?Z044anBHREJ5c1A1b0ZQaGRCeFRzOGEyeDVnNHkxaDJCY3pPUUcvTjI3aXRs?=
 =?utf-8?B?aFFxTE5HSW5lYWdMenVzc3c0M0dlTEVTbkN3RC9LQXEvQzEyR1pRQ3kydWtV?=
 =?utf-8?B?MjNNQm81UzRXOTNNWTFDZlgxb3l1LzhYSDk3dk5ndFMxU25ya2NlT0grenk0?=
 =?utf-8?B?d0dyOGRkSEFwbEZnOXNxK3VqdXF1WCtya1JCTDRWc25rUTlwV2VyaVBLemJV?=
 =?utf-8?B?anhDTzJhU1FKWFpKcWljY2VzNENEclJXd1FsMS9nL0xadTJ6ZGEwcHpDWDd1?=
 =?utf-8?B?QzVweWdYTkIzU2RVV0pVZWw5UGYxUDZLY3JBVGMvOHFiMk1hRDdEcmVwaXpv?=
 =?utf-8?B?VjViWEFUeVNJSC9pd1dPN0NMcDI5YXZLYVlFVWF1R3JidXJjVGtraU5TZU5m?=
 =?utf-8?B?OTBtcGd2eTVMdCtLcU1rUmhDT0RkZ0RaUWVPMUJlamJsRUIrZG1NV0llRlBE?=
 =?utf-8?B?Y2pyTVY0RlhzTndvSFMzNnJvZjFkSW5XaVk5N3JmYi9uNzJPNHNpZFdxbkg1?=
 =?utf-8?B?b2lkVmRhQUhGNGYweXJtczdVL2laQXhWSTVaU084UzZRTGVmOVU3N2xsRjRt?=
 =?utf-8?B?L2lXalBZZ2oxQ1pydWZNU0NDbDNEaVFDVVV2blkyQnRsSFlzSDBXSFkzd2Jz?=
 =?utf-8?B?eFFTbHhuME1qaHNzczgxTEg5ZVRHYkJSUmhBRkRSMFNtRUZvMjhrVzZrZVcx?=
 =?utf-8?B?YXprQ0JrTUpJaVpRY1p5Nno2bXZDY1FQVkFxVmVKbFRkMEJNRXJteDYzSU5E?=
 =?utf-8?B?SzhZTFRFTzJnYjFXa05aM2cwbXltbGRoLy9IekQ2dlVzc2pFRXRyK1hKOUNs?=
 =?utf-8?B?bEdLOWVJTHJLdi9oRFRzYjdNVmp3YnlxZHZrT3dhVFBYZ3Nya3ZCYnU0eVRN?=
 =?utf-8?B?M2l5Wmp0YnpnWnFPaUd5U0hDdmtYbHFtL0VvVUVOaWMrOTdXbWl4Z2tVUlZt?=
 =?utf-8?B?Ulp1TjJBbkJINzVja1pzSVNpQ3A1eEFRNUtLRS9UM0dGc0tiWmpHaTJtcE5s?=
 =?utf-8?B?ZlplaHJocEN0Nis1bUZFVHpZUnNIOFZ2L3NyLzgvQVhFQW9MS1cvMzAzNnJ2?=
 =?utf-8?B?YXAvamY3RkJGUFlQNUhyVzdEVzk4MWo5WHU5aWUrckY1NWRRVk9oSUlTQjdE?=
 =?utf-8?B?MTh0dWFYaThZTjVtNVROa1cvbFk1b0tpNXVRRG16NEJCMEJlcmlLbXRqaGRn?=
 =?utf-8?B?bWNwZENGemJ2dTRXbUNjVlFtTThoYnMxU3kzbVpVellRSHRqVlZzaUVCZ2g2?=
 =?utf-8?B?azZkTnI5cDRTVVk0bmdQZHk4aWJBZWZGZzlZbllIQnhybTUyZ01zM1gySUlC?=
 =?utf-8?B?NXhYM1hBeEEyREVyOFpJOHpXdWtLTzFObS9sL0l6TGJ6V2dOWTJQMEpkb1RI?=
 =?utf-8?B?US9pRHVRV2ZNekVON0RiTnVCSUEwOXYvYU1nZlRxczZzYmEyQVhnRXlwd2Ix?=
 =?utf-8?B?SkpVN1l4eWZ4MzVjNGlKWFpjZkY4ZSsvQkF4T2VMa0tXeEVhQnZqaXJsMlg5?=
 =?utf-8?B?MjhGRTJGQjZTeUZ2b2FNYVNBaU4vaE11aktjOHd4VWlnVW92OWVnUlloQ3Vu?=
 =?utf-8?B?bUhvSTZqL215RkE5bGt6NTlaSGIwSkNzU3YrSlJCb0F1SnJUc1RqVzRWcU9q?=
 =?utf-8?B?ZWE0SmtLQ09jbGlZT0daZmtJSmg1b2tZeEhFVHByNmdxL3BtdHp4YzZEMXFo?=
 =?utf-8?B?Y3o1dy9Yb2s1K2FENzZORmpaV1BqVnFjOEtLTnVYRFhHZUNKOHgrOWgrbzFD?=
 =?utf-8?B?TEV5U2VocVZsLy9aTmtvN1p4WDJoZ2o1UU9UdFNwQ2hXL0R1cW1iSmNBaTF5?=
 =?utf-8?Q?Jy1iQ55gaPh+iTccEC4xuSpWm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7b2e99-699d-45c7-6421-08db18ab3340
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 10:12:58.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv+ziwCj/EVn8OiMarMcVr5mzRErO3Hp4WH0NsaX99a7La2mdfsEkHBVNgXEOzRXz5WAiDeZ6YvSEzcIkph+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2023 3:36 PM, Peter Zijlstra wrote:
> On Mon, Feb 27, 2023 at 12:10:41PM +0530, Raghavendra K T wrote:
>> In summary: I do see that access to VMAs from disjoint sets is not fully
>>   fair, But on the other hand it is not very bad too. There is definitely
>> some scope or possibility to explore/improve fairness in this area
>> further.
> 
> Ok, might be good to summarize some of this in a comment near here, so
> that readers are aware of the caveat of this code.
> 

Sure will do.

>> PS: I have also tested above applying V3 patch (which incorporates your
>> suggestions), have not seen much deviation in observation with patch.
> 
> I'll see if I can find it in this dumpester fire I call inbox :-)

Sorry I wasn't clear there.. Still in inbox and am about to post.. It
was a heads up.

