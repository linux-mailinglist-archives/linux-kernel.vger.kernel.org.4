Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B215F5BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiJEVbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiJEVan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:43 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526182779
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so66884qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=sM0ExHCLiFuiNysHjATwyWwifukOjz6sXbjAjjuylIg=;
        b=i+h2r/8ajVjQMilxnWQsj9nP0OygzHyl2uRRAyql2j0kVET68KWR8nZjxjMG2rteW3
         X1YLshoKitkthEvYCk3QDosntzib7x7L50ZGC3g31mnfbbm92cNXBDh17K2frGV734hd
         zpPWuD1l6gFcdqWXfMx6gcAhPaezFV8h6vciUpjdExpPWZffFotggfldSZDTBOO5EkPB
         TO50IiXDiavtQWYv4B45jgDFF4P4VHFRYSG1LJesjEM91+I5mYV/ItIEBFQI6sjSm3Jj
         3OnBgsGWBcI3oWaM7KOaU8tCFSmZ7QNphLWeAuJ4YuL1zKwiPGTzQfggyS+VzGLAETYQ
         b+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sM0ExHCLiFuiNysHjATwyWwifukOjz6sXbjAjjuylIg=;
        b=iDxbqgAiSMCZlciY1pEk197hjB3Qdux1n3l+CADQmGbvH0WUW94x2NItsjjBdvTEsj
         va/O57R2NKpagcq6MQnkCjbkSi130PUPOz907B/2kSCQckmJnoNP6GJPJySM9pHlMnzB
         uHHYb0ho+Mum+asqBhCNQWttbOA9JQ8iWLSt7NJ0oWOFIoNi1ojJqSjYMfWk4zZ1cjn3
         Wd72ZyP7GaNDFjDlBHKkdwduxn8C1d3I3a+Nrc8iKxuDdL8ozfHUnHlq+XbFw0MONlrW
         9x7L+THFi9AXCLdEiO43ymDFxrTJ9SZ5a/8mA7uiFeuEquyaDi3d0PdkOYLl3nhsyhER
         npRg==
X-Gm-Message-State: ACrzQf3FoKNn1gt4mp7ovnV2jWH4G3Gv2v2I+JSg/EFPeTIItkTyQCHA
        14OuuQXA8xRE5bHiJmNHEII=
X-Google-Smtp-Source: AMsMyM6yleovQFJ3ah6fjoL4/GqjeNqvkGqszLLljHIBY4JlX3ZKKOCIiNe5GzcvgUAqIk8KTFGPnQ==
X-Received: by 2002:a05:6214:5005:b0:4af:b6ef:eee2 with SMTP id jo5-20020a056214500500b004afb6efeee2mr1379601qvb.75.1665005437802;
        Wed, 05 Oct 2022 14:30:37 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:37 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 6/6] phy: usb: Fix clock imbalance for suspend/resume
Date:   Wed,  5 Oct 2022 14:30:18 -0700
Message-Id: <1665005418-15807-7-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

We should be disabling clocks when wake from USB is not needed. Since
this wasn't done, we had a clock imbalance since clocks were always
being enabled on resume.

Fixes: ae532b2b7aa5 ("usb: Add "wake on" functionality for newer Synopsis XHCI controllers")
Fixes: b0c0b66c0b43 ("phy: usb: Add support for wake and USB low power mode for 7211 S2/S5")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 2 --
 drivers/phy/broadcom/phy-brcm-usb-init.h          | 1 -
 drivers/phy/broadcom/phy-brcm-usb.c               | 8 +++++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index f78cff2..76cf428 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -430,7 +430,6 @@ void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params)
 
 	params->family_name = "7216";
 	params->ops = &bcm7216_ops;
-	params->suspend_with_clocks = true;
 }
 
 void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params)
@@ -440,5 +439,4 @@ void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params)
 
 	params->family_name = "7211";
 	params->ops = &bcm7211b0_ops;
-	params->suspend_with_clocks = true;
 }
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index bedf2b8..f9fbf8f 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -62,7 +62,6 @@ struct  brcm_usb_init_params {
 	const struct brcm_usb_init_ops *ops;
 	struct regmap *syscon_piarbctl;
 	bool wake_enabled;
-	bool suspend_with_clocks;
 };
 
 void brcm_usb_dvr_init_4908(struct brcm_usb_init_params *params);
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index d97fa58..aafba4a 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -602,7 +602,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		 * and newer XHCI->2.0-clks/3.0-clks.
 		 */
 
-		if (!priv->ini.suspend_with_clocks) {
+		if (!priv->ini.wake_enabled) {
 			if (priv->phys[BRCM_USB_PHY_3_0].inited)
 				clk_disable_unprepare(priv->usb_30_clk);
 			if (priv->phys[BRCM_USB_PHY_2_0].inited ||
@@ -619,8 +619,10 @@ static int brcm_usb_phy_resume(struct device *dev)
 {
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
-	clk_prepare_enable(priv->usb_20_clk);
-	clk_prepare_enable(priv->usb_30_clk);
+	if (!priv->ini.wake_enabled) {
+		clk_prepare_enable(priv->usb_20_clk);
+		clk_prepare_enable(priv->usb_30_clk);
+	}
 	brcm_usb_init_ipp(&priv->ini);
 
 	/*
-- 
2.7.4

