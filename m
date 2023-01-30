Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79168040D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjA3DHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjA3DHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:07:19 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997F20D0A;
        Sun, 29 Jan 2023 19:07:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P4tQ35YVQz4f3lK6;
        Mon, 30 Jan 2023 11:07:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyFcNNdjqrGyCQ--.298S3;
        Mon, 30 Jan 2023 11:07:09 +0800 (CST)
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
To:     jejb@linux.ibm.com, Zhong Jinghua <zhongjinghua@huawei.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org, emilne@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
 <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
Date:   Mon, 30 Jan 2023 11:07:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyFcNNdjqrGyCQ--.298S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47AFW5ur1fCr1UAF1kXwb_yoW8JFWDpF
        WfK390kr48G3Z8A3Z5Z3yrA34Fv390yrW5Jr1rX34xGry5JF93trW5X3WY9Fyjgr9rK3WY
        gF4UK3yDKw1DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/01/30 1:30, James Bottomley 写道:
> On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
>> This error will cause a warning:
>> kobject_add_internal failed for block (error: -2 parent: 1:0:0:1).
>> In the lower version (such as 5.10), there is no corresponding error
>> handling, continuing
>> to go down will trigger a kernel panic, so cc stable.
> 
> Is this is important point and what you're saying is that this only
> panics on kernels before 5.10 or so because after that it's correctly
> failed by block device error handling so there's nothing to fix in
> later kernels?
> 
> In that case, isn't the correct fix to look at backporting the block
> device error handling:

This is the last commit that support error handling, and there are many
relied patches, and there are lots of refactor in block layer. It's not
a good idea to backport error handling to lower version.

Althrough error handling can prevent kernel crash in this case, I still
think it make sense to make sure kobject is deleted in order, parent
should not be deleted before child.

Thanks,
Kuai
> 
> commit 83cbce9574462c6b4eed6797bdaf18fae6859ab3
> Author: Luis Chamberlain <mcgrof@kernel.org>
> Date:   Wed Aug 18 16:45:40 2021 +0200
> 
>      block: add error handling for device_add_disk / add_disk
> 
> ?
> 
> James
> 
> .
> 

