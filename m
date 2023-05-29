Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44670714E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjE2QqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjE2QqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:46:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B2AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-973e7c35eddso297400066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685378770; x=1687970770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5W2InnJUP/UeKBwKYOBuhVJVSTGLUNK+LLVoQR0plI=;
        b=1h1XpexRNcq/GARqspAA3SgX1lx9vLDK6+EnwpwTtJFPeMV7/8eQfB5/0Duo1jdbM0
         zCmWVEoFh5y1cmnTFFbEb4XR5dTGF9oL8BTrYLjgNZEZ0zsbpFe5aC5sTu2n9ZSG0Cjz
         NbmrjT73sF7cjE7sPH0pjCZavpTaTgfx3faWFv17/JCyXnOthchgA39p1Lu8QDrxIPdm
         SzWueJlsMVOzzCnzQGNawipPcmqEU4jI6gt87OB5OFNlN9Etq4IJ/lBqNNnGrOrBAPzn
         1byM6y1ing7jmIqFnZJj7IdKvBwZwxuUOoX8+ABU4l9zz725vX5Zyb/A1A06ABO6CshY
         RYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378770; x=1687970770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5W2InnJUP/UeKBwKYOBuhVJVSTGLUNK+LLVoQR0plI=;
        b=KM0tO/e8ZxYv0uawkUM6+CngjKLlOzmM3RuFX1UzsrMO9leqAuMJUQLTQRy/+E1Aa6
         uc2vnsl5kHQC3IIi3rM4Uf5qrk6wxmrCFvf5QK0CwDgPjak+lRK3poUK2QlJLlFSgHkE
         dAsude+MloyPHYoZ4kMTa7uCZl60PNMrXr5Wucb8A/Kh3WqoRyAB+x/ik/7ET/la5oYo
         qV+QOCpAztUJXOmBiFfhnKE+vniM/S5VJhmdmohvwYOMHKw7BzVEIaN/CgP84IWHlXe2
         py2li2Kz7E6Rjzo0a7pSKxA86muHFNhMpIs9yGaxNmd+TqKRVxL4ZY7P9omC9Z4nF234
         bFvw==
X-Gm-Message-State: AC+VfDyrsl8VTifUwoWXaNzVPCFqpjfn0u0DBUlwopD1yclpkk4RNk9Q
        aGELfvRYouduRcYIJfKF37jmaQ==
X-Google-Smtp-Source: ACHHUZ5vN5ot2rMmDtaN9KdYMd2D30A8+m+MQ+eA0mtBsXo6xsAq+L7HqMIPyTkeUEcph2YC4AUhgg==
X-Received: by 2002:a17:907:846:b0:96a:4ea0:a1ea with SMTP id ww6-20020a170907084600b0096a4ea0a1eamr10330693ejb.44.1685378769781;
        Mon, 29 May 2023 09:46:09 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020aa7d844000000b0050d89daaa70sm3248578eds.2.2023.05.29.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:46:09 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Add LVTS support for mt8192
Date:   Mon, 29 May 2023 18:46:00 +0200
Message-ID: <20230529164605.3552619-1-bero@baylibre.com>
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

