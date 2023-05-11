Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3506FEB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbjEKGF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjEKGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E0138
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DE4641DF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F31C4339E;
        Thu, 11 May 2023 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683785123;
        bh=S6YXxPKCuvrJZSp4g1qPNxn4rPj71MCJ5tyMyEU+OlU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=e/i4W5vs2CAii8f/zTNZdR9jd5TkkvT72VO+ABbiYZ69muhhl9n1IoWczRsgbMsnu
         Y8sEs9B//o41QAfRWx2R00NpgRgWw9rXWqFVogFoO00l8DrXZc8Hel50okINXt71lm
         yWVMhmo+UX+UKte4QEhpHk3zKbtdm6May+HxLMr6oR3oDaFGg1lbnmmeN2E9AyDg2c
         iM0MKzl0wQImKr+04xkgNZcvwAEUW9rFdElToNGuGF04EGUqBiRoJqlxwScGEZJGxF
         K9MGpRkRzgX2bzKTaul4HWpGdMHFIILwjEITvOz9M1MxL1ovzJE+RTYFk93tdPpDfI
         gsiBlK9Cqs7jA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 11 May 2023 15:05:14 +0900
Subject: [PATCH v3 1/2] arm64/esr: Use GENMASK() for the ISS mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-arm64-iss2-dabt-decode-v3-1-c1fa503e503a@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S6YXxPKCuvrJZSp4g1qPNxn4rPj71MCJ5tyMyEU+OlU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkXIWdH/PbDVh1N7DNVOWDj/16UI+DtsYg10Tld
 TZATiVKPTmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFyFnQAKCRAk1otyXVSH
 0IyXB/wLKiMIokWbIaB4IwKWUb1ivlQnriSR6ezLjsBfcQ/4D+KQeL0EIPAhjcYNQfbF+zpe4lA
 SmKqwNhmvSUllKfZ/jsmRlBW32vCH0qYK4DHAKhW1SnxeL1QJkjCEs5T0m8YYJhdV2Ts6q0wulR
 s7U8mkXal4wycJHbibsMYY5o+i3yv7SbHOp6BtuXmyoC3e9Udx6dGAVAANhQok5sfeSxk0J9Bro
 bXx5NMuuaAtBNGnbDGHrsmrRYod+JnblQQg8oDu4z2z8jDFtx94VqlwAFysSUTPu7sTdsu+ZZoQ
 /c4zTHqmG6INGrPdPlYhyt5ckZWkxdpokY+OZ064NMLopkol
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

