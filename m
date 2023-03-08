Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE596AFBF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCHBPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCHBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:15:46 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14284A6758;
        Tue,  7 Mar 2023 17:15:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWZBN0qMXz4f3nTF;
        Wed,  8 Mar 2023 09:15:40 +0800 (CST)
Received: from [10.174.178.159] (unknown [10.174.178.159])
        by APP4 (Coremail) with SMTP id gCh0CgCH77K84QdkbQXLEw--.14490S3;
        Wed, 08 Mar 2023 09:15:41 +0800 (CST)
Message-ID: <a35b728d-90c8-60dc-04d1-d1762f26b8a2@huaweicloud.com>
Date:   Wed, 8 Mar 2023 09:15:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next v2 Resend] scsi: fix use-after-free problem in
 scsi_remove_target
To:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huaweicloude.com, yi.zhang@huawei.com,
        yukuai3@huawei.com
References: <20230306121636.3183761-1-zhongjinghua@huaweicloud.com>
 <d119fcba-a323-d0cd-0d36-759ad2fb8252@acm.org>
From:   zhongjinghua <zhongjinghua@huaweicloud.com>
In-Reply-To: <d119fcba-a323-d0cd-0d36-759ad2fb8252@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77K84QdkbQXLEw--.14490S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWr48Zr47Cw18WF1rGF15Arb_yoWxXFb_Jr
        48Gr1UuryUX3yDGr4UJr15Xr47Jr4qyryUJr4rArn8G34UXrn5Jr1rJwn5Aw1UGr4UJr15
        JryUt343Jr1UXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for you adevice.

Jinghua

在 2023/3/8 6:35, Bart Van Assche 写道:
> On 3/6/23 04:16, Zhong Jinghua wrote:
>> +            /*
>> +             * If the reference count is already zero, skip this
>> +             * target is safe  because scsi_target_destroy()
>> +             * will wait until the host lock has been released
>> +             * before freeing starget.
>> +             */
>
> The above comment has grammatical issues and is confusing. I think the 
> comment that I suggested was much better than the above.
>
> Bart.
>

