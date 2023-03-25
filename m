Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4AA6C8C40
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjCYHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjCYHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:40:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EAA5267;
        Sat, 25 Mar 2023 00:40:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r187so4844349ybr.6;
        Sat, 25 Mar 2023 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679730027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1IG/1kt/Y9xOco97EKexl0aCGg2ZwXOiS8z/jOTAxY=;
        b=Kz0NMsvL2drzYhlbOpIYQko84qzIPh50R3MnkyFwgpmKIZYC/qhaEfGlUvpvuo0QOa
         ioa9An4lUFoK/TKLMjdtTEUCbUSu1tSMAPZgdIkTGzl5HjT2kjsoq8jbBqgVOIuI+r7B
         BILKd0YJNGKZz1+Kgs8+XUg3jpdfvEHrz10nZ/5y9o5nYU1NGAN/ennW8iOxEUNEldnQ
         8A13u5NTVHfrmElL0XlIXVGt3sY1xGC0Ne3mJUWg0wpNCkOwMORFJslOxHSrTk5TvXoR
         rjF1W1/WCMELRu1aOglHKPLVvYawenn5psnyZcZM9mNNt0yfwofmejrpXyYxXzIOoWKX
         Ff9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679730027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1IG/1kt/Y9xOco97EKexl0aCGg2ZwXOiS8z/jOTAxY=;
        b=imkLANerMjSVgzHzhur9pYyjpbou41Mx1cjJZfEB6nY1dnd3uIY6BMnolvEMJixteD
         GBxjg3F0X2QSFXIz+xbN2TEkkXpIauWZ04k8MeMfB9g6LbiTP22h2yQlje9kg0w0OXKG
         vvO31FcHJbSrX3JMf0BewiygvH6IgV5hUUivqqItgebu+ONfjEfPBUSMBSTy7cWP8Bim
         djEfm1BpFVCm4lKWDHOTyubF5eOL8LpGlpNHO7DkCqEmW2g++OGJzjgP740YMZuCHscX
         J05YaP42k61M8zhY8bPn9lPvCSlwz3s8QrCsoHs8Q5cJTSvJJFrRT4vL5t34K99p1ldV
         ifQg==
X-Gm-Message-State: AAQBX9eBv5/k9kAKaI1rZIykgH4GdBAk7vsqGH9vWKN8t1yDFGwbjGib
        ZnIGcKjpQ0OYNulwejZ7+pM=
X-Google-Smtp-Source: AKy350YKtqc4xm5jVoKtAYVD+vHoIATs1mebKljtVf7DqcKBmtWTngWkLrUevKxUeU2bpI+I742aqQ==
X-Received: by 2002:a25:db4b:0:b0:b6a:51c9:d7ba with SMTP id g72-20020a25db4b000000b00b6a51c9d7bamr4845123ybf.20.1679730027579;
        Sat, 25 Mar 2023 00:40:27 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id w20-20020a25c714000000b00b7767ca7498sm969629ybe.53.2023.03.25.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:40:27 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
Date:   Sat, 25 Mar 2023 15:40:19 +0800
Message-Id: <20230325074022.9818-2-cnsztl@gmail.com>
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

Add devicetree binding documentation for the FriendlyARM NanoPi R2C.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6f4270f2bd9e..883c9d36e4e5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -185,9 +185,11 @@ properties:
           - const: firefly,rk3566-roc-pc
           - const: rockchip,rk3566
 
-      - description: FriendlyElec NanoPi R2S
+      - description: FriendlyElec NanoPi R2 series boards
         items:
-          - const: friendlyarm,nanopi-r2s
+          - enum:
+              - friendlyarm,nanopi-r2c
+              - friendlyarm,nanopi-r2s
           - const: rockchip,rk3328
 
       - description: FriendlyElec NanoPi4 series boards
-- 
2.40.0

