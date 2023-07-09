Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191BF74C644
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGIPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGIPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:43:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C720D9;
        Sun,  9 Jul 2023 08:42:55 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIWYf-0002yG-Td; Sun, 09 Jul 2023 17:42:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v6 0/3] Implement GCM ghash using Zbc and Zbkb extensions
Date:   Sun,  9 Jul 2023 17:42:40 +0200
Message-Id: <20230709154243.1582671-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

This was originally part of my vector crypto series, but was part
of a separate openssl merge request implementing GCM ghash as using
non-vector extensions.

As that pull-request
    https://github.com/openssl/openssl/pull/20078
got merged recently into openssl, we could also check if this could
go into the kernel as well and provide a base for further accelerated
cryptographic support.

changes in v6:
- rebase on top of riscv/for-next
- rebase on top of Samuel Ortiz Arch-random series
  https://lore.kernel.org/r/20230709115549.2666557-1-sameo@rivosinc.com
  as it has the nicer Zbc + Zbkb integration for extensions and hwprobe
- update perl code with better licensing text (Eric)
  This was also merged into the original openSSL sources
- add SPDX license identifier (Eric)
- drop unneeded fallback element in the private struct (Herbert)

Changes in v5:
- rebased on top of 6.4-based riscv/next
- code from openssl is now dual-licensed under Apache + BSD
  see https://github.com/openssl/openssl/pull/20649
- separate init functions instead of creating them with macros (Nathan)

Changes in v4:
- rebase on top of riscv/for-next
- split out the scalar crypto implementation from the vector series
- refresh code from openSSL to match exactly
- Remove RFC label, as Zbc and Zbkb are ratified and
  the cryptographic code was merged into openSSL

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

Heiko Stuebner (3):
  RISC-V: expose Zbc as Kconfig option
  RISC-V: hook new crypto subdir into build-system
  RISC-V: crypto: add accelerated GCM GHASH implementation

 arch/riscv/Kbuild                      |   1 +
 arch/riscv/Kconfig                     |  23 ++
 arch/riscv/crypto/Kconfig              |  18 ++
 arch/riscv/crypto/Makefile             |  18 ++
 arch/riscv/crypto/ghash-riscv64-glue.c | 291 +++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zbc.pl | 430 +++++++++++++++++++++++++
 arch/riscv/crypto/riscv.pm             | 261 +++++++++++++++
 crypto/Kconfig                         |   3 +
 8 files changed, 1045 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
 create mode 100644 arch/riscv/crypto/riscv.pm

-- 
2.39.2

