Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6BA5BA6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIPGWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPGV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:21:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E976442
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:21:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e68so20304214pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Jj7/OL2eAqo8lI0rpxiTJPMY8c9JRtqqMwO4KPdPLeU=;
        b=nal/o+O3eJncjRsZGGpMQv+2GWSnSNTfo2mqaEFt2WZQFfUVjftZl0aYv70EGSlvqd
         espf7tC8p47zmJtrJhK9uXL7WlKXedffzsUjhKve3/7NSyOaXOlTenmBmG/z3Nrp4Rij
         FELLoQT5RFnJ/bAQvKJsAJbNHademq3eV8ufZ4TBvgyt8AavJjwLyZA+jj7y9OHr2Dw4
         WyZZbLyn1YxVQr6A5aL64XCByooz6xdR4LJzrJ2OQuQX1ZCEr15ruNToE6Oz1lvhi6Xm
         DDgEtrAKDJN1+oQtLDCCY/kJ8aQjHSqXRKap6OqqIeL+kn+aRvgGqm1S1sUDRCJym7bq
         H73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Jj7/OL2eAqo8lI0rpxiTJPMY8c9JRtqqMwO4KPdPLeU=;
        b=pxwBwSSxEesS2EZHX9U0rjva/KcZF+g5d6yQwfoT3fXW7uBTm0MItvRoHL9r8tXekx
         /OuI3xK3lp2b5H+OCXu39yHsIZvlf2GTRcjzmMfKMcjbEWLT5sEbCi0nFj/kgMD5Eeni
         gEjYGHTZqhDFgKgECeAbcKkc0uletWF9rExRKIGCF0u05T5cDMrPZagLkgAB5gAEADtg
         rf8NqkiycQ1qQLsBSaxU7vGBqj/33W3Xf8S/aIzyYkLkfdzJhbSj/JVV4b8q2PA4aox+
         aAhQWniepXYDinfEOZrlAoewk8yzMS7z4siSfdI8qAaGFNJs34pial0LhwHFNwDKoe7v
         GOhA==
X-Gm-Message-State: ACrzQf3ugicEd2IRgQLPR+cFiiUrEdlTsiGu9e2xA02Vbom1rUNO/FkZ
        DPVkD4b7t1aq4L1B2BbRq7tVNHCpSno=
X-Google-Smtp-Source: AMsMyM5QO7rfjdJwjmcPfcEly/IZWfWK9JNGayYfv+GpRNG27/ZOH+GqVUsicuohhMFhgkfwtH4HUw==
X-Received: by 2002:a65:4941:0:b0:42a:8c1b:6b6c with SMTP id q1-20020a654941000000b0042a8c1b6b6cmr3164083pgs.375.1663309313479;
        Thu, 15 Sep 2022 23:21:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b00168dadc7354sm14177639plh.78.2022.09.15.23.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:21:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     vkoul@kernel.org
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] phy: broadcom: use function devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:21:50 +0000
Message-Id: <20220916062150.153104-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index 0002da3b5b5d..0d393e0cc7bb 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -236,7 +236,7 @@ static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
 	int idx;
 
 	if (version == BCM_SR_USB_COMBO_PHY) {
-		phy_cfg = devm_kzalloc(dev, NUM_BCM_SR_USB_COMBO_PHYS *
+		phy_cfg = devm_kcalloc(dev, NUM_BCM_SR_USB_COMBO_PHYS,
 				       sizeof(struct bcm_usb_phy_cfg),
 				       GFP_KERNEL);
 		if (!phy_cfg)
-- 
2.25.1
