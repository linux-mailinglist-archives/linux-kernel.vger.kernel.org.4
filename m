Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0624705061
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjEPOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjEPOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:18:36 -0400
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 07:18:14 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB6E7A92
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=mckk/1eSa92UDNT9PM1pbNYpthKB9JMGKfwOo4DD6nA=;
        b=UVuTAVN8EAlFqT7Bsk6o0klJkk5GSdb8SseTtPe8g5EmM9GqqjePTszp8Mc4D7
        y29fIxvBC96iSThlG2MzwysikA9BzPhvWEnnGHnWwDZvLoCspWpCHXc2kTrgHJ9H
        nBvfMgXptKKmxKmMal7iBuwPeNYW6nufre0YQbboGvuzo=
Received: from [10.0.2.15] (unknown [120.244.62.38])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDn7AQhjGNke7aJAw--.14124S2;
        Tue, 16 May 2023 21:58:58 +0800 (CST)
Message-ID: <1d32a220-d941-6e67-58db-3e949d599812@126.com>
Date:   Tue, 16 May 2023 21:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
        sunjw10@lenovo.com
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZGKY1A1q5Px64v9h@kbusch-mbp>
From:   Jiwei Sun <jiweisun126@126.com>
In-Reply-To: <ZGKY1A1q5Px64v9h@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn7AQhjGNke7aJAw--.14124S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDAryxuryrJw1rWFyrtFb_yoW8CFy3pF
        Z7Jr9IkF1qvryftrZ7Cw4FgF1DZw4kKw43Grn7GryxAw1rW3sIqr4I9ws5uFyjvrZagryv
        yw1jq3s3Zr1DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWc_fUUUUU=
X-Originating-IP: [120.244.62.38]
X-CM-SenderInfo: 5mlzvxpvxqijaw6rjloofrz/1tbijh1xjVpEI4KeTAAAsC
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

On 2023/5/16 04:40, Keith Busch wrote:
> On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> A soft lockup issue will be triggered when do fio test on a 448-core
>> server, such as the following warning:
> ...
>
>> According to the above two logs, we can know the nvme_irq() cost too much
>> time, in the above case, about 4.8 second. And we can also know that the
>> main bottlenecks is in the competition for the spin lock pool->lock.
> The most recent 6.4-rc has included a significant changeset to the pool
> allocator that may show a considerable difference in pool->lock timing.
> It would be interesting to hear if it changes your observation with your
> 448-core setup. Would you be able to re-run your experiements that
> produced the soft lockup with this kernel on that machine?
We have done some testes with the latest kernel, the issue can not be 
reproduced,
and we have analyzed the ftrace log of nvme_irq, we did NOT find any 
competition for
the spin lock pool->lock, and all the dma_pool_free function completed 
within 2us.

  287)               |        dma_pool_free() {
  287)   0.150 us    |          _raw_spin_lock_irqsave();
  287)   0.421 us    |          _raw_spin_unlock_irqrestore();
  287)   1.472 us    |        }
+-- 63 lines: 287)               |        mempool_free() {-----------
  435)               |        dma_pool_free() {
  435)   0.170 us    |          _raw_spin_lock_irqsave();
  435)   0.210 us    |          _raw_spin_unlock_irqrestore();
  435)   1.172 us    |        }
+--145 lines: 435)               |        mempool_free() {---------
  317)               |        dma_pool_free() {
  317)   0.160 us    |          _raw_spin_lock_irqsave();
  317)   0.401 us    |          _raw_spin_unlock_irqrestore();
  317)   1.252 us    |        }

Based on the test results and analysis of the code principles, your 
patch has fixed this performance issue.

By the way, another task hung issue was triggered in the test. We are 
analyzing it, but this is another story,
we can discuss it in other thread.

Thanks,
Regards,
Jiwei

