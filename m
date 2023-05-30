Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE9716E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjE3Tvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE3Tvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:51:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329AB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so50918355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685476295; x=1688068295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4IP0REEtyhlwPhv3kFKNTWdtdlRtMxYQpQGr2LUnNY=;
        b=X+L30U6OtZYV6NJxpUsIT3EUrhXpO+Rbpc/CUuKMe+iH/8ojw0i3ru8JocPgpng/38
         a0kNWl5KuV4GRpMvk8GHofXjHk0lchRyG151rQ4piGvg5J+CExg9lPoaFDn7XvN8zjdJ
         P1mffWsVX505trVtESlZ7SF4MX+EIbn2yJoHjdzrRrdZZ+GUs6vsQCG6Jy6PLg1gdaZc
         DJ+qDA4ho3j0wzeEm9hw+0UJCILUGym0zbYTDYG+01BgHE02wLB1TRCr8MDvULDHLeta
         gp1+XIZJBDHf0V8Niy9lqAI9jTU7c+twzzZouPJcu8B8rh2HJVZtcnD08j6yAGVTYBz2
         EEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476295; x=1688068295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4IP0REEtyhlwPhv3kFKNTWdtdlRtMxYQpQGr2LUnNY=;
        b=feZELoWMU74S+6DAleByZVbWtWSifl4no4I/YFLZyioin1+WjgHfgXIqYGXT1vtTJo
         QKLdKwqHeIIoo40BBtN5elrFut0c8S4tD9TjrELU2nLHqlXc+mNnapult2vvh+eBljmZ
         ZHBpvsHNJ/b+KQkltbXPGLJcVbPl9DAiqG/Wtf2Ow7eiEB9oeZHkbFRAH2xGQfphedI6
         VmKsikQdnOxBl+MmfMgmauNMbIbPUZtv66UJUJsy9bf9YFo/A3Y/P/RqsWRX9YkSrmbl
         9Xoi1fAMCD2fZ+dKrD99X+LCwk3Rh1c+0cHdS2H2CQ4ikFbTxxO4ABGt9yxZtJw1JZUI
         Gn8w==
X-Gm-Message-State: AC+VfDzIlPyz1ja3dXer0PeRt2hT0ipINEWHgaC68T7TaTy2Nol5IOTx
        cIiAg0fHhVKzjpvjvepisvS2rw==
X-Google-Smtp-Source: ACHHUZ7hkrQC/2/AK9nHX2Acv4D68laPB0ntxwZ4+W0bje9e7rPwXVFYOYCY9WVFwqS2LOYZBc376w==
X-Received: by 2002:a05:600c:2204:b0:3f6:c7b:d3c8 with SMTP id z4-20020a05600c220400b003f60c7bd3c8mr3423689wml.16.1685476295166;
        Tue, 30 May 2023 12:51:35 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b003078cd719ffsm4271545wrj.95.2023.05.30.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:51:34 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v4 0/5] Add LVTS support for mt8192
Date:   Tue, 30 May 2023 21:51:27 +0200
Message-ID: <20230530195132.2286163-1-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
Also, add Suspend and Resume support to LVTS Driver (all SoCs),
and update the documentation that describes the Calibration Data Offsets.

Changelog:
    v4 :
        - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
          room for SVS support, pointed out by
          AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

    v3 : 
        - Rebased :
            base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
        - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
          Use filtered mode to make sure threshold interrupts are triggered,
          protocol documentation, cosmetics
        - I (bero@baylibre.com) will be taking care of this patchset
          from now on, since Balsam has left BayLibre. Thanks for
          getting it almost ready, Balsam!

    v2 :
        - Based on top of thermal/linux-next :
            base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
        - Squash "add thermal zones and thermal nodes" and
            "add temperature mitigation threshold" commits together to form
            "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones" commit.
        - Add Suspend and Resume support to LVTS Driver.
        - Update Calibration Data documentation.
        - Fix calibration data offsets for mt8192
            (Thanks to "Chen-Yu Tsai" and "Nícolas F. R. A. Prado").
        https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylibre.com/
        Tested-by: Chen-Yu Tsai <wenst@chromium.org>

    v1 :
        - The initial series "Add LVTS support for mt8192" :
            "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/".

Balsam CHIHI (5):
  dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
    for mt8192
  thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
  thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
  arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
  thermal/drivers/mediatek/lvts_thermal: Update calibration data
    documentation

 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 160 +++++-
 .../thermal/mediatek,lvts-thermal.h           |  19 +
 3 files changed, 631 insertions(+), 2 deletions(-)

base-commit: 8c33787278ca8db73ad7d23f932c8c39b9f6e543
-- 
2.41.0.rc2

