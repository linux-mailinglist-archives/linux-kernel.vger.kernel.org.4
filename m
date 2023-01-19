Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB0674C49
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjATF2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjATF15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:27:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE194DBEF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:23:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B972B825D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331B2C433D2;
        Thu, 19 Jan 2023 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144276;
        bh=bLiBD1lcTQlE2apcHhtHrHNRHMGBCYK7pvp8YphbLrY=;
        h=From:To:Cc:Subject:Date:From;
        b=PHA28sXsdkIBTt828JLOLw8VtnGqWragwmGlYDnKnko5/DgoZK+PA6pCUy4Ufmm6f
         Tr+T5k68kXaxP/kjDm0wrK2eTdFARnKvIqjl0EFhhDob5tg867mGpgl1OBwd63DA3M
         QIKyemxHRzin5DplvVozZ5iXyTOYkcN/Aqbpndb1lW5funuUUor7K9hW2Lt74Cv0mo
         FffZzwXRA/+sghu21oQ5H0/KqTFSKd0OZRnUFyVpasC1dVhu1wJ0VtXKyvMYvZVDUD
         zeGo0HdCGKnm62bi5rpqTwmY36e99v73rs4zhOY57h0pomKM7pAHaKp000Ztw7o8G6
         hg+/nQyvgnEtA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] riscv: improve link and support ARCH_WANT_LD_ORPHAN_WARN
Date:   Thu, 19 Jan 2023 23:54:12 +0800
Message-Id: <20230119155417.2600-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to improve link time handling of riscv:
patch1 adds the missing RUNTIME_DISCARD_EXIT as suggested by Masahiro.

Similar as other architectures such as x86, arm64 and so on, enable
ARCH_WANT_LD_ORPHAN_WARN to enable linker orphan warnings to prevent
from missing any new sections in future. So the following two patches
are preparation ones, and the last patch finally selects
ARCH_WANT_LD_ORPHAN_WARN

Since v1:
  - add one more patch to catch .init.bss from EFI stub

Jisheng Zhang (5):
  riscv: lds: define RUNTIME_DISCARD_EXIT
  riscv: vmlinux.lds.S: explicitly catch .rela.dyn symbols
  riscv: vmlinux.lds.S: explicitly catch .riscv.attributes sections
  riscv: vmlinux.lds.S: explicitly catch .init.bss sections from EFI
    stub
  riscv: select ARCH_WANT_LD_ORPHAN_WARN for !XIP_KERNEL

 arch/riscv/Kconfig              | 1 +
 arch/riscv/kernel/vmlinux.lds.S | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.38.1

