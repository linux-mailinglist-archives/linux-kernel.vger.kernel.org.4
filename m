Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019F603866
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJSDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJSDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:07:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66B844C3;
        Tue, 18 Oct 2022 20:07:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MsbDn3Mznz6PDfR;
        Wed, 19 Oct 2022 11:04:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3nP_SaU9jZSxUAA--.3335S3;
        Wed, 19 Oct 2022 11:07:00 +0800 (CST)
To:     axboe@kernel.dk, linux-block <linux-block@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, jack@suse.cz, hch@infradead.org,
        Ming Lei <ming.lei@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Subject: [QUESTION] kernel can be silence when io hang
Message-ID: <034239b5-0d46-51b1-c189-a09f1700083d@huaweicloud.com>
Date:   Wed, 19 Oct 2022 11:06:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3nP_SaU9jZSxUAA--.3335S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy7Cr1xWryxXw1xtry8AFb_yoW8JFyDpF
        43Kw12krs5Gr1xua18Xa13Wa47Aws8Ar4a934kJw13ZFs8ZFn7JrySvrWa9F17Xr1DWFZ2
        vF10vrWv93WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, block experts！

In order to prevent false positive hung task warnings for slow io,
following commits forbit hung task checking for io:

1) 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b1977698ceb
2) 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de6a78b601c5
3) 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6249cdd46e4

However, if io really hangs, they also forbit the hung task warnings
that will be helpful.

I'm thinking about when hang task should be detected:

1) If io is still in block layer，there are many places that io can be
stalled: blk throttle, get tag, rq_qos_throttle, plug, elevator, hctx. I
think hang task should be detected at least for the case that there is
no io in driver.

2) If io is issued to driver
​   a. For the driver that timeout handling is implemented, there is no
need to detect hung task.
​   b. For the driver that timeout handling is not implemented
(virtio,virtio_scsi)，there is a real timeout handling in physical
device. So hung task should be detected before the io is issued to lower
device.

Does anyone thinks these thoughts meaningful? Comments and suggestions
are welcomed.

Thanks,

Kuai

