Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048C961D9AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKEL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKEL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:26:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C21CB16;
        Sat,  5 Nov 2022 04:26:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so19234533ejc.7;
        Sat, 05 Nov 2022 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIJ7hf/fFBlHGb3gaHRXBAK5sDqMN3APy8LXApKcTCc=;
        b=hXEVWmvWnxe69ninDDQWYoIBl3qLZ9ZNzW8y40rtZJSMghjsDd4Vfzi7QTiExEYmJn
         rABOv+nXVLVMi6nqHFtaZrZ6pS7BQoLKUd3snMgUOsNVya9d6qsfLW9V5a+gP45JUHzY
         vWrkU9dhMLzE6Iq64tRYRjs5bRNFfutjuujlOCjhOyewPLvDkCvhLpLnJeYL9CehKLZA
         3+5z3nAzqkDI61LlXRCwZtN3gqyoJbB/gwh1xWDuOFb3pRLLSBkzcftntcoJSRGMxTOj
         Y1CNujlBW+5ZjUXtLUMZ6gH5LyKluLehm3xTfqRNzcL9jRQlhV//CVbZKbPfIeo5mFCs
         D3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIJ7hf/fFBlHGb3gaHRXBAK5sDqMN3APy8LXApKcTCc=;
        b=JejPxMlVybff5IQqElGlLO7xj850CZBWayH0yZN7AxaD2nRCuZOO1DroA0eXbmNb4H
         VU/ZBfEjvGg5vzZ3BFs6xgGdF19M6y3oS6DScaCZRVHOtv0Fi9LsMX+SsHUZn+6RD2Ve
         MUDTnNZ1e64W/6MEqQoqN2c0x+pzgGAkGWgeYjwwdNffFwwpCMmE4go6PTaPqlT9rQpk
         0GdHVjQGGGlXipjpqra0zDRipCfWZt/DOU/cTb/d8qJxP+b6skFAeZxb4LbkGlURivs4
         4OzSjo5wV8XBpmH9ju9MKyXyCnoNzPoMItiNE6pQyrCOc3IBDj4W+m0CaUnN3plnTUDq
         EleQ==
X-Gm-Message-State: ACrzQf1eVW7O3xehp7FK8FqNF+gtoW/sBGojM2GESEZG2+W5ONhnLCY3
        7dyHQpVfFw7ZZAWUsc55FjY=
X-Google-Smtp-Source: AMsMyM42wbM0wGWc+Zy67vMY8EC8TjcJmL+wr609ZZUxn0PZtfvV/82tgk04tYc8j0ZEYuXjjLV9LQ==
X-Received: by 2002:a17:907:2063:b0:7ad:fa6b:e84b with SMTP id qp3-20020a170907206300b007adfa6be84bmr20372498ejb.69.1667647575280;
        Sat, 05 Nov 2022 04:26:15 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm1050069eda.37.2022.11.05.04.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Nov 2022 04:26:14 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too frequently
Date:   Sat,  5 Nov 2022 13:25:42 +0200
Message-Id: <1667647544-12945-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
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
 drivers/power/supply/cpcap-battery.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 4676560..8869067 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -137,6 +137,7 @@ struct cpcap_battery_ddata {
 	struct power_supply *psy;
 	struct cpcap_battery_config config;
 	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
+	struct delayed_work low_irq_work;
 	u32 cc_lsb;		/* μAms per LSB */
 	atomic_t active;
 	int charge_full;
@@ -914,9 +915,13 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 		dev_info(ddata->dev, "Coulomb counter calibration done\n");
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
-		if (latest->current_ua >= 0)
+		if (latest->current_ua >= 0 &&
+		    !delayed_work_pending((&ddata->low_irq_work))) {
 			dev_warn(ddata->dev, "Battery low at %imV!\n",
 				latest->voltage / 1000);
+			schedule_delayed_work(&ddata->low_irq_work, 30 * HZ);
+			disable_irq_nosync(d->irq);
+		}
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
 		if (latest->current_ua >= 0 && latest->voltage <= 3200000) {
@@ -1087,6 +1092,21 @@ static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
 	return error;
 }
 
+static void cpcap_battery_lowbph_enable(struct work_struct *work)
+{
+	struct delayed_work *d_work = to_delayed_work(work);
+	struct cpcap_battery_ddata *ddata = container_of(d_work,
+			struct cpcap_battery_ddata, low_irq_work);
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
@@ -1118,6 +1138,8 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (!ddata)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&ddata->low_irq_work, cpcap_battery_lowbph_enable);
+
 	cpcap_battery_detect_battery_type(ddata);
 
 	INIT_LIST_HEAD(&ddata->irq_list);
@@ -1185,6 +1207,9 @@ static int cpcap_battery_remove(struct platform_device *pdev)
 	if (error)
 		dev_err(&pdev->dev, "could not disable: %i\n", error);
 
+	/* make sure to call enable_irq() if needed */
+	flush_delayed_work(&ddata->low_irq_work);
+
 	return 0;
 }
 
-- 
1.9.1

