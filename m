Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89515F9EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJJM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJJM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:27:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9E65258
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:27:40 -0700 (PDT)
Received: from p5b1274fa.dip0.t-ipconnect.de ([91.18.116.250] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ohrsW-0001kg-Od; Mon, 10 Oct 2022 14:27:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor.Dooley@microchip.com, ajones@ventanamicro.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 0/2] riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Mon, 10 Oct 2022 14:27:24 +0200
Message-Id: <20221010122726.2405153-1-heiko@sntech.de>
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

Heiko Stuebner (2):
  RISC-V: Cache SBI vendor values
  drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
    C9xx cores

 arch/riscv/Kconfig.erratas           | 13 +++++++++++
 arch/riscv/errata/thead/errata.c     | 19 ++++++++++++++++
 arch/riscv/include/asm/errata_list.h | 16 +++++++++++++-
 arch/riscv/kernel/sbi.c              | 30 ++++++++++++++++++++++---
 drivers/perf/riscv_pmu_sbi.c         | 33 +++++++++++++++++++---------
 5 files changed, 97 insertions(+), 14 deletions(-)

-- 
2.35.1

