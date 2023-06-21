Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491C738429
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFUM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjFUM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:57:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627210D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:57:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:57:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687352227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mfJR3MK9wcyi5gJAKc+z304Qjz1+2ds7fjxml8WHpzI=;
        b=urdW55p8trq+/EfmomWazIVtrKrzYr6/hXE90IdzxsD2yK4v97kxd6Wpc3MUiboPUgskKJ
        6hx6p1Okb6o1l5BErFfLeMUNPtvBOHXt0Ct88wm9PyT901U5I4ujtQ1V61x0J7q0E625QW
        srrzXE3EMQIdO+62r24JzUooCED116BWL5xdOPmmewvo7uY31odUtV2Si9/U/r1+YEhkp9
        vG4gRo1Fb1nkjhLRrQwajPzLirxCSe/jMkCVq8NL0qSgwJIYQJsH02xBrBMOQxhP3/s/CY
        cGqHIF5EHkNHkGnAJpb2Ig4VCFzI0S+BH90Ij3Y20VJ4AUMmojARqwwKTzryGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687352227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mfJR3MK9wcyi5gJAKc+z304Qjz1+2ds7fjxml8WHpzI=;
        b=GAZa/ZgiEkH+vUnKtyzq46C7oYXm8/bZM8KvUBhpfB/eNXdqHeICDvVywc6yFWQTIQ8x0O
        ggH1+sWubmVFibDA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] Revert "irqchip/mxs: Include linux/irqchip/mxs.h"
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <168735222615.404.5437100914727545952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d93c22199966696cfb76c6942797de2fbb22da24
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d93c22199966696cfb76c6942797de2fbb22da24
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 21 Jun 2023 13:46:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 21 Jun 2023 13:50:53 +01:00

Revert "irqchip/mxs: Include linux/irqchip/mxs.h"

This reverts commit 5b7e5676209120814dbb9fec8bc3769f0f7a7958.

Although including linux/irqchip/mxs.h is technically correct,
this clashes with the parallel removal of this include file
with 32bit ARM modernizing the low level irq handling as part of
5bb578a0c1b8 ("ARM: 9298/1: Drop custom mdesc->handle_irq()").

As such, this patch is not only unnecessary, it also breaks
compilation in -next. Revert it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 drivers/irqchip/irq-mxs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index b3b1fba..55cb6b5 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/mxs.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
