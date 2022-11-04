Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F026194F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKDK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKDK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:59:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95777B72;
        Fri,  4 Nov 2022 03:59:22 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8Cxq9iJ8GRj4H0EAA--.15023S3;
        Fri, 04 Nov 2022 18:59:21 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+CI8GRjl2kNAA--.38047S3;
        Fri, 04 Nov 2022 18:59:21 +0800 (CST)
Subject: Re: [PATCH] irqchip: loongson-liointc: fix improper error handling in
 liointc_init()
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104080347.21527-1-liupeibao@loongson.cn>
 <539b63ee-7655-50c1-a95f-9f8210e7229d@gmail.com>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <6c14515d-2369-83b5-e20c-0e2a5ba7524c@loongson.cn>
Date:   Fri, 4 Nov 2022 18:59:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <539b63ee-7655-50c1-a95f-9f8210e7229d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxr+CI8GRjl2kNAA--.38047S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAACmNjr2Mb4AAAs8
X-Coremail-Antispam: 1Uk129KBjvdXoW7XF1UXFW3AFWxWFy7Ww1xXwb_yoW3JFbEgF
        92vr93Grn2qr1xJ34DJrWY9w47W347C3Z0krWUW3Z3Zw4Dta43ur17CwnakF18KFZ7Wwn3
        ZFs5uFyxur1IkjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        W7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 5:48 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 11/4/22 11:03 AM, Liu Peibao wrote:
> 
>> For cores less than 4, eg, loongson2k1000 with 2 cores, the
>> of_property_match_string() may return with an error value,
>> which causes that liointc could not work. At least one isr
>> is what should be checked like previous commit <b2c4c3969fd7>
>> (irqchip/loongson-liointc: irqchip add 2.0 version) did.
> 
>    It should look like this:
> 
> commit b2c4c3969fd7 ("irqchip/loongson-liointc: irqchip add 2.0 version")
> 

Thanks, I will update the patch.

BR,
Peibao

>> Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> [...]
> 
> MBR, Sergey
> 

