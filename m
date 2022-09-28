Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA555ED2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiI1BpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI1BpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:45:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DCB7766
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0Q8Oyi3dfFVk8x5YO2pGn/Bzpg8FNvPINZmlPFRj2csHZwPkgFN4enYVJo45yORA6y3CRjDdiuuYT+MXVPKbx/MH8fEbawPP1dsbBxJQ/iUTRmp6dK9PM6pH8NROuLmrTuC1hI2sFj6ncDa6PV2/uTJVVYyx0C/epnHadmhEM8Da3lhMyHXkF1T5dEyM/DONbUQG+pUY5XCbopNnOjNSZZYd49akXWL5RVAtC0D3zXWyOg8SIbGPjWomB2zlUP8E/Vb8RUFOUqegYgl1gSrqN3AtmN1AfCYbnAgcn6rfNZol6ReDUNNwu7T8X0/YOHA7pA1IChciie8EuJYAynTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bCLkesfhGCK2bHoW7QFAzSm8fOwDasa59mNb9EMsDY=;
 b=nNG+4TZ9kqR1+z4o5vIfy/8pSG4tTtvWWSYry3/AJNO7JjZ7TajbRBRSfXjkRs1P3f13xIPeOubsQeQM3k1RzhT0JYT7vLk6uuObUZ6eDLeg6mKyyRziy6BQDv3ZBf6YO6KUDc5jJXpV/ep5ura9fi7hbgUaU02+k95i9qL8mQAGHn5OXC3uFjeeJvafNii0Vm9Bl6XnHjLLmrlSLJ63YVZh591jfebLM2wOQjpLyA0RfXMw+SCG0DtfFU8XjH3PZctk46rx3SUgljiv5oYITSCfyuyZjpuM/krrHP58iZ+oXNItHjhItlGUzHb+sOXq4/x0+B2/XbTjg0KB8kJXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bCLkesfhGCK2bHoW7QFAzSm8fOwDasa59mNb9EMsDY=;
 b=Nc0MjhyDLvppqjzJENP5nHOR9d6yejoPPQfonbvXyWBKhO3jokrneuNRYMYIDH0M5gHTBt2lkNDbKl9I9a6lCxQ+o0WtURknTM5MS81bjyiBKccwTM4ORXENA221lwO0d5T1gteMY5OxePHX7it+8zqVhzyKjh6tdbGjwvbUXlQg2JQbxk6jl8y7zIDfZ0rBDpzkIocK2gfPBj8yEG2+Sp2Yy0N1ZlNOeMTCuER8G8/3vpKpN6+xoL/Y2dWByUfOag1aOrZFRnoaeHiNn+3A4FQCO0kPMlkWcCVFHrdMQsF6mmJS9SKptdC3FdYRLGpAzSfriRgUBaMoyuaOiMB69w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 01:44:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 01:44:56 +0000
