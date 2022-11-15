Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E6629382
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiKOIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiKOIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:44:11 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78645F27
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:44:09 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxfbZXUXNj2zIHAA--.9839S3;
        Tue, 15 Nov 2022 16:44:07 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOJVUXNjo28TAA--.51662S3;
        Tue, 15 Nov 2022 16:44:06 +0800 (CST)
Subject: Re: [PATCH v2 0/5] Add kprobe and kretprobe support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H47oPC6mYkeDh7NfmvL2jAHO32ugM-PK2mmFY6XdqF8_Q@mail.gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1af099bf-123e-06bb-cd9a-5fd939f9cb79@loongson.cn>
Date:   Tue, 15 Nov 2022 16:44:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H47oPC6mYkeDh7NfmvL2jAHO32ugM-PK2mmFY6XdqF8_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxoOJVUXNjo28TAA--.51662S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW5Kw4DWw48XFyUXw4fXw15CFg_yoWxXrcEgw
        1kGF9rGa1jqws8K3Z0yr43XrsrGa9rA3W5Jrn5Kw13X3ZYqa1DGrs3Kr93ZF13Jan5Jws5
        ZFWFqrn8AwsrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        I7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzQ6pUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2022 12:31 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> Thanks for your patches, however,
> 1, You should rebase your code, since some functions such as
> is_pc_insn is provided in the github's loongarch-next branch;
> 2, Your code may have some problems about preemption, you can do
> something like this commit [1];
> 3, I don't think Kprobe should be enabled by default, distribution
> configs can enable it if needed.
>
> [1] https://github.com/loongson/linux/commit/023d5412ab5c154b87d57d70d465a4243df53717
>

OK, thank you, I will rebase and address the review comments,
and then send v3 later.

Thanks,
Tiezhu

