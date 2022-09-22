Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2855E5C25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIVHRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiIVHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:17:39 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FB9DB5A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:17:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQRfclp_1663831051;
Received: from 30.178.81.15(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQRfclp_1663831051)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 15:17:32 +0800
Message-ID: <94e530a2-7641-f908-ab0f-94d4c7746d7a@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 15:17:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need to
 redirect the completion
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
 <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
 <20220922062010.GA27946@lst.de>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220922062010.GA27946@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/22 14:20, Christoph Hellwig wrote:

> On Wed, Sep 21, 2022 at 11:32:03AM +0800, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> High-performance NVMe devices usually support a large hw queue, which
> a larger number of?
>
>>   	/*
>> -	 * For a polled request, always complete locally, it's pointless
>> -	 * to redirect the completion.
>> +	 * For request which hctx has only one ctx mapping,
>> +	 * or a polled request, always complete locally,
>> +	 * it's pointless to redirect the completion.
>>   	 */
>> -	if (rq->cmd_flags & REQ_POLLED)
>> +	if (rq->mq_hctx->nr_ctx == 1 ||
>> +		rq->cmd_flags & REQ_POLLED)
> Some very odd comment formatting and and indentation here.

Thanks, I will issue a V2 patch as suggested.

