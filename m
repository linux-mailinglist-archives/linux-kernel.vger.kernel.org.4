Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F66A61C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjB1Vwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Vws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:52:48 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BF9035
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:52:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so8662912plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1677621166;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+zwAHBnS5+TovEmhkYJhNFoHDMUmuJ8ck612nZS1t8=;
        b=omA2S4LjqCtvzyGP293QcxTJ7Lo75f7JjOAJP3W5yp4CiKRAVuH5MtWpvo7ryDtMFz
         i4jDGzLy7aG5c07lAXorf7etqeUG4ti2THkpl4Pl5N4VjhCaAQvBh+zuvqBpue/ChW5q
         GPkiN80WRdLr/ITBQd4kPSb2Wp7rH42C3abAIZzxPmPdVZMnjCxDg7rbUbaOeiom2pjP
         BhZ8vn+XysK7S+6EWyghBcLpbo20XZl3pKYBT+y+773NB05P05laLT6RGZyuV0IwgejA
         cn3a/8Rb6R9Gl3jRiEUDxW+b9Ut/C2i9kNS1PvV+OEaP/Hp7CL/b+0dweVERR7XEfGGO
         ocxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677621166;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+zwAHBnS5+TovEmhkYJhNFoHDMUmuJ8ck612nZS1t8=;
        b=wilXrtbWudhhtxWpnnsw9fBh2yX2Px6Ey8QBS0gX+SReonaeT6vxZZZLX73lOYhkKu
         GOM0TXIcXiUJSKpKUeb81uVywMMZKaLtmJdTN4A60nOoDPA9cOpxOSJp/BP3jCMyDbuX
         Znu/RgkZdNDAxSpmHFrfmAhiLeq9SO6ELCE3QeeBMFnFmEkBGVd5V0zPLO34/8zTakff
         py8Xd17YLAee4Bx8vFgdtEH6WEX7eI5mYP7kN6LO59Tv5Y+8cHp0lUweS426OqeZlJLX
         GWsh06pNrWd4fYaf6nRaj1NzN3HHKCYMnKzGz4wqRyeYwSpCsv663Js0WO9Ykt5rZ7OJ
         7p2g==
X-Gm-Message-State: AO0yUKUrX1CNJshnk9VEtgxWWv77+/Zb4F+RbcYVm2gLtYLxrvs5nr7N
        zxokVpueSeHD2+q6oNezvSYkkX+KpitttSUE/4M=
X-Google-Smtp-Source: AK7set/juip8p0MiLlYoPEIxqV9PMajgZBFayKyd5KvUfxhWs1VFVopVgOhH6LHgXjliJBQQwUAyQA==
X-Received: by 2002:a17:902:e851:b0:19a:839f:435 with SMTP id t17-20020a170902e85100b0019a839f0435mr13658248plg.3.1677621166383;
        Tue, 28 Feb 2023 13:52:46 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001967692d6f5sm6945909plb.227.2023.02.28.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 13:52:45 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:52:45 -0800 (PST)
X-Google-Original-Date: Tue, 28 Feb 2023 13:51:58 PST (-0800)
Subject:     Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
In-Reply-To: <20230228135126.1686427-1-gerg@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gerg@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gerg@kernel.org, damien.lemoal@opensource.wdc.com
Message-ID: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
> The following changes add the ability to run ELF format binaries when
> running RISC-V in nommu mode. That support is actually part of the
> ELF-FDPIC loader, so these changes are all about making that work on
> RISC-V.
>
> The first issue to deal with is making the ELF-FDPIC loader capable of
> handling 64-bit ELF files. As coded right now it only supports 32-bit
> ELF files.
>
> Secondly some changes are required to enable and compile the ELF-FDPIC
> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
> user space when execing the new program.
>
> These changes have not been used to run actual ELF-FDPIC binaries.
> It is used to load and run normal ELF - compiled -pie format. Though the
> underlying changes are expected to work with full ELF-FDPIC binaries if
> or when that is supported on RISC-V in gcc.
>
> To avoid needing changes to the C-library (tested with uClibc-ng
> currently) there is a simple runtime dynamic loader (interpreter)
> available to do the final relocations, https://github.com/gregungerer/uldso.
> The nice thing about doing it this way is that the same program
> binary can also be loaded with the usual ELF loader in MMU linux.
>
> The motivation here is to provide an easy to use alternative to the
> flat format binaries normally used for RISC-V nommu based systems.
>
> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> ---
>
>  arch/riscv/include/asm/elf.h         |   11 +++++++++-
>  arch/riscv/include/asm/mmu.h         |    4 +++
>  arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
>  fs/Kconfig.binfmt                    |    2 -
>  fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
>  include/linux/elf-fdpic.h            |   14 +++++++++++-
>  include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
>  7 files changed, 67 insertions(+), 22 deletions(-)

Adding Damien, as IIRC he's had some hacked up userspace bits for the 
K210.  I'm yet to get anything running, but it'd be great if we get this 
to a point where I can actually boot test this on QEMU (I'm just doing 
builds now).

Given that it's the second week of the merge window and this is a bunch 
of new uABI it seems best to hold off until the next cycle.  I poked 
around and don't see anything wrong, but I'll try and take a more 
detailed look after the merge window.

Thanks!
