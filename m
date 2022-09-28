Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0915EDF25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiI1Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiI1Ot0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC5AF0CA;
        Wed, 28 Sep 2022 07:49:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bq9so20200837wrb.4;
        Wed, 28 Sep 2022 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZSJlpADL6FxqQLVTkCQJu3ikcoUIWPyVlc8ef31tV88=;
        b=VDNdXvLRt3TYlmc9I0S34pnH+AVClwsaUjLe0Ev7yNclLaCWBK+Nb2cHTyEqKznXbu
         RnpW+XjO0iifIHQEk7ViNpgnu2KsZLTuZUF+Q01PzFIvEaBwDD7gtRpSJ2U4BBSIp+b2
         nOaQoMEvhf2PcXVBQfOIWqqbXd3v3TmRILRB/CkuOdzh2flOcLiMUpEzIwyCVQuTqHYt
         HJrtrjXdskx0F5snSz0kcHgyiLTGI2zzRzU/++s6nHSvIiFf9BpxKQqf6EK3mAgQNHmY
         hTAHwtmEQ4WfZ6yITnUq6Zbb8d9MujyT3rbtuxR4+H3CM5DNd8op8TUqwyCQv9CPpRl2
         SyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZSJlpADL6FxqQLVTkCQJu3ikcoUIWPyVlc8ef31tV88=;
        b=1K6toddFMg2sH9XpJR5SgaU2COMiYGLWJLUy2UfB3bQ6SAUOPpn3RJCTC4ziLxLRAu
         NXma7L6g36reAyuuZM6IfognCRAckc1PXIannzE6rCpaX12tajfl8rs/zdLZTEdnQbQr
         CW2v9uq6pY+ZkOYO9INjuJFdFItksx6dF06VJ4sYCGnQ81tE0bHYkyas+j8Rl5rqBQ/v
         4pbZGV7nn2pE1EYCTx+N+I28o+QDgSgX6/YSB+qyJ6LIDB23Dm6uJ7SeTwxv2vx6VVye
         KD/SOSkt7pLM6fz49+Uz2xTMQQz1/SgIWZmEVGqRIxgZxSoeW9hM64Oc6bxX88axyeIE
         MA9g==
X-Gm-Message-State: ACrzQf0H+1PXjxOWnG6XSOqZ/3lUs0VsDEYmeVyzTLedCykCkijgiWlH
        s4qZHAz4kTMYFufnRzC0u5k=
X-Google-Smtp-Source: AMsMyM59CK+V8yWNXn7Fn4HIzBPuKDcHDmswAbJUIi32UUN2L6u7p5NGuLdhErtak8IlaaM3xh9MEQ==
X-Received: by 2002:a05:6000:188a:b0:22a:e4b7:c2f4 with SMTP id a10-20020a056000188a00b0022ae4b7c2f4mr20389233wri.446.1664376563440;
        Wed, 28 Sep 2022 07:49:23 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:23 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2 1/7] HID: ft260: ft260_xfer_status routine cleanup
Date:   Wed, 28 Sep 2022 17:48:48 +0300
Message-Id: <20220928144854.5580-2-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928144854.5580-1-michael.zaidman@gmail.com>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
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

After clarifying with FTDI's support, it turned out that the error
condition (bit 1) in byte 1 of the i2c status HID report is a status
bit reflecting all error conditions. When bits 2, 3, or 4 are raised
to 1, bit 1 is set to 1 also. Since the ft260_xfer_status routine tests
the error condition bit and exits in the case of an error, the program
flow never reaches the conditional expressions for 2, 3, and 4 bits when
any of them indicates an error state. Though these expressions are never
evaluated to true, they are checked several times per IO, increasing the
ft260_xfer_status polling cycle duration.

The patch removes the conditional expressions for 2, 3, and 4 bits in
byte 1 of the i2c status HID report.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
 drivers/hid/hid-ft260.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 79505c64dbfe..a35201d68b15 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -313,27 +313,17 @@ static int ft260_xfer_status(struct ft260_device *dev)
 	if (report.bus_status & FT260_I2C_STATUS_CTRL_BUSY)
 		return -EAGAIN;
 
-	if (report.bus_status & FT260_I2C_STATUS_BUS_BUSY)
-		return -EBUSY;
-
-	if (report.bus_status & FT260_I2C_STATUS_ERROR)
+	/*
+	 * The error condition (bit 1) is a status bit reflecting any
+	 * error conditions. When any of the bits 2, 3, or 4 are raised
+	 * to 1, bit 1 is also set to 1.
+	 */
+	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
+		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
+	}
 
-	ret = -EIO;
-
-	if (report.bus_status & FT260_I2C_STATUS_ADDR_NO_ACK)
-		ft260_dbg("unacknowledged address\n");
-
-	if (report.bus_status & FT260_I2C_STATUS_DATA_NO_ACK)
-		ft260_dbg("unacknowledged data\n");
-
-	if (report.bus_status & FT260_I2C_STATUS_ARBITR_LOST)
-		ft260_dbg("arbitration loss\n");
-
-	if (report.bus_status & FT260_I2C_STATUS_CTRL_IDLE)
-		ret = 0;
-
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
@@ -376,7 +366,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 			break;
 	} while (--try);
 
-	if (ret == 0 || ret == -EBUSY)
+	if (ret == 0)
 		return 0;
 
 	ft260_i2c_reset(hdev);
-- 
2.34.1

