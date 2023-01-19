Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED66741D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjASTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjASTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:00:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D99515A;
        Thu, 19 Jan 2023 10:59:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1980321wmc.1;
        Thu, 19 Jan 2023 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPjtd9vBOZ8O5Mrti16lqrA6uxjKjDMRhW8Vexk68HU=;
        b=b9wbkgslkSIKtuBsDIe3np7vnMnmwj7O4DDeK98xCRfOQKA9CAcIgCjUjNd6wnaPdm
         VWidvEhg20ABZB2BiXHZP8LTokcJtp8IEFQE4UWiWImRPK+ZKj0dk88CxXc+koDbTZS2
         Qk4qPcZzwujFrxjN//RrrsnlxJKlxaLX6fuszX7SMbVczc/9fyt+cCFsjCjT2EBotwSl
         UQiPbH8OyO6VQAwuk/HDkNnRKzivpW8oYE6mmCwfFzuWyJiEjAK0C4skYVlxN704QW9J
         mLsIscziOWCLpCPiUFl6VGhpI6WocGBwBWork6PqDbNy3fGqUEK3qlXNzKyblxDLGC0b
         nTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPjtd9vBOZ8O5Mrti16lqrA6uxjKjDMRhW8Vexk68HU=;
        b=J+Nb/lKAafFH2dlm9H+O1GZjVrWmsQzoWhtQsAKjU5dTbphvTOSqM/vTWIWmBrg9cO
         1WR7Y47CfFjnLcLQNmo2+5y6JkgMC7GWyrvwQoVWayCtecaxVkrV9G/qg2+KT4BxvWPN
         y+sbOnyt3t6WSdCu/4lxTAbBxVDTJai3/ildvzaLsFS4bjzW48mqMJgNGaKOYqVj47yK
         a5lnHDFFZ6me9hreERkXom4LL6vT8B23c17MdKuOro7ZK2SaA59Ovl4D7RTN4aLKp48B
         gaUD+EccsyccNP5AvrLMs0wHDwlwXtmy3PGr3853NiX6g4RMDkNtaVTxxBOQEHHpqlwt
         F/Kw==
X-Gm-Message-State: AFqh2koyNpJCl1Dplu1gIHlfH9G4WPIP4sgO28abITmvdIm/qaCxLwyr
        Uy+UYmPJ9m/JDMJgxwwc52cqeezKimM=
X-Google-Smtp-Source: AMrXdXvi2SVpCQp1FIuN46xi+H4vwKIP0jE1XUp6OmzopqSrwM/aE3KphrtE2U/DQoBE/yfGAk7D1g==
X-Received: by 2002:a05:600c:17c6:b0:3da:f672:b0e7 with SMTP id y6-20020a05600c17c600b003daf672b0e7mr11303597wmo.26.1674154744858;
        Thu, 19 Jan 2023 10:59:04 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003daf6e3bc2fsm7757544wmq.1.2023.01.19.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:59:04 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] Documentation: devicetree: bindings: Add compatible for Samsung Galaxy S5 (Exynos)
Date:   Thu, 19 Jan 2023 20:58:43 +0200
Message-Id: <20230119185848.156502-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119185848.156502-1-markuss.broks@gmail.com>
References: <20230119185848.156502-1-markuss.broks@gmail.com>
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

Add the compatible for k3g in the Samsung Exynos5800 boards section.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index faea33e4f731..fc7c191640ae 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -171,6 +171,7 @@ properties:
               - hardkernel,odroid-xu3-lite      # Hardkernel Odroid XU3 Lite
               - hardkernel,odroid-xu4           # Hardkernel Odroid XU4
               - hardkernel,odroid-hc1           # Hardkernel Odroid HC1
+              - samsung,k3g                     # Samsung Galaxy S5 (Exynos)
           - const: samsung,exynos5800
           - const: samsung,exynos5
 
-- 
2.39.0

