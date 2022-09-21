Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB355BFD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIULrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIULqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:46:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7195685
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so8749495lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QO312a6i8/S0aAmV9/OT7vjMYqyfCVVJUdmei7UzN2U=;
        b=gKaCJJdnysMw/QnYhM4mDpp7ZBiEtYpfJD6Fm72t+uaTa/am/neW+LfJw41250lcFy
         F9DsW1UIpgYqQy0g2wicbjByKCtZV9h2/aI9r2c6eiidfxbYzujeeJkBwYIyfGq2rc//
         yjXEuiId3qfhhxJQMe0m/aLjkQ8bAZbiIIGOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QO312a6i8/S0aAmV9/OT7vjMYqyfCVVJUdmei7UzN2U=;
        b=v/JQgDP0EzOAAMxM7jsnj6ZjYDSE+EnZ0k+FynfQbkT8tPzzbNNlqtU769BA870LS4
         f1cNO2X6AMY3S6D3v+46+gi2HXpI2u59NSETzoFvgWccGefcZEgruOkSL4JpnMu1mSut
         zTEyuw4pSTrWsNIVB9iNvSIV8gd18s8FjFSb7cRmtqvMQ0h5ZXCnXS3wIeREmLo2PZ/L
         ZVOXJrXUrYR3I6XbZYXn6IbTMPxyAqMmH3hHNP0fQrDamlkWE6O9bcwoYpzCtd+uGd39
         JRU/vwYPcL5DnafCoEUBSgxfgVUFU4zcNrdKq9mHdO5EShYlmSnnUCHX9yyAHH0DFDP1
         Cafg==
X-Gm-Message-State: ACrzQf3SKPmRSR780n9gaM6qJtdu5C0U56AvU3DwF/P1OPoQy7jNN0D9
        Xqa/zqSqyXAbEnWac62ogZx4nw==
X-Google-Smtp-Source: AMsMyM4ZCHEZvmafIThhaRckJxaQl9iR7FM4INrk8+otkBUCCz/oPbnh7t9S0ef70WsekBjEy4UuFw==
X-Received: by 2002:a05:6512:128d:b0:49f:4b31:90ed with SMTP id u13-20020a056512128d00b0049f4b3190edmr10352424lfs.118.1663760796100;
        Wed, 21 Sep 2022 04:46:36 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] rtc: isl12022: simplify some expressions
Date:   Wed, 21 Sep 2022 13:46:19 +0200
Message-Id: <20220921114624.3250848-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
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

These instances of '&client->dev' might as well be spelled 'dev', since
'client' has been computed from 'dev' via 'client =
to_i2c_client(dev)'.

Later patches will get rid of that local variable 'client', so remove
these unnecessary references so those later patches become easier to
read.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 2fc9fbefc6fc..7efe23fa74df 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -112,13 +112,13 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
-		dev_warn(&client->dev,
+		dev_warn(dev,
 			 "voltage dropped below %u%%, "
 			 "date and time is not reliable.\n",
 			 buf[ISL12022_REG_SR] & ISL12022_SR_LBAT85 ? 85 : 75);
 	}
 
-	dev_dbg(&client->dev,
+	dev_dbg(dev,
 		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
 		"mday=%02x, mon=%02x, year=%02x, wday=%02x, "
 		"sr=%02x, int=%02x",
@@ -141,7 +141,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(buf[ISL12022_REG_MO] & 0x1F) - 1;
 	tm->tm_year = bcd2bin(buf[ISL12022_REG_YR]) + 100;
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -158,7 +158,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
-- 
2.37.2

