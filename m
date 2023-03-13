Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2AF6B71F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCMJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCMJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:03:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2C580F4;
        Mon, 13 Mar 2023 01:59:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u5so12127563plq.7;
        Mon, 13 Mar 2023 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678697940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2NqsaIKXSDOG8M7FKQrqhkG2QMfzWgRRYdSSRT/6aU=;
        b=mDKpAy4oPyJ1IrbE8DMGw+0fQLFAmLhZWUFnstrt+cF+zl6EjJlqAYkVhlWHd6RQmm
         8EUdmOQvywscktOm03guaS7IY1VTOSE0c/ZsfVfZzWFDwq8NlXMANoFRkmWL/t0A48aF
         X7dI5M++CiShTS7isLa/A9bgGyDtai03WxYQmP1DeMbiBrCYGVPkrO6w7HOTLBqjOal8
         anJOy65vglMS2tPkYSgTVlDZ/bYpui08aR/2nHVfkPuV6yPJa0e79PIP8NKj/dACPDIM
         qhcwM6/LIf8DE+KR33fZmFikEXoi+1EuLBX5sjY9vq+cgjSStldRi8V5XUIwkp4leOAt
         NDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2NqsaIKXSDOG8M7FKQrqhkG2QMfzWgRRYdSSRT/6aU=;
        b=rN/e9v8llbPlgRUKxs00orUSu9n4h1Ji9YboitAuo/uN9ZX9t6YdLTYuxNyFbKGPGr
         5TESDzzAy2Lh7wkOKm4d9oeyXo3gsW0w/0kWdILdk31aEjM5i4ePI/GU3bVA0y1pwNsS
         2seYedW3R5yQ1UYNpCrKvkdam/6LlatfmccZCMTeHLs4H6jJoOuxWp9wNHIp4ce4wW1h
         +TfApnh4JdVrDTnFNrP2JMJOVLRPQwUmFoozMAfqgfGP8u2qZdnkKLzNnb1jmWJz8kAK
         3gU54bcLzMvdvfv6q8yQpNieIo4jfF9ED6PSJeeNAOy+NGjqIqkwqgUacbKMBNC2y+cg
         zm+Q==
X-Gm-Message-State: AO0yUKV1yB0QXdt19DyEOmuWZ8ZJkPKw2/TU5WWwrxEa5vKG56T9U89h
        SzKJhoC+E6YywFyAUgLJC5o=
X-Google-Smtp-Source: AK7set8a67W2u/yY0Zl7AOrEabibSzUI7Ozn25sXNDfHRJmKKsbZQt+LqSgmiZiGGJiCTFGP6AtbhQ==
X-Received: by 2002:a05:6a20:5488:b0:bf:7b3a:fd46 with SMTP id i8-20020a056a20548800b000bf7b3afd46mr38062458pzk.20.1678697940447;
        Mon, 13 Mar 2023 01:59:00 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id d7-20020a630e07000000b005038291e5cbsm4102905pgl.35.2023.03.13.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 01:59:00 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     crope@iki.fi
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: dvb-usb-v2: ec168: Fix null-ptr-deref in ec168_i2c_xfer()
Date:   Mon, 13 Mar 2023 08:58:53 +0000
Message-Id: <20230313085853.3252349-1-harperchen1110@gmail.com>
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

In ec168_i2c_xfer, msg is controlled by user. When msg[i].buf is null
and msg[i].len is zero, former checks on msg[i].buf would be passed.
If accessing msg[i].buf[0] without sanity check, null pointer deref
would happen. We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/ec168.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index 7ed0ab9e429b..0e4773fc025c 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -115,6 +115,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = READ_DEMOD;
 				req.value = 0;
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -131,6 +135,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 		} else {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_DEMOD;
 				req.value = msg[i].buf[1]; /* val */
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -139,6 +147,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = ec168_ctrl_msg(d, &req);
 				i += 1;
 			} else {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_I2C;
 				req.value = msg[i].buf[0]; /* val */
 				req.index = 0x0100 + msg[i].addr; /* I2C addr */
-- 
2.25.1

