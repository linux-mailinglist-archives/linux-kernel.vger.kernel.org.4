Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFECA65C809
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjACUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbjACUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D8140C1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A9F3B81104
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0888AC433D2;
        Tue,  3 Jan 2023 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672777535;
        bh=fWdC96nOiyYQllhHb320Pi7UN6yZJMtcVyFGws6l7OY=;
        h=From:Subject:Date:To:Cc:From;
        b=FSvE4t0TdTbrzlebM2n7CtloLWVv6k9pO45Vc5AyCEJyrBi5mwOtPZlZCeL+L1Ke1
         s3ZKm4/nV9rxxjrGlRWLCV7GSCslb1NJ6EKC1YNoexPx7f1eGyTP1JOUc4pFKLinyC
         M4MzZ2GQ3IyeIVnLDxohh6UrcpHukiAv5TAT/lmxooaF/LY0SE5admBfm5SFXPAPGB
         6tWtGVomHDh9gQ3LY9HP144EUz9zJ+X5jN02NpnlR/aDtZ7manODjvceX03Arh6LEY
         +9ZnRfBWUa/sgmCrNyVSSoddmLuuPxEVU47DMcw622Vu8BjxwU6M9T+0r9x8weStmz
         ZRdYF7p7w/PHA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/6] arm64/signal: Signal handling cleanups
Date:   Tue, 03 Jan 2023 20:25:15 +0000
Message-Id: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACyPtGMC/0WNwQ6CMBBEf4X0bNGuIODJ/zAelrKUjdCSLRoTw
 r9bvJg5vUzezKoiCVNU12xVQm+OHHwCOGTKDugdae4SKzgBmBSNMl0KHdl5HLUdCf1r1q3tKqig
 oxIbldQWI+lW0Nthl4OwY3+cMC4kez8L9fz53d4fiXsJk14GIfyfGSjMuaxNnUMNTVlqkxZD8Ey
 3J4mnMQ/i1LZ9AXwPPsbDAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fWdC96nOiyYQllhHb320Pi7UN6yZJMtcVyFGws6l7OY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjtI84uYm7QVfqrrk/rDnJ9tYJUGg07dxvxryMlzra
 5+hdHL+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7SPOAAKCRAk1otyXVSH0BIJB/
 9acTAwvQiel6zzT/zjrGzu5o8n7nHBI8fpCxTdufO6Yv2TSXoDMqEiK7KSAnaNIc+2CvAXfwZKiFjc
 Wt/pPEunrvKiYPDXEKddUtpOfXVYwPw0POEIBhgcf7TrMFdhHx3e4ti0toyglgJiwhYWGh4UHxiAin
 ONGN79cphFlZvxqzfXIR2Zf1VFVwlGc73LFtH6jzM3Dm5dApjGUWd2woLYBlSQe5jSEDgJJ9RXSsRz
 5plITxEv580T9OPVjEjqtv7uZWqB9tEb7T3c8Nd0z8YNzDUselgEyRfL+OgZXm1LrlAKr//H5oyQja
 GoUL1EIHfJWb8s4ktgOq1CtufjA128
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

This series collects a number of small cleanups to the signal handling
code which removes redundant validation of size information and avoids
reading the same data from userspace twice.

There are some overlaps with both the TPIDR2 signal handling and SME2
serieses which are also in flight, applying this will require
adjustments in those serieses and vice versa.

v2:
 - Rebase onto v6.2-rc1

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (6):
      arm64/signal: Don't redundantly verify FPSIMD magic
      arm64/signal: Remove redundant size validation from parse_user_sigframe()
      arm64/signal: Make interface for restore_fpsimd_context() consistent
      arm64/signal: Avoid rereading context frame sizes
      arm64/signal: Only read new data when parsing the SVE context
      arm64/signal: Only read new data when parsing the ZA context

 arch/arm64/kernel/signal.c | 91 +++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 45 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221212-arm64-signal-cleanup-bcd7272de5a9

Best regards,
-- 
Mark Brown <broonie@kernel.org>
