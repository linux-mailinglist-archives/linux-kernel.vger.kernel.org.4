Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE25EDF33
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiI1Oup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiI1OuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:50:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63F97D7A;
        Wed, 28 Sep 2022 07:50:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so20219560wrm.2;
        Wed, 28 Sep 2022 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VjzbsqyM1APsENn4Ek+I+pGVYJYx6nNdMM0neoVN9ZM=;
        b=WPIKMykDY++bP0uYimAivAUijxifE++Ikj0sAqcd8xClKlDR0ADDj1xR1PwMHeurXm
         cByqoA81MLdYsGmJ2rRu++dHE9ar+aawGjM5pOXwnfAmfmzeqiBTmHZajOKh/KyqaIxJ
         IktEmBWX9kkD0p6aDYWk+iDbiEBSCsHL6xy/tqsjGZiGdVpMX2R1SdEN/toF/UtqUu3G
         jbKObuVK5SdmEFiXENC6dl7+XLvuv+VILRgG0+vIw/Jnvk0n+wo8ghgYtA/5EzleuwDT
         Ix+v2sKKuhsTUWbaPHsuophz6Rwxsnd8jqqwVirbHiUK2GjrhPlXeMXSA/+1VxubkT3G
         Bz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VjzbsqyM1APsENn4Ek+I+pGVYJYx6nNdMM0neoVN9ZM=;
        b=pD+hjvAVNXQDZru3s157pmIgCUzQOIyJ1ud/3cfKtIEhM0zfcdDEUsis2YIy+n3hmR
         XJjY8lDQ936jYRWdl7G6LpmEOhdQcfHL08jZLG9hml953jFy99ML65h8a7AwvA6QXExG
         f/Wf4BeFbvHa1ThP8JRpBlYeE/Gl+N4JRaCMc6UOS8DBfxqpUIHxNEokT9iAnzevRdr4
         ctZ3HwkIsvpK0YHZVlEu6ZaXxUSQvT6Iifigc58+wtIsoS2rjG7WtU5f1DdQ2liCSYQx
         GRPhlN8ktch4FxUfkzif/rOJm8Q9mpbjC5xiF2arHCsTtRR2Fz4gHuPYUaSeaVOESNbk
         HcTA==
X-Gm-Message-State: ACrzQf3/BDdU/tpGZKyraxJCjFx3YBboKr8hTMJWXO8FOtQhzkW5+LRy
        m2Uxq5XEPvTSMydb2S7fY1c=
X-Google-Smtp-Source: AMsMyM5crwY2/LlXIa0Qudznuc7W2yW1rFQ1trCeM3LK1Uz5y7JltsJcBpgciPxzBrOXDk3XBnFBIQ==
X-Received: by 2002:a05:6000:1864:b0:22a:e349:f031 with SMTP id d4-20020a056000186400b0022ae349f031mr21202406wri.476.1664376604914;
        Wed, 28 Sep 2022 07:50:04 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:50:04 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2 5/7] HID: ft260: improve i2c large reads performance
Date:   Wed, 28 Sep 2022 17:48:52 +0300
Message-Id: <20220928144854.5580-6-michael.zaidman@gmail.com>
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

The patch increases the read buffer size to 128 bytes. It reduces the
number of ft260_i2c_read calls by three and improves the large data
chunks' read performance by about 10%.

Before:

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

After:

$ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S

  Read block via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  49316           85             256           2           128

Kernel log:

[  +1.447360] ft260_i2c_write_read: off 0x0 rlen 128 wlen 2
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.001633] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000190] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 128 flag 0x7
[  +0.008617] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.008033] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000954] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000208] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.015853] ft260_i2c_write_read: off 0x80 rlen 128 wlen 2
[  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.001182] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000180] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 128 flag 0x7
[  +0.008575] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.008014] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.001001] ft260_raw_event: i2c resp: rep 0xd1 len 8
[  +0.000223] ft260_xfer_status: bus_status 0x20, clock 100

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
 drivers/hid/hid-ft260.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cb8f1782d1f0..c7c3a9d395a2 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -30,12 +30,8 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
-/*
- * The input report format assigns 62 bytes for the data payload, but ft260
- * returns 60 and 2 in two separate transactions. To minimize transfer time
- * in reading chunks mode, set the maximum read payload length to 60 bytes.
- */
-#define FT260_RD_DATA_MAX (60)
+
+#define FT260_RD_DATA_MAX (128)
 #define FT260_WR_DATA_MAX (60)
 
 /*
-- 
2.34.1

