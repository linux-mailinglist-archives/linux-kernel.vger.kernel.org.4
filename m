Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8076A6D4F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjDCRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjDCRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:53:49 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BCAC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:53:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54601d90118so411522467b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680544409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQO/GmpqLMEjtyr2atFB1M1H+ye6V/kPyFsUarcG0ic=;
        b=MXb6iL/HFXndej/CtEHNUvhgkCghuRYHFdCUjltYevYE9g6PVv/wflCUlYJVtPNw8L
         Wki2KsSIlx6Q33pfCVPcwZsmVns9GsSC4pjvOABViPyjTOIkjv+A/EeT2j67IHsY7huX
         8rafwtkUTK2XrwS7MazWNSxnSYbIr9JZ10Y6wjOWGnfrLYdolcytyRXilJKc63uncGzu
         No15Q4oJeqTJsyKYjah39PjR59XDUlmB9gWpAgEZxlN8GBp50F2/3h7SXDDen7ZnkA7B
         8t8phSKcJSJUgiTovPg+nrSVQqznek/2FljSjGjaW0TKOo34l6FtVcdWTSRg4a2Rx5zR
         zMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQO/GmpqLMEjtyr2atFB1M1H+ye6V/kPyFsUarcG0ic=;
        b=qlsvkJnHtSB8G3faPeKjkT6lrzd3Od3SH3uwCLjSjaLXfbd4e2BZE6epfDI27jz5VB
         LmNjJZrHKmA5l1FVSJXeelIGdR3r2OdwuV5zybFQDTbk7GWJq20qsU/oWPR7dPQ7VhGx
         I+M1SEBrE0+AqiDGe6okpWhgpGhIgR5IP9HCBpoii0idPiyLNXDYc6xsNqlj9ez6DPRr
         PW/LARK5qqJkqlUh2KHx9byGNlSg28RB2kXT8IMOu5efrfXToU+bSzglvl6xDnArG68g
         WK3vSGWLDMayDIzGbbh+EWxleY4o6z+GxIS1kllQ9cl+G0l+zqd8qPUPsnNZEoZXHiZo
         MHJA==
X-Gm-Message-State: AAQBX9dk8loAOrGKiv0p9/amym1uiaDUqaHTHeWwksC+iQhHBRw5ypku
        712QFQOMgFioJ7IAzCkhTkr1QWtEZRm6iqUEI80weg==
X-Google-Smtp-Source: AKy350bSFMd7XG8DGXPuPuVKSAbI8PI0Gs4lG8jTUxk69faGT/KbNU5FUpeDrQvn2OJKzeiuRqk5NA==
X-Received: by 2002:a81:5ad4:0:b0:538:5106:b41b with SMTP id o203-20020a815ad4000000b005385106b41bmr35592135ywb.32.1680544409017;
        Mon, 03 Apr 2023 10:53:29 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z135-20020a814c8d000000b00545a08184adsm2661663ywa.61.2023.04.03.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:53:28 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/2] gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config
Date:   Mon,  3 Apr 2023 13:53:14 -0400
Message-Id: <005eaf8c2094581025eb5273e2c669a676b12d08.1680543810.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680543810.git.william.gray@linaro.org>
References: <cover.1680543810.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idi48 regmap can be used in an interrupt context by regmap-irq. To
prevent a deadlock, enable use_raw_spinlock for idi48_regmap_config.

Fixes: e28432a77365 ("gpio: 104-idi-48: Migrate to the regmap-irq API")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idi-48.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index ca2175b84e24..ba73ee9c0c29 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -81,6 +81,7 @@ static const struct regmap_config idi48_regmap_config = {
 	.wr_table = &idi_48_wr_table,
 	.rd_table = &idi_48_rd_table,
 	.precious_table = &idi_48_precious_table,
+	.use_raw_spinlock = true,
 };
 
 #define IDI48_NGPIO 48
-- 
2.39.2

