Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113685EDF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiI1OuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiI1Ot7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891E876AB;
        Wed, 28 Sep 2022 07:49:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so20235294wrq.1;
        Wed, 28 Sep 2022 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BQ0d6O8gcaPdhIkSTZVgDmJh/2nyyRjb1Qm8sfiyfJQ=;
        b=f+rR02DKnHKA9Q+qCxphXhbLCLsOgFOseljQsaFXj+O+UWoHraTDje2rbyRkwT6I+5
         e1aCmSHepiYwjbKEhwxhOTlyNNPRIY5TDlYuc5pwc8YL/XSkM4TRDSq0WgfgxL+m48LU
         /05wlTo75o9Q9V2zHehs/TN+7By86zV2n+3EV2BGm2zHcDP5Ddzj8WZKa70A+xPpMW22
         gp50Q7wgLAeYJsl6zvUCn0/AOP0kG+2saOmPrfeKcBwt5otDdSI2oyYF+7OAes5e36E1
         SeoCtMjhcMklalILRMoeyzGdYDw1jwsd8w83wpXSQaz99WcNVUP0u7a0eeW36oIiAjYN
         Hp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BQ0d6O8gcaPdhIkSTZVgDmJh/2nyyRjb1Qm8sfiyfJQ=;
        b=H2XyImmEQB2uhExsB7pxz3hPen8w3o9B2MvivzrM2PcCrs+o7c6xlxIXUTPpsKakdO
         EMQQaLl9qi2ewKzKGHrzGqGwKNAz57M/n7Eed5on8WtzOq9bUnqaovsIPwGnXoEzfBxx
         jV3yZbCwB/JVh9YEOir6TrrjX+PwV5Y0WCNc/5E12M+cn1Age/X7nmm7/MmNEW/FhEin
         uLWAXYv9DsmEjwAvHaQF+TjFwgVtlhiMuNx9Q6QOsGSjtEh3eLzRY1am3bvY1XZSEP1p
         bZUBc/L0fEn3TVsYRyhEDnI2dM6PorRQLvwOONFH21sWFtdmTOIgFDACPgnhzfb4B4GP
         mhcQ==
X-Gm-Message-State: ACrzQf2eW4slVEAjozN0ylmKJeUCIJygCSr/E5w/43oQ6TlepEmdvpeP
        zq7TCtm2ckJPn6oK1WYv1Ws=
X-Google-Smtp-Source: AMsMyM4LLUkXF1KQaYshEqj77K2/XP5SHZXG34IhhVnfIrtw9m02R7v9ohjU1C9i8FRhX3kCnH/44A==
X-Received: by 2002:a5d:5b18:0:b0:22b:1c7:6f8 with SMTP id bx24-20020a5d5b18000000b0022b01c706f8mr20872476wrb.502.1664376590666;
        Wed, 28 Sep 2022 07:49:50 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:50 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2 4/7] HID: ft260: support i2c reads greater than HID report size
Date:   Wed, 28 Sep 2022 17:48:51 +0300
Message-Id: <20220928144854.5580-5-michael.zaidman@gmail.com>
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

A random i2c read operation in EEPROM devices is implemented as a dummy
write operation, followed by a current address read operation. The dummy
write operation is used to load the target byte or word address (a.k.a
offset) into the offset counter, from which the subsequent read operation
then reads.

To support longer than one HID report size random read, the ft260 driver
issues multiple pairs of i2c write offset + read data transactions of HID
report size so that the EEPROM device sees many i2c random read requests
from different offsets.

Two issues with the current implementation:
- This approach suffers from extra overhead caused by writing offset
  requests.
- Necessity to handle offset per HID report in big-endian representation
  as EEPROM devices expect. The current implementation does not do it and
  correctly handles the reads up to 60 bytes only.

This patch addresses both issues by implementing more efficient approach.
It issues a single i2c read request of up to the EEPROM page size and then
waits for the data to arrive in multiple HID reports. For example, to read
the 256 bytes from a 24LC512 chip, which has 128 bytes page size, the old
method performs six ft260_i2c_write_read transactions while the new - two
only.

Before:

$ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S

  Read block via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  40803           85             256           2           128

Kernel log:

[  +2.376308] ft260_i2c_write_read: read_off 0x0 left_len 128 len 60
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.000707] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000173] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 60
[  +0.008660] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000156] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000001] ft260_i2c_write_read: read_off 0x3c left_len 68 len 60
[  +0.000001] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x3c
[  +0.001034] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000191] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 60
[  +0.008614] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000203] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000001] ft260_i2c_write_read: read_off 0x78 left_len 8 len 8
[  +0.000001] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x78
[  +0.000987] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000192] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 8
[  +0.002614] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000200] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.012511] ft260_i2c_write_read: read_off 0x8000 left_len 128 len 60
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.001456] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000207] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 60
[  +0.008625] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000203] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000002] ft260_i2c_write_read: read_off 0x803c left_len 68 len 60
[  +0.000001] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x3c
[  +0.000991] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000196] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 60
[  +0.008621] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000202] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000001] ft260_i2c_write_read: read_off 0x8078 left_len 8 len 8
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x78
[  +0.000979] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000151] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 8
[  +0.002644] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000141] ft260_xfer_status: bus_status 0x20, clock 100

After:

$ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S

  Read block via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  43990           85             256           2           128

Kernel log:

