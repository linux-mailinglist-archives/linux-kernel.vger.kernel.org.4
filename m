Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7857767DA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjA0ANL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjA0AMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:12:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB474A57
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so3646584ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNud8Lepb4eeXuGOsqZyJ2CqEHzF4/YGHX/WXomA3GE=;
        b=dg98ZZl1AyihbP1LtRx2ePJtNIBANvg6l6Gdfmwrlmg+xT29TDIlqdpN4YyRCNlsxH
         2d+0NDQIyNI3+imcQ7NQDTRWU1cDISH1SIRjs9KZ9MtQYKwyRV2E4kxG41RUu30tztbk
         1mwsm7nys4j63yTbqvFZ+dsEGsC+i/ndeRX8r4+da18Js4TD+T2SAi+UhZwx6pYIX2zk
         S33rrWohkq2TTRvsyKP/W20Tvxz9wzR67Dg4HTFjJ3AJA4tGIDsFSQ5Evi/mLTjK/dZc
         mdnVVzCHcFRVh1ANjNSv5R8RCXk+iP/LFXcXuHnbESiTmXqgog9RUHjvs7XuDBqjK0Te
         pPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNud8Lepb4eeXuGOsqZyJ2CqEHzF4/YGHX/WXomA3GE=;
        b=UcgOalvt6O9kcyKC8R6UnrfYphXGHNAD3FVgfHF2v+IC6X2D/zehJ8oyfS58ZAdL6K
         2Ev/Bd5FM9x9WGfIpwZNm4SLZ+YVOKDnv4PSLDsj6Nj03jiXYf72wiAMXu1Mj3J1g307
         QKnpwA8FoZ0XQkkKfTpHnDkU4sQzeIqpTZvCj08QoUpvEB/jlIHlKpyqzDcEEbd7PBwH
         6bpU8dElEust9eJDm0KA6rdJxPwiXlcEkgBD/QMP73Ho34HDBHymq62/Ce/3zCh3ALdb
         wVuga25QzLR0uBbmy8EeIb846Pp9KloYql60oC7fl6kCXeE1f+hsfJOf3XMlQK0D1iQV
         WXrw==
X-Gm-Message-State: AFqh2koo9J/SEe6/hv5nvg8cpMJHd77ERnVjKNLWewwrBw18/xcgyY1J
        6Vx034YtZeDHb1kBlz4fJPzYSAti/tK55dI=
X-Google-Smtp-Source: AMrXdXsSdZknjAr0wKn0gY/MpnIZeRHel3NzwGKSoO8sLRLrs7LZP2oF+s13fwjubTyvaUKdTsWZdOHXxvgHyc8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a81:6284:0:b0:373:8313:2991 with SMTP id
 w126-20020a816284000000b0037383132991mr3462545ywb.261.1674778329995; Thu, 26
 Jan 2023 16:12:09 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:37 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-11-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 10/11] irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this device is only partially initialized by the irqchip driver,
we need to mark the fwnode device as not initialized. This is to let
fw_devlink know that the device will be completely initialized at a
later point. That way, fw_devlink will continue to defer the probe of
the power domain consumers till the power domain driver successfully
binds to the struct device and completes the initialization of the
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 1 +
 drivers/soc/imx/gpcv2.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b9c22f764b4d..8a0e82067924 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 * later the GPC power domain driver will not be skipped.
 	 */
 	of_node_clear_flag(node, OF_POPULATED);
+	fwnode_dev_initialized(domain->fwnode, false);
 	return 0;
 }
 
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7a47d14fde44..b24f9ab634dc 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1519,6 +1519,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
+		pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 		ret = platform_device_add(pd_pdev);
 		if (ret) {
-- 
2.39.1.456.gfc5497dd1b-goog

