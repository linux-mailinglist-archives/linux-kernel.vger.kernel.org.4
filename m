Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34F68393C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjAaWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjAaWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:21:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5525A83B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:21:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63C16172A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152FEC4339B;
        Tue, 31 Jan 2023 22:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203661;
        bh=v3FjEdRmmEt3NyVgaKzEfe9CNRFEtOqilNNlSnvu+VA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R4IgY3/BayvBrlVlgVHD9c2rtsypzG7Sz3pee1ZxmG8T++MoOVZVDikEJ1F63udi2
         PdEdg58Z5q2LUGZPSYJhSz/Pzeqsytaebbd644gaFZgiB3SCj5f7mjBPrgha9ITILm
         QjB4jvyQ5xk8Lwo3u6DRCvPsZ2oOg0JmzNCdgpVe67V4q1PnRAzXZ+xgLA7+ncNCge
         vkzvoXo38U2syseapUOGGOjBbkmdEXUW21POKFKha9gsm2w1fDId1E/OnEgiHt5OKP
         9Bb1X0YP9M3iKhyFrWdTaea9hLDglv3gb1afjfqulxyy4QOnQFRRDGM0D/OTQh27Wu
         Iu1v1S+0pZUVw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:45 +0000
Subject: [PATCH v3 7/7] arm64/signal: Only read new data when parsing the
 ZT context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-7-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v3FjEdRmmEt3NyVgaKzEfe9CNRFEtOqilNNlSnvu+VA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZRALr0svZCl9sk06hJBwcGaS+7GOBnxP/4lIysy
 3PhsAIuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUQAAKCRAk1otyXVSH0GwrB/
 9pa2+QCNmzp2hYTGFfcZUm/fCzdSM8BCi0zTOykaFZAJek1FpPgVW2CbYFmPAtZdzk2ivw56QVk3hB
 E9w2hFr/ktL0C5ZuRPJTzfj3xbzJaH8ALvCY5MtL30ytV7xDAbpsN1V0ZbvylCwx3Xu0N/TX1a4QY9
 sObfG7NR0aKsQ6FIGlkEbu/oWSJDEpGpIN820K14QGNtQCtTRdZBkLCbJGAsLu0h9uDeykqGUgnV+b
 gEV/D1BL7rcEi4vL3CmaQd0F7BYP/6n/fK8vQpLp16MaPmHhUPmGcUBtDoHKUTCj5YwnXVM66hdoFl
 CW+jJI7nwD7E6jXCUVZYf0V7iKN9pu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we parse the ZT signal context we read the entire context from
userspace, including the generic signal context header which was already
read by parse_user_sigframe() and padding bytes that we ignore. Avoid the
possibility of relying on the second read of the data read twice by only
reading the data which we are actually going to use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 7810d090c025..d7b5ed8a9b7f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -521,7 +521,7 @@ static int preserve_zt_context(struct zt_context __user *ctx)
 static int restore_zt_context(struct user_ctxs *user)
 {
 	int err;
-	struct zt_context zt;
+	u16 nregs;
 
 	/* ZA must be restored first for this check to be valid */
 	if (!thread_za_enabled(&current->thread))
@@ -530,10 +530,10 @@ static int restore_zt_context(struct user_ctxs *user)
 	if (user->zt_size != ZT_SIG_CONTEXT_SIZE(1))
 		return -EINVAL;
 
-	if (__copy_from_user(&zt, user->zt, sizeof(zt)))
+	if (__copy_from_user(&nregs, &(user->zt->nregs), sizeof(nregs)))
 		return -EFAULT;
 
-	if (zt.nregs != 1)
+	if (nregs != 1)
 		return -EINVAL;
 
 	/*

-- 
2.30.2

