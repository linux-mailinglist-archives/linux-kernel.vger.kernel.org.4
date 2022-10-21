Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A3607B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJUPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJUPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:51:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771817F291;
        Fri, 21 Oct 2022 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666367460; x=1697903460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=arY4EvxAT/KvXp/JPvYXdDFVIm3QFZ803U2WXf8eouw=;
  b=mjoM7Ko25VVgIsTbYKrIF7uepSKa+p3ZXUfJDMPM7/rkdwLSCwuTA5Hm
   Ao6nD3PzFZVtmZzWvqGP5k82bTU1WjlwIkw0fEHB8X5YdsL6twsv4e8BR
   DyKzZxx28DbYqYw7NydP2BEHbYGMSEaSGrBdZJ6a7Fpe/hYxnvJtfAiz2
   1cvMctVsFXNbAhsrf6952PBzBjoS06LmO+I4tWtTz4BHiIgKb1YLd1hsT
   5ctMFfogNp4FzO1LkmMoWIdRW4qdUyNGvB55XY9clqFvndqhiaYsuKw9s
   hMbWlw9gTLWBtSjyACa3BCIkFBni1zsrz+oWIMm1TiEs4/3XNnOuoei/L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393334481"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="393334481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 08:50:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="608425439"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="608425439"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 08:50:49 -0700
Message-ID: <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com>
Date:   Fri, 21 Oct 2022 18:50:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com
Cc:     CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221021073025.18831-1-wenchao.chen666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 10:30, Wenchao Chen wrote:
> From: Wenchao Chen <wenchao.chen@unisoc.com>
> 
> Summary
> =======
> These patches[1] supports the host to turn off FUA.
> 
> About FUA, roughly deal with the following two parts:
> 1) FUA(Forced Unit Access):
> - The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted from the
>   filesystem and will make sure that I/O completion for this request is only
>   signaled after the data has been committed to non-volatile storage.
> 
> 2) In emmc, FUA is represented as Reliable write. code show as below:
> static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> 		int recovery_mode, bool *do_rel_wr_p, bool *do_data_tag_p)
> {
> 	...
> 	/*
> 	 * Reliable writes are used to implement Forced Unit Access and
> 	 * are supported only on MMCs.
> 	 */
> 	do_rel_wr = (req->cmd_flags & REQ_FUA) &&
> 			rq_data_dir(req) == WRITE &&
> 			(md->flags & MMC_BLK_REL_WR);
> 	...
> }
> 
> Patch structure
> ===============
> patch#1:  for block
> patch#2:  for sdhci-sprd
> 
> Tests
> =====
> Ran 'AndroBench' to evaluate the performance:

It would be good to have more details e.g.
What file system? What block size?  What journal size?
What file size? What record size?

> 1. fua_disable = 1
> /sys/block/mmcblk0/queue # cat fua 0
> I tested 5 times for each case and output a average speed.
> 
> 1) Sequential read:
> Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
> Average speed: 265.74MiB/s
> 
> 2) Random read:
> Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
> Average speed: 98.81MiB/s
> 
> 3) Sequential write:
> Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
> Average speed: 200.5MiB/s
> 
> 4) Random write:
> Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
> Average speed: 70.32MiB/s
> 
> 2. fua_disable = 0 (default 0)
> /sys/block/mmcblk0/queue # cat fua 1
> I tested 5 times for each case and output a average speed.
> 	
> 1) Sequential read:
> Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
> Average speed: 257.86MiB/s
> 	
> 2) Random read:
> Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
> Average speed: 100.2MiB/s
> 	
> 3) Sequential write:
> Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
> Average speed: 149.48MiB/s
> 	
> 4) Random write:
> Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
> Average speed: 12.68MiB/s

Is every write being sync'ed of just sync at the end?

> 	
> According to the above data, disable FUA (fua_disable = 1) improves the
> performance:
> 1)Sequential read improved by 3%.
> 2)Random read were down 1%.

FUA should not affect reads.  If it is, you may want to investigate how.

> 3)Sequential write improved by 34%.
> 4)Random write improved by 454%.
> Therefore, it is recommended to support the host to control FUA.
> 	
> Reference
> =========
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/writeback_cache_control.rst
> [2] Embedded Multi-Media Card (e•MMC) Electrical Standard (5.1)''

You do not seem to have considered data integrity.

Regular disks are assumed to provide atomic sector writes.  That is, a sector has either the old data or the new data, but not some corrupt mixture.

mmc does not have that assumption, which is presumably why Reliable Write has been used instead.  Although that idea appears to have been thrown away for devices with no cache by commit 08ebf903af57 ("mmc: core: Fixup support for writeback-cache for eMMC and SD").

File systems can use FUA to mark a successful journal flush.  Whether or not getting a torn sector at that point will corrupt the file system recovery is presumably file system specific, and maybe specific to file system options e.g. the use of checksums.

It may well be that a file system can survive a torn sector at that point, or that user space would prefer to take the risk in order to get better performance.  In either of those cases, it is not really a decision for the host controller driver.

> 
> Wenchao Chen (2):
>   mmc: block: Support Host to control FUA
>   mmc: sdhci-sprd: enable fua_disable for SPRDSDHCI
> 
>  drivers/mmc/core/block.c      | 3 ++-
>  drivers/mmc/host/sdhci-sprd.c | 2 ++
>  include/linux/mmc/host.h      | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 

