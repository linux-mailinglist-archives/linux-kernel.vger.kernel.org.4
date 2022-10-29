Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D66612524
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ2Tjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ2Tjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:39:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA05F4E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOuypOhx4rd5Xv5LYED2k7knd5ulqmmm1ZtFpLLN6AX/9+d7qMn2pB+ZH9o4lOFseiRpwpYGgiyW/u4usKL/ITbPuQFB4F0Qjjs7H1x4QOMcbPkEQnngOuc8elBA7awu2k5lS3Wcz3fC9CjDpmIxwNgZ1A1pNxYCyLnmAJKIWdl9hdJmDxFjrADfh+hG51LaAhT7zTZ+AJJt//xptfOC1Nla2k46bp7YZmHE3dP5VGHgT2R8Cj8Gd7wUDQXWrARecLwVfCjDXcoB7XSBhrWHr1JYnbJU8NmUmjcw6VEdU9gOI1d1JqIqDCyaiWaoZoh3JHUsL8EkbxZDi1Ub2X0+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS7b82Q5p4Xh/hZi0hOqWOcn2AlSZ1bur0ielNcXNgQ=;
 b=UmJotYWu3lTTSOk3GgujIqbdNoNM34JKjvKt6y8HQuzLR/BK3RAL+4js6m1cyDr+Tw0VMY8h98KuvH8MUbJO4l99KLI8GVHIHwh9qKZtp3Sm2aoKZFR5OxNw7feIipXjRDlVrykpQTRMaM3MIOlCVh57WnlSfl4hiHMciYy4M8n4aDrOYNAnGLj+44GY7bQ/sqaKh/LzWd07SL9HKnTACSIcimZgkVks9MuTbbhiZ8v652rdXU9oZeJT2RKgXLUqlfxZMokpm5CcXBQc1M5OV5wrzKPpc7AGDCXKhyGhBqjnG/5dWoHSsQRAs95VXZ9EAHCBs77XzUlVL59jvFaSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS7b82Q5p4Xh/hZi0hOqWOcn2AlSZ1bur0ielNcXNgQ=;
 b=TcngGANslKkve9cZK/4GhVUXXR7gzi5YXb2Q6+9oDjH/4irUKlvm/HMUtkoI6I4+uKZjcROZCt12fQq04iLuTwiPktUfwPs+l+bwovUrNXMpViOQO5MRkGqSPOBid+kUvy+Aj6lJJsm8MX7TvAO/Zxy967qgTMq0bR8DDrCUe0YfdRojsAyqeMQYBIsqVAI/fXw8/kXOa9MHL6FS9m1YMnhggemKFyDMFqYFO6xr3c5IVX12fo1YqE1BmXwJag51wd9r5r7WAWps9yigRjefrfIrhie1BLose2Myi8mjpWAuBJGzDvYmkTAPLPvCFOGDQ8VWG1IvDBHDLo2zohZ+6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sat, 29 Oct
 2022 19:39:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f%3]) with mapi id 15.20.5769.016; Sat, 29 Oct 2022
 19:39:32 +0000
