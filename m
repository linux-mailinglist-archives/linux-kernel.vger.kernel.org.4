Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB37216EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjFDM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFDM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:27:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0FB5;
        Sun,  4 Jun 2023 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685881625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bJflcJlGAugVDPpSX1OH5WDNgjOC+VFuKrhAQwMRcU=;
        b=JqvH8eUiOElpSqMVcgKMQrKSuZSdvWmTf88YMdix3ODjmaEnQe2d/9wmdCLfDRGNWbKAAF
        si2Z+ZxJfZT98oDJjyFYkqTKJHuAkcwtQ0sIA4xiBfRQHcfP2HVG/8zk4qbZduFCTqAxpC
        12jioFl0IDKozCSfZvDSrhQOnabGerc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] mips: ingenic: Remove useless __maybe_unused
Date:   Sun,  4 Jun 2023 14:26:53 +0200
Message-Id: <20230604122655.69698-2-paul@crapouillou.net>
In-Reply-To: <20230604122655.69698-1-paul@crapouillou.net>
References: <20230604122655.69698-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These flags are useless in this case as the code referencing these data
structures is always seen by the compiler (and not behind #ifdef
guards).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/generic/board-ingenic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/generic/board-ingenic.c b/arch/mips/generic/board-ingenic.c
index c422bbc890ed..7a4fce06875d 100644
--- a/arch/mips/generic/board-ingenic.c
+++ b/arch/mips/generic/board-ingenic.c
@@ -117,14 +117,14 @@ static void ingenic_halt(void)
 		ingenic_wait_instr();
 }
 
-static int __maybe_unused ingenic_pm_enter(suspend_state_t state)
+static int ingenic_pm_enter(suspend_state_t state)
 {
 	ingenic_wait_instr();
 
 	return 0;
 }
 
-static const struct platform_suspend_ops ingenic_pm_ops __maybe_unused = {
+static const struct platform_suspend_ops ingenic_pm_ops = {
 	.valid = suspend_valid_only_mem,
 	.enter = ingenic_pm_enter,
 };
-- 
2.39.2

