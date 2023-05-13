Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE15701788
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjEMNxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjEMNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:53:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52542716;
        Sat, 13 May 2023 06:53:11 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33179bbb900so25850535ab.3;
        Sat, 13 May 2023 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683985991; x=1686577991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TN0zJMvkxx65sSIuo+8IlKyGnKuvioQ0EbGfwquxBic=;
        b=SsjnEmWQqwS6Wk9ypv8YK+Mst01iRvVmSW5rwhB/PkiWCs+kYXnizKB0i/YcbBOqSf
         iY1MB8U0uBcrpgFGkzNwJZ/skqyyGm1MYjon9UZw1mn+DzPAyR2A5xftJfkHAiAN8SD4
         9kFmaDLAjIsNe/pGll6dbo7YN2lIoEeUdZ7ndBSLKjK2UU4FpRU/0ejQmj7Doz6UNI9W
         ZRV8EiXJcePg9qvTp2IL71pnMOfQ4EZYJHMby2jwl5DTIe9BMqSgnZ6zVQmGwNB3CjtC
         FPX6TMApt1TDGRM5tm7T46K+GW1nvHfdXV7uFwTC+SkncxjdylYf+Jrzol6T/QFPmx3G
         ja8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683985991; x=1686577991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN0zJMvkxx65sSIuo+8IlKyGnKuvioQ0EbGfwquxBic=;
        b=gZ9ZctnVNQFLhW64hEGkHCUWIEIVDyFyWCRRTeKMSvrspAp0Cd9Hnp65NyCR9/q4hi
         h1nMD/70hYG40gJkZOgk9cgIlnL9KX/Z+mHoDzoTiV3XmOM7Q0yz20LI0eEDw9jCvurU
         yqbb60zr+BPpsOuoh/DZB2cE2QGngrYEyF0539nKx2vL4CLsM93bnYIdhM0n33iRKWg6
         rOLToUkwTuiS+iUL49xGKIrkVbYKtYawoJthkMAoKQr9dDLrYQk5k+hGhi93MI8oag2q
         wbRVKeUvKBS8XA2Wi2I6pEMAEpdSIG92B8/ZbhvOGNPigQIN4DTuoXA60ZTEqsGQPp6s
         cQiQ==
X-Gm-Message-State: AC+VfDy6+70cJiCiI3w/bCCTSUM0vD60KgPCm8zwBbogmaIUqecVtzRT
        Kf8of5iCm33ZOXDPT4nWvEg=
X-Google-Smtp-Source: ACHHUZ4kpLTbd3Bxz5NK/wOd1+2Bs8dWmEog4eES9bsaCzU0oM6NBPu/QqYogEh90yP4JPbmfwKayQ==
X-Received: by 2002:a92:c9c4:0:b0:335:9220:2ec2 with SMTP id k4-20020a92c9c4000000b0033592202ec2mr10642522ilq.26.1683985990845;
        Sat, 13 May 2023 06:53:10 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id r15-20020a6bd90f000000b0076ca45ebfc4sm1104991ioc.14.2023.05.13.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:53:10 -0700 (PDT)
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
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: add FriendlyARM NanoPi R2C Plus
Date:   Sat, 13 May 2023 21:53:06 +0800
Message-Id: <20230513135307.26554-1-cnsztl@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

changes in v2:
* updated commit title
* collected acked-by tag

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

