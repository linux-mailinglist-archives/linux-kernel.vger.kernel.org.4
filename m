Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1229B6C8C43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCYHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjCYHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:40:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE93199E6;
        Sat, 25 Mar 2023 00:40:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p204so4811660ybc.12;
        Sat, 25 Mar 2023 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679730030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDcKlqWwiEbWvCmMV2E4cuAQ9yjvAR7tqhw3SRJQR8k=;
        b=crEbB+pY9dKKXfQv7fH96zxQmt61orUCbhj9tj/PwU8VAC0TPct9ZdHu6ln60ksrC/
         zAAw/C+DRnkA7+M+MRK0A5tb2G5h9WafLQN1pk+5camCgkgCBnTQ1evk4yJjA28+t0gz
         ylLcJI0kQwCU7FyK0RC5i69oH5MsY5x2+DE5gNWxTsSvoXwXOjtR7gLk1HhHyXfo3YHC
         DZu/lsItu36xKdGy6Sj4zDWrIjCeKsms97UcI5+G8wmrdCGRwxCFmXUkx5HqEedHMRKG
         3IwdPZJ0hs5IvhePR7ayDQ4AbLwgwzCqNBymjVmkGuCLyioEFvjyvYWvhOiFRJKCUtMb
         6ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679730030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDcKlqWwiEbWvCmMV2E4cuAQ9yjvAR7tqhw3SRJQR8k=;
        b=xegh0V4boLxDyJAAlzJDm7Kk+IRCgoV5xTVa0oOiABv0Hz2zi9+QGkVj+CEXbfV48Q
         cCCikWFUSQIRcf85pbQr583Ly99N8WXsdpolT7Zq8z1Bysu9Wd00uuwAakDD7lqlEQvp
         Lp4XawwRukwTBAms70bK3gUN8p1KiZO5yhxpp+QgSBq/hpvH18rQsbn2CLPVZSU9h0io
         Mr8FhxEi4FWiT1h7W5gkX5QvU8zFjb2pC7r2SaPG72mnitxOQo0Gpu0HIHfoRc8P103O
         sAWEt7yh6Ve+DkUqKxm6Myrtr7LXURav921lOxCiJrncRdlB5vPghxOJJLS68QgE2oVW
         sLNg==
X-Gm-Message-State: AAQBX9dyQSvcCwbpfcFwYCxYKgRzquhHlm6p9H9uKvPYZRYN9daSvrsQ
        i4Ka1dEskpoKuzICbQw1T1o=
X-Google-Smtp-Source: AKy350ZmNUnytb2HQL1zKl2feAM2o40Diq1Q6MnLckdbYwxnBFt8iAv59ZcXGif4KLF9G3juwoBVmg==
X-Received: by 2002:a25:54f:0:b0:b73:839:d8e8 with SMTP id 76-20020a25054f000000b00b730839d8e8mr4725883ybf.3.1679730030141;
        Sat, 25 Mar 2023 00:40:30 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id w20-20020a25c714000000b00b7767ca7498sm969629ybe.53.2023.03.25.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:40:29 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
Date:   Sat, 25 Mar 2023 15:40:21 +0800
Message-Id: <20230325074022.9818-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325074022.9818-1-cnsztl@gmail.com>
References: <20230325074022.9818-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the
Xunlong OrangePi R1 Plus LTS.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 883c9d36e4e5..ec141c937b8b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -831,9 +831,11 @@ properties:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
 
-      - description: Xunlong Orange Pi R1 Plus
+      - description: Xunlong Orange Pi R1 Plus / LTS
         items:
-          - const: xunlong,orangepi-r1-plus
+          - enum:
+              - xunlong,orangepi-r1-plus
+              - xunlong,orangepi-r1-plus-lts
           - const: rockchip,rk3328
 
       - description: Zkmagic A95X Z2
-- 
2.40.0

