Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C67316F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjFOLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbjFOLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6BA30CF;
        Thu, 15 Jun 2023 04:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D616391A;
        Thu, 15 Jun 2023 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9D5C433C8;
        Thu, 15 Jun 2023 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829069;
        bh=PdmQ4uG6f4t6aNXe/LOf7pwuNswE/s6OIEpzySX2Aqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6/RqkqeD89mPXJH5rC3+r0m1jpR7P7y4dsKk2yCE9/jV3cFxuZh4/9Niyk6KWzrM
         SyfuvkEWnlUpf0SRV6lOkUK0JnYb9M1hiRpKCjo9c7z6wzSs29l517HcGdpBbpXrhY
         K+MG4oJivlt3kIdHVFRmcCF5Cou5MF/WqUYY9DtK0pnAvda0ohOJIO/KLG+L8ZxyZa
         JGtU6ICQ6GSCmEuKEqeAu28SOPUxcxeh9QNkXeUdSiOdOzXXBLIhqP79OsxhD7vmgv
         8eYjFF4BOU8knHI5ow+e+/eSX5Ew1GWINCyzcPHWKvVt0gO++WDQ82qJqc2PbpEEit
         KaL/VAkp/+trw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sasha Levin <sashal@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, james.morse@arm.com,
        kristina.martsenko@arm.com, robh@kernel.org,
        jintack.lim@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 08/19] arm64: Add missing Set/Way CMO encodings
Date:   Thu, 15 Jun 2023 07:37:08 -0400
Message-Id: <20230615113719.648862-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113719.648862-1-sashal@kernel.org>
References: <20230615113719.648862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
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
index 9e3ecba3c4e67..d4a85c1db2e2a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -115,8 +115,14 @@
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

