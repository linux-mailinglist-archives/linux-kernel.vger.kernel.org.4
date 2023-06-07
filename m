Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130EB726D86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjFGUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFGUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9D2113
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 284816463E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D39AC433EF;
        Wed,  7 Jun 2023 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170550;
        bh=5aQZkv7b76uNRIEEdQU8uQNP36af9VapveubHqYUaFQ=;
        h=From:Date:Subject:To:Cc:From;
        b=NOTgZAD9znY+E34eMdNxRrYZ9WFsjp1bDtbNZVPoEftzkVH/LzVi1T42kRaawir7c
         NKA/2AjGOyWhxbmJzrbHGjdA7pSvm7+lfpg16pLt9bsfH4AZkHLwo5+8JqlFNyuJRh
         7HAjjVnt3E4qFM034doh6Aq/Qy6uqlO20o3YNdW2Q4qpoQj1twc3ZaivgDDRxB8WMW
         +JguAl1+rO+7mT7HLUowSatyk5ow8CegDMLYVnOnQNRGZZK8Fay5SM+68iaSYZhQHf
         MywLNQWEq6NYWrVPwT0VW65dcA5Z7zjIACREG6zVEGXlqw1NGRSoE2aaou8xtKX+tr
         AKotEd4N2Mqvg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 07 Jun 2023 21:30:51 +0100
Subject: [PATCH] arm64/fpsimd: Exit streaming mode when flushing tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPvogGQC/x2N0QrCMAwAf2Xk2UCdoxV/RXxIY2aD2kmCUxj7d
 zsf7+C4BVxMxeHULWAyq+tUG+x3HXChehPUa2PoQ38IMSQke8YBx8fbC/rMhkNiTpGOnDNDyzK
 5YDaqXLbwM9l90y+TUb//0/myrj82jPm5eQAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5aQZkv7b76uNRIEEdQU8uQNP36af9VapveubHqYUaFQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkgOu0OWZtXqQLnmaga8qWcEKH43zY/MuFSc6R2FTB
 QHARcI6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIDrtAAKCRAk1otyXVSH0F81B/
 0RF7RycQjSNI9WUnqO2R7nmzQwDLgtpGzQr5kXvGiRcOELDrerPK8ajLa+QDvaqgla82fv5d5Khccm
 b9iZhy0q9RE35vZlqXELzI1IQ1PVvL60gNaE42C3AXZndnQdoWxUN9PNoilPLdDP+W6tmE2tlxFgfy
 SW5+K61o5rJr8RlwuuOBIRGZb4BKWr0h0WEDOgml9yRh+q/jUaBQrW8iUa+e9OFqJKFdsQG6+GuUGi
 DFygUmJwPf08bJpxFYhKhMAAhEJHyeoK2+K8o+OOUpX1NjwbLBs/lU3QVZbpCxm7TmyOjIMh7JKUkX
 nvYQXSb30SRsVSaphjQPmpBN0BcDch
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

Ensure there is no path where we might attempt to save SME state after we
flush a task by updating the SVCR register state as well as updating our
in memory state. I haven't seen a specific case where this is happening or
seen a path where it might happen but for the cost of a single low overhead
instruction it seems sensible to close the potential gap.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2fbafa5cc7ac..1627e0efe39a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1649,6 +1649,7 @@ void fpsimd_flush_thread(void)
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
 		current->thread.svcr = 0;
+		sme_smstop_sm();
 	}
 
 	current->thread.fp_type = FP_STATE_FPSIMD;

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230607-arm64-flush-svcr-47cc76a8cbbc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

