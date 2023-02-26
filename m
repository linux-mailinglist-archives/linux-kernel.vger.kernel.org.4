Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6576A2E70
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBZFkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBZFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF9136F3;
        Sat, 25 Feb 2023 21:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vm8XesWZZsdJp3yTtd1wnFZl0IgUFeQLot9qSDQtjWw=; b=k1vZOkQWbzFIE8hajMCqs31sXz
        XaqcWLE8zcWJS79sXGCa/hba+DSpcr7IoLcyQIWD2Rh4u1MP1u01rFLTldFsXVbf4hLpyJqqwklPe
        Ba2eqnsV0NljxngI5jLQNntsFX6PEBeEpp57n0W8DUm7dvKg8Zt/JBsdskhfG7cXTT0o5314eJl+7
        w/2MRUPbt3hv3uzaKkGevXYg26JYsIjk4ymhemUJSyahqM/TuZjwfJMWwyltxHqumUXH73ZwGV5+J
        Y7/vbl6D91QBhFgR268o3hrQv5sw4qq6J2UZJUsaNgO8jC8dwR3d5oIv7x6y50wPuxaudU1smqrh2
        v5kkRewA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lN-006qYL-QJ; Sun, 26 Feb 2023 05:39:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:52 -0800
Message-Id: <20230226053953.4681-8-rdunlap@infradead.org>
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

Fixes: b474303ffd57 ("thermal: add Intel BXT WhiskeyCove PMIC thermal driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
Cc: Bin Gao <bin.gao@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/intel/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -73,7 +73,8 @@ endmenu
 
 config INTEL_BXT_PMIC_THERMAL
 	tristate "Intel Broxton PMIC thermal driver"
-	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
+	depends on X86 && INTEL_SOC_PMIC_BXTWC
+	select REGMAP
 	help
 	  Select this driver for Intel Broxton PMIC with ADC channels monitoring
 	  system temperature measurements and alerts.
