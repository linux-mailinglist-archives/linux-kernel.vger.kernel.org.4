Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA2713970
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjE1MfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:35:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A0B6;
        Sun, 28 May 2023 05:35:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2564c6a2b7dso538915a91.3;
        Sun, 28 May 2023 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685277307; x=1687869307;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq0gNqj2qfz8g0wb05v2/2uio/8Cx2BLv1ubMI7PTgY=;
        b=WRpqSqXY2gp0xawIYDhcOV0NSo7IWn27YjEP5sigwtFuuBJK5OrNRcL38V/ZFd7Wc4
         x66EKYxgjulsfTlXKYLV4bDuYI+TJGVK/QsEaINcsbPYjzLpKFe9DTwgy2a47q5G1ckV
         U6oHEydEH8I2eLsDNY5RCyIv4n1G4YiTG8rLjb3dFpHzURQC23L2L5sjMRyr+MP+OKfI
         hmjLI83c+IdoE1qC/OWbv1VvrI42Euq759Ta8bSZ5iIGklkIa2VcdZeWKPrqclTUS/rx
         L68EEX1yaX+k82lgHYO/OPSL+CBzvdDHiOf4OODzzuNuCBUzvhwoqoYXushJRbrQJZ49
         tqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685277307; x=1687869307;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq0gNqj2qfz8g0wb05v2/2uio/8Cx2BLv1ubMI7PTgY=;
        b=JaFfTldbuG0jfzmYyva7MS0XUAZk5m6jmTXO5FTU7L8zJQGGbEnmNfVYl4xVTxed0e
         HwlYKAouinNTF1P54g39+JYXMRT6aJ1VZ/BsuJebPwZfrJ4Kh/NpYZWhPTJkH0RjQ2lY
         Sg/U/iZ3kBnvPu4wQzwT+0ikr5xE6dTmq/JD4d5i7icn/o94YU+lBChqnUZjXi0BUcoE
         ATUuBfxlY0iVhAlD9OK5SYbQhSsph/BBvsVgvRVt5JKmigF9Zn2pOdVza6nOfGYIb5jH
         s/lyGH21+N7T8X34o182OuSOtPt0hr20YjD0SQnJLr8qKBG14pGhX3WLvrSlL92GzPX6
         cdww==
X-Gm-Message-State: AC+VfDzlaojNe6MUwFDflWCAOFpKhkcKnSWYYCmDUP9aGXYPUbHOZnCE
        HbyOMfP3Ao9do09RHL/drCS7Gr3IokY=
X-Google-Smtp-Source: ACHHUZ6KDLC4tY1ov50bCGq+vxz3AsAbfKWiP0wdEn8GF9zH+MHDaEqPA0k0HBPOFlGFthYyBBhhcg==
X-Received: by 2002:a17:902:cec8:b0:1af:babd:7b57 with SMTP id d8-20020a170902cec800b001afbabd7b57mr11317937plg.25.1685277306745;
        Sun, 28 May 2023 05:35:06 -0700 (PDT)
Received: from localhost.localdomain ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170902c10900b00186a2274382sm6250352pli.76.2023.05.28.05.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2023 05:35:06 -0700 (PDT)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v2] pinctrl:sunplus: Add check for kmalloc
Date:   Sun, 28 May 2023 20:34:37 +0800
Message-Id: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Smatch static checker warning:
potential null dereference 'configs'. (kmalloc returns null)

Changes in v2:
1. Add free allocated memory before returned -ENOMEM.
2. Add call of_node_put() before returned -ENOMEM.

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
 drivers/pinctrl/sunplus/sppctl.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 6bbbab3..e91ce5b 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -834,11 +834,6 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	int i, size = 0;
 
 	list = of_get_property(np_config, "sunplus,pins", &size);
-
-	if (nmG <= 0)
-		nmG = 0;
-
-	parent = of_get_parent(np_config);
 	*num_maps = size / sizeof(*list);
 
 	/*
@@ -866,10 +861,14 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 		}
 	}
 
+	if (nmG <= 0)
+		nmG = 0;
+
 	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
-	if (*map == NULL)
+	if (!(*map))
 		return -ENOMEM;
 
+	parent = of_get_parent(np_config);
 	for (i = 0; i < (*num_maps); i++) {
 		dt_pin = be32_to_cpu(list[i]);
 		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
@@ -883,6 +882,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				goto sppctl_map_err;
 			*configs = FIELD_GET(GENMASK(7, 0), dt_pin);
 			(*map)[i].data.configs.configs = configs;
 
@@ -896,6 +897,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				goto sppctl_map_err;
 			*configs = SPPCTL_IOP_CONFIGS;
 			(*map)[i].data.configs.configs = configs;
 
@@ -965,6 +968,15 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	of_node_put(parent);
 	dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
 	return 0;
+
+sppctl_map_err:
+	for (i = 0; i < (*num_maps); i++)
+		if (((*map)[i].type == PIN_MAP_TYPE_CONFIGS_PIN) &&
+		    (*map)[i].data.configs.configs)
+			kfree((*map)[i].data.configs.configs);
+	kfree(*map);
+	of_node_put(parent);
+	return -ENOMEM;
 }
 
 static const struct pinctrl_ops sppctl_pctl_ops = {
-- 
2.7.4

