Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D76B727F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCMJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCMJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:27:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16123A9B;
        Mon, 13 Mar 2023 02:27:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so11015180pjp.2;
        Mon, 13 Mar 2023 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678699677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OpwxskmBPy4CpjtWMo+T8QeWJJwqkVX8aJFIYDNm7xs=;
        b=RAH/DVxOyUQvf/lt8KhbMbh/+OZthHAeg/X+tupO2oO4eZDpHXTABqSqSpe6TZjNs5
         uzqROM+3NNEUCEZFZRlBeHuHLW09LzNS/jN35i4LpvEBqZN/LUDu91+iiIjcOJu5N/bZ
         z40CUczzdpdEbx+raY+hHQmiUwV06B1LZdgMIpSLwPEMJeEsgFqzHZZbH1Y77R5EfaPp
         T4gt/U+WyuUJ634o911ijRj66W4uKMdkU7V2oCmmt43MFsJ8Hs3aJ1AJUmByTP9JDhcU
         Nf15bNCSquSZ+GDN6ysVBEyhP7q0m5ShZ6/OAg/bo3WHsUboTsXXcRSPfgEhddzkSkgn
         2RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpwxskmBPy4CpjtWMo+T8QeWJJwqkVX8aJFIYDNm7xs=;
        b=HJ3OUnjqpkeWuvLkXcdkmbG9l9rBeKjGN7EMmxmZrUoWkeYNqVBkDY/R8Sy6cgj9CO
         s1YdB1Ex426UVgHhKLBTjdDwDcJrtJdx4nlLZ6OgTcJpXM6LUUe8izYB33CSVs55KY3Y
         fFFhQv5rh825A6DjQ8OoWFjrNd8JmqxA/85b6U44cq3XajfX4uXUnEFIn/NMNsEvGE8t
         dYH+YQFfVAyG7ulrjD5Y+tVD/1zfnxC0qxZ2omxGjwrTqI4BTtr2nRv+rOE5RmWdrD5S
         qwuw1k92NsO748VvtI2XVpcmnufIPgbaRivJ6doZChmZfx+MuXMCxqBlpsmPVYWLDfgZ
         hcKg==
X-Gm-Message-State: AO0yUKXAT3HD1QkmWOGYe6580uSUufCpSundRLOgJfVwTLPYnweeHSce
        xjw1cmnTq8bThQ9ImVQ1j+Q=
X-Google-Smtp-Source: AK7set9S4EYlxcmQI8BkTNR8foIisBUh7fq7Feg2Vp+nL4Aa+KNIQ79f+FRfLcaXlypfLn0lyfkxKA==
X-Received: by 2002:a17:90b:38cc:b0:237:bf05:40b with SMTP id nn12-20020a17090b38cc00b00237bf05040bmr36653252pjb.20.1678699677129;
        Mon, 13 Mar 2023 02:27:57 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090aa50d00b00230dc295651sm956751pjq.8.2023.03.13.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:27:56 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: dvb-usb-v2: ce6230: Fix null-ptr-deref in ce6230_i2c_master_xfer()
Date:   Mon, 13 Mar 2023 09:27:51 +0000
Message-Id: <20230313092751.209496-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ce6230_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach ce6230_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen. We add
check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/ce6230.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/ce6230.c b/drivers/media/usb/dvb-usb-v2/ce6230.c
index 44540de1a206..d3b5cb4a24da 100644
--- a/drivers/media/usb/dvb-usb-v2/ce6230.c
+++ b/drivers/media/usb/dvb-usb-v2/ce6230.c
@@ -101,6 +101,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_READ;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
@@ -117,6 +121,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		} else {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_WRITE;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
-- 
2.25.1

