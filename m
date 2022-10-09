Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688B5F892A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 05:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJIDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 23:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIDe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 23:34:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA462FFF5;
        Sat,  8 Oct 2022 20:34:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MlSK65KPzz6PFm6;
        Sun,  9 Oct 2022 11:32:10 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgAn6ok+QUJj8HL8Bw--.16153S2;
        Sun, 09 Oct 2022 11:34:23 +0800 (CST)
Message-ID: <64aedb51-b0b4-d412-b5ad-67d50f12ad8b@huaweicloud.com>
Date:   Sun, 9 Oct 2022 11:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: bcm: rpi: Fix an out-of-bound access to
 raspberrypi_clk_variants
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xu Kuohai <xukuohai@huawei.com>
References: <20221008144544.283945-1-xukuohai@huaweicloud.com>
 <bce9efac-15a8-75e5-6f3f-bc62e33d0184@i2se.com>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <bce9efac-15a8-75e5-6f3f-bc62e33d0184@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAn6ok+QUJj8HL8Bw--.16153S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUtw18uw13Xw48ur13twb_yoW3KrX_u3
        Z0vFZrWrnrXw15trnrAFnxWr1DXr93AFy5t3yUAr43Crn7Xw1kArykG3WrGFyrGrsrJw1U
        Jr1jka17J3ZIqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/2022 1:07 AM, Stefan Wahren wrote:
> Hi Xu,
> 
> Am 08.10.22 um 16:45 schrieb Xu Kuohai:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> KASAN reports an out-of-bound access to raspberrypi_clk_variants[]:
>>
>> ==================================================================
>> BUG: KASAN: global-out-of-bounds in raspberrypi_clk_probe+0x1dc/0x690
>> Read of size 1 at addr ffffcc7116d615a0 by task kworker/u8:0/8
>>
>> CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 6.0.0-rc3-00900-g08f4df4a3c53 raspberrypi#10
> 
> this kernel is a little bit older and doesn't contain bc163555603e ("clk: bcm: rpi: Prevent out-of-bounds access").
> 
> Can you please check Linux 6.0?
> 

Yes, the kernel branch I used was not updated, and the KASAN warning was gone after switching to 6.0 kernel, thanks.

> Best regards
> 

