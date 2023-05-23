Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1870E4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbjEWSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjEWSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4F91
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2EFA62DA4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE11DC433EF;
        Tue, 23 May 2023 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866981;
        bh=85tRnbat52B6IBzDM3UnXuQ+f5nD406kWabSowIdwAA=;
        h=From:Subject:Date:To:Cc:From;
        b=IIPoge2fHVVufSr0gZ06zxpDIjv5YJsn/I4U/QOD/sRi2fFXZfxw1ILXz8gsvOxR+
         qtcQ83SV+TvZNAn8yCUumCfnTEAds7wwR9frdOTG8BTmKujcORuKA1BchglIZONeED
         aEp2nMnKDfFgTpEkVaUHNku+7dXRNIoszP6stn4ao2F2DgoTMgI/pGAJLhMjD86rJj
         iFvoDcCgMMgo9diygJKiycelYfhilVwiGCVEUt6OMmpqpAtQiaWQ/EAgwC6rcz/Jaa
         vOZ+hyQoIqjV+ZiV14CMiZmf+BhEb3CbAXVxKwxnFrvbH9jdGlIKt13pGVMuLTex8M
         q65LCJo4+yuPg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/7] b4/sysreg: More conversions to automatic generation
Date:   Tue, 23 May 2023 19:35:57 +0100
Message-Id: <20230419-arm64-syreg-gen-v2-0-e0064336e2dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI0HbWQC/3WNQQ6CMBAAv0L27BoopFJP/sNwaMtSGrQ1W4MSw
 t8t3D3OJJNZIRF7SnAtVmCaffIxZBCnAuyogyP0fWYQpajLplKo+SkbTAuTQ0cBjdC6VdK0epC
 QK6MToWEd7Lh3n8jTrl9Mg/8eo3uXefTpHXk5vnO12/+LucISVS1tf5HKGkW3iTjQ4xzZQbdt2
 w8w/8I3xgAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Shaoqin Huang <shahuang@redhat.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=broonie@kernel.org;
 h=from:subject:message-id; bh=85tRnbat52B6IBzDM3UnXuQ+f5nD406kWabSowIdwAA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQecGcBbJzib3zy+IKJGV2eSsVzML4rJJNXF43EC
 G1cCFWKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0HnAAKCRAk1otyXVSH0Os0B/
 9fmX3RhgkJNbVZLHbWMVUPDhvvnbvfMGjXc16xfsyxt8SbWe83plgVOjZT/ePDk3gAN6vHANxo4C/E
 MzWdzb6THmrYnTnamsSaWYg9wPsGoXuYxV13+BDYbpl+lxs/5MuDM4JQSQAH1jNawG4W2syNZhjFBj
 upS94YjvTmhhF6iZR29D8JwWGJ10BYEH9D1zThdIonHIUhSa1SCfEdr9ak265KvVXnT0d8bSKUW8Lj
 N0b79LQw77XVYUlxejM/+SFIPtWQU+1OcxiyYQmekFXMSh6RcFL5tLF491NYDWTfkGlyVKjmIp+Sv6
 A2MDQR4AZ0wHaqW8WIbTwgSBiYWvwg
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

Continue working through the register defintions, converting them to
automatic generation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Also convert OSECCR_EL1, OSDTRRX_EL1 and OSDTRTX_EL1 instead of
  dropping them.
- Link to v1: https://lore.kernel.org/r/20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org

---
Mark Brown (7):
      arm64/sysreg: Convert MDCCINT_EL1 to automatic register generation
      arm64/sysreg: Convert MDSCR_EL1 to automatic register generation
      arm64/sysreg: Standardise naming of bitfield constants in OSL[AS]R_EL1
      arm64/sysreg: Convert OSLAR_EL1 to automatic generation
      arm64/sysreg: Convert OSDTRRX_EL1 to automatic generation
      arm64/sysreg: Convert OSDTRTX_EL1 to automatic generation
      arm64/sysreg: Convert OSECCR_EL1 to automatic generation

 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/sysreg.h   | 16 +++---------
 arch/arm64/kvm/sys_regs.c         | 10 +++----
 arch/arm64/tools/sysreg           | 55 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 18 deletions(-)
---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230419-arm64-syreg-gen-b2aa896b8af6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

