Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45667FF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjA2Opg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjA2Opc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:45:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099841BADF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:45:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so6544642wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYZkdrMXMeEPg3GRieLPg0wSSepZGYYAWur6SgaAHH0=;
        b=f/xa2DykNqZe9VBEt7kH6rje8ZlM1nq6aMa+BXbH1FRXonPH83eswZNQZiR0X9sI27
         oVVJpIfpxQrnIWl5qLewh2d2A4p6/HrqzziPJXn0EWtUitke8qm1Y24JpsTFTyWHPwKW
         R4v+uRMp/rZDSvQgw0mNm9frFii5skBtTyylrdSE3arfyZpOwynVqN2GmHow62e8GvNv
         OeoZUt6c+7RlJuroikcW1dO76u49I9lyYhHLgvaHQ1Fh5zEsVXNfMnCWHGtYjCCoEexL
         FVMsp9owevieL1ZNKr3Mmu1H06EonAaOw53+NWBELFf95J+JgvYNf5mhc91FHo+RO9KC
         ZtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYZkdrMXMeEPg3GRieLPg0wSSepZGYYAWur6SgaAHH0=;
        b=tC/SVxjIF1+2xa5Hib7DMGfvm7fAiiu/1Gtzy8ffny7gAVL1JYIKULBw2/qBItNpW0
         mVtCZwh4dhCdzRdUksBoXiLQpcn7ePKfSNdaG7Pdvs2bvzktxQNZcqhxYbdK5B2+sqpa
         bhChxLiIfm/MzJd2P8CwZptx34JkbSwrLnQcWaMobPLxW3JkKpCYdCoPdvYrVkiwCABl
         JH4DfmNByeK8KMXNB2jJQiNJuy3vZI5M3U/DGReGuIazSciIflv4sACWkxoaB8wnbEAW
         UhNLyFw+BOWV4/Q5lKcDJlHE+qHBS6HcSDUwSSNWCqA/sE51d7yjslBakax+UBCcFYU6
         QBDA==
X-Gm-Message-State: AFqh2kqjytwCuIUfYwVczwPMk//G+y+MaA5mITbnyvlm/oZsajMFYzB0
        AF4ZYPFsGgNIR9TP+FsJZnZJ4w==
X-Google-Smtp-Source: AMrXdXue3XS92JSUvV0ZZZSgiZgiNQr2+KdurebgIrezvPcNpy5XTgtz5zRTNAYrFb+/sLmbcnTswA==
X-Received: by 2002:a05:600c:348f:b0:3db:742:cfe9 with SMTP id a15-20020a05600c348f00b003db0742cfe9mr46866684wmq.34.1675003529545;
        Sun, 29 Jan 2023 06:45:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b003a3442f1229sm14950038wmq.29.2023.01.29.06.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:45:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: dts: cleanup for v6.3, part two
Date:   Sun, 29 Jan 2023 15:45:25 +0100
Message-Id: <20230129144525.5802-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230129144525.5802-1-krzysztof.kozlowski@linaro.org>
References: <20230129144525.5802-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cleanup of several platforms, not picked up by maintainers. On top of previous
pull request.

Best regards,
Krzysztof


The following changes since commit 3a48b303d44a19d335910f825f9a8473c5ff35e0:

  ARM: dts: at91: align LED node names with dtschema (2023-01-13 11:38:33 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.3-2

for you to fetch changes up to 2ba4ff82f9dd312fb9f77168f159698c93f4841b:

  ARM: dts: berlin: align UART node name with bindings (2023-01-27 10:44:58 +0100)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.3, part two

Align UART node names and OPP table names with bindings (alpine, arm
boards, axm55xx, berlin, cx92755, dm814x, moxart, mstar, stih418).

----------------------------------------------------------------
Krzysztof Kozlowski (9):
      ARM: dts: mstar: align UART node name with bindings
      ARM: dts: cx92755: align UART node name with bindings
      ARM: dts: arm: align UART node name with bindings
      ARM: dts: alpine: align UART node name with bindings
      ARM: dts: axm55xx: align UART node name with bindings
      ARM: dts: moxart: align UART node name with bindings
      ARM: dts: dm814x: align UART node name with bindings
      ARM: dts: stih418: align OPP table names with DT schema
      ARM: dts: berlin: align UART node name with bindings

 arch/arm/boot/dts/alpine.dtsi             | 4 ++--
 arch/arm/boot/dts/axm55xx.dtsi            | 8 ++++----
 arch/arm/boot/dts/berlin2q.dtsi           | 4 ++--
 arch/arm/boot/dts/cx92755.dtsi            | 6 +++---
 arch/arm/boot/dts/dm814x.dtsi             | 6 +++---
 arch/arm/boot/dts/dm816x.dtsi             | 6 +++---
 arch/arm/boot/dts/integrator.dtsi         | 4 ++--
 arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
 arch/arm/boot/dts/integratorap.dts        | 4 ++--
 arch/arm/boot/dts/integratorcp.dts        | 4 ++--
 arch/arm/boot/dts/moxart.dtsi             | 2 +-
 arch/arm/boot/dts/mstar-v7.dtsi           | 2 +-
 arch/arm/boot/dts/stih418-b2264.dts       | 2 +-
 arch/arm/boot/dts/versatile-ab.dts        | 6 +++---
 arch/arm/boot/dts/versatile-pb.dts        | 2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi       | 8 ++++----
 16 files changed, 36 insertions(+), 36 deletions(-)
