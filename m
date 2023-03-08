Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E46B0E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjCHQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjCHQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:04:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF25DC8F;
        Wed,  8 Mar 2023 08:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL4qrX80+IzwotJuYRLFPEqurDdxAU1RtynFNr+MRVPcQ3Dq0paMFZQe49mXLUBQE1KZslG1CkoftemlH49GvXLvboFtKYvOoyX63GMfYWRD9vqV5J+4HZqZlO554uuzpSMby/PkymXIfPOxaFYMVamfCj1uUdEH98u6g3f9x0jkM9+e8pJlBavATgJv9a4Qu35fGdH+mLxLnaV3UF/RrwGURBMOq5ogD2ZWlVjph4V35KT0hrK3cBTVKvX+A26C2CFgzJ/rdsc9Bq17w3jDLm+ZwWuReImo44R4PyiLhWTa3bZ1Z3++bbfMheWEfSpy5nd2EMqczHGrKPVH7z/BWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9AGUcK5MuBtP+SG50Bllt7QAbfXch7CBg9zdu8mdVk=;
 b=NP1YrA6ridyhq1li9/HnNSYN+YqVFrM0H5veKV5KKNtjWSg4VWhIiXNYhUFOkCallfSrC9qLxlbVd4FHftNv4uS7QBYVa4ZnVbDk+vwf8GaIJeiv7GKR77mfm7cYgxZaxMPvt0240WsICzG9NBG0qZmYOl/G+af5gLP7MhbYu5CjaJkHIHvMnPE//SpyDebKVKVhDsNpVYk/oNAOwevUgAthSWfXCwD0F3sKi5oV8Xg/PNdnuamEtxvNm7z/NbiUCSaYDALCJm5wDwxfmdKCI/Hykr2R3Bv62wMZSZGMydxXyH1CHhas2OGhNzVVx2G8T25Mg62gPt+WImbojs+uHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9AGUcK5MuBtP+SG50Bllt7QAbfXch7CBg9zdu8mdVk=;
 b=nAqJn7xxffJo0PSm/hAj55BpCuh6rW5T8FL+ePfuyBkZXtpqCL87gBHmwKfpqCroiGxtMNz2plqYd7rTOSMt0WUXVKidCRA7V36Rpkrs1jkcjVGDjyekBlVQ6ZHZ/oyNx+m+CsaCBduGlEATGG28rkKdvmjM9OLDmJcZi9MaAoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 16:02:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 16:02:50 +0000
