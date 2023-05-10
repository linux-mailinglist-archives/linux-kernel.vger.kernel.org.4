Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABF6FDC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjEJLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjEJLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:24:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB0E5F;
        Wed, 10 May 2023 04:24:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42711865eso22461435e9.0;
        Wed, 10 May 2023 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683717855; x=1686309855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQz0nqDpJgVq4PjwkeydzjRKfpwtaxnYesaYZraUnVA=;
        b=iYhqqeBjM48QaMhRPEkYT2YU9xh0zNEersu8qnkpWo8LOKJaY3U5yQqANAxFm/q32w
         FMPRVVqJoISnC6aPbthNCZ2xdFiww+h/rIBGHZfUEopODddgDdHLxjCJmFAUt91aBTQz
         JrODj+00bSBsNoicc9lV8Dy2QwiPJehj74NO1isLhlafHaNxiCGHGToDXt7tJx3I019+
         Ztg2rXL5HL00WhdtU1PesRNpVDA13SUzlwzBRZtDrMYf18IZP3jW15u2rHJQqVnmF6Qq
         BB5n8Xx0MVZ06IhybmDycGLq8GT69u1nkiQGXUiUgBdV9HM2RSVX0o/siMijRnpchDzA
         pWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683717855; x=1686309855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQz0nqDpJgVq4PjwkeydzjRKfpwtaxnYesaYZraUnVA=;
        b=C1Spq/6UKLfiy/75HNd/wkp45vuMpGtfKFAp2gzCO5HN+Ldc8dIJycHvkx+U4Xy7wp
         XLFwT/GoZpIro6H8hyNtinRKs8c/WqfEqogE+Xrcrx71BPnNhleYqgRh0BHYpnlRlpgw
         Xh3llTUAcjlG2J9yipX4kQSDzXOSiOKOtqJ7y0mKc8WKyGkPRgQ1zNhhYICL9UBZYYOx
         f8ciB+m+rnfFmbiXGa5B4jKEa706tgRxfuvltg3jkklCs/Yo6YxddGfwjQC9dUH2IgEU
         smtFIHCPYchfhk1di4DLM1SnArcfAFKc4Umn+UrlWTbiCUMtGXNXSUxHrIGOR9jbh28h
         54fQ==
X-Gm-Message-State: AC+VfDzWNhjnU1m+nIouYew/0/zxntCtoEO1R1j4kb+/YdwtxGMv1P3Y
        0YGJxy+7i21jb6LrkOIfRZzLI3bnmEI=
X-Google-Smtp-Source: ACHHUZ4TgiXNcni0p3xfh64OwhXDfR+Wd1HCOLbq3FCl8U1mNPBP52Jlnoi7sT3v6T7q/sv7EfLcTA==
X-Received: by 2002:a05:600c:21ca:b0:3f4:2c46:e74f with SMTP id x10-20020a05600c21ca00b003f42c46e74fmr3686113wmj.12.1683717855239;
        Wed, 10 May 2023 04:24:15 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n23-20020a1c7217000000b003f4ad703aecsm1262417wmc.15.2023.05.10.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:24:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: vendor-prefixes: Add ESS Technology vendor prefix
Date:   Wed, 10 May 2023 12:23:48 +0100
Message-Id: <20230510112349.939991-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix "ess" for ESS Technology <https://www.esstech.com>.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..95c42e32e02e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -438,6 +438,8 @@ patternProperties:
     description: Seiko Epson Corp.
   "^esp,.*":
     description: Espressif Systems Co. Ltd.
+  "^ess,.*":
+    description: ESS Technology, Inc.
   "^est,.*":
     description: ESTeem Wireless Modems
   "^ettus,.*":
-- 
2.39.2

