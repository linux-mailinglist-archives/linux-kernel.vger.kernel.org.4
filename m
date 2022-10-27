Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB2610161
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiJ0TQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiJ0TQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637772EDB;
        Thu, 27 Oct 2022 12:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2672762486;
        Thu, 27 Oct 2022 19:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CFC4314B;
        Thu, 27 Oct 2022 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666898206;
        bh=0FOUDtQQL42lE45KflCMkrX8g3yyb7/p/49sMzexo9U=;
        h=From:To:Cc:Subject:Date:From;
        b=Pk4iIsApYuq/PVHx2kx9WyUUsO83ow1XiisTenNMn5vip3e6ObhN6NiyWP6QDb2uf
         w/QJWzsx5pdcnvZiy3ZqNGy0hkzr/fiQDGKL1QAka83OqI/1OLJslcPff3V51bWR0Z
         cWBR9mxRla+lpB4Cmb+EGTg5TkCxBEyyAnU6HhoCKDbnH0ef+KZtX4HmZOd4wN5B4K
         7TxCq+kmKjASkGzJQQA99tVeaS3cvPT38piLod5P777eZj9N07utXtaoUXcTxg27b7
         /rhHp41lxJfg+oIepGu2cgzFdSJMx7GpSr8gXL1YBsO04bdK96fsrxTsFIRrHTaVWk
         X1V8txzdvMz5Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] pinctrl: qcom: Include bitfield.h in pinctrl-lpass-lpi.c
Date:   Thu, 27 Oct 2022 12:16:25 -0700
Message-Id: <20221027191625.1738204-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=arm allmodconfig, the following error occurs:

  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_gpio_set_mux’:
  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:102:9: error: implicit declaration of function ‘u32p_replace_bits’ [-Werror=implicit-function-declaration]
    102 |         u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
        |         ^~~~~~~~~~~~~~~~~
  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_config_get’:
  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:127:16: error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
    127 |         pull = FIELD_GET(LPI_GPIO_PULL_MASK, ctl_reg);
        |                ^~~~~~~~~
  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_config_set’:
  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:233:23: error: implicit declaration of function ‘u32_encode_bits’ [-Werror=implicit-function-declaration]
    233 |                 val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
        |                       ^~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

bitfield.h was included via pinctrl-lpass-lpi.h but another change
removed that include to restrict what was being included. Add bitfield.h
back to pinctrl-lpass-lpi.c, as it is needed there.

Fixes: aa9430f8a6de ("pinctrl: qcom: Add missing header(s)")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index d5cfa91e2eff..3dc670faa59e 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2020 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>

base-commit: 76f3768132eab2c26c9d67022b452358adc28b2c
-- 
2.38.1