Message-ID: <d0d7b726-7149-9982-e63e-8549dea8f915@amd.com>
Date:   Wed, 8 Mar 2023 10:02:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:610:4d::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 6511e380-da33-4ed6-bc10-08db1fee9146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZOMNbQ2ma0e6fFlmndDxO707tLPKOTQdA35qoMiygpLfrBsZ1zuGj8S5La/CLEo3GJnZVWRBhTLHuoIzwGnUN4nQ5L1Wt5VwMnNbOZ57BIlRC7mHc0yStkLtQJmqfcDMO+dieA55oJuI5bB9NUjxlM6i6zqEmjUFZyxweJRlZa0VD+yNUPi2oKKhgKv7OKMB6ti7S8gq2FO/fFia3F2ujMInpt9i01zhCPMeI42ZLNL+7DUgPK6TFY74Y1BLBq38pUDD+52K/mFYmKhUj7QJwYF14lu46CcU/nnqosh3sB6pMrlRI48s6dkW/W1OUSVofCW89mRWGzy9XJcPo21ZuFpe+QZVc5zQ64BbeM1OcXn92sn5/MryMJpwwCInMKDDj0Fhv7nmaou+pXjDnhndZNQz5UwQjS+oDPxsMpE0x36KH4kqzWTkqtGLR/X6GYZk81762BR5Kbn+0jUGgbDuvW8CCZFkmZT7ovWI/QBacv1yDnLt7sQl7TkBBJGqMgYMW6+dr5wx6iLfKQJanpVUKITeYz4XLNK988Dqxyq1Eg1g2tZJNAx9Bxw5cdBjpX0nfCn/NlObry30f2wm+cYR7S0t3GQ24PkxS7ONCOaOy7zA4qrgSTc6TnpaZ8UhiBHMabeC3eC/7V5JXvvrmMiDn6HeB0jose9XaQH0XdusAaL+HMtWshdtxw2Pm4fMpsjguZLwExLwWHTuMR+5FVDvw5qu9YPIgzRv+E1QDDm/4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(8676002)(4326008)(31686004)(110136005)(54906003)(36756003)(38100700002)(8936002)(4744005)(2906002)(186003)(5660300002)(7416002)(478600001)(2616005)(86362001)(6666004)(3450700001)(6486002)(6512007)(6506007)(26005)(53546011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBRZ1hheVRoenhqRlRtSUd0NE4zQlR5L1JLSERZeW9halZONFFYSHFUTmVs?=
 =?utf-8?B?UnpyM2MrdFBTRHI4Z2tXcEpqb2lJYU1saEp2SEtJVzNmT2hqVDA4WTc1aHFG?=
 =?utf-8?B?eDIxaDJuUmtMcWhjMDJDcEk2VmFaM2kwZDI1NlhzWUlYUkVVSVJOSU9pQVJO?=
 =?utf-8?B?a3BKZ1VLc1U4cE1TbVBjakJhTWl2cU1sTTI2RVY1WGsyT3huR01rOEY4c3FJ?=
 =?utf-8?B?YWJLUVd2elZsV1o4NlBxQTVzZFZMZ3VhL05td0ZxWXF2SGJkNUZiVno2WldS?=
 =?utf-8?B?QWhxYU1lYVIwZk80QTE0TVlvZEhQSzUrWDg3WDJXZExGVHMrZFlIa3VQaHNY?=
 =?utf-8?B?V3FOU1ZPclJMeFVXbmlUR1QvdTd6eGtaUVE3U1dKeHRxQTRYbzBNQlV2ZG84?=
 =?utf-8?B?SXhZOGtxS1JyRnFUOTd6YnQxOTl2bTM1UUthNEZsSUJsVWVGQktWNzBRSlRQ?=
 =?utf-8?B?NlU2NGpCc3NZdnBXMXdvV3RudlAwenBlU3Jva044cG5nOGxaQVd0RGtZSWcy?=
 =?utf-8?B?RmRUTklqT3RFRkxZdGU3U2VON2VIdm1vSlVqQmJYamtnTkhySkNZRHR2Ym4w?=
 =?utf-8?B?aWJ1TVlyL1ZhNWFUM0tkNHBySERSWUl1SHhZOUM0UWZYaDVnZ0IwUDNJbDdy?=
 =?utf-8?B?QzMwNmR3bzV2QUpFR2dKaldDMkp1djVQY1hnOGY4bVJvY3RTb1dDSzU1KzJK?=
 =?utf-8?B?d081Y295WHBWeERmY0pXZVIxY2R4T0hyMjdTVjJUZHdSM0R6NnhRQnR3d0FQ?=
 =?utf-8?B?Z1dYV1MrVlEvUmZYTDJQcUlKQUkyV3pVMllRRklybXlYMFNoZFAzdGlKZ3Ex?=
 =?utf-8?B?SkZISG1xbWJOdDVKYndaU2tOdEx5UGR0Z3plOGY5cnlDalorQ3pnR2Fhb21p?=
 =?utf-8?B?eTJDSGJYNDlQSVB1RE5teVZ1TXh5Z2txRmJJZW9MT0s0REE5MVQ2eC96VXQy?=
 =?utf-8?B?dnJzdkdvZDFVdVN1b0hQeENYQjMxWU9EMWdPdE5PTHVJWG1OMFUyaDRqWkZQ?=
 =?utf-8?B?QzZJUVZGWi9NcGF1dkQyZ2l2QXBNSjJMVUQ4NHMwTnpKaFlYWjRnTllDY0tK?=
 =?utf-8?B?b1BoQXlTZG8xZFNaanhPT2RnVTVDOXlDQi9scDY4dklEcGI1cU5oZUJDMjJo?=
 =?utf-8?B?YWljdHovZDFaR21UMU9qV0UrT29SeXp0d0xxd2h4U1ZIMmhuMUU5b3BqYmly?=
 =?utf-8?B?VE0zdS92YkJURXZtK29EeE9jam5tR29ZclRDWmpNaDRQMUN0UUM2TnNDTWhW?=
 =?utf-8?B?Ly9sSUNWSCs2cXpJSE02U09FaWt4WTRtWGZlVnZPWTVmL1QvL1J6aXBqdzQy?=
 =?utf-8?B?NkNwZ3JINnlZeFk1eXRiOUF4MkwzMVRNRXdYSkhSZzZtU0dJMFE2NXBsSXND?=
 =?utf-8?B?R3AzNi9sTHFjcDBhMGljemVCV3VBZmtuY1kzeXBrNHRiWWhUbUw4NkN6R2s4?=
 =?utf-8?B?b3NqZk41WlN0YkxEMXQ1cFJRVE9WTmtvdWg5bVlscUdLcjNLSjZ1ejJVRnho?=
 =?utf-8?B?V0FkMjN0TTgyNC9BeTNIditGdXRkZEtNZFlZN2YzMy8yU0RIR1ZmTExNMlRT?=
 =?utf-8?B?RzdkeGZSRk43ZHNDaUUvUE1pdWlNZksreHFGcmxpRzc1SmVQNzYvQkNibXBL?=
 =?utf-8?B?enZmcXpuaHd6bVQxallxckxmM1FEVTRPYWlrcnF6LzlnMXZkZjhjaCt2ZUUw?=
 =?utf-8?B?WkhReldXdU9kQVkwZjdXaGx0V2xaeVE0ZG83RkhMTGFhT1FZK3Z6WUxvQXNV?=
 =?utf-8?B?QkgySzRYMEZkTjBnRENzMlZOWFNDZW5PVDR2ZUJJNVNkYU4ycjJIdWF4Skdi?=
 =?utf-8?B?MUtXaTc4ZHZMYlllVUpIUkU2QzgrOXFjanRzY0Z3SndGWXordFhRYzdwN3h3?=
 =?utf-8?B?czZabWRVUmtiSnlQRFU2M2FvTG1wTUphdDM4N0RmV1NzUDN6Mm5nUnhzcHJv?=
 =?utf-8?B?Q1pNM0l0UEhiejJpWmo2MURhMjg1MTF6V2M3OG5TK2FUR1ViUWZMUSt5YktD?=
 =?utf-8?B?ZjZIR2dNaEM2RmZWSEpIcGhqQzROMlUzSlNHZ1hGZjg4ZFRaOTlBbVg2YlEz?=
 =?utf-8?B?b29mME5WdEUrRHA5WDlSOXQ4NFp5U0E0cWpQOTBEdlVZcjh0dWVrb09qaFQ4?=
 =?utf-8?Q?WO6M61lh3Ectg8B/pIUeSp7hx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6511e380-da33-4ed6-bc10-08db1fee9146
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:02:50.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDzBaRPmJlh82qkW+omYO770weMx4XJ/JO8IMcPr6pmaADWmv1r8u31Q+xOaoV/u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 15:06, Linus Torvalds wrote:
> On Tue, Mar 7, 2023 at 12:54 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I think the problem is that the <asm/resctrl.h> code is disgusting and
>> horrible in multiple ways:
>>
>>  (a) it shouldn't define and declare a static function in a header file
>>
>>  (b) the resctrl_sched_in() inline function is misdesigned to begin with
> 
> Ok, so here's a *ttoally* untested and mindless patch to maybe fix
> what I dislike about that resctl code.
> 
> Does it fix the code generation issue? I have no idea. But this is
> what I would suggest is the right answer, without actually knowing the
> code any better, and just going on a mindless rampage.
> 
> It seems to compile for me, fwiw.
> 
>              Linus

Tested both on GCC and CLANG. Test passes and resctrl limits are working
fine. Thanks for the patch.

Tested-by: Babu Moger <babu.moger@amd.com>

-- 
Thanks
Babu Moger
