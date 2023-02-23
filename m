Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30A6A1018
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjBWTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBWTIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:08:19 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10AF2F79F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:08:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VcLDvLr_1677179291;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcLDvLr_1677179291)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 03:08:12 +0800
Message-ID: <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
Date:   Fri, 24 Feb 2023 03:08:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com>
 <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
In-Reply-To: <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/24 02:52, Gao Xiang wrote:
> Hi Eric,
> 
> On 2023/2/24 02:29, Eric Biggers wrote:
>> Hi,
>>
>> On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
>>> From: Sandeep Dhavale <dhavale@google.com>
>>>
>>> Using per-cpu thread pool we can reduce the scheduling latency compared
>>> to workqueue implementation. With this patch scheduling latency and
>>> variation is reduced as per-cpu threads are high priority kthread_workers.
>>>
>>> The results were evaluated on arm64 Android devices running 5.10 kernel.
>>
>> I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
>> ("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.
>>
>> Why is this more complex solution better than simply removing WQ_UNBOUND?
> 
> I do think it's a specific issue on specific arm64 hardwares (assuming
> qualcomm, I don't know) since WQ_UNBOUND decompression once worked well
> on the hardwares I once used (I meant Hisilicon, and most x86_64 CPUs,
> I tested at that time) compared with per-cpu workqueue.
> 
> Also RT threads are also matchable with softirq approach.  In addition,
> many configurations work without dm-verity.

Also for dm-verity use cases, EROFS will reuse the dm-verity context
directly rather than kick off a new context.  Yet I'm not sure there
are still users using EROFS without dm-verity as I said above.

Anyway, the original scheduling issue sounds strange for me (with my
own landing experiences) in the beginning, and I have no way to
confirm the cases.  Just hopefully it could be resolved from the
developer inputs and finally benefit to end users.

I've already did my own stress test with this new configuration as
well without explicit regression.

> 
> I don't have more time to dig into it for now but it's important to
> resolve this problem on some arm64 hardwares first.  Also it's an
> optional stuff, if the root cause of workqueue issue can be resolved,
> we could consider drop it then.
> 
> Thsnka,
> Gao Xiang
> 
>>
>> - Eric
