Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA38676918
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAUUR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjAUURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B522DDE;
        Sat, 21 Jan 2023 12:17:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz11so21906342ejc.0;
        Sat, 21 Jan 2023 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+5bO+lWD89GR1evsBX1z7xFkVso1S4GR3FB8mwTo4k=;
        b=kYJDFo0cXdVHqzzZoGnC0BoLwbh2tQcScjIRh2HB9SS7igVrkOe/Pq262tcFZINKgN
         9mPs6cXkhMkMGQ1v5cjmzOmcyOAB4nN6Ye1gBQlwxYYr/DEhvOGxVkqrQ2Y6WlwsIUwH
         uho6W1+zDU1Ttx/wRaR9X9o9vlSLbs7FYane2M9d3jTR+kn2pzZeXM2LHwcy85+3D5Xh
         Hs1QloP/Uu7RQhRHWfnyUu+DsVCCAIT+Ybais8rSTJcu1ZreHodwjCBDvStC4XXgkP0e
         9tHTd6kwX2ZyPdGZOfVxfWGi8UsHtgcjyhxZlkJ1LfqnliQdKOQFk4FOgDprguCu3Qw8
         j3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+5bO+lWD89GR1evsBX1z7xFkVso1S4GR3FB8mwTo4k=;
        b=x577StuvAGijXgZLq98lvdKBGGi8e7FPVlCKq29/MU4XclyiClVz21SVyvotsJSpox
         1PT/RhMNZUHpGH3zHVplAv1os//8UlTjRjEwRs5QUXrNgMGA8qzKw7NGoPNUHtG5Rr8f
         Q3cCB8hwBNOSX9DdqPAPjhvQ4ps49nqT3kwYchvsxj7ZwMMCAg0y0gV3sG9pev/UNcec
         V9Vo2L5B2Mt56r4TP9aQt2GGJBjot4aniCxd1ujUyaK6B3mmbYzmKD3Cu5vEUNnJXFbS
         W59XXiYf5OmG3KO/FzMawaowx0BMY8ox+fyTdOLoTfSNY0Kbg8hCoyTPsENdem1gsoud
         GDLw==
X-Gm-Message-State: AFqh2koP1bU+j6QUku/w4xFAZZxNnm4dTBVu+0mkZDVf2mx9mk36MIZv
        v/IAXmCN4+W3+ypVbLLXzBtxCuxINgIEBw==
X-Google-Smtp-Source: AMrXdXuVinXxRzJD+kAu5PdzPPK+NSGlS1nS0Xhb5JPeJW7Y7+FP4XK6HYu0k7IOFsNsuzFpguJL/A==
X-Received: by 2002:a17:907:8b8a:b0:82e:a57b:cc9b with SMTP id tb10-20020a1709078b8a00b0082ea57bcc9bmr37867425ejc.24.1674332248621;
        Sat, 21 Jan 2023 12:17:28 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906614400b008512e1379dbsm16599493ejl.171.2023.01.21.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:17:28 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S5 (SM-G900H)
Date:   Sat, 21 Jan 2023 22:17:20 +0200
Message-Id: <20230121201722.46636-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201722.46636-1-markuss.broks@gmail.com>
References: <20230121201722.46636-1-markuss.broks@gmail.com>
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
index faea33e4f731..deb2cf971871 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -171,6 +171,7 @@ properties:
               - hardkernel,odroid-xu3-lite      # Hardkernel Odroid XU3 Lite
               - hardkernel,odroid-xu4           # Hardkernel Odroid XU4
               - hardkernel,odroid-hc1           # Hardkernel Odroid HC1
+              - samsung,k3g                     # Samsung Galaxy S5 (SM-G900H)
           - const: samsung,exynos5800
           - const: samsung,exynos5
 
-- 
2.39.0

