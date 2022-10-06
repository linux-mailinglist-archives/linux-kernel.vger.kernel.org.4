Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C265F6192
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJFHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJFHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:17:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810A6555E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC0FDB82008
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7645EC433D6;
        Thu,  6 Oct 2022 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040673;
        bh=9fBsPwhvJZRdf+CU1/201DO08wpjks0kDIv6Vzm4XOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGhOU5BPOIuEr1AMhM3o0TySAQYnb7GXc/yNE8oGUnCzKZosX2CbfRpmOPVzPYaG8
         xg7ukolKlHrHpfr5BY8AIY8hyQRRKlWxPDyipTKxyxW4937An4t67v3yDNJzGaXBEF
         dqIj3O30QH4l+RH0XZJodmkxqZXW8m3ANj34sfkrH4qDEz0whtO5iCzHnUCJon9a3R
         QrNpZJRbTKTa8ItDbbyG+3Z+5NJYd7uwIxn4007RdIUDkMcn1qDAZqXsl89Jh7iyIQ
         iYeDoURySIx+mbLiveX1VEaJI1sIyrUUkwTNSMN6/ryEIs7WjbKX8qJ+r1TMwLHkvK
         0AOYxi88PT0qg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] riscv: cpufeature: detect RISCV_ALTERNATIVES_EARLY_BOOT earlier
Date:   Thu,  6 Oct 2022 15:08:12 +0800
Message-Id: <20221006070818.3616-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org>
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

Now, the riscv_cpufeature_patch_func() do nothing in the stage of
RISCV_ALTERNATIVES_EARLY_BOOT. We can move the detection of "early
boot" stage earlier.

In following patch, we will make riscv_cpufeature_patch_func() scans
all ISA extensions.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 03611b3ef45e..afa54635c180 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -307,6 +307,9 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 	struct alt_entry *alt;
 	u32 tmp;
 
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		return;
+
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != 0)
 			continue;
-- 
2.37.2

