Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC66D3A32
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDBUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDBUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579A3586
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b20so109523438edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6yCxE8OoG8PeYtqKpR9SG7wxwNS753oO+7UKWNzpVg=;
        b=N9sz1W2nE5acZfsaVT+YC3J/c7YMv2SuZ2EhIM5begbM7seJrl65wteJHGxYZnCQWg
         oesgZqYRLy2aeHHLdg/QhWpBFRpVgFeVFrH22NLC1qUQFPGqz5790QzANSU5mSSPpfwv
         JgV4Jm0WtlkBHy498Qk3sUQD0+18MwQaGeOHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6yCxE8OoG8PeYtqKpR9SG7wxwNS753oO+7UKWNzpVg=;
        b=qF1w6pA9v+Ucoj6knGCd+uAzX6Iqt3jPklho/HAdJ6e8WvQspk3a3gWUwUsUIUFzDM
         xFqkjdYy0UwSwTYQiAbwWCZPokwaZOMN8PFBBmXTYG1utyNfzkAqRvZlngQLqNQqvs7R
         WIXN3n763qYO3Cc1FBZbYsDU9/4056vo9qhI6qAgWj9KQ06Hn9L4Kab5AxNtoSHmnWiy
         6TqeBe4D+WH0bRkd2A34O69s/Cm/f+VDeF4JgV3AX7kDYH27QiukhShPxLT0093Xiara
         gFiOvQTxpTojCV8NR0hpFC+yRYG533Z5lhwmhyfx8/V8kM7DGc3QSgDMrbXYKQy9bG8t
         Ut4g==
X-Gm-Message-State: AAQBX9eol+OLwvl/h4c9xXMVOtOo20HADqrza2EsGLQhXGK2KHbL2nwp
        xcMASKwvOucgk/72BTnWE/Z8oSEPLmtfSVoOC3A=
X-Google-Smtp-Source: AKy350ZJmiV/iG/KdkY8Z4BybeVcfbuz3pwQ5ecPcXpiI6+BODgcGjO17mujGqBKrFmJ3/4np3nIHQ==
X-Received: by 2002:a17:906:a150:b0:8a0:7158:15dc with SMTP id bu16-20020a170906a15000b008a0715815dcmr33439578ejb.74.1680466217623;
        Sun, 02 Apr 2023 13:10:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:17 -0700 (PDT)
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
Subject: [PATCH 4/9] Input: edt-ft5x06 - don't recalculate the CRC
Date:   Sun,  2 Apr 2023 22:09:46 +0200
Message-Id: <20230402200951.1032513-5-dario.binacchi@amarulasolutions.com>
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

There is no need to recalculate the CRC when the data has not changed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c96fe6520578..d4f39724b259 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -319,7 +319,7 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 				    u8 addr)
 {
-	u8 wrbuf[2], rdbuf[2];
+	u8 wrbuf[2], rdbuf[2], crc;
 	int error;
 
 	switch (tsdata->version) {
@@ -333,11 +333,11 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 		if (error)
 			return error;
 
-		if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1]) {
+		crc = wrbuf[0] ^ wrbuf[1] ^ rdbuf[0];
+		if (crc != rdbuf[1]) {
 			dev_err(&tsdata->client->dev,
 				"crc error: 0x%02x expected, got 0x%02x\n",
-				wrbuf[0] ^ wrbuf[1] ^ rdbuf[0],
-				rdbuf[1]);
+				crc, rdbuf[1]);
 			return -EIO;
 		}
 		break;
-- 
2.32.0

