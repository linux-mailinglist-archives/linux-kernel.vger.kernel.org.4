Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD606D68C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDDQ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjDDQ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:27:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D34EE5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:27:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so28473565qtx.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1680625641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCKZ9Mkz+RQ4mEYeEtL01DQSakeCQYik5lgGNcrvFgw=;
        b=gu8aDzW6mk7ndqQJ78eCYXkaMIcBflx9g1fcE0d0FuijriRXhfnU+AnBoaG8G96Ao6
         4woLHIqo1G0iduPIi1uA2GwJUvshAoPxVcs43wl8YPmvnvOMrw9WXwIll1kpfbn9q7+N
         jSoBV/aRYVQ0vC3xsX1DKaagUy1y2NKXB8C12FbSAU7wirgtLPywwAAI6K0ExR/IMoCY
         br0DhHh7k1Jv2pbZMvlFHFMJlYYPmp49p1HAccZo6HoawFbG20Zq4chO9gJdRf9iTatF
         5OEwjfIZQ+l1iV76f4Dm/7LHQUAqQyXT9fmfTXxajhx8Gkq2P9TcaFiMJC5czUuyJu0i
         yZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCKZ9Mkz+RQ4mEYeEtL01DQSakeCQYik5lgGNcrvFgw=;
        b=11HwIkIpICmBcXRB/J/EOosgL5wMpG0QFZ4g9OuYoOX85y3Q5/TIpKMHkYGrK5rE/V
         zkJwP2wdAU3EvGYTBgXPwe7Up1O63+s3l/6c1YuQGKCP34pl5sTdLadTzKzWrmCDwKI6
         F0JXzy+Y1blwxjj0p8CzeP5IEQx3a5rKT3/guPb6YZv90BOjVpZ7IRSEtbkqAiJlEgJB
         0N7UDduhYKCS6R5OtZOmGHfOE8Wbwe1K0MdDkvRDjSouIJtlaHdLCWwRHUEzXY9Hvsr+
         LxB3T0dYshO52c8nVF9nXXj1dKTz+e+NHlbzDhq12V7sjWcLcoDAWngiZc+iWS7NhlsC
         waTQ==
X-Gm-Message-State: AAQBX9cKo5qe9t+zFf66iDreunZLeosCCYHfti88j/z6vURrYwP1iMKV
        /sE7SoPc3slz5XqifpBcaehIlA==
X-Google-Smtp-Source: AKy350YdHhxJHAWa7CVEDFiWfp5hB318UjAsQxTMa/B80zKTDxFrmS6y3Oanueas7lgNPYz88e1N8w==
X-Received: by 2002:ac8:5716:0:b0:3e6:38cf:fc93 with SMTP id 22-20020ac85716000000b003e638cffc93mr92844qtw.19.1680625641325;
        Tue, 04 Apr 2023 09:27:21 -0700 (PDT)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m124-20020a375882000000b0073b8745fd39sm3699594qkb.110.2023.04.04.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:27:19 -0700 (PDT)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Tue, 04 Apr 2023 12:26:50 -0400
Subject: [PATCH v4 3/3] drm/bridge: tfp410: If connected, use I2C for
 polled HPD status.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v4-3-f983bcef2df8@criticallink.com>
References: <20230125-tfp410_i2c-v4-0-f983bcef2df8@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v4-0-f983bcef2df8@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=e9amVn7Rg4sZ0MMr3Oo/rypthm9YpAHvIkIP258W2H4=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBkLE/Ys8NZkx1nbBAzJJRYhysKfHgmOTynPZlQqnaK
 +xQYoxuJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCZCxP2AAKCRDc1/0uCzbrqriqD/
 4utNSdB0l9Jcpc5ExxjWDxeRwX7gWcySy/fuRa5QdL4/fBkhyq2A9l9PemRNrlMkDVszzle+CrsOuC
 oO92O1c4jnZZiNNulaag7Gc8Cy1nL06MRXBjy8iRCc7Gi/WUGoqI3jQ3mq1hYaY1DD+NPdJxUUsa6n
 Q4cNA3k92DyW42TIAnN4JKA9JP0Wx76oe1Z61xj0V88QKShYFORoAc5c8h63u6o1zG1kkm2yjDnPRN
 dcCK5GFcbjJbThlo5N4oMUjfQyBvEfhAcF+7dReWngXVsKtVxchUU0gEO8X/12xYWGZ+qpuULguYZq
 0mlb8FldXYcgurMFXN8B9d2AoNjidUez7XkNIm2KDfwy7cm+lK7IG0dJkTWh/BfrElcUSgWw0uu/jN
 W7kTsCyLXhZRi2Q+rgogE9yAwLJaKIUpjzVPbnyJSYvKcR1nwxBRVqN5RBkyJa6MpzI6TK/Q3vcTjJ
 tAKt/qI0Dk3MLXri1wMJi2dS4LKVNbUxMjX5rYafKK6nO9EKH+r/8jx+6GX6xSqwNrV4dMi9s471Ek
 xkaWUNjgLPbIdmnMotNEAKNC4Z7oNkCXQN9QHalvBptIc9wvvmf4qVsI05niR5MdN7JlPhhAqsKXFc
 YPJQbaYm1cpzfhOelWQqRc+OHjrXWcLIZfq/6L8JDV7VSRZvnQj6zke+L6iw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 41007d05d584..eeb7202452aa 100644
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
@@ -105,6 +108,15 @@ static enum drm_connector_status
 tfp410_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct tfp410 *dvi = drm_connector_to_tfp410(connector);
+	int ret;
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

