Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC35735061
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFSJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjFSJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:33:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A41BCD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCVMFr2uOu88MTRMITVu6t5zClP+w484lKkvdv4RLpiBWPLPwJQIbmMB9YjABxeo0KaqAtDozbh09SKFwZptt0FWno04NEhvRG6fgvsVMJkT5w8aLtdEb+d/AprR+g1rRKH4EzTeAhH7SlCYPAbzyyFYlW40vYfgWt2sqPtBJlfO7yywDY5mTYi7XaKtSzgPH8pKUJvlm9gbiJmQve9Zux9Kh7mIqVnX0bzsOAOB5StGR9DF//JU8cR8IzGdeH4L6hC+5zNXTYNFeeRywd/bCqb7dhHl1RsJ2YUlOx6uIUMG7f2TwrkcVvOCaP/YNvdDPt6ggUIHnUOkw+UaWbsbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HkI8VeoGXjKhoA5tcoleC6UJuKEf8+EikTBpU0LDDU=;
 b=H8pAyiR8jxIQL1+seQlLM0w5XotFtxWTntGQjpFtQ9ZTFvD/MZAZqI6/UPzdXrZ+OO/hXahLFW+WsdDVQFRPsV7QBa0qp8EgNoxUfJBzcqqYwZtXME3yIPA4qI1jqU46ehqyzgLgU/yNtIsxRm4niyxUssi945JxbppYhDItBQkj8VZ0ODOlnsetJzpp2RTEkMGYlNi27yN+grfrSihJxCbb2pXsJXtT357WgqQurrQiHdGfcj7ECkAd3OC7ZdTW3E9S9EJfCqZJyvoLxsMR8AZf5v1dI9rUr4rga73ZnDxh1484FxvUTSZcrtixrnHaBt6i/o8dEm+n8C2B7ZyJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HkI8VeoGXjKhoA5tcoleC6UJuKEf8+EikTBpU0LDDU=;
 b=XVNigIRT9sv/jEaWE5oYQ2/j4BPMMWLCjm5cfpSmR+hPbUbZ+97X+7+k3pN1lU+XcES7CsaMpcIamsye3HtgvF7batT7wVAequJtTOU+YDGXKXxB6hJ5dmFLhls69CDF4tv0u/gsDIj5CBM2THgAjecHKO8YDnshAf2jioagDrT67nZ3ByrMqASATy3G4MQlhuYmXnbcCfWzi7Dvsja0WFBB7bjZ4Q8yxtSa+Urw0XmxfNHU0aiBmtSuUv48c0uDc8tN66qBFpTdSWcBLMSnpkFWPaIMqBnOU4uyF5m96tpHSGCNNME88Q6NZlwc7khKFXIsT8Y0BGO4ihV+cq2VzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5591.apcprd06.prod.outlook.com (2603:1096:101:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 09:31:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:31:44 +0000
Message-ID: <6fb1d0be-b9d5-ce0a-7984-56b2e1a1a242@vivo.com>
Date:   Mon, 19 Jun 2023 17:31:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] f2fs: compress: don't force buffered io when in
 COMPR_MODE_USER mode
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230609131555.56651-1-frank.li@vivo.com>
 <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
 <dde6972a-e98c-8a6e-493b-9aff5668101d@vivo.com>
 <7ab6b6f9-37fa-9bf2-69ce-7b1b1944d9f3@kernel.org>
 <fe223231-5445-61ef-1ba8-0d46f4f4ed5f@vivo.com>
 <65ce42d6-889a-5e1d-8f04-af8f66fd0afa@kernel.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <65ce42d6-889a-5e1d-8f04-af8f66fd0afa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d94bb1a-4d60-45d4-ef92-08db70a7fefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMl7Te0A0YJeFBtjFlZr2uIjOA1cpZbQjF1UDv2oABHEHuKaVsLZLQaqNzm7zVnnrkXBQpbbvEDsAzIm4fbraAZzl3v+4odj1ikx+XYJaRK7BPyAbh4upIGgStkTAvl/U7EOJIqeDzxkWrQdrtCFg0gl60HLLn/RO5PenK1gbTzo9IYhaMokoEGkzv/5R/Zf/jcbbokBuYHP8gdGpbD8BXUQPF4SHhyr97GQcfSuWNooGrSiel7S/jPej/z7/Jn5WRGnNAFJnqN8mYlK6jroDzEpZlE3NRAFgDGHw37bQQfP1fY8yUeqEqkAE7sKEuLFms94R0ujyiaw2PjIlsiWeYK5tQzl/+WE9EedBBjroo3f0XupqOaqbWtheiWGko4s4/0GPbYKfPj3R+BVuuJHZ3LK3pTQOWuj4KC4XFMTAR1AGnxpuNXSOJgGNy4uA2/xV0zTvZaFucHZ/s5x1CRcLt14+vTl9W07iPbvkjQhKn279bF9Tc+YnH4sU1yuFmIFaXxfJlxicCPD0T/CmbCUOU95u3830XNvz/nqVb7Q5+2GuBHcnuGPWBaMCZbV6C7R1XiPCq3uPH1EGC6xOBS5NmEFY1NFr4nhQBmopSlPhaMdCiVr1SPecVmT67bnZWttaiQnnVNBGdbriS72l7mDypNVd//QRf3f44FuLvDHdm/S9UEGYvZpmnxFeujMjYmO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(2616005)(31696002)(86362001)(2906002)(31686004)(83380400001)(5660300002)(110136005)(66476007)(8936002)(186003)(66946007)(8676002)(66556008)(36756003)(26005)(478600001)(40140700001)(38100700002)(41300700001)(4326008)(6512007)(53546011)(6506007)(52116002)(6486002)(6666004)(316002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEp4TUpBanY4YnNkZGVtVGh0a1g5UUlDeEg1L3FHSEd0YTAyRXR6YUNTMFVT?=
 =?utf-8?B?QUY5TG9LMVM3bHI3ODFXSFdzNVZWT295cVhqSk9PcFEvQ24vbWZXeDhxbjdh?=
 =?utf-8?B?OGtmVFo4UlFJVVc5Y0FCZzBYWmJxY2w4QWdtZW5iTUdFeG5HR216Y0VpNzda?=
 =?utf-8?B?Q3VUUjRwSzN2LzZZZWhzdTlIaEhQaktlQ3BuVjRMSEJKVXhyczBublg4YWsz?=
 =?utf-8?B?anoxb0JCUlB3UTRDL1RhSm1rODRtM1l3b1AzWTd0RlpCS0RROWpqa1lvdTFw?=
 =?utf-8?B?dzNoMVNQZHhrUVI2NzVTYUdRNC9qdi9icnFraXdQUnhlcGQ2Yi93RVd6YWs0?=
 =?utf-8?B?NkxXczdVK3RwaW03NEpVZ3BaOFZ1QWpsV1R1b3FpbDFYTzlXN3VqSm95MURk?=
 =?utf-8?B?RFRlaVBYWjJEUmdVc0FTMk5EQlpWQ2lMNE9rMm03bk1WMG1pMkEyd3NMRmpu?=
 =?utf-8?B?TWxYVEg5LzhMWTExYis1Y2ZCeGdIVDlXd2ljVjUzZ2hNZGx2aXhyL1FSY2FG?=
 =?utf-8?B?ZzdGaXdldysxc2JCVURIUjk3MElYYW5LQWw2Z2lBaU1RZko2TjZKTW5Qb2E4?=
 =?utf-8?B?MXpObUNyMXE0TXdCUE16dklMbDlNeGx1VUhLbXR4ODlXejNxSWhyeCtJRVdQ?=
 =?utf-8?B?VHorMWFFbzRtU2xpYy9tWmJPdUpBWjBDd0ZCREFaR1FrVUF3aU9UaGZZRmdF?=
 =?utf-8?B?WHlZTkwwWEJtU0hZRjFYMm1rZG9YZkxPamR6R1I0VGd1UXpwbFFTMmk3UU1K?=
 =?utf-8?B?dDlIaThnQU1mbklEaEljSU9qYUMxMUZjMlNZR1hmTVFiZjh1ayszb3N5Q0R3?=
 =?utf-8?B?RXBKb0E1M0VuM3RHQVBQV0k5WFVlTEhJQ2dWeWNEMExUSk9pdnhZT1JwRGll?=
 =?utf-8?B?Mzd4allhUG5hYWZPOXRvMGdnKzE3SWJFWVE2Y3lJUlJNWlQza1lwcnVJQlZG?=
 =?utf-8?B?QVdqTHdsenNVMWtjSHdaWWJxeVQrOFJ4WWtkMm0ydDJvMUVldEFNZnRNM1pr?=
 =?utf-8?B?QVkzTndtSHBGYjY0emx5RmgwNWJxOXpVQmNaVE5zSDN5cEtsRFRBOXRRVktQ?=
 =?utf-8?B?UVBCK25KQUlYMlZsT0RwMXlObzExeGNTRS84UHJLbm51UStYVElWVVZlZ2Za?=
 =?utf-8?B?bWpycnkrM24xZUFkMi9jV0VaQkdJWkxZWEM4azBhUnZvaXV0MTJwVHRldE5P?=
 =?utf-8?B?S0pLNkpRbkt3M1JxSWRZdUdlTVllb1ErMlZBS0tZK3ZvRW16MS85K2I1TlFa?=
 =?utf-8?B?STR0aE1vK0pOUkVjaCtkTmd6WmtIN3paTHdqbElWWC9RaU5hZVA0V3RZLzl0?=
 =?utf-8?B?dGQzSEtwYVhtSDNqUThQME90aWp5dWxZMWdjRS93ZG9rUjJua0g1cEpuM2Zz?=
 =?utf-8?B?MitmTGNGRlNqbUk1Q2JzOU9iVStLNTJUVWUxVm14RkJ4VHVDVk9DL0V3Q0cx?=
 =?utf-8?B?RlBseW9QMVkxN1hqS3Z3YmNPV0t3MWVZalpTWVJJYldjTUdDYVYwUHBLcE1U?=
 =?utf-8?B?MmgzUXpacGpZdW1ZcE4yeE55aVo3ekhaTkpUZ3RXWWdMb2J3UE9seVYvNWxH?=
 =?utf-8?B?Rzl2blFGQ0RQZkVyRmF0Nms0WituTXJweUJESXZPTWlGKy82d0UyYjdWeFlX?=
 =?utf-8?B?bkZ3VFQ5Yk85ckZBRmNvZjZleXhZM3F0QnVUcFM2cDBhRU9yM2owOFRHVDlU?=
 =?utf-8?B?U1BJQloyVFBlbTNKUjc0RHRQQVR2N0lxR0drSGN2aXo5UmM5bmVhcU51eXV4?=
 =?utf-8?B?Uy9teG9xVzlzSTIwTjF6ckV4eGN6cVNhM3NsbnVjY0xzUjkydWgzN214KzUx?=
 =?utf-8?B?UW1NbVpiRWJ2UEFneUJwT3h5ZDloRGtnaEYvazN0YnJPdTNxbVlWOHhycGhu?=
 =?utf-8?B?MHhlMVczN3p5SUJvRnovM3RYSVNwZlJGNU9VNk5IWXc4OCtWa1BVNkkwaGJ3?=
 =?utf-8?B?bXQrS0EvbHZULzdONWxBN2tvSXRlU1pnUm0xbzgzdmJIdTdYUVBSa0NEOVlJ?=
 =?utf-8?B?UDhyR0FRZk1HdkxaZ1F0bXZHazJrZ2FVRTJZWm1DbXNaeUlXb1JUSGlGenhG?=
 =?utf-8?B?WEllb21NT09TWmhBTlB3WmE2ejVlMC9xd3k5VXpyWk5hS05TbnlSZUhBQnlh?=
 =?utf-8?Q?p/SYWKDiRCKE7NsXPpYToHY4n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d94bb1a-4d60-45d4-ef92-08db70a7fefb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:31:44.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhNCMl7dPVS3R+DT0F8fc/HMKi+C51BiC82T5UdXzehCuINzezh9kwN9iLY2FWCSkqi6gREDRuoCQvJlEGZmHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5591
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/19 12:04, Chao Yu wrote:

