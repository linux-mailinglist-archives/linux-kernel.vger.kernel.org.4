Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6484964E737
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiLPGLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLPGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:11:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2189217594
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:11:04 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxdPD3C5xjCQkGAA--.14137S3;
        Fri, 16 Dec 2022 14:11:03 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+T3C5xjiTkBAA--.5397S3;
        Fri, 16 Dec 2022 14:11:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Correct the definition of is_branch_ins()
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <1671006659-23859-1-git-send-email-yangtiezhu@loongson.cn>
 <e89c80c7-53e5-5fec-d66b-4b375aa85d10@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e65ce2d5-a154-6912-ab01-b0dc158acaaa@loongson.cn>
Date:   Fri, 16 Dec 2022 14:11:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e89c80c7-53e5-5fec-d66b-4b375aa85d10@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxf+T3C5xjiTkBAA--.5397S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Wr15urW7Xw4UZr4xWF4fAFb_yoWkZwc_ua
        47Ww48Cw4rJ39rA3WkKw1ftrWUGa18Jan5Ary8tFW7GFn8tw1DA3yUtwnxZwn8Kw4kArs8
        uF95tr1rCr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        x7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2022 11:18 AM, Jinyang He wrote:
> Hi, Tiezhu,
>
>
> On 2022-12-14 16:30, Tiezhu Yang wrote:
>> The current definition of is_branch_ins() is not correct,
>
> But the branch instruction opcode only use the high 6 bits,

Yes, I noticed that, the logic result of current code is right,
but it seems a little strange (only consider reg1i21_format)
at the first glance, the initial aim of this patch is to make
it theoretically correct, maybe it is not the best change.

I think we can neglect the instruction formats and check the
high 6 bits instead, what do you think of the following change?

diff --git a/arch/loongarch/include/asm/inst.h 
b/arch/loongarch/include/asm/inst.h
index c00e151..fd31752 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -329,8 +329,8 @@ static inline bool is_pc_ins(union 
loongarch_instruction *ip)

  static inline bool is_branch_ins(union loongarch_instruction *ip)
  {
-       return ip->reg1i21_format.opcode >= beqz_op &&
-               ip->reg1i21_format.opcode <= bgeu_op;
+       return ((ip->word >> 26) & 0x3f) >= beqz_op &&
+               ((ip->word >> 26) & 0x3f) <= bgeu_op;
  }

Thanks,
Tiezhu



