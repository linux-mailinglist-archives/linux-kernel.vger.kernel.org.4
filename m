Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2A5F5C87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJEWNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJEWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:12:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347483200
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:12:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o5so11611041wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=CwxRItFiSyGkSsVk03I7odc5pM54LdjFqGNovlI4mDdFuQud975xo1ZjzOe2Tb1Hdn
         V0Yx+6mj4qnKLaLmhOL9CZodhkZjQqjYF9QS63Zg5n/pKEItDyJhgowMN4IMJoKuclH9
         Btl8W2jz10SoFTXSKHP6lXB5M7Bg+asVc0M4z+I8o8TRjTwkyuWeavONqCZLqbBAZiid
         ByPKUCPe314HaigLiCBpHBU5U/pkRgfe4uV9yA4W9ORFA1zrkOFEiOp+U3ADWo55kVcu
         ggq96TIzVLPo70QeSxfNC0SzkuI1xG1DW8kYEZaoNAgX9I72gS41m6X24w3wq6H/lHtj
         zLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=rbOw0k5f/pQHHSx4dFxsdVJGGkXY4aRi2mWtuagH1LxDGONYJjEOg6dN0z6LxFdu3I
         T6KVUMe1Sn9vJpNYUTiy0Umbg9GpXV2eNFLJNrXVo1XdETmXekc2GBF2h9cWKP8evpCC
         B8teEaak9VnpffG+vIqOoB//9kjumjgswo4w6Ca1bKDK0hPqgOOvuPS0V6IPwywNAgyZ
         MH27UINNP2QvbnqSLVRgieojV+uUBFJkUFeIZc+/zZAcDREYeGN5eGgVFFK1+SwKwxVI
         QPqjvvlGbGqy1VR9vN1q2vvp5ja6K07ke6q+Xz7tZCzzegKDHNVgll6UUGmcKtLhpm4s
         XjBA==
X-Gm-Message-State: ACrzQf3YYleCyL+EpFOK0YMYczm52OF7o4QxxKdDrxavR2VoZkyHj7R7
        NEckgPPzB51RBqwCeHwLhTVaTA==
X-Google-Smtp-Source: AMsMyM7Wbls2cncHeDTU+qrNRSHvee+oD9v+FEyIh3tQFDImWYF5CdvGzSyiNAUur29eVaQLYjAI2Q==
X-Received: by 2002:a7b:c3d4:0:b0:3be:88e:2265 with SMTP id t20-20020a7bc3d4000000b003be088e2265mr4681373wmj.163.1665007970185;
        Wed, 05 Oct 2022 15:12:50 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:49 -0700 (PDT)
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
Subject: [PATCH v5 04/10] pwm: dwc: move memory alloc to own function
Date:   Wed,  5 Oct 2022 23:12:36 +0100
Message-Id: <20221005221242.470734-5-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005221242.470734-1-ben.dooks@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
MIME-Version: 1.0
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

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

