Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0772D99D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbjFMGCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjFMGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:02:29 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE779188;
        Mon, 12 Jun 2023 23:02:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl0oXcB_1686636140;
Received: from 30.221.148.254(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl0oXcB_1686636140)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 14:02:21 +0800
Message-ID: <b89351eb-e450-61b9-53b6-02fe68319174@linux.alibaba.com>
Date:   Tue, 13 Jun 2023 14:02:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2] block: fine-granular CAP_SYS_ADMIN for Persistent
 Reservation ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
References: <20230612074103.4866-1-jefflexu@linux.alibaba.com>
 <20230613050259.GA13751@lst.de>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230613050259.GA13751@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 1:02 PM, Christoph Hellwig wrote:
>> +static bool blkdev_pr_allowed(struct block_device *bdev, fmode_t mode)
> 
> With my resent series the use of fmode_t in the block layer has been
> replaced with a new blk_mode_t, so you'll need to rebase.

Okay I will rebase on that in the next version.

> 
>> +{
>> +	if (capable(CAP_SYS_ADMIN))
>> +		return true;
>> +
>> +	/* no sense to make reservations for partitions */
>> +	if (bdev_is_partition(bdev))
>> +		return false;
> 
> I think we should disallow the PR ioctls for partitions entirely.
> Yes, that's a change of behavior (and should be a separate patch),
> but this is the right time to fix it.

Okay I will make it into a separate patch later.


> Otherwise this change log good, thanks a lot!

Thanks for the comment and suggestions!


-- 
Thanks,
Jingbo
