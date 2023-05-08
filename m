Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1106FB200
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjEHNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjEHNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D60D1BE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3179362D5F
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E55C433D2;
        Mon,  8 May 2023 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683553814;
        bh=BXgdn3NMjuyoP1sp3OyJ6vmKBZBzk1/LOYTIFOk5FaY=;
        h=From:Subject:Date:To:Cc:From;
        b=kfs29VyOOxBfwAl2UQcf4jRm5SWr6PqmwoTAmDltd/7CC5d31JmW2sXjJRz5QG4GK
         +DvpWjkVvIOn5xgxHvdQ7GhE+hYbzDjw8uamqQ1Z/b5rnk+w9Hk43Cz9/zqdj2/k4i
         qhNk/k0rdPreFHMlfCApyrl7B4FSKs57+3K5xSDCQ438LEdZmsxJlGebq0pNR5R5In
         mqI4gnEakM50++O1aUMbZThMtGoaiQDfJ3pQKLTQAXaMXKAUE1aFQRFPQDQ17LnSpd
         AjYsz/pFl0pqIt8stwFUZan4fBn3Ih9PhKm61WrtjU4egUoiaWy0lpwSAHHIda2e/C
         hPiXJeJabSoAA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] arm64: Add decode of ISS2 to data abort reports
Date:   Mon, 08 May 2023 22:50:08 +0900
Message-Id: <20230417-arm64-iss2-dabt-decode-v2-0-84e1c1463d30@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABD+WGQC/4WNSw6CMBQAr0K69hlasAVW3sOw6OcJDdqaV4Iaw
 t0tXMDlTDKZlSUkj4l1xcoIF598DBnEqWB21GFA8C4zE6Woypor0PSUNfiUBDhtZnBoo0NA25p
 a2rbRLWc5NjohGNLBjnv+jjTt+kV495/jd+szjz7Nkb7HfuG7/XtaOJQgeNWYi5SNUuo6IQV8n
 CMNrN+27QdoHZIS1AAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BXgdn3NMjuyoP1sp3OyJ6vmKBZBzk1/LOYTIFOk5FaY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkWP4S0qHesN5RoqHoNY2TZH914Q7Vc/bHZDXMp
 7CTsjJ7Up2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFj+EgAKCRAk1otyXVSH
 0DqpCACHDEU7HM5vegwNrvVMUJwXLlXsc/fDr5aRCNAQ+TjbivJjw3AMYqLmgydPxxZO1NZxqUf
 vBfdqpTLe5/s4szrbXSSM10ZAOZmrUwD9+Loe27Wdx8e0Zrx3QWz82Fdo4ZpKEr0MjrymA1GWeZ
 3f/rXBxO6hw3zVsDnK6L0aUTGojKuiMqUO6it/icds/CyaEa/xsMhiQ5RmBjlK+Tvhaceedk+BT
 H/V33vxZuIp4cZsB6g9OJe6FmuBrG0SikCfXpsCKUuO7AA2Or7JG/gC6Ae6K6Ywf+/w76R+hi8Z
 rnEyJyHLmgzU36kuQORwjZfH3S48/JiWIvcpt5vB2vvTSBKE
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

