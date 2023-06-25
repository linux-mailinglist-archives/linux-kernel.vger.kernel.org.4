Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67AF73CEBE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFYGpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:45:11 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63433E4F;
        Sat, 24 Jun 2023 23:45:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QphL35JD5z4f3xbl;
        Sun, 25 Jun 2023 14:44:59 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Jq4pdkr3_yMQ--.45962S3;
        Sun, 25 Jun 2023 14:45:00 +0800 (CST)
Message-ID: <adbdea88-2da6-e3c7-cb86-e75995e550f3@huaweicloud.com>
Date:   Sun, 25 Jun 2023 14:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] md/raid10: optimize fix_read_error
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <20230623173236.2513554-2-linan666@huaweicloud.com>
 <d1778341-549e-6f88-0282-3096bfcd6614@molgen.mpg.de>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <d1778341-549e-6f88-0282-3096bfcd6614@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Jq4pdkr3_yMQ--.45962S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GF45XrWDWr4DGrWfCw15Jwb_yoW8Jr15p3
        ykt3WYy34DGF13Cr1xArs8J34jq3s3KFW7CF10g3WDuw1DK34aqF4Igr15Wr92krn2g347
        Xay5Zws7Zas5KaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xF
        o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        UCXd8UUUUU=
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



在 2023/6/23 18:03, Paul Menzel 写道:
> Dear Li,
> 
> 
> Thank you for your patch.
> 
> Am 23.06.23 um 19:32 schrieb linan666@huaweicloud.com:
>> From: Li Nan <linan122@huawei.com>
>>
>> We dereference r10_bio->read_slot too many times in fix_read_error().
>> Optimize it by using a variable to store read_slot.
> 
> I am always cautious reading about optimizations without any benchmarks 
> or object code analysis. Although your explanation makes sense, did you 
> check, that performance didn’t decrease in some way? (Maybe the compiler 
> even generates the same code.)
> 
> 
> Kind regards,
> 
> Paul
> 
> 

Compared assembly code before and after optimization:
  - With gcc 8.3.0, both are consistent.
  - With gcc 12.2.1, 'r10_bio->read_slot' mostly uses r10bio dirctly:
      2853    while (sl != r10_bio->read_slot) {
        0xffffffff8213f2a0 <+1328>:  cmp    %r14d,0x38(%rbp)

    'slot' is mostly saved to a register individually:
      2819    while (sl != slot) {
        0xffffffff8213f08a <+794>:   cmp    %r14d,%ebx

I have not tested the performance, and it won't bring significant 
performance optimization, which can also be seen from the analysis of 
the assembly code. In fact, I just want to make code more readable.

-- 
Thanks,
Nan

