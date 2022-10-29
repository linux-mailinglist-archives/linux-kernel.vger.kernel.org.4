Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5F612014
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ2Ee1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2EeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:34:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5F92CEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:34:23 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzmlL0mfGzHvL3;
        Sat, 29 Oct 2022 12:34:06 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 12:34:21 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 12:34:21 +0800
Message-ID: <b30fa009-9174-da95-5799-149837e199e6@huawei.com>
Date:   Sat, 29 Oct 2022 12:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ASoC: core: Fix use-after-free in snd_soc_exit()
To:     Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.com>, <perex@perex.cz>, <lgirdwood@gmail.com>
References: <20221028031603.59416-1-chenzhongjin@huawei.com>
 <166697367874.746166.7503879951900455151.b4-ty@kernel.org>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <166697367874.746166.7503879951900455151.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/10/29 0:14, Mark Brown wrote:
> On Fri, 28 Oct 2022 11:16:03 +0800, Chen Zhongjin wrote:
>> KASAN reports a use-after-free:
>>
>> BUG: KASAN: use-after-free in device_del+0xb5b/0xc60
>> Read of size 8 at addr ffff888008655050 by task rmmod/387
>> CPU: 2 PID: 387 Comm: rmmod
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>> Call Trace:
>> <TASK>
>> dump_stack_lvl+0x79/0x9a
>> print_report+0x17f/0x47b
>> kasan_report+0xbb/0xf0
>> device_del+0xb5b/0xc60
>> platform_device_del.part.0+0x24/0x200
>> platform_device_unregister+0x2e/0x40
>> snd_soc_exit+0xa/0x22 [snd_soc_core]
>> __do_sys_delete_module.constprop.0+0x34f/0x5b0
>> do_syscall_64+0x3a/0x90
>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> ...
>> </TASK>
>>
>> [...]
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [1/1] ASoC: core: Fix use-after-free in snd_soc_exit()
>        commit: 6ec27c53886c8963729885bcf2dd996eba2767a7

I noticed that there is a build warning introduced by this patch:

WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in 
reference: init_module (section: .init.text) -> snd_soc_util_exit 
(section: .exit.text)

It's because it calls _exit snd_soc_util_exit() inside _init snd_soc_init().

Since snd_soc_util_exit is only used in snd_soc_init() and 
snd_soc_exit(), could you please add this fix to the patch and delete 
_exit for snd_soc_util_exit()?

Or should I send a v2 version to replace current one?


diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index a3b6df2378b4..a4dba0b751e7 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -264,7 +264,7 @@ int __init snd_soc_util_init(void)
         return ret;
  }

-void __exit snd_soc_util_exit(void)
+void snd_soc_util_exit(void)
  {
         platform_driver_unregister(&soc_dummy_driver);
         platform_device_unregister(soc_dummy_dev);


Thanks!

Best,

Chen

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
