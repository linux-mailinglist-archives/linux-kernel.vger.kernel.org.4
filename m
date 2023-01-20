Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08E674CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjATFv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjATFvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:51:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD93E0AB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:51:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR8rQn+GOWfMkIdbsXl6+03Bbnc+j3goNE0tGbp5+AjehlAZAJFMab7douD2TsJZEa/b6Ty2DVtrFrbpGPbGMDZZvzYUzyNpUod8Dpxabc6Df3E2R3BaS0NOQoUOq7ZLhw8PXjdKIOHZCEtdeX3tad2ikaS4FK3hU/WrTWbkTuqpY7AAlgQG60u78aAdz/3blQVhUVUD/5parQJFLY5g1R8tynL061Qr2EHBz5k9I9hxtT2K1Bmz7dAFnitgUUnemypAAMpwWLF6ziZozhfadHCom3a0Ms6B6E5Mp5JQOQoqBpUp746jyR/UmGc0j1OmDNraRd8dFU41XpG2Qxg4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JEGzBhQk5KAmhE5S6dhmaC1Jcel80+KryXG7HAxKWg=;
 b=VBq0P4+BVHkeIZjwxE2vM0AwDJaYMjbTbbuCix52zusW8en9DUiow8yR36H58oZv4oMKiY8DvEahgYC2ya9txX1vawSplUyRnkXTKy+pMeykVuOjGrrJIggSZYDao2irdA5QBSlxzNXbuNzfVqvbDLwfE8rGtNwDyqA5J47oWStslSZJAJTvxdimbcy8BRhlGxWFyf4QVoRi6UkiYHCJLE2fo7IZ41fgB2Zg55ORIkOPQGoS18/0R0E2dm/tNEzzSTt5JPjTkx3suUw7WK76o1EpPzM5l/1DyGAIKRToWFi5jwpUSRcKEW8JC/0BNLW0axyu7irZGQlknDBP+N0rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JEGzBhQk5KAmhE5S6dhmaC1Jcel80+KryXG7HAxKWg=;
 b=VB7seavyUNsLS+Jc19LBz/fPKyeM+3We/CZ+1/Tm1tTizoCV+y28SyjgALBYiAamYsg9c12OmSlgW9qrrlvDVEcYlPKDaIKaKB4DCXAgQM6KvWPGdvqihx7MMePOitRY8fFSheLwNi7yH82xgyCPXNe8cdxNV8leErXssGYLDNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 05:51:05 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%6]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 05:51:05 +0000
Message-ID: <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
Date:   Fri, 20 Jan 2023 11:20:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at "Loading
 Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
