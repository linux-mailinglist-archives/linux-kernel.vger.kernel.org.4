Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F169B8C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBRIdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBRIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:33:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A1498A4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5365936facfso28247027b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wf3aa1fibAc7MkDg7PORyU7RaVXEoouFWua6YI0T5Hw=;
        b=r/CAEVeZKaF7JFTzJGZPssmJ2DIsZyZc9v5lclCdMbxrxNh2Q3QLMVp4pLNRuC/Q5o
         s27Bkv2TMKwmgM8oUoVvMvQEDvRGwftjSDp/ve6slRHgGsw5Ms0v43lU1FgwAhrBbFUe
         35o2FkSyM0x9/CMG8wr9G7/tyB/xKWzUmAI6tpiI86269U3STCkvIy4CWA8W6S2SdtXS
         95eDXAunOWuxhtEP+diSImXUFuEa0VFXp1IRPtl0LmzghMSuArwHNw5gdcwOcP5ghRmt
         Jtm9ur/C7VTni40wqDN76966yegfo02FQ3vpbSwRhwDhCS/71+WQUH1e/qqxm6JVCgxQ
         FjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wf3aa1fibAc7MkDg7PORyU7RaVXEoouFWua6YI0T5Hw=;
        b=0ZaTWhUKZvAjtJ4OnYtDA3bE5SkbyYSfzl5xRXzXvlwtuyvPgY3FTvrdMPsOpybPTO
         lkyFSkBglA/b1nEeKt8H9z/R49H3IPYkplqG5IbxQY3++r2NGIjF9z/2Yb2f+Ki3W7Ls
         K5F4d7bnMuGqjNxSuRh2hLLJQx6DhHpTfFhdzRaNmM2/7Y0o3LwFgrdPelL3GCwEcVV7
         /fgM5z4dti0CgckkLJlxvSq8uSGj3WnoOi0K5sxPY1mqzaBV0HogNQY/1PqhZzcM9f8T
         WuYu/uRACygDV4XAJdtoahml0hpjbkq0YH14CRvqg8luaMAu8gDz/DnmHs9UHPr5qkR1
         Pkqw==
X-Gm-Message-State: AO0yUKXyIaoRxJahLPDh4GRiZZ8RPD6PMh906B+8k00X4Ubr04xjcwSN
        ZbWOETL8BL9unDpzPzso9sU378wX0jcpzkc=
X-Google-Smtp-Source: AK7set8PFya149sfYHXrlUe84h6TnpJuUyTxV/h5YVz8ypiqAHXvBdWcZs8G6zaahZ/K/pJIAwRpMfD2P80zE3A=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:382:7632:f7fc:4737])
 (user=saravanak job=sendgmr) by 2002:a81:6a41:0:b0:534:3fd:8403 with SMTP id
 f62-20020a816a41000000b0053403fd8403mr652502ywc.89.1676709186748; Sat, 18 Feb
 2023 00:33:06 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:32:51 -0800
In-Reply-To: <20230218083252.2044423-1-saravanak@google.com>
Message-Id: <20230218083252.2044423-5-saravanak@google.com>
Mime-Version: 1.0
References: <20230218083252.2044423-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [RFC v1 4/4] regulator: core: Move regulator supply resolving to the
 probe function
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the regulator's supply resolving code if we resolve the
supply in the regulator's probe function. This allows us to:

- Consolidate the supply resolution code to one place.
- Avoid the need for recursion by allow driver core to take care of
  handling dependencies.
- Avoid races and simplify locking by reusing the guarantees provided by
  driver core.
- Avoid last minute/lazy resolving during regulator_get().
- Simplify error handling because we can assume the supply has been
  resolved once a regulator is probed.
- Allow driver core to use device links/fw_devlink, where available, to
  resolve the regulator supplies in the optimal order.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d5f9fdd79c14..f3bf74d1a81d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1952,7 +1952,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 		if (node) {
 			r = of_find_regulator_by_node(node);
 			of_node_put(node);
-			if (r)
+			if (r && r->dev.links.status == DL_DEV_DRIVER_BOUND)
 				return r;
 
 			/*
@@ -1982,11 +1982,11 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	}
 	mutex_unlock(&regulator_list_mutex);
 
-	if (r)
+	if (r && r->dev.links.status == DL_DEV_DRIVER_BOUND)
 		return r;
 
 	r = regulator_lookup_by_name(supply);
-	if (r)
+	if (r && r->dev.links.status == DL_DEV_DRIVER_BOUND)
 		return r;
 
 	return ERR_PTR(-ENODEV);
@@ -2050,13 +2050,6 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 	}
 
-	/* Recursively resolve the supply of the supply */
-	ret = regulator_resolve_supply(r);
-	if (ret < 0) {
-		put_device(&r->dev);
-		goto out;
-	}
-
 	/*
 	 * Recheck rdev->supply with rdev->mutex lock held to avoid a race
 	 * between rdev->supply null check and setting rdev->supply in
@@ -2178,13 +2171,6 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
-	ret = regulator_resolve_supply(rdev);
-	if (ret < 0) {
-		regulator = ERR_PTR(ret);
-		put_device(&rdev->dev);
-		return regulator;
-	}
-
 	if (!try_module_get(rdev->owner)) {
 		regulator = ERR_PTR(-EPROBE_DEFER);
 		put_device(&rdev->dev);
@@ -5649,9 +5635,6 @@ regulator_register(struct device *dev,
 	regulator_resolve_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 
-	/* try to resolve regulators supply since a new one was registered */
-	bus_for_each_dev(&regulator_bus, NULL, NULL,
-			 regulator_register_resolve_supply);
 	kfree(config);
 	return rdev;
 
@@ -5782,7 +5765,9 @@ static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
 
 static int regulator_drv_probe(struct device *dev)
 {
-	return 0;
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+
+	return regulator_resolve_supply(rdev);
 }
 
 static struct device_driver regulator_drv = {
-- 
2.39.2.637.g21b0678d19-goog

