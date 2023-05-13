Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4087014E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjEMGw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 02:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEMGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 02:52:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2424219AD;
        Fri, 12 May 2023 23:52:54 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c5db6a5cfso380030339f.2;
        Fri, 12 May 2023 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683960773; x=1686552773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZy59Sb4uWTS03Uzza8m8M1I8qxhAiWpLhVKo7Pl2pc=;
        b=Q7CavTa7jj86mcszJpgDaJKKf143s0m9p4m3X4FjqIRcVL3frnBcqqE9bOzrckKEtb
         W9+Jt+OnYE6gdt1Oi3YsSjnd+iGymukJQYkZfRLeq5mexg3LzJUBxvwDFyxTOdTFYRS6
         y0SNFCPPJW0CZncn6EdA89k0z6LUO1t3TvxwzMx3+lBtc49BZ4CIlfC/Au8KCNvUxlnb
         1qbYMplWm1B0CKRRQxqq0mgBHHF6KKiaEh8vKjXoh6rk1rCz5N0Q6DEJK367W5Nmxk6P
         KzJWE7RtI6vruuAOkL75SqMAE7sZ9yWX9Xe2eSvIaGHaeEH3KyFRZotx4a+iZYDXlBG1
         /zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683960773; x=1686552773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZy59Sb4uWTS03Uzza8m8M1I8qxhAiWpLhVKo7Pl2pc=;
        b=IUI/Bf81r4xZoAdmZbJMsAxNX8EPZvKgxzaOx+1+OTamYh3P/Yykj6FJSV8B5uLCfu
         EK0ZrAIq6cfZMbZn8TnGMX1O3YTItnUkvquxC9e3MjFBNxd8IVCU9CDNljl3EXjTh/76
         h8RVZYYG9ZOcswfcfYZbUS5fDrvOWeBGfw2OWxEXuTedBfL8wlwlwJrBoZ8L5i/M0FLA
         cB0dAGxYfFPL/H868i+tN19waVmLscO9guO3ZhRUBSoVvgmC8O9l9EwZ1KLjBa40ypdQ
         nyl97g1xyx/8SdDlGusH7cC+DBxtZiaIXUzTQV1J0Bi5WrJyU0D/zYm5xyUCEaFGhfFn
         T9ng==
X-Gm-Message-State: AC+VfDwTuF1VX/0KIYum4EzauV9VaQGZ0kBdD8ImselR7XGrfftIPwmy
        cqViWet0edcuQCqI4DGYC3s=
X-Google-Smtp-Source: ACHHUZ4ovM1vI09mzoHMP+4pWWbhBqn39wcj4WQY3BDIaxw6slO7z0UJx8mLLlmV+u4N0NOLels6Sw==
X-Received: by 2002:a6b:e606:0:b0:76c:8728:23be with SMTP id g6-20020a6be606000000b0076c872823bemr5455957ioh.4.1683960773380;
        Fri, 12 May 2023 23:52:53 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id a11-20020a5d980b000000b007697fe48ca8sm5371396iol.47.2023.05.12.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 23:52:52 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R2C Plus
Date:   Sat, 13 May 2023 14:52:27 +0800
Message-Id: <20230513065228.25971-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Add devicetree binding documentation for the NanoPi R2C Plus.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index b1d271778179..6f4d966744a5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -189,6 +189,7 @@ properties:
         items:
           - enum:
               - friendlyarm,nanopi-r2c
+              - friendlyarm,nanopi-r2c-plus
               - friendlyarm,nanopi-r2s
           - const: rockchip,rk3328
 
-- 
2.40.1

