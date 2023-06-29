Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E49742423
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjF2KqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjF2KqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:46:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707B1FCB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688035567; x=1719571567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwk5ABF4qGgGMZxv66u4XmVNCk/M9YuiuP7nMBK9Mn8=;
  b=bNVosmNqd1Wknzc1QymXdOhHlpgy5Akv2Xg4c1rIgSqGbM5RK5QvqlC5
   vQNLDCQ86a8sy7DRosEpOUKDl1AtSbb+Koie6rR2FZnCs0Qu71AgJUGOq
   1wrplvnY6K9iHDMDzpcIhxTtDGjRw/4on+6/DQ/z5zlIDH4FBrK0Pyg5B
   wpGCDFLIzLmLL9z9bQW9jNf9dB9Ke2jJX9OJv9CJGRMvLaHj0PdwBLKE3
   3OsHZnbzcDJrn8GI7C6SDxPAbJo7SUNQaweDKjbY6Mi+O6v+29DyJmhJT
   PNcBqeuxJ2IA57NLjFE92eeQ88Nh88V6EJ2qhXI8K7y9aXpkxnO1Q5YK+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="362115067"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362115067"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 03:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963948380"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="963948380"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 03:46:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B8F06204; Thu, 29 Jun 2023 13:46:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/3] ASoC: rt5677: Use agnostic irq_domain_create_linear()
Date:   Thu, 29 Jun 2023 13:46:01 +0300
Message-Id: <20230629104603.88612-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
References: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index ad14d18860fc..4ef9c88cb20a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5539,7 +5539,7 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
 
 	/* Ready to listen for interrupts */
-	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
+	rt5677->domain = irq_domain_create_linear(dev_fwnode(i2c->dev),
 			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
 	if (!rt5677->domain) {
 		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
-- 
2.40.0.1.gaa8946217a0b

