Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0806B8185
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCMTNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCMTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:13:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64169EC4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:13:07 -0700 (PDT)
Received: from ip4d1634a9.dynamic.kabel-deutschland.de ([77.22.52.169] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pbnbT-00028k-MQ; Mon, 13 Mar 2023 20:13:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de
Subject: [PATCH RFC v3 00/16] RISC-V: support some cryptography accelerations
Date:   Mon, 13 Mar 2023 20:12:46 +0100
Message-Id: <20230313191302.580787-1-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

The base is v14 of the vector patchset but the first patches up to doing
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
- use correct Co-developed-attribution for the code coming from
  openssl
- follow openSSL changes along until they get eventually merged

changes in v3:
- rebase on top of 6.3-rc2
- rebase on top of vector-v14 patchset
- add the missing Co-developed-by mentions to showcase
  the people that did the actual openSSL crypto code

changes in v2:
- rebased on 6.2 + zbb series, so don't include already
  applied changes anymore
- refresh code picked from openssl as that side matures
- more algorithms (SHA512, AES, SM3, SM4)


[0] both still open
https://github.com/openssl/openssl/pull/20078
https://github.com/openssl/openssl/pull/20149


Greentime Hu (2):
  riscv: Add support for kernel mode vector
  riscv: Add vector extension XOR implementation

Heiko Stuebner (14):
  RISC-V: add Zbc extension detection
  RISC-V: add Zbkb extension detection
  RISC-V: hook new crypto subdir into build-system
  RISC-V: crypto: add accelerated GCM GHASH implementation
  RISC-V: add helper function to read the vector VLEN
  RISC-V: add vector crypto extension detection
  RISC-V: crypto: update perl include with helpers for vector (crypto)
    instructions
  RISC-V: crypto: add Zvkb accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation
  RISC-V: crypto: add a vector-crypto-accelerated SHA512 implementation
  RISC-V: crypto: add Zvkned accelerated AES encryption implementation
  RISC-V: crypto: add Zvksed accelerated SM4 encryption implementation
  RISC-V: crypto: add Zvksh accelerated SM3 hash implementation

 arch/riscv/Kbuild                          |   1 +
 arch/riscv/Kconfig                         |  22 +
 arch/riscv/crypto/Kconfig                  |  82 +++
 arch/riscv/crypto/Makefile                 |  60 ++
 arch/riscv/crypto/aes-riscv-glue.c         | 169 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl    | 500 ++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-glue.c     | 485 +++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zbc.pl     | 400 +++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkb.pl    | 349 +++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl    | 161 +++++
 arch/riscv/crypto/riscv.pm                 | 659 +++++++++++++++++++++
 arch/riscv/crypto/sha256-riscv64-glue.c    | 114 ++++
 arch/riscv/crypto/sha256-riscv64-zvknha.pl | 284 +++++++++
 arch/riscv/crypto/sha512-riscv64-glue.c    | 104 ++++
 arch/riscv/crypto/sha512-riscv64-zvknhb.pl | 347 +++++++++++
 arch/riscv/crypto/sm3-riscv64-glue.c       | 112 ++++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl     | 195 ++++++
 arch/riscv/crypto/sm4-riscv64-glue.c       | 163 +++++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl    | 270 +++++++++
 arch/riscv/include/asm/hwcap.h             |   9 +
 arch/riscv/include/asm/vector.h            |  25 +
 arch/riscv/include/asm/xor.h               |  82 +++
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/cpu.c                    |   9 +
 arch/riscv/kernel/cpufeature.c             |   9 +
 arch/riscv/kernel/kernel_mode_vector.c     | 132 +++++
 arch/riscv/lib/Makefile                    |   1 +
 arch/riscv/lib/xor.S                       |  81 +++
 crypto/Kconfig                             |   3 +
 29 files changed, 4829 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-riscv-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkb.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/riscv.pm
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha.pl
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb.pl
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/lib/xor.S

-- 
2.39.0