[  +1.464346] ft260_i2c_write_read: off 0x0 rlen 128 wlen 2
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.001653] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000188] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 60 flag 0x3
[  +0.008609] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000157] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 68 rlen 60 flag 0x0
[  +0.008840] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000203] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 8 rlen 8 flag 0x4
[  +0.002794] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000201] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.015171] ft260_i2c_write_read: off 0x80 rlen 128 wlen 2
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.000764] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000231] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000148] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 60 flag 0x3
[  +0.008488] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000205] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 68 rlen 60 flag 0x0
[  +0.008795] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000176] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 8 rlen 8 flag 0x4
[  +0.002819] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000167] ft260_xfer_status: bus_status 0x20, clock 100

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
 drivers/hid/hid-ft260.c | 133 ++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 61 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index bfda5b191a3a..cb8f1782d1f0 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -460,49 +460,68 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
+	u16 rd_len;
+	int timeout, ret;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
-	int timeout;
-	int ret;
+	bool first = true;
 
-	if (len > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
-		return -EINVAL;
-	}
+	do {
+		if (first) {
+			if (flag & FT260_FLAG_START_REPEATED)
+				flag = FT260_FLAG_START_REPEATED;
+			else
+				flag = FT260_FLAG_START;
+			first = false;
+		} else {
+			flag = 0;
+		}
 
-	dev->read_idx = 0;
-	dev->read_buf = data;
-	dev->read_len = len;
+		if (len <= FT260_RD_DATA_MAX) {
+			rd_len = len;
+			flag |= FT260_FLAG_STOP;
+		} else {
+			rd_len = FT260_RD_DATA_MAX;
+		}
 
-	rep.report = FT260_I2C_READ_REQ;
-	rep.length = cpu_to_le16(len);
-	rep.address = addr;
-	rep.flag = flag;
+		dev->read_idx = 0;
+		dev->read_buf = data;
+		dev->read_len = rd_len;
 
-	ft260_dbg("rep %#02x addr %#02x len %d\n", rep.report, rep.address,
-		  rep.length);
+		rep.report = FT260_I2C_READ_REQ;
+		rep.length = cpu_to_le16(rd_len);
+		rep.address = addr;
+		rep.flag = flag;
 
-	reinit_completion(&dev->wait);
+		ft260_dbg("rep %#02x addr %#02x len %d rlen %d flag %#x\n",
+			  rep.report, rep.address, len, rd_len, flag);
 
-	ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
-	if (ret < 0) {
-		hid_err(hdev, "%s: failed to start transaction, ret %d\n",
-			__func__, ret);
-		return ret;
-	}
+		reinit_completion(&dev->wait);
 
-	timeout = msecs_to_jiffies(5000);
-	if (!wait_for_completion_timeout(&dev->wait, timeout)) {
-		ft260_i2c_reset(hdev);
-		return -ETIMEDOUT;
-	}
+		ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
+		if (ret < 0) {
+			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			return ret;
+		}
 
-	ret = ft260_xfer_status(dev);
-	if (ret == 0)
-		return 0;
+		timeout = msecs_to_jiffies(5000);
+		if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+			ft260_i2c_reset(hdev);
+			return -ETIMEDOUT;
+		}
 
-	ft260_i2c_reset(hdev);
-	return -EIO;
+		ret = ft260_xfer_status(dev);
+		if (ret < 0) {
+			ft260_i2c_reset(hdev);
+			return -EIO;
+		}
+
+		len -= rd_len;
+		data += rd_len;
+
+	} while (len > 0);
+
+	return 0;
 }
 
 /*
@@ -513,45 +532,37 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
  */
 static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 {
-	int len, ret;
-	u16 left_len = msgs[1].len;
-	u8 *read_buf = msgs[1].buf;
+	int ret;
+	int wr_len = msgs[0].len;
+	int rd_len = msgs[1].len;
+	struct hid_device *hdev = dev->hdev;
 	u8 addr = msgs[0].addr;
 	u16 read_off = 0;
-	struct hid_device *hdev = dev->hdev;
 
-	if (msgs[0].len > 2) {
-		hid_err(hdev, "%s: unsupported wr len: %d\n", __func__,
-			msgs[0].len);
+	if (wr_len > 2) {
+		hid_err(hdev, "%s: invalid wr_len: %d\n", __func__, wr_len);
 		return -EOPNOTSUPP;
 	}
 
-	memcpy(&read_off, msgs[0].buf, msgs[0].len);
-
-	do {
-		if (left_len <= FT260_RD_DATA_MAX)
-			len = left_len;
+	if (ft260_debug) {
+		if (wr_len == 2)
+			read_off = be16_to_cpu(*(u16 *)msgs[0].buf);
 		else
-			len = FT260_RD_DATA_MAX;
-
-		ft260_dbg("read_off %#x left_len %d len %d\n", read_off,
-			  left_len, len);
-
-		ret = ft260_i2c_write(dev, addr, (u8 *)&read_off, msgs[0].len,
-				      FT260_FLAG_START);
-		if (ret < 0)
-			return ret;
+			read_off = *msgs[0].buf;
 
-		ret = ft260_i2c_read(dev, addr, read_buf, len,
-				     FT260_FLAG_START_STOP);
-		if (ret < 0)
-			return ret;
+		pr_info("%s: off %#x rlen %d wlen %d\n", __func__,
+			read_off, rd_len, wr_len);
+	}
 
-		left_len -= len;
-		read_buf += len;
-		read_off += len;
+	ret = ft260_i2c_write(dev, addr, msgs[0].buf, wr_len,
+			      FT260_FLAG_START);
+	if (ret < 0)
+		return ret;
 
-	} while (left_len > 0);
+	ret = ft260_i2c_read(dev, addr, msgs[1].buf, rd_len,
+			     FT260_FLAG_START_STOP_REPEATED);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.34.1

