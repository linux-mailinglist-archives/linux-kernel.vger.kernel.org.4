Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C625EEAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiI2B30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2B3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:29:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D56118DEC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:29:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jm5so13138114plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paradetech-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SM4jqQ6Il3GWV92a+UhDIXmom3xi+6T+8WqpFvA2YOI=;
        b=BxwFbi7sJXlRrhgH0WVMvi9wNAqdJvg8wsDNaPA1Y2P8J7Odr3QtDlVrPzYeSs/Sb7
         1SgoHrKtmewvv3/gCkL/k1lnuzNEgwIlxckRL/6YALlI758+YcuPXOtHDPVoupvBYhc2
         o8lexPw9R3nHrQYXcgNdZWvqt1+bYPoXUESBJaAqQoaSoHquHNXmn1/MxhqyjpriQc4Z
         EC2KupWYG30Gq6mHk8aKxGuSqGuAjWTlJJlYQgIsIy/c6P/oCG5AEeot3ttBv0mApLKr
         XnsqIcn6FOoY11lCVT4KYgMj/o9WvGaAmMU7MzQWYPJbSwcCSXll4/ZW15hbmApdHD7p
         vUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SM4jqQ6Il3GWV92a+UhDIXmom3xi+6T+8WqpFvA2YOI=;
        b=csNpAU1rqM3MoNjPLqZuUsbwFFISljuQg0+VcGutJEXAOwcPzTIHjXEk4+V3Agy/XV
         n3Cbj0NqCJ5ymFodk1yI/JdWkqHiR6A85KNHC33qgjGxQUIRBpnFISaQ94CB+JEaESrK
         ibiJ1fks81qGsBnmpZ62r0CtW6C25qf4mYZ/FJUAknbP+MHmzntqrEiBUV6ECyOSxKNj
         rFblu6AXb+zO1C3a+bczPC284LMImMTJ+rPmWB3ZBtoM9CDZunee6g2u2yJZILDWtN8W
         ww+YcJPJE1ZBhgZX62TFW11w97wmrUGTz9NnBujisULaKYibhykPtl5CNul4KIoMrZsG
         39ig==
X-Gm-Message-State: ACrzQf2neVsyGVtJOey2ntKAahAsHycfMRVVDTwFIgqlDyF9wdpPq3YX
        E/E3IBckouodBkdhn+8nKUUVk4nI9qnjTkXe
X-Google-Smtp-Source: AMsMyM4/VlvMw8aYyDVMgL6aP4TCJ54nI5FUpLRLPgGUaN5WTsGzu1Zib90d70GDDRWiW7G0kbDSog==
X-Received: by 2002:a17:902:b182:b0:178:8977:4013 with SMTP id s2-20020a170902b18200b0017889774013mr790987plr.27.1664414961796;
        Wed, 28 Sep 2022 18:29:21 -0700 (PDT)
Received: from jason-ThinkPad-L15-Gen-2.. ([203.67.103.146])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b00540f3ac5fb8sm4750848pfr.69.2022.09.28.18.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:29:21 -0700 (PDT)
From:   Jason Yen <jason.yen@paradetech.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     treapking@google.com,
        Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Subject: [PATCH] drm/bridge: ps8640: Add software to support aux defer
Date:   Thu, 29 Sep 2022 09:29:11 +0800
Message-Id: <20220929012911.2521786-1-jason.yen@paradetech.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip can not handle aux defer if the host directly program
its aux registers to access edid/dpcd. So we need let software
to handle the aux defer situation.

Signed-off-by: Jason Yen <jason.yen@paradetech.corp-partner.google.com>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 31e88cb39f8a..967dec840b91 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -303,6 +303,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	case SWAUX_STATUS_ACKM:
 		len = data & SWAUX_M_MASK;
 		break;
+	case SWAUX_STATUS_DEFER:
+	case SWAUX_STATUS_I2C_DEFER:
+		if (is_native_aux)
+			msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
+		else
+			msg->reply |= DP_AUX_I2C_REPLY_DEFER;
+		len = data & SWAUX_M_MASK;
+		break;
 	case SWAUX_STATUS_INVALID:
 		return -EOPNOTSUPP;
 	case SWAUX_STATUS_TIMEOUT:
-- 
2.34.1

