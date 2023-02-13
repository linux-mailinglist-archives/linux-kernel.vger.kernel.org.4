Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABAE693D55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBMEPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMEPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:15:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAEBCA2F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KP+QUTQLUK2eLfgHq5KRvNPggllLGVnWdOEMxnpKkT0=; b=cAOtQYru6OXsUMRBFJy+DckahO
        44CgxcULv8NnYNsA+AZAPfSqrt3F2nv7INKfutwhVAJh3363RQIgqeTbtJ5lJhx86bC8s33Uymac3
        y40xl8TwQTFjL2GCWnzrHiZgSFTWciXhoMjURFivyjmwTwz3CPzeSH24CKL5ildUox+xl2I6E2fne
        GIk6FBdMXV/3Qq0Aj/AthbBXZONaIX/IJ+cqxgufAaBhaKfBRW9CaPqImEPttO/6yuCzs+cmrzdre
        tzxnRP7Ie7QYIyiBPahk0eKz+vWZKjoPax7qRdzszQZxJuLMGc0RcCADt9MqWsXWDOGSBZhfsztUx
        FrNYgaqA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRQFf-00D56G-Jq; Mon, 13 Feb 2023 04:15:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] extcon: max8997: select IRQ_DOMAIN instead of depending on it
Date:   Sun, 12 Feb 2023 20:15:33 -0800
Message-Id: <20230213041535.12083-2-rdunlap@infradead.org>
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

Therefore, change EXTCON_MAX8997's use of "depends on" for
IRQ_DOMAIN to "select".

Fixes: dca1a71e4108 ("extcon: Add support irq domain for MAX8997 muic")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
I have a similar patch (should be a series) for REGMAP.

 drivers/extcon/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -115,7 +115,8 @@ config EXTCON_MAX77843
 
 config EXTCON_MAX8997
 	tristate "Maxim MAX8997 EXTCON Support"
-	depends on MFD_MAX8997 && IRQ_DOMAIN
+	depends on MFD_MAX8997
+	select IRQ_DOMAIN
 	help
 	  If you say yes here you get support for the MUIC device of
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
