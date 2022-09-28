Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E45EDF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiI1OuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiI1Ott (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22E96B65D;
        Wed, 28 Sep 2022 07:49:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so20234661wrq.1;
        Wed, 28 Sep 2022 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/sHzX4jPq66wDshKJtO+yRtib7ejS/fTeaRY05KXCxQ=;
        b=kD3Tm3/ZYq83UvFaYGjGmMdjJV3figBwRycsRiReOh3Ff+pS//1AynybEz3OBiq99R
         vQDjM91BgADRE9eWdm+Rq+03O7tSBTgWvPW5OJiwqC0L943HtNjWBigY+V9Sl6XbIpwU
         r95fN41E1nUkonFVbgINrhE0ujRefwoyatQxuIA4eQEwPFW+Me1ZB6HWZkpv4sVcs4tV
         gqvbWuJDDa3dqDM1p5cQpBLM8jfErCelx1kGU92C8mJknJGCZ87K/kcDHkostmyfMO7g
         JqSnX1nCazD3ohcv9cLSvWn/zEGnrH9YuKNFb7z41TDZh8ROcUQDNnPtb10vsAz/x2Gf
         cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/sHzX4jPq66wDshKJtO+yRtib7ejS/fTeaRY05KXCxQ=;
        b=Q/hM+16XaFlxvqvWZ8+A+CIppnfKxeSmKwqDxXq9a2dlwfB9lKVOO8VDy4GD37wZqa
         T4FtKUDmBgxFLL+fqnAzE9giexgMZG02MNdQFAWV0JpaTPeXcw9ig/H7TzWeVdg6yZXh
         PJ/xAAu2SyBKjIBIrzh8Rpt10x0SNNfz4Mq+XTmuLK98cQd0lvj4Kc5cLeQWkNfi/VNX
         jcP2BAsbooPPav5LBe7C7uibqNrdXsmDdcNQiSFODRdIiixEZYjHNpjxqW31ENkeUFJY
         KdCQ6go2GURGgTMsFH39kBsU7aXUhHtpAsycJbwu/vInTL354RIpM9jHY1PboAReQoOc
         IDGw==
X-Gm-Message-State: ACrzQf06P8hp1K59jkSUfyOM46+0n2LH7Zcy7vjxbvrztNDDpqGD8Amz
        nJfBKPxw0dmQC1EN034WXtU=
X-Google-Smtp-Source: AMsMyM5uxoxPgjphdgK6TFPgvDnC8DHaSWC7GROn3UF7l7o8mKY8NrMSw4itSJ088/mb7aAYhN4AVA==
X-Received: by 2002:adf:e609:0:b0:22a:a6fd:cfe1 with SMTP id p9-20020adfe609000000b0022aa6fdcfe1mr21874055wrm.0.1664376582023;
        Wed, 28 Sep 2022 07:49:42 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:41 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2 3/7] HID: ft260: support i2c writes larger than HID report size
Date:   Wed, 28 Sep 2022 17:48:50 +0300
Message-Id: <20220928144854.5580-4-michael.zaidman@gmail.com>
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

To support longer than one HID report size write, the driver splits a
single i2c message data payload into multiple i2c messages of HID report
size. However, it does not replicate the offset bytes within the EEPROM
chip in every consequent HID report because it is not and should not be
aware of the EEPROM type. It breaks the i2c write message integrity and
causes the EEPROM device not to acknowledge the second HID report keeping
the i2c bus busy until the ft260 controller reports failure.

This patch preserves the i2c write message integrity by manipulating the
i2c flag bits across multiple HID reports to be seen by the EEPROM device
as a single i2c write transfer.

Before:

$ sudo ./i2cperf -f 2 -o 2 -s 64 -r 0-0xff 13 0x51 -S
Error: Sending messages failed: Input/output error

[  +3.667741] ft260_i2c_write: rep 0xde addr 0x51 off 0 len 60 d[0] 0x0
[  +0.007330] ft260_hid_output_report_check_status: wait 6400 usec, len 64
[  +0.000203] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_write: rep 0xd1 addr 0x51 off 60 len 6 d[0] 0x0
[  +0.002337] ft260_hid_output_report_check_status: wait 1000 usec, len 10
[  +0.000157] ft260_xfer_status: bus_status 0x2e, clock 100
[  +0.000241] ft260_i2c_reset: done
[  +0.000003] ft260_i2c_write: failed to start transfer, ret -5

After:

$ sudo ./i2cperf -f 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S

  Fill block with increment via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  58986           86             256           2           128

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
 drivers/hid/hid-ft260.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 44106cadd746..bfda5b191a3a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -378,41 +378,50 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 }
 
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
-			   int data_len, u8 flag)
+			   int len, u8 flag)
 {
-	int len, ret, idx = 0;
+	int ret, wr_len, idx = 0;
+	bool first = true;
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->write_buf;
 
 	do {
-		if (data_len <= FT260_WR_DATA_MAX)
-			len = data_len;
-		else
-			len = FT260_WR_DATA_MAX;
+		rep->flag = 0;
+		if (first) {
+			rep->flag = FT260_FLAG_START;
+			first = false;
+		}
+
+		if (len <= FT260_WR_DATA_MAX) {
+			wr_len = len;
+			if (flag == FT260_FLAG_START_STOP)
+				rep->flag |= FT260_FLAG_STOP;
+		} else {
+			wr_len = FT260_WR_DATA_MAX;
+		}
 
-		rep->report = FT260_I2C_DATA_REPORT_ID(len);
+		rep->report = FT260_I2C_DATA_REPORT_ID(wr_len);
 		rep->address = addr;
-		rep->length = len;
-		rep->flag = flag;
+		rep->length = wr_len;
 
-		memcpy(rep->data, &data[idx], len);
+		memcpy(rep->data, &data[idx], wr_len);
 
-		ft260_dbg("rep %#02x addr %#02x off %d len %d d[0] %#02x\n",
-			  rep->report, addr, idx, len, data[0]);
+		ft260_dbg("rep %#02x addr %#02x off %d len %d wlen %d flag %#x d[0] %#02x\n",
+			  rep->report, addr, idx, len, wr_len,
+			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   len + 4);
+							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed to start transfer, ret %d\n",
-				__func__, ret);
+			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 			return ret;
 		}
 
-		data_len -= len;
-		idx += len;
+		len -= wr_len;
+		idx += wr_len;
 
-	} while (data_len > 0);
+	} while (len > 0);
 
 	return 0;
 }
-- 
2.34.1

