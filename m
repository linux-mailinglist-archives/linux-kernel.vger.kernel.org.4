Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2A62D401
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiKQHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQHYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:24:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833B28E1E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:24:20 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCWcy6Fz6z4y0vK;
        Thu, 17 Nov 2022 15:24:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH7O9Qq090542;
        Thu, 17 Nov 2022 15:24:09 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:24:11 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:24:11 +0800 (CST)
X-Zmail-TransId: 2af96375e19b4b0447f0
X-Mailer: Zmail v1.0
Message-ID: <202211171524116446204@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tYzogcHdyc2VxOiBVc2UgZGV2aWNlX21hdGNoX29mX25vZGUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH7O9Qq090542
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6375E1A2.000 by FangMail milter!
X-FangMail-Envelope: 1668669858/4NCWcy6Fz6z4y0vK/6375E1A2.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375E1A2.000/4NCWcy6Fz6z4y0vK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/core/pwrseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index ef675f364bf0..2374669b588a 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -29,7 +29,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)

 	mutex_lock(&pwrseq_list_mutex);
 	list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
-		if (p->dev->of_node == np) {
+		if (device_match_of_node(p->dev, np)) {
 			if (!try_module_get(p->owner))
 				dev_err(host->parent,
 					"increasing module refcount failed\n");
-- 
2.25.1
