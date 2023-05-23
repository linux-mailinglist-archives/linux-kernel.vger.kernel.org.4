Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7170E7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbjEWVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbjEWVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2FFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E989F636B9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B26C433EF;
        Tue, 23 May 2023 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684878565;
        bh=LGDWZl7VfayJ4wOSBvlfkjYbnh3U4A89vday2/1A4L8=;
        h=From:Date:Subject:To:Cc:From;
        b=P1vZncXpWAGx2YLd+hW07n9qlfzAi0aCJ27jrlJBybR1nDfYROVI6V8wP9KBJQWtb
         kPGOdasyP/aahSKAV1r1x6y1ZYDbiBt5If9jqr7MqgFGCN64QnnZoYRA/4UdHQ51Dm
         k7DVrl8hSP1CmT8yenL0iDKls3lLavvRvmHVjvS9EoAcuIgTD7FKjNX4JrrjLpXhQy
         rhRpO6mGLL/2n7OJAKaYwPIstg/CtHqtM3pldM1oMYyi1uu8R8zvV2kCKF+vaMrmTf
         N2W6dsFXJFuaTNfsl48ir3nqHIqk9NCvfavGpGjO+PzUqCaSyYjtLNr0XBYXYpemJ+
         DQ1ekXGxN9kaQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 22:49:00 +0100
Subject: [PATCH] arm64/cpufeature: Use helper for ECV CNTPOFF cpufeature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230523-arm64-ecv-helper-v1-1-506dfb5fb199@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMs0bWQC/x2NwQrCMBAFf6Xs2YU0tUH9FfGQxKdZsLHsShFK/
 93U4zAMs5JBBUaXbiXFIibv2qA/dJRLrE+w3BuTd35wox846hSOjLxwwWuGcu5DGMPZpVNy1LI
 UDZw01lz2cIr2ge5iVjzk+39db9v2A1iMcQh7AAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LGDWZl7VfayJ4wOSBvlfkjYbnh3U4A89vday2/1A4L8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbTTjthSD8Kjd4b+swsioy3k0yuuRKVj3qBKZ2ShW
 NSPaNZaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG004wAKCRAk1otyXVSH0DhPB/
 9/2jokQ6J4kiTRSJEMce6K/pDsZTB5qc7t3V+A+JGUod5sWbuBKpcEqXEVo6HBdBxRdWcrmr8Rbd0z
 M4mrE3sOr0cOknalyWiIgD2K8gMRN+EvtR3yfgWoyiXWJlfXzA1alO1OXpFOZGzEgfxvHPR0aCtrSJ
 y1fxVjOeVD4irS8c0lPU+uWhlehPZWcyPSu/xTNuEXMcKOdvpUqlsxn0nN015qbKfZYqwGMLiKKQNv
 VwObMWcV0mXTOTDgqf5NnO92t/XIoDFnygijeCbX2PhDnZwrCyFvTKijTkAgsL56M1CrWkENGGcEcr
 OG/PPy7qWPPESzpzSDgUXizHVM1sJp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added support for ECV CNTPOFF open codes the recently added
helper ARM64_CPUID_FIELDS(), make use of the helper.  No functional
change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7d7128c65161..27326f35b646 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2235,11 +2235,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_ECV_CNTPOFF,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64MMFR0_EL1,
-		.field_pos = ID_AA64MMFR0_EL1_ECV_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64MMFR0_EL1_ECV_CNTPOFF,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, ECV, CNTPOFF)
 	},
 #ifdef CONFIG_ARM64_PAN
 	{

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230523-arm64-ecv-helper-c1665690b8b0

Best regards,
-- 
Mark Brown <broonie@kernel.org>

