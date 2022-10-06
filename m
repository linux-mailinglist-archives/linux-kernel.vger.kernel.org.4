Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A15F717F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiJFXBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiJFXBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:01:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25AC4C03
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:01:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w191so3395153pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN4miwGrMwTAr8vuA+CxQiPVjqHRbd4U4l+JJ7oe008=;
        b=bcrYRt7ENzyQqEqdkeEh2jVNgPT+HtOKFNjyVDpQCOaxka2rLAZA0mYFCt8jEVsP9q
         xb7HEqJtXIQHTfbG1BwA8rq1AzJyXInYHWwbuBrMxu4ZsgmSIyYgryLuSBLUfS3ItsOH
         Copz/bAl6DO7fZnF9mZ19kUlHCQm0Z7zBzArKAiZzhJdWHhdgQ25gMi/JezS2AqvaPd6
         eBJ7ZJXw9GgxciSIsDgPEnWE790GHED+KsDd/RiaXKNh7VTOnXB+HyEVz5IFemPh0ifU
         DGmlOR09IQa6oXW+mlb1B7RavL3bTzsQFZPYvvw/EGfvXLF+5u0+gKE/gwgH4CardeGY
         zUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN4miwGrMwTAr8vuA+CxQiPVjqHRbd4U4l+JJ7oe008=;
        b=OGNd0d126EB9F8s2C75NaahbtILQsn+HsO8m/7SVRcCXwdjfyTEhALcnWrbJI4Xngq
         SnB9ih8DeBWFKQ2zXGF5JFoeCDD+gg72AkfsfSQp6D/MLW1T/8ZGOTJzPMWpo5hY1qDu
         av7IV0Yz5dp7YRDItGHVZnWGier17l0NCH5agfftEnsMNJKMsiGtLKguOMMwXU1U/Ol5
         qEtN5hOHwYb7gQsBWJYRDSbodcPzEZirvVxyVlDZ5UY2WfNmnnosAVLvy+dKj4f0zpLu
         fIBKja0OKSlj57Se/hsq44EqT8R6oiLB7aMJA3NTC0ktUo41MiicXIOEsdjsEXav7De3
         5kHA==
X-Gm-Message-State: ACrzQf3zMf86H027Y9R8Z9kWSJsT6kQb45kxA3/ROY090gSWHFQxYdem
        Zgt4TyqRIWgA+jKclYgc9qOwE+pUcxHpoA==
X-Google-Smtp-Source: AMsMyM5DjP+jdcNi/KFvE4nLeDxqjHarAcBvmSkPlN2JDkfqCSnbNKdupLT7X+Z2aYKvCxzcXxb/Yg==
X-Received: by 2002:a63:5658:0:b0:43c:dac:9e24 with SMTP id g24-20020a635658000000b0043c0dac9e24mr1814480pgm.562.1665097276014;
        Thu, 06 Oct 2022 16:01:16 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm257309pgb.83.2022.10.06.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:01:15 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v4 PATCH 3/3] RISC-V: Use common linux loader
Date:   Thu,  6 Oct 2022 16:00:51 -0700
Message-Id: <20221006230051.185850-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006230051.185850-1-atishp@rivosinc.com>
References: <20221006230051.185850-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V doesn't have to do anything very different from other architectures
to loader EFI stub linux kernel. As a result, just use the common linux
loader instead of defining a RISC-V specific linux loader.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 grub-core/Makefile.core.def    |  4 +--
 grub-core/loader/riscv/linux.c | 59 ----------------------------------
 2 files changed, 2 insertions(+), 61 deletions(-)
 delete mode 100644 grub-core/loader/riscv/linux.c

diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def
index ce95c76eaffa..d6cb8a673e1b 100644
--- a/grub-core/Makefile.core.def
+++ b/grub-core/Makefile.core.def
@@ -1820,8 +1820,8 @@ module = {
   arm_efi = loader/efi/linux.c;
   arm_uboot = loader/arm/linux.c;
   arm64 = loader/efi/linux.c;
-  riscv32 = loader/riscv/linux.c;
-  riscv64 = loader/riscv/linux.c;
+  riscv32 = loader/efi/linux.c;
+  riscv64 = loader/efi/linux.c;
   common = loader/linux.c;
   common = lib/cmdline.c;
   enable = noemu;
diff --git a/grub-core/loader/riscv/linux.c b/grub-core/loader/riscv/linux.c
deleted file mode 100644
index d17c488e118d..000000000000
--- a/grub-core/loader/riscv/linux.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- *  GRUB  --  GRand Unified Bootloader
- *  Copyright (C) 2018  Free Software Foundation, Inc.
- *
- *  GRUB is free software: you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, either version 3 of the License, or
- *  (at your option) any later version.
- *
- *  GRUB is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <grub/command.h>
-#include <grub/dl.h>
-#include <grub/lib/cmdline.h>
-
-GRUB_MOD_LICENSE ("GPLv3+");
-
-static grub_err_t
-grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
-		 int argc __attribute__ ((unused)),
-		 char *argv[] __attribute__ ((unused)))
-{
-  grub_error (GRUB_ERR_NOT_IMPLEMENTED_YET, N_("Linux not supported yet"));
-
-  return grub_errno;
-}
-
-static grub_err_t
-grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
-		int argc __attribute__ ((unused)),
-		char *argv[] __attribute__ ((unused)))
-{
-  grub_error (GRUB_ERR_NOT_IMPLEMENTED_YET, N_("Linux not supported yet"));
-
-  return grub_errno;
-}
-
-static grub_command_t cmd_linux, cmd_initrd;
-
-GRUB_MOD_INIT (linux)
-{
-  cmd_linux = grub_register_command ("linux", grub_cmd_linux, 0,
-				     N_("Load Linux."));
-  cmd_initrd = grub_register_command ("initrd", grub_cmd_initrd, 0,
-				      N_("Load initrd."));
-}
-
-GRUB_MOD_FINI (linux)
-{
-  grub_unregister_command (cmd_linux);
-  grub_unregister_command (cmd_initrd);
-}
-- 
2.25.1

