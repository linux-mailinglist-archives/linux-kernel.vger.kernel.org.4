Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949C5F58EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiJERPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJEROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461E62E8;
        Wed,  5 Oct 2022 10:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DA47B81EC0;
        Wed,  5 Oct 2022 17:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719EFC4314D;
        Wed,  5 Oct 2022 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990075;
        bh=C2ehtRTdCg39q9bItLZO3vn1F8+p+kdTKZzHvn9xQoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHj9/vi3k9+ujlImWfuzvR5rivHk5YiEX2LRRnKzyUWhkjw2Vp83PAWPNp3i2mqp3
         cHQ/hwv+Cfpt5N6XjC79y/HgcwRMp/QK9L++iu8pBH2aQa3OZtwF13siUAuVx3COvz
         lCv3Mu+1oxFw3zPZ+2CCXbzeksH9JpaJZL8syYLmp/nXs5YdzbDEdbdtkbHBuzK49z
         FN4gWnfCdRru7PpZv6/n+/a8I+WF6JDbjROn5uwWXzlnZF+L3KKC8LtsrLOYaMN7Km
         w6UWJPtlqlFEaBnRtKJatFDQF59tsaUsztpSl1BBYdJDMX+jBH8DFKdYZk2j0bH9vj
         DkbYCTRO8QHdg==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 5/6] riscv: stop selecting SiFive clock and serial drivers directly
Date:   Wed,  5 Oct 2022 18:13:48 +0100
Message-Id: <20221005171348.167476-6-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005171348.167476-1-conor@kernel.org>
References: <20221005171348.167476-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The SiFive clock and serial drivers will now default to the value of
SOC_SIFIVE so there is no need to directly select their symbols
anymore.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 83f14afd4086..b6f4cfad159b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -8,10 +8,6 @@ config SOC_MICROCHIP_POLARFIRE
 
 config SOC_SIFIVE
 	bool "SiFive SoCs"
-	select SERIAL_SIFIVE if TTY
-	select SERIAL_SIFIVE_CONSOLE if TTY
-	select CLK_SIFIVE
-	select CLK_SIFIVE_PRCI
 	select SIFIVE_PLIC
 	select ERRATA_SIFIVE if !XIP_KERNEL
 	help
-- 
2.37.3

