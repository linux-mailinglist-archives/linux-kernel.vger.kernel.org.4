Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD770C32F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjEVQWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjEVQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F1BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9014161BD5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4C3C433EF;
        Mon, 22 May 2023 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684772569;
        bh=GYDycd6Y7G2pTvvcfFmXqSLvdBq4KcJ5xGdE+Xqfr9w=;
        h=From:Subject:Date:To:Cc:From;
        b=C34eJlWewiwiMKBBvdp5+3WGNKMnOJB0DfS3k+VRid+P2pevJJdnY9ZjQvfwY39A5
         yvyXNgPruRkUZigzT9mB4iiqIWUAjBcIBIgOf/HNRkPjf831HqCsv0Lo6OmuahjfUW
         9RNjInrFhTmxZvwAxNYzGCZvjNl1cqZJ47eXdkYgcsEHXiKo5EOcRFTvKHIT8h/iUd
         Y6jLkKCBg8QrSDhFs05xXFpIXTfxNdQEHwpnHB43/heXO1n7MNfwJWhV5Pe9nvlhRw
         jxH7x5NMrQracIGvuR87kmQmckM/SP+E8OEm55cEQFQkSlRZwBNYH/HPnhrwlBZUPn
         6GOY/lV5P9+WA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] b4/sysreg: More conversions to automatic generation
Date:   Mon, 22 May 2023 17:22:39 +0100
Message-Id: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+Wa2QC/x2NywqDQAwAf0VybkBXWbS/UnrIalxD6VoS8IH47
 649zsAwBxirsMGzOEB5EZM5ZageBfQTpcgoQ2ZwpavLpuqQ9OsbtF05YuSEwRG1nQ8tjR5yFcg
 Yg1Lqp7tbZ/3c+qc8yvYfvd7neQFNdKX9eAAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GYDycd6Y7G2pTvvcfFmXqSLvdBq4KcJ5xGdE+Xqfr9w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBka5bS9bMkaQNVvKeVeyk4O33QetHSjOElefnPTq7X
 gL7KjkuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZGuW0gAKCRAk1otyXVSH0FelB/
 wOSdB9BwWBxVUX/eVreh3Ok4yIWEuJUzNwtRF34GOW+NJy3HlfLSTzgdj8qSLs0ef70tNAEVHcLc0V
 rmwu1wtUTu7NL7LTauhv76CTmTIPECR+ZffZVaBsXli18KTg4pnZiIqbr42ENSqzCUmXZa/U2ujwEM
 ALRkg6vB9VYvY6DyEb39bxnTcj/49T9XRY9o0DtAuqcYnpwqCqguT3iahmByWFIV1VJsoY39EJq7Lr
 rx9frdeJFU49q9BXE68BVuRHWwc7yT71xiQaRciyLBY2CbuDU/1me3ZIJ/CFEy+82jJ1Lc8SSb1CKM
 ett2NR8UQ4BoJJul8ZgGpTnTehw/Y9
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
Mark Brown (5):
      arm64/sysreg: Remove some unused sysreg definitions
      arm64/sysreg: Convert MDCCINT_EL1 to automatic register generation
      arm64/sysreg: Convert MDSCR_EL1 to automatic register generation
      arm64/sysreg: Standardise naming of bitfield constants in OSL[AS]R_EL1
      arm64/sysreg: Convert OSLAR_EL1 to automatic generation

 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/sysreg.h   | 16 ++++------------
 arch/arm64/kvm/sys_regs.c         | 10 +++++-----
 arch/arm64/tools/sysreg           | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 18 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230419-arm64-syreg-gen-b2aa896b8af6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

