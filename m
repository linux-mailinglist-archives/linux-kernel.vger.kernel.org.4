Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF76D0872
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjC3Oir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC3Oip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:38:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A257681
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680187120;
  x=1711723120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a9Ww3URL8IKa4ToDwwEl2NAqjZek9o/NJEa5wUe/rBo=;
  b=PyT8YZJzImhS0GVTtFegatzflycuaeoK2R+82qm8950yDAAQKYsYn3ql
   HwUbOda1ZSqSdKVpWQFh/rUM1OCAnfFNbNupvzENRaxkv1q9a/NWi8E7w
   jHRl99C9Bg6URILtHQizw7l24Mi8xIYAqNEW8y2BznitM81Vbr0E3DAta
   ZQ0nTkruzenpYUMXK/piojF/UtWPtytMyXCNpy5MQYmKjA/cwWb6cSlld
   LiYkUXXRmqRgYgkJhaPAlQ8IzeT2M5fPzmSeM08gPHE24ZsPZHwOdcqkK
   QtR4+cSiByJ3ab++pFl/nwvmE6/BZVRKZPNH3h86UcuyoV76eJBs3+SZ3
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYewM5jbMQ3kp1Q08eLBgIYMMu3p9li2A5tYNc+aPRs3hlfPg8Wx0KEKm9SdxGAC8wfWYBukKOD4ImKPBdnkSt2QcPaIFLYZAwe8nPIxn4mBMaRmhnYKF0cSpWA0Z9hmZawTi/rT4vFPi5TBElZ29raN87fm9pI28JvnQzZT7NXqrrvhMbQJPRy3P4xVYlZkJL7XpKEU+lv7xOOsBWi7cMS3RQhmgMKipEOzyNLYljh/E47cu1SIRCGEWAzVqLNwyT3V8GUAUfk24j/VmSfXDYd57oZPwXc2CjXInUBpxLLSZxQ4Q4Dxu9FH7yORtFHE+uSIqqV3osUzFAQc0MQYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9Ww3URL8IKa4ToDwwEl2NAqjZek9o/NJEa5wUe/rBo=;
 b=nHt1TDp7ymOOVo3U7YngbC983oxruvvJ06CmsOZD+xdGoNwLtGWJ6Rr80frVqoUdQ0eOYg6IkcO/gPn9pOvny2kZn/Ok7FHhGGAU9eyv6tnoPgsHIeL6sQT8o6AK18p9j6d31TahUqwJz3CkwffzPKmvxu0tfbx9Ce/mIoCdP2gSMMGDwHuWWRnB2r/iBUuo6TylZmN4S62+zL20H6wdZxM2dApWgzrLwISxmTpOrsrJF9qESis82Cxs6lgydWwnee18ClxuBdH1iAu7xcDKFhTooyQXOIabSngxIyU1H2lVBFcMHfdlSqjm3uLhr1LnL99dAq/o9/r6xeVhJEMsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9Ww3URL8IKa4ToDwwEl2NAqjZek9o/NJEa5wUe/rBo=;
 b=rX5OlMDb8CzzTOa+O6+bFXTGnugICXwLWn7MuDjmz/gkmmZNEAFniwxvF/NllW0NwcskJnX4v/FjhAA7rJ9ed2zbfFuqSiM/IukKQqHswW4aMZFP/Rg5Wcx7iqCu5lp1h24QIsS91sBL3zrYIFf+8Uosfa0k1JRhpNe+fDtAff0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <585bbddc-7c02-bc10-df37-6b91337e5618@axis.com>
