Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF46822EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAaDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjAaDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:38:49 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDFB810405;
        Mon, 30 Jan 2023 19:38:45 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxmOlEjdhj+jwKAA--.17447S3;
        Tue, 31 Jan 2023 11:38:44 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxc+VCjdhjlColAA--.39283S3;
        Tue, 31 Jan 2023 11:38:42 +0800 (CST)
Subject: Re: kernel hangs when kprobe memcpy
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
 <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
 <20230112233629.fafdbbe07dddf364f8078df6@kernel.org>
 <d0484b6e-c8a3-65c8-2157-0da95c17b061@loongson.cn>
 <20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org>
 <b20cfc27-0e46-7e3b-e4f1-2e185ea516ab@loongson.cn>
 <20230116154123.a0ff8d6deaff3fe87b48461b@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <357a5386-f588-f3c6-96de-42fcbb36a535@loongson.cn>
Date:   Tue, 31 Jan 2023 11:38:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230116154123.a0ff8d6deaff3fe87b48461b@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bxc+VCjdhjlColAA--.39283S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7XFyrAr48ZrykWw4DGFW5GFg_yoWDXrcEyF
        4UKrykC3yUXr4UAwn7Krn3ZFnxCFWfKFykAw47Xa97twn8Xay0gFsakFn5Xw1kGFs5Jrnr
        ZFsavwnYkr1IvjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        W7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/16/2023 02:41 PM, Masami Hiramatsu (Google) wrote:
> Hi Tiezhu,
>
> On Sat, 14 Jan 2023 14:53:21 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

>>> If you saw that without any change, please report it. At least
>>> memcpy is already marked as noinstr.
>>
>> The current upstream mainline kernel has no problem, because it includes
>> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr"), memcpy is
>> already marked as noinstr. But for the kernel without the above commit,
>> like kernel 5.7, it has problem.
>
> I've confirmed that kernel 5.4.228 (the latest stable tree) did not have
> this issue (it already rejects the memcpy).

I just tested the stable kernel 5.4.230 on x86_64 fedora 36,
without any change, kernel hangs when execute cmd:
modprobe kprobe_example symbol="memcpy"

https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.230.tar.xz

Am I missing something? Since 5.4 is a stable tree, should we do 
something to fix it?

Thanks,
Tiezhu

