Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF915FBE61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJKXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJKXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:19:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C440A8CEC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:19:12 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oiOWK-0003i7-1R; Wed, 12 Oct 2022 01:18:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor.Dooley@microchip.com, samuel@sholland.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 0/2] riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Wed, 12 Oct 2022 01:18:39 +0200
Message-Id: <20221011231841.2951264-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU on T-Head C9xx cores is quite similar to the SSCOFPMF extension
but not completely identical, so this series

changes in v6:
- follow Anup's suggestion and hook into the (pending) cpuinfo patch [2]
  instead of modifying the core sbi_get_* functions

changes in v5:
- add received Reviews
- fix sbi caching wrt. negative values (Drew)
- add comment about specific c9xx arch- and imp-ids (Conor)

changes in v4:
- add new patch to cache sbi mvendor, march and mimp-ids (Atish)
- errata dependencies in one line (Conor)
- make driver detection conditional on CONFIG_ERRATA_THEAD_PMU too (Atish)

changes in v3:
- improve commit message (Atish, Conor)
- IS_ENABLED and BIT() in errata probe (Conor)

The change depends on my cpufeature/t-head errata probe cleanup series [1].


changes in v2:
- use alternatives for the CSR access
- make the irq num selection a bit nicer

There is of course a matching opensbi-part whose most recent implementation
can be found on [0].


[0] https://patchwork.ozlabs.org/project/opensbi/cover/20221004164227.1381825-1-heiko@sntech.de
[1] https://lore.kernel.org/all/20220905111027.2463297-1-heiko@sntech.de/
[2] https://lore.kernel.org/r/20220727043829.151794-1-apatel@ventanamicro.com

Heiko Stuebner (2):
  RISC-V: Cache SBI vendor values
  drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
    C9xx cores

 arch/riscv/Kconfig.erratas           | 13 +++++++++++
 arch/riscv/errata/thead/errata.c     | 19 ++++++++++++++++
 arch/riscv/include/asm/errata_list.h | 16 ++++++++++++-
 arch/riscv/include/asm/sbi.h         |  5 ++++
 arch/riscv/kernel/cpu.c              | 30 +++++++++++++++++++++---
 drivers/perf/riscv_pmu_sbi.c         | 34 ++++++++++++++++++++--------
 6 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.35.1

