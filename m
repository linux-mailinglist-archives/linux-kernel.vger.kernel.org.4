Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C870ADF9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjEULug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjEULti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:49:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31710F8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:47:24 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q0hWu-0008T6-Os; Sun, 21 May 2023 13:47:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, christoph.muellner@vrull.eu,
        David.Laight@ACULAB.COM, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Date:   Sun, 21 May 2023 13:47:13 +0200
Message-Id: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Zawrs [0] was ratified in november 2022 [1], so I've resurrect the patch
adding Zawrs support for spinlocks and adapted it to recent kernel
changes.

Also incorporated are the nice comments David Laight provided on v2.


Changes since v2:
- Rebase on top of 6.4-rc1
- Adapt to changed alternatives Kconfig handling
- Adapt to changed cpufeature extension handling
- Address review comments from David Laight
  - better handling for 32/64bit cases (less ifdefery)
  - less macros calling macros
  - don't duplicate __smp_load_reserved_relaxed in
    __smp_load_reserved_aquire

Changes since v1:
- Fixing type checking code for 32/64-bit values
- Adjustments according to the specification change
- Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS


[0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
[1] https://github.com/riscv/riscv-zawrs/commit/9ff54f7e7fcd95cf1b111d2e54276ff1183bcd37

Christoph Müllner (1):
  riscv: Add Zawrs support for spinlocks

Heiko Stuebner (1):
  riscv: don't include kernel.h into alternative.h

 arch/riscv/Kconfig                   | 10 +++++
 arch/riscv/include/asm/alternative.h |  1 -
 arch/riscv/include/asm/barrier.h     | 64 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/errata_list.h | 14 ++++++
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpu.c              |  1 +
 arch/riscv/kernel/cpufeature.c       |  1 +
 7 files changed, 91 insertions(+), 1 deletion(-)

-- 
2.39.0

