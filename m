Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF25F9C97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJJKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiJJKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C486B8EF;
        Mon, 10 Oct 2022 03:17:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 70so9454019pjo.4;
        Mon, 10 Oct 2022 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8zsaI5Gs8vsXLxREyleuRlaz94K3/hG65VmZ8PPqBI=;
        b=LHYwVxxCP2wrkz/TjMYmSTUyOSEuQDpK2OjNrpvd0FTWJ8q3hTCAAeyYX07hJNPDbu
         nPvyGtRb/ivY+Javm6g9egAWpBTe9bdHhaDsY65FX5wW/9zQvbFpcxzj7v85HlLyGjF+
         a2OWkHTB/ovm+nZpRFxGB6ZRYX4X81+KBmnYEJvmD8DW4vQPmPjZWvwto7UUOCscKHr+
         UAIVcrTQMvZTOU5VZPRgHIqvjt0uJFSeAYpPBniP77TUxQH9dzuWUiBbLuyw13kc+B64
         z3feTof9UGwsKPR8CcEESYlRwtt1rqcKes+ddaF+9jyKqGorAouhjko9CTEV0nYUr1CV
         PpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8zsaI5Gs8vsXLxREyleuRlaz94K3/hG65VmZ8PPqBI=;
        b=pWmdhU57ENt4pgpWtREiSJQj6lohtG1hhlfb2PP8L9eGxaWhznbGoyYn4cB9mzv5TH
         +X9A+oqh89jMYxHoE91K8MrOVgeCEBNVIgACO58YHIN3VGROImG+Qe+Y8G7axm636zdQ
         8/vQ8vSGbPef8q/WAvXAmPrup/dfKy5mZvLCo7VAuTH7j0ltKoJefRnLlJWcfMxr6Qo9
         /u+kDfpWsyMrAjRBNUgN5g/P8OnEQUdnd6DxvmGurOOyXpGGNRX0O9T4GWpWU1aADNfZ
         /pipYRMUaPwCiUYvCons5uJj8Jj9kI5JBfHhCgS2V/asUA4jl3QtHdxBX+zs26IsdbUl
         6qrA==
X-Gm-Message-State: ACrzQf2otcd6oDIYEUFvGJb/1c+H2pG5iZNMHsjt1g3S6i9hKVB0oRAZ
        92KOMe71QwU6ohpR2Gcy4jGT6ZBHKxk25A==
X-Google-Smtp-Source: AMsMyM7CYOH7FziNpAhLFmnfpwtDamMOpV7rSlnRiPuHkD25wgbdinSWaS0YLYIrdnNE29Y5Ej2CWw==
X-Received: by 2002:a17:902:6a86:b0:176:a6bc:54c0 with SMTP id n6-20020a1709026a8600b00176a6bc54c0mr18544218plk.87.1665397035938;
        Mon, 10 Oct 2022 03:17:15 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001769e6d4fafsm6229515pln.57.2022.10.10.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 03:17:15 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/of: Initialize the thermal governor for configuring thermal zones.
Date:   Mon, 10 Oct 2022 18:17:08 +0800
Message-Id: <20221010101708.12565-1-huangqibo.tech@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the initial thermal governor of thermal zones on the device tree.
Since the kernel provides a variety of thermal governors,
to a certain extent,thermal governor is also a specific hardware property
 of thermal zones.

Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
---
 drivers/thermal/thermal_of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fd2fb84bf246..617b5ac030b4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -404,6 +404,11 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
 	if (!tzp)
 		return ERR_PTR(-ENOMEM);
 
+	if (!of_property_read_string(child, "thermal-governor",
+					&governor_name))
+		strscpy(tzp->governor_name, governor_name,
+				THERMAL_NAME_LENGTH);
+
 	tzp->no_hwmon = true;
 
 	if (!of_property_read_u32(np, "sustainable-power", &prop))
-- 
2.37.1

