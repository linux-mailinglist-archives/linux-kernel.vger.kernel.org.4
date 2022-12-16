Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5363A64E64E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLPDS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPDSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:18:55 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F08BE3D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:18:54 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Dx9vCc45tjawMGAA--.13633S3;
        Fri, 16 Dec 2022 11:18:53 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxg+WY45tjChsBAA--.5803S3;
        Fri, 16 Dec 2022 11:18:50 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Correct the definition of is_branch_ins()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1671006659-23859-1-git-send-email-yangtiezhu@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <e89c80c7-53e5-5fec-d66b-4b375aa85d10@loongson.cn>
Date:   Fri, 16 Dec 2022 11:18:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1671006659-23859-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxg+WY45tjChsBAA--.5803S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CFW8tr1UWr18ZrWxWr15Arb_yoW8CrWkpF
        9xAFs5GF4kKFZakrnxJa18uF1Fvws3Kr4xXF1a9r1rCwnFqw1qyF18Jw1qyF1vkw4xKr1I
        qr4fJ3WjgF47A3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jntxDUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,


On 2022-12-14 16:30, Tiezhu Yang wrote:
> The current definition of is_branch_ins() is not correct,

But the branch instruction opcode only use the high 6 bits, [1]. That's 
meaningless because it is the same as the original result. If we care 
too much about the details of instruction format, we will lose a lot of 
tricks on LoongArch instruction coding.

[1] 
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-of-instruction-encoding


> it was
> first introduced in commit 49aef111e2da ("LoongArch: Add prologue
> unwinder support"), in fact, there exist three branch instruction
> formats rather than only reg1i21_format.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/include/asm/inst.h | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index c00e151..42be39be 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -329,8 +329,31 @@ static inline bool is_pc_ins(union loongarch_instruction *ip)
>   
>   static inline bool is_branch_ins(union loongarch_instruction *ip)
>   {
> -	return ip->reg1i21_format.opcode >= beqz_op &&
> -		ip->reg1i21_format.opcode <= bgeu_op;
> +	switch (ip->reg0i26_format.opcode) {
> +	case b_op:
> +	case bl_op:
> +		return true;
> +	}
> +
> +	switch (ip->reg1i21_format.opcode) {
> +	case beqz_op:
> +	case bnez_op:
> +	case bceqz_op:
> +		return true;
> +	}
> +
> +	switch (ip->reg2i16_format.opcode) {
> +	case jirl_op:
> +	case beq_op:
> +	case bne_op:
> +	case blt_op:
> +	case bge_op:
> +	case bltu_op:
> +	case bgeu_op:
> +		return true;
> +	}
> +
> +	return false;
>   }
>   
>   static inline bool is_ra_save_ins(union loongarch_instruction *ip)

