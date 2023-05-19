Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00797095F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjESLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjESLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:08:20 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A9D7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:08:18 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id CF7CAE000B;
        Fri, 19 May 2023 11:08:12 +0000 (UTC)
Message-ID: <6fc7f0e1-0dde-9b41-0d60-6b0bd65bb630@ghiti.fr>
Date:   Fri, 19 May 2023 13:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
 <20230215143626.453491-2-alexghiti@rivosinc.com> <87wn1h5nne.fsf@igel.home>
 <4adb27d2-325d-3ce0-23b1-ec69a973b4bf@ghiti.fr> <87ttwi91g0.fsf@igel.home>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <87ttwi91g0.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 20:18, Andreas Schwab wrote:
> On Mai 09 2023, Alexandre Ghiti wrote:
>
>> On 5/9/23 21:07, Andreas Schwab wrote:
>>> That does not work with UEFI booting:
>>>
>>> Loading Linux 6.4.0-rc1-1.g668187d-default ...
>>> Loading initial ramdisk ...
>>> Unhandled exception: Instruction access fault
>>> EPC: ffffffff80016d56 RA: 000000008020334e TVAL: 0000007f80016d56
>>> EPC: ffffffff002d1d56 RA: 00000000004be34e reloc adjusted
>>> Unhandled exception: Load access fault
>>> EPC: 00000000fff462d4 RA: 00000000fff462d0 TVAL: ffffffff80016d56
>>> EPC: 00000000802012d4 RA: 00000000802012d0 reloc adjusted
>>>
>>> Code: c825 8e0d 05b3 40b4 d0ef 0636 7493 ffe4 (d783 0004)
>>> UEFI image [0x00000000fe65e000:0x00000000fe6e3fff] '/efi\boot\bootriscv64.efi'
>>> UEFI image [0x00000000daa82000:0x00000000dcc2afff]
>>>
>> I need more details please, as I have a UEFI bootflow and it works great
>> (KASLR is based on a relocatable kernel and works fine in UEFI too).
> It also crashes without UEFI.  Disabling CONFIG_RELOCATABLE fixes that.
> This was tested on the HiFive Unmatched board.
> The kernel image I tested is available from
> <https://download.opensuse.org/repositories/Kernel:/HEAD/RISCV/>.  The
> same kernel with CONFIG_RELOCATABLE disabled is available from
> <https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/kernel/standard/>.
>

I have tested the following patch successfully, can you give it a try 
while I make sure this is the only place I forgot to add the -fno-pie flag?

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fbdccc21418a..153864e4f399 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
  endif
+ifdef CONFIG_RELOCATABLE
+CFLAGS_alternative.o += -fno-pie
+CFLAGS_cpufeature.o += -fno-pie
+endif
  ifdef CONFIG_KASAN
  KASAN_SANITIZE_alternative.o := n
  KASAN_SANITIZE_cpufeature.o := n

Thanks

Alex

