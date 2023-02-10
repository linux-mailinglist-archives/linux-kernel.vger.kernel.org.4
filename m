Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED39691694
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBJCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJCP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:15:58 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154C6E88B;
        Thu,  9 Feb 2023 18:15:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCclr1rVmz4f3lK8;
        Fri, 10 Feb 2023 10:15:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R_XqOVjXpooDA--.2711S3;
        Fri, 10 Feb 2023 10:15:53 +0800 (CST)
Subject: Re: [PATCHSET v3 block/for-next] blkcg: Improve blkg config helpers
 and make iolatency init lazy
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk, josef@toxicpanda.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230110222714.552241-1-tj@kernel.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <58a4bf92-2830-1ff0-c7b1-ea9b349105df@huaweicloud.com>
Date:   Fri, 10 Feb 2023 10:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230110222714.552241-1-tj@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R_XqOVjXpooDA--.2711S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfWF1ftr1UZFy7ZF4UXFb_yoW8CryDpr
        yfKF43uw18KrZFqa1fKw4fCF1rtw40vry5GrnIyr1rAryY9FyjvF4vvFWFyFW0qrZFkF40
        qr15Jryjgw1Uu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/01/11 6:27, Tejun Heo Ð´µÀ:
> Hello,
> 
> * v2[2] fixes the build failure caused by v1[1] forgetting to update bfq.
> 
> * v3 drops __acuquires/__releases() changes and updates patch descriptions.
> 
> This patchset:
> 
> * Improves blkg config helpers so that they can be used consistently for all
>    the existing use cases. This also allows keeps using the same bdev open
>    instance across lazy init of rq_qos policies.
> 
> * Updates iolatency so that it initializes lazily when a latency target is
>    set for the first time. This avoids registering the rq_qos policy when
>    iolatency is not used which removes unnecessary calls into iolat from IO
>    hot paths.
> 

There are some rq_qos and iocost bugfix based on this patchset, can
anyone help to review this patchset?

Thanks,
Kuai

> and contains the following four patches:
> 
>   0001-blkcg-Drop-unnecessary-RCU-read-un-locks-from-blkg_c.patch
>   0002-blkcg-Restructure-blkg_conf_prep-and-friends.patch
>   0003-blk-iolatency-s-blkcg_rq_qos-iolat_rq_qos.patch
>   0004-blk-iolatency-Make-initialization-lazy.patch
> 
> and is also available in the following git branch.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git iolat-lazy-init-v2
> 
> diffstat follows. Thanks.
> 
>   block/bfq-cgroup.c    |    8 ++-
>   block/blk-cgroup.c    |  122 ++++++++++++++++++++++++++++----------------------
>   block/blk-cgroup.h    |   10 ++--
>   block/blk-iocost.c    |   58 +++++++++++++----------
>   block/blk-iolatency.c |   39 +++++++++++++--
>   block/blk-rq-qos.h    |    2
>   block/blk-throttle.c  |   16 ++++--
>   block/blk.h           |    6 --
>   8 files changed, 159 insertions(+), 102 deletions(-)
> 
> [1] https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org
> [2] https://lkml.kernel.org/r/20230105212432.289569-1-tj@kernel.org
> 
> --
> tejun
> 
> .
> 

