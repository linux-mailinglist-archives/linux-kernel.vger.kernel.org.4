Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC95F2194
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJBGpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 02:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJBGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 02:45:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859782CDE4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 23:45:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rk17so16551386ejb.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+EFb6uk4cTnqBeI+5KKFVfi8qmpv//hil6I+XjIEg10=;
        b=Z6eZABtXZW25w/5ZyMrjoGibSALBRFTBPOZ3m9ciR8K5cg5YYtOx+uYUCdFWVGG7vC
         Fj8IrV/vXJ8t6J+fMB+I2+mkQIsc0hz6XEZxe/ffAXYEafz21v/MVLnMLO77sabS2aSm
         ma9lsFZUE903KWzEhReXmALwvDgy4P3ehuLBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+EFb6uk4cTnqBeI+5KKFVfi8qmpv//hil6I+XjIEg10=;
        b=rmoVKZW0Pl1vRIR/Em5b+IG64VZdAm4o4RONk95SyB/+F4omtguemUIeHsG8iDe8qI
         Nh3OHWwFKZmGDsJsCAyApP1xrQRxdbRl+AtxLsviScBeM7EMAi8EQW8F18ye72e+KUBC
         YUJt8E7Te2Cho4vIOtyB7ytjmhfrhz/8wpu2u7eiAIeWC+te0fImKB5BNWxcB/tIYZ5R
         NVV7fXPhs9CX1UNFHCWhVGi4R1r7fOKtuQIk0eNuIlMIU2wSLUt0KIGvfD4LZ+g7M9Gr
         7u9dJM36PXqnllYqlAS1wy0uE/pd7xRgM97f8AZN3Btb87qISQa3cqnxq46SaC2lGg2Y
         KYyQ==
X-Gm-Message-State: ACrzQf1+6o8PtnyAFfhOiOQnjgKFpNqtDMqz+/I9jefTtu3SabAHKtg6
        8KVeI9Ucfy6KvdQv3lRliownWw==
X-Google-Smtp-Source: AMsMyM4B5NnmV+Vv6ol70KZMuL8JEVXI/URE4cg0VGwaJQnYUbGUUGOKtgaodi64X9B7RZP0ZmTX1Q==
X-Received: by 2002:a17:907:160d:b0:782:bc5d:162e with SMTP id hb13-20020a170907160d00b00782bc5d162emr11502660ejc.291.1664693145088;
        Sat, 01 Oct 2022 23:45:45 -0700 (PDT)
Received: from panicking.. ([109.52.206.103])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906329a00b0077f5e96129fsm3569894ejw.158.2022.10.01.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:45:44 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Subject: [RFC PATCH 1/4] phy: add PHY_MODE_TTL
Date:   Sun,  2 Oct 2022 08:45:37 +0200
Message-Id: <20221002064540.2500257-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002064540.2500257-1-michael@amarulasolutions.com>
References: <20221002064540.2500257-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are combo phys out there that can be switched between doing
dsi, lvds, and ttl. So add a mode definition for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 include/linux/phy/phy.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b1413757fcc3..87ae8c27ec57 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -42,7 +42,8 @@ enum phy_mode {
 	PHY_MODE_MIPI_DPHY,
 	PHY_MODE_SATA,
 	PHY_MODE_LVDS,
-	PHY_MODE_DP
+	PHY_MODE_DP,
+	PHY_MODE_TTL
 };
 
 enum phy_media {
-- 
2.34.1

