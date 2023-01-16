Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405366B584
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjAPCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAPCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:15:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DB527A;
        Sun, 15 Jan 2023 18:15:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwFwW61xZz4f3v5b;
        Mon, 16 Jan 2023 10:15:07 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBXxS8ss8RjAsTDBg--.33134S2;
        Mon, 16 Jan 2023 10:15:10 +0800 (CST)
Subject: Re: [PATCH RESEND v2 5/5] sbitmap: correct wake_batch recalculation
 to avoid potential IO hung
From:   Kemeng Shi <shikemeng@huaweicloud.com>
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
 <f8df9153-eeff-f3ca-c4c2-2be0cf876298@huaweicloud.com>
Message-ID: <16d02f7b-8e0e-097c-63bc-ef83eb9cb05b@huaweicloud.com>
Date:   Mon, 16 Jan 2023 10:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f8df9153-eeff-f3ca-c4c2-2be0cf876298@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXxS8ss8RjAsTDBg--.33134S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF13ZFWfGF48ur18JF4Utwb_yoW3twb_Xr
        4v93Z7C39xGa1xKw1kKr4YqFZIga4DWFy8ArZ5Xr1Fq395t3yfAr4DtrZ5XayDtw4rJFnI
        qry3uasrXw4UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 1/3/2023 10:12 AM, Kemeng Shi wrote:
> Friendly ping...
> 
> on 12/26/2022 4:57 PM, Yu Kuai wrote:
>> ÔÚ 2022/12/26 15:50, Yu Kuai Ð´µÀ:
>>
>>>> why using
>>>> wake batch of 4 is safe for cards with say 32 tags in case active_users is
>>>> currently 32. Because I don't see why that is correct either.
>>>>
>>
>> I see, you guys are worried that during the period that some hctx
>> complete all it's not idle yet. It's right waiter might wait for
>> other hctx to become idle to be awaken in this case. However, I'm
>> not sure which way is better.
>>
>> Ming, do you have any idea?
>>
>> Thanks,
>> Kuai
>>
> 
Hi Jan. The magic batch 4 seems just for performance initially while
lacks of full consideration. And there is no better solution provided
in futher. Do you have any suggestion that I can do to make more
progress.

-- 
Best wishes
Kemeng Shi

