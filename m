Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F376645E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjAJQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbjAJQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:18:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A605BA39;
        Tue, 10 Jan 2023 08:18:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so13684832pll.9;
        Tue, 10 Jan 2023 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBbRxHCxpHxeYy/QhxBE9XBhCUOcaIU8wt7RKimbSCo=;
        b=HZZkTQDouWgjtJV/uhiD0ge3vUOgJY0AUnAISim0JtsmAbq4LzmPH89Sqfy2fVMBQj
         4H9T1SJC8NsrcwpUUn6sfdVOXDCtsPgONI1PVWP3dcSg++qMxZlpD9F+ZMDr35TAv6U6
         qMvRUevU2cX+y2+fOeVKbwTpey1UR/+YSDq8fAtVJkYRQQmYOmx7u2x2kBGS0/SGl/vv
         urWdUvuk2O/ake0a2PlIufcHs0ZfMA1CqkeeNea7HjDjKFDmBGb4bTn6ZCk2nrGnhGr5
         1J7tKxaAJxoDjCbj3XLxV8AmzmZL82vwdPLoTFmjEv5nJEDn+2Eo1iU9HeVlnqT6ETOt
         IB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBbRxHCxpHxeYy/QhxBE9XBhCUOcaIU8wt7RKimbSCo=;
        b=One9YzEZ+FVbZVvTg/m4LiXWH78nWlccJgBV9hGrlc4GZcvEvlH0pWr0MnjG9WSUgg
         q3TB3MLmQ/sJNbMN6K9Z/jbsrnaFl24ANK2aVtEgowMtsYJkJpl1UsTiI19z+cdvJV8K
         6BDN/Xc1bFkXGQHkRGC50hzP+D9DiczVZkk+QDV7RdSwD0YPRq0ZOqyqii3QmJE/iAMH
         3WfGIlGxDKu9BD4d3q1kCK3Z0iTWNRgcdaH6WBoc1kYfpiEnyycrNyrlE68iWYyMJ9SG
         yBmC2flE/mxNth664n9Bk9SsUXnKqFobuuWsvathdhXNVCtCmGNP2eTslFaOlodqjxuW
         PRlg==
X-Gm-Message-State: AFqh2krM/SZEU8OvA1sMUIwA37qM0UFbCgpmHy7pzZ2MB2wnKtEcsfMY
        ZxOSjjgRjdqajDCrAf+Gvc8=
X-Google-Smtp-Source: AMrXdXs7wPKBNF6cRXppnab/hitxx+u0RxxREDCfVfM7rtc/x+opTrqLOekiDvded4XCjF1ItXU8Gw==
X-Received: by 2002:a05:6a21:32a1:b0:aa:6efd:1883 with SMTP id yt33-20020a056a2132a100b000aa6efd1883mr110630628pzb.37.1673367506555;
        Tue, 10 Jan 2023 08:18:26 -0800 (PST)
Received: from yoga ([202.131.132.22])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b0058af0b6dc7csm1325887pfg.75.2023.01.10.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:18:25 -0800 (PST)
Date:   Tue, 10 Jan 2023 21:48:19 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, anupnewsmail@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light : max44009 : Convert to i2c's .probe_new()
Message-ID: <Y72Py9i91MEYFzH2@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/iio/light/max44009.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496..3dadace09fe2 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -487,8 +487,7 @@ static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
 	return IRQ_NONE;
 }
 
-static int max44009_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int max44009_probe(struct i2c_client *client)
 {
 	struct max44009_data *data;
 	struct iio_dev *indio_dev;
@@ -538,7 +537,7 @@ static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
 	},
-	.probe = max44009_probe,
+	.probe_new = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
-- 
2.34.1

