Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB162F3AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiKRL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:26:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364A1100;
        Fri, 18 Nov 2022 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668770780; x=1700306780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l57k8EFLzzzCOgsedkHMQdqgrBUn6tk+oHcf6jB45mk=;
  b=QnVbEPuztlvh+Cx7xS+M61tv0js/VpF8Prm9y8tOfFuPpZaO3wWhgvAe
   togYGag8QsIUqv1GOEA6QBQFk3yWRN89R0Dum6k6B/n7WbkDtfJIu8Cga
   GuqLF7w61RpQeJC/itWuVaPWfrpG85DdX2h1pkYCR97N8ntOJ9chA4Ivq
   x+Iz3xiUofl9VnF4l7Nk/u8IEorQVo/MoEPStgmhUuxmuNibnN8XDzRX0
   llZMEpe3S2t7VenODAG0WxpxCAavILHnthPWzzHDZIJRJhONr/82B2bp4
   naO/yCZhrYf9rey4eNnheRu9uXaB77A/IDCjOHVtLMCJ1ngzWzQFNAmpb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314934160"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="314934160"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:26:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="617986964"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="617986964"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:26:14 -0800
Message-ID: <4c1826b3-90b0-7f82-fd0d-3167a6a074c6@intel.com>
Date:   Fri, 18 Nov 2022 13:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     ulf.hansson@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        axboe@kernel.dk, avri.altman@wdc.com, kch@nvidia.com,
        CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com>
 <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
 <e0381607-d4ba-5a75-3710-8811a0776b91@intel.com>
 <CA+Da2qyh14b2DrOpi4iW4AyuxT68ULh-q-g3TcHWPEv2fyBKoQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qyh14b2DrOpi4iW4AyuxT68ULh-q-g3TcHWPEv2fyBKoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/22 12:54, Wenchao Chen wrote:
> On Fri, Nov 18, 2022 at 6:12 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/11/22 09:58, Wenchao Chen wrote:
>>> Hi Hunter
>>> Thank you for your review!
>>> I'm sorry to reply you so late because I've been too busy lately.
>>>
>>> On Fri, Oct 21, 2022 at 11:50 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 21/10/22 10:30, Wenchao Chen wrote:
>>>>> From: Wenchao Chen <wenchao.chen@unisoc.com>
>>>>>
>>>>> Summary
>>>>> =======
>>>>> These patches[1] supports the host to turn off FUA.
>>>>>
>>>>> About FUA, roughly deal with the following two parts:
>>>>> 1) FUA(Forced Unit Access):
>>>>> - The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted from the
>>>>>   filesystem and will make sure that I/O completion for this request is only
>>>>>   signaled after the data has been committed to non-volatile storage.
>>>>>
>>>>> 2) In emmc, FUA is represented as Reliable write. code show as below:
>>>>> static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>>>>>               int recovery_mode, bool *do_rel_wr_p, bool *do_data_tag_p)
>>>>> {
>>>>>       ...
>>>>>       /*
>>>>>        * Reliable writes are used to implement Forced Unit Access and
>>>>>        * are supported only on MMCs.
>>>>>        */
>>>>>       do_rel_wr = (req->cmd_flags & REQ_FUA) &&
>>>>>                       rq_data_dir(req) == WRITE &&
>>>>>                       (md->flags & MMC_BLK_REL_WR);
>>>>>       ...
>>>>> }
>>>>>
>>>>> Patch structure
>>>>> ===============
>>>>> patch#1:  for block
>>>>> patch#2:  for sdhci-sprd
>>>>>
>>>>> Tests
>>>>> =====
>>>>> Ran 'AndroBench' to evaluate the performance:
>>>>
>>>> It would be good to have more details e.g.
>>>> What file system? What block size?  What journal size?
>>>> What file size? What record size?
>>>>
>>>
>>> What file system?
>>> F2FS
>>> What block size?
>>> Sequential: 32768KB, Random: 4KB
>>> What file size?
>>> 64MB
>>>
>>>>> 1. fua_disable = 1
>>>>> /sys/block/mmcblk0/queue # cat fua 0
>>>>> I tested 5 times for each case and output a average speed.
>>>>>
>>>>> 1) Sequential read:
>>>>> Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
>>>>> Average speed: 265.74MiB/s
>>>>>
>>>>> 2) Random read:
>>>>> Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
>>>>> Average speed: 98.81MiB/s
>>>>>
>>>>> 3) Sequential write:
>>>>> Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
>>>>> Average speed: 200.5MiB/s
>>>>>
>>>>> 4) Random write:
>>>>> Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
>>>>> Average speed: 70.32MiB/s
>>>>>
>>>>> 2. fua_disable = 0 (default 0)
>>>>> /sys/block/mmcblk0/queue # cat fua 1
>>>>> I tested 5 times for each case and output a average speed.
>>>>>
>>>>> 1) Sequential read:
>>>>> Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
>>>>> Average speed: 257.86MiB/s
>>>>>
>>>>> 2) Random read:
>>>>> Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
>>>>> Average speed: 100.2MiB/s
>>>>>
>>>>> 3) Sequential write:
>>>>> Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
>>>>> Average speed: 149.48MiB/s
>>>>>
>>>>> 4) Random write:
>>>>> Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
>>>>> Average speed: 12.68MiB/s
>>>>
>>>> Is every write being sync'ed of just sync at the end?
>>>>
>>>
>>> /*
>>> * Reliable writes are used to implement Forced Unit Access and
>>> * are supported only on MMCs.
>>> */
>>> do_rel_wr = (req->cmd_flags & REQ_FUA) &&
>>>     rq_data_dir(req) == WRITE &&
>>>     (md->flags & MMC_BLK_REL_WR);
>>>
>>> A Reliable Write access shall force the data to be written to the
>>> nonvolatile storage。
>>> It will consume more time.
>>
>> Reliable write is slow because it guarantees not to tear the write.
>> The issue is torn writes, not just FUA.
>>
> 
> If you'd like, could you introduce Reliable write that doesn't tear writes?

