Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0059664C99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjAJTfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjAJTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:35:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C465567B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23562B81982
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FBBC433D2;
        Tue, 10 Jan 2023 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673379325;
        bh=o9N3woG4Qs6mBhxJSHGOuHM5b3tLy/QKtrC0KOCKr3M=;
        h=From:Date:Subject:To:Cc:From;
        b=F/yBSqhYYA8BI6u8oX0BBZuvO8f0f2mC1viuKB8z9jQDFZq5DXjF7kZ6Mgk0Epj04
         RGVhdDz26Pmvx6kVA71lZYh0L4oZhZRGAR2fC/h5TckbvxGNFYm+sta4fhikZGZClp
         +Qc92dCZmD4CqSBQcNvPArGFwAJsG9XplD1tVQGNj5P38k5sYz4VR98CgCxin4PFQn
         ZDJVjKLgt8XCtJRBWdWEDv36FM4w9ZAlhBBbgITTUCBVhkm0kC6ZVL1puoicKcYROc
         CYLfT8Z5AAnsw3Eulzsnut076UWADaXvRYtG9n64pqDVv07KRYlpY5jUDcgSR1rO/c
         jTlbyw696hREA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 10 Jan 2023 19:34:36 +0000
Subject: [PATCH] arm64/sme: Optimise SME exit on syscall entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-arm64-sme-syscall-smstop-v1-1-ac94235fd810@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMy9vWMC/x2NSwrDMAxErxK0rsB2jCm9SunCdpRGNLGDVPoh5
 O51ups38GY2UBImhUu3gdCLlWtpYE8d5CmWOyEPjcEZ1xtrDUZZgkddCPWrOc5zy/qsK/rBut6H
 MaRwhqanqIRJYsnTMfCu8jjqVWjkz//xetv3H0QbQZGBAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o9N3woG4Qs6mBhxJSHGOuHM5b3tLy/QKtrC0KOCKr3M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvb37ZoUaZ4FQvydDgtwXGdHTvjRqqA/GuyjoxYeM
 6ihdipuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY729+wAKCRAk1otyXVSH0P+RB/
 oDRJ0uqLTp3uvung4cQ7A83NmXso2E+GOMVXh2Y69QHX0qEJ37nZlhOMXbEVPSKHlbjWMf9CkJscwA
 MAJsJCSDOVWGr5n2+FqO8MvNrjRu4wpYI+G0vrbbWDhGq207ILFN10+g+J19S0XKlte2Z1zLWfgFDd
 825FDM3ujKxL5D0D/Ffk8/fl0xEeoguzl21RVdv5Xr+OHQNInaAkiy5qySEnUh24+FG6pMAl+DwGJg
 KFfnfeRUM5bap/S+z9JTkNxe0Zk3VHpCVI/k0YOYLzqpRYZE+CoOxL0x/SCUnp9kgXVNoApvf4ulwd
 +JzigFtiW5F7yDjHqvARHhQG+Np1CX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our ABI says that we exit streaming mode on syscall entry. Currently we
check if we are in streaming mode before doing this but since we have a
SMSTOP SM instruction which will clear SVCR.SM in a single atomic operation
we can save ourselves the read of the system register and check of the flag
and just unconditionally do the SMSTOP SM. If we are not in streaming mode
it results in a noop change to SVCR, if we are in streaming mode we will
exit as desired.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/syscall.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index a5de47e3df2b..da84cf855c44 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -173,12 +173,8 @@ static inline void fp_user_discard(void)
 	 * register state to track, if this changes the KVM code will
 	 * need updating.
 	 */
-	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
-		u64 svcr = read_sysreg_s(SYS_SVCR);
-
-		if (svcr & SVCR_SM_MASK)
-			sme_smstop_sm();
-	}
+	if (system_supports_sme())
+		sme_smstop_sm();
 
 	if (!system_supports_sve())
 		return;

---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230110-arm64-sme-syscall-smstop-4d12346f6b68

Best regards,
-- 
Mark Brown <broonie@kernel.org>
