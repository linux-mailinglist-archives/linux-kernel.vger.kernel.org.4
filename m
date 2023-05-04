Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7BA6F62E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEDCWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDCWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D51A1;
        Wed,  3 May 2023 19:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6312F61BF0;
        Thu,  4 May 2023 02:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75496C433EF;
        Thu,  4 May 2023 02:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683166935;
        bh=zYg+Thhfj2kqapZClkQyeQ4gfvuTkn6TncHltGVj3Mg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EmJwl+6TMhzhxzJNU/dKkD9bblgEI1Rf7ZX+f5QlDfb3wjpY/2NmZcWKBQtcrc9Ac
         yCvi3P6sPxSQUX9j3lfTa8HDL1qhZGSr/zsz43NsaH3htcymRwQP2LcOeVySQLCqHq
         MHKQYBroNYAgRw6bfV/+QWpQS8GTY2w6lcn9GAEvN3qDmhV/1xwOXU3iIkmxl08nDx
         rJXdX+2ZNpQbhlNV6av5RvqsjdBWO1KFdPy9bWQk0QE+vDH4Kc8OCZ2tft1iTg7Oon
         XIJT1PnRDVWYw+CbBhIDebHoz6NtgBTL5GsocG0V69AERRjRSldUtfJl/loIY1ZRkO
         Vjx/u49EJGC2g==
Message-ID: <306ff487-06d2-4ec7-c3c0-65ac066aa0f4@kernel.org>
Date:   Thu, 4 May 2023 10:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: (2) [PATCH v4] f2fs: add async reset zone command support
Content-Language: en-US
To:     daejun7.park@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Cc:     Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
References: <6596335b-2448-20f7-30ea-42ba40f1af72@kernel.org>
 <20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p7>
 <CGME20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p2>
 <20230504020810epcms2p2511cc27f9824fee69563e2be99284f78@epcms2p2>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230504020810epcms2p2511cc27f9824fee69563e2be99284f78@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/4 10:08, Daejun Park wrote:
