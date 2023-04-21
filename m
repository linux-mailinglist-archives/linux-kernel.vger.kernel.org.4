Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB366EAE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjDUPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjDUPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:43:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344AD13C04
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso54334005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682091820; x=1684683820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSTxzI2UL4iyV0x1qsc6iOOIHOUmxegUBSvF/ZUcYNk=;
        b=i40TYNbdQuSpdWFF00dXQx786i/9MjaamcmD6i7fvKTAN3xxgc2TJNs2u1oep1YUPB
         KzvgUjujGlJKhd6gCCnxGMP3GyH3L8F0lpfgRfzddPiVm+e+EuWXZLuXv2E2zdVJ4L8P
         vM1h1S1JpUDsWTlxclBSN439k8JqgZKD8j5WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091820; x=1684683820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSTxzI2UL4iyV0x1qsc6iOOIHOUmxegUBSvF/ZUcYNk=;
        b=Xpexu6XiVOr+BgluyfmVux+u7uIDKMS0JvqWCaq8uadpxjaDNp/cemIgwfekLyfjOG
         QbLJMNrSNcXqmrxzUrMEupQvv9l0xcNPUhVMGG0cbUr+lmW/6Pk+XGBM+F2T48J1cvw/
         Bl+LnwEUECIHpUgtIoRhmYB7tml6+QwvDphXDHLqqNmhorqNaQTimKEmTzbeFsoPaHM5
         fk2VFR7fQeieKoz+i2YEpwnMq0tpoZ3RThwyZCdH4t5KA8Mds57BM8qgAjfT1+SWodWd
         lpQwFMxNI2v9XPj3tY9/a2gvz2P4BYrVVVlPVbII7xq2K3BqaLypxhJxi1pDi0TgVqj2
         QQMg==
X-Gm-Message-State: AAQBX9eMTUSX72PlIqQ/G8OE8D9amNFnNhmBXLmVwOplQG9Lb0nzE+G9
        LcytHrGOGpzWBQDrGRmcZ1U7ShB+1Y71YopVBMxIHg==
X-Google-Smtp-Source: AKy350Z4srGvgKG10mBjRPzYdYpuxudfGWzNDz/qzD+shoAncKiAblL4cxYi1jVsAyWCzfyuso0tLg==
X-Received: by 2002:adf:e689:0:b0:2f9:805f:eecb with SMTP id r9-20020adfe689000000b002f9805feecbmr4493211wrm.3.1682091820245;
        Fri, 21 Apr 2023 08:43:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.127.129])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm4651609wrw.79.2023.04.21.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:43:39 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6/7] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
Date:   Fri, 21 Apr 2023 17:43:07 +0200
Message-Id: <20230421154308.527128-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add Tianma TM041XDHG01 that utilizes an Ilitek ILI9805 controller chip,
so its compatible string should be added to ilitek,ili9805 file.

Add the compatible string for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../devicetree/bindings/display/panel/ilitek,ili9805.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
index 57c36cf22e4a..6065ef5ec385 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - giantplus,gpm1790a0
+          - tianma,tm041xdhg01
       - const: ilitek,ili9805
 
   avdd-supply: true
-- 
2.32.0

