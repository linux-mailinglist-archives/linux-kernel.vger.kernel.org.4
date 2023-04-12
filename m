Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CCA6DEB48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLFjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDLFiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:38:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D0268A;
        Tue, 11 Apr 2023 22:38:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y6so9173127plp.2;
        Tue, 11 Apr 2023 22:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277926; x=1683869926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/9A2Wvuk2e7mWbwnwQigP3PrjzpmI/BM4Gbz8gqsvk=;
        b=JULLrIwH4P9YENfu3lPoLRvGi4qaEKeofwmL5KwbVTyefnjXEX82WvrG2e5gNOtnzg
         fV2XgVyztsNUcgbk9OhyEsiT+Z++8j9W4EEOMJC1dnRaElUfLPouv4F21XpMcrY8me/0
         Whuv6pXZn+5OgPSO6e75XqAD6KxGh7gP+HXnkpOiXDwWV0tIJiMQWPzNep/3M8uVGSAs
         v14HTayJbep3+I2JdLSGpPOz2RzaTeesqu+rAe2yOJ5dUor88P44+td/LqHE4a8jw0do
         tMUzUNERh4EBLZf2AaIuizYLm4LbmLmN2xcTwv1d4v4kJQPvpeMZNypZ+4a38/yEzrZ4
         dZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277926; x=1683869926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/9A2Wvuk2e7mWbwnwQigP3PrjzpmI/BM4Gbz8gqsvk=;
        b=h3FdUqYdGQPssT/zg7c7iHZQPZDidFXVjflE/vK7suqlNwukPKMxzltUQFSza/3Qrf
         S69kgdboxTa85R2MF+t09nQQneGkpGbhCgWZovdPX+u0zYe5IUXl+46VSM1kCsIgRRb2
         lyxWMpS9pZBo0LDHAhAzFnfNUWM5aT8OdP1eDkcBx1wwatyWfMS23qln5/HJRm7ao+lY
         NTs0nBSH1NvADnYKwFabXwl6Rl89Z0D8kU7P7+TJ9cKrIxmXP9m9CMBaz3E1o2XkvvzP
         GKezMI5x1n8eHJvn6dn2NPppISlTWz53O6rOfHZMWzy4RX2vl8oyeyInukZo/Qmx1zO3
         lX0A==
X-Gm-Message-State: AAQBX9dhDRUaGRBwjbpYxw7Zg2XxuJfhnqHm+6fG2S6LVQhHiAYc8B0D
        oRmKSm6bx11ZGZmjX7ATy0U=
X-Google-Smtp-Source: AKy350YFdaFAP4QOR78dTDDxuhBJfBVW0SQWMpVJSKcdmARxdkQibUM3b9GgmqJQlx1Vwq3U70815g==
X-Received: by 2002:a17:903:4054:b0:1a5:deb:a339 with SMTP id n20-20020a170903405400b001a50deba339mr12320876pla.6.1681277925950;
        Tue, 11 Apr 2023 22:38:45 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:45 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
Date:   Wed, 12 Apr 2023 05:38:17 +0000
Message-Id: <20230412053824.106-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412053824.106-1-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add Nuvoton ma35d1 system registers compatible.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c828c4f5e4a7..7ee1d27f59dd 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -56,6 +56,7 @@ properties:
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
+              - nuvoton,ma35d1-sys
               - nuvoton,wpcm450-shm
               - rockchip,px30-qos
               - rockchip,rk3036-qos
-- 
2.34.1

