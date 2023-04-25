Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA066EE02B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjDYKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjDYKYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBCCCC1D;
        Tue, 25 Apr 2023 03:24:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso4505520b3a.2;
        Tue, 25 Apr 2023 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682418271; x=1685010271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=OxV2vkMjNO942OeChDJEpY1i9fwDjFfBZQXeQyOpDgGaGU7QfI6f7xKL1Q9jZqQG6Z
         VB2IhE7ZU1bmFZyPhtTBfudTz2jdbDjIl0jNmmb5XVmt8wGYLGeOdfflHnMBIyys1qK8
         +b92vMJWO2f/D6P2HzezoQpgeeBWwqc4cB974MWO1jvz5mrkLZHRjIBIrYuNb6Qit84/
         mGsLJf53HlfcVEv92o7pz3Pb1/sIipUka7AlwslfLp/zrHnCRu4vvBEoxeY92qD3k7Zm
         McgzacIurHft1cOvGf+JKaW17DjLLXaCpP61w4bfU2Z99d/VrkpEHIBNPNbU7ActUYPm
         IjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418271; x=1685010271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=RyZPwsF2MdD7SYOMXFxrTe8c12SmN0IcqUVhJzTHGgGoCYzhMe7GufL6dGkFkVoYW2
         zvAql1yLvd1DlHfNvp1xdcy7JdOSJM+/lNeB0Od3bRwxNh0qF3g79iKqmNDoZRMivTMr
         RKJ5VFcKbsHJswY0MiWT/LOSL+q+/jdthvGiS1/LzdbpqIw1OtbRLj5R6LIS8fAfgf4/
         sLyaCgiZJDLLn7O9hJ2qiLiclWF4U9E1fZughiYniG+nm0fQrTzKCM8fifS/SmQy52TO
         cmf2O2e8M2+yC5OZfRY8XfQ/0gouTHcKYmRC7nQPxCif0k6TzXjcEEvfIptZxGpF2d/O
         mkPg==
X-Gm-Message-State: AAQBX9eOeKeLGoG7Q41ez8smvWqwtXuU8ydpXmhBBZAcU5NehbPj3IQ2
        g4/VzuAH2OHVZIeSMnmmt0o=
X-Google-Smtp-Source: AKy350YSUqeNMt/R0+podNPW7RVEql9WZhuY4WRbBlG65tVl7WlBHWqXG22Wawc05RVb8V7fsO0eIQ==
X-Received: by 2002:a05:6a00:114f:b0:63d:2343:f9b with SMTP id b15-20020a056a00114f00b0063d23430f9bmr19434171pfm.19.1682418271270;
        Tue, 25 Apr 2023 03:24:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a63125e000000b0051b70c8d446sm7644715pgs.73.2023.04.25.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 03:24:31 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v8 02/11] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Tue, 25 Apr 2023 10:24:09 +0000
Message-Id: <20230425102418.185783-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425102418.185783-1-ychuang570808@gmail.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This adds support for the Nuvoton MA35 family SoCs which
are based on the Cortex-A35 Armv8-A 64-bit architecture.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..c96189acb02c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
 CONFIG_ARCH_NPCM=y
+CONFIG_ARCH_NUVOTON=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
2.34.1

