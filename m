Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C89620E17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiKHLEm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Nov 2022 06:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiKHLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:04:38 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B8312636
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:04:34 -0800 (PST)
Received: from smtpclient.apple (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowABXX4+qN2pj8Y3iCA--.26885S3;
        Tue, 08 Nov 2022 19:04:10 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 0/8] Add OPTPROBES feature on RISCV
From:   Xim <chenguokai17@mails.ucas.ac.cn>
In-Reply-To: <87y1sm1z8j.fsf@all.your.base.are.belong.to.us>
Date:   Tue, 8 Nov 2022 19:04:09 +0800
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, liaochang1@huawei.com,
        Liao Chang <liaoclark@163.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <9A705974-A007-45E2-BC5D-A7E90821A258@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <87y1sm1z8j.fsf@all.your.base.are.belong.to.us>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-CM-TRANSID: qwCowABXX4+qN2pj8Y3iCA--.26885S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7WF1xAF4DWw48urW3Wrg_yoW8Cryfpa
        yIkws8Ka1vyasFg3WqvF4xX3WS9r4jqrWUZFnrGw15Gw15XF9avw4Sg3y5uFn8KrWFyr4I
        vFyjyw1kZ3s7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
        cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx
        0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
        I402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxU4nmiDUUUU
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwIEE2Np+0jc0gAAsl
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

Thanks for your great review! Some explanations below.

> 2022年11月8日 00:54，Björn Töpel <bjorn@kernel.org> 写道：
> 
> Have you run the series on real hardware, or just qemu?

Currently only qemu tests are made, I will try to test it on a FPGA real hardware soon.

> AFAIU, the algorithm only tracks registers that are *in use*. You are
> already scanning the whole function (next patch). What about the caller
> saved registers that are *not* used by the function in the probe range?
> Can those, potentially unused, regs be used?

Great missing part! I have made a static analyzation right upon receiving this mail.
The result shows that this newly purposed idea reaches about the same
success rate on my test set (rv64 defconf with RVI only) while when combined,
they can reach a higher success rate, 1/3 above their baseline. A patch that
includes this strategy will be sent soon.
> 
>> +static void arch_find_register(unsigned long start, unsigned long end,
> 
> Nit; When I see "arch_" I think it's functionality that can be
> overridden per-arch. This is not the case, but just a helper for RV.

It can be explained from two aspects. First, it can be extended to most RISC
archs, which can be extracted into the common flow of Kprobe. Second, it is indeed
a internal helper for now, so I will correct the name in the next version.

>> static void find_free_registers(struct kprobe *kp, struct optimized_kprobe *op,
>> -				int *rd1, int *rd2)
>> +				int *rd, int *ra)
> 
> Nit; Please get rid of this code churn, just name the parameters
> correctly on introduction in the previous patch.

Will be fixed.

>> +	*rd = ((kw | ow) == 1UL) ? 0 : __builtin_ctzl((kw | ow) & ~1UL);
>> +	*ra = (kw == 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
> 
> Hmm, __builtin_ctzl is undefined for 0, right? Can that be triggered
> here?

Will be fixed.

Regards,
Guokai Chen
