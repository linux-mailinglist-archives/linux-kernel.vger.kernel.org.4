Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8820693D57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBMEPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMEPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:15:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8BE396
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7EM0k4yf3TlWpm0n08kPMpGLehSGSAexr0X/ND2utsk=; b=en4qp0vWpgwjNqCR4CxWOb5O7G
        m5x0DwxA7IbG+ddJ/QOh/85G88XNLlR9Cb/RtIK1YxZuCRRBmnrQtvsGD9vc+fWi7xBC573DGBt6I
        BiUwLHQ/Dx/Y0wFBwOo+FQH5HD+q51PFy71EgWqddTqm7zHfY8Pk4biBDm4LVuHq+pxZSYE0jUpvB
        L1Rhfk3Z4v8YQ2q5qH7p/gbRn4ws3BV56G5mGd9eH8phgTi0rioI9hNAnDKvsr7NmgGlQyZ1i2dRf
        hoPwjpt3KJ+iO+13Ij6VUwtORq4vLxgfLOSAvWs0TXtznk65QDW4Gv7+P0vzURUqELBs7Dnt5VdZd
        nmqgFyDw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRQFg-00D56G-7N; Mon, 13 Feb 2023 04:15:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/3] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
Date:   Sun, 12 Feb 2023 20:15:34 -0800
Message-Id: <20230213041535.12083-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213041535.12083-1-rdunlap@infradead.org>
References: <20230213041535.12083-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
it directly thru "make *config", so drivers should select it instead
of depending on it if they need it.
Relying on it being set for a dependency is risky.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change OF_IRQ's use of "depends on" to "select".

This patch reduces one Kconfig circular dependency in
drivers/mux/Kconfig when MUX_MMIO attempts to select REGMAP, which
that driver needs (but does not completely resolve that issue). [1]

[1] https://lore.kernel.org/lkml/20230210115625.GA30942@pengutronix.de/

Fixes: 63c60e3a6dc3 ("of: OF_IRQ should depend on IRQ_DOMAIN")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
---
I have a similar patch (should be a series) for REGMAP.

 drivers/of/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/of/Kconfig b/drivers/of/Kconfig
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -68,7 +68,8 @@ config OF_ADDRESS
 
 config OF_IRQ
 	def_bool y
-	depends on !SPARC && IRQ_DOMAIN
+	depends on !SPARC
+	select IRQ_DOMAIN
 
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
