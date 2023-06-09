Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906BE72A655
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFIWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFIWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E63A87
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7BF65781
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 22:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C060CC433EF;
        Fri,  9 Jun 2023 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686350632;
        bh=pFXxi/+k0vgMNVbo/aKTzxMO8ok6BkKhrmW5ZW5j7JE=;
        h=From:Date:Subject:To:Cc:From;
        b=Um6tyhVDVM1tBkhRxlYN3csYLcMYhwLbZYn+iQ5SUOEptjd2UUFzM/uY1NmTRJHgJ
         WO8ommVW0albmjJPqdXnzDCP2yNWJ5f7b3G4OXLUoizF+JGETrIJ2Q3CrZ0SXS3pYI
         TRt0h2nXOX+uprOG8gIs+zqnLAemelRr1YsjfLeUCRJbwhY4jceYpuhDZdTCmJbtHl
         IgdNVEfCcsN4hvPLRo8diIzhFADpzUqclgKlJw/SWTI90E6BnvbDrYVhmovtCc6vxO
         3r0VaPZLZKo3DEQs5yy9GuozF6rJqLK9l0T2IXFAZ5zx3wOEk3eXbgae+CQL4ufVZz
         SmnpYTy/4EozA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 09 Jun 2023 23:43:41 +0100
Subject: [PATCH v2] arm64/fpsimd: Exit streaming mode when flushing tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-arm64-flush-svcr-v2-1-827306001841@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByrg2QC/32NQQ7CIBAAv9Jwdg1gQ1tP/sP0ALgtpBXMoqhp+
 ndpH+BxJpnMwhKSx8TO1cIIs08+hgLyUDHrdBgR/K0wk1yeuOINaLqrGob5lRykbAnqxtpG6dY
 aY1nJjE4IhnSwbgvfkaZNPwgH/9lP176w8+kZ6buPs9jsn0cWIKBppdBKdB1yfZmQAs7HSCPr1
 3X9AYVnDo/IAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pFXxi/+k0vgMNVbo/aKTzxMO8ok6BkKhrmW5ZW5j7JE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkg6sl7hwnoCTpgzs8tkHwo1tsLhOytwBi8AEz9daW
 wkZDurmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIOrJQAKCRAk1otyXVSH0EfMB/
 4iqKhRm1wjF7Flf4wvqcjNAsKMrWOvwFpKn3Lrf+4Bnw4/p3udF9Gl/+wf1UjPsnl/L41AjgkzW/23
 cga9vRpCvRnQUYLzc61LYJSOmlNKCTUgcRV/8yZjxxsqj3ExOrQqTF2FpQUcBiY4Dk4v7RqFnnQdF3
 19VLxC5QgFeOGysFPDaPN6MMuk4HMCLpbdtz7K5SBF9eLLhY9C/hTbGMHvml/l50VQZL5iYypbRtcZ
 YeQ+HkZTIa2U3HeWheolO1FvUOgNzxc5GkvytsYdAatWZkL5aYy3fTuyAOZTF9cTNg8kYOhfQsAq+o
 VV61IbAAB/7AYYE+lUorxFwRWlpW+r
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

Ensure there is no path where we might attempt to save SME state after we
flush a task by updating the SVCR register state as well as updating our
in memory state. I haven't seen a specific case where this is happening or
seen a path where it might happen but for the cost of a single low overhead
instruction it seems sensible to close the potential gap.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Do a full SMSTOP to cover ZA as well.
- Link to v1: https://lore.kernel.org/r/20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2fbafa5cc7ac..7a1aeb95d7c3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1649,6 +1649,7 @@ void fpsimd_flush_thread(void)
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
 		current->thread.svcr = 0;
+		sme_smstop();
 	}
 
 	current->thread.fp_type = FP_STATE_FPSIMD;

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230607-arm64-flush-svcr-47cc76a8cbbc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

