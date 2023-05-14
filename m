Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A48701E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjENQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjENQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:47:48 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43D871FC8;
        Sun, 14 May 2023 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rXLNr
        rQ2Y423zWrRyCGFEOlcg07uqKROXf9zZcuH+wI=; b=crGWH7uShgXwegJOiN9JX
        rRxblWm8EPfWOQ4llDz2qu3x9ij5jASbZ85oYGjsJtal8YRM8vjHOdKmE8l2CSu1
        XaNaj7o+hL43QwqUxvxpkdsyJFSuelb9EIZw0X0z4usDMIInzIPMxmUGWvhjotf1
        cd1R9gstOcJLZ3ZvInebOs=
Received: from lizhe.. (unknown [120.245.132.205])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wB3S3WEEGFktc6EBw--.6929S4;
        Mon, 15 May 2023 00:47:31 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] drivers/pinconf.c: Remove redundant check for the existence of the member
Date:   Mon, 15 May 2023 00:46:58 +0800
Message-Id: <20230514164658.246613-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3S3WEEGFktc6EBw--.6929S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1DJryxtFyxuw4UWr1UGFg_yoWkAFg_uF
        WrJry7JrWkCa4Ikr109rs5Zr92ya10kF1xKF1qvay7AFy7Zw17J3ykKFsFqr97X3yfKFyq
        qrWrZr9aqr4kAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt6wZJUUUUU==
X-Originating-IP: [120.245.132.205]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlwRvq2I0ZA6G8gAAsf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pin_config_set" in pinconf_ops.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/pinctrl/pinconf.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index d9d54065472e..7b078d4ab61e 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -158,10 +158,6 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
 
 	switch (setting->type) {
 	case PIN_MAP_TYPE_CONFIGS_PIN:
-		if (!ops->pin_config_set) {
-			dev_err(pctldev->dev, "missing pin_config_set op\n");
-			return -EINVAL;
-		}
 		ret = ops->pin_config_set(pctldev,
 				setting->data.configs.group_or_pin,
 				setting->data.configs.configs,
@@ -174,11 +170,6 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
 		}
 		break;
 	case PIN_MAP_TYPE_CONFIGS_GROUP:
-		if (!ops->pin_config_group_set) {
-			dev_err(pctldev->dev,
-				"missing pin_config_group_set op\n");
-			return -EINVAL;
-		}
 		ret = ops->pin_config_group_set(pctldev,
 				setting->data.configs.group_or_pin,
 				setting->data.configs.configs,
-- 
2.34.1

