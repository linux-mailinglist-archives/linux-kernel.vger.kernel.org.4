Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C47169B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjE3Qfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE3Qf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:35:29 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 850201B6
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZptMN
        5b1HFyj0M+tXHUCEbylco9ZmxRdPWPDQJlP/Bs=; b=onK1rnO+EYkJtYR+wNumM
        +ZgqUdwMyzLbsmWtYCmNVG3nZ1XyztXBsVgNrPMVJhjItx3f3IPh7nrCRZK6u/pm
        aS21qfzXVZVbpUg7E/Cp6WVGJCDFFfUBjzheq4xqQN6XnAnnuWW/EsxaxfgNL8dr
        yGT2BCDwmKQE0ro+axY4hI=
Received: from lizhe.. (unknown [120.245.132.246])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXj0cOJXZkGoMHBA--.32862S4;
        Wed, 31 May 2023 00:32:54 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] dirvers/gpio: remove redundant reset gpio suffix
Date:   Wed, 31 May 2023 00:32:10 +0800
Message-Id: <20230530163210.4324-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXj0cOJXZkGoMHBA--.32862S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kGF1kWrWUCF4xXr15CFg_yoWfJFX_Ga
        yF9a1UZ34jvFs29ry5uaySyw4vvFn3Ar4Skrn2kr1DA3W5Z3Z8tanFyrnxCFs5Wa97WFy8
        XFnF9r4YyFZ7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfHUJUUUUU==
X-Originating-IP: [120.245.132.246]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlxZ-q2I0ZKQeYAAAs9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no need to add the suffix "gpio" or "gpios" after "reset", as they will
be automatically added, see of_find_gpio().

Signed-off-by: Lizhe <sensor1010@163.com>
---
 sound/soc/codecs/cs35l34.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index b3f98023e6a7..cbf0f2f4f9df 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -1061,7 +1061,7 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client)
 		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
 
 	cs35l34->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-				"reset-gpios", GPIOD_OUT_LOW);
+				"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l34->reset_gpio)) {
 		ret = PTR_ERR(cs35l34->reset_gpio);
 		goto err_regulator;
-- 
2.34.1

