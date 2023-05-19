Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B290709FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjESTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjESTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:06:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A9EE5C;
        Fri, 19 May 2023 12:06:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so1338119a12.1;
        Fri, 19 May 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684523192; x=1687115192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIVD26O0XaIuTEjpysSAOudJibPoc4VOZbd4aMrlF9w=;
        b=sDbR6BDkjWavH6129ai7vd/lD3LYmnz4KJaFT+gW1Ybic0sB8iPLtr6h5sbAnxDGkH
         9k57dw8/oKGTFDtO/yucVJ1abbGpqV5rIwKPqbTpOcg98ofITN6fjTieXiQ8fcLo0hp4
         kZmk/yfgq6q6VTPNMftz034qjjI9zPZK102TNfOW53We7J8TpeM+51PIFHhgzGDXPIiO
         /d1uWodpKWLVOJuoGRXJ8/H1F48ksR0YAfHpSHb2LksravmGScX7nj7egUmV4utL5ciS
         EDmye0bNg3lu6GnlGXTI8g7cbzob+qCbRT8gBoqYeOX+8FEU4PZYzqtqRP8/mDmY+i7t
         SiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523192; x=1687115192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIVD26O0XaIuTEjpysSAOudJibPoc4VOZbd4aMrlF9w=;
        b=e3xaW8Sq+5NsS+XcMhifxo/l4HfDUVZ0xcFzBwdbvFtRKygwLKKvBg5IGj9Otw8LMl
         WBZZyCwbbmS7qXeqJsDkUzgN1v6oHIzNuW/CAnta4/4W0AuXtKzZXn+FdicomhgKhVKk
         DeuYKAmtBm8iTDlrFMsggie80cmCarnjUmVW4mJqVs83/DhbvtT0m58HdHU5K1pli2sY
         /JqNxNQtXSU5155VFnZGBt/Er+afl5qcz8Je82vHpZ4xCdXYzIzHkaoRea3b2Yl+NDk3
         O6grQKtx9Te+bIHgCv9aKOY+3lAYCHHNvrEWh8uM1VjtCICM3HZrW5y07ELe6QIbv+dx
         9TQw==
X-Gm-Message-State: AC+VfDyA5byqbgx3GiBPVofTJZTdNKCRms+q44Wi3NPe823VRpR70MKt
        fDrXxfhyLu6pT75Eh6mJ5XQ0g3aQ+TE=
X-Google-Smtp-Source: ACHHUZ4pZEx+JoDG795WwGZFFMH4+7+t90PIXJtaDtTh2nVqemSJoCGq/LuO4Xm+ysKz5iqlolFatQ==
X-Received: by 2002:a17:907:1620:b0:94f:2b80:f3b4 with SMTP id hb32-20020a170907162000b0094f2b80f3b4mr2787388ejc.69.1684523191681;
        Fri, 19 May 2023 12:06:31 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090609a100b0094f1b8901e1sm2624244eje.68.2023.05.19.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:06:31 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/3] ARM: dts: samsung: Fix some typos in comments
Date:   Fri, 19 May 2023 21:06:22 +0200
Message-Id: <20230519190625.7844-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'specfic' to 'specific', 'optiosn' to 'options' and remove
duplicated 'are listed' in DTSI heading comments. While we're at it,
fix the s5pv210-pinctrl.dtsi header (seems like it was copied out of
the main DTSI file and never changed to match the new contents).

This patch has been split off from a patch in a separate series:
"[PATCH v3 11/13] ARM: dts: exynos: Fix some typos in comments"
https://lore.kernel.org/all/20230501195525.6268-12-aweber.kernel@gmail.com/
It has been split into 3 separate commits: one for Exynos chips,
one for s3c64xx and one for s5pv210.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (3):
  ARM: dts: exynos: Fix some typos in comments
  ARM: dts: s3c64xx: Fix some typos in comments
  ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  4 ++--
 arch/arm/boot/dts/exynos3250.dtsi         |  2 +-
 arch/arm/boot/dts/exynos4.dtsi            |  2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  4 ++--
 arch/arm/boot/dts/exynos4412.dtsi         |  2 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |  4 ++--
 arch/arm/boot/dts/exynos5.dtsi            |  2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  4 ++--
 arch/arm/boot/dts/exynos5250.dtsi         |  2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5410.dtsi         |  2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi         |  2 +-
 arch/arm/boot/dts/exynos5800.dtsi         |  2 +-
 arch/arm/boot/dts/s3c6400.dtsi            |  2 +-
 arch/arm/boot/dts/s3c6410.dtsi            |  2 +-
 arch/arm/boot/dts/s3c64xx.dtsi            |  2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    | 12 ++++--------
 arch/arm/boot/dts/s5pv210.dtsi            |  2 +-
 19 files changed, 26 insertions(+), 30 deletions(-)


base-commit: fd811cce9b92635799ba5c6de657e4a53c68adf6
-- 
2.40.1

