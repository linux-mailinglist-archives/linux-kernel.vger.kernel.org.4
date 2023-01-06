Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0812665FE37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjAFJmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjAFJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:42:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69110736F9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:37:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02EB461D72
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D407EC433D2;
        Fri,  6 Jan 2023 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672997872;
        bh=4Yg7nKp5VKlgMLRQicguVZYUf8Mfxt+W8biYKtmLKNw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JF2wYRrhOQHlEyYkwne41oBdqiJTi+svDSB5DxIHYLfPVyPbLD/DiSD4HuCsyglXr
         lxEV+eBQBIUyUf2FfwBbhzvix4xBW4tH763tpGyAIyVZRIsKGKXV+Ajf4+fPIJnbiB
         F9nlDDkR/OOZ17Jlwev/YQcus3Qhv7eHUm3WqxvfGvHY4/o1TEw08UX/jXYWDus+Ud
         nrGmh+rbKQF3a4uJIZspp8JrMyPhblxW8WX53R1o5JtnFfz4bxQNPJLJdf40g0BkMP
         s4I3WyaVpifMXmZ/5xX4lDMA5oMVJB5cQ8xHaBNqoH/Vl178mqEcGk4zUtGaDNVQFu
         XiW4ONMRj1n7Q==
Date:   Fri, 06 Jan 2023 09:37:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH 0/3] RISC-V Hibernation Support
User-Agent: K-9 Mail for Android
In-Reply-To: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
References: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
Message-ID: <E0CEA20A-7D53-4766-AB5D-48A06D7E3991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,
Just passing on some issues that automation picked up=2E


On 6 January 2023 06:05:32 GMT, Sia Jee Heng <jeeheng=2Esia@starfivetech=
=2Ecom> wrote:
>This series adds RISC-V Hibernation/suspend to disk support=2E
>Low level Arch functions were created to support hibernation=2E
>swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
>cpu state onto the stack, then calling swsusp_save() to save the memory
>image=2E
>
>arch_hibernation_header_restore() and arch_hibernation_header_save()
>functions are implemented to prevent kernel crash when resume,
>the kernel built version is saved into the hibernation image header
>to making sure only the same kernel is restore when resume=2E
>
>swsusp_arch_resume() creates a temporary page table that covering only
>the linear map, copies the restore code to a 'safe' page, then start to
>restore the memory image=2E Once completed, it restores the original
>kernel's page table=2E It then calls into __hibernate_cpu_resume()
>to restore the CPU context=2E Finally, it follows the normal hibernation
>path back to the hibernation core=2E
>
>To enable hibernation/suspend to disk into RISCV, the below config
>need to be enabled:
>- CONFIG_ARCH_HIBERNATION_HEADER
>- CONFIG_ARCH_HIBERNATION_POSSIBLE
>
>
>At high-level, this series includes the following changes:
>1) Change suspend_save_csrs() and suspend_restore_csrs()
>   to public function as these functions are common to
>   suspend/hibernation=2E (patch 1)
>2) Enhance kernel_page_present() function to support huge page=2E (patch =
2)
>3) Add arch/riscv low level functions to support
>   hibernation/suspend to disk=2E (patch 3)
>
>The above patches are based on kernel v6=2E2-rc2 and are tested on
>Starfive VF2 SBC board=2E
>
>Sia Jee Heng (3):
>  RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public
>    function
>  RISC-V: mm: Enable huge page support to kernel_page_present() function

Unfortunately this breaks rv32_defconfig
https://patchwork=2Ekernel=2Eorg/project/linux-riscv/patch/20230106060535=
=2E104321-3-jeeheng=2Esia@starfivetech=2Ecom/

>  RISC-V: Add arch functions to support hibernation/suspend-to-disk

This one then breaks rv64 allmodconfig too :/

https://patchwork=2Ekernel=2Eorg/project/linux-riscv/patch/20230106060535=
=2E104321-4-jeeheng=2Esia@starfivetech=2Ecom/

Thanks,
Conor=2E

>
> arch/riscv/Kconfig                |   7 +
> arch/riscv/include/asm/suspend=2Eh  |  23 ++
> arch/riscv/kernel/Makefile        |   2 +-
> arch/riscv/kernel/asm-offsets=2Ec   |   5 +
> arch/riscv/kernel/hibernate-asm=2ES | 123 +++++++++++
> arch/riscv/kernel/hibernate=2Ec     | 353 ++++++++++++++++++++++++++++++
> arch/riscv/kernel/suspend=2Ec       |   4 +-
> arch/riscv/mm/pageattr=2Ec          |   6 +
> 8 files changed, 520 insertions(+), 3 deletions(-)
> create mode 100644 arch/riscv/kernel/hibernate-asm=2ES
> create mode 100644 arch/riscv/kernel/hibernate=2Ec
>
>
>base-commit: 1f5abbd77e2c1787e74b7c2caffac97def78ba52
