Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B737445E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGABk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:40:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF73C3F;
        Fri, 30 Jun 2023 18:40:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QtFHm56mzz4f41xD;
        Sat,  1 Jul 2023 09:40:20 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLADhJ9kqHixMw--.61619S3;
        Sat, 01 Jul 2023 09:40:21 +0800 (CST)
Message-ID: <0af5c40f-ccc5-0d4c-3371-6473da9083b7@huaweicloud.com>
Date:   Sat, 1 Jul 2023 09:40:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] md/raid10: factor out get_rdev_repl_from_mirror()
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230628015752.102267-1-linan666@huaweicloud.com>
 <20230628015752.102267-3-linan666@huaweicloud.com>
 <CAPhsuW7ySGEQtSHg0jxvRRDQWumF7DsVF8fro6MYCc_bY6Ssew@mail.gmail.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW7ySGEQtSHg0jxvRRDQWumF7DsVF8fro6MYCc_bY6Ssew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLADhJ9kqHixMw--.61619S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtryxKw4kWw1DAF4rZF15XFb_yoWDtrX_uw
        4qyw1UGF15tr1kAr15Gr1YyFZxJFZxGaykZrZayrWfK3s7WFWj9ryrGryxA343C3yxXr9a
        kF1kGryYyrZ3ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
        M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
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



在 2023/7/1 7:53, Song Liu 写道:
> On Tue, Jun 27, 2023 at 6:58 PM <linan666@huaweicloud.com> wrote:
>>
> [...]
> 
>>
>> +static void get_rdev_repl_from_mirror(struct raid10_info *mirror,
>> +                                struct md_rdev **prdev,
>> +                                struct md_rdev **prrdev)
>> +{
>> +       struct md_rdev *rdev, *rrdev;
>> +
>> +       rrdev = rcu_dereference(mirror->replacement);
>> +       /*
>> +        * Read replacement first to prevent reading both rdev and
>> +        * replacement as NULL during replacement replace rdev.
>> +        */
>> +       smp_mb();
>> +       rdev = rcu_dereference(mirror->rdev);
>> +       if (rdev == rrdev)
>> +               rrdev = NULL;
>> +
>> +       *prrdev = rrdev;
>> +       *prdev = rdev;
> 
> I don't think the reduction in duplicated code justifies two output arguments.
> 
> How about
> 
> static struct md_rdev *dereference_rdev_and_rrdev(struct raid10_info *mirror,
>                                 struct md_rdev **prrdev)
> {
>      ...
>      *prrdev = xxx;
>      return rdev;
> }
> 
> So we only have one argument for output.
> 
> Also, "from_mirror" in the function name doesn't really add more value.
> 
> Thanks,
> Song
> .

I agree. Let me improve this.

-- 
Thanks,
Nan

