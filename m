Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC406A6499
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCABOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCABOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:14:39 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8B15894
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677633278; x=1709169278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+aZAPK10DnzUaT0ayx2/pjO5bVYRfWI3HigiBUgzRM=;
  b=KEEO1j2gZpk12FPeuwmaKc0sPqLMM7VsdGSfd30s8mnwBGo2jiDmDdgY
   t/b0iRzDDQtom0NoYfcm6xzIJm3PzsPxWw5IlITFNuobqhgtoFBFiR+Vv
   SaHQX1fa+Z2p9yAkBgq5kinRDMWE9Lm4BAi5lcoNMe+AKBFAN5BdBG1D+
   Ryw4e/LsZb7AxfcOKJF/o/C4vTj+FZzej0qi0Z3rUtOnqAqulZY1XB1jX
   +7yBpNdiaW7CJSQPV59lgfebXXTZzJbTI5qGS67V2ivObipsl8DSuGkmA
   HfoNtkZ3zA6cQ0zAD2QIaFkU9BeptgTBXHeuINbs+FqqxmU0dgkW9NIpG
   g==;
X-IronPort-AV: E=Sophos;i="5.98,223,1673884800"; 
   d="scan'208";a="336455395"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 09:14:37 +0800
IronPort-SDR: mxuZPO38/zm5VYxJ6zO7X0xpsrclx2QIN4JlrglmiqoVqR5xEy9JyOxAL4BQOTHGAjbNh+JFKO
 CmrSNiNnLpEa1p6E2m5DhutAziEigSD0kHEEgwG6bZTmtkBix5qB9NlLupMZgm2hOj65KSHXhO
 1EeeJgq2aY1hl6UMIQ4wSB0A5fikQdowCj9WvJCufkKwTOjF2WYYzcHhVlTSBvo5L9Mk80KiLb
 yeIrnnJQ59WlSrl53yWJpLTJcfDJWjsTwLuIDFCOSI0IROJPwjxwldMORXFPSdbVNxDShD5TJI
 5v0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 16:31:28 -0800
IronPort-SDR: YuwlrVdmUEc5AmCUNsCLYpheZpe6SS2QTGC8YeXf7zMaVUZOv4KEipTznlXSeIy0I1Xog3NDwU
 XXNtRMwL6jhzu0ZIfbU24qtMCgoFvW+86op5W39PCFwhqILc36Q8Si6D3k5cpSq8SPlxpnaar4
 vy/z/ronL0YLdPzDtBKRRfY0U1ka4e9ugaLASL+okq5zxYN4eC4yHWqFJWhzN0FZG/XZl+BofF
 8QUigYLceiVZ/nMeS4/lea14lqB+rZM98m6BWeHBB9g2dfRafIbzK1Y1cn12vC4E5UR9Wfb12d
 UnQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 17:14:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRGVP3nyCz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:14:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677633276; x=1680225277; bh=N+aZAPK10DnzUaT0ayx2/pjO5bVYRfWI3Hi
        giBUgzRM=; b=BzA5de2BzcC2J0nyyXm1kFXIXN8O6e2COQlzWHxaM8ShOb56hqb
        hrtiuCFA8yToZlxLWS8w0CGKZyDPd8xoq0HN59FKDhZNob1yBpqt1eaXoKP+r3dr
        E6GMbERI4aYrhxVFOIqhmn18MAXjued0XjqPQV2k7597ADPU6n/sL+bLbO2P8fRS
        Ju5tkDHamRqULWBZ3RdmCdpiSlE7ZyMxv5rDpekUSuT1t6EBeJrqm3++EUs5r+BJ
        Zp+wYSlBrh/CGIBamR6rxo47G+EGALbSIJgDubLhTX3m168kaC0ndM6kvvoerrQv
        lGgIMmqLL/KQqBxU2Fn8kTvjIjvMnsfgUbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wLRBd8YN7hLE for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 17:14:36 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRGVM43hSz1RvLy;
        Tue, 28 Feb 2023 17:14:35 -0800 (PST)
