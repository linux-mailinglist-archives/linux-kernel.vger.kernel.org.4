Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC875EDF38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiI1OvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiI1Ou0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:50:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794496FA2A;
        Wed, 28 Sep 2022 07:50:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so12431324wrb.13;
        Wed, 28 Sep 2022 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G2Ds7PBltmbT3ftDD3p3qVVqVDz6MYqMgst02mWavxo=;
        b=FlJoC7mk81FTVS4maQ9EmnxE4r1FD+zg+BOudTTciRsH1WbdpWAVQ1imTIvyes/esm
         EUFXZtCTGCWeCVECN1cG8lruXQcu1szlvpmhXCDSH1I8pG/9CbtdifKU3c9mFZtgIkcM
         edJvrt+6xU0HnIluDEpCUGJQgqF1YUmmHjjgjwl7jZh1FofQxVkYK8araH+IbPTWKzrR
         ecRFqorUHcqJ6EWu/aA8jJQPCgMnN05f9h0HdVytZNRcLDXcYxzyh5LWaH42WZ35uKw/
         o+PTIXmuM1kZ2Hm2X/HLg72Xo7CN556E3gg5S1ZmkzK47ZaE4wPFGL/pT01PDtyo+bTj
         0sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G2Ds7PBltmbT3ftDD3p3qVVqVDz6MYqMgst02mWavxo=;
        b=bzZkQfrDqczYzNJhHPQOam9JVN6DRl6bsB3Jt8D91R3+RXRLI/tZcimNzYtKsYiMpl
         jXv79QpFNoAXR0nMWu0sZCahm0y7f0pcqZGG9QZFwMARYvGzHjF/xqhMd5UEVEE9HXaa
         qrw52dslbxreaiQEWoZQ0n+gde812mvRlZC1M7yB0TxyhOvShjbQ+ad+afs8u5a2/Zx1
         3E94mIM3IbHrok5TOsD98idGgTwtYCn9P2KPPTaMLfeq2WmeBwHZjrvFnSVzX9PDmsmn
         xXDnnPdZBejPmJ//oMOJzbhJ3dDnVWglRYfCvpvVTEunF9rwhq/kh0v+yOAoOyQafKX0
         9QDQ==
X-Gm-Message-State: ACrzQf0tr4+Ro77E/5j+g1Rjj3mIq6+T+F2xjjs8BrLTVUB/+ZTHig9M
        SiBU6RwrSkiBpa7CaAuiwd4=
X-Google-Smtp-Source: AMsMyM7svr+dAiUj+4m6pEjJmz39wFM49lIO3wKDF8YTFG51QxykK5CZOas0VFkRm8JFj9/u2MPiEg==
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id r2-20020a5d6c62000000b0022a2f59cb7dmr20967722wrz.405.1664376614760;
        Wed, 28 Sep 2022 07:50:14 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:50:14 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Enrik Berkhan <Enrik.Berkhan@inka.de>
Subject: [PATCH v2 7/7] HID: ft260: skip unexpected HID input reports
Date:   Wed, 28 Sep 2022 17:48:54 +0300
Message-Id: <20220928144854.5580-8-michael.zaidman@gmail.com>
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

The FT260 is not supposed to generate unexpected HID reports. However,
in theory, the unsolicited HID Input reports can be issued by a specially
crafted malicious USB device masquerading as FT260 when the attacker has
physical access to the USB port. In this case, the read_buf pointer points
to the final data portion of the previous I2C Read transfer, and the memcpy
invoked in the ft260_raw_event() will try copying the content of the
unexpected report into the wrong location.

This commit sets the Read buffer pointer to NULL on the I2C Read
transaction completion and checks it in the ft260_raw_event() to detect
and skip the unsolicited Input report.

Reported-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index bb9f4e07c21d..a162e9d14a08 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -457,7 +457,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
 	u16 rd_len;
-	int timeout, ret;
+	int timeout, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	bool first = true;
@@ -480,10 +480,6 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			rd_len = FT260_RD_DATA_MAX;
 		}
 
-		dev->read_idx = 0;
-		dev->read_buf = data;
-		dev->read_len = rd_len;
-
 		rep.report = FT260_I2C_READ_REQ;
 		rep.length = cpu_to_le16(rd_len);
 		rep.address = addr;
@@ -494,22 +490,30 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 		reinit_completion(&dev->wait);
 
+		dev->read_idx = 0;
+		dev->read_buf = data;
+		dev->read_len = rd_len;
+
 		ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 		if (ret < 0) {
 			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
-			return ret;
+			goto ft260_i2c_read_exit;
 		}
 
 		timeout = msecs_to_jiffies(5000);
 		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+			ret = -ETIMEDOUT;
 			ft260_i2c_reset(hdev);
-			return -ETIMEDOUT;
+			goto ft260_i2c_read_exit;
 		}
 
+		dev->read_buf = NULL;
+
 		ret = ft260_xfer_status(dev);
 		if (ret < 0) {
+			ret = -EIO;
 			ft260_i2c_reset(hdev);
-			return -EIO;
+			goto ft260_i2c_read_exit;
 		}
 
 		len -= rd_len;
@@ -517,7 +521,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	} while (len > 0);
 
-	return 0;
+ft260_i2c_read_exit:
+	dev->read_buf = NULL;
+	return ret;
 }
 
 /*
@@ -1035,6 +1041,13 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
 			  xfer->length);
 
+		if ((dev->read_buf == NULL) ||
+		    (xfer->length > dev->read_len - dev->read_idx)) {
+			hid_err(hdev, "unexpected report %#02x, length %d\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
+
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
@@ -1043,10 +1056,9 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			complete(&dev->wait);
 
 	} else {
-		hid_err(hdev, "unknown report: %#02x\n", xfer->report);
-		return 0;
+		hid_err(hdev, "unhandled report %#02x\n", xfer->report);
 	}
-	return 1;
+	return 0;
 }
 
 static struct hid_driver ft260_driver = {
-- 
2.34.1

