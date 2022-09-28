Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9305EDF28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiI1Otv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiI1Otl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B23B87C;
        Wed, 28 Sep 2022 07:49:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1144080wms.5;
        Wed, 28 Sep 2022 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6RVS2yHMtMgbWKW8mt4Gmc48qyDC1ei7uda2cYYmRkQ=;
        b=PDz0FEtOhXdgSMyri2zGSlMGSyFeyaZW4SIMQOA7PTFZd+wqyaeGTnCaYsPPS0MpT2
         p1QoiuSRv4WLx9IFrtHTV0UwmJuMCsoaOz4rBSB3bFBKsU3ZZ7XtEbt6LUW8mMZvSG4T
         OSf2JzCPc9e/r3X/sfDbxZsN7BhbyU2dD7USntkdWajX99mOrPdlh09lm73aCt+FkIxc
         MnTlc57BneX5GYh7KMaK9bJKI4O5a9N6XrHbGkBYEYNxD0LDmMT0k1lALPkbNISrCn4C
         u8MKq93Mz1xquEhawmTo+4ZZ8nCdUJYdPfNI9Fb53ah1e1h6YUwWWBGo/SYJh5Juwsps
         D/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6RVS2yHMtMgbWKW8mt4Gmc48qyDC1ei7uda2cYYmRkQ=;
        b=bR0RqVIasdc1tNZAyLp1oT3UES01yUrTVRN8tvaYiSDbrSgEuqLyjnqnjiqQtI587l
         BIIGaqyV42Ti6xcXPMjjtN0pzQ7z8hLN7u+gDRIZEiqrwvvzOhTe0e6pXys9smi32glQ
         +BEUTTZGHPACMP4zNAkE8bbyi0XFmJ7QL932KyxtQaB/V0mqUAY2SG1eLby15Fcs/JK7
         vtZknR0M62nWBObW3adsq7jRIJFp2bIPIIRmnteoC4P+pDxLHVE3zomaGzMz/wKK3O+I
         hPpTIG7Kk2I8LVAMqXTClB5Ja1m5ugy9WlMGHkt26xcJZmwY2cFeotHOlvkYkExY91hP
         lH3w==
X-Gm-Message-State: ACrzQf2TiYCTYdbac6z8fag0Si7EmtwiQWhkY3TMH5+12EKxFowP0Knl
        298WMuQlGj+9zH29wgkybMsKQA1/KDCduA==
X-Google-Smtp-Source: AMsMyM44eCqL1qe6yyGHm87Hu6r5TQJEWRvB1WoJdz75i9f4lHgZL6nGWlLZRI4wGyWWIDjmKvDAQA==
X-Received: by 2002:a05:600c:1589:b0:3b4:fe4a:c225 with SMTP id r9-20020a05600c158900b003b4fe4ac225mr7448623wmf.150.1664376573130;
        Wed, 28 Sep 2022 07:49:33 -0700 (PDT)
Received: from michael-VirtualBox.xsight.ent (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.googlemail.com with ESMTPSA id m35-20020a05600c3b2300b003b47b913901sm6977446wms.1.2022.09.28.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:32 -0700 (PDT)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: [PATCH v2 2/7] HID: ft260: improve i2c write performance
Date:   Wed, 28 Sep 2022 17:48:49 +0300
Message-Id: <20220928144854.5580-3-michael.zaidman@gmail.com>
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

The patch improves i2c writing performance by about 30 percent by revising
the sleep time in the ft260_hid_output_report_check_status() in the
following ways:

1. Reduce the sleep time and start to poll earlier:

  Before:
    $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      40510           80             256           8           32

  After:
    $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      52584           80             256           8           32

2. Do not sleep when the calculated sleep time is below 2 ms:

  Before:
    $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      26707           73             256           16          16

  After:
    $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      37034           73             256           16          16

Link to the i2cperf - https://github.com/MichaelZaidman/i2cperf

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
---
 drivers/hid/hid-ft260.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a35201d68b15..44106cadd746 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -345,7 +345,7 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 						u8 *data, int len)
 {
-	int ret, usec, try = 3;
+	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
 
 	ret = ft260_hid_output_report(hdev, data, len);
@@ -356,10 +356,14 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		return ret;
 	}
 
-	/* transfer time = 1 / clock(KHz) * 10 bits * bytes */
-	usec = 10000 / dev->clock * len;
-	usleep_range(usec, usec + 100);
-	ft260_dbg("wait %d usec, len %d\n", usec, len);
+	/* transfer time = 1 / clock(KHz) * 9 bits * bytes */
+	usec = len * 9000 / dev->clock;
+	if (usec > 2000) {
+		usec -= 1500;
+		usleep_range(usec, usec + 100);
+		ft260_dbg("wait %d usec, len %d\n", usec, len);
+	}
+
 	do {
 		ret = ft260_xfer_status(dev);
 		if (ret != -EAGAIN)
-- 
2.34.1

