Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84D5F5BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiJEVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJEVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B18276D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:36 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z30so1083199qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ADXfYjVqcsb71HATcSWA4CTLqWqDoNigZwkBL1NsNA0=;
        b=VMAultGS/VumpE0hdEat79ZOtj7Ps6VEKJe73ns71ai3VkjcGU1DZv2b+1XtrvH+19
         QFyC5d3J/f+mEI03MEimDecJryzOie69YRas0xRcoiOFdArT3CzqiQ6zi28eLNY+WnWp
         /jfhbjFnC8VuQPsnck0Y5v5NfXzamtmXQgcdCL2iMbM5nei4Q9j6VDFCWKmuOOPqCnKC
         eyluSC76Vr5Lj5ZVE3lVfE9HGRjDScfWNcnW4qSQIQre8lWIcVS62nvL9LxI2qF5OWnI
         Zb2hmuf7SWX4U5AKJQnzJX791ayOcjtP7JWFw7BM76/CZEezwK4PIiN12pKlf0S1yHck
         EJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ADXfYjVqcsb71HATcSWA4CTLqWqDoNigZwkBL1NsNA0=;
        b=TvWW2ky/n31q+/aveKglP0+BuCNg1zHaCMOVP1WvtoYRvsYStN4cvNfDUwC09CiCQq
         aewqSfg7zOk2CjE0h5nvtH1RFnqRxCsq2+GgiKjpesUX1xh7h5SkyBsmW8sX51hLxAS0
         oQ69ZiKV3YK/6QcZpMaW3ti7H611ZH0XR2x0aez9yK4mRk1XqfSpIwZCKMz223nUmu1o
         A3hx1w/pHLNkO75PGDF7C9qBGwZP6m7c9KXDdg8pX07OIlQvEgVGHrK2WsKoaEo8qek8
         L4dslbtAJgQe1bS+peed+PXxgMbXki2hY20AXta5y+utS/xlLb1K70xfRXEu+3eCxQ9J
         ulJA==
X-Gm-Message-State: ACrzQf2eDQ9jXiKCDNONvPiisWkSNza++c3LIheMSbfWrhknAXK9VGSD
        TLBZoeySG6nG2HDd6tf0gBU=
X-Google-Smtp-Source: AMsMyM5SMCbfYce20jcrqzVl+aVKGTNodDOWJfok6qBCDyQqyEPY5dIYpL0BbCy/jvmC1YLsNAnK/w==
X-Received: by 2002:a05:620a:2a02:b0:6ce:90fb:51b8 with SMTP id o2-20020a05620a2a0200b006ce90fb51b8mr1151710qkp.460.1665005435541;
        Wed, 05 Oct 2022 14:30:35 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:35 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 5/6] phy: usb: Use slow clock for wake enabled suspend
Date:   Wed,  5 Oct 2022 14:30:17 -0700
Message-Id: <1665005418-15807-6-git-send-email-justinpopo6@gmail.com>
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

The logic was incorrect when switching to slow clock. We want the slow
clock if wake_enabled is set.

Fixes: ae532b2b7aa5 ("usb: Add "wake on" functionality for newer Synopsis XHCI controllers")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 6a4d478..f78cff2 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -337,13 +337,12 @@ static void usb_uninit_common_7216(struct brcm_usb_init_params *params)
 
 	pr_debug("%s\n", __func__);
 
-	if (!params->wake_enabled) {
-		USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
-
+	if (params->wake_enabled) {
 		/* Switch to using slower clock during suspend to save power */
 		USB_CTRL_SET(ctrl, USB_PM, XHC_S2_CLK_SWITCH_EN);
-	} else {
 		usb_wake_enable_7216(params, true);
+	} else {
+		USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
 	}
 }
 
-- 
2.7.4

