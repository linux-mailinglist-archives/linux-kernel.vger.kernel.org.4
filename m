Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27F73FBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjF0MRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0MRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:17:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C741BE7;
        Tue, 27 Jun 2023 05:17:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6194691e87.2;
        Tue, 27 Jun 2023 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868229; x=1690460229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zw0XO0K/YJZaGpOs6ScnOWaE2Vp0kSyIA1FOyq+ley8=;
        b=Y4ZPTg47KBLzs+cPPRkoB4QEQJogOjJOdJjCAiLhGsqferI0CkZhck89KuGf/qZK8m
         cNG79iYsCpGh0vUfoB1GfwwePp2dBEDo5S6JuiBMe/6lFyJbRGHCQ2453o4AMhZdaxoh
         zciAkf+nZLm0WQYQYHqenxg3BBIiolRGNJvo/hWrPvw1G3LZnIwCoSQhstGxhC7wWoYO
         OMQDJAeMLg4K6a+41nFCSWvQVgrXcJxe/w0XgAp9B5YqFkb5PSVqGvg4kdHi/+c2H1Rl
         6id7Y9bLkRlvGKrNwhweQaiusg7KVIpmU12Fh/+hjFVrQXIDpL2mXonMgkpmfyBtATqM
         3JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868229; x=1690460229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw0XO0K/YJZaGpOs6ScnOWaE2Vp0kSyIA1FOyq+ley8=;
        b=dj6upq1M448AKv10Z/A+EFHbm9P2McPvbUOCqD/51JLI+a7HpnL07i5C8E6MM5tiAN
         PYioXfEwXS6PC+Y7NkhUBf5wh+FJLUCfZ97GowuN+bemMG/Cqb2GR4CptcD5TaNSLBba
         XA5zIarAjrWU+aw/wdIdeWMdfQd1BZLtbjHTzwZT33Mf0TiatEa3JKEl0yBighsNo/IR
         s62ktiUzrChp0me/STanU/mvfSm8d4xlSg24mgnAzhPxyabPesfi5F4TJx7aHR7YaAcp
         /2q5ONE47+wjyp3i0AyXGg4uTIPhHklP/02Fgdx9EFAP2NfVjqNo7Z5wmNqvtR5r5tYE
         rwJA==
X-Gm-Message-State: AC+VfDyOgDfv3GUljXMJgUJjBmKhLjBE4GTiyKRXjP3e5osOXj/FImWh
        eU//QFf0aL/IKk7lq35jtHN5lJo6//M=
X-Google-Smtp-Source: ACHHUZ4AZlBP0GXgHdZROjji+plUNPA9EpkAsuHPth/8ra4buZBwQysFftdpJP81W+FGiOrbApH5Lg==
X-Received: by 2002:a19:505d:0:b0:4f8:5ede:d447 with SMTP id z29-20020a19505d000000b004f85eded447mr15585676lfj.28.1687868228732;
        Tue, 27 Jun 2023 05:17:08 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b003140039f318sm1504556wrx.69.2023.06.27.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:17:07 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: bd99954: make read-only array sub_status_reg
Date:   Tue, 27 Jun 2023 13:17:07 +0100
Message-Id: <20230627121707.722021-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array on the stack, instead make it
static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/bd99954-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index 086dcf4033c1..1ed1d9f99fb3 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -536,7 +536,7 @@ static irqreturn_t bd9995x_irq_handler_thread(int irq, void *private)
 
 	for_each_set_bit(i, &tmp, 7) {
 		int sub_status, sub_mask;
-		int sub_status_reg[] = {
+		static const int sub_status_reg[] = {
 			INT1_STATUS, INT2_STATUS, INT3_STATUS, INT4_STATUS,
 			INT5_STATUS, INT6_STATUS, INT7_STATUS,
 		};
-- 
2.39.2

