Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684E6F9A9A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEGRcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjEGRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:32:05 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF1A1BD1;
        Sun,  7 May 2023 10:32:01 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QDs1B61f7z9skr;
        Sun,  7 May 2023 19:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683480718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQHQgsnbPJTgsXPCqG4AqQGuAPuZsFrH5o3VxE1rTc4=;
        b=L8DHt6oqMQ8+MSjhjgvR8ROjEp/xzp//i4ahR1oot9wJb9ksy9p4mq7TVNSDmY2bjQffzU
        6PyzNP/QvBRbBiXG2THMOqGShi6WG5B7bTACe2E3Ew4b+GTYPzawtWWKe41tQBA1qZn33/
        P2kW/icoEIwE3GyDua1Hmep0/3lRWUZ9c8qNlgMbDP/CdAMNjUEzo2IfBR3VWmAs3lZXZV
        5pg6FsY0mGznF5gKGBvmXpDavzgcnwGuadaCdgRwvn5Dw6EBo51DyiibPGjxq6WgAe9Z3T
        LpWi0Sh1FM7IdQBqjL6FwrOI2wMAAOnzxSiKNGPl3qjEwyibISoTU/mobYdAqQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     pavel@ucw.cz, quic_fenglinw@quicinc.com, lee@kernel.org
Cc:     trix@redhat.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 2/2] leds: flash: leds-qcom-flash: disable LED when changing brightness
Date:   Sun,  7 May 2023 19:29:41 +0200
Message-Id: <20230507172941.364852-3-me@dylanvanassche.be>
In-Reply-To: <20230507172941.364852-1-me@dylanvanassche.be>
References: <20230507172941.364852-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PMI8998 PMIC requires the LED to be disabled when configuring
the brightness. Always disable the LED when setting the brightness and
re-enable it afterwards.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/leds/flash/leds-qcom-flash.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 16045b5d89b1..c8d41a3caf38 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -417,6 +417,14 @@ static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
 	bool enable = !!brightness;
 	int rc;
 
+	rc = set_flash_strobe(led, SW_STROBE, false);
+	if (rc)
+		return rc;
+
+	rc = set_flash_module_en(led, false);
+	if (rc)
+		return rc;
+
 	rc = set_flash_current(led, current_ma, TORCH_MODE);
 	if (rc)
 		return rc;
-- 
2.40.1

