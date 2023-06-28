Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5374172D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjF1R1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:27:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27974 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232302AbjF1R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:26:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SA6o3F031485;
        Wed, 28 Jun 2023 10:26:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dkA6eOzXd1GG3+hrhXXxNJuM6i3WCZlzyKlComnzzgY=;
 b=LZ9Oz1lSinrzmK+J8g6Xrowr/X7Rlzz8ZD6QRVvdvhdAhaEVVgK6tRtKtvqGklAoDsgi
 G6FWu8TWPedky+gk5byAQMPMrSivY9MZv0IF49bGlWM9yMGnd754Yzim73b89N8ZfhWp
 jel4fC94/kl+bphFjeGi3u+1fgW4/2fse+E4aKsY08F7ytwNM2g1K4ePVnei6RpaLMSy
 QzfNGd8Qa3tIjg46uFhPJdMeD53v0uF7vGG4fmmq+WZYwHiGXk7yCFifj3nI30Yv4kbK
 lA3CibL/4iwvU8/wjy6Lv06AcyJZC3CFBNf6uRhK/sJ/m/iDWgmIom0qojadxNDUSH6V gQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfnm1rgag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BORK93Xs9Ohgp0AkI7u33B4rRsXxj+VKOmqKUpaaHyLp+fchT98QsbWr8mUFBNpD1idJuCZtyEEIS4aWiqyKSafvp9cW8WDUe2H5Dq3UKcrynfFOD7NsZaqjfTfr0v/Ue7bUuBzvtGC6EURk83ILQI7Ee4i5oVyVitMFELmXm9uUAodAU7k3m4fG0rcqF3CNc9i43BO1ztDxx/MArCbsDJgLx/X88IGuVfqWvSZ4fgKrSqakwvh2Q74C87KL/dxIJmjlJOdlHg6dpyWpnZ8yoCfaGU6mcAxb1x44aNMms/QUcumau7j4Fi3IBNWh8MeDEebcqIvjShMrZtWcztsvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkA6eOzXd1GG3+hrhXXxNJuM6i3WCZlzyKlComnzzgY=;
 b=XTm9qmMasfuh8q/2kIGtEkm8wKdNS0fq10LChLL1EWHkWh2JuKrhk3870KebB2GP3bevcIFxS48cdGckkpoGAtcMc4c9RVjBush7eBnqE7EBYK4d7sEUy/uyhK39N5MeIh3UiyDBpmwsAjCvS+uwMUyESUSU6IUFWRLU/aYJu1Q9P485v1OaIjxAz1HZ8gh4bcW1B2RCCq5rYZJvh+5V42GjtV4NB0x8/dbRJtlKh6gBkpCyO5vxAFxTntQ5igq+/4biYPUZfNw3Dcypl1km/NxpwQF9W+KlrA83LMyRHFY88RWpE0Rh5ZnuiWFMuem53hkQ/edBWIsbIw1a2cIQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB6161.namprd15.prod.outlook.com (2603:10b6:510:234::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Wed, 28 Jun
 2023 17:25:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 17:25:58 +0000
Message-ID: <7404b9cd-f57e-e76b-87ff-ae3b1f68e381@meta.com>
Date:   Wed, 28 Jun 2023 10:25:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] kallsyms: strip LTO-only suffixes from promoted global
 functions
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Yonghong Song <yhs@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Cc:     Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230628064433.2859335-1-yhs@fb.com>
 <42da73d9-063b-24c9-6a7e-734403827dcb@huawei.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <42da73d9-063b-24c9-6a7e-734403827dcb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: da560eb4-cb7b-4275-cee7-08db77fcbc9a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEPyMQgSKqNfS+c/ov6IYsFR9TDs3TYGa7X5t5qztyhrpX5JUbmIO2ZcEDbjo3M1I+3DK15mSo8pk/N4IcO5Cx7vQ8yGtuqJfGzG94KPUq9CI/kgzi/K49NCH9bfPDrBc+D9VSNfqPJebJa32watQqL5CVaYf4gBi61xR1wOSy9D7md/lr/c+q5FY77OeZhqltCtFL0ZSUUn9fofyFetqY+YyMdBKvCdPsm+BLmatIoW41m76SdSV3nCIx6OXH4cJZBihiT4RBZdh6Tub7wfJW792/exyggDGEIreyKA77suy2yT0IxofakIMjEsU2ITKKPhtsE1WkPzKedyzIruhWSkl3ZjkDI6oemhImOm4khx6byVRzJwt/9hhfAbh45aF8avOcG/fZ2fV4G7rD47T4FVXlPUZRpa2vDYnf1cM2yg83xwgukTAQE7g/Zh+/ay6XghlFiOdG06xS+MyC1KJ+DJ41UNiv4MZUzzFnh0dK0csuMcQ4RikUzcOM1TD/JHQgIoZGhOa4q+TdEE3w8RIMKd9nFCzUM0sKLHHNXbxve3KQELoFBr5GaA7DBdp4Fp9kaT9K3YkCeTCzoXz7gMRmw/r2VoHIx6taWxF/80weCMlASzvACQP1rW5AJ42GyEs0AufpTLZ290VaoKXue1lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(110136005)(5660300002)(8676002)(8936002)(41300700001)(86362001)(31686004)(6666004)(6486002)(2616005)(4326008)(316002)(966005)(66556008)(83380400001)(2906002)(66476007)(31696002)(478600001)(36756003)(66946007)(38100700002)(6512007)(6506007)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V00xUnVMU2JlTm9vRXRLYUc0d2JhQWNkRlVFSHVMbURRZjNJeEo3VmhEWW5k?=
 =?utf-8?B?NlFacitVcjhVd2lWSnUvTmZiT1lMZEFIZlIrU3lKcVFETlFTUHFZOGpjZ3k1?=
 =?utf-8?B?OFRwRHM0U1JjTy82OTF1YW1iNkV3U3ZCYTJFckJYR3hjbThSMVZxRlpWZlVO?=
 =?utf-8?B?M3lDWGpzRFBINzRiNWRUS1hVVEwzY1lFZGhaeTRwcVJUUk0zelNmM3Vzd3ZI?=
 =?utf-8?B?QVBPZ0VKbmJjbGlMalhJVzZ2Zkt4TExnSEdmQU92bVlHZXluTHRCQi8zK0Z4?=
 =?utf-8?B?c3UxckwrR05qOGdzSUdIM0dITW1XNXVtYWpCY0FTYmxHTFU1Y0ZScG1FMWxn?=
 =?utf-8?B?UWNBUTJqSzNHVnA2WElrSnZ3YzdKcnJCNmVEdHppWngzd0lLS1pRQWVuODdk?=
 =?utf-8?B?SlhZZnBTbU5kL1ppRCtVS3gwSW0vNERsT2JDSkhSb3BDT3RPeHJ5SXZ1azNy?=
 =?utf-8?B?VGpiWlFyNk9FVE8yNE9rYjZYMzJQaDJqRnpwMEhMWTVoZzRPZUpLV25oc1JH?=
 =?utf-8?B?djJQbXZzdm8yZWRiZk90azBiUFY0NWE3TFdoV1dVSFllNUlEeU9WcFhjUmlK?=
 =?utf-8?B?czAydWJJSVdjU3JFY0VjeXFTdHhrL0FJYVFnbDZXTnRaYmw0VVpFeXo4L2xo?=
 =?utf-8?B?UjltL0Q2ckwxT1d0RVAxYUNqejh0YmdNcVJRcjRtclZIZnpqY3pVcjFXQStP?=
 =?utf-8?B?a0lRVlN0RUlHcWczZ0NxcFl6dWxhRWlUWERaK1QvcTRMMEVLU0hFaEZlaXU1?=
 =?utf-8?B?bk05cGV4QzB4dHlWRXQ3NG8wYXR6NVpDdlRKMkw3K3luVHZNTVBPcm1Lb1Z6?=
 =?utf-8?B?OWtONmZ6UTNjTHNNdWRLdHpsTWxZYThGVUsyNXd0SDZtUW5EUTBRZ0JrNjVt?=
 =?utf-8?B?NXRNSVd5Qjh1Zm5FZ2hDQnFBRkU4Ly9QMXErZlJ0MnlrNGZtM3V1WjVvcUNO?=
 =?utf-8?B?WUxRQmR3ZjFSc1dCWVhpNW5RN0toVzl3TkZlRXQxOEt6Nk5UMXhBd0plc3hO?=
 =?utf-8?B?MXVHaHNuclVOL0RaeUUva0JNT2hpUTVLdmZCMnY2Q0owQWFuN3JtYWNTM3hG?=
 =?utf-8?B?K3hlc3dxbmN5VmhTV2pxL0lzRkk1a1R2SU4ybzFYWkZOZVBSdFBjaEl3RkpM?=
 =?utf-8?B?WHBhb1dpa01NM0pMbWQ1ZllVR3NpckMyTDhKSEdMMnc4aUJWcHVFdVN1WS9o?=
 =?utf-8?B?ZC9KdDNRNzNyZ3lveHNVNmlwa0lRaDV6RWw3NmlqRUNpRmRBMEZwN0RrWWRG?=
 =?utf-8?B?OFJFOThxZnNsNGx0UXBVQ3o4UEFWempZU1kxOUgwYTM1b1U3T0dkVW1LRXYy?=
 =?utf-8?B?MGdQSDdtUFJJZmw0b2tsMFJJZko0WkdUbUNTY3M1b0VyZ1pNMktIWW5wZlBR?=
 =?utf-8?B?aCsySnJaZms1Y3lBSldWUmh4dkhvRmh6R0lTZldZeitHMUdsblY3UCtZejhZ?=
 =?utf-8?B?L2FlTUhtc1hEa3lwMWNrcFhrMk1WbGRTWWkrTlE5b01qVzdTRitiNzFENnlB?=
 =?utf-8?B?K2VDcWsxLzJwQ0p2OFhEU2V0NnVyVWJzWlhPUUFudFEwcG1DMk9MK25hLzBW?=
 =?utf-8?B?NUdGSnV0cTNydERhZjVkcUUzTzVxMU1lbzZSZE5PT1NFQWpZdnVhYUtIRGE1?=
 =?utf-8?B?ZkU2UlIxU3d6cjhnd0JmZ0k0WTlpNWttdzFKRlFyUGo3WXN5YVVYUURMbVFv?=
 =?utf-8?B?dkhGK0YvQml3akxRVG5qRGtETlA3dTFHZGxtNGYxZ2lCdzNRSEs0a09OdWMz?=
 =?utf-8?B?N0ZmTWhUa3BIWkphRjhFL2dRUmxFNm1tcGFSWVc4RE5hRFBEV2hVb1dIaEVV?=
 =?utf-8?B?ZVNPaWtWbVMxUWYxcTdwSzU0YVFhYlVPMk9ReTIvbjZCME1rNVloOUxueTlr?=
 =?utf-8?B?MTNROEMzdVJGSGEvRnNiaUkzSnBFWVBIaXJLOVZ4YlkrQ2FHRkIwWEt1Z25p?=
 =?utf-8?B?M1VRTkZZNmM3emc4Y0s0VWEvMGE5cEk4Ly9hcWFDcW90dUN4MjlITVM2MWg0?=
 =?utf-8?B?VDRKd3Q3bGRObE91TWIxeElIb0ZMSnNLZjc3dFZVaXNOS1hja3JCMXRwUHBC?=
 =?utf-8?B?QzRPdU15b1FUeitTY1dLd3FSQ2RNY3RlamZaSzdMM2tsOGlnMkdXK3gwZDhE?=
 =?utf-8?B?bm9May9uMDA2Y25qRjZadzk3SERUL2tvZENmVURvVDBnblRXaUI0YVFibE1G?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da560eb4-cb7b-4275-cee7-08db77fcbc9a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 17:25:58.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVxfEAHDd/VyWHukUAs4WKnjYvRgdMd3+2a0jwWXCEtj5BkRqLHsIUfFZuFQ80wL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6161
