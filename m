Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EFE74A86A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGGBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:24:09 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E2113;
        Thu,  6 Jul 2023 18:24:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QxwfB2CCSz4f3mJ6;
        Fri,  7 Jul 2023 09:24:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Izaadk_kKHNQ--.12047S3;
        Fri, 07 Jul 2023 09:24:04 +0800 (CST)
Subject: Re: [PATCH -next v2 0/2] md/raid5-cache: fix a deadlock in
 r5l_exit_log()
To:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com,
        logang@deltatee.com, hch@lst.de, song@kernel.org, shli@fb.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawwe.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230628010756.70649-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4c4b000b-d4c7-ff16-a04c-50b8b8d39507@huaweicloud.com>
Date:   Fri, 7 Jul 2023 09:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230628010756.70649-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Izaadk_kKHNQ--.12047S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxGw1ftrWUAw1xtF17Awb_yoWktrbEgF
        W7WF98Kw4xAasIkasYkr1xKrZ7Kr4UAFW8JFy8tF429ry3ZryF9r48WrWrWa98WFWkuF1r
        CrW8ZFW8trsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

�� 2023/06/28 9:07, Yu Kuai д��:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>   - remove a now unused local variable in patch 2;
> 
> Commit b13015af94cf ("md/raid5-cache: Clear conf->log after finishing
> work") introduce a new problem:
> 
> // caller hold reconfig_mutex
> r5l_exit_log
>   flush_work(&log->disable_writeback_work)
> 			r5c_disable_writeback_async
> 			 wait_event
> 			  /*
> 			   * conf->log is not NULL, and mddev_trylock()
> 			   * will fail, wait_event() can never pass.
> 			   */
>   conf->log = NULL
> 
> patch 1 revert this patch, an patch 2 fix the original problem in a
> different way.
> 
> Noted this problem is just found by code review, and I think this is
> probably the reason that some mdadm tests is broken.

Any suggestions?

By the way, while taking another look at this problem, I think probably
read and write 'conf->log' should use READ_ONCE and WRITE_ONCE.

Thanks,
Kuai
> 
> Yu Kuai (2):
>    md/raid5-cache: Revert "md/raid5-cache: Clear conf->log after
>      finishing work"
>    md/raid5-cache: fix null-ptr-deref in r5l_reclaim_thread()
> 
>   drivers/md/raid5-cache.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 

