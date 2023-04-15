Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0B6E30C2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDOKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDOKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE167ECD
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f0dd117dcso34978866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555400; x=1684147400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUbiysWc5q3o18PK65IFMxy2iBdWKZw+S63n6f+1CG0=;
        b=ZH2HN0fRPu4KGCFt8HWLptfZGmBbF2PTZFT8u6SvuciQQM35H0b/EBYSOJVTa0P38g
         7pFT4VqR/x/wHHJcIHA045U6lISAWqVGY7xGv7nQIOUJKaGOD7GQbJz2OHMUCd7yYDmW
         +/r7zra2QWAm4u/KnLFpbAnQGcFtRLrVS04+JtNch+DEe9lbfcOsRGR+0xUxHSCs3U5N
         jyl4+a9A8OrbsRqdhYDr4NSAsCCb55GRz57ejz+bkg2iNoqWIoxNE6JKaRd/eDoFeJhY
         zDIewvgO/wmsBndOmPMCbJaVXuZL6RMxuRyqWLDALekh+IftivmvxuT5f36hsT/Iqdzz
         HvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555400; x=1684147400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUbiysWc5q3o18PK65IFMxy2iBdWKZw+S63n6f+1CG0=;
        b=WNTChhbVyPnBfYyzvSnaDpP0LJTQMGvX0ler46fgQXELCQdqzc24V716R4r6lBTLLO
         rUm99Gn3UhxhHFL7GetxmqwwfMzfDN/4dahcFiA6dZiRs/kHP8yPX6f7DdlKj8iYIr8P
         Dwz+5J8Qxtezfs/wVeGc73HvUCD58rFG/B6+D8g2zwfy6ADNumo/LZR/J/wwTXg+fWeN
         qxVzhROqhgduEciGW4+LPCzUxUOLDcWlqEk+BcqVzaCkhTUAxXvD06orBqZ7jXaM74N8
         ffXkWie4pkvb27L9fTa84R8Sbg4x38FuPxTylnro1lSnbm2y5qeKHL2TI3RCbyPYLs0w
         LsIQ==
X-Gm-Message-State: AAQBX9erIWJIav2zW/6oMoj7aMFRodcO7pKcW080UuThNiSr42aVQCkK
        GfipMzX2NNl1GW0h5GGfPDC2hQ==
X-Google-Smtp-Source: AKy350YGg1nD08b9Hnsi/tpoqYEgB5/3Z8O2U2WDyI54qhxgrk5oirGicPDsua6/5/sEhTFH7SVxQw==
X-Received: by 2002:aa7:d0cc:0:b0:504:89cb:748b with SMTP id u12-20020aa7d0cc000000b0050489cb748bmr8889158edo.33.1681555399716;
        Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/15] w1: minor white-space and code style fixes
