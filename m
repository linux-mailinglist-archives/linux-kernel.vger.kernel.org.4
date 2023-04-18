Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB516E66B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjDROIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDROIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A883FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0315C628A1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF856C4339E;
        Tue, 18 Apr 2023 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681826921;
        bh=xpHsOrpkWRpyNCpBAlr/smcDbgm9ns3SuGHZf7AJY+k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bsK6f7SYNFolXhScpxxmBRMAXE1fSceM8+DAksbKK7J3dYaKV6Y1fWyTO+PFnis/l
         5JqdgF33ililjaH5lv6Rh/P0TSBfqKaFoovN3CvnW+OdhpgST1wNH94hkmAHqecbiN
         YUUYAtuG1hW/3bny2P6d4TMV6VQWahUWSs3dFtN22Dy93Ahr39zuqV+oCfRlajIQeE
         aN0YzXLLIH1VTox8efH9ucZKEK57y1w1jdOjrHizy/tYfmYQA0cwuG0xn/gBgBoaQb
         H56mMEV00ZvbFlXQ3NGgrdafOOpvBWGx/ljeeJKPQqG3QYolxF0OWvo7PBKsRBmRUd
         jRjTnocTPrl3Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Apr 2023 14:57:31 +0100
Subject: [PATCH 1/2] arm64/esr: Use GENMASK() for the ISS mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-arm64-iss2-dabt-decode-v1-1-2138b5668777@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xpHsOrpkWRpyNCpBAlr/smcDbgm9ns3SuGHZf7AJY+k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkPqRkeS7UOEnFRIgdAZNupiulQ4MNR2QjZKhO9kVX
 HG9SbvuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZD6kZAAKCRAk1otyXVSH0FhSB/
 9qsI6sABTBumYfQvPtyRsaAmGR4YOv80PLiLvQ8Pya6vJCaGnPe92RvF6fsegVD10YrZBoQi/GMrWC
 1gHFxB/bu8Y1hJeVCBEVUAw4BYb/XVENzzAHHCl5hjC6GIYMpAfmpvUL6RQr8febtdOkbXwFUvhon+
 DwoWg/MEJ+vkPBl8XTXeaN9Gqbi16OhBBncwZHJdZQt0mg3IcGz9hMf75kk6tfGm9iAUJ7t/t/vQsN
 trUCSltAjO8tNQRmG/ZYqxZMoW7TBHz6D9of8foVn3iSZrNzm763DPumdBIrxoI/iOqwau1LSnBBEi
 4wtNIV2CjX5qD8/qUCaGxL8m6P3X5U
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
2.30.2

