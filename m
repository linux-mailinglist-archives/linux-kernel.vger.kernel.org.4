Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43A6F9DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjEHC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjEHC7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:59:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F683EE;
        Sun,  7 May 2023 19:59:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643aad3bc41so2768216b3a.0;
        Sun, 07 May 2023 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683514790; x=1686106790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=a/kX70au42SV6lB2oMFLu98VXARL4IFa0rS85RlqcHD3RcMAIEBXoOlUNprPbCzmov
         JmabP13LPMmfL3fk+OSlAT8GWiuWSu2v2yLhTxJG3CSMFBfU9aJG0Y5rYFOs2x85USiw
         BmhABcSsxqTF4Q6ZH8EYkWpPg6Dc0j2/AmiGLeu7ZwhrodFw9DxAJGafvQd+ZvqCqGAp
         6kK01ZCJBEEOjVU40YXgGYe9PMG0n3iIfMukaT7stzlC6NKRjiHzOmr0KhqfOAVC3dS0
         Y0DyMuHBtD9bvf1iVjQYPlGBti0Vl3U61pysjqFPlWU0Y7FAgEhvjS6AMIm6F2xLEN+q
         gPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514790; x=1686106790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=cOhxifjwzIFWzLCVu6Hrdszcy0e4luj7rhYrlFmJ7zWXP8Afujl5R8jtwsrMm63oNT
         d43W0NL2hxEnQN88phhylJXztSJzyuh15cTEklkWHCdFKzHpm3ndWUAg2Xsh7otshp9N
         15tKdtBlArRTe7l3BbtfkwwU50Yaa5o+gTLCGKYTFKpqQR5BAUMb8X8j766yclqjx+PZ
         3IpZ6CWSTnBZdsI7KZ39tJaz3LJuucl0ZnJXdE7YuxoSWrQZIIkFibucLllaiM0gR2BX
         B11UTb7L5dr5OCd55BW05ZLyY5qFnbRkTti8XPetfBlLSKnIJjB8UqSl5MTjbHwiZDKJ
         pNBQ==
X-Gm-Message-State: AC+VfDxgAg2mbeX0nsmYSd4XA2zrA1h//cfItK3/+j/sWyFHb3rbAk4w
        xY3ejBLuTeX0+9piq/3qKBg=
X-Google-Smtp-Source: ACHHUZ740VCAdhDUAnAdxRPFatSt0kgM1Bdt1ehA5Jgl94ywZFxXsfzUj93RwJ7kMfd9rwhnm680lg==
X-Received: by 2002:a05:6a00:2e05:b0:63e:6b8a:7975 with SMTP id fc5-20020a056a002e0500b0063e6b8a7975mr10530434pfb.9.1683514790495;
        Sun, 07 May 2023 19:59:50 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b0064559b58eb8sm1525422pfn.154.2023.05.07.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:59:50 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 02/10] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Mon,  8 May 2023 02:59:28 +0000
Message-Id: <20230508025936.36776-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508025936.36776-1-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..0ee572753f1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -52,6 +52,7 @@ CONFIG_ARCH_NXP=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
+CONFIG_ARCH_MA35=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
-- 
2.34.1

