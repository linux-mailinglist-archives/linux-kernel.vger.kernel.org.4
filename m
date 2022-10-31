Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B631612E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJaBIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJaBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:08:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC4BE1C;
        Sun, 30 Oct 2022 18:08:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N0w2M3tCTzl9Ch;
        Mon, 31 Oct 2022 09:06:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHluj7H19jjwbcAQ--.21030S3;
        Mon, 31 Oct 2022 09:08:13 +0800 (CST)
Subject: Re: [PATCH -nect RFC v2 0/2] block: fix uaf in bd_link_disk_holder()
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, willy@infradead.org, kch@nvidia.com,
        martin.petersen@oracle.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221020132049.3947415-1-yukuai3@huawei.com>
 <20221020164712.GA14773@lst.de>
 <0ad09045-1012-e86b-41f2-a88d02e8f1ed@huaweicloud.com>
 <20221030153040.GB9676@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bdaec1ab-db1a-59d6-895e-1ac652a68950@huaweicloud.com>
Date:   Mon, 31 Oct 2022 09:08:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221030153040.GB9676@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHluj7H19jjwbcAQ--.21030S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy3XryDuFy8WrWDAw1DWrg_yoWDCrb_uF
        W8Cr1kCr4IkwnYgwsFkr15Zr93Kr1kZ3s3XFZ7tan7W3W2qF47GF45Gr1fZ3s7Wa1rKrn8
        KFy29a13ur9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph

在 2022/10/30 23:30, Christoph Hellwig 写道:
> On Fri, Oct 21, 2022 at 11:15:34AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2022/10/21 0:47, Christoph Hellwig 写道:
>>> As mentioned before I don't think we should make this even more
>>> crufty in the block layer.  See the series I just sent to move it int
>>> dm.
>>
>> It seems we had some misunderstanding, the problem I tried to fix here
>> should not just related to dm, but all the caller of
>> bd_link_disk_holder().
> 
> As far as I can tell the problem was just that patch 1 in my series blows
> away the bd_holder_dir pointer in part0 on del_gendisk.  Each holder
> actually holds a reference to the kobject, so the memory for it is
> still valid, it's just that the pointer got cleared.  I'll send a v2
> in a bit.

This is not the real case. In bd_link_disk_hoder(), bd_hodler_dir is
accessed first by add_symlink(), and then reference is grabed later.
The reference should be grabed before bd_holder_dir is accessed, like
what I try to do in patch 2.

Thanks,
Kuai
> 
> .
> 

