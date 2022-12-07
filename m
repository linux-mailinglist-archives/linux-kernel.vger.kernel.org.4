Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7416D64563D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLGJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLGJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:14:47 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B1481A822
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:13:55 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx+OhSWZBj_scDAA--.5516S3;
        Wed, 07 Dec 2022 17:13:54 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1dSWZBj9yUnAA--.12280S3;
        Wed, 07 Dec 2022 17:13:54 +0800 (CST)
Subject: Re: [PATCH v7 1/4] LoongArch: Simulate branch and PC instructions
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1669986505-11322-1-git-send-email-yangtiezhu@loongson.cn>
 <1669986505-11322-2-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7CmTu4uF1F655N2dDcPxPBpYAe93HqQ38U_Lg84HVBAQ@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a3ed9194-ff36-19ff-8cdd-2cfba12c17a9@loongson.cn>
Date:   Wed, 7 Dec 2022 17:13:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7CmTu4uF1F655N2dDcPxPBpYAe93HqQ38U_Lg84HVBAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxR1dSWZBj9yUnAA--.12280S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZrWDAr1fuw48AFWkuFyfJFb_yoWkGrgEkr
        4v9rnF9w1DZrnavw13KrWFgF95WFyUCw4UJ3ykJw1avw12qF93Grn5G3s3uryUZFs7Ar4a
        9r4Dt3yvkF9rWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        c7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2022 11:06 AM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Fri, Dec 2, 2022 at 9:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> According to LoongArch Reference Manual, simulate branch and
>> PC instructions, this is preparation for later patch.
>>

...

>> +static inline unsigned long sign_extended(unsigned long val, unsigned int idx)
>> +{
>> +       if (val & (1UL << idx))
>> +               return ~((1UL << (idx + 1)) - 1) | val;
>> +       else
>> +               return ((1UL << (idx + 1)) - 1) & val;
>> +}
> You can use existing __SIGNEX and its friends rather than reinvent them.

Thanks for your reminder.

In my opinion, this static inline function sign_extended()
is much more clear and readable than the macro __SIGNEX()
defined in alternative.c, the helper function bs_dest_*()
seems redundant too, use "pc + sign_extended()" is a more
straightforward way to simulate instruction according to
the ISA Manual, so here I prefer to keep it as is.

Additionally, we can use sign_extended() instead of __SIGNEX()
in alternative.c, the __SIGNEX() related code can be removed
in a seperate patch in some day.

Thanks,
Tiezhu

