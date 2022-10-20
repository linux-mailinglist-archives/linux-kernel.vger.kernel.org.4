Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0D60641B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJTPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJTPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:16:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A088B14C52D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so34990713wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVsjMt/QqWDQIkbN9ThQA44X6Q8M6+q3vjfLdgd5aDk=;
        b=iOxGAFmVxJvTYE+QW4dceGIkp9U15XE2Qj1RQ2d3WLlBFZ7yRKcOB6uM7IiHFaKgEq
         A5Jd54OgNopobtiKJfFR+vtui4g+6T9Ggtt9o4uB6hok71RIbQTstD5YpxD1oEiO9kBW
         51oiup5HY4tBN+odUUDkd9W6Yk1Cmjd1TALRToAu5r9ZJ5OSUgK7El+zlSSl8U7g/Plf
         HOOoBnftvuZNzu7uCMjMSNiwZnjHuA3HZ1S4q31UHrUdJAV2AzSvRVjTIHAMYnSMvV+q
         bLdTeG5BWXKxfMDQLKmSSxH1Lf/O0n1p2ePU9WFC7L6BwRkIFYEWJEPmfK1308gJpJj5
         uLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVsjMt/QqWDQIkbN9ThQA44X6Q8M6+q3vjfLdgd5aDk=;
        b=i7x647zs1ZRE8QlzErrQ1bv63fzLxBiLqW01CY4UJulxSZ+r9lOEEy8J5wuekpRLAz
         MD8A5qoVXEQdjxjB0MCTyslPHGrWBua1ElcgrMYhwgjvSkO7GDKvSAbYi+r/wlfLRhaE
         nNmXHK0agc5Cy0YCQffOx6oSH+dDX0vFOOqx38bN4FCinqnjGAtwwURThsZSto9/ap5l
         F4rKIDzeV08pffb93uYK12pPYKW+XN+zmVrZCuN0jZYgRBfxJZnK4NXL9/rLc1Zy3y4/
         gH2f6u08N/kBXp5XicNZyDOin38VYvYwgYH5JrGhf3/hDMPiySEutTNKxTJN0Duropv7
         AW0Q==
X-Gm-Message-State: ACrzQf08rp7OQpLGQcs5uzKyoG8uAd3X0jCAUCVTFWMM8H9TIEsH/Nlu
        MpgU9VAswoU7zWzFjxgqVwucyQ==
X-Google-Smtp-Source: AMsMyM6SWCYL2ZCR2dCpmurN/Q1n+5WL9VL8DHrRsIJNKRdvw9QmU6QQi9cnH2QpLcvtHo+njjUpJg==
X-Received: by 2002:adf:e10f:0:b0:22a:43e8:969f with SMTP id t15-20020adfe10f000000b0022a43e8969fmr9601282wrz.292.1666278980129;
        Thu, 20 Oct 2022 08:16:20 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:19 -0700 (PDT)
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
Subject: [PATCH v6 05/10] pwm: dwc: use devm_pwmchip_add
Date:   Thu, 20 Oct 2022 16:16:05 +0100
Message-Id: <20221020151610.59443-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

