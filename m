Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276567B67C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjAYQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjAYQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:01:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541A4B740;
        Wed, 25 Jan 2023 08:01:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vw16so48875307ejc.12;
        Wed, 25 Jan 2023 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0udQBNiyTVHtXU/kII3EPH6dSydFl+W8baA8J5nZ+U=;
        b=KS8DhefvPt+fMOJY0QiaaCruv0yftCwSRrQqF02HoppSGB5KwRt3vC1MqbTPpXHVmE
         zapEgcqOgea9mLIjGvp/b2VN+ffjPo+2GRlhOCiZBM6CtPxnPO1kDUdx9kQik6qpbnzB
         V2pt/0wmRKG5pu63J8SBTJGtox0sUy+rQqIBTzT8jA4zs3A+u2af/9ZTXtT8DSImJE8e
         HDHL2RWgTie4DotqDNxoaJcFxoornznK7LGIjrR5JE7wybuBY0q19EDQtFVxLY5x1Pyo
         rciGxVHQ9eUVNNYl9iUgCMbIuEUh53c85A18HxrvQSdi1FAQJwO73i7wq8LaiqoFdyzA
         ccvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0udQBNiyTVHtXU/kII3EPH6dSydFl+W8baA8J5nZ+U=;
        b=W7+NG8vTBotkN8FxQcFR1M2kdFi1igKpvnJFSqekQgTTX3E2fmAc6ymMXq7YQXz1cz
         GQo4bhkxKAD3gugVKy4UqxL9YBqOgu42nry0uaJKdcaDgJL1SK0YHfIBLGpX22n1sjSA
         Z5E1hAbF3cLRSFi+P7uf6cW9xTuJ+GATG0Z8AvPCoMNTs8MUzGZX47uYe8eiXmbTUSGa
         kvWGN1w2iHfY+E81gH2JTxL0T/Ca5Iy+0SroclB0XXZglEYTxc6C6nO1bse9TTqnEJS+
         3d9DoeoG15oVtzgTU6usNsQV7x7nAKkh4z5VWSWWh8QLdP/Mgi7eF4guOpS9SLStVbI9
         +Jbw==
X-Gm-Message-State: AFqh2kodBQa34ZhUfl8w1r3K3EFidWEHV0I8wPs2Jn6icLGEH+a2u+7k
        5eFsyvX3oJ63E8saFcgPzuo=
X-Google-Smtp-Source: AMrXdXu+Wr8TdMfPe4hi8u0hLIVuosJ9gdtq7D05AKjMSvz30/Nc84f9Vhj0UCDfDWZBGMiN+9OVwg==
X-Received: by 2002:a17:907:a80b:b0:86f:220e:94af with SMTP id vo11-20020a170907a80b00b0086f220e94afmr46778569ejc.56.1674662516648;
        Wed, 25 Jan 2023 08:01:56 -0800 (PST)
Received: from DE008-GL-00034.UMK.KLS.zentral ([62.157.169.226])
        by smtp.gmail.com with ESMTPSA id lr26-20020a170906fb9a00b008566b807d8asm2543662ejb.73.2023.01.25.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:01:55 -0800 (PST)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: imx27: fix race condition .apply,.get_state
Date:   Wed, 25 Jan 2023 17:01:42 +0100
Message-Id: <20230125160142.586358-1-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.1
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

From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>

A race condition might occur, ultimately leading to switching off the
PWM that is supposed to be turned on.
The condition is more likely, if `CONFIG_PWM_DEBUG` is set and the PWM
has been enabled before Linux is booted.

After writing some value to the register linked to the duty cycle
(`MX3_PWMSAR`), the related debug function
(`core.c:pwm_apply_state_debug`) reads back (`.get_state`)
a wrong value (`0`) as the configured duty cycle. This value is stored
as part of a temporary state variable that it subsequently reapplies
to the PWM for testing purposes. Which, effectively, turns off the PWM.

This patch postpones the return of the `.apply` function until either
the written value can be read back as expected or the operation times
out.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
---
 drivers/pwm/pwm-imx27.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 29a3089c534c..9b473fe10cb9 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -223,7 +224,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
-	u32 cr;
+	u32 cr, val;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -290,6 +291,18 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(imx);
 
+	/*
+	 * According to imx pwm RM the value can be:
+	 * - written at any time
+	 * - only be read, if the pwm is enabled
+	 * Yet it returns a wrong value (i.e. within `pwm_imx27_get_state`) if it is subsequently read (while enabled).
+	 * Apparently it takes the value some cycles to propagate.
+	 * Wait a bit to make sure the right value can be read by other functions, before returning.
+	 */
+	ret = readl_relaxed_poll_timeout(imx->mmio_base + MX3_PWMSAR, val, val == duty_cycles, 20000, 300000);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.39.1

