Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70F274EFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjGKNIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGKNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69A93
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61E1614BD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0ECC433C8;
        Tue, 11 Jul 2023 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689080909;
        bh=LUcJB0cq3kg6328TLZnO/4L83pKi9KtIC1j5JsNOlE8=;
        h=From:To:Cc:Subject:Date:From;
        b=gI8w4Ex9LIcrKsCI1HWYPC+akmsCgpovuc87W7bVuf9+xEyO7s29XnpujGm9IHQ/F
         iXg0ykha7MCPbDzVdvvbV3nWbggu5BQN/3V4lfJShrQ3bdP/vCEXsEdP60ZkBAz2yA
         wQO6Eic4WPZgm/ZcZH4rQNehffXS8kEMPfEciRznJpcz2UM/Fxo2moBLNF7gRBAjkK
         NNQ7dRYhscaMbYNU/KC+//Ef2M0GPHj/xRMBHClMCFMrxLnjN7W4bTWu9bIO8Flg64
         AZIqh6xIlgxowZWGKrnkyTNcXGXHyC65zCrrS0X+1PoSoGUDRaQmDXItO0JHdRqCyp
         +ML9YhD7XnYpw==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     palmer@dabbelt.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, brauner@kernel.org,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2 0/2] riscv: support ELF format binaries in nommu mode
Date:   Tue, 11 Jul 2023 23:07:52 +1000
Message-Id: <20230711130754.481209-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes add the ability to run ELF format binaries when
running RISC-V in nommu mode. That support is actually part of the
ELF-FDPIC loader, so these changes are all about making that work on
RISC-V.

The first issue to deal with is making the ELF-FDPIC loader capable of
handling 64-bit ELF files. As coded right now it only supports 32-bit
ELF files. 

Secondly some changes are required to enable and compile the ELF-FDPIC
loader on RISC-V and to pass the ELF-FDPIC mapping addresses through to
user space when execing the new program.

These changes have not been used to run actual ELF-FDPIC binaries.
It is used to load and run normal ELF - compiled -pie format. Though the
underlying changes are expected to work with full ELF-FDPIC binaries if
or when that is supported on RISC-V in gcc.

To avoid needing changes to the C-library (tested with uClibc-ng
currently) there is a simple runtime dynamic loader (interpreter)
available to do the final relocations, https://github.com/gregungerer/uldso.
The nice thing about doing it this way is that the same program
binary can also be loaded with the usual ELF loader in MMU linux.

The motivation here is to provide an easy to use alternative to the
flat format binaries normally used for RISC-V nommu based systems.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
v1->v2: rebase onto 6.5-rc1

 arch/riscv/include/asm/elf.h         |   11 +++++++++-
 arch/riscv/include/asm/mmu.h         |    4 +++
 arch/riscv/include/uapi/asm/ptrace.h |    5 ++++
 fs/Kconfig.binfmt                    |    2 -
 fs/binfmt_elf_fdpic.c                |   38 +++++++++++++++++------------------
 include/linux/elf-fdpic.h            |   14 +++++++++++-
 include/uapi/linux/elf-fdpic.h       |   15 +++++++++++++
 7 files changed, 67 insertions(+), 22 deletions(-)


