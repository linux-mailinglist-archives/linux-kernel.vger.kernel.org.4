Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4F6BA93D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjCOHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCOHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890486B300;
        Wed, 15 Mar 2023 00:29:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rj10so7295108pjb.4;
        Wed, 15 Mar 2023 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCnGvIs2Tq8LeZXK/BHdAYKObwoy4RHPHee0yLoq8bM=;
        b=bewoF86q8bBsFN0qhkp/a1PFzYVMCX2Y+hxzO+Yfe9EXWzRTv+a/GhvT+VTkX6EAM/
         U8itS/mWKbnjMh9VfurS2gWJTItsCoIQ6O3D7iQtOpwC9XwgcJ+I9U0ApyKYE68RGasW
         Xpt8MLEX4JPDDmRlVaD2s5EMyFJJk24TK2pCa+yqRg6sLMKy1s9PqZz42dOhytWHZ1ZS
         rXWgzrUFgQysGsgTKu4q0bDfmPaWIN1gJ1IfVo5DNBYjWxAktqCUf9oFidbTVYe5Auxf
         hV9nS+joqF1Y1CK9wo9aJKfQMdNUlRr4sMOqIoSsnQmYs0qTie+vBbkZdmZiKWRpw9SD
         zKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCnGvIs2Tq8LeZXK/BHdAYKObwoy4RHPHee0yLoq8bM=;
        b=YW8DrQ6LMuXvmRWybtsCNXs0VmLN8xaplrml9XkDei8dZDh8bvvDnli9JC2JWf6h6l
         QBo6vO0wUa1ulUFiJkr0r3qKsxKycMDl7Y8M0zDJthBjG+DKeUAccpD9RpyU23h58bXm
         Fr8GP8SPGK0BAAPqVRIvVyEUsrFll+miwuTvSSI1Dbw+HShPHfDHAgU08mkCiBlhZoTE
         AGXz4kBH2KImkegya3/M33S+rwXGrlserwv1mooYPIZk9n4+uzK6lozg95Tjb1fbzBkJ
         OcQhxLu+uhVkJY+w6R9lqYYgRKbu896fPjJOLy84IBeyPfliNPisL8DNBxfrdt9Fk+VC
         rMYA==
X-Gm-Message-State: AO0yUKW6lIBJIrBkjFYzzad/DOwt/LA5ICxQtDlPeUQIE7KR3Iht1mYG
        a8zt06Z/f2E397DB80sPMVY=
X-Google-Smtp-Source: AK7set+hG6Ka99Vt9tXoVmO88yvAPxytcP+1S9CzwSZMpWQQNepeq6XwQ5K6t1ATS0awuhn6rvOU5A==
X-Received: by 2002:a17:902:e484:b0:19f:2339:b2ec with SMTP id i4-20020a170902e48400b0019f2339b2ecmr1363973ple.33.1678865363787;
        Wed, 15 Mar 2023 00:29:23 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:23 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 06/15] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
Date:   Wed, 15 Mar 2023 07:28:53 +0000
Message-Id: <20230315072902.9298-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
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

Add Nuvoton ma35d1 system registers compatible

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c828c4f5e4a7..e7a3c6e1e77f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -57,6 +57,7 @@ properties:
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
               - nuvoton,wpcm450-shm
+              - nuvoton,ma35d1-sys
               - rockchip,px30-qos
               - rockchip,rk3036-qos
               - rockchip,rk3066-qos
-- 
2.34.1

