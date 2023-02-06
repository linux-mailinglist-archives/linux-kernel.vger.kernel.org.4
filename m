Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153BA68C9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBFW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:58:55 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE728201
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:58:51 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPARk-0002Mb-6m; Mon, 06 Feb 2023 23:58:48 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC 00/12] RISC-V: support some cryptography accelerations
Date:   Mon,  6 Feb 2023 23:58:34 +0100
Message-Id: <20230206225846.1381789-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

So this was my playground the last days.

The base is v13 of the vector patchset but the first patches up to doing
the Zbc-based GCM GHash can also run without those. Of course the vector-
crypto extensions are also not ratified yet, hence the marking as RFC.


As v13 of the vector patchset dropped the patches for in-kernel usage of
vector instructions, I picked the ones from v12 over into this series
for now.

My basic goal was to not re-invent cryptographic code, so the heavy
lifting is done by those perl-asm scripts used in openssl and the perl
code used here-in stems from code that is targetted at openssl [0] and is
unmodified from there to limit needed review effort.


With a matching qemu (there are patches for vector-crypto flying around)
the in-kernel crypto-selftests (also the extended ones) are very happy
so far.


Things to do:
- The series still includes its own Zbb extension detection,
  I'll need to untangle my branches to adapt to the applied Zbb
  patchset [and address Andrews comments]
- use correct Co-developed-attribution for the code coming from
  openssl
- some more cryptographic algorithms (aes, sha512, sm3, sm4)


[0] both still open
https://github.com/openssl/openssl/pull/20078
https://github.com/openssl/openssl/pull/20149


Greentime Hu (2):
  riscv: Add support for kernel mode vector
  riscv: Add vector extension XOR implementation

Heiko Stuebner (10):
  RISC-V: add Zbb extension detection
  RISC-V: add Zbc extension detection
  RISC-V: add Zbkb extension detection
  RISC-V: hook new crypto subdir into build-system
  RISC-V: crypto: add accelerated GCM GHASH implementation
  RISC-V: add vector crypto extension detection
  RISC-V: crypto: update perl include with helpers for vector (crypto)
    instructions
  RISC-V: crypto: add Zvkb accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation

 arch/riscv/Kbuild                          |   1 +
 arch/riscv/Kconfig                         |  45 ++
 arch/riscv/crypto/Kconfig                  |  28 +
 arch/riscv/crypto/Makefile                 |  34 +
 arch/riscv/crypto/ghash-riscv64-glue.c     | 489 ++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zbc.pl     | 400 ++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkb.pl    | 346 ++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl    | 172 +++++
 arch/riscv/crypto/riscv.pm                 | 723 +++++++++++++++++++++
 arch/riscv/crypto/sha256-riscv64-glue.c    | 103 +++
 arch/riscv/crypto/sha256-riscv64-zvknha.pl | 502 ++++++++++++++
 arch/riscv/include/asm/hwcap.h             |   7 +
 arch/riscv/include/asm/vector.h            |  14 +
 arch/riscv/include/asm/xor.h               |  82 +++
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/cpu.c                    |   7 +
 arch/riscv/kernel/cpufeature.c             |   7 +
 arch/riscv/kernel/kernel_mode_vector.c     | 132 ++++
 arch/riscv/lib/Makefile                    |   1 +
 arch/riscv/lib/xor.S                       |  81 +++
 crypto/Kconfig                             |   3 +
 21 files changed, 3178 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkb.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/riscv.pm
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha.pl
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/lib/xor.S

-- 
2.39.0

