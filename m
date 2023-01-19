Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3C6741E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjASTBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjASTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:01:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475595142;
        Thu, 19 Jan 2023 11:00:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d2so2782696wrp.8;
        Thu, 19 Jan 2023 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HO4UmNRP6zH/cRqMCCiTDrQIjarI4C2/3uiX8zDTE84=;
        b=Zplunbh0Fa3NcXho+kQlrASEZ8cTeTuuLh5d2lnw0X1g5k88mEoKB0b/5IFGjR4+fg
         bEzB/WoHndamIU7xBB7993TV2icO0CCezp9KeMewiaRwYm767sHSiU3pa4s+WeP5z92N
         h3Lc4PxWxi49zOd5k8r9JTajFQUIIJYkqM8y41DN/PCWIlV8CLLyBTVHi/u25NFWoHqO
         gkB3TPM7VR418fY5D09TAGadEL0w1L96N3SOnj0m3LH7oprnqm17j9WUT37V410OoOBo
         oPs69pbo3iVUUFnuhhRV/txSg+aKaMQIVMAJK6ZU2r7T1XO0KR58lBYfiobbWZKdlzzo
         EYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO4UmNRP6zH/cRqMCCiTDrQIjarI4C2/3uiX8zDTE84=;
        b=IBodJjzzPRZeANP7Xj/t36eLI1zQOQXzPy1vCB56QTfpnSMi/VH8HS65Xtfce2CPmi
         HWzwTnJIevcjssjMybh0CW+zdJ9LtHD5clodAIWWmNnm1Clr5bFCLaRer3x+pXgwXIN2
         bBGYob0n57uM1qxC8NRgzJgXIXgUjTISPoWirz7E/hloIpZX7+JFhJktQsSzHeV766A/
         jzN4fvmr63BVKBS3UZIAzDkomSfabJTbE4CVWOZaZHVslviap676YToY/DnotRIwFl7T
         Qqh/vYnLYQl002ra53rcskueyVvO0Jyw4eGF29/YHTXX9ilha2ytxGL4LVi1oVqKjnC0
         LSLQ==
X-Gm-Message-State: AFqh2ko83ET/2db3aTGq9FbKWvsUV6krcAJt9hgYNMEVESv074LSh6nd
        v5GLHyu+64udsYAE2JNdIcjnxQRvq4U=
X-Google-Smtp-Source: AMrXdXuv4vVVpNlxGmfYKz5rvjcPO6Z3nIrpRHuDDhHMndL8uSYIYAbSJAEO+D6ClVIEUh4N6X9Pxw==
X-Received: by 2002:a05:6000:22d:b0:2bb:f46f:c136 with SMTP id l13-20020a056000022d00b002bbf46fc136mr9185891wrz.23.1674154791219;
        Thu, 19 Jan 2023 10:59:51 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm34814488wrm.6.2023.01.19.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:59:50 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/3] Correct inaccuracies in Exynos5420 and Exynos5800 device trees
Date:   Thu, 19 Jan 2023 20:59:36 +0200
Message-Id: <20230119185940.156558-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Use the proper compatibles for the DSI host controller and MIPI
video phy, as the current ones are not compatible with the hardware.

While this fixes the kernel panic while trying to use DSI, I was still
unsuccessful to consistently produce image that isn't noise on S6E3FA2
panel of Samsung Galaxy S5. It seems to only work sometimes.

Markuss Broks (3):
  arm: dts: exynos5420: Add a label to the DSI controller node
  arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
  arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller

 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5800.dtsi | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.0

