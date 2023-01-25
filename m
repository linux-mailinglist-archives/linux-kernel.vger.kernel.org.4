Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44BA67BDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjAYVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:10:29 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9A5AA63
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:09:33 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id l125so6119vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RJJ/n41zzX+saTp2LNncjY8Fypt3NmL9yEutFB4n1s=;
        b=WOHm/saIG3Dr4q+24Z7G6SYdxWckEwYZ2OiPVUiQlFDjk9J/GGH5G2lPCp9nPBdUM6
         NKLPG74xTyEwESMRZGQkeobMfCP0xvhk5dxc/hF9opSrydqXNm+bgs4xusEtsuqt6ZTj
         erM0lCjFlt1FjkKoN2A0doFteQq1lyRdmHVl5KpF63lOurZ1mSrCtIHL8WCuWLQTVOdQ
         f57HcEWpr7rvKo71D5asNmYTOkr2yKFiuCioq2hGejao5f7Z1Lr2hfTb0FQGrA4rgB2Z
         r62S/gRt3R3/7qHDmBiWTdJj+fteUohtw1NfX3myqFn9sBC4hrsY1vkKe36xcZhRDijK
         IetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RJJ/n41zzX+saTp2LNncjY8Fypt3NmL9yEutFB4n1s=;
        b=Ew4uLz7s8e7Rs5OMXH3SU3D2SKaejE3PcMf811tupYXXrJYouhJJdREeLGn378mm3S
         jQ36Hewvy5uEg+eIo5K3kryaulqDa7dNCbx8FHvoxAzbcS2csqjm0VJ/23qhzqQBHeue
         eMFZhuUn+C9yIigM4hKhPx60dQOAuJkK/RKbOz8Q7o/zRRn7f9XluLsgQhjgiTA8KuHA
         OqUtIS6LF1idngyZbXh1ToxTp8/G1ZHpYO9Bv0DwIYmZa9bL4i+6kRC3O0v/seyzLB/H
         FL+5yvnaac0rKYXipcvd8OvLYzQcGrqoevRZTr+hCWZyFQMTi8Jq1G5YYu7e9cj08ute
         MAAg==
X-Gm-Message-State: AO0yUKW0bqNmAfVEMijeW2L2h2ARvsFTBFFZrSa7mMHTnBc1vE3e4jMZ
        CdrDgvjebDPlCKQXcORBfAg27Q==
X-Google-Smtp-Source: AK7set9bH4FlpCkV+Z+7rYCaPzI9wpMh7X7Sa4ITkX7oLz7viTzX4t7Ud2ygznpBXw4WanAYEKE8aw==
X-Received: by 2002:a67:7284:0:b0:3e9:93fa:140c with SMTP id n126-20020a677284000000b003e993fa140cmr1644589vsc.9.1674680962198;
        Wed, 25 Jan 2023 13:09:22 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id q196-20020a3743cd000000b0070736988c10sm4177090qka.110.2023.01.25.13.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:09:21 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Wed, 25 Jan 2023 16:09:12 -0500
Subject: [PATCH 4/4] DRM: BRIDGE: TFP410: If connected, use I2C for polled HPD status.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v1-4-66a4d4e390b7@criticallink.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.11.3-dev-d001f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=dbb6ec7CfpiriM2pWdSl9OaXPVL9sCebyFiqEYEERQk=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0Zp8UY3oOfu1sE+y2VZfLN0nj6Zb8gpmkZWoxYPV
 wM1zUW2JAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9GafAAKCRDc1/0uCzbrqly9EA
 CPJlnlwhTnKovCKXXIx14LdNjTl14R/C5jZyKgskM3kkTsxuPRLUWuniHgeDEO7fhbZx3FwtW1QUp/
 Zn9RnwRza3ZKJEyHv0elltxnjisj/WTR0Z3NGL2xHIQXP8MxyGFBYtvJZoQHQ3rpmu9bOkhCIvD+fG
 7MenhcEfyBVbKBnIiK7AraSXgAMBWt5lGo6o8ZBbVHBVgol/iU5lkMs4Od1hCEmfWDyiGAbvvQnCGc
 XSo2TauNuwCKaDxFtgPUmxx9OEN5ng5G72LWN9H3o32YN7zWBHJsArkqExSVXGMn/BlK/rsjzKIwg5
 BQp91qTt4vHztKSR7ekaU6ikv8dQ8kG6f39xSrLXYOxt3IXaIauH6JtqkjeqnsaqxUDi3fR8sVjIW4
 6CU4mgt8wLdSt6qR7kSYMmqg6BDRRrKjvNd5HvlG1AYTs/aIXXxos80/58TJ+n/PqtROGGKAEPDDli
 oYJ6lkB/1H7pHV9ZfrvCTz9Ws4egquII/R3G7FOyp+kEMFTZQy7jIPfvmXHSdIIo8XSf8fg9pOz8IG
 j4k9CKHz3e699zCre/Yi7JazXyKpcJ3nedEX6XbrDIgXwqx7jShjt0rl2A/sdXuOQSR7Lfg1Ckqqmd
 X3/+eF32C7gtCmaP6ZLHcb0F93Y//74lDL+IYvGiTXMqEz+qFfntvOV1Q+Xw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Williamson <michael.williamson@criticallink.com>

If the I2C bus is connected on the TFP410, then use the register
status bit to determine connection state.  This is needed, in particular,
for polling the state when the Hot Plug detect is not connected to
a controlling CPU via GPIO/IRQ lane.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 837e1f81a0ff..ac216eaec3c8 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -28,6 +28,9 @@
 #define TFP410_BIT_BSEL BIT(2)
 #define TFP410_BIT_DSEL BIT(3)
 
+#define TFP410_REG_CTL_2_MODE	0x09
+#define TFP410_BIT_HTPLG BIT(1)
+
 static const struct regmap_config tfp410_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -105,6 +108,16 @@ static enum drm_connector_status
 tfp410_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct tfp410 *dvi = drm_connector_to_tfp410(connector);
+	u32 val;
+	unsigned int ret;
+
+	if (dvi->i2c) {
+		ret = regmap_test_bits(dvi->regmap, TFP410_REG_CTL_2_MODE, TFP410_BIT_HTPLG);
+		if (ret < 0)
+			dev_err(dvi->dev, "%s failed to read HTPLG bit : %d\n", __func__, ret);
+		else
+			return ret ? connector_status_connected : connector_status_disconnected;
+	}
 
 	return drm_bridge_detect(dvi->next_bridge);
 }

-- 
2.25.1