Message-ID: <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
Date:   Sat, 29 Oct 2022 12:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
References: <20221022111403.531902164@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d602b02-a252-4c44-1e89-08dab9e54d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFUV7UA4tUzNcOcprIggOZWnM5bUyadmOB3P0Pk57FNP7U+sbpz71HFWOLmn/i8w5zpo5c9Anlr8JAxfCQd0Hr1DfBzcBg/eBfxFElMcplvYuaPR9BqUUhJ+UZNbEsukLAPqIEryaE7cntvTDY4nVFpLzYpKLnAc8C+Mh0dSpt017niM9SkXAacmyEw/9sxe1JYMmVjggAS8ruCqDitVqFKDBi6cLlnLqgVEWeDmINN+szzhBRRgKKCxzaDM0lNO2LuzRgCVGHrdDRmJ2wUS890xIPkkYafCFmA7EyLhuOVJIFcdBLMRYWacvXdbsT4Mpyys4Q8Cqu7gs0ZmBDQp6nnCTzHnrRJFEk09959qshuGfq1AoZJ0TYaZFAOEwLaY27+3tieIIDJlStpyCtC+4H73RHjqn27QrwLFSQQxZOfxfMeX2+Cyryvw5Qb3eR0CDFmgFVFboUtNJThuM7f7BJgo+CNHVQLznP3wsQ4UokDhZacn1cfN7HqdhvWCuQvzeVv2kXsgI/tk3ZqcyAFnOh573v7pZ5M8/XnZUCp0imm+lSeqwajiNuIPODICRuTrKQ2+ByAknyTfPm31CAwNRyNcrtQrOoXM7pszWV45SrewxEwgl0DXHsfrrx/t8VUICb4fOZk9izcv+4UyKQcGPmkLhn21IA/HVdaNz/YyJAFcTfW+v2SMwV4q3uwO5b7IzYSxbD3t2zljEnFEmr3t6F+t9S2L4q02HpelpLCsZUDWwdRlGu9xDRvAoLROrhq0bPGFerzKNS8ck6nMP48sYE/BZU9NNV6nxtR2LiVL2ROBQYmBekN/t1BIXSYl//4HYdozXyH2j2rUUWrt5p5YiHZIjHtiLeZprFk2FicNl1FbdlbTBpqlXfabkE5Z79N+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(2616005)(6512007)(478600001)(53546011)(6506007)(6666004)(107886003)(26005)(186003)(83380400001)(2906002)(316002)(54906003)(6486002)(966005)(110136005)(8936002)(66476007)(7416002)(4326008)(5660300002)(8676002)(66556008)(66946007)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGxmc0lCbE9RUHkyWHVDQ0JlNzFPUTBkMU5PcG92SXorSWdGL1hOQnd3VktN?=
 =?utf-8?B?QlBoYXI3TkVkUzM4TmRxTzZZeTE0REg0QlE0cGZ0Qk1MNDFpL3VLZHVjVWN2?=
 =?utf-8?B?MERGMENqNlcyc09MS2Q4dkNDZnRVcHZWSTdqUzdRTnNqSGlpTStzWlRIVnBI?=
 =?utf-8?B?SWNIbjhiNng1SUpkeDRLWDQ5cmhvZEllOWwyV3U2a1Y1RDFSWDl0dzVZMGJ0?=
 =?utf-8?B?S1NlU2NTRkdFcXVqMHN4VjVUdzVrc1FOTWltQkx5MXJCNzRPTGE3Y28ycDV5?=
 =?utf-8?B?dEVGZjBLcTVLNXh6VlU0UldYeFFiN1hMbXF3WEtjQWZkNGExYmkzTW9xak5G?=
 =?utf-8?B?NEJBVWZaRDVWejRBL0hDTU1XRVJnSkpySmswb2NPMEtBZmhEODJSa1Vvbm5F?=
 =?utf-8?B?Z1BPOHcvOWcybkpaOHJKVmdOSUhOUHNDbXY5QzJ0RVJwQkdta3dYNE11d3VV?=
 =?utf-8?B?TXFzQ3lSYTZSM2NpMU5SOFRza08vN2tSQ1hPZi94ZEEzQWxKVnd5NUMxbkoz?=
 =?utf-8?B?QmJQcW41NjJYWmdXaCtrYjREckpEcW5renkwRWZKM1BQV01Bc1prajQwZmtG?=
 =?utf-8?B?NlNZYlArODZOSFo0OGExRGE5djZXZk5yMnF2U29GNGRpQyt0K1pxZit6QjE3?=
 =?utf-8?B?Tkx0bVNYVThrK3hpTFBVU0JGdjhXeHhxQjRXaWtNVXRGSkxtc2laQTRQRGJV?=
 =?utf-8?B?T0J4MFVUeUh1RjZXN0JJZk02ZStMQkhER3VPcGZYQ1Ntd2svU1gvTGRIcFhh?=
 =?utf-8?B?Zkh5a3o1TjRGUjhyT1IvS3hZOGJsbDZzZFhobEoyclZjQlU4U0Y4L3dHc0p0?=
 =?utf-8?B?OXRmQmFET2J6eXcvZFlhWUpKWEVCRHY1dWNZdWpYWjFLNmhJMFJ5S3pDRVFy?=
 =?utf-8?B?TEVCV3NGVkpkNmkwVjl4RjlSZjdCZEhhSmpoeGdOb3FPTk4xN3MrNVNlKysx?=
 =?utf-8?B?bjc3NlpFQkVyQnNWdm1wMW1LdUN0bFA1Z2t3NHUreE1wQk5ySlBBdDVZSkVv?=
 =?utf-8?B?UGg3Sjk3VTQvWWlFOEJDcHJ3dXFzRFd4MTFVRDh1MU1jTnZUWmVsRWNGY2FE?=
 =?utf-8?B?VHB6a0loYUJybFdyME5PQUEyS2hYbzFKclhNaWpOcmdvS1pNY0F4OUlURllO?=
 =?utf-8?B?U1Z0MWhuWEhkYko1WWlOd1ltampqMURGR3JRSDl1VjFNSk4xTzl2cDladFl6?=
 =?utf-8?B?eGt6MkRHWDErWnJmUFQ3U0pBbjcwb0g0ZWhzNjUzRGkycWJYWUVqeElQS1F4?=
 =?utf-8?B?OEJBVE9aVTY4Z0JROVZHV3hGRVNvNjhkRjZIem04YytvdHl1aDNYZElidjJk?=
 =?utf-8?B?blFpNFhYL2I2UnRpeDNra1k5Y01zUzhQanlMbmZqSzluN2lGbTB4Z25leTZa?=
 =?utf-8?B?bVRaeTJXRXdNYlI5d2lZeHBIQ0pyQ2hpa0tBblV4dWNiMUh6UjdWMDdsdXhR?=
 =?utf-8?B?VmZ2UjZOdHlXL1JNYlJYM3RPc0tIQ2hsa0lVd0dNbVpWa0daYnhMWGxIUHhC?=
 =?utf-8?B?R2ZWeGtzYlRRNkY5RnRMUmJOYW95aENyM2RUU3cvVmIzaFBhN1VDbXBLUHdY?=
 =?utf-8?B?U0c0aDg2MlYzU1FhQUZoWDVEeEFZdEE0VGwybmtrSHpVN3A4bk52aENZNHhF?=
 =?utf-8?B?Nm51MlVSSVh6R3E0VUptamVkNHVUVFhZWm5mNjUxdis4ZWt2eHdySVZGQWc4?=
 =?utf-8?B?N2krQ0x4M2VWZnMrZGQ5SE1yYkdTMWY5NlNTb0NKdmVTbTUzTDY4cDdLWmcr?=
 =?utf-8?B?Q3RUdm83cDRVUkpGN0N5VTNvc1UxOWdYYUx0enZpeWdHQSs0aGp4TnNwOWlL?=
 =?utf-8?B?Z0V4MW8xamlHOGtIcmM1dTcxa2xHUVo0a3B0V0FvVFBlRFpUQ09pQkpzb2pw?=
 =?utf-8?B?WVY1VEtSS3l3VHg4VGtiN2NuWGFJOFpzeTVwcmpoWTFNMWNZbFBER2lnMlBZ?=
 =?utf-8?B?NkRtci95bG9kaWRsL0lZOHh1dUxDdGRXUU1nN1MxWGFxREhiemlORlVuNmtn?=
 =?utf-8?B?SklBaERRSGNVUTh4MlRKcWNQTnJEbE1yRUViZmtvOFhNWmRydUp3b0lOZDlH?=
 =?utf-8?B?cUJCWVI1SzAvZ21YN3AyazNlYzN0NHo3Ui9LVnZNbGp5RlBHMDNQU2ZsZk1m?=
 =?utf-8?Q?h2wO++xtx5n4sQXHId/10VCuJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d602b02-a252-4c44-1e89-08dab9e54d2a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 19:39:32.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEi4X+PR3+QkYBfmkhex+Mn6WpnwoQsZgdRBmQ3IZnJUqPQWtFSNnKbhAofaKzmooO5CIpgF382iDv22j2Ectw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 11:36, Linus Torvalds wrote:
