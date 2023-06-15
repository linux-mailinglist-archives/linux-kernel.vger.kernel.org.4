Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F39731737
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjFOLkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344111AbjFOLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7983A86;
        Thu, 15 Jun 2023 04:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E08963680;
        Thu, 15 Jun 2023 11:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5216C433C0;
        Thu, 15 Jun 2023 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829110;
        bh=SNeHZdA+/GRdBVUx2LtBVyhcwEvjjnPlzJqkO+RKOBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbGd/qAax8BpJ3XcNm20PgFyVkK90uHkbcuIfbasBpqWd30sKERFTOnPXLSAsnjeH
         +8F1PAnotEPuP95vBgPNJ0enfg+OfQwmEkGJXTc+GAsau8u5vfQZXaer4RsZDOGyNY
         DouncqzGjWDCeXK6yffOWQdQpKl7f8RvHYhtEquRUrw+ITCRMfsxxFPAZixEw7XgKP
         /hxFegEoGkYlFTsUJIr2lSpIvUVqfILpgDAEOrd+EOqZpFzCYmuixarPXCywru2GNM
         k2DAkQSIA5HbfdAqE8eioNJcqAmbwVqGXxRJ6rPC24yyvt+im4nMtziv+tXPRzzuUQ
         Aqh6apAe1aPdg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sasha Levin <sashal@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, james.morse@arm.com,
        kristina.martsenko@arm.com, robh@kernel.org,
        jintack.lim@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 06/16] arm64: Add missing Set/Way CMO encodings
Date:   Thu, 15 Jun 2023 07:38:06 -0400
Message-Id: <20230615113816.649135-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
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
index 7d301700d1a93..3a448ab0924b3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -111,8 +111,14 @@
 #define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 /*
  * Automatically generated definitions for system registers, the
-- 
2.39.2

