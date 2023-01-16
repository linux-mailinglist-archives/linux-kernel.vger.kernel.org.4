Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8266C2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAPOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjAPOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BD23D94
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:42:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so27678733wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ppko8Fem+qtirmYhp62EkgUMyaloOxSAW2RcoWpD8I=;
        b=8EI8vtH1yUk28VFMj92vw5wTOII6JxqTmxqBGNvfxrRf9qrzwu1wy4qOATNSQxjc9d
         R1UJ4qU2vEgWUuxmWQiWGyklnOrH5wV2LU+Ccv2embbP0WIETuvDcaXddLvjwyQRHD66
         dbk5W9yLzTVC7r9xQ6kMStfb4kPSUEcfl+8j28OSk0lopTRCTRddJxa6EYyvsOuwUB3+
         smD2q6ZAr6K+69W4Rv0jgvS8LM2gawH1uQamqOU0urnmv8/pZOTvCN7qxY7KuL1smhlz
         bvL86lYGRzOFWlBB/pCJmRn6AiWnFm7YM5i/CBulRWnbqgGVaA+PY4tEOUd3FExj9W7v
         vsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ppko8Fem+qtirmYhp62EkgUMyaloOxSAW2RcoWpD8I=;
        b=7HCH7FvOAuRQcxqPA8VIx4ND6A05o/RMHjuo6ugUzIU6ljeqhmw8NHCs0507NOWEsz
         /qqAvLZfAVpz+Z8n60AQn8zXpSMPRi3qjY3zerB8jbYMO9IumIvqL2ihunQTNoaiwBSe
         /l3kXHe+HI4fXFPGxgc6CH/vCI/RAl+lBVatwu57Vgbpo7LH/aXSNe0QkxLobbgcjOjk
         EL9fGi8ksuUHY8hAhGo3WlMq3sHvDLUIsiWTC3q6IeQo6xN435t6bCw5YFsz04MpnHji
         BkjOJfxQCD11oZS/OiT+BmUNSTJImE+bpGs0ecbKwbLWB09LJfWz5+ZHzsRBNqxjBe2v
         9S8Q==
X-Gm-Message-State: AFqh2kqO8jXKfZC4U1uCWEI838mphlx+QSHEzlaE0jPBRms53z2rk3Yf
        FLnSJ9FJXgxHAP7kr5uik5ryNQ==
X-Google-Smtp-Source: AMrXdXvswhBZBHL3czGygVmuEp4kCJ4skGF7OFh/1qMOaUgNh5rRMgW34Z1OPN5a1reY/5IDqOTxPA==
X-Received: by 2002:a5d:528e:0:b0:2bd:e99a:a8a9 with SMTP id c14-20020a5d528e000000b002bde99aa8a9mr7603936wrv.71.1673880119021;
        Mon, 16 Jan 2023 06:41:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f9d:c271:2ba9:4f2a])
        by smtp.gmail.com with ESMTPSA id r10-20020adfda4a000000b0029a06f11022sm26691105wrl.112.2023.01.16.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 06:41:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH -next] spi: spidev: fix a recursive locking error
Date:   Mon, 16 Jan 2023 15:41:49 +0100
Message-Id: <20230116144149.305560-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When calling spidev_message() from the one of the ioctl() callbacks, the
spi_lock is already taken. When we then end up calling spidev_sync(), we
get the following splat:

[  214.047619]
[  214.049198] ============================================
[  214.054533] WARNING: possible recursive locking detected
[  214.059858] 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1 Not tainted
[  214.065969] --------------------------------------------
[  214.071290] spidev_test/1454 is trying to acquire lock:
[  214.076530] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x8e0/0xab8
[  214.084164]
[  214.084164] but task is already holding lock:
[  214.090007] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
[  214.097537]
[  214.097537] other info that might help us debug this:
[  214.104075]  Possible unsafe locking scenario:
[  214.104075]
[  214.110004]        CPU0
[  214.112461]        ----
[  214.114916]   lock(&spidev->spi_lock);
[  214.118687]   lock(&spidev->spi_lock);
[  214.122457]
[  214.122457]  *** DEADLOCK ***
[  214.122457]
[  214.128386]  May be due to missing lock nesting notation
[  214.128386]
[  214.135183] 2 locks held by spidev_test/1454:
[  214.139553]  #0: c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
[  214.147524]  #1: c4925e14 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x70/0xab8
[  214.155493]
[  214.155493] stack backtrace:
[  214.159861] CPU: 0 PID: 1454 Comm: spidev_test Not tainted 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1
[  214.169012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  214.175555]  unwind_backtrace from show_stack+0x10/0x14
[  214.180819]  show_stack from dump_stack_lvl+0x60/0x90
[  214.185900]  dump_stack_lvl from __lock_acquire+0x874/0x2858
[  214.191584]  __lock_acquire from lock_acquire+0xfc/0x378
[  214.196918]  lock_acquire from __mutex_lock+0x9c/0x8a8
[  214.202083]  __mutex_lock from mutex_lock_nested+0x1c/0x24
[  214.207597]  mutex_lock_nested from spidev_ioctl+0x8e0/0xab8
[  214.213284]  spidev_ioctl from sys_ioctl+0x4d0/0xe2c
[  214.218277]  sys_ioctl from ret_fast_syscall+0x0/0x1c
[  214.223351] Exception stack(0xe75cdfa8 to 0xe75cdff0)
[  214.228422] dfa0:                   00000000 00001000 00000003 40206b00 bee266e8 bee266e0
[  214.236617] dfc0: 00000000 00001000 006a71a0 00000036 004c0040 004bfd18 00000000 00000003
[  214.244809] dfe0: 00000036 bee266c8 b6f16dc5 b6e8e5f6

Fix it by introducing an unlocked variant of spidev_sync() and calling it
from spidev_message() while other users who don't check the spidev->spi's
existence keep on using the locking flavor.

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Fixes: 1f4d2dd45b6e ("spi: spidev: fix a race condition when accessing spidev->spi")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spidev.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8ef22ebcde1f..892965ac8fdf 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -89,10 +89,22 @@ MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
 
 /*-------------------------------------------------------------------------*/
 
+static ssize_t
+spidev_sync_unlocked(struct spi_device *spi, struct spi_message *message)
+{
+	ssize_t status;
+
+	status = spi_sync(spi, message);
+	if (status == 0)
+		status = message->actual_length;
+
+	return status;
+}
+
 static ssize_t
 spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 {
-	int status;
+	ssize_t status;
 	struct spi_device *spi;
 
 	mutex_lock(&spidev->spi_lock);
@@ -101,12 +113,10 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	if (spi == NULL)
 		status = -ESHUTDOWN;
 	else
-		status = spi_sync(spi, message);
-
-	if (status == 0)
-		status = message->actual_length;
+		status = spidev_sync_unlocked(spi, message);
 
 	mutex_unlock(&spidev->spi_lock);
+
 	return status;
 }
 
@@ -294,7 +304,7 @@ static int spidev_message(struct spidev_data *spidev,
 		spi_message_add_tail(k_tmp, &msg);
 	}
 
-	status = spidev_sync(spidev, &msg);
+	status = spidev_sync_unlocked(spidev->spi, &msg);
 	if (status < 0)
 		goto done;
 
-- 
2.37.2

