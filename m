Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB067714D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjE2Pfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjE2Pfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:35:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD62CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078cc99232so3187446f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685374534; x=1687966534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5W2InnJUP/UeKBwKYOBuhVJVSTGLUNK+LLVoQR0plI=;
        b=2Efh/A+7Ot1ySLPh0HhuRd0fb/e85j22M6yPB6MrBkBETBIncWTMWHl7iQeWdhvm8z
         E/KCBLl0OHFf/DQRXmcRF7gLBTARTeAdGxsi9U68igMF/0KEQydwFh7+XWRe8V3j0cgo
         rFB47LLcAORkYZVzAT3kkKsUoolrCNpG7G0BHyBm3FbDo60e4eTekw44cLnZrxSYP+eg
         nqY5AHN7hnHmKBF4dXFbZ4heyzlAXdwew3P3y6ufXQmpML8OcCXLhjbhrmXC/qf+YUqe
         9b4fMiQ3AzICvSlmkVdJMDthPn9TNuDTZ6ygctqBTZV1PUj1WYhENlAiflEl2w7e6xrQ
         tmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374534; x=1687966534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5W2InnJUP/UeKBwKYOBuhVJVSTGLUNK+LLVoQR0plI=;
        b=locEG6aQEPUeCkKdGh1EQs6zlkyWGGhpeXM5jSmB0qKOBXijy0xUAQGHUN+Zbm5Pf5
         u1MEcLLu78ITJLGFBR5x4F9Sb/FmVxP4MLvlcRPKKNHkCienUy+HFUXiyJ5G362jO7az
         nLEzG17YuGps3OSnKbRYTCYV0EDx47nNXDAN8WPWaBKcJY5N/HTdJ63PJiC3u4wQEsgO
         1vrRjyEErlEkdUPZ4tb8xYx4wTCnk9RMFijQ+PGPLtmMwbz6/9G0FvcTF+6BwwjZdWeu
         QktfYcxFuk5bbyrS7YtnoqYJKx4YZYUhZjCLpWoAl+7DvkIhEWNhEInkRrEB2z9QhjNF
         SAXA==
X-Gm-Message-State: AC+VfDznsyCQORScEImRNe7fS5+uV1Okapf6BF6wcBrDrAcjqtqN5CEM
        EoRGN2x3ugyYfKEaHGIh7gVejA==
X-Google-Smtp-Source: ACHHUZ6Gh08w/RoJi45yAq2DuH7Uxj3S/ix6965ss0uiu0zUF7ysxLa6FUS6BJZzcfzOeCVWN9YUHg==
X-Received: by 2002:a05:6000:120f:b0:306:36b5:8ada with SMTP id e15-20020a056000120f00b0030636b58adamr9515336wrx.29.1685374534530;
        Mon, 29 May 2023 08:35:34 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm269781wra.97.2023.05.29.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:35:34 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzystof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 0/5] 
Date:   Mon, 29 May 2023 17:35:27 +0200
Message-ID: <20230529153532.3541327-1-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
-- 
2.41.0.rc2

