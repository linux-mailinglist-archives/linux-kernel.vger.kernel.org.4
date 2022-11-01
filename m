Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7618615298
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKATyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKATyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:54:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A251B9E6;
        Tue,  1 Nov 2022 12:54:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so10532270wmq.4;
        Tue, 01 Nov 2022 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMLvz91JxdD1ON81vyAGas2R1qe681rjzzgx71DZVdI=;
        b=AsdJI5HULHCv9VmdCc1ZdAEq2+6JDar7zcys5fSi//ueKHj00uKnY+5eADzPW4qjrT
         TDPm3e+QZfXB82yAzyptOsINAZBw1BcML1pjhTMw86prwCtl9AZWwqwqry1aDJ0lr6CO
         RSUqHcZaZZP4qAe+TrAhVnWuikr9jBXMdN3McRN6dOHk8pRRXA7snsDRPREpTsOllddB
         rtCfYmqOeaKsi1Co4mX76wSXaReBfRkuU+M3n/6L36eXOnTVyqdUU2/qNwD8apAM5VpU
         OjX7SH1yRx9Vom7TAcj7KG5Nc+R48ZOaUfD2TXy0Up6QPs9BsgM4UGhHnUrspI+AYyO7
         RXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMLvz91JxdD1ON81vyAGas2R1qe681rjzzgx71DZVdI=;
        b=cxJmmxFKKF0MQrwZRFjz3pM066z5COEB4zT2yJJsTp9OLVvFs2t+fuLmoVYsr4kOA1
         XNOSFfwZ6M52/5ZeyULBNszE7LxXt5U/2xQW5P4GxoFaa0BWXbwRjrUq5SHSA7ZunL/8
         Q4HiqI/v0QLA3v9/AUbJOxSG7emG+Jc/51q0CdWZUMB7QpZMk18q8u9aQCQ/dQ7p+e3W
         mQcpm3u/Vr1dD9uNJvHfLuwSHbAoRordpFVI0R5UvIErUdnriAukGmQZKvlXB985Vz3F
         6bMRN9gLC7SiD0cz9aCQPv1Qh0jwrr4jFcwD+KlnmodLvfreSIPJDKKXoU21DWyurl8t
         oEdQ==
X-Gm-Message-State: ACrzQf0eIR3GMa4exUQc+JTvj8t8U8tWhCu4s1WxtoQKdgvg+sD+sLNq
        FscqFec2TO1BrkG3gl/yE34=
X-Google-Smtp-Source: AMsMyM7WLsCc05cIThUdud6Lj0K45zQUc9KUVE7a9mC0NbZvXA8gHPwBvnmOU5HfgOUL9LO4yNjj+A==
X-Received: by 2002:a05:600c:4e47:b0:3c6:fc59:5eff with SMTP id e7-20020a05600c4e4700b003c6fc595effmr23083213wmq.18.1667332446282;
        Tue, 01 Nov 2022 12:54:06 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cf75213bb9sm6092617wmo.8.2022.11.01.12.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2022 12:54:05 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too frequently
Date:   Tue,  1 Nov 2022 21:53:43 +0200
Message-Id: <1667332425-12536-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that low battery irq may be generated tens of times per second,
leading to userspace being flooded with unnecessary events.

Fix that by preventing such events being generated more than once every 30
seconds.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 4676560..2659df7 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -137,6 +137,7 @@ struct cpcap_battery_ddata {
 	struct power_supply *psy;
 	struct cpcap_battery_config config;
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
+	struct timer_list low_timer;
 	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
 	int charge_full;
@@ -914,9 +915,14 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 		dev_info(ddata->dev, "Coulomb counter calibration done\n");
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
-		if (latest->current_ua >= 0)
+		if (latest->current_ua >= 0 &&
+		    !timer_pending(&ddata->low_timer)) {
 			dev_warn(ddata->dev, "Battery low at %imV!\n",
 				latest->voltage / 1000);
+			mod_timer(&ddata->low_timer,
+				  jiffies + msecs_to_jiffies(30000));
+			disable_irq_nosync(d->irq);
+		}
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
 		if (latest->current_ua >= 0 && latest->voltage <= 3200000) {
@@ -1087,6 +1093,19 @@ static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
 	return error;
 }
 
+static void cpcap_battery_lowbph_enable(struct timer_list *t)
+{
+	struct cpcap_battery_ddata *ddata = from_timer(ddata, t, low_timer);
+	struct cpcap_interrupt_desc *d;
+
+	list_for_each_entry(d, &ddata->irq_list, node) {
+		if (d->action == CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW)
+			break;
+	}
+
+	enable_irq(d->irq);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id cpcap_battery_id_table[] = {
 	{
@@ -1118,6 +1137,8 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (!ddata)
 		return -ENOMEM;
 
+	timer_setup(&ddata->low_timer, cpcap_battery_lowbph_enable, 0);
+
 	cpcap_battery_detect_battery_type(ddata);
 
 	INIT_LIST_HEAD(&ddata->irq_list);
@@ -1185,6 +1206,8 @@ static int cpcap_battery_remove(struct platform_device *pdev)
 	if (error)
 		dev_err(&pdev->dev, "could not disable: %i\n", error);
 
+	del_timer_sync(&ddata->low_timer);
+
 	return 0;
 }
 
-- 
1.9.1

