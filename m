Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A76A0FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBWSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBWSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:53:01 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724F10F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:52:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcLG3xX_1677178375;
Received: from 30.25.216.19(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcLG3xX_1677178375)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 02:52:57 +0800
Message-ID: <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
Date:   Fri, 24 Feb 2023 02:52:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/ewpGQkpWvOf7qh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2023/2/24 02:29, Eric Biggers wrote:
> Hi,
> 
> On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
>> From: Sandeep Dhavale <dhavale@google.com>
>>
>> Using per-cpu thread pool we can reduce the scheduling latency compared
>> to workqueue implementation. With this patch scheduling latency and
>> variation is reduced as per-cpu threads are high priority kthread_workers.
>>
>> The results were evaluated on arm64 Android devices running 5.10 kernel.
> 
> I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
> ("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.
> 
> Why is this more complex solution better than simply removing WQ_UNBOUND?

I do think it's a specific issue on specific arm64 hardwares (assuming
qualcomm, I don't know) since WQ_UNBOUND decompression once worked well
on the hardwares I once used (I meant Hisilicon, and most x86_64 CPUs,
I tested at that time) compared with per-cpu workqueue.

Also RT threads are also matchable with softirq approach.  In addition,
many configurations work without dm-verity.

I don't have more time to dig into it for now but it's important to
resolve this problem on some arm64 hardwares first.  Also it's an
optional stuff, if the root cause of workqueue issue can be resolved,
we could consider drop it then.

Thsnka,
Gao Xiang

> 
> - Eric
