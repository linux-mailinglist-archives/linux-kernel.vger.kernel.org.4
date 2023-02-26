Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72126A2E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBZFj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBZFj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D175136EA;
        Sat, 25 Feb 2023 21:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5EL3h3gDbv1fOup+zFv/dxa8dkjfhZsLYy7zEK7AZjE=; b=ZABGG7wnGOx6TcA9KINzaegqjD
        4QUug6UACr1wdMOK5fTqdO/UKI6Xu2fJudekLhS/cibD6PMOw3lMho63cshMjB69n9jRskuCL6Pt+
        e0UNJa0W/nZtnFX9/aVcZk89HYuHuYWXDoXEC91b2OlTtxaHYObY4uOxKiWgVszbJ5Tfh8SNenos7
        ggbN7SJ7Baeh86xDSdW07MShRFdKAN1BEMx4u6g8kZLA7V3UaKZGEiGP0EEoBtjR5WAmh2NawhyyK
        6Og6C2FYvTLO+Ouwkzrh8Xl7gGc7CxMgdOg6CMI61HfGQEZPktSfbVsoCotVBsdc1es39CVhaNY4O
        JmxgZhgw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lL-006qYL-GS; Sun, 26 Feb 2023 05:39:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:47 -0800
Message-Id: <20230226053953.4681-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
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

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on REGMAP" to "select REGMAP".

Fixes: 3a49afb84ca0 ("clk: enable hi655x common clk automatically")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Riku Voipio <riku.voipio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/clk/Kconfig b/drivers/clk/Kconfig
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -91,7 +91,7 @@ config COMMON_CLK_RK808
 config COMMON_CLK_HI655X
 	tristate "Clock driver for Hi655x" if EXPERT
 	depends on (MFD_HI655X_PMIC || COMPILE_TEST)
-	depends on REGMAP
+	select REGMAP
 	default MFD_HI655X_PMIC
 	help
 	  This driver supports the hi655x PMIC clock. This
