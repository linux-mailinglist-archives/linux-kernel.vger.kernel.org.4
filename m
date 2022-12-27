Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13212656B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiL0NEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiL0NEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:04:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4386546
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D558561158
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371D2C433EF;
        Tue, 27 Dec 2022 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146283;
        bh=pTrChFbqVqwC6gDN/DoqmaY2bboCZ02nPBSBZf5fRx0=;
        h=From:Date:Subject:To:Cc:From;
        b=PsMAZrE+f7OWqqbE/SVgkzdw+kXKaWAXXBHouWbn7aYc5iVTUbvRyEqfMS5bLp2Lv
         /YKFY3zw/K7whmeo5DevJ4l5CY/oMH7nqkuGjNiw29zoFzI0NjMlLffgEg8SWdAl6q
         SN4+O80JFR+vcNCFW3HEBrMmuyC6gliiVUkY2jMKgMVjUhyqPATeIAiIes/f+gdkQP
         fMpO2Toe9K2+iYHvONW2OaiaaB8K0jczs52974TgsgBrOHAWzDgk53HmWeqbE78Tvu
         6pFkmuvCz5DjJMo8HKbGNmIT6nY2vsTrChoSL8b1yNaqvg4GNjvGMTxWMwqh4ojoWO
         YuyeOeQioZqhg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:04:35 +0000
Subject: [PATCH] arm64/sme: Don't use streaming mode to probe the maximum SME VL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221223-arm64-sme-probe-max-v1-1-cbde68f67ad0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGPtqmMC/x2NQQrCQAwAv1JyNtBNi1W/Ih6yNdogu1sSqIXSv
 7v1OAPDbOBiKg63ZgOTRV1LrhBODYwT57egPisDtUSBqEO2dO7Rk+BsJQomXnHg0A2Xtg9XIqhl
 ZBeMxnmcjvZb7HPo2eSl6392f+z7D1WQSEd8AAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pTrChFbqVqwC6gDN/DoqmaY2bboCZ02nPBSBZf5fRx0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu1pmVDmTeVu62lKGILUFR/hYnubH4Gbu1lX+mFh
 YspZj3GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rtaQAKCRAk1otyXVSH0OvMB/
 oDUKXOzQNQdSZyCVj1xyyp0b3UV8Qv8Gm3WSjFJlIRR1rFNK1DpZeLlhlZs21lyxY3A6ipknGPai53
 Q/3GwpTCM1IidvobHTbDDvMmRsDsu37HM2uh6MpVfVfBJI0n31YsXYO/Eykioo7UfvFk4xPOjwlZPx
 fCtZT2Kj/IJBljfKVmiWfzcDJOKIx7oq9wt0V03F9AmD6CFlCrUm7mNImv4f2l9somW65W+VohyGiw
 wk5fKLUK0whEwuwRAX6j/cQmUtQvUBZkPO/2gZlQg6R8qDobvRStCyHa8+wb5zc/PNCThnrKBX8w3t
 /AxLqyRujO4PAAVB5hicRJeeoLxlbU
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

During development the architecture added the RDSVL instruction which means
we do not need to enter streaming mode to enumerate the SME VLs, use it
when we probe the maximum supported VL. Other users were already updated.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index dcc81e7200d4..62c67664cdaa 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1322,7 +1322,6 @@ u64 read_smcr_features(void)
 	unsigned int vq_max;
 
 	sme_kernel_enable(NULL);
-	sme_smstart_sm();
 
 	/*
 	 * Set the maximum possible VL.
@@ -1332,11 +1331,9 @@ u64 read_smcr_features(void)
 
 	smcr = read_sysreg_s(SYS_SMCR_EL1);
 	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* Only the LEN field */
-	vq_max = sve_vq_from_vl(sve_get_vl());
+	vq_max = sve_vq_from_vl(sme_get_vl());
 	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
 
-	sme_smstop_sm();
-
 	return smcr;
 }
 

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221223-arm64-sme-probe-max-7a1378041922

Best regards,
-- 
Mark Brown <broonie@kernel.org>
