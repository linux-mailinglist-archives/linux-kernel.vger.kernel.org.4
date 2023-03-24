Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016756C7590
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCXCX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCXCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:23:24 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C526AD39
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:23:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VeVutzY_1679624587;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VeVutzY_1679624587)
          by smtp.aliyun-inc.com;
          Fri, 24 Mar 2023 10:23:18 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     james.schulman@cirrus.com
Cc:     david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: cs35l56: Fix an unsigned comparison which can never be negative
Date:   Fri, 24 Mar 2023 10:23:03 +0800
Message-Id: <20230324022303.121485-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'rv' is defined as unsigned type, so the following if
statement is invalid, we can modify the type of rv to int.
if (rv < 0) {
	dev_err(cs35l56->dev, "irq: failed to get pm_runtime:
		%d\n", rv);
	goto err_unlock;
}

./sound/soc/codecs/cs35l56.c:333:5-7: WARNING: Unsigned expression compared with zero: rv < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4599
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/cs35l56.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 90fc79b5666d..d97b465f0d3c 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -321,7 +321,9 @@ irqreturn_t cs35l56_irq(int irq, void *data)
 	struct cs35l56_private *cs35l56 = data;
 	unsigned int status1 = 0, status8 = 0, status20 = 0;
 	unsigned int mask1, mask8, mask20;
-	unsigned int rv, val;
+	unsigned int val;
+	int rv;
+
 	irqreturn_t ret = IRQ_NONE;
 
 	if (!cs35l56->init_done)
-- 
2.20.1.7.g153144c

