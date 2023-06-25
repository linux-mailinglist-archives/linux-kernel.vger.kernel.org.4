Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1385A73CDCB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFYBX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFYBX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:23:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACAE9C;
        Sat, 24 Jun 2023 18:23:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QpYCV3DFbz4f3mWD;
        Sun, 25 Jun 2023 09:23:50 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZQll5dkElXhMQ--.24766S3;
        Sun, 25 Jun 2023 09:23:51 +0800 (CST)
Message-ID: <3f57cd5a-5d7d-a975-f22f-ab5abd4288f0@huaweicloud.com>
Date:   Sun, 25 Jun 2023 09:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] md/raid10: optimize and fix read error
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <2cfb7dd4-ef6e-c460-8132-5c1c49cf6877@molgen.mpg.de>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <2cfb7dd4-ef6e-c460-8132-5c1c49cf6877@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZQll5dkElXhMQ--.24766S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy7Wr47tFWrWry3tr1fJFb_yoW3Arg_G3
        9rtr9Fgr1xXr48Jr43WF1jgF13XF4Yyw15Jw17uwn0yF1rXFn5Grs3Grn5Zrn5Ga95Wr1q
        9rn8Xw43tw4SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07Al
        zVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFf
        HjUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/23 17:52, Paul Menzel 写道:
> Dear Li,
> 
> 
> Thank you for your patches.
> 
> Am 23.06.23 um 19:32 schrieb linan666@huaweicloud.com:
>> From: Li Nan <linan122@huawei.com>
> 
> Just a note, that the date/timestamps of your patches are from the 
> future. (Yu’s patches had the same problem.) Could you please make sure 
> to set up the system time correctly.

System time is correct now. Thanks for your reminding :)

> 
>      Received: from huaweicloud.com (unknown [10.175.104.67])
>              by APP4 (Coremail) with SMTP id 
> gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S4;
>              Fri, 23 Jun 2023 17:34:11 +0800 (CST)
>      […]
>      Date:   Sat, 24 Jun 2023 01:32:33 +0800
> 
> […]
> 
> 
> Kind regards,
> 
> Paul

-- 
Thanks,
Nan

