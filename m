Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240F6FF97F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbjEKS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:28:07 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 11:28:04 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B27729A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:28:03 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4QHKrx3P72z1s95F;
        Thu, 11 May 2023 20:18:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4QHKrw5kCfz1qqlb;
        Thu, 11 May 2023 20:18:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id IerpHNoGBzfN; Thu, 11 May 2023 20:18:23 +0200 (CEST)
X-Auth-Info: i/Xv+IcJhW0kfDb3RFbFK0/YgUTT+UjCzPxmdmooeKeqEWINPY1r+0B4+hi7eI4b
Received: from igel.home (aftr-62-216-205-189.dynamic.mnet-online.de [62.216.205.189])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 11 May 2023 20:18:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 21B822C1D1B; Thu, 11 May 2023 20:18:23 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
In-Reply-To: <4adb27d2-325d-3ce0-23b1-ec69a973b4bf@ghiti.fr> (Alexandre
        Ghiti's message of "Tue, 9 May 2023 21:55:53 +0200")
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
        <20230215143626.453491-2-alexghiti@rivosinc.com>
        <87wn1h5nne.fsf@igel.home>
        <4adb27d2-325d-3ce0-23b1-ec69a973b4bf@ghiti.fr>
X-Yow:  BELA LUGOSI is my co-pilot..
Date:   Thu, 11 May 2023 20:18:23 +0200
Message-ID: <87ttwi91g0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 09 2023, Alexandre Ghiti wrote:

> On 5/9/23 21:07, Andreas Schwab wrote:
>> That does not work with UEFI booting:
>>
>> Loading Linux 6.4.0-rc1-1.g668187d-default ...
>> Loading initial ramdisk ...
>> Unhandled exception: Instruction access fault
>> EPC: ffffffff80016d56 RA: 000000008020334e TVAL: 0000007f80016d56
>> EPC: ffffffff002d1d56 RA: 00000000004be34e reloc adjusted
>> Unhandled exception: Load access fault
>> EPC: 00000000fff462d4 RA: 00000000fff462d0 TVAL: ffffffff80016d56
>> EPC: 00000000802012d4 RA: 00000000802012d0 reloc adjusted
>>
>> Code: c825 8e0d 05b3 40b4 d0ef 0636 7493 ffe4 (d783 0004)
>> UEFI image [0x00000000fe65e000:0x00000000fe6e3fff] '/efi\boot\bootriscv64.efi'
>> UEFI image [0x00000000daa82000:0x00000000dcc2afff]
>>
>
> I need more details please, as I have a UEFI bootflow and it works great
> (KASLR is based on a relocatable kernel and works fine in UEFI too).

It also crashes without UEFI.  Disabling CONFIG_RELOCATABLE fixes that.
This was tested on the HiFive Unmatched board.
The kernel image I tested is available from
<https://download.opensuse.org/repositories/Kernel:/HEAD/RISCV/>.  The
same kernel with CONFIG_RELOCATABLE disabled is available from
<https://download.opensuse.org/repositories/home:/Andreas_Schwab:/riscv:/kernel/standard/>.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
