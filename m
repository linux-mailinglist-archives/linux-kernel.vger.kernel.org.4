Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E588676CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjAVMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjAVMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:15:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F01ABCF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:15:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so8764013wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYzBOFIiirkmqMZWjpo+uYx1+JPy1KYoRNQwi1+AmGY=;
        b=Uj/oOib5AsGrBWAYgFvNZIv9WdtsxocVc6DdiOF1wLCOXWYJlLB0T9w03A/a3nLWnF
         flwjaPuhcf62F6iKuU+vitZgZxqYXau/HeGwWoUmHkPb53pX0xEc/kEa3e5wWWFHA6Sb
         zeqFLjpeKh6HCXlhkhGm08VugSwhTfEs96DEvg6YfDAPJ2fWgG1KiGQbt7vc1fx1BmCs
         j5dBCsO/5N3HdNB97xFgYgAcdANtkAD9B/WgEfklkzxU05LUE6X/HxBSVvC1Tzk1v21U
         zKn1Y7qJuTPG8CzF74bcbbZixSU/8E1vL6M7QrwmlDz5+JmSzzfz1j+Vf9h8z2jnrqXD
         WKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYzBOFIiirkmqMZWjpo+uYx1+JPy1KYoRNQwi1+AmGY=;
        b=acCL04PflJ/GgQkE/2xOHc8917CPbzvRS6klex3U9cRxThHIyhcp1SzjtwOQVGkx1i
         5Y01as7m1QohgD5TboF3rAlR3/Z14VEt9nnNFlvyV2qqjecjIpiuTMNuna9c7DNjii16
         +j+tzwUmXaekHRiDpvSe9p5n+uAYFuINkQc3X7fjMTO0VHlN0b4wwW9yhXuuThkn/P4X
         qJgzGEjaHtVgQ9SE6Qm1muasrCQ3sW6ERrYcoBdU/fGGjUuilRAO0tkctn3vok+nhUtj
         ETX/iC5c9tMzOp8rTv7u/ZqU/XF/cVebSXk+BHJ5scxQR8YZENWmzSsk8BMGJtS+Re0L
         XjoA==
X-Gm-Message-State: AFqh2koCxt1LAVeYH8cAciloOhoVGMAJqXE8mXKZyFHz+dr1h43fHd5F
        mFEhCDB9d2QCvOl+WyEcjiTFag==
X-Google-Smtp-Source: AMrXdXvOtIoR3Sl2P5Nhj6vIVBah9gB0DFW+MWosXdF170n1/ZbFPnEZyspK38WX4XzAouVs5N0z7A==
X-Received: by 2002:a05:600c:2116:b0:3d6:10e:68a8 with SMTP id u22-20020a05600c211600b003d6010e68a8mr17054413wml.0.1674389747348;
        Sun, 22 Jan 2023 04:15:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm8543663wms.35.2023.01.22.04.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 04:15:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: dts: Cleanup for v6.3
Date:   Sun, 22 Jan 2023 13:15:41 +0100
Message-Id: <20230122121541.29312-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122121541.29312-1-krzysztof.kozlowski@linaro.org>
References: <20230122121541.29312-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.3

for you to fetch changes up to 3a48b303d44a19d335910f825f9a8473c5ff35e0:

  ARM: dts: at91: align LED node names with dtschema (2023-01-13 11:38:33 +0100)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.3

1. Drop 0x from unit address (socpfga).
2. Align HDMI CEC and LED nodes with bindings (stih410, keystone, dove,
   at91).

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      ARM: dts: socfpga: drop 0x from unit address
      ARM: dts: stih410: align HDMI CEC node names with dtschema
      ARM: dts: keystone: align LED node names with dtschema
      ARM: dts: dove: align LED node names with dtschema
      ARM: dts: at91: align LED node names with dtschema

 arch/arm/boot/dts/at91-gatwick.dts            | 12 ++++++------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_icp.dts        |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   |  4 ++--
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts   |  4 ++--
 arch/arm/boot/dts/at91-sama5d4ek.dts          |  6 +++---
 arch/arm/boot/dts/at91-tse850-3.dts           | 16 ++++++++--------
 arch/arm/boot/dts/dove-cm-a510.dtsi           |  2 +-
 arch/arm/boot/dts/dove-cubox.dts              |  2 +-
 arch/arm/boot/dts/dove-d2plug.dts             |  6 +++---
 arch/arm/boot/dts/dove-d3plug.dts             |  6 +++---
 arch/arm/boot/dts/keystone-k2hk-evm.dts       |  8 ++++----
 arch/arm/boot/dts/sama5d31ek.dts              |  2 +-
 arch/arm/boot/dts/sama5d34ek.dts              |  2 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi             |  2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga.dtsi                |  2 +-
 arch/arm/boot/dts/stih410.dtsi                |  2 +-
 22 files changed, 57 insertions(+), 57 deletions(-)
