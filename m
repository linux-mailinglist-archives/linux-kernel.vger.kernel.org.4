Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71465B943
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjACCMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACCMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:12:38 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2EE57;
        Mon,  2 Jan 2023 18:12:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NmGTW6Ft5z4f3pFc;
        Tue,  3 Jan 2023 10:12:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgBH8yABj7NjwAamAw--.61673S2;
        Tue, 03 Jan 2023 10:12:34 +0800 (CST)
Subject: Re: [PATCH RESEND v2 5/5] sbitmap: correct wake_batch recalculation
 to avoid potential IO hung
To:     Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org,
        Laibin Qiu <qiulaibin@huawei.com>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-6-shikemeng@huaweicloud.com>
 <20221222134146.khucy5afnxwl75px@quack3>
 <d00297d7-a77a-770a-1cd7-1632f8ae77e0@huaweicloud.com>
 <3662b1aa-546b-e4e0-3705-0bc5626067f6@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f8df9153-eeff-f3ca-c4c2-2be0cf876298@huaweicloud.com>
Date:   Tue, 3 Jan 2023 10:12:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3662b1aa-546b-e4e0-3705-0bc5626067f6@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH8yABj7NjwAamAw--.61673S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
        6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
        CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
        xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

on 12/26/2022 4:57 PM, Yu Kuai wrote:
> �� 2022/12/26 15:50, Yu Kuai д��:
> 
>>> why using
>>> wake batch of 4 is safe for cards with say 32 tags in case active_users is
>>> currently 32. Because I don't see why that is correct either.
>>>
> 
> I see, you guys are worried that during the period that some hctx
> complete all it's not idle yet. It's right waiter might wait for
> other hctx to become idle to be awaken in this case. However, I'm
> not sure which way is better.
> 
> Ming, do you have any idea?
> 
> Thanks,
> Kuai
> 

-- 
Best wishes
Kemeng Shi

