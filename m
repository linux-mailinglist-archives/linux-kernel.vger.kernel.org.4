Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93D5BE98D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiITPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:03:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929036DD5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b5so4774195wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=uqh2dUbJoe0czrli6Kd224HI22Ux46FPe3M+hCU7TSM=;
        b=DXJVo1kZdhTaLHixoiyKqUBvm4HdflY4OsRIzLyHV4lW717MrOMbIq4EGZ0xOzT389
         PCprPBKzPHmgAy781JFqC5+s1HsvkFwvP8AHPzHE8FrmFG+Ep3w6tK09z5oiUIo04u6s
         QpsCkrrwcdC4jTvmM+zUCcjyhnKqYhkN0jou9sXbP9wGbz2hnWqxmHIEo9YhMhAKz83c
         ZVsGAXRsZIe7mCbWVuBOwfmRlwq3AOTkVD5135EGU1qIHWivegHi/VH3PP0xY2dC9BVt
         aoIrdkEZ7hG/o7ldH00g/HjNnrcafYhO0HGI06DixwaDSizyZqZSsmvJzm4k3uuI47gp
         oftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=uqh2dUbJoe0czrli6Kd224HI22Ux46FPe3M+hCU7TSM=;
        b=eDQrqYzJ1bMFsPlxksxZcLlXkbVizVx3yumG1JVmZe/l3Ho2y0NpBKeSqukxz2Yr87
         MLytjY8AcyXITJLSrVdKz+4SDRStt3a2cFJr5fuBN6VyhwbambdMprmQA0HdS5zlmByI
         +b1WDue58oOJeOMItnJ+thigkzOatQ6wm4L0/93es0KGUlZz2s54E45ck+lTTRHa4B06
         MZMPCRcvL4M/hOC5J1bAPYLx4dmYNLxJr7B1G4czwPWF63p3+o/34SyuNLGIKCNhvGR+
         8Qtmsewec5zMA4XVavMnl62EgUkIfHZxeLpHNR6t3qOdzBMyCV6j64a8PKFvpL6r5orb
         /tLg==
X-Gm-Message-State: ACrzQf3tjy9LHI9XX2ldgXQmfln+EK3XPBPapiDLGY3l2Bpj6NUr7OcL
        pxtJNwjgTYOnYO3pj4E4PeFsqp2pZk+uq++j
X-Google-Smtp-Source: AMsMyM4N3YyCHurPDYZZtnr9E0TUg9Sv7/xmEAaHI2ynKZ4GFkBWucudF/uupLgrSQ0U9mOQa4DTtQ==
X-Received: by 2002:adf:d0d2:0:b0:22a:daf4:87e8 with SMTP id z18-20020adfd0d2000000b0022adaf487e8mr14283790wrh.167.1663686229972;
        Tue, 20 Sep 2022 08:03:49 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id u3-20020a5d4683000000b00225239d9265sm242056wrq.74.2022.09.20.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:03:49 -0700 (PDT)
Subject: [PATCH v5 0/4] thermal: mediatek: Add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFPWKWMC/w3LQQqAIBAAwK/EnluwlQL7jdqWC2ah2UX6ex7nMA0KZ+EC69Ag8ytFrtQxjwP4YN
 PBKFs3kCJShhSKnhU+gfNpI9YbSfPG+6SNWxz05WxhdNkmH/pLNcbv+wFekBRVZgAAAA==
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 20 Sep 2022 17:03:47 +0200
Message-Id: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
To:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663686228; l=928;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=ZDTa/tO2w1q5PgHHJH+pnlRiuHKoLh+P+DGPwBVzPgQ=;
 b=P9O/bhuGn1v+GUuvjvPBQVRiw0A/n7SOtf6jGT64bGiMkH7KDObNF9pLdTQ8KkFK77EYyL5gAOHA
 Au3g1oCCBWraOD/6z1bud2qipvaOG0SPzh5+3xrzGknI5+HRm6JI
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds thermal support for MT8365 SoC which contains three
thermal sensors.

Changes in V5:
- rebased on thermal/linux-next

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (1):
      thermal: mediatek: add another get_temp ops for thermal sensors

Fabien Parent (2):
      dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
      thermal: mediatek: add support for MT8365 SoC

Markus Schneider-Pargmann (1):
      thermal: mediatek: control buffer enablement tweaks

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 197 +++++++++++++++++----
 2 files changed, 166 insertions(+), 32 deletions(-)
---
base-commit: 64b269c002273cac4c41fb69572f3684dd1e3284
change-id: 20220920-i350-thermal-up-23edef139b6b

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
