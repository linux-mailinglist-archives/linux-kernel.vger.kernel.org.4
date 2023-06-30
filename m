Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F939743FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjF3Q32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjF3Q3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:29:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDC3C22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:29:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so12342405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688142560; x=1690734560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+ge4K54TEOm7/rx5aIH7nXv5noKUxUQbqIp51XysbU=;
        b=J1Ks+nmhLmK/yIjXRjKXrVSyZu+qt4jmmi/bLA1IYs3KR9uimZVAJ1HEuSo5W+Z7H/
         JWKyfCb9ctBjOMB7uqlKuOuSFpl77/Sj1jZTRxnB0Z7fKUvUd+UIgFfZYd3u5PjzcASw
         3lzTO9XjR3dnOSfpDYavATmJoFCSNDJ1aHk0V3O6xZNd99biNOtWn+KKUbIzVVMo77Do
         pK7e81U7FFfrCLzISieqln+zleDgQu3BfE4lVa4lvvxq3jPdBomQ/lr6N9gBwVz7rgYg
         WjnrgtZxK2xvjdgnmGVdJG3WEOMLzyqP/sp3R41U0gOKS3UFUM+9YRsjUQpUJpQXpeQV
         42WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142560; x=1690734560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+ge4K54TEOm7/rx5aIH7nXv5noKUxUQbqIp51XysbU=;
        b=HjiAmXiC/uaX2i0saH1b6Y0zyVnEdjR8otCrUx+riMBD1kfDjRzeco15o68cUna3hJ
         y7zRnUvQdBw9r2hOmgpt0n05BntVviZS1ITMXpWbj/kYlqmxbkVEzpCoisfcWBkp0WQ4
         ECMbT1y8dR56EnCiI3Courw3/fJ0j0WQceLthAyvZ933DjB2UVmfQt7jnA2OWUe6ZahU
         rjCPU82K22RHb7dIJGLa1JTSc2bNYPnoz2sDLH1rgzf7XjJu4538z8vFung8KsZeYcBH
         vndnN68h3AsE2mnjfncKEdq+e67lNAaZicCf5HsErw0QMj+iCpbO/ncwRjm5mNe8wskI
         3s+w==
X-Gm-Message-State: AC+VfDxgYxU5YtDND4+sa2GkPNcSHhHF/hCjdvkSMI1ty5v+pv0KedDs
        fNZBWKH/FdT2h+Al5fZUBqxfsg==
X-Google-Smtp-Source: ACHHUZ7+BKIoV4xg598c9FcGgrVTApX6k0SblZg1KAXK2Su2xV1DQfef4QNQLs2dAHCtVhgm3/ucSA==
X-Received: by 2002:a7b:ca48:0:b0:3f7:948f:5f17 with SMTP id m8-20020a7bca48000000b003f7948f5f17mr2495585wml.7.1688142560218;
        Fri, 30 Jun 2023 09:29:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm18835836wrb.84.2023.06.30.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:29:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:29:08 +0200
Subject: [PATCH v6 1/9] dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-1-fd2ac9845472@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=708;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2BBkVc8TRDNmHWa33LPRxnRmu9hb0Ks3oe1kaJIh+rY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwLau1zel3znaoFXRHvm8v9nGwRc+jS3jn2r5/YP
 4uXeT2yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8C2gAKCRB33NvayMhJ0T5bD/
 4imT9yiAOF5zIvuIj9aCuaNMuqR8MW8jMUm6XGMwTiP0uoljcoGWPDwMKyIG1/+/xY42La8gfRHk4/
 3ZtfR0P6o1PAT7b23wDPosJG5xJbLO+RPDSv/z6QLiA9S46BDbYCT4tEcc5OkmC2phi2XJTZN5VgJ/
 +YD6VFQwnwcXNvK5niHTfFY1sOSYJ2kTdVkk128ETB1ihBwTS5k2RpsdpuX08RNUysHizODZk3PeiJ
 GLnKpaVWCVbKJiHsj+09dRgZy5Jk5YzuCQYL5r1lZHpx8fZA7BiLo5UqePwpM1Jjp9B8Y8AhkAxBIO
 7d68VX7wNOJSt0AlbwrelecftuqGoTIUPafuMUAZs5of4hABKdkWm0A1vqx4MuUpR0Rung0dr+ITEb
 Bqbcb0MX6p4G0orZYph0YqliRgFacr9YRSSkmNqpcd2QUBD0dyI2RJAw333tFlcZ5iNDjzuzkyk98d
 cSjJM80zQz74HUL3XyPCuLyAx9SaEL/8G+FGoA9Dx50rPFTA5zcUnBDZQJ86PkfSFBi17y+Js8jUQo
 /qr4cfRdi6sLtneh1CVkNPv1K4fcWOOj+TcTsSNGYwm+PWmrB44ajPm4vuSrZl2Ci6uU5/8PRYjP/L
 hQZYKF+r3whHKpljUXJERnJm9oQTuD9JMJQ/lKKvBR9rJp7ez+rxiwS2om9Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new CLK ids for the CTS_ENCL and CTS_ENCL_SEL clocks
on G12A compatible SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/clock/g12a-clkc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 387767f4e298..636d713f95ff 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -279,5 +279,7 @@
 #define CLKID_MIPI_DSI_PXCLK_DIV		268
 #define CLKID_MIPI_DSI_PXCLK_SEL		269
 #define CLKID_MIPI_DSI_PXCLK			270
+#define CLKID_CTS_ENCL				271
+#define CLKID_CTS_ENCL_SEL			272
 
 #endif /* __G12A_CLKC_H */

-- 
2.34.1

