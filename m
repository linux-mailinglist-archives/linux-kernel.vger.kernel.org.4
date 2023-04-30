Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9E6F291D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 16:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjD3OCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3OCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 10:02:42 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93D68199B;
        Sun, 30 Apr 2023 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vdfSe
        6AsEohOXu+zr/OQxFcuRoEL1V+oA5NLjf5c/Og=; b=nUEQXrBc0Znqa3Fp4IG6P
        EaUip6IbY3kQM0LHke99z3dCx2viPpPJZa/qm/IWx8T4Jkt8Se5S/VrwLem6oRp4
        RMsY//zGBzvj+K2xQdBEdvUrsuXSeTs/Z1+UhZFLIz0+jNxmAgh+xAJZLgqomChE
        2zNvfeHjq/fpa/uVtMyquk=
Received: from lizhe.. (unknown [120.245.132.239])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wB3r1+6dE5kijFUAg--.48793S4;
        Sun, 30 Apr 2023 22:01:59 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] pinctrl:sprd: Check if the pinctrl_dev still exists
Date:   Sun, 30 Apr 2023 22:01:29 +0800
Message-Id: <20230430140129.112081-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3r1+6dE5kijFUAg--.48793S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF13GFW7tw4DCr1rCryrtFb_yoWfGrc_GF
        yrJrWxJw4UGw4Y9w1jkry7ZFWIyF43Xr1SvFnFqFy3C347Xw4UtrykCFs8G34xGwnrAry7
        Gry2q3s3Zr17AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKGYLJUUUUU==
X-Originating-IP: [120.245.132.239]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBohhhq1aEIFHrrwAAsX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to check if the pinctrl_dev still exists before calling
pinctrl_unregister().

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ca9659f4e4b1..52089e34435c 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -1114,8 +1114,10 @@ EXPORT_SYMBOL_GPL(sprd_pinctrl_core_probe);
 int sprd_pinctrl_remove(struct platform_device *pdev)
 {
 	struct sprd_pinctrl *sprd_pctl = platform_get_drvdata(pdev);
+	
+	if (sprd_pctl->pctl)
+		pinctrl_unregister(sprd_pctl->pctl);
 
-	pinctrl_unregister(sprd_pctl->pctl);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sprd_pinctrl_remove);
-- 
2.34.1

