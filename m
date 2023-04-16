Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D26E3722
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjDPKSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDPKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8910D8;
        Sun, 16 Apr 2023 03:18:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a342f3ebcso523816366b.0;
        Sun, 16 Apr 2023 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640291; x=1684232291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Jvxyw959FBVgqwdIHjHqfLuFNRZ5ppQl2qELcKy9w=;
        b=a8/reai+fkCe0l97u3b5U2wOLRijCZpCFVTYo9W7WwvGifVyD2Svg5XOangqDnMw9v
         UiQvk2DzAV2i+ZCWAFQf/6bgUeFkblmNvoTTxbnSkRfeiNwAyelGLE3L7Hus0jMxVeXM
         5Xe/OpzoGwoC5Ih4ac9xayLYGRbO/Wft4yl576G4A6GdZlWl6UQKPspsHDch9VcoQOwv
         oEN6Dki2IBGnGA/7V1JeTbXIKTMN4FvNKfu6IyOLQ7F9R/vKjSABVb+9/mjqBpZ8LtmY
         EFV3hnyMz5SAO4Dhu/sQauy3yzQAFpgDXXcGm1+raTjNnE6nlXvp3FAkLShA3ESTSZqK
         8EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640291; x=1684232291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2Jvxyw959FBVgqwdIHjHqfLuFNRZ5ppQl2qELcKy9w=;
        b=MV4s8rP/BFKPXViqInV+T0KMxlVCOnoEt8pAxqeTc2sUuPnu4ElOrxFvr5dRmf/hwD
         ghChHmrEogfzYOC8INU79YJpUV+BJ/B62OGuh0XXTWcgNOsbH9luJyLG71eJGb6Fxujq
         5uPF4OXB7L2IhUFByTdBw9dXj0LSW9oF7hJYRhd2Nj0IIJHv2DcprQNmSkOy5Gql72Zr
         sNgo+i1YaiLKqa52HoE4pocVbp4tGnmS+Zz8SDQOabyLTbnlHtkmB8pU/OrT3sak1nO9
         5x9SKhrbkTJ4wLoDlMgcmCKK8Umk+2dvxOhM8CxStNZHtOERlfUc7wVyRhyUr/GBq69r
         ZXBA==
X-Gm-Message-State: AAQBX9erRwH68LwXXNuLAxIN4DsvsoVEXMXO/0qlZRjivRoAOOQnjE2T
        5J3ggovh4vPwyH0RbuxoQX0=
X-Google-Smtp-Source: AKy350aSVJC1e8d38M+/4GkG/aB/xdn2FE4imNsQNhQV8/4WJrKgBKEMZUfyCo5fWAX95bzv7TNC2Q==
X-Received: by 2002:aa7:cf87:0:b0:506:77e5:d157 with SMTP id z7-20020aa7cf87000000b0050677e5d157mr9264259edx.19.1681640290762;
        Sun, 16 Apr 2023 03:18:10 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:10 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 02/12] dt-bindings: clock: add Exynos4212 clock compatible
Date:   Sun, 16 Apr 2023 12:16:14 +0200
Message-Id: <20230416101624.15866-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-introduced as part of the Exynos4212 re-introduction effort.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/clock/samsung,exynos-clock.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
index 0589a63e273a..a36781a455b6 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
@@ -24,6 +24,7 @@ properties:
           - samsung,exynos3250-cmu-dmc
           - samsung,exynos3250-cmu-isp
           - samsung,exynos4210-clock
+          - samsung,exynos4212-clock
           - samsung,exynos4412-clock
           - samsung,exynos5250-clock
       - items:
-- 
2.40.0

