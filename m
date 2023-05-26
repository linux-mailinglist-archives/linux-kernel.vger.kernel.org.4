Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D25712B79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbjEZRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbjEZRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006171B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57227650CE
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C85C43446;
        Fri, 26 May 2023 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685121072;
        bh=N+SE5apBHJdpc4kl5LVsR83pASoe466MUuKqmk4qCmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dy9f79qlz416EP/3kBixmbxtEXL1AKGqFraAcnWqIMmty/VaLIObcEn4i3SO2uOV5
         QkhwCRgI/Oay6bicOxByimULBFgUFw4j6xneFP+fsk11XbUZMlDS3mNrTjpUoqqqTz
         DPwGGmjWeRBgtFzQ9ouzXuhtXZ9Y46W8C6ObVWRrOdxmxoX7UOcfV9J0b5bErkxuxC
         ppNttvMssdEoz7kRbhRyYN6bZlp+UYB42+BkQAbnz1U92W3qY73ZMyiDf8+iCahGwg
         LLej5KAh21kHUwffCZrId0f8ZlWjsdXRsPwBaepbd0kjN2eSX6TmWWJEi/Am3Jq5P5
         BklHbdj0qYrUw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/6] riscv: errata: thead: only set cbom size & noncoherent during boot
Date:   Sat, 27 May 2023 00:59:53 +0800
Message-Id: <20230526165958.908-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526165958.908-1-jszhang@kernel.org>
References: <20230526165958.908-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CBOM size and whether the HW is noncoherent is known and
determined during booting and won't change after that.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/thead/errata.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index c259dc925ec1..be84b14f0118 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -45,8 +45,11 @@ static bool errata_probe_cmo(unsigned int stage,
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return false;
 
-	riscv_cbom_block_size = L1_CACHE_BYTES;
-	riscv_noncoherent_supported();
+	if (stage == RISCV_ALTERNATIVES_BOOT) {
+		riscv_cbom_block_size = L1_CACHE_BYTES;
+		riscv_noncoherent_supported();
+	}
+
 	return true;
 }
 
-- 
2.40.1

