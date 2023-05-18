Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F83708816
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjERS5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC81702;
        Thu, 18 May 2023 11:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6270164FCD;
        Thu, 18 May 2023 18:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03542C4331E;
        Thu, 18 May 2023 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436227;
        bh=Hxt77XTd4sJ4iSsW4a+tGjggeRmSDhhjr46ffLnz1is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozM0GDlhAZV8HvMUYO9tXWmKQKFJ9BVbHZS3eBKkSx/LEFwoXPchpJCjWLpb4zp5K
         exANsNP2OcsiyOaErwuldCtwi97q3hKqXFUXC5e9rXiiX/u5WFwp9KD2rc0tTv6eWP
         o9GzOQYbCiH2x4EGtMDkWy0hd1hUMHiI9bDqfGu2E5w9njF9Q90a+FpJED1rUXLWGx
         ICt8X8CP4RQxC00MmpdH/7bWShTEqX2d9XcEJJ2zo267E7fJgybAKWTsLKNhcmyEXq
         RFPVyuLF7YlNMHb7rB7hjWivqCR5d/pMnh9ES2G0fMqXPQw9ikRg9PzpGwWVklQwak
         jh/dLVW4bHlug==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 5/9] riscv: Add the T-HEAD SoC family Kconfig option
Date:   Fri, 19 May 2023 02:45:37 +0800
Message-Id: <20230518184541.2627-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first SoC in the T-HEAD series is TH1520, containing quad T-HEAD
C910 cores.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1cf69f958f10..ce10a38dff37 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -41,6 +41,12 @@ config ARCH_SUNXI
 	  This enables support for Allwinner sun20i platform hardware,
 	  including boards based on the D1 and D1s SoCs.
 
+config ARCH_THEAD
+	bool "T-HEAD RISC-V SoCs"
+	select ERRATA_THEAD
+	help
+	  This enables support for the RISC-V based T-HEAD SoCs.
+
 config ARCH_VIRT
 	def_bool SOC_VIRT
 
-- 
2.40.0