X-Proofpoint-GUID: Taf1A6G6o6hoyAWMA1Y9WZvPgCBDJbS2
X-Proofpoint-ORIG-GUID: Taf1A6G6o6hoyAWMA1Y9WZvPgCBDJbS2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_12,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/23 4:34 AM, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/6/28 14:44, Yonghong Song wrote:
>> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
>> stripped all function/variable suffixes started with '.' regardless
>> of whether those suffixes are generated at LTO mode or not. In fact,
>> as far as I know, in LTO mode, when a static function/variable is
>> promoted to the global scope, '.llvm.<...>' suffix is added.
>>
>> The existing mechanism breaks live patch for a LTO kernel even if
>> no <symbol>.llvm.<...> symbols are involved. For example, for the following
>> kernel symbols:
>>    $ grep bpf_verifier_vlog /proc/kallsyms
>>    ffffffff81549f60 t bpf_verifier_vlog
>>    ffffffff8268b430 d bpf_verifier_vlog._entry
>>    ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>>    ffffffff82e12a1f d bpf_verifier_vlog.__already_done
>> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
>> '__already_done' are static variables used inside 'bpf_verifier_vlog',
>> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
>> Note that the func-level to file-level static function promotion also
>> happens without LTO.
>>
>> Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current mechanism will
>> return 4 symbols to live patch subsystem which current live patching
>> subsystem cannot handle it. With non-LTO kernel, only one symbol
>> is returned.
>>
>> In [1], we have a lengthy discussion, the suggestion is to separate two
>> cases:
>>    (1). new symbols with suffix which are generated regardless of whether
>>         LTO is enabled or not, and
>>    (2). new symbols with suffix generated only when LTO is enabled.
>>
>> The cleanup_symbol_name() should only remove suffixes for case (2).
>> Case (1) should not be changed so it can work uniformly with or without LTO.
>>
>> This patch removed LTO-only suffix '.llvm.<...>' so live patching and
>> tracing should work the same way for non-LTO kernel.
>>
>>   [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u
> 
> Missed the addition of:
> Reported-by: Song Liu <song@kernel.org>

Will add in the next revision.

> 
>>
>> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/kallsyms.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>> index 77747391f49b..4874508bb950 100644
>> --- a/kernel/kallsyms.c
>> +++ b/kernel/kallsyms.c
>> @@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
>>   	 * LLVM appends various suffixes for local functions and variables that
>>   	 * must be promoted to global scope as part of LTO.  This can break
>>   	 * hooking of static functions with kprobes. '.' is not a valid
>> -	 * character in an identifier in C. Suffixes observed:
>> +	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
>>   	 * - foo.llvm.[0-9a-f]+
>> -	 * - foo.[0-9a-f]+
>>   	 */
>> -	res = strchr(s, '.');
>> +	res = strstr(s, ".llvm.");
> 
> We'd better modify function cleanup_symbol_name() in scripts/kallsyms.c accordingly.

Thanks, will make corresponding change in scripts/kallsyms.c as well.

> 
> 
>>   	if (res) {
>>   		*res = '\0';
>>   		return true;
>>
> 