To:     "Erhard F." <erhard_f@mailbox.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
 <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5178f65d-7a9a-471e-248c-08dafaaa51e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDjvNILGXJkiahoT74XuI/Bu93A/faAP3aPz7KhIe7O/x/pKoRtPU0Sv+5Pcmb+dlrwpCVJOLwy5RXsfQAERassE74VstZPqlcB5mNJrwlJHmxM0s84ZwgYweu8fK2FXdVZu97dJnnHwkdx+aI/eve6DWJwGYT2B/Tdd9FqTViTi45bpH46QMSfCQvsdWdjrPvAa0upBIdB3aZ/zZ4peEZZZBJ8kNTAV2NExAIZcYzefpEJ5A67dmkIUQgBbl4bUBOph6QKX4qHlCI/WEzft+D81gbEPc5aiTLAKcnsxTLbN/KcaEcOKp6Va/nctmo3UJR+QI7awi2hz3YRGL7+jKBFtLqjymTirGR0zA1GmcMCGpr8isrw/xGW2bi4OTdE9Z5kTK+4eDBNV9BXXWPwhdOBxgbYmkpyKkJQouWuSMuo+v0iFCERHURDd2KAVNX1qRNCBgJZcw0+IseS34pnqfQ67thuteUVElAAWm0zmdQwYG2M7yEGRruJjjKTL5XyYFellttGhYnKnQ9U7XPvtTS33kJ7tShuJsVRVZua4VpRcgLenGHOBQu6vwUy1U4afhS8hFO//PaA6iiEf4KkENVrb3XmsEmMgDF7pDs71tH6Laa1wZAOhPIeT3Nd1raaC+fcsjeBpQbJD2HmVLhr6gnr/zV9Lh56xjawdM9XmIKKl1q1EURZnWYcQRmoe/6hR/1+G2nFObwscrfVy0+Wa7rTWx+PqOWyihUgKHTivn5qjz9dkQ5HqxBOJfTNlZ/ANERfqLyV2ALtRiy1dv72eiolThLliUVaGvZoFnUhnvWpKeUoCmWnx+zEJ9pXwzGlE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(6512007)(66476007)(66946007)(66556008)(186003)(26005)(4326008)(8676002)(36756003)(6666004)(478600001)(6486002)(316002)(966005)(110136005)(6506007)(53546011)(41300700001)(86362001)(31696002)(5660300002)(31686004)(83380400001)(8936002)(2616005)(44832011)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29EZDFUWjBFNGlSazBSZmZ5ZzhSdUE5cTVmOUtoTm41YkdEOHVaRHYzY2V4?=
 =?utf-8?B?RXczNmxiVXVTakNralBuU0xDZ0p5SE1KR3hPMzB6cDM2OTFHRFpCQW9EV1Vs?=
 =?utf-8?B?UU9VUDcvbUwvWjJuM1dyVjFNSEJzaVhTRFFNYWR6TnBHbjB1NUQxTGtFM2Rw?=
 =?utf-8?B?SWQyRXhQRFpTdVExeEJzR2VQeWVFbUVBWGJEYlZkeFpKYlA1bFFNVVZJYVV2?=
 =?utf-8?B?NzBuM1dTWno0NUlKK0VYS0pERW4zVHBOcENRWUxpUzhtZ21tMVdjTUFwWXN2?=
 =?utf-8?B?QmVtR2hybjFGMmZlbUdtZFBBaTNiOElFSkE1dnVsZlhhZ1oxc1VSWms4aTUw?=
 =?utf-8?B?M2l2VHFUVGhudndVdURiK3JBUG1hK1VBUjl0NnZJdkFXMTlHNFZkZ0IrbXFw?=
 =?utf-8?B?Z21jRzYvQVFZeFlaYXExY0lUaHlOc2QxTlErUUMvdGM0S1EzRVdqanlkNjBS?=
 =?utf-8?B?MzlIVTJsOEZjQW0zLzBkRVhVelBacHNHZmZhWG8zTGx6M1lBemZDZWdpcXEz?=
 =?utf-8?B?TDNzMjU5a1JXYWFpcW93SDFzM0ZVRnJLOHBFeVpIWWJ1RUdlell1NEp2bXdo?=
 =?utf-8?B?NWIxRWpuUGVKcEY1MjgrQkgxTDA4SkVlclprL0Z6ZW5qandjdlcydko3Q1ZZ?=
 =?utf-8?B?R1RjVHJQOHpWZFM5U1lVazk4SGd0TE41aFJPZ3ZMTVI3dnV0bTNhNnBqcnVX?=
 =?utf-8?B?MzNQekQzZVQrL09CWmxHT2FOL1F4Qkk4dHJaSHJmN2RKcTlXYXdFZjZKV0ZV?=
 =?utf-8?B?OVpyYXRyYXVzeGIxWGJRenBpcHk3UDl5TzRXbzgwMy9nQUNRVDB2a0cwcEh4?=
 =?utf-8?B?TWxOUW5SMDRDRXRVLzZuRVcxTjQ5cjcvWk5laXNPRmgyNW0yais4cWtuSmtR?=
 =?utf-8?B?VzhqY2xiVEpTdUR5OS9icEpqYitheGpKTzJjaXNqN2s2eElZbnBDblZnVG8w?=
 =?utf-8?B?cm1vNFhrOVZJZXg4Y3E3Z1F4Vnp3b1ZFYjJENUMrZjV3TUx5UU01ZHMzM2E2?=
 =?utf-8?B?MkhEUFNNdmRGUzh6UnRKTDJRQ1p4d3h2N1lFZ1EyaHhPcysyQnJVMWhEM2pT?=
 =?utf-8?B?MitqaUdXc21GKzhXck91VWkxR0p1Yzc5UGwxV2dNc3AxekZCMHkwenlraWZR?=
 =?utf-8?B?WlJWK1AxWW5pTU42b05DVmFRaURoSVFkd2pNUFZKQndEMUtYcEYrRUpyYlFl?=
 =?utf-8?B?SUZSelNTWjRlNjNKeWZoOTFBSVRzSktTOXNXWHp1a2ZBQXpuQVFGWFZRTFFn?=
 =?utf-8?B?QUcwZmhTdXZWZDZ5c1dudEtQaXhpRkMxRm9iVVc3MGR6VVRrc2tuS1NCMzVD?=
 =?utf-8?B?dWNoNDF4ZkJ5elppWTNNOUVieDNXYm5WNjZ1T2ZUZnZLaTBxZG8rZzJxK3dB?=
 =?utf-8?B?eEg5L0dTdzhIOGg1OTRYN1FrU2g5TTc0TlJ3TVFKQy9XS0w4eWJsbmpNa0pJ?=
 =?utf-8?B?dTBUbVEvRHk5SXA0OXlzaFBOSm5xek1XUC8ySm90ay9oTHdOcys0dEtjemtT?=
 =?utf-8?B?TkZHaFplOGEwOXJLbVlOVzZHU09GQmZqZ0tVb3BYWXRuWEY1NlhkR1NwYzRR?=
 =?utf-8?B?RlhpbFdRYzJpR1BsVUs3RWJIdjFuTm5JTk11dXdmOUNhblNpL3h3MmNML3B0?=
 =?utf-8?B?Nm9qazhoQkdhZzVWTFA1UUMyLzA5WjlOVHdUS1BQRTg3QVd4MGdVMGk1QkZr?=
 =?utf-8?B?RlpGL21IUnRpS3pTYkI2bjdiUG9tYThVbGo3ZlJnUTN5dW40US9NV1hnSlEv?=
 =?utf-8?B?Y0RRd3QvSDJYaWpWYWRMQXJ3RkhWQTFWa25UbHJvclZJckVQT0RuQ0NSUXFG?=
 =?utf-8?B?MG1Bc2VoRUdwbXZlckhXdGtIYzJMRnM5cXVvelh2VTFoOFBGQjFWdTRpS21F?=
 =?utf-8?B?VkE1QlNuWm1xZ0Vob0dFUUdvRUpGS2IreG1uVGJxbVhuSFBkQ1JDUEtGUDBL?=
 =?utf-8?B?SUxYakJ0UUx5dTZZanpqNHVjSU9KNGhsMU9DK1dKOWVrTFZORGdNTldrcmFD?=
 =?utf-8?B?TmZob0pzQU10WElEb25HaGY2MFUzemtudEEvRzgrajhVRGZRMXdVK2tHYklr?=
 =?utf-8?B?RVhrUW5yRlZncGgxRThmSVcyaU94dURMWEdCcURjME5ndGJEZ0RidGVBdkFU?=
 =?utf-8?Q?ODekJdMTCU68yn1BDHbO9Zux9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5178f65d-7a9a-471e-248c-08dafaaa51e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 05:51:05.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bEOP1hr3qkfvzH0lIdLKNRKD8f6toiV7AJXEpeZZMS1T261eEkN3m3vox9WZzLVlXVy01YwHCd8SGXmH14ewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/2023 8:48 PM, Peter Zijlstra wrote:
