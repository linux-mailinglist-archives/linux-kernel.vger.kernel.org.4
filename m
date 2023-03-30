Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377376CFD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC3Hy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC3Hyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:54:54 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A02A59C0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680162894;
  x=1711698894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MV52fyoNIHTllvgjr2hMMPoJMLG8BXclnGuRc1KolK8=;
  b=WaojksFTXo8W+omd4Gw9Zcb1DFsuW0oikZ9PPdI1+V5/VgkHcuoNb49e
   T4mBJbZUk4+vj4D413sq/f4Dflnt1KyJzuR2tPJBizbTq0S5GenwpBBoT
   Y1vN69qwnQvpQzNYtrcnSLRT7jJLMtKoQLfhVbiBeLHFjt/MEWEizkLvk
   +T+C2TmGycuxXLOTD8M8go9z1nK1CdiczPUJFlCI/ZgHG2b3kx0s8P9Eb
   WmgQL03FB9a93P9ffx2/qzKbeascJs0X0I/eoVg9H26zby4CIZMvtIHBL
   +WHZZL1j4x7Hy45ESq18qvN9/TiuGTSqcaiCRjkRjXxkDfndROau1SUvM
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5ZmgTu472sYxoXI9fBZkhf+/ry7d2orMe7k1havhXjtcNqltd6B/i7kSSrlYxd9Xa/mE+pMlAkiluxcuBSXkjBXBrxnHYgHdjEquiq3YmyGjf/JhQF7SUYRcJR6Hf8QJLtjFiLwPD/ZSBam0Sti0xNN5Cre0ewA1rYaQDJ4Pu1GZgpscZiFbRZ29zJhOxUABlC0+zfws2k0/esTORdNtfMPoFCAoxwnTLjvJoQaAeWBUqwyhbVlRkocbAQE2ZGSy5SdeBjT/iSP6+qtH4BPOxXiAGwOVmEccPPWK0L/tGyXbI45JIdFZcAbclaaS445Uo5dpdiwMNIMZy8eSnXmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV52fyoNIHTllvgjr2hMMPoJMLG8BXclnGuRc1KolK8=;
 b=inkVwCs/SIOoz+rAam5itWaOupmxXjY3Vq+XrOCpAr+lXwkrsmOfkMPhE4LdCdSj03FEctboonm9HNnzq5Rb13JgciSiwUWZs1/EnmHaVN7yb/ggiamnal4ux9RQ/fGTcLCBz3lwG4BkrgJpLA+b4zaua8GZRmDUUXWEqqZXUoDMBSrvY43vqc2DrhOVVTta66rHAPT/lo8zCzGESxfqTRduhrGOEprVqU7VaVNKmSF6pvAhyh5Zcl22sF1irt5Gm7Zk43T2R9WHfzEly6DRTEaEpEfC2F7OzUOtbAhAZelIfdwCIWEm+ZxerygOreQskICdJyXwTJi5Gbj8487ibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV52fyoNIHTllvgjr2hMMPoJMLG8BXclnGuRc1KolK8=;
 b=Oj/ALt2+6t8Jm228GhR3a4Td7xYHtDvfwnTzwmTrcgoIsOoE5pI3PK0+kKbZNjpFTL8wasrMjz2TVovjRqcj9/o/ZiVasQMaGdoMguv0fvFMmXG7S/JqllQR/SkVcLlSfR1946gdQskt7KRSdYdClIh6kMBi5WNT0a0sJA/4E4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <61344864-cfc1-0c57-bf3b-38e5a125d281@axis.com>
