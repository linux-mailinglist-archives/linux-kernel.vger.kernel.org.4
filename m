Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE374411A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjF3RWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjF3RWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:22:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F8199B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688145725; x=1719681725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3IUtCLuB4ClrnmeXN1FNAH3rmScz4Se3y8ZAbWmBgs=;
  b=N4+XHH3A08MiJOxyji9DrJLMmElIVRrlENRjLDftSqHyNSKksoA3m8h9
   ZrCqAf7SoqlQmzTASvL2rgOP4d8wzJd7oloanjfNVvNF6QOO+FlNXuXao
   TwUVFefTRW+tgkQV0uwaxmHZDBVtEoEQwFtutoutsN81YjVl9OQYp3WJA
   Rajpd5mG8fx84F/l8PDgr7toWnscytWCA9/kyjYZ2JTqcfTK9iKjrNf/d
   8uSaPO593jioXJY8Z+paDLwz9SszocOY6fEvnpZaaMvvOpw84RLTr0vuk
   iZ62pmTHQ4x6O40KaRu2ECtTouqvMyHMgCWpCy7/20nJdG7n6dOfsBfor
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="361298326"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="361298326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="747486145"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="747486145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 10:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E16474DA; Fri, 30 Jun 2023 20:21:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 2/4] ASoC: rt5677: Use agnostic irq_domain_create_linear()
Date:   Fri, 30 Jun 2023 20:21:53 +0300
Message-Id: <20230630172155.83754-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of irq_domain_add_linear() that requires of_node,
use irq_domain_create_linear() that works outside of OF world.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 3a2a6b150cda..17d5dd5d2974 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5511,7 +5511,7 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
 
 	/* Ready to listen for interrupts */
-	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
+	rt5677->domain = irq_domain_create_linear(dev_fwnode(&i2c->dev),
 			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
 	if (!rt5677->domain) {
 		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
-- 
2.40.0.1.gaa8946217a0b

