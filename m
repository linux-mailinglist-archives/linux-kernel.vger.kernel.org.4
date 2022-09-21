Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98E5BFC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIUKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiIUKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:14:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D796515A34
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:14:42 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32sG5Cpj+WYfAA--.45921S3;
        Wed, 21 Sep 2022 18:14:32 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mel Gorman <mgorman@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
 <YyLUGnqtZXn4MjJF@casper.infradead.org>
 <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
 <YyLpls9/t6LKQefS@casper.infradead.org>
 <b52b3f49-ebf5-6f63-da1a-f57711c3f97d@loongson.cn>
 <YyQ2m9vU/plyBNas@casper.infradead.org>
 <4bd0012e-77ff-9d0d-e295-800471994aeb@loongson.cn>
 <c3f4d1bb-418c-fbf5-c251-fd448f4d4e86@loongson.cn>
 <20220921091303.hihmb3qvfvl3s365@techsingularity.net>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <f946fbd8-89f6-67c9-44c1-10ef6e3bdb68@loongson.cn>
Date:   Wed, 21 Sep 2022 18:14:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220921091303.hihmb3qvfvl3s365@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx32sG5Cpj+WYfAA--.45921S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF18AryDAFW5ur15Zw47Arb_yoWfCFg_ZF
        W8Ar4vkw4qqF4qqay3tr42krs7WryvkFy8X3yrXwnF9a4UKa4DXFykt3s3X3Z5tan7t3sx
        CFyYv345Ar9a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8YjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j04E
        _UUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Thanks for your reply.

On 2022/9/21 pm 5:13, Mel Gorman wrote:
> On Tue, Sep 20, 2022 at 10:23:05AM +0800, Hongchen Zhang wrote:
>> Hi Mel,
>>
>> The scan adjust algorithm was originally introduced by you from
>> commmit e82e0561dae9 ("mm: vmscan: obey proportional scanning requirements
>> for kswapd"), any suggestion about this fix patch?
>> In short, proportional scanning is not friendly to processes other than
>> kswapd.
>>
> 
> I suspect that 6eb90d649537 ("mm: vmscan: fix extreme overreclaim and swap
> floods") is a more appropriate fix. While it also has a fairness impact,
> it's a more general approach that is likely more robust and while
> fairness is important, completely thrashing a full LRU is neither fair
> nor expected.
> 
OK,got it. Let's wait for the 6eb90d649537 ("mm: vmscan: fix extreme 
overreclaim and swap floods") enter the stable repository.

Best Regards
Hongchen Zhang

