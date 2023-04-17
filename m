Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC46E47A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjDQM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:27:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335911C;
        Mon, 17 Apr 2023 05:27:32 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1poNx9-0005H7-Lh; Mon, 17 Apr 2023 14:27:27 +0200
Message-ID: <c04a9a24-a802-261a-0d98-d4eef0ebfbe5@leemhuis.info>
Date:   Mon, 17 Apr 2023 14:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Kernel Panic - V6.2 - Reseved memory issue
Content-Language: en-US, de-DE
To:     Christian Hewitt <christianshewitt@gmail.com>, tanure@linux.com,
        Stefan Agner <stefan@agner.ch>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
 <9BAD677A-74AF-4515-B19C-A15A69CE53EF@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <9BAD677A-74AF-4515-B19C-A15A69CE53EF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681734452;2e1ebda9;
X-HE-SMSGID: 1poNx9-0005H7-Lh
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

This is apparently is a regression and thus got on my radar.

This all sounds a bit unfortunate. What can we do to get this properly
solved? Which commit actually causes this? I wonder if poking maintainer
higher in the hierarchy might help getting this finally fixed.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 02.04.23 15:11, Christian Hewitt wrote:
>> On 2 Apr 2023, at 12:10 pm, Lucas Tanure <tanure@linux.com> wrote:
>>
>> I am trying to fix a kernel panic I am seeing on my vim3 board (Amlogic A311D).
>> I don't have enough knowledge about this area, but my current guess is
>> the kernel is using a piece of memory belonging to ARM-trusted
>> firmware that I shouldn't.
>> Log:
>>
>> [ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
>> [ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
>> [ 9.792985] Hardware name: Khadas VIM3 (DT)
>> [ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
>> [ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
>> [ 9.793008] sp : ffff80000a2eb7f0
>> [ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: ffff000000008800
>> [ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: 0000000000000001
>> [ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: ffff00001f358538
>> [ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: 0000000000000040
>> [ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: 0000000000000003
>> [ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: 0000ffff9dc91fff
>> [ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : ffff000007e93680
>> [ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : 0000000000000007
>> [ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : 0000000000000001
>> [ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : ffff00001f358540
>> [ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt
>>
>> This doesn't happen with downstream Khadas 6.2 kernel, and that's
>> because the downstream kernel removed this from
>> early_init_dt_reserve_memory (drivers/of/fdt.c):
>>
>> /*
>> * If the memory is already reserved (by another region), we
>> * should not allow it to be marked nomap, but don't worry
>> * if the region isn't memory as it won't be mapped.
>> */
>> if (memblock_overlaps_region(&memblock.memory, base, size) &&
>>    memblock_is_region_reserved(base, size))
>>          return -EBUSY;
>>
>>
>> And this causes 3 MiB of memory belonging to ARM Trusted firmware to
>> be reserved.
>>
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi :
>> /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
>> secmon_reserved: secmon@5000000 {
>>        reg = <0x0 0x05000000 0x0 0x300000>;
>>        no-map;
>> };
>>
>> And the mainline kernel fails to reserve that memory:
>> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for
>> node 'secmon@5000000': base 0x0000000005000000, size 3 MiB
>>
>> It fails to reserve because memblock_overlaps_region and
>> memblock_is_region_reserved return one.
>> I think memblock_is_region_reserved is saying the memory is already
>> reserved by uboot and shouldn't be nomap, but it should.
>>
>> Is there a bug here?
>> Why the kernel is failing to reserve this memory?
>> Is this an u-boot issue?
>>
>> I would appreciate any help. The current mainline kernel fails 90% of
>> the time to boot into the Vim3 board.
> 
> The issue was raised before by Stefan Agner here:
> 
> https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/
> 
> The thread sort of points at the general issue but the conversation
> fizzled out and didn’t lead to any changes. At one point Stefan made
> a suggestion about reverting part of the code, leading to this patch
> in my own patchset:
> 
> https://github.com/chewitt/linux/commit/9633c9b24f6f16afdb7fa8c2e163b6ea7a7ac5f8
> 
> The issue is still present and the patch does work around it. The
> crashes would probably show up more, only a large percentage of
> distros that actively support Amlogic boards (and several vendors)
> are picking chunks of my curated LibreELEC patchset for their own
> kernels and thus that patch is quite widely used.
> 
> Christian
> 