> On Thu, Jan 19, 2023 at 02:56:08PM +0100, Peter Zijlstra wrote:
>> On Thu, Jan 19, 2023 at 02:23:03AM +0100, Erhard F. wrote:
>>> Hi!
>>>
>>> I did a kernel bisect for an issue I originally posted on https://github.com/ClangBuiltLinux/linux/issues/1774
>>>
>>> It is about kernel 6.1.x not booting on my machines when built with clang. A gcc built kernel with the same config just works fine. Turns out kernel v6.2-rc4 and earlier v6.2-rc are still affected.
>>>
>>> I did a kernel bisect which revealed this commit:
>>>
>>>  # git bisect bad
>>> 706460a96fc654e80b6bed1f562b00d2ce9f2f4d is the first bad commit
>>> commit 706460a96fc654e80b6bed1f562b00d2ce9f2f4d
>>> Author: Sandipan Das <sandipan.das@amd.com>
>>> Date:   Thu Aug 11 17:59:51 2022 +0530
>>>
>>>     perf/x86/amd/core: Add generic branch record interfaces
>>>     
>>>     AMD processors that are capable of recording branches support either Branch
>>>     Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
>>>     Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
>>>     calls which act as gateways to call into the feature-dependent functions
>>>     based on what is available on the processor.
>>>     
>>>     Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>     Link: https://lore.kernel.org/r/b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com
>>>
>>>  arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
>>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> Using: v6.2-rc4-67-g7287904c8771
>>
>> I have an AMD Interlagos and after bringing it back to live/up-to-date I
>> can't seem to even boot your .config in qemu/kvm irrespective of
>> GCC/Clang.
>>

I had a similar experience on a system with an AMD EPYC 7713. Both guest
and bare-metal boot failed.

>> When I build defconfig+kvm_guest.config both GCC-12 and clang-15 boot
>> just fine in qemu/kvm.
> 
> Furthermore, testing localyesconfig based off Debian's
> config-6.1.0-1-amd64 boots fine using both GCC-12 and clang-15 as host
> kernels on that machine.
> 

With the combination of defconfig+kvm_guest.config+localyesconfig, the only
thing that made a difference was the compiler optimization choice. The kernel
boots up with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y but not with
CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Both Clang 15 and 16 kernel builds are affected.

- Sandipan
