Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE26C688F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjCWMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjCWMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:38:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836042726;
        Thu, 23 Mar 2023 05:38:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id bf15so9868765iob.7;
        Thu, 23 Mar 2023 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elyff+jc0Dmn8L8o0mKSvi+OnSPUaZQkUoy2yMJRlrY=;
        b=ROJW454d0ZORZyCxD8eYjE/BQ2imMWkRbHcixAhlMziFGE89Pp9xt3g3kEmOy4/Niz
         Bm7VKSUr98fclycy0fqcgfx856uIB9+qj9DQzJi5FTAapkFNo9+NQMHG/JSo+yUIAioJ
         MTPy4uOKwPRs6IUGwCiqVsELUiPNKT5pOftbCum0uQZy/TYduetqqtlv7LP7dNrHRrdR
         FtvWtGGmcL/wk3VnsHRwPR0X34qMFwQJ4Encw7+BTlJA1AvfErC3FWX8uVAiVkoJl/Yz
         QmPMYBoKnRDEhxx79ZfClwC7ViOrXej7OlDx7lDcmPHfR6P8sod2jaNQWKBByvlDaE7Y
         sr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elyff+jc0Dmn8L8o0mKSvi+OnSPUaZQkUoy2yMJRlrY=;
        b=hs9cr5RBhSk3LyV6zme0KgJ61GvdGH7ef8g43bBjuPuQKWf1VMOJxl3A3AEs0av6JA
         HwmaHfKxXoMe12r/nRwoZhjtt0Zho7pcvkRU1yfIs/ZxIKndbdgSyrwClEuIGsjVBsI+
         TlevPmnXV+2qH5cr/AAu/AY3KsQIQwzKGsoI5PU7SBYW5etJmQM12Rkz0yxynko/2jwC
         ZzUNBSkgKtKpH87nF3tC2FMhLi3F0kIg0ihabGigVqo698F9Ma/21O7UudRa15zPCFOg
         /2oRwwR7J4hHmdmUyX8L8sDvb9a5uSEVFnhVjwSoZalfyJ1ENXSo+GGBbvG5dRXndkP1
         3WLw==
X-Gm-Message-State: AO0yUKVoBkcwOrJ+D+5b7fz7Hlc+DT5c13hhJzdwFD40jEdNwtEEaZgh
        zDcMZum9eWbjI8LvKgYvjVE=
X-Google-Smtp-Source: AK7set/0iydoq+EtlUmADjV58UvVzo5A4y1nyq6acf+hjG5Ez293WSfJs6GXV46+QkptKUhZBNHCIw==
X-Received: by 2002:a5e:850c:0:b0:758:b06f:6ab2 with SMTP id i12-20020a5e850c000000b00758b06f6ab2mr3250924ioj.2.1679575093694;
        Thu, 23 Mar 2023 05:38:13 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id n11-20020a6bed0b000000b00758993500f3sm1307608iog.7.2023.03.23.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:38:13 -0700 (PDT)
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
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
Date:   Thu, 23 Mar 2023 20:38:04 +0800
Message-Id: <20230323123807.11882-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323123807.11882-1-cnsztl@gmail.com>
References: <20230323123807.11882-1-cnsztl@gmail.com>
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
index 6f4270f2bd9e..01df9a5a0cf5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -185,9 +185,11 @@ properties:
           - const: firefly,rk3566-roc-pc
           - const: rockchip,rk3566
 
-      - description: FriendlyElec NanoPi R2S
+      - description: FriendlyElec NanoPi R2C/S
         items:
-          - const: friendlyarm,nanopi-r2s
+          - enum:
+              - friendlyarm,nanopi-r2c
+              - friendlyarm,nanopi-r2s
           - const: rockchip,rk3328
 
       - description: FriendlyElec NanoPi4 series boards
-- 
2.40.0

