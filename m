Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C90744324
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjF3UXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjF3UXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:23:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EB2D69;
        Fri, 30 Jun 2023 13:23:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3110ab7110aso2580524f8f.3;
        Fri, 30 Jun 2023 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688156621; x=1690748621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh6GRzkrItcPLO9sSjebWiYC3C++2yaAGmp1iq4lTQQ=;
        b=pFvt5lXJDrPne95Y1XQzuGNY+7sTAr/pgk0go1GWNfvAJvaWxAF4KRxY7o2N9zMTIv
         6vmHW/ekTcPF9Kd1+ucOctlqPJP1UwHzuPi/pzNIbSY9n3g7wNLyIfOBphcrOJbFuQAE
         7Psx4kMnZ4e69uUQSqJ0N80xJTArE8dy1XHuXMPoUK48MlgMhICMxX12Gab9a9RXEkEX
         rGpvlnd2iEiPU6t7ZiFbu25iSv7i1IcXN4qipdVfsNggaf2GFGaI0tLs1F/6pFZ6CXba
         0/dVU8N9NCr0V27KABfbV0X6fzlIJi85dPKXcoB4XPJvHvt7sn4/LjsJ93KZ1BLrNrgk
         ZCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156621; x=1690748621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh6GRzkrItcPLO9sSjebWiYC3C++2yaAGmp1iq4lTQQ=;
        b=bJCE1kY1nYetX5WFjbKCEtqGKLeTiNAlHpaos5HZ4m3+uIOrSfnF1x0ZAm4vFhGeeQ
         Oy+M1yribRtOvC93d0BROSx7293w5ElGqwx1hmIgphCoZDocjeBfRvop8raA5M5vLzNG
         azsy47iXYRT7FA7iDUNl+HhH/az37s1E2/LJoPLf3UEgKtzeNxdoks/0KrkE2ig5fz8M
         43GFS6OhUY9oocNJ8SDI/5l/+I6OHHHmKXvVs3dkBsEwI39jMl9VAbJV6dfwHpA1qjP5
         1B0OqXPKU2o0x20ztrC36pn/ynbiInucE+/fWT51CihCGY2fT7lcNEn+LHhNh3sHavyv
         ks8Q==
X-Gm-Message-State: ABy/qLZsPs2ZR5HL02rqio++oYpCZxfzr4WknvjKcFn7ekIQF0/oIXpV
        v1a+evXvWTErM96T3RxHlO8=
X-Google-Smtp-Source: APBJJlGfsOT+WsMtRtpg6UwUE/AtYmrQfubWNvuIOyu/m/+GTdFFNRuP7nprGlbjuKuCWpIAidF4mQ==
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id o10-20020a5d670a000000b00313eadfb82dmr2400819wru.69.1688156620892;
        Fri, 30 Jun 2023 13:23:40 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id fa12-20020a05600c518c00b003fbb1ce274fsm81552wmb.0.2023.06.30.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:23:40 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] spi: bcm{63xx,bca}-hsspi: update my email address
Date:   Fri, 30 Jun 2023 22:22:55 +0200
Message-Id: <20230630202257.8449-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630202257.8449-1-jonas.gorski@gmail.com>
References: <20230630202257.8449-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address to a working one, as the openwrt.org one is
broken since ages.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
 drivers/spi/spi-bcmbca-hsspi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index ee2528dad02d..9e218e143263 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -2,7 +2,7 @@
  * Broadcom BCM63XX High Speed SPI Controller driver
  *
  * Copyright 2000-2010 Broadcom Corporation
- * Copyright 2012-2013 Jonas Gorski <jogo@openwrt.org>
+ * Copyright 2012-2013 Jonas Gorski <jonas.gorski@gmail.com>
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 8cbd01619789..ca1b4741e9f4 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -3,7 +3,7 @@
  * Broadcom BCMBCA High Speed SPI Controller driver
  *
  * Copyright 2000-2010 Broadcom Corporation
- * Copyright 2012-2013 Jonas Gorski <jogo@openwrt.org>
+ * Copyright 2012-2013 Jonas Gorski <jonas.gorski@gmail.com>
  * Copyright 2019-2022 Broadcom Ltd
  */
 
-- 
2.34.1

