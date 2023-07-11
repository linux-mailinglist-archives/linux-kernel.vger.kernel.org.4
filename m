Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1BC74F3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGKPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjGKPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:39:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA95310D4;
        Tue, 11 Jul 2023 08:38:01 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFQw-0000g0-J0; Tue, 11 Jul 2023 17:37:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Date:   Tue, 11 Jul 2023 17:37:31 +0200
Message-Id: <20230711153743.1970625-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

This series provides cryptographic implementations using the vector
crypto extensions.

v13 of the vector patchset dropped the patches for in-kernel usage of
vector instructions, I picked the ones from v12 over into this series
for now.

My basic goal was to not re-invent cryptographic code, so the heavy
lifting is done by those perl-asm scripts used in openssl and the perl
code used here-in stems from code that is targetted at openssl [0] and is
unmodified from there to limit needed review effort.

With a matching qemu (there are patches for vector-crypto flying around)
the in-kernel crypto-selftests (also the extended ones) are very happy
so far.


changes in v4:
- split off from scalar crypto patches but base on top of them
- adapt to pending openssl code [0] using the now frozen vector crypto
  extensions - with all its changes
  [0] https://github.com/openssl/openssl/pull/20149

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

Greentime Hu (2):
  riscv: Add support for kernel mode vector
  riscv: Add vector extension XOR implementation

Heiko Stuebner (10):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: add vector crypto extension detection
  RISC-V: crypto: update perl include with helpers for vector (crypto)
    instructions
  RISC-V: crypto: add Zvbb+Zvbc accelerated GCM GHASH implementation
  RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
  RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation
  RISC-V: crypto: add a vector-crypto-accelerated SHA512 implementation
  RISC-V: crypto: add Zvkned accelerated AES encryption implementation
  RISC-V: crypto: add Zvksed accelerated SM4 encryption implementation
  RISC-V: crypto: add Zvksh accelerated SM3 hash implementation

 arch/riscv/crypto/Kconfig                     |  68 ++-
 arch/riscv/crypto/Makefile                    |  44 +-
 arch/riscv/crypto/aes-riscv-glue.c            | 168 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl       | 530 ++++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-glue.c        | 245 ++++++++
 arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl  | 380 +++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl       | 168 ++++++
 arch/riscv/crypto/riscv.pm                    | 433 +++++++++++++-
 arch/riscv/crypto/sha256-riscv64-glue.c       | 115 ++++
 .../crypto/sha256-riscv64-zvbb-zvknha.pl      | 314 +++++++++++
 arch/riscv/crypto/sha512-riscv64-glue.c       | 106 ++++
 .../crypto/sha512-riscv64-zvbb-zvknhb.pl      | 377 +++++++++++++
 arch/riscv/crypto/sm3-riscv64-glue.c          | 112 ++++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl        | 225 ++++++++
 arch/riscv/crypto/sm4-riscv64-glue.c          | 162 ++++++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl       | 300 ++++++++++
 arch/riscv/include/asm/hwcap.h                |   9 +
 arch/riscv/include/asm/vector.h               |  28 +
 arch/riscv/include/asm/xor.h                  |  82 +++
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/cpu.c                       |   8 +
 arch/riscv/kernel/cpufeature.c                |  50 ++
 arch/riscv/kernel/kernel_mode_vector.c        | 132 +++++
 arch/riscv/lib/Makefile                       |   1 +
 arch/riscv/lib/xor.S                          |  81 +++
 25 files changed, 4136 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/crypto/aes-riscv-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvbb-zvknha.pl
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvbb-zvknhb.pl
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/lib/xor.S

-- 
2.39.2

