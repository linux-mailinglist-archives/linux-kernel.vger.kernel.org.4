Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1662572F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiKKJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiKKJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:46:15 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29889CDC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohu.info;
        s=biln2210; t=1668159970;
        bh=QBuozeCGvJ1pPUnPmH4I3zOe7+Yzr9DI6CwqEv6b9JE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HkZ9gWWj2+ADpfcrJZgt/xND7H/ZvFse4wjmloWQUCQaSLVKrQEP6PZucWt2jgrfa
         gsM5f7/NRNnPQwdvBAmKSPl/3bb1fT0fqnDkUbd1+BcQv9EEB0YGCCFgvLX0GzopSe
         QKs/cz3yTPE90heD2s8Xo6VX1rkPeVuFy7PQYnA8=
X-QQ-mid: bizesmtp70t1668159967tkdhay0e
Received: from localhost.localdomain ( [223.166.236.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Nov 2022 17:45:58 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: lP1Pu2Q8kTqcKFrUvbl6n7DNBaPweLpIzch4q+CEL724Fn8X3VErTTzPc7eqy
        rubbPz/70YVXV6jTL1pHxjbOZt+/etvhXdx6VbnZ/as7bRUtftD48fd+kAK2n75G8MDQLwK
        e7/++wIb6h04eyDWQow3NzHnFHADpqMM137xaGuBgYrQRibFanTEhEV1QA45+x/i/yprYfa
        v3k/sHO/6mqVyc8LQi+/JsyweIfAfpVDJtXizzJTpX82PqnFbWT9nB7Zoz4zLBHMYHs9q3e
        R/95L10xyDOVC8cE4OWUEpV+dCvNdYzfeDib3jf+nc/N8h0ZDu+G7s7WYjO77hSi0OZIJUR
        7FRanaJEf/edEfBGwr7R/4DpRBn6nweixHCfygeAbypIK/MLws=
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Soha Jin <soha@lohu.info>
Subject: [PATCH driver-core-next] platform: remove useless if-branch in __platform_get_irq_byname()
Date:   Fri, 11 Nov 2022 17:45:42 +0800
Message-Id: <20221111094542.270540-1-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_IRQ is not enabled, there will be a stub method that always
returns 0 when getting IRQ. Thus, the if-branch can be removed safely.

Fixes: d4ad017d6345 ("platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq")
Signed-off-by: Soha Jin <soha@lohu.info>
---
 drivers/base/platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 968f3d71eeab..6cd7fd478c5f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -441,11 +441,9 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 	struct resource *r;
 	int ret;
 
-	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
-		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
-		if (ret > 0 || ret == -EPROBE_DEFER)
-			return ret;
-	}
+	ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
+	if (ret > 0 || ret == -EPROBE_DEFER)
+		return ret;
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 	if (r) {
-- 
2.30.2