> On 2023/6/19 11:11, Yangtao Li wrote:
>> On 2023/6/19 8:54, Chao Yu wrote:
>>
>>> On 2023/6/13 12:14, Yangtao Li wrote:
>>>>
>>>> On 2023/6/12 22:38, Chao Yu wrote:
>>>>> On 2023/6/9 21:15, Yangtao Li wrote:
>>>>>> It is observed that when in user compression mode
>>>>>> (compress_extension=*),
>>>>>> even though the file is not compressed, the file is still forced 
>>>>>> to use
>>>>>> buffer io, which makes the AndroBench sequential read and write drop
>>>>>> significantly. In fact, when the file is not compressed, we don't 
>>>>>> need
>>>>>> to force it to buffer io.
>>>>>>
>>>>>>                    | w/o patch | w/ patch |
>>>>>> seq read  (MB/s) | 1320.068  | 3696.154 |
>>>>>> seq write (MB/s) | 617.996   | 2978.478 |
>>>>>>
>>>>>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>>>>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>>>>> ---
>>>>>>    fs/f2fs/f2fs.h | 14 ++++++++++++++
>>>>>>    fs/f2fs/file.c |  2 +-
>>>>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>> index 1efcfd9e5a99..7f5472525310 100644
>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct
>>>>>> inode *inode)
>>>>>>            is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>>>>>>    }
>>>>>>    +static inline bool f2fs_is_compressed_file(struct inode *inode)
>>>>>> +{
>>>>>> +    int compress_mode = 
>>>>>> F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>>>>> +
>>>>>> +    if (compress_mode == COMPR_MODE_FS)
>>>>>> +        return f2fs_compressed_file(inode);
>>>>>> +    else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||
>>>>>
>>>>> Should check dirty page as well? i_compr_blocks may increase after
>>>>> data writeback.
>>>>>
>>>> IIUC, in COMPR_MODE_USER mode, i_compr_blocks will only be updated 
>>>> when
>>>> FI_ENABLE_COMPRESS is enabled.
>>>>
>>>> If FI_ENABLE_COMPRESS is not enabled, i_compr_blocks will never be
>>>> updated after data writeback.
>>>>
>>>> So there is no need to additionally judge whether there is a dirty 
>>>> page?
>>>
>>> Oh, user mode, that's correct.
>>>
>>> If we allow dio/aio on compress file, it needs to consider race case in
>>> between aio and ioc_compress_file.
>>
>>
>> The inode_lock is already held in f2fs_file_write_iter and 
>> f2fs_ioc_compress_file, I guess this is enough?
>>
>> What else?
>
> aio may complete outside inode lock, so it needs to call inode_dio_wait()
> in f2fs_ioc_compress_file() to avoid the race case?


How about adding this below？

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f45d05c13ae5..5021d13e788b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4146,6 +4146,10 @@ static int f2fs_ioc_compress_file(struct file *filp)
                 goto out;
         }

