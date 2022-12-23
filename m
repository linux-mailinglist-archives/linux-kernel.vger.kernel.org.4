Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73037655245
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiLWPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiLWPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:38:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEC44948
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so4897182wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62ZS7JkYul2m8VHv1f4RSJBR/i75r0mH9YhXsFCm5ng=;
        b=kkNBCyTDnoMYXmE+0z0ruJGNOmPedCYqRQg9Z2I2JpHduRO843zCdWs9Vio4cgOBw8
         71h1Cvoyr+Z/YAM6n+4vvf+gYit3f0ffbrqKPs++M7j47yE7tKJ3nW+FVmn2jXOuaIi3
         TjVYYo1ZWSGkuLdvZDStRP2MiDt0DsGFzS7ald0dbMv2sAAjNQ60aCyjyQYZ+q9pokpS
         VNrbxnVU0BJfq8+nmJ3nSkTt8FoUUffj5xNVLA2XoQW3WtJpQIeZ0FPO1eU1RXsyUy12
         0IQh07jo6D7zREz/vJ8EzeVI5tkztX3ndIotAOfE2TzQF8ZLBwIc6E2VSV3I3JkdiHF9
         o+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62ZS7JkYul2m8VHv1f4RSJBR/i75r0mH9YhXsFCm5ng=;
        b=RwFgBvLzkMtsKg22DOTyCDMwzqdWeWeb1jivX61SAjb6lBUJ2mIOFHP/hz76xVVsgR
         TrTUA1ZfFPjetv3Cku/2OY7G5+8ikX6pdVNuq43y2jM7jpVJPJDYkhLdImWEph5HjXpQ
         9G2mZ0PRVxRdsrkQhIQHTJ3hWR4avBNjdIMvHYKRY2MqLa1BZWbAZCDRylwdf0igwg+L
         e7dDQVIjQGC/ILyiFApls96hpZVetSA3rqVzBOWoS08RqqsTCEhvdFNF7/ksOm2SPCAx
         YvbLd40NPxeJCJHEMgSNNQqv8iEhPGsBhf4V34mFJxjM8HOqTsvgP8NkE0SCdti3UDyy
         ZfnQ==
X-Gm-Message-State: AFqh2ko1Lx+mAdBa0YGtiuYtwgFNMSswHe5aZKKUBJmjfM9yQSVDR9q4
        nV/fD69vpL+my0qH3h7k+ek1KA==
X-Google-Smtp-Source: AMrXdXuez67Czj0Gg1F7GnS0247uGtRGqJzpwsoZyvsWa1w5xuXBq2EhWRarnlCIkdwMsdLAe6yQdg==
X-Received: by 2002:a5d:58fc:0:b0:242:7f6e:9192 with SMTP id f28-20020a5d58fc000000b002427f6e9192mr6618305wrd.52.1671809907978;
        Fri, 23 Dec 2022 07:38:27 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:27 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 05/10] pwm: dwc: use devm_pwmchip_add
Date:   Fri, 23 Dec 2022 15:38:15 +0000
Message-Id: <20221223153820.404565-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_pwmchip_add() to add the pwm chip to avoid having to manually
remove it (useful for the next patch which adds the platform-device
support).

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 61f11e0a9319..56cde9da2c0e 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -242,7 +242,7 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	ret = pwmchip_add(&dwc->chip);
+	ret = devm_pwmchip_add(dev, &dwc->chip);
 	if (ret)
 		return ret;
 
@@ -254,12 +254,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 static void dwc_pwm_remove(struct pci_dev *pci)
 {
-	struct dwc_pwm *dwc = pci_get_drvdata(pci);
-
 	pm_runtime_forbid(&pci->dev);
 	pm_runtime_get_noresume(&pci->dev);
-
-	pwmchip_remove(&dwc->chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.35.1

