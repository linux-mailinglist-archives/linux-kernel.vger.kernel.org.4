Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BF6DEB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDLFip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDLFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:38:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EB5598;
        Tue, 11 Apr 2023 22:38:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q2so15134187pll.7;
        Tue, 11 Apr 2023 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277915; x=1683869915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=OVNTi5cifri7lZAj7pK0tDyID5Q5F+ZDAKDj/pob1NUvNYFvDOgRaPrVqxgtxGR8Xi
         qsuR/HNc6tFMi980bXCXAVh+4PBAAqejhke10NiMERqNHbsAPbpeXRcxeT1H/bgHEitQ
         pWZucLjqgjVMA3M0GRIyxkiaQyodHao+FL9HKysAQleIt39GurMf+9IpsuQ916clrQEO
         ZcSTTpi81ipnrf+wiQ/gdrCZzJTUBgnS71Q/eKPLnrjqqS+TZEwU/qM7CPwtVy+/X5e5
         MtHRmdV9kepdGXPD7RMqEgXz7cE7Ns1Hg2WmXAwngd4VGpso05yxPxxp76WyUEk7TQob
         WBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277915; x=1683869915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaSv0fqLKCElmpWFPdMbQfJoPfoV6HUW2XrOse+W9mw=;
        b=NK9NB9MEMKTXqmGzL86yDeksiNlGa2fjXUShzEUd9lshCJUVUIr+nWFmvr+i4ugaYO
         igY7owC9QchBhwcaOaIhMEn8wWbMdOpkBrtOurx9XCDtEVLTl6zWofnRYphXmYEtNokg
         JQAJn1/8hpmFnCcAfyYdi7dx3LMMIrm07uZR2lXD4xJhMc1Y15IhTfC+nIOy7P5/xLNE
         97jQtnAP3l6u6lPvMnt5g4pgvtBOxbakoENzXGbNbEXbTXPaeQVgqo4KltEBRudhfsaT
         koYOD4WAO+8gMN7B8bEp60mQZUu7KKpG3y/yxOr1a9Jl36ZKgyl+mtjQQhzjNtamoHBV
         WMfQ==
X-Gm-Message-State: AAQBX9daQ4dk6xrlYzD2lGNTdFDz09QdO7j9yV9ZWCtcqI0qSCI3yK06
        UL17h8Gx1k4E/DmP8h/JI5k=
X-Google-Smtp-Source: AKy350Z4E0EeLaPMBWThYPuaxOTIZL0hVFZyMRcFuHwkJPWKwf5D1/MgtgjZhOg2fQO2XEeNg7YhQw==
X-Received: by 2002:a17:902:d489:b0:1a1:bff4:49e9 with SMTP id c9-20020a170902d48900b001a1bff449e9mr18496279plg.23.1681277915519;
        Tue, 11 Apr 2023 22:38:35 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:35 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 02/12] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Wed, 12 Apr 2023 05:38:14 +0000
Message-Id: <20230412053824.106-3-ychuang570808@gmail.com>
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