+       /* avoid race case between aio and ioc_compress_file */
+       if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
+               inode_dio_wait(inode);
+
         ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
         if (ret)
                 goto out;


Thanks,


>
> Thanks,
>
>>
>>
>> 4691 static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct 
>> iov_iter *from)
>> 4692 {
>> 4693         struct inode *inode = file_inode(iocb->ki_filp);
>> 4694         const loff_t orig_pos = iocb->ki_pos;
>> 4695         const size_t orig_count = iov_iter_count(from);
>> 4696         loff_t target_size;
>> 4697         bool dio;
>> 4698         bool may_need_sync = true;
>> 4699         int preallocated;
>> 4700         ssize_t ret;
>> 4701
>> 4702         if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
>> 4703                 ret = -EIO;
>> 4704                 goto out;
>> 4705         }
>> 4706
>> 4707         if (!f2fs_is_compress_backend_ready(inode)) {
>> 4708                 ret = -EOPNOTSUPP;
>> 4709                 goto out;
>> 4710         }
>> 4711
>> 4712         if (iocb->ki_flags & IOCB_NOWAIT) {
>> 4713                 if (!inode_trylock(inode)) {
>> 4714                         ret = -EAGAIN;
>> 4715                         goto out;
>> 4716                 }
>> 4717         } else {
>> 4718                 inode_lock(inode);
>> 4719         }
>>
>>
>> 4115 static int f2fs_ioc_compress_file(struct file *filp)
>> 4116 {
>> 4117         struct inode *inode = file_inode(filp);
>> 4118         struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> 4119         pgoff_t page_idx = 0, last_idx;
>> 4120         unsigned int blk_per_seg = sbi->blocks_per_seg;
>> 4121         int cluster_size = F2FS_I(inode)->i_cluster_size;
>> 4122         int count, ret;
>> 4123
>> 4124         if (!f2fs_sb_has_compression(sbi) ||
>> 4125                         F2FS_OPTION(sbi).compress_mode != 
>> COMPR_MODE_USER)
>> 4126                 return -EOPNOTSUPP;
>> 4127
>> 4128         if (!(filp->f_mode & FMODE_WRITE))
>> 4129                 return -EBADF;
>> 4130
>> 4131         if (!f2fs_compressed_file(inode))
>> 4132                 return -EINVAL;
>> 4133
>> 4134         f2fs_balance_fs(sbi, true);
>> 4135
>> 4136         file_start_write(filp);
>> 4137         inode_lock(inode);
>>
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>
>>>> Thanks,
>>>>
>>>>> Thanks,
>>>>>
>>>>>> +        is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
>>>>>> +        is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
>>>>>> +        return true;
>>>>>> +
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>>    static inline bool f2fs_need_compress_data(struct inode *inode)
>>>>>>    {
>>>>>>        int compress_mode = 
>>>>>> F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index 74ecc9e20619..0698129b2165 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode
>>>>>> *inode, int rw)
>>>>>>            return true;
>>>>>>        if (fsverity_active(inode))
>>>>>>            return true;
>>>>>> -    if (f2fs_compressed_file(inode))
>>>>>> +    if (f2fs_is_compressed_file(inode))
>>>>>>            return true;
>>>>>>          /* disallow direct IO if any of devices has unaligned 
>>>>>> blksize */
