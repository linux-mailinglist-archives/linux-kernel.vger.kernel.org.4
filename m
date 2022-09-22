Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518165E5FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIVKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIVKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:23:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FCD826C;
        Thu, 22 Sep 2022 03:23:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 207so8681785pgc.7;
        Thu, 22 Sep 2022 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=BFG7E5DQJVUzp3LwJ0qUmDTHBE0wFMMStZtZRS9w0FI=;
        b=p6OgPDiugJa58P2dqy+RxH4tSjw8T8QF9a2cw8mLLSvqwifJPi1Hm41LGHuvtQwvKM
         WrcowYC7QIaM4d9RX5J3M/dfzZtpg334wbFWAwqnXQC8c7WI82stlg8GVMxwaICMczun
         /d5nZC/Y0/HV0+2jqTokMAqKRX/xjeE49WS5ImrNwCTaWopsCrDcIYmw9mf0F9jkapoO
         nJuA7NbpAp54xVOsLDPELaZm4ccCBm8AuF2or/3LpxP2yqK9X2UbvOMn2rTC+3KTAcgl
         3OIX5Um1rDU/fEK5OYm3EaO2dNpPqiFmwoMQ+RHVnK9h91JaaIPg9sajnh09faScPWZE
         mFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BFG7E5DQJVUzp3LwJ0qUmDTHBE0wFMMStZtZRS9w0FI=;
        b=RFQNHzlWA1mot7lQfq72mmts8kYRIoJT0wbp1f8wzXRW3L6Opz9pWQ8dMDHt8eOKft
         Isp/beQRqawcKRgEVEDTAimvOuGSk2LRhIFArDncci9ljuFnXXH4qbz7lKlDQnufvFVa
         LdUYi7Tqoise8Q1ToZerMoj2dmEJ1X2aWYp09hJYpqGV7y3E46YRaEXrk5o8gvR8yLn1
         wvUnGNcJzCAXLHC4rSWSf35LmFlFnH7nauNKRhwJjybWJjY/vbxnqibO4XgRxi83EF+2
         f1eRmF3qKqZ30Fq3woY8+6mlW8+WZyEvLFvR+Vjo/a5zri47uf2ar907fa5b2gJvzZRP
         +aFg==
X-Gm-Message-State: ACrzQf1AbxCrn7qUVy7Rwi/aqY7XwDcD5QFs+ysIghriBIziUYHeaL4B
        qJWbkpN4vBOAtkQt9puv8JzZOUosLPY=
X-Google-Smtp-Source: AMsMyM464+W1YojxacSNxYCT0+NhdSqCJD0ZmlA5G5L+2pOLg07xJjaoGq0shr8PisYzpGONaPWtMA==
X-Received: by 2002:a63:e507:0:b0:42c:65d3:f3b6 with SMTP id r7-20020a63e507000000b0042c65d3f3b6mr2405035pgh.395.1663842201521;
        Thu, 22 Sep 2022 03:23:21 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id v16-20020a63f210000000b0042a713dd68csm3422050pgh.53.2022.09.22.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:23:20 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v4 4/4] input: touchscreen: elants_i2c: Add eth3915n  touchscreen chip
Date:   Thu, 22 Sep 2022 10:21:20 +0000
Message-Id: <20220922101813.v4.4.I0cebec46a06dd3ea8f6b7abde038faed917dd5d4@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ekth3915 and ekth3500 are almost the same.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

(no changes since v1)

 drivers/input/touchscreen/elants_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index c9dd703b0c7d8..a21c9c9ed4d78 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -133,6 +133,7 @@
 enum elants_chip_id {
 	EKTH3500,
 	EKTF3624,
+	EKTH3915,
 };
 
 enum elants_state {
@@ -664,6 +665,7 @@ static int elants_i2c_initialize(struct elants_data *ts)
 
 	switch (ts->chip_id) {
 	case EKTH3500:
+	case EKTH3915:
 		if (!error)
 			error = elants_i2c_query_ts_info_ekth(ts);
 		break;
@@ -1686,6 +1688,7 @@ static const struct i2c_device_id elants_i2c_id[] = {
 	{ DEVICE_NAME, EKTH3500 },
 	{ "ekth3500", EKTH3500 },
 	{ "ektf3624", EKTF3624 },
+	{ "ekth3915", EKTH3915 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, elants_i2c_id);
@@ -1702,6 +1705,7 @@ MODULE_DEVICE_TABLE(acpi, elants_acpi_id);
 static const struct of_device_id elants_of_match[] = {
 	{ .compatible = "elan,ekth3500", .data = (void *)EKTH3500 },
 	{ .compatible = "elan,ektf3624", .data = (void *)EKTF3624 },
+	{ .compatible = "elan,ekth3915", .data = (void *)EKTH3915 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, elants_of_match);
-- 
2.17.1