Date:   Thu, 30 Mar 2023 09:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ubifs: Free memory for tmpfile name
Content-Language: en-US
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230329-memleak-fix-v1-1-7133da56ea8f@axis.com>
 <cec30bcb-85d2-5de0-186b-6838ce94e3f7@huawei.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <cec30bcb-85d2-5de0-186b-6838ce94e3f7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::18) To PAVPR02MB9523.eurprd02.prod.outlook.com
 (2603:10a6:102:303::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB9523:EE_|GV2PR02MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: eafc2e9a-e772-4213-6c1b-08db30f408e2
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdP9t7K3JqPLggRFK6Za/v2sZaVv1/RwiuypG1Riq4LInCFGYUUHZE3JYoAGzUmvuc/EUJ8YXLioHshnJDnbJAqEydqJseEHYNw7NMyjVwnXrOKC9V+KArXLtoGkxb+9ZM7v8ddlrf7eNgjCK2luivCEz7NXzKXNcmYikzDVrAuKr0N5HVxiznpgrmH5pnSHYYYz9xNoJx2Sz5ZNefliWKcEV21FDzQ40y9XL7TNMTrYc7M1b0TARHVR3YLDzm8rgiKgbrm0qdCzPXwOgoJSNETHWutfFy3Q71lXMA2+Xh4n91Qu7VSg7J010+6DF1+EVWWz8c1jZTsbLJmmbV0TC2rZubE1/YhZFJ3EmqOwchopVOTcZ8GFehCSW3neFOZ34V2UxXUdab8tFH5heGBeCUGZqXjo1vkvBw62ytzqeBaX68yYYLSBgEWG7FwHpYQDO030fZAQNilZHsEwOxDpZrWRl4zQsPeBlUPOxy+qdkYbhjrP3FO8f7BcH3sWTeVyo4KqqUjksJmapA+w8Y+nvDFXS1z5HsN6fCKTdXoqa5BdEQvxpeQRYWvuMGd8P7R/rYJgjPhP99tiP9CQk2UyH1IcFdIm25iTx3jZZxptz1YjHxDyRlyBenGOb3moP6lkQ6KI+TTwUPyz2sOrVRf6YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(31686004)(83380400001)(38100700002)(66574015)(2906002)(2616005)(6486002)(31696002)(8936002)(186003)(107886003)(316002)(110136005)(36756003)(41300700001)(5660300002)(66476007)(478600001)(4326008)(66946007)(6512007)(26005)(6506007)(66556008)(8676002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFiaFBlblZBUUM1dHVWV0M2OGxZcjB6bVVHK1lLVlp5Y1dsK0duNnNRNkpV?=
 =?utf-8?B?UTZSdzFHMFZEUXZjZTNCZHdiRDhKS292aUJXYTJxRWJ4R0IwUVFBWDlWcUkw?=
 =?utf-8?B?WkxHOCtQNi9ORFdqSmtnSU5HZGFDMXVjbTJaeE9Zb2VqS25zbkN5TVZNUmhB?=
 =?utf-8?B?dWJQa0dMblJESlh3TUZNeHY1WXh6MHpnNGZZeFhpcWFVc2FjNWFIVU5CRW5w?=
 =?utf-8?B?djRIV1pYSTFQZko3Z1VhTERHOXB1UjF5MjJUamJHT2wzYnV1TlErTFJOamJr?=
 =?utf-8?B?cjErU0tTWVVpV1NkbVViNSs3VnFZc2NzcTJRaVE2cjZTT0VISWM4bVN3M2Jx?=
 =?utf-8?B?a28yUlVJdkJvOUt0dkFjQkdVdFQ0cnpjRXR5K0pWdUlIbXU2ZXYwT0Fxcmd3?=
 =?utf-8?B?bS84WWdsb0VDTnEySUdyc01aWk9MUzl4cmo1dEtqRnB4U1NlZ2JkeUdiRHl2?=
 =?utf-8?B?Sk9jTi85dWk5a3VkeHFKUGtnVGo5MVUrc0JsMjIvZzhwZ1gwNTYrM1NVZk10?=
 =?utf-8?B?Qm5NakdoNVMvK3E1Z2xPUDNkczE3SHFvUVkrcE0zS3gwcFRPQmFsWmZrQ1Q4?=
 =?utf-8?B?RVlEMHMwMGcyWkloQXhiYTA3YzdhMFV4NjVuZ0NmV2RRbXkrTzNHK1JycHFO?=
 =?utf-8?B?YUYzOHVQZVhEeVVZcE5XRDFvUE9hV1ZsUE9sc00xQzhlQlU3ZUVMMmRCK3E0?=
 =?utf-8?B?Ujg2YmcyVEc2ZWpad29uWGxIeTB2ckZoWHRQamFGZVBXckhwMVFhenpkQzhk?=
 =?utf-8?B?UUw5SXloSUQ1LzEwOEJxODRnaSt0Z0M1VUxlajhpMkxOYkNjWmR6dVAyNjJ5?=
 =?utf-8?B?SUFvL0Z6WEY3Z3Z6bnVGL0I5MFVOb3lLU1JmaTJBNUJyRXNHL0dDdCtLNjda?=
 =?utf-8?B?UDBoc3V6dm9vQkJYU1U1M1p5ZlRWWmFjbkQ3N21UL1MrVmZyWVdoTjBHbVln?=
 =?utf-8?B?bm1qWEozSXpEOXZoTG5LVzRtcVRhSEtWWmFFYmJrYlRzU2lJSTZaL1dMbkpl?=
 =?utf-8?B?RlNHUFRXcE84Q2hqcGZ1S1JUZlRwRjhid2w1UDFES1BYdVFiN0tXOUNqeDlm?=
 =?utf-8?B?MmtQbkRIdUdldlJySlk1dHpwek10WW9MamxPUEttUEF1L3Z4L0Fhd2tJbWhT?=
 =?utf-8?B?dnhFellCSExjMFNEazBIaGxsVEdkRjAwd1dMYXplSGFjMFdWQlFOb0U0cDcz?=
 =?utf-8?B?YnVzMGZFak14MTNtV1VOam1QeTdKdVZuUWxqMGZPM2o0eU9mRHlqdmxhNHM5?=
 =?utf-8?B?d0VFd2liK2gxUENucklaQ3Bnd0xXOHBnSGM1VmpYTzcrYmt2OEdMakFaZjBQ?=
 =?utf-8?B?OGJ4N1lmNWN4ME12ZzFqV2dBQi9seHhYcW9CemNxejVBdGZHYkFTZ0pQNytv?=
 =?utf-8?B?UVlNeXNEZVRRYkZ2ZU1ueFkweitFSjZBWE5iVUl4V0o2d1M4c2hySkpXcmFj?=
 =?utf-8?B?TXpwdTB4QjQ5KzQzK1pjc2I3alFsQVJUN2FNLy83VVhrZlBJUURJSE1yclVJ?=
 =?utf-8?B?Q3RBVjZ5ZStwdzkxM21NcmpyU3gxNVhzU29FaGpVU2NIclRmRVRGNGxzRXVn?=
 =?utf-8?B?cXVsKy9DSUgrVVdjYWIyQ0FIcldLdGpkWFB0bHVXVVlTV0RRS1dZZUsrUmtM?=
 =?utf-8?B?bjV1eElTRlVSWk0vbzE2S1kwVms4MHdzV1BScDYxY3FIRU1YTWdwUExaMTBJ?=
 =?utf-8?B?bTV4MWpiSWd4djlYZ0JoOUVzL05jYXQyWWI0ajlNTGp2MEpDeXk5Mm1ISGtB?=
 =?utf-8?B?UXFub0RYbUFYSnpIaVhHcG5VN3p5a3ZvOHhPd25zbTBSNHM1aktMUjZmdmJG?=
 =?utf-8?B?ZmEzNVFwc2RBVW1lMExRbmx0R2d2U2dQYmpPR2JpazZkQUNwSzhwNitFTUJE?=
 =?utf-8?B?WTBadndROHUyeXk1TFlramk0b08vZk1SQ3A2WHdNN05uUlhtdzJDeGU0RC9s?=
 =?utf-8?B?cHhNeVZxSkszZGQyTnJWd0JhUE9aR21tNERuTkdYM085L3IyL0E4KzVseDRq?=
 =?utf-8?B?dkltWnp2VFBobG42Nm0rTjZLeDExdElwYytBSkNVaHRvL1RQQnFtTEw2UG1o?=
 =?utf-8?B?WkFIWklXYTNJSnoybHQ2aGZnQThoRWt6TjBtMG9xWDVXOFBRaURpZ1Zza2s2?=
 =?utf-8?Q?y2Pa90+wtF3jQO8zYVktUny0I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eafc2e9a-e772-4213-6c1b-08db30f408e2
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:54:48.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjrLY3h9UUb9FDvNstpCubl4Gc1hG4G138UmmEST8hC9o/ce0Z2yLnKq3euqMvUzsH5+FPcoPn8O5jbh/osygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8650
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao!

On 3/30/23 04:25, Zhihao Cheng wrote:
> Hi Mårten,
>> When opening a ubifs tmpfile on an encrypted directory, function
>> fscrypt_setup_filename allocates memory for the name that is to be
>> stored in the directory entry, but after the name has been copied to the
>> directory entry inode, the memory is not freed.
>>
>> When running kmemleak on it we see that it is registered as a leak. The
>> report below is triggered by a simple program 'tmpfile' just opening a
>> tmpfile:
>>
>>    unreferenced object 0xffff88810178f380 (size 32):
>>      comm "tmpfile", pid 509, jiffies 4294934744 (age 1524.742s)
>>      backtrace:
>>        __kmem_cache_alloc_node
>>        __kmalloc
>>        fscrypt_setup_filename
>>        ubifs_tmpfile
>>        vfs_tmpfile
>>        path_openat
>>
>> Free this memory after it has been copied to the inode.
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>>   fs/ubifs/dir.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>> index 0f29cf201136..089ca6910124 100644
>> --- a/fs/ubifs/dir.c
>> +++ b/fs/ubifs/dir.c
>> @@ -491,6 +491,7 @@ static int ubifs_tmpfile(struct user_namespace 
>> *mnt_userns, struct inode *dir,
>>           goto out_cancel;
>>       unlock_2_inodes(dir, inode);
>>   +    fscrypt_free_filename(&nm);
>>       ubifs_release_budget(c, &req);
>>         return finish_open_simple(file, 0);
>
> Looks good, just one small nit. I'd prefer to add 
> fscrypt_free_filename() after ubifs_release_budget() just like 
> ubifs_create/link does, so that ubifs can get unused budget earlier.
OK, I will move it after ubifs_release_budget.
>
> After looking through the code, I found another place create_whiteout 
> has the same problem(Imported in 278d9a243635f26c05("ubifs: Rename 
> whiteout atomically") by me). Would you mind fixing this point just by 
> removing unused 'nm' in create_whiteout()?

I see what you mean. As I understand it calling fscrypt_setup_filename 
is not needed in create_whiteout. I would prefer removing those lines in 
a separate patch since that leak is related to do_rename(). If it's OK 
with you I can make a patch for that. Would that be OK?

Kind regards

Mårten

>>
>> ---
>> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
>> change-id: 20230329-memleak-fix-87a01daf469e
>>
>> Best regards,
>>
>
