Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61C6FB201
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjEHNuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjEHNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA613E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C173762DA5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097CEC4339E;
        Mon,  8 May 2023 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683553816;
        bh=S6YXxPKCuvrJZSp4g1qPNxn4rPj71MCJ5tyMyEU+OlU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AxFw8OEj80BxtobPqKOSRqxzOa2KOVM4bmUYqapkWP/5Z0mbQPZF6jl7z5oIQ/RVn
         tm0Vaoxtuo3CnA/lXRJ0mU5NV71LHti3oRtq13lAEs7AX8wfzit28w8psb/edWiC4h
         vCAraZlJ9NvGPW3g18LgggXDdSxWGG3mIjiwpDEua6u9le2iwW1j8wIX92autH64vp
         6XIWeYrsYIk/l6kxEeYI7CLNJ+pAX7/GjAsL0AiHH95Jgy7W9l0th0IISY6AL9Ceo5
         Sl5Fst58gM2c3yoFTyq2VFaZMTfSfrDF6OLTmIpFs1kNNL9gjtF7sfV7eEXDC5SJX0
         4pmMDgiUyY7Zw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 08 May 2023 22:50:09 +0900
Subject: [PATCH v2 1/2] arm64/esr: Use GENMASK() for the ISS mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-arm64-iss2-dabt-decode-v2-1-84e1c1463d30@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v2-0-84e1c1463d30@kernel.org>
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v2-0-84e1c1463d30@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S6YXxPKCuvrJZSp4g1qPNxn4rPj71MCJ5tyMyEU+OlU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkWP4TjeaZvYFxL/h7LFXHcQN+H9RqTzwFF/rZQ
 rnnnpqD08+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFj+EwAKCRAk1otyXVSH
 0PxYB/9AMx39UNxBpJUd7O4kCK/+WZzRmWjhtg+cc3RXb7HRBEyyzmepXpUItnArA8HUZ5j8TrI
 uVzh9Qq8purAor+xfb4+iB/ajujBTpx4Mj/RLF7BhQIXxZ0yw+8Ltj40CwBAVv6YzCN5R9zG9Qr
 F8fFB4UsItC4J8zzBDyI7Sz9Ky3tkoOhs+GGHNo9a7LWf4gpCS2+B05Az+a3FuThfehe2ORnTA0
 ME/D8PTFJSYPG5m8dZdOHa5muZBh8QJOlQdkEeDSCTMU6M6sCzqf85/UIwniFeCSd4gukiw3eMO
 VEqUGBhyoQbsrhMSxynf+HrRuUgPRVM0QdA2Dkuv8zO+CcJB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We express the mask for ESR_ELx.ISS in a non-standard manner, not using
the standard helpers. In preparation for adding decode for ISS2 convert to
use GENMASK(). No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 8487aec9b658..0bd879007168 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -75,7 +75,7 @@
 
 #define ESR_ELx_IL_SHIFT	(25)
 #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
-#define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
+#define ESR_ELx_ISS_MASK	(GENMASK(24, 0))
 #define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
 
 /* ISS field definitions shared by different classes */

-- 
2.39.2

