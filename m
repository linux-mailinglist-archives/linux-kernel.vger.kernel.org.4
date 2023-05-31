Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF32717BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjEaJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjEaJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:32:02 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A9BD9;
        Wed, 31 May 2023 02:32:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWPDF5JFZz4f403R;
        Wed, 31 May 2023 17:31:57 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAMFHdk_vNxKg--.6164S3;
        Wed, 31 May 2023 17:31:58 +0800 (CST)
Message-ID: <dab276f1-a186-f26c-ddc9-561ea32d7a07@huaweicloud.com>
Date:   Wed, 31 May 2023 17:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/4] md/raid10: fix incorrect done of recovery
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     bingjingc@synology.com, allenpeng@synology.com, shli@fb.com,
        alexwu@synology.com, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230527072218.2365857-1-linan666@huaweicloud.com>
 <20230527072218.2365857-4-linan666@huaweicloud.com>
 <CAPhsuW7ZeiFNoiY=-EVwj67FhnaW5rphkkumBrSCdtHHgBxzNw@mail.gmail.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW7ZeiFNoiY=-EVwj67FhnaW5rphkkumBrSCdtHHgBxzNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAMFHdk_vNxKg--.6164S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4fKr47uryxCFW8uF45KFg_yoWfAwb_Wa
        yjkF1kGw18Z39rCr4xXr4agrZrWF4jqF18J348Xwn5X34UJay3Zan8Kr95ZF45JrZY9rnx
        tF1FgayxA3929jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/31 5:55, Song Liu 写道:
> On Sat, May 27, 2023 at 12:24 AM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> Recovery will go to giveup and let chunks_skipped++ in
>> raid10_sync_request() if there are some bad_blocks, and it will return
>> max_sector when chunks_skipped >= geo.raid_disks. Now, recovery fail and
>> data is inconsistent but user think recovery is done, it is wrong.
>>
>> Fix it by set mirror's recovery_disabled, spare device will not  be added
>> to here. The same issue alos exists on resync, it will be fixd in future.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
> 
> I applied 1/4 and 2/4 of the set to md-next.
> 
> For 3/4 and 4/4, please improve the commit log (rephrase confusing statements,
> fix typo's, etc.). Please also add a mdadm test for 3/4.
> 
> Thanks,
> Song
> 

I will add a test later. Thanks for review.

-- 
Thanks,
Nan

