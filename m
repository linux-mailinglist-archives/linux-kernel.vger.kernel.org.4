Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF473841B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFUMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9151996
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6514614C0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA58C433C8;
        Wed, 21 Jun 2023 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687351968;
        bh=h9FXyN6dNMU+C6jrvp0fGpm2E0wCjF4Yj1o/AqbYAHA=;
        h=From:To:Cc:Subject:Date:From;
        b=jwWvblZX080MV6/0d6j2RPiq0WYdpkj3Y5hE41KUVVuBAuJnQHOE+jvgcqIST1ikq
         I4RS+eDchcAl+BF6CWzEpn8b3pI5YyJEGbc4n2WQ1wzDBexM+Rjl9c0TJgj4DR9JC6
         kxtx3RF5HUqiqna5TZDwYQS7RJCOnFAGKhRo7vqKxp2l70ZRygp0kQ+5bXdWtWga8T
         VrtiK4n7eiS5HHLslJ6Y7bFa+nAF8ojYhTHiIz80WsG03Imm3OjAOsrOnb2HIr1ZHY
         5/EizT8FRLfVpz+seClv41RiuHstGrBVRHDdwEJgQtJ81ygF6ucs/OaNyW8kBeZZUy
         QH9Sv0FGBk+4g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qBxKI-00780j-0l;
        Wed, 21 Jun 2023 13:52:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] Revert "irqchip/mxs: Include linux/irqchip/mxs.h"
Date:   Wed, 21 Jun 2023 13:52:42 +0100
Message-Id: <20230621125242.3252661-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, shawnguo@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index b3b1fba871c1..55cb6b5a686e 100644
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
-- 
2.34.1