> Thank you for reviewing the patch.
> 
>> --------- Original Message ---------
>> Sender : Chao Yu <chao@kernel.org>
>> Date : 2023-05-04 10:43 (GMT+9)
>> Title : Re: [PATCH v4] f2fs: add async reset zone command support
>> To : 박대준<daejun7.park@samsung.com>, jaegeuk@kernel.org<jaegeuk@kernel.org>, rostedt@goodmis.org<rostedt@goodmis.org>, mhiramat@kernel.org<mhiramat@kernel.org>, linux-f2fs-devel@lists.sourceforge.net<linux-f2fs-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org<linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org<linux-trace-kernel@vger.kernel.org>
>> CC : 김석환<sukka.kim@samsung.com>, 송용길<yonggil.song@samsung.com>, 김범수<beomsu7.kim@samsung.com>
>>   
>> On 2023/5/2 12:16, Daejun Park wrote:
>>> Changelog:
>>>
>>> v3 -> v4
>>> Fixed build error caused by unused function.
>>>
>>> v2 -> v3
>>> Modified arguments to be correct for ftrace parameter.
>>> Changed __submit_zone_reset_cmd to void return.
>>> Refactored the f2fs_wait_discard_bio function.
>>> Fixed code that was previously incorrectly merged.
>>>
>>> v1 -> v2
>>> Changed to apply the optional async reset write pointer by default.
>>>
>>> This patch enables submit reset zone command asynchornously. It helps
>>> decrease average latency of write IOs in high utilization scenario by
>>> faster checkpointing.
>>>
>>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>> ---
>>>    fs/f2fs/segment.c           | 83 +++++++++++++++++++++++++++++++++++--
>>>    include/trace/events/f2fs.h | 18 +++++++-
>>>    2 files changed, 96 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 6db410f1bb8c..ec7a8de71198 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1196,6 +1196,44 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>>>    static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>                                    struct block_device *bdev, block_t lstart,
>>>                                    block_t start, block_t len);
>>> +
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +static void __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
>>> +                                   struct discard_cmd *dc, blk_opf_t flag,
>>> +                                   struct list_head *wait_list,
>>> +                                   unsigned int *issued)
>>> +{
>>> +        struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>> +        struct block_device *bdev = dc->bdev;
>>> +        struct bio *bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET | flag, GFP_NOFS);
>>> +        unsigned long flags;
>>> +
>>> +        trace_f2fs_issue_reset_zone(bdev, dc->di.start);
>>> +
>>> +        spin_lock_irqsave(&dc->lock, flags);
>>> +        dc->state = D_SUBMIT;
>>> +        dc->bio_ref++;
>>> +        spin_unlock_irqrestore(&dc->lock, flags);
>>> +
>>> +        if (issued)
>>> +                (*issued)++;
>>> +
>>> +        atomic_inc(&dcc->queued_discard);
>>> +        dc->queued++;
>>> +        list_move_tail(&dc->list, wait_list);
>>> +
>>> +        /* sanity check on discard range */
>>> +        __check_sit_bitmap(sbi, dc->di.lstart, dc->di.lstart + dc->di.len);
>>> +
>>> +        bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(dc->di.start);
>>> +        bio->bi_private = dc;
>>> +        bio->bi_end_io = f2fs_submit_discard_endio;
>>> +        submit_bio(bio);
>>
>> How about accounting iostat info for zone reset command?
>>
>> f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO, len * F2FS_BLKSIZE);
> 
> Sure, I will do.
>   
>>> +
>>> +        atomic_inc(&dcc->issued_discard);
>>> +}
>>> +#endif
>>> +
>>>    /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
>>>    static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>                                    struct discard_policy *dpolicy,
>>> @@ -1217,6 +1255,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>>            if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>>                    return 0;
>>>    
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +        if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev)) {
>>> +                __submit_zone_reset_cmd(sbi, dc, flag, wait_list, issued);
>>> +                return 0;
>>> +        }
>>> +#endif
>>> +
>>>            trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
>>>    
>>>            lstart = dc->di.lstart;
>>> @@ -1461,6 +1506,19 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>            }
>>>    }
>>>    
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +static void __queue_zone_reset_cmd(struct f2fs_sb_info *sbi,
>>> +                struct block_device *bdev, block_t blkstart, block_t lblkstart,
>>> +                block_t blklen)
>>> +{
>>> +        trace_f2fs_queue_reset_zone(bdev, blkstart);
>>> +
>>> +        mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
>>> +        __insert_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
>>> +        mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
>>> +}
>>> +#endif
>>> +
>>>    static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>>                    struct block_device *bdev, block_t blkstart, block_t blklen)
>>>    {
>>> @@ -1724,6 +1782,19 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>>>    
>>>            mutex_lock(&dcc->cmd_lock);
>>>            dc = __lookup_discard_cmd(sbi, blkaddr);
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +        if (dc && f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
>>> +                /* force submit zone reset */
>>> +                if (dc->state == D_PREP)
>>> +                        __submit_zone_reset_cmd(sbi, dc, REQ_SYNC,
>>> +                                                &dcc->wait_list, NULL);
>>> +                dc->ref++;
>>
>> IIUC, should be?
>>
>> else
>>          dc->ref++;
>>
>> Thanks,
> 
> In case of discard, we can delete a pending discard via __punch_discard_cmd().
> However, we cannot remove the pending zone reset command.
> And, we should always wait for the completion of the zone reset command,
> so I increased the reference counter.

Oh, I missed that we always call __wait_one_discard_bio() for zone reset case,
thanks for the explanation anyway.

Thanks,

> 
> Thanks,
> Daejun
> 
>   
>>> +                mutex_unlock(&dcc->cmd_lock);
>>> +                /* wait zone reset */
>>> +                __wait_one_discard_bio(sbi, dc);
>>> +                return;
>>> +        }
>>> +#endif
>>>            if (dc) {
>>>                    if (dc->state == D_PREP) {
>>>                            __punch_discard_cmd(sbi, dc, blkaddr);
>>> @@ -1876,9 +1947,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>>>                                     blkstart, blklen);
>>>                            return -EIO;
>>>                    }
>>> -                trace_f2fs_issue_reset_zone(bdev, blkstart);
>>> -                return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
>>> -                                        sector, nr_sects, GFP_NOFS);
>>> +
>>> +                if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING))) {
>>> +                        trace_f2fs_issue_reset_zone(bdev, blkstart);
>>> +                        return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
>>> +                                                sector, nr_sects, GFP_NOFS);
>>> +                }
>>> +
>>> +                __queue_zone_reset_cmd(sbi, bdev, blkstart, lblkstart, blklen);
>>> +                return 0;
>>>            }
>>>    
>>>            /* For conventional zones, use regular discard if supported */
>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>> index 99cbc5949e3c..ee1477de8324 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -1512,7 +1512,7 @@ DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
>>>            TP_ARGS(dev, blkstart, blklen)
>>>    );
>>>    
>>> -TRACE_EVENT(f2fs_issue_reset_zone,
>>> +DECLARE_EVENT_CLASS(f2fs_reset_zone,
>>>    
>>>            TP_PROTO(struct block_device *dev, block_t blkstart),
>>>    
>>> @@ -1528,11 +1528,25 @@ TRACE_EVENT(f2fs_issue_reset_zone,
>>>                    __entry->blkstart = blkstart;
>>>            ),
>>>    
>>> -        TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
>>> +        TP_printk("dev = (%d,%d), zone at block = 0x%llx",
>>>                    show_dev(__entry->dev),
>>>                    (unsigned long long)__entry->blkstart)
>>>    );
>>>    
>>> +DEFINE_EVENT(f2fs_reset_zone, f2fs_queue_reset_zone,
>>> +
>>> +        TP_PROTO(struct block_device *dev, block_t blkstart),
>>> +
>>> +        TP_ARGS(dev, blkstart)
>>> +);
>>> +
>>> +DEFINE_EVENT(f2fs_reset_zone, f2fs_issue_reset_zone,
>>> +
>>> +        TP_PROTO(struct block_device *dev, block_t blkstart),
>>> +
>>> +        TP_ARGS(dev, blkstart)
>>> +);
>>> +
>>>    TRACE_EVENT(f2fs_issue_flush,
>>>    
>>>            TP_PROTO(struct block_device *dev, unsigned int nobarrier,
>>
>>   
>>   
