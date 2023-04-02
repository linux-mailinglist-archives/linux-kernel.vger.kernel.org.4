Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742816D3A2D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDBUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDBUKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7DDB775
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so109436633edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OecrPdtGTbWbu5zwStTncNRELXl4OL8K+L0SCeXpYlI=;
        b=IWyNDbBWPyhtOqz8w1hZS0whZFFehIBz6EVGbTlKctZ3l9DL+8vSUPor1AUY+m6oG8
         b/Mw/jix25vP9jJMu+eIiJZsBsGP6UHRMzfMQ92/40AFJuQQ5KFt96JXWnE2KeNT0SY3
         7th7lOBc8od3ECnjY7Gk4inGTQMP8NEZEmic4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OecrPdtGTbWbu5zwStTncNRELXl4OL8K+L0SCeXpYlI=;
        b=KrT5p9PZfBtWSRcUr/jmWd0/qZvlxOMMr1dgkWnPhGFSRjajeqasKfa3s6I9TNpi00
         XL9ftGFQ8RzNNDuGrexup+M3a15w9VgIa0BJdRgS7LthwXLaSBuPnC6UwwJrm4r6GtMY
         xNJnFr2F88Q2JVU78OJGE6GvMCmAvk0N5haszgbBShN6rVc3oBRYEubkQzfneggo6VJN
         +Kh3dIatYDNB7ch4Cf3xgzQLRn872K5al2DBa7fMPnbX9qt6DbD+hoye8UDt76HKF4mQ
         SFkJFCgqSB6MN8xVSo/d0UL/XtuUWIUJMqV634M9SkNeQzI7T3lxLnE1rPPwXF3W1qcp
         tWrQ==
X-Gm-Message-State: AAQBX9eJLE4s5e+2I+brs9WThs13+2lrSb0g8+WRPjuTn1aao/T5OiZR
        s7Vnl0arRYzEOfJhdfkStz5QHrINb2kuPpHJOek=
X-Google-Smtp-Source: AKy350bXjwi8Ug83mrB+ve0vY0+BiB4dOMxb2JHLqg3/D5cFI8Xz+d6iFtltA5OVJwXX4cIFy+vEZA==
X-Received: by 2002:a17:906:ac1:b0:92d:9767:8e0a with SMTP id z1-20020a1709060ac100b0092d97678e0amr29588752ejf.13.1680466214662;
        Sun, 02 Apr 2023 13:10:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:14 -0700 (PDT)
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
Subject: [PATCH 2/9] Input: edt-ft5x06 - remove unnecessary blank lines
Date:   Sun,  2 Apr 2023 22:09:44 +0200
Message-Id: <20230402200951.1032513-3-dario.binacchi@amarulasolutions.com>
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

It removes unnecessary blank lines so that checkpatch doesn't complain
anymore.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index daba6472fc65..c0ad3e4b6662 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -619,7 +619,6 @@ static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 	if (reg_addr->reg_report_rate != NO_REGISTER)
 		edt_ft5x06_register_write(tsdata, reg_addr->reg_report_rate,
 					  tsdata->report_rate);
-
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1459,7 +1458,6 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 		gpiod_set_value_cansleep(wake_gpio, 1);
 	}
 
-
 	return ret;
 }
 
-- 
2.32.0

