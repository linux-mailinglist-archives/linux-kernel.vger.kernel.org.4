Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1375E6E30E1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDOKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDOKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:48:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4407FAF32;
        Sat, 15 Apr 2023 03:47:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rp27so14846921ejb.12;
        Sat, 15 Apr 2023 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555627; x=1684147627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dISlVJnWoSaQPOrIVy9KR50yRndMlP9B9wtDi4lm21g=;
        b=SCjs3vMvK2vVbIo4PEH9d6VWabMBvQohKJbY+fgeqC2sQFvisjZ0GgspZWffRy8dZk
         y6KeaK7MPnpTR4p3cA/zb5IZvkRki0fwPrItKuI39DExUfQP+Eo6qx7mgNs/2FEkigiQ
         j565yQ+cmOkG8X7Zts82eUD6V5SoTeVooL9sBYn1KlKioXjtggB3zFRdkewj9WJlvryy
         0GUlkG4BcmAyatKWEVvcsIcLHMIomzkba4xtVOiqTgWqI4AzbA9mWG1hk0mSGJrbvd1B
         ghkuN13whkF8Wf6Z0FDvWBOofX5TIOv6hWP2k1UpuJbPYjl5OsdvaoMlFNnxs+Vhc7eL
         70qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555627; x=1684147627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dISlVJnWoSaQPOrIVy9KR50yRndMlP9B9wtDi4lm21g=;
        b=M7XVEhkvAMBo8EHep/agsCmtJrUGTKQ9+IatqIcjmhdNH7pOMVdXBo6H+WVU0ngHGM
         lYKrOsb8tCgWAajvnJvI2tllVnTYCZgvFbaAXXKEw03HN3tUG5HPfP8AgjBL8SP1UX2q
         cCtj/futR51Bv/I0Mf6GOftqlcCf9ZfGnx87u6bKZdwNlXW1tNsUL23zmMHxv7gaqnrn
         TwNwnUvH0AY3gM5iAFc2xv2tdu6dmNwCvPSFsybXaDm8ghzmxfV2HNWEadxyyzmagv9s
         pGguY9Irc+n0xwinwX2sLXsNBz6kn+TywQrXvsgZ6aLsX2yE3cDMvRjWBp/+KqdBbM44
         bZJA==
X-Gm-Message-State: AAQBX9cRrHJ66+a7UHpfXmybIFXE9SSGzS9Mt5kGBU34pZUwiz/vfvG6
        d0HkUIK7iZJNTU7EWkdnvh8=
X-Google-Smtp-Source: AKy350Y5afmiBhKRprtC5SNEdZYPWt8T99YvHJGrJGHbqb6r+TSAdL+giiW/xUXtzn4KHSMx6NBvAg==
X-Received: by 2002:a17:907:2149:b0:94a:4d06:3de3 with SMTP id rk9-20020a170907214900b0094a4d063de3mr1493742ejb.72.1681555627031;
        Sat, 15 Apr 2023 03:47:07 -0700 (PDT)
Received: from localhost.localdomain (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id m15-20020a170906720f00b00947ab65d932sm3607034ejk.83.2023.04.15.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:47:06 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/3] ARM: dts: sun8i: h3: beelink-x2: Disable DW-HDMI CEC
Date:   Sat, 15 Apr 2023 12:46:13 +0200
Message-Id: <20230415104613.61224-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415104613.61224-1-jernej.skrabec@gmail.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
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

Beelink X2 uses software implementation of CEC even though DW-HDMI has
working hardware implementation.

Disable unused DW-HDMI CEC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index a6d38ecee141..38f40d69e5c5 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -150,6 +150,7 @@ &emac {
 };
 
 &hdmi {
+	snps,disable-cec;
 	status = "okay";
 };
 
-- 
2.40.0