Message-ID: <9b48f4be-4060-2505-8028-95cfa6806f33@opensource.wdc.com>
Date:   Wed, 1 Mar 2023 10:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Content-Language: en-US
To:     Greg Ungerer <gerg@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
 <3719a4f0-1a5a-4661-a6d7-5d4f67d7b7e8@opensource.wdc.com>
 <b3ec8b21-8776-98e1-b7e2-f82bdee40602@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b3ec8b21-8776-98e1-b7e2-f82bdee40602@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 09:24, Greg Ungerer wrote:
> Hi Damien,
> 
> On 1/3/23 08:49, Damien Le Moal wrote:
>> On 3/1/23 06:52, Palmer Dabbelt wrote:
>>> On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
>>>> The following changes add the ability to run ELF format binaries when
>>>> running RISC-V in nommu mode. That support is actually part of the
>>>> ELF-FDPIC loader, so these changes are all about making that work on
>>>> RISC-V.
>>>>
>>>> The first issue to deal with is making the ELF-FDPIC loader capable of
>>>> handling 64-bit ELF files. As coded right now it only supports 32-bit
>>>> ELF files.
>>>>
>>>> Secondly some changes are required to enable and compile the ELF-FDPIC
>>>> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
>>>> user space when execing the new program.
>>>>
>>>> These changes have not been used to run actual ELF-FDPIC binaries.
>>>> It is used to load and run normal ELF - compiled -pie format. Though the
>>>> underlying changes are expected to work with full ELF-FDPIC binaries if
>>>> or when that is supported on RISC-V in gcc.
>>>>
>>>> To avoid needing changes to the C-library (tested with uClibc-ng
>>>> currently) there is a simple runtime dynamic loader (interpreter)
>>>> available to do the final relocations, https://github.com/gregungerer/uldso.
>>>> The nice thing about doing it this way is that the same program
>>>> binary can also be loaded with the usual ELF loader in MMU linux.
>>>>
>>>> The motivation here is to provide an easy to use alternative to the
>>>> flat format binaries normally used for RISC-V nommu based systems.
>>>>
>>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>>> ---
>>>>
>>>>   arch/riscv/include/asm/elf.h         |   11 +++++++++-
>>>>   arch/riscv/include/asm/mmu.h         |    4 +++
>>>>   arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
>>>>   fs/Kconfig.binfmt                    |    2 -
>>>>   fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
>>>>   include/linux/elf-fdpic.h            |   14 +++++++++++-
>>>>   include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
>>>>   7 files changed, 67 insertions(+), 22 deletions(-)
>>>
>>> Adding Damien, as IIRC he's had some hacked up userspace bits for the
>>> K210.  I'm yet to get anything running, but it'd be great if we get this
>>> to a point where I can actually boot test this on QEMU (I'm just doing
>>> builds now).
>>
>> +Niklas
>>
>> Niklas, didn't you add a nommu qemu build for buildroot ? Can't find the config
>> though...
>>
>>>
>>> Given that it's the second week of the merge window and this is a bunch
>>> of new uABI it seems best to hold off until the next cycle.  I poked
>>> around and don't see anything wrong, but I'll try and take a more
>>> detailed look after the merge window.
>>
>> Does any riscv compiler support nommu fdpic now ? When doing the work on the
>> k210, there was no support at all, hence the statically linked user binaries
>> used (no shared text for libraries).
> 
> I was wondering if anyone was working on it. Couldn't find anything.

Maciej (added to this thread) has done some work on gcc, but nothing that is
upstream yet.

> The way I use this support doesn't improve the statically linked situation.
> The -pie ELF files are still statically linked. But it does avoid the
> use of flat format binaries. That makes the toolchain generation a little
> simpler.

Right. I was still thinking in terms of flat bin. The keyword here is "elf"...
Need more coffe :)

We could try this using either qemu or the k210 with buildroot, with the
addition of your uldso loader. Will try to put that in the pipeline (pretty full
as usual, so may take a while).

> 
> Regards
> Greg
> 

-- 
Damien Le Moal
Western Digital Research