Not following you.  Reliable Write doesn't tear writes, that is why it is used.

> 
>>>
>>>>>
>>>>> According to the above data, disable FUA (fua_disable = 1) improves the
>>>>> performance:
>>>>> 1)Sequential read improved by 3%.
>>>>> 2)Random read were down 1%.
>>>>
>>>> FUA should not affect reads.  If it is, you may want to investigate how.
>>>>
>>>>> 3)Sequential write improved by 34%.
>>>>> 4)Random write improved by 454%.
>>>>> Therefore, it is recommended to support the host to control FUA.
>>>>>
>>>>> Reference
>>>>> =========
>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/writeback_cache_control.rst
>>>>> [2] Embedded Multi-Media Card (e•MMC) Electrical Standard (5.1)''
>>>>
>>>> You do not seem to have considered data integrity.
>>>>
>>>> Regular disks are assumed to provide atomic sector writes.  That is, a sector has either the old data or the new data, but not some corrupt mixture.
>>>>
>>>> mmc does not have that assumption, which is presumably why Reliable Write has been used instead.  Although that idea appears to have been thrown away for devices with no cache by commit 08ebf903af57 ("mmc: core: Fixup support for writeback-cache for eMMC and SD").
>>>>
>>>> File systems can use FUA to mark a successful journal flush.  Whether or not getting a torn sector at that point will corrupt the file system recovery is presumably file system specific, and maybe specific to file system options e.g. the use of checksums.
>>>>
>>>> It may well be that a file system can survive a torn sector at that point, or that user space would prefer to take the risk in order to get better performance.  In either of those cases, it is not really a decision for the host controller driver.
>>>>
>>>
>>> Considering the data integrity, we did a random power-down test, and
>>> the experimental results were good.
>>>
>>> FUA can only reduce data loss under abnormal conditions, but cannot
>>> prevent data loss under abnormal conditions.
>>>
>>> I think there should be a balance between FUA and NO FUA, but
>>> filesystems seem to favor FUA.
>>>
>>> FUA brings a drop in random write performance. If enough tests are
>>> done, NO FUA is acceptable.
>>>
>>> I found a discussion about FUA:
>>> https://lore.kernel.org/linux-f2fs-devel/20220528051238.GX1098723@dread.disaster.area/
>>>
>>> UFS reference:
>>> https://lore.kernel.org/linux-scsi/20220531201053.3300018-1-jaegeuk@kernel.org/
>>>
>>
>> You really need buy-in from more people, especially file system
>> developers.  I suggest you try F2FS people to start with.
>> Please be clear though: Reliable Write protects against torn
>> writes.  If enough stakeholders agree that file systems can
>> handle the torn writes anyway, then we could presumably drop
>> using Reliable Write for FUA.
>>
>>>>>
>>>>> Wenchao Chen (2):
>>>>>   mmc: block: Support Host to control FUA
>>>>>   mmc: sdhci-sprd: enable fua_disable for SPRDSDHCI
>>>>>
>>>>>  drivers/mmc/core/block.c      | 3 ++-
>>>>>  drivers/mmc/host/sdhci-sprd.c | 2 ++
>>>>>  include/linux/mmc/host.h      | 3 +++
>>>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>