Date:   Thu, 30 Mar 2023 16:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ubifs: Fix memory leak in do_rename
Content-Language: en-US
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230330-memleak_rename-fix-v1-1-99789e908fdf@axis.com>
 <bc8aaf0a-0b21-99a8-4c50-92edeff8edd7@huawei.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <bc8aaf0a-0b21-99a8-4c50-92edeff8edd7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::28) To PAVPR02MB9523.eurprd02.prod.outlook.com
 (2603:10a6:102:303::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB9523:EE_|PAXPR02MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 89314547-d0bc-400d-7696-08db312c71ec
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAcUAcTSXxh2biyRELuj0fpwLe36H88/vrgHG/8iSP+v7dwZmddqdRvab2tEW9rLc0xaEgdhInHsRJg/5M/vzQk4lAo1BVmpEML77pa0MrNgQaT6HIS2XUmrdzqO/kc3PSALhsdOvQdu+ap0kZKX9ulo/cfmPKrvQla77Cjzf0N1L0TP/G+J2DfTf06AwMgPQLjPENmOo6ovA4fDJbFAsVhDpw+UY4723bcoo0ZD4S8ew2Fb+p28lNpTev/kOYl2xKWvB2+6i1fZZnLZPu4fb76+4cYG6VLn/QblymVr7XApT2wEtBmwuMdOFOnieLyn+9a43+DVptItL0vRTFvhZueJ6VclsoNJAbLldYj3afhQcho14amnWNacuwgne+pVljT+UiemecERa0SrtcSjb4OuPomnXUcXI3yumJshl+lSn0GLqP5pEBz1i2QS5uguIrdsd+L+ezt7Sg0Uv05qL/DltSaSiAMPGzxCLzylLf8Csx9xPpWH5rduUEemTbsghmxir3ACegyVhplrpSz8OtK7SR7qfe8fcmX/hxvxtuOytumnHCGWXagH/BehLEhC2FnBma71k3yMJ02OYx3UAXaJRomq80AoQZI2Xicre1Nrn+A9uR4+prwgJcp7Bg/V6FVef3HUrgDtgeWvBK49aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(83380400001)(110136005)(316002)(6486002)(38100700002)(66946007)(107886003)(6512007)(53546011)(66556008)(26005)(2616005)(6506007)(2906002)(478600001)(186003)(5660300002)(31696002)(36756003)(41300700001)(8936002)(66476007)(8676002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJ0KzJTRG9YSWNSb0xnSkI3SmVqcyt4eG9PYjV3U1VtTTUyQi8zZGljZWdZ?=
 =?utf-8?B?ZlZyMTR6T0pTQlFxaFd2VVhMVFQvd3ZGY3paaWJHNVRNRURMSWUwN2UzTzlx?=
 =?utf-8?B?ditpNm9jbUZEcFhsOG1qNkkwT3U4UkJVY2cwd09vNDd5dGhQR3dHUTVwbXV4?=
 =?utf-8?B?SFlTMkxOd29WR01XdlBDc3NweDBBOGlHQXJPcFp0SmJsQk4yZkZpTDI5N0ZD?=
 =?utf-8?B?UDdmMDJENm53MWt1Mm9mYVVEZUlTbUFwWWF2cXRGbVFLMitjRTBSV0RuMG1F?=
 =?utf-8?B?dytxTmwyWVQxcngyTThSMHlMQ1htZ3U1akVpUUVGdXJOS0l3Q2tuUTVNeVB0?=
 =?utf-8?B?bjh1WnR6dG41cm13b0pIbS81R0JWTE1ieExsZzZKb2ttRzdxVGhXNzR1YWJR?=
 =?utf-8?B?aGhwc2J3N05TeFhXNUY1VlpZY2dNencvU3JXaWU0QVBWY1FkL09aSjlmaEtZ?=
 =?utf-8?B?T3ZYSXBkbk5KR1MrR1ZLb05WTURkTHFQRXdIKysyYU5XTWllQU5xbzNLMEZa?=
 =?utf-8?B?MXlpbmJkTFJzWEh6MzVDRkhrK3NsOFJJeDl0QXhQaDZDSlgzNFpSM0liWnB0?=
 =?utf-8?B?bkt2MklyWTF6MnVhZDd0V2JNVnhJQWhtSkRweXpta21hdDBzY2RHQmFFYk1N?=
 =?utf-8?B?dUY0N21CMkNJS0RlWTVOMTR2czJnZlcxK3NJUFhIY2hFbzFqdnovRWw5SWdU?=
 =?utf-8?B?cXV6RHVHTmhYdkcrSzAwOHdQakJ6cHNvVENLeWFoRUNSUDcyR0Q0dHJHM3dw?=
 =?utf-8?B?c3NkOU5PdWtvVFN4TUFvQm41NEloczIvVVROVWE1bGcxWVQ5em1mZXNObzlU?=
 =?utf-8?B?YU8yUC9MWVM5ZnpROUpwZWpidExWNkFLNWdsUHdTQXhDWlB5Rm1wd1dTYStY?=
 =?utf-8?B?MmtQdmoxZWtnNzhWUmVyb21EYUVQZ2prWmgrSFlkbE16MmtXUUdhUzdMY1F2?=
 =?utf-8?B?NTNiR0tMbHN1Qko4RHUrZ2JZTUI4Vy9SanRYaUtuNzdPaGtBZUVDYXBtK0Nn?=
 =?utf-8?B?YjE4dzc0VXNZdmY3ajFGb0IrVTgzZWhOeGNnTllycm9KRUJoU1FJNDV3dE5D?=
 =?utf-8?B?ZXhCYmd5dDZpNmRGUWFuazJvdk9TWVU1eVZHQXJJckJDMi9zaDVlNGVIcTFK?=
 =?utf-8?B?bWZhUlBoNldUaFBSZTVJRFRQR2FyU1hvVk8rd09zTDVTUy9UYW1wSExUcTI4?=
 =?utf-8?B?eTloVk94SkJpSmJkQ1pLZzJqVTNBVUg1M0dsZnNUbEhncllkTTIva0EzTW1r?=
 =?utf-8?B?K2pCOWx1clNySVE2QUhuczdmUEhVK1lvODArSThVRndldk9JRGFJdUJnMlQ1?=
 =?utf-8?B?ZzFudzFtUCtsWUtmQSs5Y1JLVU1FdmVnQW5aYnY1azM5YjBQSW85QTNTcXNr?=
 =?utf-8?B?ditNVkMrRnJEeGdxNFhrS25yTzdzSmVGUmkrMGNQQ0FPYmZOQ3Z1Z0NJRnhn?=
 =?utf-8?B?RncrUytSRjFiS0YvVnp4QkdNRnVEUzJmZGxkWGxrbHhoZHVZYlNSWXgwd1Ru?=
 =?utf-8?B?NW1wbDk2eHpQQVMwWXE1T1pxZlYrVnV4SHRRcW92UktpbllOL3Q3WDM5eDFs?=
 =?utf-8?B?U3JUdXJhRVMzWjZNdkpDaVoya0ZkL2JRdWUzNHVhZVR0SlVscWlBS1Z6UXlV?=
 =?utf-8?B?Z24vanJpZkpSaHZrdWNaZlRtdkVJQkRnNjcwQldvUWdSeXdHdVUvZTNzWXVt?=
 =?utf-8?B?dEg2Y3NvODJ1bDR6ck1rc201YjF3TUNNK0hZQWRCU0swZzgrWlJmMzhpZ1FS?=
 =?utf-8?B?c1JtRG5XOW1oUW9hTEpWR2Vob2l1aithdVd2clZOcHM3eHN3WnN4bktwdmpt?=
 =?utf-8?B?b2NkenFwWDhOY1UvNm1waVV2SUxzUjZ0TCtDWE5qa0RrRmU0K0k2anJoSzVZ?=
 =?utf-8?B?dG9MQWd1MmRUOVhON2hDdEY5dDhOejF3QmpFYitDbDh3dW43UlFGazNXb1lt?=
 =?utf-8?B?RGxFRnBkOFRiUFRrNWNlRW45OHJaa1loUTRrWm8xTVBNV09YWU9RL2FLV0dv?=
 =?utf-8?B?RzRZam5CQ3FDVDM1NTJyMEs5b3hnUXFhdzd6YW4xVUNBT1oybzNKMk5YcWw0?=
 =?utf-8?B?MXAwRW9rREVLV1I3VHYvYnNLYnNxQjgwWUhTVDd0enpJcWtSN2xmdDZEVUVy?=
 =?utf-8?Q?Q61pfYgOFy8RiDERcZKANY7WN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89314547-d0bc-400d-7696-08db312c71ec
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:38:36.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vTIuNrYrXH2ZlxFKPT8oM4hUeAIFr/c3QUB2n8Nipk2K3dyD4MoBJUcmeDtF54HxeceG4cYvFuGcUjnuGJmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7360
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

On 3/30/23 16:17, Zhihao Cheng wrote:
>> If renaming a file in an encrypted directory, function
>> fscrypt_setup_filename allocates memory for a file name. This name is
>> never used, and before returning to the caller the memory for it is not
>> freed.
>>
>> When running kmemleak on it we see that it is registered as a leak. The
>> report below is triggered by a simple program 'rename' that renames a
>> file in an encrypted directory:
>>
>>    unreferenced object 0xffff888101502840 (size 32):
>>      comm "rename", pid 9404, jiffies 4302582475 (age 435.735s)
>>      backtrace:
>>        __kmem_cache_alloc_node
>>        __kmalloc
>>        fscrypt_setup_filename
>>        do_rename
>>        ubifs_rename
>>        vfs_rename
>>        do_renameat2
>>
>> To fix this we can remove the call to fscrypt_setup_filename as it's not
>> needed.
>>
>> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>>   fs/ubifs/dir.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>
> I'm okay with this modification. It would be better to add a fix tag. 
> (Fixes: 278d9a243635f26 ("ubifs: Rename whiteout atomically"))
>
>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks! I'll send a v2 with the Fixes tag and your Reviewed-by tag.

Kind regards

Mårten

>
>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>> index 0f29cf201136..4c2dda1346e7 100644
>> --- a/fs/ubifs/dir.c
>> +++ b/fs/ubifs/dir.c
>> @@ -358,7 +358,6 @@ static struct inode *create_whiteout(struct inode 
>> *dir, struct dentry *dentry)
>>       umode_t mode = S_IFCHR | WHITEOUT_MODE;
>>       struct inode *inode;
>>       struct ubifs_info *c = dir->i_sb->s_fs_info;
>> -    struct fscrypt_name nm;
>>         /*
>>        * Create an inode('nlink = 1') for whiteout without updating 
>> journal,
>> @@ -369,10 +368,6 @@ static struct inode *create_whiteout(struct 
>> inode *dir, struct dentry *dentry)
>>       dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
>>           dentry, mode, dir->i_ino);
>>   -    err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
>> -    if (err)
>> -        return ERR_PTR(err);
>> -
>>       inode = ubifs_new_inode(c, dir, mode, false);
>>       if (IS_ERR(inode)) {
>>           err = PTR_ERR(inode);
>> @@ -395,7 +390,6 @@ static struct inode *create_whiteout(struct inode 
>> *dir, struct dentry *dentry)
>>       make_bad_inode(inode);
>>       iput(inode);
>>   out_free:
>> -    fscrypt_free_filename(&nm);
>>       ubifs_err(c, "cannot create whiteout file, error %d", err);
>>       return ERR_PTR(err);
>>   }
>>
>> ---
>> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
>> change-id: 20230330-memleak_rename-fix-6f94a6f99350
>>
>> Best regards,
>>
>