Date:   Sat, 15 Apr 2023 12:42:52 +0200
Message-Id: <20230415104304.104134-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct several coding convention violations around white-spaces:

  ERROR: spaces required around that '=' (ctx:VxV)
  WARNING: Missing a blank line after declarations
  ERROR: "foo* bar" should be "foo *bar"
  ERROR: "(foo*)" should be "(foo *)"
  WARNING: Block comments use * on subsequent lines
  WARNING: Block comments use a trailing */ on a separate line
  WARNING: please, no space before tabs
  WARNING: Missing a blank line after declarations
  ERROR: open brace '{' following struct go on the same line
  ERROR: that open brace { should be on the previous line

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/ds2482.c    |  6 ++----
 drivers/w1/masters/ds2490.c    | 13 +++++++++----
 drivers/w1/masters/matrox_w1.c |  3 +--
 drivers/w1/slaves/w1_ds2406.c  | 31 ++++++++++++++++---------------
 drivers/w1/slaves/w1_ds2408.c  | 10 +++++-----
 drivers/w1/slaves/w1_ds2413.c  |  6 ++++--
 drivers/w1/slaves/w1_ds2433.c  |  2 +-
 drivers/w1/slaves/w1_ds2780.c  |  1 +
 drivers/w1/slaves/w1_ds2781.c  |  1 +
 drivers/w1/slaves/w1_ds28e04.c |  6 ++++--
 drivers/w1/slaves/w1_ds28e17.c |  2 +-
 11 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 3d8b51316bef..806e352c8292 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -78,10 +78,8 @@ MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8
  * To set the channel, write the value at the index of the channel.
  * Read and compare against the corresponding value to verify the change.
  */
-static const u8 ds2482_chan_wr[8] =
-	{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87 };
-static const u8 ds2482_chan_rd[8] =
-	{ 0xB8, 0xB1, 0xAA, 0xA3, 0x9C, 0x95, 0x8E, 0x87 };
+static const u8 ds2482_chan_wr[8] = { 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87 };
+static const u8 ds2482_chan_rd[8] = { 0xB8, 0xB1, 0xAA, 0xA3, 0x9C, 0x95, 0x8E, 0x87 };
 
 
 /*
diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 0eb560fc0153..5f5b97e24700 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -304,6 +304,7 @@ static void ds_reset_device(struct ds_device *dev)
 	if (dev->spu_sleep) {
 		/* lower 4 bits are 0, see ds_set_pullup */
 		u8 del = dev->spu_sleep>>4;
+
 		if (ds_send_control(dev, COMM_SET_DURATION | COMM_IM, del))
 			dev_err(&dev->udev->dev,
 				"%s: Error setting duration\n", __func__);
@@ -731,7 +732,8 @@ static void ds9490r_search(void *data, struct w1_master *master,
 			break;
 
 		if (st.data_in_buffer_status) {
-			/* Bulk in can receive partial ids, but when it does
+			/*
+			 * Bulk in can receive partial ids, but when it does
 			 * they fail crc and will be discarded anyway.
 			 * That has only been seen when status in buffer
 			 * is 0 and bulk is read anyway, so don't read
@@ -743,8 +745,10 @@ static void ds9490r_search(void *data, struct w1_master *master,
 				break;
 			for (i = 0; i < err/8; ++i) {
 				found_ids[found++] = buf[i];
-				/* can't know if there will be a discrepancy
-				 * value after until the next id */
+				/*
+				 * can't know if there will be a discrepancy
+				 * value after until the next id
+				 */
 				if (found == search_limit) {
 					master->search_id = buf[i];
 					break;
@@ -760,7 +764,8 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	if (found <= search_limit) {
 		master->search_id = 0;
 	} else if (!test_bit(W1_WARN_MAX_COUNT, &master->flags)) {
-		/* Only max_slave_count will be scanned in a search,
+		/*
+		 * Only max_slave_count will be scanned in a search,
 		 * but it will start where it left off next search
 		 * until all ids are identified and then it will start
 		 * over.  A continued search will report the previous
diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index ee716c715710..94a1f3fa2dc3 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -39,8 +39,7 @@
 #define MATROX_GET_DATA			0x2B
 #define MATROX_CURSOR_CTL		0x06
 
-struct matrox_device
-{
+struct matrox_device {
 	void __iomem *base_addr;
 	void __iomem *port_index;
 	void __iomem *port_data;
diff --git a/drivers/w1/slaves/w1_ds2406.c b/drivers/w1/slaves/w1_ds2406.c
index 6c269af73c80..3bb88b51fe2b 100644
--- a/drivers/w1/slaves/w1_ds2406.c
+++ b/drivers/w1/slaves/w1_ds2406.c
@@ -27,11 +27,11 @@ static ssize_t w1_f12_read_state(
 	struct bin_attribute *bin_attr,
 	char *buf, loff_t off, size_t count)
 {
-	u8 w1_buf[6]={W1_F12_FUNC_READ_STATUS, 7, 0, 0, 0, 0};
+	u8 w1_buf[6] = {W1_F12_FUNC_READ_STATUS, 7, 0, 0, 0, 0};
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
-	u16 crc=0;
+	u16 crc = 0;
 	int i;
-	ssize_t rtnval=1;
+	ssize_t rtnval = 1;
 
 	if (off != 0)
 		return 0;
@@ -47,12 +47,12 @@ static ssize_t w1_f12_read_state(
 
 	w1_write_block(sl->master, w1_buf, 3);
 	w1_read_block(sl->master, w1_buf+3, 3);
-	for (i=0; i<6; i++)
-		crc=crc16_byte(crc, w1_buf[i]);
-	if (crc==0xb001) /* good read? */
-		*buf=((w1_buf[3]>>5)&3)|0x30;
+	for (i = 0; i < 6; i++)
+		crc = crc16_byte(crc, w1_buf[i]);
+	if (crc == 0xb001) /* good read? */
+		*buf = ((w1_buf[3]>>5)&3)|0x30;
 	else
-		rtnval=-EIO;
+		rtnval = -EIO;
 
 	mutex_unlock(&sl->master->bus_mutex);
 
@@ -65,10 +65,10 @@ static ssize_t w1_f12_write_output(
 	char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
-	u8 w1_buf[6]={W1_F12_FUNC_WRITE_STATUS, 7, 0, 0, 0, 0};
-	u16 crc=0;
+	u8 w1_buf[6] = {W1_F12_FUNC_WRITE_STATUS, 7, 0, 0, 0, 0};
+	u16 crc = 0;
 	int i;
-	ssize_t rtnval=1;
+	ssize_t rtnval = 1;
 
 	if (count != 1 || off != 0)
 		return -EFAULT;
@@ -83,12 +83,12 @@ static ssize_t w1_f12_write_output(
 	w1_buf[3] = (((*buf)&3)<<5)|0x1F;
 	w1_write_block(sl->master, w1_buf, 4);
 	w1_read_block(sl->master, w1_buf+4, 2);
-	for (i=0; i<6; i++)
-		crc=crc16_byte(crc, w1_buf[i]);
-	if (crc==0xb001) /* good read? */
+	for (i = 0; i < 6; i++)
+		crc = crc16_byte(crc, w1_buf[i]);
+	if (crc == 0xb001) /* good read? */
 		w1_write_8(sl->master, 0xFF);
 	else
-		rtnval=-EIO;
+		rtnval = -EIO;
 
 	mutex_unlock(&sl->master->bus_mutex);
 	return rtnval;
@@ -133,6 +133,7 @@ static int w1_f12_add_slave(struct w1_slave *sl)
 static void w1_f12_remove_slave(struct w1_slave *sl)
 {
 	int i;
+
 	for (i = NB_SYSFS_BIN_FILES - 1; i >= 0; --i)
 		sysfs_remove_bin_file(&sl->dev.kobj,
 			&(w1_f12_sysfs_bin_files[i]));
diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 7fa911989193..56f822a1dfdb 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -35,12 +35,12 @@
 
 #define W1_F29_SUCCESS_CONFIRM_BYTE        0xAA
 
-static int _read_reg(struct w1_slave *sl, u8 address, unsigned char* buf)
+static int _read_reg(struct w1_slave *sl, u8 address, unsigned char *buf)
 {
 	u8 wrbuf[3];
-	dev_dbg(&sl->dev,
-			"Reading with slave: %p, reg addr: %0#4x, buff addr: %p",
-			sl, (unsigned int)address, buf);
+
+	dev_dbg(&sl->dev, "Reading with slave: %p, reg addr: %0#4x, buff addr: %p",
+		sl, (unsigned int)address, buf);
 
 	if (!buf)
 		return -EINVAL;
@@ -292,7 +292,7 @@ static int w1_f29_disable_test_mode(struct w1_slave *sl)
 {
 	int res;
 	u8 magic[10] = {0x96, };
-	u64 rn = le64_to_cpu(*((u64*)&sl->reg_num));
+	u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
 
 	memcpy(&magic[1], &rn, 8);
 	magic[9] = 0x3C;
diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index c8cfac555b48..bf4a72aae28a 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -99,8 +99,10 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	if (w1_reset_select_slave(sl))
 		goto out;
 
-	/* according to the DS2413 datasheet the most significant 6 bits
-	   should be set to "1"s, so do it now */
+	/*
+	 * according to the DS2413 datasheet the most significant 6 bits
+	 * should be set to "1"s, so do it now
+	 */
 	*buf = *buf | 0xFC;
 
 	while (retries--) {
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 6134ca2f37fe..23cd099d032b 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -115,7 +115,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	}
 	memcpy(buf, &data->memory[off], count);
 
-#else 	/* CONFIG_W1_SLAVE_DS2433_CRC */
+#else	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 	/* read directly from the EEPROM */
 	if (w1_reset_select_slave(sl)) {
diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index 9dcb5a54f7fc..3cde1bb1886b 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -91,6 +91,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
+
 	return w1_ds2780_io(dev, buf, off, count, 0);
 }
 
diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index 2cb7c020b607..e418484b4a49 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -88,6 +88,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 			     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
+
 	return w1_ds2781_io(dev, buf, off, count, 0);
 }
 
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index f54d6afd79c3..2854b8b9e93f 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -198,8 +198,10 @@ static int w1_f1C_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	wrbuf[3] = es;
 
 	for (i = 0; i < sizeof(wrbuf); ++i) {
-		/* issue 10ms strong pullup (or delay) on the last byte
-		   for writing the data from the scratchpad to EEPROM */
+		/*
+		 * issue 10ms strong pullup (or delay) on the last byte
+		 * for writing the data from the scratchpad to EEPROM
+		 */
 		if (w1_strong_pullup && i == sizeof(wrbuf)-1)
 			w1_next_pullup(sl->master, tm);
 
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index aed10b72fc99..fdbaf77620ac 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -59,7 +59,7 @@ MODULE_PARM_DESC(stretch, "Default I2C stretch value to be set when a DS28E17 is
 /*
  * Maximum number of I2C bytes to transfer within one CRC16 protected onewire
  * command.
- * */
+ */
 #define W1_F19_WRITE_DATA_LIMIT 255
 
 /* Maximum number of I2C bytes to read with one onewire command. */
-- 
2.34.1

