Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1556CDB94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjC2OI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjC2OIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:08:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D74C30;
        Wed, 29 Mar 2023 07:07:44 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phWSA-0004ZJ-0m; Wed, 29 Mar 2023 16:07:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Date:   Wed, 29 Mar 2023 16:06:38 +0200
Message-Id: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Heiko Stuebner (4):
  RISC-V: add Zbc extension detection
  RISC-V: add Zbkb extension detection
  RISC-V: hook new crypto subdir into build-system
  RISC-V: crypto: add accelerated GCM GHASH implementation

 arch/riscv/Kbuild                      |   1 +
 arch/riscv/Kconfig                     |  22 ++
 arch/riscv/crypto/Kconfig              |  18 ++
 arch/riscv/crypto/Makefile             |  18 ++
 arch/riscv/crypto/ghash-riscv64-glue.c | 258 ++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zbc.pl | 400 +++++++++++++++++++++++++
 arch/riscv/crypto/riscv.pm             | 231 ++++++++++++++
 arch/riscv/include/asm/hwcap.h         |   2 +
 arch/riscv/kernel/cpu.c                |   2 +
 arch/riscv/kernel/cpufeature.c         |   2 +
 crypto/Kconfig                         |   3 +
 11 files changed, 957 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
 create mode 100644 arch/riscv/crypto/riscv.pm

-- 
2.39.0