Message-ID: <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com>
Date:   Tue, 27 Sep 2022 18:44:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal>
 <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal>
 <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
 <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal>
 <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8442eb-51ce-491d-42a0-08daa0f30b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IokZiyN3CHFJE+jP8FJwaPjhRWr6LofW8cfORnFBLFKb49UdJuvXDDYXvGu7R/ckCk6eX35ik5txhGtZ4CXFwgawZ5iiYaIdWBLQnD3bYm3mufsCg55iIpc4/KeRPGPAPdzRGQjM0sNuFV0jnvwoAziS0u0Jx2rSZV780QTIh/WDXaUZW4dIKJmrpWoalXyy88v3Sql86zn4E+WSZPegSWJb9CZMI3Uw91W7poTndrFe67FsLVa52YWqnj4u3AwC2yz8uBMFCDd6XG4h0eLKPiWH+cwHbTMfw05FMsZU21Wmqe+dasHP9F8w9FD/Huybp7o+A5jb1cCQ3qVMKVZUzAuVX0yxKI4i0mlPfEIshAW45lJICbP5AGBfRyNY/QGRUrc8MwjKeEy8rUjyy10kFdGSnKYfqeBnEdRskLQqA+YyF/vgcWh12hCwdJcmULFl/c1TuccVx9L1xGd6Djwaimd/O62wS+c2jPR9kFWrxeu1Su+2u1qMxPES2s/cbanCi5Bb6AE6Qk+UxpluN/KUQ7rzmejkyUHsW3S0Q5YhvR0P2DHqzOcCmuo32HNcdM2HXroiqYoj1RGa5Mv7BPNNyDmWjx23BfXDAI+ZDAqHEc26BKS1ixFnsW8I4n0gt9pbzpVedpkQ59dx0nJtfQzAh3dFLgHzFcx5BpNkV1HPSlLF10IfsPIBgD37nQEsdjlErHeL4wuG3cgRB8urPKLUrw/zoHSsPEdkCIj4SfsDATqtchOxmXtF6N0rBRnTq/nhz8w4r8A4oWCxN+JgnOqE8YYTG+piw6ozERU5sYNZZto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(4744005)(2906002)(36756003)(38100700002)(86362001)(31696002)(6486002)(478600001)(5660300002)(66946007)(8936002)(66556008)(4326008)(186003)(54906003)(316002)(110136005)(6636002)(41300700001)(6666004)(83380400001)(66476007)(8676002)(2616005)(53546011)(6512007)(26005)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERXZGhmUEJ3dytsazVzQWpjY0htanNIT2p5RGdsMzU2ZE9LdGlqWlpiMmV4?=
 =?utf-8?B?SUdmTDFEZ3h6TnZMZVozMS9Uc1hwN004bnUxR2M3SmpWTEVEeFlLdmpsRGV0?=
 =?utf-8?B?RHlPQWRoVVF1SEZ3WlVKQm8yaGpOR3Z3aDU0aHlQMmFTWGVxUXZ5eW94ekhi?=
 =?utf-8?B?ZmJUUEQ1SEYramlUbXh3VFVsakdyKzV1bG9lcmZoRWpoRnlEbnA0VEF6Yzlp?=
 =?utf-8?B?Y2FybkN5Q0dpK2J0K2VXSy9ub1BHdHRDMEU3cm5Ed3pOQzdOUS81ekV5U1l4?=
 =?utf-8?B?c2h5bllRS1BnNUs3d0VPbS9CamFVSEpadlpjeEI1OXR5MTBWWVBWdXlqeXNu?=
 =?utf-8?B?MVFNdGUvNkFnMk1PdnRPV01ZdGwrY2thb0NURnZra2FIUlBGMU85K2F3Z3VE?=
 =?utf-8?B?dFIrcktyajRHQ3ZEcDFxMXBhNk1NcEpwYTNiMjhRczQ5YXdjbmI3TmZjbms3?=
 =?utf-8?B?MzFURXpjSU1QelRoalB4cEZCNmVnS25qWXJpTysvM2dwaDlVWTJ6QUlvaUQz?=
 =?utf-8?B?S2pCbStzN01ZWVF1MmZ6QmlKQURkV2FFVUNNOTkyMFNxVyt3MnV1aUtaRnZq?=
 =?utf-8?B?cW9rTVRaZW10Q09qVW95VHpaRVU5YnZBbHNwTUx5dnR4ZDI3ZDVVQmlBdWoz?=
 =?utf-8?B?ZkJrdnFMUXZzeDFuK2tWVnlTaTU1ZXFEZllLTzBMeTh6NXo3TitJcEduRHoy?=
 =?utf-8?B?dHhjbTRsWlBKSFhPSlRDeVd4ZHVNSUsvSUd1NGNDWmJxMmNvdVRVVVkyM2Zr?=
 =?utf-8?B?bVZub2tCOHhPTTg1M3VxWCtBbENaRU1sVU9JZ09KaGhKcGdOYWZ4V2hZSHBk?=
 =?utf-8?B?bFdqK3p2alpZTEIvN3l3UWxQZlVtQXRUMnY5UUdCa3g2WVY3ZTdaZHJONnYw?=
 =?utf-8?B?cC9ick14c3grZzZNSnpvVEI2RXNxUlBlaUdDSkswNDR5L1Z6enhYQTJnQ0RO?=
 =?utf-8?B?TGYvZmMvUG9STkRyTVFVY0hFbVpwamlneTYyK0djUG9UR0VUUHk2V0lSa0Qv?=
 =?utf-8?B?cGwzWG9FRXlMTHNLdmorODlmQ1BORWNXamtJQXFCNjR2TTh5N2J5QWNoNml3?=
 =?utf-8?B?ME9WR0pWZWxnVmZXemcyeERvNm5GREt6QU1YTFluakVxVUlaYzFaOWVERERM?=
 =?utf-8?B?OGViTENlRVJtc0VKWDdwWDBKMEZ3bTNKNXNOWWFFZ0FPYm5QbUpRamZuK2JD?=
 =?utf-8?B?RXRONm1lMkFmT2FNMFcwRXhTZW43Mlk5elBBUjNuSlg1WWNJMzdJdVJwajN5?=
 =?utf-8?B?Mk96UUo1MkE1VUFZemVDSm9UTjJCOStsd3JTYmFPN3p6ZDVRWmVCS09yYTJ1?=
 =?utf-8?B?MmNsQ0wyeU0xeDhROWlNT3MyNmhJZFBGQ0kvL0FqaVFrN2N0U2lZZy9RVCtG?=
 =?utf-8?B?Y21Sbm9LdjVTWDh2WmtKQWtBUGt3eWV2UUg1SEJXNHFtS1hiV2dZY3BoeTdJ?=
 =?utf-8?B?c0RNcWE5NDBwbUMyTVR2SXB6R2FHNGR4RWVrTUJET1duSlBSeDR5Vy8zYlN3?=
 =?utf-8?B?b1NaT2NxV1BsWEhlRVo4NENwS0Y1TXVudUZJRmNyNXdEdkR2UEZSV1hRdzBq?=
 =?utf-8?B?MWU0Z0NQM3hLVExWeFVUTkVHUm9FMktkQlNUOWNYYVB2dFZ2bXB0M3F5Unpw?=
 =?utf-8?B?VnI4VU9nTnVuMi9Fa0lsa3ZIbEVyQUFvWlBpVUFwZkVmeDMzRmNnb3lUZmFn?=
 =?utf-8?B?V0N3emdBNXg2Zk0zZXlZNFp3NldKUFJpYVFFa1NiZFN4enNGTXBYTERwMXNO?=
 =?utf-8?B?ZFN1VHNPYXI4c3NmU1NOWVNlS25GYXF2TEdwS0oxZGN4ZDN1UEFzbGxNM05C?=
 =?utf-8?B?Q3YrdXY3MGo3Vnp6eE00d0ZUR2J4Yk9UeFBCZ0RHelRmR0w4RTcvRFFrQnFo?=
 =?utf-8?B?cU44L0p3cU5QUGUyOVlVaW5XYld4U0hDaFFlUXM4NE9KZ0FlYWI2N1pybVlQ?=
 =?utf-8?B?dzFBYlUxSnFFTmxDOGc1bWYxRXlBNjkxUFlMZC8zc2JIaXE5Q01uTEZ6Yzlm?=
 =?utf-8?B?b1dVS0oxYTdidHhGOXU1bkFmamUwODFjcE0rY0orRlh2NkRBOVhKbnAxSVBU?=
 =?utf-8?B?dDA1T1NGZ2JEYVEzMEhERnZGNlRNQ09wZ2k4MWh2eDZTVDJ2N2dXdWF2SDRI?=
 =?utf-8?Q?YhgunrOzI/XfWv3AtE4AFtlZ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8442eb-51ce-491d-42a0-08daa0f30b3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 01:44:56.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq3lOF9zuvIENanfY9aZRG/FLYbWCMGab3Gm7aUX6RhzLzYNaZndFqHsN+9w010u9WyqyAy4lFBB1koBxtdjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 18:41, Huang, Ying wrote:
>>>> I also agree that we cannot make any rules such as "do not lock > 1 page
>>>> at the same time, elsewhere in the kernel", because it is already
>>>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
>>>> (15) pages per batch [1].
>>
>> That's not really the case though. The inner loop of write_cache_page()
>> only ever locks one page at a time, either directly via the
>> unlock_page() on L2338 (those goto's are amazing) or indirectly via
>> (*writepage)() on L2359.
>>
>> So there's no deadlock potential there because unlocking any previously
>> locked page(s) doesn't depend on obtaining the lock for another page.
>> Unless I've missed something?
> 
> Yes.  This is my understanding too after checking ext4_writepage().
> 

Yes, I missed the ".writepage() shall unlock the page" design point. Now
it seems much more reasonable and safer. :)

thanks,

-- 
John Hubbard
NVIDIA

