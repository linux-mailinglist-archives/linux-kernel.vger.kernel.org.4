Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893406FEB89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjEKGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEKGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B2184
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B053D64AEB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE1C433EF;
        Thu, 11 May 2023 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683785121;
        bh=GuYjeo//7p/ec0S34Gs3dF2pDfOrQTrtaV3XxSG4X2w=;
        h=From:Subject:Date:To:Cc:From;
        b=pCa5XPoCE/aDASwJ/8pJ8aNq+scllgoFhXsgXgImfyn4y9osy1pcuOzOoE5PWsUzO
         gmkMnVm75+mnWoXoxzRUywnhbl0Q8Sg48xojaOmxTxuvRd0Zfwd87yRCdt2ijSMljA
         gOThui2EtQnuc3xE+5nKiH13QgWqUkt3PEbuFJOMKefjZL7ItVeY0yUNMwkz/wCZkP
         6iFsruBDkIfLgMDzWJ8d+EIPjuspWpsC/EQ1XtD/476yWO1hnw8Nyx3aSnC+xoQ7bD
         jtIXM31mnOSKvgUQYHjjtOfmnFEPWGi/lfJ8lI9KHIGjJILevMQXRVmDo5pshIueYm
         hwzPDr0bTlhfg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] arm64: Add decode of ISS2 to data abort reports
Date:   Thu, 11 May 2023 15:05:13 +0900
Message-Id: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmFXGQC/42Nyw6CMBBFf4V07Rj6sIAr/8O46GOEBqVmSlBD+
 HcLO1e6PDe558wsIQVM7FjMjHAKKcQhg9wVzHVmaBGCz8xEKWSpeAWG7lpBSEmAN3YEjy56BHS
 NVdo1tWk4y2drEoIlM7huvT8j9ev8ILyG19Y7XzJ3IY2R3lt+4uv6szRxKEFwWduD1nVVVacea
 cDbPlLLVuck/vOI7KkVcseVll6WX55lWT7OiKrFHAEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GuYjeo//7p/ec0S34Gs3dF2pDfOrQTrtaV3XxSG4X2w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkXIWcWXeszBHILpQYFxPFnHWtvp7iuCa2hxyXm
 +JQfNNq1RaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFyFnAAKCRAk1otyXVSH
 0D27CACBYZUm8aeC4ZNw8JVYrhGbmkdd/d6Kdtiut+J//6iMi3lJfTfYbI43ZTl6iIaebdijz13
 N2hiv9dVJvShqamzzR4nNkXX17I+XzfJuvtOzRqGcb5oxqFuwgUAN2Wnfu+4mRvNJmOdSVhjjG9
 lcpe5aae7m0FUXpxuXUgKTG2AhS7UolT4XPas0RBD4DC0iQ3DmcowDzV9wrKFiATGpk9Vqf7QaA
 64Q4l4GjnOjWp/3XpJfdgTdPcpgFBPPRKmjSbHW+E7uPwiz1taUg2j9Co7o98FwhsZQ24L21IdW
 Djmzijoclq0LmKwT76F1qXmU42IuJsnYOJnsE5E/zb4W4Sid
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

We provide fairly detailed decode of ESR for data aborts but do not
currently cover the information reported in ISS2 which has had quite a
bit of additional information added to it by recent architecture
extensions.  Add decode for this information to aid in debugging, for
completeness including features we don't actually use yet.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Correct ISS->ISS2 typo.
- Link to v2: https://lore.kernel.org/r/20230417-arm64-iss2-dabt-decode-v2-0-84e1c1463d30@kernel.org

Changes in v2:
- Rebase onto v6.4-rc1.
- Link to v1: https://lore.kernel.org/r/20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org

---
Mark Brown (2):
      arm64/esr: Use GENMASK() for the ISS mask
      arm64/esr: Add decode of ISS2 to data abort reporting

 arch/arm64/include/asm/esr.h | 19 ++++++++++++++++++-
 arch/arm64/mm/fault.c        | 17 ++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230417-arm64-iss2-dabt-decode-ec9b46c98a91

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>

