Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC146D14AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCaBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCaBI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:08:26 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB8CA31;
        Thu, 30 Mar 2023 18:08:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PnhxH2qWdz4f3mHs;
        Fri, 31 Mar 2023 09:08:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGDMiZk3OR6Fw--.5152S3;
        Fri, 31 Mar 2023 09:08:21 +0800 (CST)
Subject: Re: [PATCH v3 3/3] md: protect md_thread with rcu
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230330202046.795213-1-yukuai1@huaweicloud.com>
 <20230330202046.795213-4-yukuai1@huaweicloud.com>
 <67b0f0fb-e9f3-b716-f22f-0ca091a291b0@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7efda5d2-96bf-05a4-418d-122bfdf2ce04@huaweicloud.com>
Date:   Fri, 31 Mar 2023 09:08:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <67b0f0fb-e9f3-b716-f22f-0ca091a291b0@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGDMiZk3OR6Fw--.5152S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWkur43ArWkuw4rJFWUJwb_yoWDZrbE9r
        yvqr4kGrnxWrn3JF129r47XrZxJFW3ZryxZr48KFW7tF1FgFy5WrnxXr4Sv34fZ3y8KF9Y
        y3s8trWSgrn0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Logan!

在 2023/03/31 3:35, Logan Gunthorpe 写道:
> 
> A couple points:
> 
> I don't think we need a double pointer here. rcu_dereference() doesn't
> actually do anything but annotate the fact that we are accessing a
> pointer protected by rcu. It does require annotations on that pointer
> (__rcu) which is checked by sparse (I suspect this patch will produce a
> lot of sparse errors from kbuild bot).
> 
> I think all we need is:
> 
> void md_wakeup_thread(struct md_thread __rcu *rthread)
> {
> 	struct md_thread *thread;
>     	
> 	rcu_read_lock();
> 	thread = rcu_dereference(rthread);
> 	...
> 	rcu_read_unlock();
> 	
> }
> 
> The __rcu annotation will have to be added to all the pointers this
> function is called on as well as to md_register_thread() and
> md_unregister_thread(). And anything else that uses those pointers.
> Running sparse on the code and eliminating all new errors for the patch
> is important.

Yes, you're right, I'll remove patch 2 and update patch 3. And I'll try
to run sparse before sending the new version.

Thanks,
Kuai

