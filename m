Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DD6B2259
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjCILLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCILKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:10:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26404E91B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:05:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j11so5376854edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ujwdXwajbqzIp8w+URIoJrndYaLSTJTCghQ93Kw5KM=;
        b=OeS3rVlCZELUIzDgjHn6Iq007IzPrphWqsSMa9/2m7Cr+DfQWsdJIi5UtRdaplic6j
         spUwNs6zKt7od29+ibeC2IS9GiTrFz9jelKcusYjesYXWAfRJcDMbBv+bkmb/cq6u89w
         H7om1t5IhYZxLmiP6+iiQjY4dsUzH9RxS12gMKaQlEI/3ngcGk6Mj82WxqOhvTSKYI05
         K24IFuSTWIh3+ayOk6QZAZJ7wBHMgD8A4jFhk95mGx0H3Xx1ehnHkmPOjDROVZuVo4je
         d7Yny9m65Apve1lR4Gy3MX25nyAc0BaTUXNcYB2BFmrrgx0UjZeWCd2REVPGMKb4smb0
         6trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ujwdXwajbqzIp8w+URIoJrndYaLSTJTCghQ93Kw5KM=;
        b=56smTVjkpdbGNsE2TxtWoCq16FNAB09Oc0juURepbSGL/a8nOUbLj3aSjsGtvFIhIt
         /lKrHDl6XNxUvea/Y3KjnrvgpAS3dzQb5q7tl80FDbcwdcj6Al3TsXSgJkpvPPBJ1MYX
         mGbHn/t1+mabFEEogdmJ1TpCIJN8h6DYXymgklk0yLvI9yZO+7mI6Zq2LYk7FZAF1tUH
         UFYgB/HI9RpS3iYgs30wDgtnpFj50ZZ6FnZxb7SdITOIj4v1V3mF4+0RELqKYk8Q3JhQ
         Wcvy2sWfBxHIYiN1h0vbXhK1StiQlTUBvxwkTd/Hceb1HwkYBUUFFRs71DsePYoPLLFN
         p5WQ==
X-Gm-Message-State: AO0yUKUWrsFC78XqYdmGGUy5/d7CnaDF3Gv25+L8HsyX8CRi4Ip9HC3F
        fm0PYKfU4l/SBe1I9eg/sp8=
X-Google-Smtp-Source: AK7set8NV0T0MiRe6KZaSeG/N2snlRGUptr0JuTmSA/LOx0/KoXVPqhHqVCawSM+7Lxr7V0s01PUmw==
X-Received: by 2002:a17:906:2da2:b0:8ae:f1cd:9551 with SMTP id g2-20020a1709062da200b008aef1cd9551mr21512315eji.76.1678359902163;
        Thu, 09 Mar 2023 03:05:02 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id lo2-20020a170906fa0200b008e09deb6610sm8650935ejb.200.2023.03.09.03.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:05:02 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: rtl92e_clear_irq() is not used
Date:   Thu,  9 Mar 2023 12:04:39 +0100
Message-Id: <20230309110439.24504-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The function rtl92e_clear_irq() is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 9 ---------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8edfaaeda910..db26e431f8b7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1969,15 +1969,6 @@ void rtl92e_disable_irq(struct net_device *dev)
 	priv->irq_enabled = 0;
 }
 
-void rtl92e_clear_irq(struct net_device *dev)
-{
-	u32 tmp;
-
-	tmp = rtl92e_readl(dev, ISR);
-	rtl92e_writel(dev, ISR, tmp);
-}
-
-
 void rtl92e_enable_rx(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 1713381dc2b4..fa3b71dbb091 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -18,7 +18,6 @@ void rtl92e_enable_rx(struct net_device *dev);
 void rtl92e_enable_tx(struct net_device *dev);
 void rtl92e_enable_irq(struct net_device *dev);
 void rtl92e_disable_irq(struct net_device *dev);
-void rtl92e_clear_irq(struct net_device *dev);
 void rtl92e_init_variables(struct net_device  *dev);
 void rtl92e_start_beacon(struct net_device *dev);
 void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
-- 
2.39.2

