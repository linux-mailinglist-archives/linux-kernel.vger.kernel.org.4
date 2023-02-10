Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FE6916E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJCwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBJCw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:52:27 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE160D4A;
        Thu,  9 Feb 2023 18:51:59 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id cw4so2757877qvb.6;
        Thu, 09 Feb 2023 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6+48hgnO2gTjvi3w2MqkzHMRFt3hzTXJXWQj1iCLhY=;
        b=M5MjZ96hJzJ0033EP/SEBjkaHF62hsi7Mb5WqlmFoLlMLptfidBkuAyq1iVBDfz8/h
         6kFa+NRPM2OMc5KzgmIu//+MWw+u1QUJXDoUw/ZJFoJnu5ssmMtQVqtPPcmBN0EAYo53
         36R0sCF1GiYZDFu3AMVo0lnhy/3I+b2mvdB3bKQVj+VEMbSpZ2mUHvKr7/NfUCOQQWw0
         59J+5lT3416478mCqSkYeQQey2+OscLa4+lT3FBgzG1nLmw9D3MpYl1vkXWlfsHh5D1p
         1+aXIY0dTFHLscAXBsyt439p3Gj4J0/LMCUlnDaC9AAr45f3ncLjGKF1VYSzlpnjKzk1
         1aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6+48hgnO2gTjvi3w2MqkzHMRFt3hzTXJXWQj1iCLhY=;
        b=pcpeibwMFaKfR8ysjwupgNsgN3EwKl6CgmJQ7KO71JIoG7kmJt+G+e/THJCihVOXWV
         hYM9VUbTzUuOFIx8Rjs6/EEYJJP/ieOrscqRTmVG2LAnEd5JbAQqJfAtS2nE8rsksG6L
         keIeyJKZ0wTrLaYbmAJTcc7M+M+A1kr2uers+tj+7XPRa9VddKGyOeJWevq+mu42b3wa
         g4f3GDY3pKBaN6ybge1NxBSIiJ3raiFY2QhiIkkmFLop+AM6U1QiaeeBZ8/htBgd5m6D
         9nbTGQC7ET6qY/fzOBawHpOYP5uqwE5dkOTsDonVVn+hUv/X/aF/nlNr8nmAG1HY0Sac
         HJgg==
X-Gm-Message-State: AO0yUKUWN8ufSlEBq0/PRgzsHd6GvezUK1N8xc+7drh22e9nrKyfg3uC
        3U/EJwVJLnw1aI0v5OqgAFP9kvBaeNs=
X-Google-Smtp-Source: AK7set9P5/13cxfHVB4IddQLjmZXYrqEHgUPKJxNyGztfAuGl8T9d3qEx8G3mi6k3xrzdE+yrgjOPg==
X-Received: by 2002:ad4:5b83:0:b0:56b:ff68:7ae1 with SMTP id 3-20020ad45b83000000b0056bff687ae1mr22608434qvp.26.1675997510706;
        Thu, 09 Feb 2023 18:51:50 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id v129-20020a372f87000000b0070495934152sm2667265qkh.48.2023.02.09.18.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 18:51:50 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: gpio: nxp,pcf8575: add gpio-line-names
Date:   Thu,  9 Feb 2023 21:51:31 -0500
Message-Id: <20230210025132.36605-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
In-Reply-To: <59efb87b-5f97-a409-46ae-095ab03d01b9@linaro.org>
References: 
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

The devices described in this binding represent 8-bit and 16-bit i2c i/o
expanders. Allow the user to specify names for up to 16 gpio lines.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v2:
- expand maxItems to 16 to accommodate that some of the io expanders
  covered in this schema are 16-bit (e.g. PCA9675)

changes since v1:
- the original said [PATCH 1/2], there is no 2/2
  (or at least there wasn't back then)
---
 Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
index f0ff66c4c74e..3718103e966a 100644
--- a/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
+++ b/Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml
@@ -39,6 +39,10 @@ properties:
   reg:
     maxItems: 1
 
+  gpio-line-names:
+    minItems: 1
+    maxItems: 16
+
   gpio-controller: true
 
   '#gpio-cells':
-- 
2.36.0.rc2.17.g4027e30c53

