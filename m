Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28EC5EDF36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiI1Ous (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiI1OuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:50:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE218689D;
        Wed, 28 Sep 2022 07:50:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so1407279wma.3;
        Wed, 28 Sep 2022 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TDlzEIb+M6CPHiaVMqXJZzEfCntRBIpPMm1M+NjSybU=;
        b=deUaeO5m4FljkO6EVha8UK7BH08sIS6PEVcg2ZBKtOXW3VgnLFqnhHau0Xl7I1y1R+
         7/ehszoBLYlt+iFh8j3tiBdQESTbwqTjgVoobn7rQUJyacz8tm9YUHg/8EbA9Ke7wCtZ
         YH8BDFA5bt3S3WIr5obADRq7yxn1mYCd1Tb56rcIFpoAWorMuq3scnkMdcu9oZPb4J9f
         l0vbfZS9hN5CDzNIKBbyq1C+e8OyR0Oz7jyA8f/VqfzF0dVf/Y4Rnrd5EjmDqzWl5JHv
         3y2AKzgjUdOkioH5B/6/HlXZfkdLYbOK4KLpdUmVI30SQjchkakwJLJQDFt/Ts3XeWLA
         rpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TDlzEIb+M6CPHiaVMqXJZzEfCntRBIpPMm1M+NjSybU=;
        b=38vxrQ0OuEeZetmB9vp5SRUtHescgXklzd5GE791D48VjtRULfUCh2YzFPivvhc8je
         QW9oP3RL0vZ82/YqfYKOW+Wtja2+1//ZWkZ5O+fY7GJTPqw5COWK32o67krUpE7OHmz8
         ub7cDOEk/qNpoTbGI3eqqi0ikmEW029Jhoatt138F6VMWUScNH4Z4fFG7g3PZ0DPyhPO
         ho13i5mPhO2fybwRzVEyof+BfusBgUpQidLj62irgmW2dKLWkDlcjq250qbOZeh5WZWF
         dPFc0EmJjJ+LU6qsEF3vSZ24pEWUZAJ/SxC5C+XDfOuIQ8gYTvZq6P3v0V2cM+O7tPW4
         O3oQ==
X-Gm-Message-State: ACrzQf1ByzOaebVPKopChJ7pGJfN2e2rrh3SDvRYupyj2ASI6EnQtqPP
        CiGNcfcCHBXAvAxWpaAjzjQW55UKv/uS1g==
X-Google-Smtp-Source: AMsMyM7ACX8BWjxAHcPlCJ9YL2XU3mdCk5XCu08iupdKaJjQ8LkE4RC8ADycFYpo/zLgdOasp+W2Mg==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id k4-20020a7bc404000000b003b4facacf50mr7129617wmi.67.1664376609995;
        Wed, 28 Sep 2022 07:50:09 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:50:09 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Enrik Berkhan <Enrik.Berkhan@inka.de>
Subject: [PATCH v2 6/7] HID: ft260: do not populate /dev/hidraw device
Date:   Wed, 28 Sep 2022 17:48:53 +0300
Message-Id: <20220928144854.5580-7-michael.zaidman@gmail.com>
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

Do not populate the /dev/hidraw on ft260 interfaces when the hid-ft260
driver is loaded.

$ sudo insmod hid-ft260.ko
$ ls /dev/hidraw*
/dev/hidraw0

$ sudo rmmod hid-ft260.ko
$ ls /dev/hidraw*
/dev/hidraw0  /dev/hidraw1  /dev/hidraw2

Reported-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index c7c3a9d395a2..bb9f4e07c21d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -938,7 +938,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "failed to start HID HW\n");
 		return ret;
@@ -965,6 +965,10 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret <= 0)
 		goto err_hid_close;
 
+	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
+		hdev->version >> 8, hdev->version & 0xff, hdev->name,
+		hdev->phys);
+
 	hid_set_drvdata(hdev, dev);
 	dev->hdev = hdev;
 	dev->adap.owner = THIS_MODULE;
@@ -973,8 +977,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.quirks = &ft260_i2c_quirks;
 	dev->adap.dev.parent = &hdev->dev;
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "FT260 usb-i2c bridge on hidraw%d",
-		 ((struct hidraw *)hdev->hidraw)->minor);
+		 "FT260 usb-i2c bridge");
 
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
-- 
2.34.1

