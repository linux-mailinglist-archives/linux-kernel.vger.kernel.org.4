Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB46F749F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEDTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjEDTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AA9005;
        Thu,  4 May 2023 12:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900B6637C2;
        Thu,  4 May 2023 19:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B688DC433D2;
        Thu,  4 May 2023 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229603;
        bh=3cm8SZFDsBnS6NwwSOzv0TR1ysXO8bAgKi0mu4OgyUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C09sAemq0NP2bsM7Mj3E7oi82KKroOPSOyql7ycm2kn3s0/0MX/Z7GIJ/XjENxqsN
         htNtH9/Ve3+jigOLttWz5EdF4dXad8JiHCEfzhel5nP7L/fA8ui9WbKa0+Tmzokd1I
         3WznFySC+olHbqyntL7LFdBBA0HckzgZV5cVYHpwSK/bdjN4sf1jCH3yJd58wiDucG
         kb/ONgaBsnbBQ6am8lHvc6dTnhCe2qzvnbP71Cc+y0JK70PC2q7xyQD5QL2a4fyKDM
         PztBDKCKeovGfNmkQ81n+FBBBbbrvDwga+x0lmGJm1R/TeuVUmsGhVzlBjZXewym4a
         XWgLU7/ikV8ZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Sasha Levin <sashal@kernel.org>, tsbogend@alpha.franken.de,
        ast@kernel.org, andrii@kernel.org, paulburton@kernel.org,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/49] bpf, mips: Implement DADDI workarounds for JIT
Date:   Thu,  4 May 2023 15:45:42 -0400
Message-Id: <20230504194626.3807438-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit bbefef2f07080cd502a93cb1c529e1c8a6c4ac8e ]

For DADDI errata we just workaround by disable immediate operation
for BPF_ADD / BPF_SUB to avoid generation of DADDIU.

All other use cases in JIT won't cause overflow thus they are all safe.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Link: https://lore.kernel.org/bpf/20230228113305.83751-2-jiaxun.yang@flygoat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig            | 1 -
 arch/mips/net/bpf_jit_comp.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b26b77673c2cc..44763be3bd125 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -64,7 +64,6 @@ config MIPS
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
-				!CPU_DADDI_WORKAROUNDS && \
 				!CPU_R4000_WORKAROUNDS && \
 				!CPU_R4400_WORKAROUNDS
 	select HAVE_EXIT_THREAD
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index b17130d510d49..a40d926b65139 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -218,9 +218,13 @@ bool valid_alu_i(u8 op, s32 imm)
 		/* All legal eBPF values are valid */
 		return true;
 	case BPF_ADD:
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
 		/* imm must be 16 bits */
 		return imm >= -0x8000 && imm <= 0x7fff;
 	case BPF_SUB:
+		if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
+			return false;
 		/* -imm must be 16 bits */
 		return imm >= -0x7fff && imm <= 0x8000;
 	case BPF_AND:
-- 
2.39.2

