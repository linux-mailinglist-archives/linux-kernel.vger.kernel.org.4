Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4763DCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiK3SFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiK3SFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:05:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE976140;
        Wed, 30 Nov 2022 10:05:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bx10so16340036wrb.0;
        Wed, 30 Nov 2022 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F49cJsb8CUa65X+Gm6KdTwzZDDVKxz1Zo3pe8gGcwv0=;
        b=EG/PnpDlTgJTJJO34GwsXSOqeEZlDZIRWWDQ1jtUTMA9gU2YnGm7LazarhIrEpOaoU
         lM5OEwXW5+A/XpjTXfRQYyc2Wyj+Ls1YDXawTztM9GSBmWjz2zgbcGjhsmKv+Ut5Fvzt
         8Rq9e4k6OX9YYED8w4BUGeG09Z/ju8GxxTnjj1DH2Ocj6XTTjDwM67c1A1xHUVfK+q5k
         O6cpHmAlcGIbLJ2Zp6KL4giw8KMl9wx2agrP/bFRfV9rhoupeNBpOm5yja4ViYDDILcF
         YiG6kFP9b/hAAaVnOYAl4O019zw9Zx2w4KerXeFwkeAfgTkxcrjTqm0ZkFGCMKEBlaDn
         UaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F49cJsb8CUa65X+Gm6KdTwzZDDVKxz1Zo3pe8gGcwv0=;
        b=s+ZNWYEBhZ43KhAapjQAneA4k+DxbLQTfE/OrESQh4qsOB4jZ92S4Urgidia2OhKv3
         Ej/h9xkoO9O+4q3RDA0sZMd9lEI4adJ0MZQDdzbR5YS1xrKGwOE+0AgurldkEHKH99vi
         1/o27En7E5kX1ig1B5CcbnWvGKCMGcMUDKGG375yngTL6UeVYIK5aGRRqlfFd8ncxf/P
         ju8yNhZoTjAPDGex5IZWICc5npd6R2AfARHGNsir7YvGSShSHQxaiOF8d3hnNQC02/Do
         Zv8pz2sExak77PU2TeXZq3xJ8uJ5Lo6olGundAFRSUHjIc1Td7huRGYNkaL2XAiSdgNG
         e2ew==
X-Gm-Message-State: ANoB5pl8lp0+tKwJW3FuTOsk55A8kQF7VfeENNb18z229kI2+SUBN2B1
        6pGnw03GNhqGMLEPFVc9Qj8=
X-Google-Smtp-Source: AA0mqf5VT4u0wrpfLqYzOzziyDfaAq3+pawLVdT7IrkzMOfkGciPAx18ye557gAcuH0T5nW8eaj8Hg==
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id c12-20020adffb4c000000b002365270735emr27400470wrs.659.1669831501168;
        Wed, 30 Nov 2022 10:05:01 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c310d00b003a2f2bb72d5sm7943267wmo.45.2022.11.30.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:05:00 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: dvb-usb: m920x: make read-only arrays static const
Date:   Wed, 30 Nov 2022 18:04:58 +0000
Message-Id: <20221130180458.1580847-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the arrays on the stack, instead make them static
const. Also makes the object code smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/usb/dvb-usb/m920x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index 548199cd86f6..fea5bcf72a31 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -485,14 +485,14 @@ static int m920x_identify_state(struct usb_device *udev,
 static int m920x_mt352_demod_init(struct dvb_frontend *fe)
 {
 	int ret;
-	u8 config[] = { CONFIG, 0x3d };
-	u8 clock[] = { CLOCK_CTL, 0x30 };
-	u8 reset[] = { RESET, 0x80 };
-	u8 adc_ctl[] = { ADC_CTL_1, 0x40 };
-	u8 agc[] = { AGC_TARGET, 0x1c, 0x20 };
-	u8 sec_agc[] = { 0x69, 0x00, 0xff, 0xff, 0x40, 0xff, 0x00, 0x40, 0x40 };
-	u8 unk1[] = { 0x93, 0x1a };
-	u8 unk2[] = { 0xb5, 0x7a };
+	static const u8 config[] = { CONFIG, 0x3d };
+	static const u8 clock[] = { CLOCK_CTL, 0x30 };
+	static const u8 reset[] = { RESET, 0x80 };
+	static const u8 adc_ctl[] = { ADC_CTL_1, 0x40 };
+	static const u8 agc[] = { AGC_TARGET, 0x1c, 0x20 };
+	static const u8 sec_agc[] = { 0x69, 0x00, 0xff, 0xff, 0x40, 0xff, 0x00, 0x40, 0x40 };
+	static const u8 unk1[] = { 0x93, 0x1a };
+	static const u8 unk2[] = { 0xb5, 0x7a };
 
 	deb("Demod init!\n");
 
-- 
2.38.1

