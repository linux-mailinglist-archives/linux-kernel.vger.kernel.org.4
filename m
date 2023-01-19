Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21FB672FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjASDzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjASDmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:42:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB826CCF4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d8so1104522pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
        b=AYoOQ/8J91aj/79GYchUN5wJYIBudinYvCvZHpawYHMzb+k2DSRr1R1uVRBxEeofqo
         LzyW1cJAQjiKJMpSTrXcqWYdzoFP2mabaNPAfxBeciFXkh7cXm4eqy3GOwWMksVTTLUI
         WadLMrWa67XUAHDgEnXHXoGTfo1qLudHckfnDNMfrClKiZ/HJZev7fNG5VSng3BxkQtx
         QjurQkREyFtFMLXzrt7PVeLW6lcdSbUSsmLjdxns1fImjXPAhp/chEEz+ZpqISxfVuXy
         PQ7pj2gDNoLopkiz4HUs9lc9hjnZP8pdrQtpezvIr2b7qcNtYt90n33wvKAS0cXxDC2p
         A1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVkJKiJ32kgmrV9HwlRJqykEjqFOh7CBZW3HRZVDDmc=;
        b=BPtc/HbMxZquwhwKYOREvun1cEDaXcFShmYr9D0geuVv/ZUFM5cOiQ++AK2K+5aiMB
         WtYNT6mSYm6aFHfr09WHLy+tccHzBBh+0sUIHj61+7j2SFsKPYLvrnuZCzbuvY8kUDV8
         xljgC+O/0ElCnLJOq1HyHSqsva28HWZ4tqY140msSdr99m17uogbaCRxRgJ2iYdT10Lq
         4OX/QHSM1TSbIcKk8BMldJe8VWV8AMSAxKFAyWJDmcQAl03VN/aEoJgggnhoGXPf07xP
         eZMyKDZsH3mn+8LnPVHilKHXCweTr0Hnoh1yI617oWusnBGN0r7hm7uWfzecZttZdmEh
         7QoA==
X-Gm-Message-State: AFqh2ko+KGcPNngpOrUF8XrWMPGgdYG28FpPYvX2YP8N4c1gjepbe1Xp
        kHPl4Oo+es+o1mNuZesRxfzGmA==
X-Google-Smtp-Source: AMrXdXspfuChE5/UxncH6rROQNGpPzZT2cnNcxd08fIyPsy5yYzclyc4tmpYZH1QhU+EWILFVKcqtw==
X-Received: by 2002:a05:6a21:3990:b0:b6:157c:d72b with SMTP id ad16-20020a056a21399000b000b6157cd72bmr9990976pzc.33.1674099615188;
        Wed, 18 Jan 2023 19:40:15 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:14 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 05/15] dt-bindings: mfd: syscon: Add amd,pensando-elba-syscon compatible
Date:   Wed, 18 Jan 2023 19:39:08 -0800
Message-Id: <20230119033918.44117-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AMD Pensando Elba SoC system registers compatible

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd010431..f4b0ed4ff03c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - amd,pensando-elba-syscon
               - brcm,cru-clkset
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
-- 
2.17.1

