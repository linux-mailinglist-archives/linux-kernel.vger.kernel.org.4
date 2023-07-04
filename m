Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012187473B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGDOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGDOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:09:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B21119
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:09:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89b0c73d7so1813005ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479794; x=1691071794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNVc/lWNaJwg4YvT+IkALxQ0qVnRk5RlYxkisizUmPs=;
        b=sOqO8Mdo3qKCn6fETzd5E7/dNhb5a6LaIqkkyzVK1sqsXQAVRcCsYAciANkmKC9spO
         rqZR/gEIUj0TDHTHBkWt9Rs0Wl45Z1qIVvgDJDrH/5fRqbhRBeE4tRMLcj5uPToR7QTU
         +jj6z84V/93X/fkMU9FKJB7Hb9C62h2EYPyfO6Nbp+8Tjta0WJU33Z3eM6qL63RjL7d4
         G81F/kCkUBAMsPJQOBW38L2F5zU4Wo9p9O98BOqcWEu0AtWMpZunJ62q965uMK9h86nf
         B2ahUkAdEnKIIbSxcexTV9Ms/h/6DJFG0uHQIW62iesFclXubNU2ur9p6J0nvWXkO8rj
         f+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479794; x=1691071794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNVc/lWNaJwg4YvT+IkALxQ0qVnRk5RlYxkisizUmPs=;
        b=JyUSbhxzI02jvCMbZvj+Cjv4T8qp6RaZiPc3gyqAJkuhTjyo8iPusa7RHZ+w6XNjq2
         +2c2dsj10scSxAlUBzwwS2+U4Aj7SE5+rQvTdzl+OMEuKc6Vz7rBvjRORZCqvTlKi/jv
         YUwiYnOIykyC3VGSx0HUZ7Iwik6u5U56CVKNohMa045dSGTSfKEYGo5F8d/+7WcCkPzS
         9hInjKJ4hIhNzSFTTh9M7q1ogAesfpOye9A9o34q5EEgHBoPKjkvKGc1ZBP+RbOfKLcR
         CFN6A8g0PPOsRD6uASEmnwRRwVw9HPQqAuV7cmywUdJXwqJy14U+LKNxq25x4KGlLHZs
         te5A==
X-Gm-Message-State: ABy/qLY4DVbV8BS4Tv/zJJxcoc/lAt0tCsbxB04WmYaq19H4n2c5HUZa
        fbLbjUnI7jT+0A9ZSzA+orfcKw==
X-Google-Smtp-Source: APBJJlE9RI0DK4Ion+iq8cniS+0A4G82a4j2L2B88L3T8BciKJ3WuLozAI9h6jz3YXIjkYI/2YnGFg==
X-Received: by 2002:a17:902:fa46:b0:1b8:a8e5:e8bc with SMTP id lb6-20020a170902fa4600b001b8a8e5e8bcmr936049plb.6.1688479793572;
        Tue, 04 Jul 2023 07:09:53 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:09:53 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 0/9] Add support to handle misaligned accesses in S-mode
Date:   Tue,  4 Jul 2023 16:09:15 +0200
Message-Id: <20230704140924.315594-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 61cadb9 ("Provide new description of misaligned load/store
behavior compatible with privileged architecture.") in the RISC-V ISA
manual, it is stated that misaligned load/store might not be supported.
However, the RISC-V kernel uABI describes that misaligned accesses are
supported. In order to support that, this series adds support for S-mode
handling of misaligned accesses, SBI call for misaligned trap delegation
as well prctl support for PR_SET_UNALIGN.

Handling misaligned access in kernel allows for a finer grain control
of the misaligned accesses behavior, and thanks to the prctl call, can
allow disabling misaligned access emulation to generate SIGBUS. User
space can then optimize its software by removing such access based on
SIGBUS generation.

This series relies on a SBI extension [1] allowing to request delegation of
the misaligned load/store traps to the S-mode software. This extension
has been submitted for review to the riscv tech-prs group. An OpenSBI
implementation for this spec is available at [2].

This series can be tested using the spike simulator [3] which allows to
either handles misaligned access in hardware or let the software do it.

With hardware misaligned access support:
$ ./spike --misaligned --initrd=rootfs.cpio \
  --kernel=arch/riscv/boot/Image opensbi_fw_jump.elf

Without hardware misaligned access support:
$ ./spike --initrd=rootfs.cpio --kernel=arch/riscv/boot/Image \
   opensbi_fw_jump.elf

[1] https://lists.riscv.org/g/tech-prs/message/540
[2] https://github.com/rivosinc/opensbi/tree/dev/cleger/fw_feature_upstream
[3] https://github.com/riscv-software-src/riscv-isa-sim

Changes in V2:
 - Fix prototypes declaration for handle_misaligned_load/store()
 - Fix build for !CONFIG_FPU
 - Added conditional build for various part of misaligned code handling
 - Added in-kernel misalignement fault support to be equivalent to
   existing SBI support
 - Added support for misalignment emulation detection for hwprobe
   reporting
 - Modified set/get_unaligned_ctl to use this detection of emulation
 - Added support for sysctl "unaligned_enabled"

Clément Léger (9):
  riscv: remove unused functions in traps_misaligned.c
  riscv: avoid missing prototypes warning
  riscv: add support for misaligned handling in S-mode
  riscv: report perf event for misaligned fault
  riscv: add support for sysctl unaligned_enabled control
  riscv: add support for SBI misalignment trap delegation
  riscv: report misaligned accesses emulation to hwprobe
  riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
  riscv: add floating point insn support to misaligned access emulation

 arch/riscv/Kconfig                    |   1 +
 arch/riscv/include/asm/cpufeature.h   |  10 +
 arch/riscv/include/asm/entry-common.h |   3 +
 arch/riscv/include/asm/processor.h    |   9 +
 arch/riscv/include/asm/sbi.h          |  11 +
 arch/riscv/kernel/Makefile            |   2 +-
 arch/riscv/kernel/fpu.S               | 117 +++++++++
 arch/riscv/kernel/process.c           |  18 ++
 arch/riscv/kernel/sbi.c               |  21 ++
 arch/riscv/kernel/setup.c             |   2 +
 arch/riscv/kernel/traps.c             |   9 -
 arch/riscv/kernel/traps_misaligned.c  | 352 ++++++++++++++++++++++----
 12 files changed, 498 insertions(+), 57 deletions(-)

-- 
2.40.1

