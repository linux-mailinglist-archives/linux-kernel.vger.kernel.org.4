Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997236F3897
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjEATz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEATzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6334D30E8;
        Mon,  1 May 2023 12:55:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-959a3e2dc72so591004866b.2;
        Mon, 01 May 2023 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970935; x=1685562935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioENJwwSwT8zGQMUXkQ8Tqi2ax0jSorolSTsZSyeeas=;
        b=K6eLCuzGsavXNmaXAh7srZI2woPo8xtK6L2wfwkbtp/Imj5Jj/+aB/6HBz1M9AkTO5
         TkKkJFUipDeWNfNhpiIbWXRobPXpksgkC1zaaE1mb3GeMtRRx6uWfz991ioq9MrzalxD
         1vWbe8+uUFp+LwcxQ2+hfg2Ub1LOs0AZ2IJh77xI8giNy2daVxEaJOftr0j6wInKM0Y8
         kyW6KtbU/F67Y5ukPSPemwBjQ6Mx6niLahdF+xg1nHFnlLfQUmjuJrInWzeKOtVVAQ4I
         lW5sHNlfOTxqPpOCwj3CYxBieq3mg7onrNaqVk+cCQa+XeKHQfcrZpluhX68gxtmAEa+
         E3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970935; x=1685562935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioENJwwSwT8zGQMUXkQ8Tqi2ax0jSorolSTsZSyeeas=;
        b=I4KGI2c8Vwipu1IuatPoEsWByeQlQnzcr2tNPqBwkrV3BHEejje7og3XpnFnfmEweq
         sfknCy/brh5zFmxTjZa00IFoED6RX5GfwUeHGJCEwIA7wVKlUycfQs96RFHf6sT1c9Ov
         CcfVv/y/DLGrqu/gCvbGjLwXq+Ids6n5++ttXTdOShHKsqb5aMSIQKcDPTaMSNaJApEN
         7z3bds+wivhmJS3dH9nsc/9kczrk3tF09nCdgycFyGnYwZESd/bHeOX/F8Dy7sVKVyu6
         chL/asvOxfqHdlwQZ/pqG9KlGiylolAr8KuuRYz1aKXHNhu4KQQdGd0TxUh0EELf2ovh
         R/OA==
X-Gm-Message-State: AC+VfDyX7OwHdWCem0TvgGs3YEmZZugUdggkT4QXKsX0QLiG3ZcdYHmD
        UwGdMNfbX8T/cwR5dt8oLRs=
X-Google-Smtp-Source: ACHHUZ6IVZDwDQOTnnbij4uvxNxCT1PMcB7uRFLQJHqaKRBGgkrS4fKg3jfhVmMzJmY8cz8Ps3IH6g==
X-Received: by 2002:a17:906:7308:b0:94a:8c3f:d0f0 with SMTP id di8-20020a170906730800b0094a8c3fd0f0mr14002808ejc.68.1682970934695;
        Mon, 01 May 2023 12:55:34 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:34 -0700 (PDT)
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
Subject: [PATCH v3 02/13] dt-bindings: clock: add Exynos4212 clock compatible
Date:   Mon,  1 May 2023 21:55:14 +0200
Message-Id: <20230501195525.6268-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501195525.6268-1-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
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

Support for the Exynos4212 SoC was originally dropped as there were
no boards using it. We will be adding a device that uses it, so add
back the relevant compatible.

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
2.40.1

