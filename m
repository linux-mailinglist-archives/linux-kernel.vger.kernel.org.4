Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9B64055C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiLBK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:58:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB40716DD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:58:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so6839447lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asePIDAduz3wjwHekIjxIWyoaIECGFH8vErA/u3bLN4=;
        b=bWhJrmXjdq55NOaGcwX/Atz3vFl/oz3eIvphok+SzkjhWZydkEk9JsO4pC/rGw+HYG
         QfdTuTpMRYZ1UnLUhZhmULmAksl2y3p2hSV8ijlP/U58/H0R5fn5WeXxpnDVSq31K/5E
         Kvnnijeqp+AfgnM5QnHt/scqsVOJL/T7KmJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asePIDAduz3wjwHekIjxIWyoaIECGFH8vErA/u3bLN4=;
        b=mxfPxhrW6NbJg9WAptjPxh+vKwPiUyLWHduTvTv9m10bKpj3INfXa2AQMYJ6SxmLWY
         DKGPk5QjjLk5+dbBoYztyaVMeog5O5W1KhkUKtVJtc7QPVcwjZv1XEJE4ouLM4NctbRg
         4H6rI8dnO4QgyPkyALyC8Ua7w7blLGZRTAg6d/l2Jxwk+nQs4U2KJxn00tJSpF0HUeSP
         hm+dJxDpXbzYyGM87DDmPzEG3VBi/Ij79QytQEqdyR5aePnD99h1fm0YIidc/7E5MCcQ
         gVqe/g0oTziQA5Hv7VSSISwr+ZO01TOfJ/Pq0NZTY2/hg3a5SIiQmUL4M3fUA5xoOG3+
         oq7A==
X-Gm-Message-State: ANoB5pmpC1E/ESezkqXTIoiAv+33SEjuMUUghksTWXfdwDDKWqdX1Q+p
        2YNvuoLq/Jp1wt1KwvxQJsI9Nw==
X-Google-Smtp-Source: AA0mqf6u8qX9oGcO0BTh42XYDDh2o/SjY3dXsfoJGAUXY/CS3GBafSO66+JXnzYW4msK5+vhPKVWAA==
X-Received: by 2002:a05:6512:b8d:b0:4b4:ec87:ef9d with SMTP id b13-20020a0565120b8d00b004b4ec87ef9dmr15987504lfv.70.1669978690303;
        Fri, 02 Dec 2022 02:58:10 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id dw8-20020a0565122c8800b004998d9ccb62sm982682lfb.99.2022.12.02.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:58:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: edt-ft5x06 - always do msleep(300) during initialization
Date:   Fri,  2 Dec 2022 11:57:59 +0100
Message-Id: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a board with an FT5446, which is close enough to a
FT5506 (i.e. it also supports up to 10 touch points and has similar
register layout) for this driver to work. However, on our board the
iovcc and vcc regulators are indeed controllable (so not always-on),
but there is no reset or wakeup gpio hooked up.

Without a large enough delay between the regulator_enable() calls and
edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
fails with -ENXIO and thus the device fails to probe. So
unconditionally do an mdelay(300) instead of only when a reset-gpio is
present.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 9ac1378610bc..8bafa123083c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1239,8 +1239,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	if (tsdata->reset_gpio) {
 		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
-		msleep(300);
 	}
+	msleep(300);
 
 	input = devm_input_allocate_device(&client->dev);
 	if (!input) {
-- 
2.37.2

