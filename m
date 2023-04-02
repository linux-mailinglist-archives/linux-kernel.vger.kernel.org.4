Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F66D3A33
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjDBUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjDBUKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDAC3586
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so109434009edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMHERFML/oNzDxt2xRgB06w0p+QqR9zI3HtwO5KrpJg=;
        b=BTA0a7k7iFtvaI2JEereURx8iOMHTUOIQcSCoitVWC3sF+WGnPQVeju6CVDc/6tRB2
         ZfpEnkmpRBCSppaEZ5OdsY/Oi+Jo32snp7n7puHWzt7bBzxZonHe9cHpKVYQdPMf9Vl7
         ZjEVTpQBasomg2sk23RR/gSl5qHGWIR8C9U5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMHERFML/oNzDxt2xRgB06w0p+QqR9zI3HtwO5KrpJg=;
        b=cnvFworFjtub1Sf05CTd/MmemvOy6+gy83gFLJKqHC6Tl/JKQ0gadZ/cbuF8Kh+7so
         r1W6sMQCk2Tep5DC4knTxmGSsCMPm01nvdDHQHsurk2aUiN7Io40w19NhEWdINgGC0po
         PVZ0QKObTDRlmxeWjY5lMipx7djmbbxNeLY4Hh9XlDp7+5vO36KVPtgyt3dlRaVdK4RX
         djWfysLOqmmiMYiXEcZ7EDuzV+knQ4/P/ubsgCE6TN6MIfmxyzzF7Tc6ZIDeQdAlqeF4
         lOwBUTRmef9RMCtoE77gH/L1MR6hwDzig1mK448M70GqzUGj7KX6eBlNGqnSK56AdpjW
         hpUw==
X-Gm-Message-State: AAQBX9dmoUNuONJjCsJx72anaJjmhJ3BEJYDYakD/kzOh5Gfg8mjbTGE
        dIecZcIJh8o55At1EqfQUbMbjzSKy9unqPARaSY=
X-Google-Smtp-Source: AKy350YzePVZDu3bwXduDlhZsJ0xniTfatUrFkqFgAC9hiqa91HtRn0heuR8JnLEVJgG+BTqIbYKrw==
X-Received: by 2002:a17:906:b049:b0:937:9a24:370b with SMTP id bj9-20020a170906b04900b009379a24370bmr34522323ejb.67.1680466219066;
        Sun, 02 Apr 2023 13:10:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:18 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 5/9] Input: edt-ft5x06 - remove code duplication
Date:   Sun,  2 Apr 2023 22:09:47 +0200
Message-Id: <20230402200951.1032513-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
References: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
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

The use of the macros M06_REG_ADDR and M06_REG_CMD avoids code
duplication without impacting the application load, and reduces the
chances of errors or mistakes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d4f39724b259..7d82f412ab15 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -75,6 +75,9 @@
 #define EDT_DEFAULT_NUM_X		1024
 #define EDT_DEFAULT_NUM_Y		1024
 
+#define M06_REG_CMD(factory) ((factory) ? 0xf3 : 0xfc)
+#define M06_REG_ADDR(factory, addr) ((factory) ? (addr) & 0x7f : (addr) & 0x3f)
+
 enum edt_pmode {
 	EDT_PMODE_NOT_SUPPORTED,
 	EDT_PMODE_HIBERNATE,
@@ -294,8 +297,8 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 
 	switch (tsdata->version) {
 	case EDT_M06:
-		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
-		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+		wrbuf[0] = M06_REG_CMD(tsdata->factory_mode);
+		wrbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
 		wrbuf[2] = value;
 		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
 		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
@@ -324,8 +327,8 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 
 	switch (tsdata->version) {
 	case EDT_M06:
-		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
-		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
+		wrbuf[0] = M06_REG_CMD(tsdata->factory_mode);
+		wrbuf[1] = M06_REG_ADDR(tsdata->factory_mode, addr);
 		wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
 
 		error = edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2,
-- 
2.32.0

