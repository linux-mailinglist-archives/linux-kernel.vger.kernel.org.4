Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066B4608451
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJVEgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVEgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:36:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCAA16CA54;
        Fri, 21 Oct 2022 21:35:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so4756712pjl.3;
        Fri, 21 Oct 2022 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQYm5LqzX57uwWQZcQgQcLEzWEXhv56KAAGUn4/bM1s=;
        b=pQvvard2nxmZEuToHQCoxqKq7E+NyOPozW/OVGgcTjUXIuXUtthCc7761Sz21nK1Ck
         Q+8eGKtasc1vPLudAPwPMPJPFstelL3PbyCrl0dSQq+DvXA8k6SlKFDmHUn/5M+b/RGz
         W+CDlMrwQrXwHTjgmA5AfhFRGHL8ZLzIxI/QXty7DHZLWsYMOkGwH+UcfoN7vPB1wmo9
         6WlrXsoTcwNMG3I7REK8U4MpPMoGsafYEh/PUKmO2Qi36ARLc7tQ+Eb/BUQ1buaLGjs1
         FnX4Wplsz7wWStPIBsq/tcdrieUbUWspX769DNftAFHlJRNSrsSUjnHE9mdJl6RwN5YA
         OR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQYm5LqzX57uwWQZcQgQcLEzWEXhv56KAAGUn4/bM1s=;
        b=dd3BB8eeAO1dPh7oHz+F2Pq0FSBTsxDNYsgVLibcFxdJr34xNSEy0qXfXFOL8gnlIw
         OFmJTzYMIKZVJo0BUDZtnyw7rvsPT9UxjBryUGk9t1ByqCJvTVJgiJHL/Hzj6Bz2DWhr
         qcdRL0CbTj789Gec795xrGPnMnzO0xiybOjqlVtDLfXtsWZrJRGlegs9d/V0FT8J2wIK
         UXP116x/5JDnjaKeLBoGSDcUQ4ewV0a+bwEi68GXqkRKJ4VugfMlAt7bDH2PMgXpkcIf
         IJhOPZsGn+W7ZW9BgiM0j4Ip1aI51yh8vrAetWVnNgobaFoqoDQnbblwmYKG0KjcN410
         Jt7w==
X-Gm-Message-State: ACrzQf0/1yR0hY13mpslBM/w16am8vIjk/tVjyjGM1ghmZU1MRgpKiCC
        s+JhzCyM63lmaaYxgXaOQ1k=
X-Google-Smtp-Source: AMsMyM57V05ZKji27dZkrlNCQ2qo4WzjK3QyXijF498quz/JdHwf2kSi+mgkZ9Dg64BlKvl6JfMA6g==
X-Received: by 2002:a17:903:40d2:b0:186:6f1d:608c with SMTP id t18-20020a17090340d200b001866f1d608cmr9815540pld.52.1666413357291;
        Fri, 21 Oct 2022 21:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:8003:d90f:f801:7164:b4e6:b90b:c4d5])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b0017eb2d62bbesm402812ple.99.2022.10.21.21.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 21:35:56 -0700 (PDT)
From:   "Scott J. Crouch" <scottjcrouch@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org,
        "Scott J. Crouch" <scottjcrouch@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq: add 'static' to function definition
Date:   Sat, 22 Oct 2022 15:35:48 +1100
Message-Id: <20221022043548.1671644-1-scottjcrouch@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse error:

    warning: symbol 'vchiq_platform_init' was not declared. Should it be static?

Signed-off-by: Scott J. Crouch <scottjcrouch@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index dc33490ba7fb..ffa517077b80 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -462,7 +462,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	cleanup_pagelistinfo(instance, pagelistinfo);
 }
 
-int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
+static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 {
 	struct device *dev = &pdev->dev;
 	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
-- 
2.37.3

