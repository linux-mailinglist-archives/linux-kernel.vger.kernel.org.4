Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3573D6669D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjALD6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjALD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:58:33 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF73C0EE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:58:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZPF1qd_1673495907;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZPF1qd_1673495907)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 11:58:28 +0800
Message-ID: <6acd0aea-2e7b-e30e-214f-81f4c3766ead@linux.alibaba.com>
Date:   Thu, 12 Jan 2023 11:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing
 of relinquished volume
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com
References: <20221226103309.953112-2-houtao@huaweicloud.com>
 <20221226103309.953112-1-houtao@huaweicloud.com>
 <2431838.1673453170@warthog.procyon.org.uk>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2431838.1673453170@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 12:06 AM, David Howells wrote:
> Hou Tao <houtao@huaweicloud.com> wrote:
> 
>>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
>> +			/*
>> +			 * Paired with barrier in wait_on_bit(). Check
>> +			 * wake_up_bit() and waitqueue_active() for details.
>> +			 */
>> +			smp_mb__after_atomic();
>>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> 
> What two values are you applying a partial ordering to?

Yeah Hou Tao has explained that a full barrier is needed here to avoid
the potential reordering at the waker side.

As I was also researching on this these days, I'd like to share my
thought on this, hopefully if it could give some insight :)

Without the barrier at the waker side, it may suffer from the following
race:

```
CPU0 - waker                    CPU1 - waiter

if (waitqueue_active(wq_head)) <-- find no wq_entry in wq_head list
    wake_up(wq_head);

                                for (;;) {
                                   prepare_to_wait(...);
                                        # add wq_entry into wq_head list

                                    if (@cond)  <-- @cond is false
                                        break;
                                    schedule(); <-- wq_entry still in
                                                    wq_head list,
                                                    wait for next wakeup
                                 }
                                 finish_wait(&wq_head, &wait);

@cond = true;
```

in which case the waiter misses the wakeup for one time.

-- 
Thanks,
Jingbo
