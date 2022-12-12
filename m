Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C2649F68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiLLNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiLLNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:07:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B86458
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:07:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso5081502wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5yuV9jd97R81uDazuj6Xzn2nQRDFmr1/RjN3Yc1W2U=;
        b=8COUZHtUWTRPsp14Y0Sk3z9fvujNJj0DQepHFAVugiJvB918gp3oHwgyBkUoWq51Qa
         nnYtfpFk9AoKIdNXM1cauY2lk3TIPDGUm6k+wO6Qg8YLBj1fG1/mznNTgABWRVb3slP8
         Q6ceNEZiPiSCGcOtAtxOwdRag3a+gCGtYHg3WTLT0Ge9FilcFX9jzUxVLJKxCVflZVZh
         CVyuy9L4YC3mLOcUzVgKef8K3opHmRcadQBaLzDMkYo8SfhjpLCWSclju2SeWm4jjGLA
         QyO0+lT2v5K/vTNjJX5g9zZwghp2pv7RwbG27An9hyFd+enSXqo+zMUfEUmdqVgFrtf/
         L3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5yuV9jd97R81uDazuj6Xzn2nQRDFmr1/RjN3Yc1W2U=;
        b=byScq026doWcmdY8RkukcMLFuMMALnGEzid3HtvhR5wOR3/bRbpzFcoFuDsSZHDhuK
         kyP3MLDXzyVIY3qe0KQxHWQYVd2Yix5RKnydNHQKiY5sLewYPGYxB/149ClzFZQ4YaLU
         SYv9bOVqafyr5gzbOkoRpwlaNzheavFJlwyq2FiOd6GWaWvwPkLPxJ5PvLRlTm80KQIh
         I3SNXcM8Nc1ogdZC1TIdai9rlMjOrUKmKoSspca8JQ+q0rmEk78Bp/UwdkGCR6FwfAcx
         BsR8UfmboH6Ex6VWgkr2lL3sVojo0Q0LPOldtvNQOeoXB589TiWNwFwWGbyc/Mv5eToe
         /UFw==
X-Gm-Message-State: ANoB5pmqDdoY8KC3L90WONOJ7BGR9T/ZTPq2PqU+ioLZ6/Y/SCzuj+Pg
        gZP1pQYmbmeyu5Eje4EZhGneVw==
X-Google-Smtp-Source: AA0mqf4MoBDUAd5xQ6VFh8EbzCBzqe4szK5HnulC7sIiYS7H23IC2XsHAi1J0o87pRzHoT0vu+SIig==
X-Received: by 2002:a05:600c:908:b0:3d1:fb5d:dd67 with SMTP id m8-20020a05600c090800b003d1fb5ddd67mr12039182wmp.23.1670850470397;
        Mon, 12 Dec 2022 05:07:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f39:2597:6684:1762])
        by smtp.gmail.com with ESMTPSA id i2-20020a1c5402000000b003c6c182bef9sm11220360wmb.36.2022.12.12.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:07:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] gpio: sim: set a limit on the number of GPIOs
Date:   Mon, 12 Dec 2022 14:07:48 +0100
Message-Id: <20221212130748.443416-1-brgl@bgdev.pl>
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

With the removal of ARCH_NR_GPIOS in commit 7b61212f2a07 ("gpiolib: Get
rid of ARCH_NR_GPIOS") the gpiolib core no longer sanitizes the number
of GPIOs for us. This causes the gpio-sim selftests to now fail when
setting the number of GPIOs to 99999 and expecting the probe() to fail.

Set a sane limit of 1024 on the number of simulated GPIOs and bail out
of probe if it's exceeded.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212112236.756f5db9-oliver.sang@intel.com
Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 1020c2feb249..60514bc5454f 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -31,6 +31,7 @@
 
 #include "gpiolib.h"
 
+#define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
 
@@ -371,6 +372,9 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
+	if (num_lines > GPIO_SIM_NGPIO_MAX)
+		return -ERANGE;
+
 	ret = fwnode_property_read_string(swnode, "gpio-sim,label", &label);
 	if (ret) {
 		label = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
-- 
2.37.2

