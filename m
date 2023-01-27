Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70DC67DA67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjA0AMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjA0AMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:12:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B4721E6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b201-20020a2534d2000000b0080b87d910a2so3680350yba.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qrGwsyJhvuk8/KLfQTHsy0tky5Hgdg5GqDKep+1DD4=;
        b=ImHEFeirQ0+RNKXqTaRuRYAbdlWC5P5L5GKOen6KHlSMssg4oHFiz8wutXFV5a4tIe
         S7kQQuXLu7CpQ+gcDOKQIgq7ikdWUn+rZ1UtcQPNh0gxcZQw1wsRj6iqGY3gnJnXhy1G
         NkOjRS354EK8XltpUyGCaPrUCbw/DnHLbLReN+Ew9y/NfKLLZcgs7hauSWp5PvS5MbaA
         FqgwSH8VK+sdmrpkFSE4HZxG2acds1LrKo7sRSFq7ryxJ4Wxoqki0uG9IRIlPHito8iZ
         zImbuVkz+4PK9IaO7IHdiDnHqOYuRc6/qWn3UZ4pCiAfGD+B5KwFGQl+8L+UgsEnm9Z+
         3qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qrGwsyJhvuk8/KLfQTHsy0tky5Hgdg5GqDKep+1DD4=;
        b=OHrh2U7Mr0hrv0qUajqDZPOFVJZfbK4hVWdDk4vsfQYBZJdP0aAjorNazSt6GzAKG1
         7BAhK8CE9Ra9MlmtmOz8Q+ObOHluVcseYAleIo8k+vY7cZ6u9EN7ebsX0gsD3CT/I28N
         CKF5KT4HGS/bcGs+Uq8zy0TWhUKYFZH7Wa2jOhSs52kLeOPOvFaG3losGe3W/AMhcqv9
         zDy4ChnmfKORSew6UogoV9RcTj98PYohNykP0rq4ei0dcf87d1uHH2j3lxcRM9GorFBt
         yty6I6xyNIvGszBp7ZHvLJnnT1tbLISGg8xd+YWgyQJjWDEHdJFJvbbzfIby0F5pzdJA
         MbRQ==
X-Gm-Message-State: AO0yUKVnCypSCJqMCHhJdCGWz1xLVfgTrZY0EMbI3u/lv3Ghm6zghiiJ
        piWQvPvPgdrHLvZQDRMHBfpud8fpd7RH+io=
X-Google-Smtp-Source: AK7set94B+Uk166woh0daWeHRoT+YOBMrypJ1SORaMn8sBX2Wuwc6YxVyj9CsmbZUek2b/SIx0NT19DAyygxzRQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a25:260c:0:b0:80b:663d:6a98 with SMTP id
 m12-20020a25260c000000b0080b663d6a98mr1309860ybm.598.1674778312253; Thu, 26
 Jan 2023 16:11:52 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:30 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-4-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED for fw_devlink
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

The OF_POPULATED flag was set to let fw_devlink know that the device
tree node will not have a struct device created for it. This information
is used by fw_devlink to avoid deferring the probe of consumers of this
device tree node.

Let's use fwnode_dev_initialized() instead because it achieves the same
effect without using OF specific flags. This allows more generic code to
be written in driver core.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index b0a80de34c98..03246ed4a79e 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 	if (!error)
-		of_node_set_flag(np, OF_POPULATED);
+		fwnode_dev_initialized(&np->fwnode, true);
 
 out_put:
 	of_node_put(np);
-- 
2.39.1.456.gfc5497dd1b-goog

