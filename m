Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77657317AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjFOLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbjFOLnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471323AAD;
        Thu, 15 Jun 2023 04:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF5761222;
        Thu, 15 Jun 2023 11:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B68EC433C9;
        Thu, 15 Jun 2023 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829208;
        bh=6B0uD/SW1mtEkKwc/TQ7EhqxppsghSjhM0fW+fwclHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfSw1BtbLsaV1TCT0qSyK7u4lA+ngfgeIHFy/zksTXJqMOptY+f3GfEqbmAU5JFHu
         0c6XlXoHt42fUS6w1VO4z0XCMTc04VG3n1GU5VWT2kRX2b3MGIDBwTFDRO18qzDHSd
         1PELpUbvBB0mYgwGB1pkaarlOytwHOAx3JwdoDiW/MT1wX1AZho2oUJoHP1u36R0tp
         Rs2L6dXTGSXHdXvW2ps5K9ejz6AhNWWPVMCBF4wny5aFqZDnZb1wWnt2KV5rT9Cciu
         CYaEKFqN31L3Ubp4N5IxLVHAM0Ou1rLE9RkE9gEwkSGXHrzXhq65Pxnjmdo1APejUT
         DpajPJW9wbnlQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sasha Levin <sashal@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, james.morse@arm.com,
        kristina.martsenko@arm.com, robh@kernel.org,
        jintack.lim@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 5/8] arm64: Add missing Set/Way CMO encodings
Date:   Thu, 15 Jun 2023 07:39:53 -0400
Message-Id: <20230615113956.649736-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113956.649736-1-sashal@kernel.org>
References: <20230615113956.649736-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.286
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 8d0f019e4c4f2ee2de81efd9bf1c27e9fb3c0460 ]

Add the missing Set/Way CMOs that apply to tagged memory.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20230515204601.1270428-2-maz@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e90cf51b87eca..22266c7e2cc1e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -98,8 +98,14 @@
 				       (!!x)<<8 | 0x1f)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
-- 
2.39.2

