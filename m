Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF15BBEE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIRQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIRQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 12:10:24 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022E1180F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:10:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQ2jLUb_1663517416;
Received: from 30.39.108.176(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ2jLUb_1663517416)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 00:10:17 +0800
Message-ID: <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Date:   Mon, 19 Sep 2022 00:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To:     Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/18 00:50, Jens Axboe wrote:
> On 9/17/22 10:40 AM, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
>> so when "nr_ctx" is equal to 1, there is no possibility of remote
>> request, so the corresponding process can be simplified.
> If the worry is the call overhead of blk_mq_complete_request_remote(),
> why don't we just make that available as an inline instead? That seems
> vastly superior to providing a random shortcut in a driver to avoid
> calling it.

Hi

This is what I think about it. If it is an SSD with only one hw queue, 
remote requests will
appear occasionally. As a real multi-queue device, nvme usually does not 
have remote
requests, so we don't need to care about it. So even if 
"blk_mq_complete_request_remote"
is called, there is a high probability that it will return false, and 
the cost of changing the call
to "blk_mq_complete_request_remote" to determine whether 
"req->mq_hctx->nr_ctx" is 1 is
not only a function call, but more judgments in 
"blk_mq_complete_request_remote".
If "blk_mq_complete_request_remote" is decorated as inline, it also 
depends on the compiler,
there is uncertainty.


Thanks

