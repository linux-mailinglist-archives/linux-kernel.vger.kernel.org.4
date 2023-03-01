Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF46A6434
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCAAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCAAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:24:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342232D175
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3958A60FD9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE5C433D2;
        Wed,  1 Mar 2023 00:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677630248;
        bh=m4guPfJLUa8LmwPjtN0dbXYerTvJcpnOVu9CzY3no+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ln9WdYoxjZoAiwJySwfPO+L2v7buBxftjBXhNQAVyCeyqTCSSukyiQ9rYjTgPIkCG
         OjHp6qmOFvjSIZ37hNCL8gPtBO8K+S+dBzN8+wtQ0j/POPUvpZAgGnKlOJcG2Zc9JW
         JE9Aa06X0egJzufhZyMZgY/Uo7wL1wtk3l9oHQYiz/OtpP4j15u7TGOizpEq/2sZJi
         W1RjezCmky98WvbG1SRtJuDsrs29HKCY5+hi5g5ZZ9cCuKAauhFD15hQ26GNBOjVCm
         O6P2tpeh/n+sfGQSvQm+H0wssokb+YVtMsdPsHlLJ0c8KaPzYQGJoNbVbEc6Y7OOmP
         MMv93wiezPWVA==
Message-ID: <b3ec8b21-8776-98e1-b7e2-f82bdee40602@kernel.org>
Date:   Wed, 1 Mar 2023 10:24:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
 <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On 1/3/23 08:49, Damien Le Moal wrote:
> On 3/1/23 06:52, Palmer Dabbelt wrote:
>> On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
>>> The following changes add the ability to run ELF format binaries when
>>> running RISC-V in nommu mode. That support is actually part of the
>>> ELF-FDPIC loader, so these changes are all about making that work on
>>> RISC-V.
>>>
>>> The first issue to deal with is making the ELF-FDPIC loader capable of
>>> handling 64-bit ELF files. As coded right now it only supports 32-bit
>>> ELF files.
>>>
>>> Secondly some changes are required to enable and compile the ELF-FDPIC
>>> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
>>> user space when execing the new program.
>>>
>>> These changes have not been used to run actual ELF-FDPIC binaries.
>>> It is used to load and run normal ELF - compiled -pie format. Though the
>>> underlying changes are expected to work with full ELF-FDPIC binaries if
>>> or when that is supported on RISC-V in gcc.
>>>
>>> To avoid needing changes to the C-library (tested with uClibc-ng
>>> currently) there is a simple runtime dynamic loader (interpreter)
>>> available to do the final relocations, https://github.com/gregungerer/uldso.
>>> The nice thing about doing it this way is that the same program
>>> binary can also be loaded with the usual ELF loader in MMU linux.
>>>
>>> The motivation here is to provide an easy to use alternative to the
>>> flat format binaries normally used for RISC-V nommu based systems.
>>>
>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>> ---
>>>
>>>   arch/riscv/include/asm/elf.h         |   11 +++++++++-
>>>   arch/riscv/include/asm/mmu.h         |    4 +++
>>>   arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
>>>   fs/Kconfig.binfmt                    |    2 -
>>>   fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
>>>   include/linux/elf-fdpic.h            |   14 +++++++++++-
>>>   include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
>>>   7 files changed, 67 insertions(+), 22 deletions(-)
>>
>> Adding Damien, as IIRC he's had some hacked up userspace bits for the
>> K210.  I'm yet to get anything running, but it'd be great if we get this
>> to a point where I can actually boot test this on QEMU (I'm just doing
>> builds now).
> 
> +Niklas
> 
> Niklas, didn't you add a nommu qemu build for buildroot ? Can't find the config
> though...
> 
>>
>> Given that it's the second week of the merge window and this is a bunch
>> of new uABI it seems best to hold off until the next cycle.  I poked
>> around and don't see anything wrong, but I'll try and take a more
>> detailed look after the merge window.
> 
> Does any riscv compiler support nommu fdpic now ? When doing the work on the
> k210, there was no support at all, hence the statically linked user binaries
> used (no shared text for libraries).

I was wondering if anyone was working on it. Couldn't find anything.

The way I use this support doesn't improve the statically linked situation.
The -pie ELF files are still statically linked. But it does avoid the
use of flat format binaries. That makes the toolchain generation a little
simpler.

Regards
Greg