>> In such a case, shrink_page_list() would consider the page clean, and would
>> indeed keep the page (since __remove_mapping() would find elevated page
>> refcount), which appears to give us a chance to mark the page as dirty
>> later.
> 
> Right. That is not different to any other function (like "write()"
> having looked up the page.
> 
>> However, IIUC, in this case shrink_page_list() might still call
>> filemap_release_folio() and release the buffers, so calling set_page_dirty()
>> afterwards - after the actual TLB invalidation took place - would fail.
> 
> I'm not seeing why.
> 
> That would imply that any "look up page, do set_page_dirty()" is
> broken. They don't have rmap either. And we have a number of them all
> over (eg think "GUP users" etc).

Yes, we do have a bunch of "look up page, do set_page_dirty()" cases.
And I think that many (most?) of them are in fact broken!

Because: the dirtiness of a page is something that the filesystem
believes that it is managing, and so filesystem coordination is, in
general, required in order to mark a page as dirty.

Jan Kara's 2018 analysis [1] (which launched the pin_user_pages()
effort) shows a nice clear example. And since then, I've come to believe
that most of the gup/pup call sites have it wrong:

    a) pin_user_pages() b) /* access page contents */ c)
    set_page_dirty() or set_page_dirty_lock() // PROBLEM HERE d)
    unpin_user_page()

ext4 has since papered over the problem, by soldiering on if it finds a
page without writeback buffers when it expected to be able to writeback
a dirty page. But you get the idea.

And I think that applies beyond the gup/pup situation.


[1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/T/#u


thanks,
-- 
John Hubbard
NVIDIA

