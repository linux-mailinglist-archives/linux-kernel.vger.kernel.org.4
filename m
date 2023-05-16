Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163237046F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjEPHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjEPHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:52:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E71FD8;
        Tue, 16 May 2023 00:52:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso1928285ad.0;
        Tue, 16 May 2023 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684223551; x=1686815551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=oVtgasVRbUJeGz+K1WDy2wHuDROJfpBH+qhdm6EEOegU3yWrtCzxHgRqZremSH1KZY
         QiKhgZpibIbi2TleyqkCuki5n45vnuWgIwnmMCv9ocCNSf5GTOoX4s4YVRq9DhIQVf9u
         fpxFpVjblCvpzcbaJOMjFrjjbnYZe20EGHP17C/L2nOx/3DnYo2IOiAzLrN1y8q0rCWJ
         osNd9GUWtNHrdrJGQByAz2s+MBro7kx/knQeVUkBAXT0sxqZcM5fR1pPTasAjxJgUM99
         VoMbaijEA1IOaDQimunxFJnuC7jQouvTT6tvvTBO8U0SLmAk46HLfAQbwI0/7S7W6vAi
         rvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223551; x=1686815551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=F3SbpIzjaQIez/IpHjQGBrXIWCBweIc5ei5I8NNCT8v1Paqug6fATphWn1iXbO6kOO
         +ax4xXOjG6SmQlVRXToX/Bk6c1/ebA7nHQfTSWMUqnaQApONLZ/knVkqeEuaR4mpxQZx
         XfuDY3XCw35gvFsBzIElr73PioJriMQSjnssViBOSpSZw6nCk5LLgaw5yT911/FiM0Zn
         qNPYTw+Gh9OQcnTH8uRBHsBkK0icIBvvuCtdQKRcReTkcImUcV3zyWjh/VL4MiUvSHcf
         4AsvjoIqouKBtJD93qBgnuJdtAKfGPkZFeuRBp5VsjzwWAQ1DjKyGix6lbPmpNVIuE9Y
         aLbg==
X-Gm-Message-State: AC+VfDwe3q3BaStxJhRukheknhZ06kJfSPPVKx50DhNkaExe7B9PFSnP
        Uq3npwczH4g24mPvUSIcMIk=
X-Google-Smtp-Source: ACHHUZ7Lv0UpK6d/VE+isEPetzkBwIS6Nqh4y64bdHDkuMglGO7vO6iMw9OulfLstIPE3VliSGF/hg==
X-Received: by 2002:a17:902:f682:b0:1a6:db0a:8005 with SMTP id l2-20020a170902f68200b001a6db0a8005mr45001096plg.68.1684223551293;
        Tue, 16 May 2023 00:52:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001ab061e352bsm4793043plh.195.2023.05.16.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:52:30 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 02/10] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Tue, 16 May 2023 07:52:09 +0000
Message-Id: <20230516075217.205401-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075217.205401-1-ychuang570808@gmail.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
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

