Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8257561A3D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKDWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKDWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:01:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275943AE9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:01:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y67so6574782oiy.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALGhbLG8IZq1W8PcaxhXQ3scDMznxgngbZP1/w11AsU=;
        b=WnGV3hmxxtBVfN8nZUkGESLKx+wSYEkqROLH9Z6vx0g3hbEglS/FURqo4NrcbD+K4q
         vQW0A8tZpN/3Vg2fAm9gemOhwfKc85zV26faEF6MC6HbXqUGqOvnvvh1X34QFzvy7Ynr
         KMa6vN3tImlan3nvT/sobFJdiwD2G81TKO6oyNeUFIyBKGkYG5l4K4qmDbMa0dhDCP0q
         EaSz4Y1Gbk6I29b20cXvkjLZ5NOLB/h2nJVOAWEiCF6UALPZaKJQ/7Yaca+LdEknbAAD
         E7lGljsKtxRi26yGkLDDiJ0/DJ66BieGeZRra0ShR2P7wwwPNK2HFV1tlxpHLM15KsEX
         R4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALGhbLG8IZq1W8PcaxhXQ3scDMznxgngbZP1/w11AsU=;
        b=Zjq2erQ2Ybf/EUbh4WgCviLNQF5ceLcVNxQdn9ZnTLuxc+jltk13Yi8CVyFIj2pD/G
         QvgFXPE48i9lhV8m18ofcnQeM/pBnWn6T6B7uFoY1JiugCYrJHQugyJCRFjSj2bOyikA
         3btzozO8wR4w6VyPtVHW0noWJK4rRr8WN0hQL/V+TaVTDM1aiNbrAQNR/XDLbeKd2VPQ
         7kVlvzyywOedzhwm56cw2KOYQI8alM7/CmRbqhgNzQ4sKwFIvUkkFhGAt43cHNC9tY1j
         drdG/C5V7RgYESFeXSNnbp4O2IA4ADGmmRIa5XsjCPN/pqXTYFI2cAfZad+xnZJ1neCU
         5agw==
X-Gm-Message-State: ACrzQf1OGVzGx2xC0db939D7UthwulMGT0+cZhcDMI8jjlH7voTL6/w5
        biN41UTWe4feHXf3Z4Tv0v8EmcmhRJJtqsgP
X-Google-Smtp-Source: AMsMyM5WrFEmsHFyNFoYuKhenK2bjTP2pebM1NY6MW9nmza7DkOwA+acCKLmIXqe2f3hCYNlA3KpJQ==
X-Received: by 2002:a05:6808:30a9:b0:35a:6dc0:2104 with SMTP id bl41-20020a05680830a900b0035a6dc02104mr426141oib.142.1667599311010;
        Fri, 04 Nov 2022 15:01:51 -0700 (PDT)
Received: from antonio-Lenovo-Legion-5-15IMH05H.multilaserwifi.com.br ([45.163.246.212])
        by smtp.googlemail.com with ESMTPSA id o22-20020a9d5c16000000b0066756fdd916sm193893otk.68.2022.11.04.15.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:01:50 -0700 (PDT)
From:   Antonio Gomes <antoniospg100@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     antoniospg100@gmail.com, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v3] drm/nouveau: Add support to control backlight using bl_power for nva3.
Date:   Fri,  4 Nov 2022 19:01:21 -0300
Message-Id: <20221104220122.38622-1-antoniospg100@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031163211.13228-1-antoniospg100@gmail.com>
References: <20221031163211.13228-1-antoniospg100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: antoniospg <antoniospg100@gmail.com>

Summary:

* Add support to turn on/off backlight when changing values in bl_power
  file. This is achieved by using function backlight_get_brightness()
  in nva3_set_intensity to get current brightness.

Test plan:

* Turn off:
echo 1 > /sys/class/backlight/nv_backlight/bl_power

* Turn on:
echo 0 > /sys/class/backlight/nv_backlight/bl_power

Signed-off-by: antoniospg <antoniospg100@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index a2141d3d9b1d..5c82f5189b79 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -263,7 +263,11 @@ nva3_set_intensity(struct backlight_device *bd)
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
-	val = (bd->props.brightness * div) / 100;
+
+	val = backlight_get_brightness(bd);
+	if (val)
+		val = (val * div) / 100;
+
 	if (div) {
 		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
 			  val |
-- 
2.25.1

