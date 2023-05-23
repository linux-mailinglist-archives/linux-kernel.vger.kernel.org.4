Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7970E576
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbjEWTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEWTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:31:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC33E46
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae4c5e12edso243125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684870268; x=1687462268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=da7xHElmRhs7yLWfdeHx4hSBX9WK1oPzedpFeX43g5E=;
        b=LzUeez59b5Pg0Ump+sB4OM8jCT2gUu+L3cHDGuYq6KxKNdbWzzUcYfIjiAl9CHb7/y
         Zd/xCwCoNFjhdzyDFQL7kt91TMpOZffzujd6HC05iDlXlLzNfOfWBkCHqD6ablJniuG1
         PQBLx18VMf6dlXe/RbYmWDRnV0qm5puEiOYyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870268; x=1687462268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da7xHElmRhs7yLWfdeHx4hSBX9WK1oPzedpFeX43g5E=;
        b=V9XpEbC0iPF9orJiRva2Yl+x9Ctao6vQgqN4DbqEPsraeQ+7cRrcJOBzHQa5Sgi3I+
         3dgjcpFr/Slo55PU7ObPog5HZ6/aHfuF3nFj+vzhmn+51WQhtKO7TCjnZrUgeTBahdHq
         Eflz0NeFq45+Z4cduYpsfuW4poloc80vL5+qX4fi4eKk2GyHZF17ty+mNkcqh/J76TTf
         3K6cc30kmIKLAR/EmrHnrRwp+YkUeYxmXUA6uY0vrRZA8BhvXXqyQKNhG89g0eKaNME9
         mcMIwYIoR1Uzd1nx0rKS6m7sKxq3KWDlWT1OM5hm7RShDYR1UKvMcKeqb4FT5CVqYU9H
         pOUw==
X-Gm-Message-State: AC+VfDzntIEDeaYUurkCLy8XKAOJgu0QOyNDvIutkJm9AZCwjXjfIL53
        N62x26TWW3cnyJrNOCLXScSLpA==
X-Google-Smtp-Source: ACHHUZ4/GhcYkmDFF4G/tiyzD+WQyx75cWfu4Fa2ANvrz/NLC/goHxpAkTJKe2ReitBreL7vc+KZpA==
X-Received: by 2002:a17:902:c151:b0:1aa:cf25:41d0 with SMTP id 17-20020a170902c15100b001aacf2541d0mr14164593plj.33.1684870268211;
        Tue, 23 May 2023 12:31:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:af98:af9d:ed15:f8b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm7109947plr.197.2023.05.23.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:31:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/9] drm/panel and i2c-hid: Allow panels and touchscreens to power sequence together
Date:   Tue, 23 May 2023 12:27:54 -0700
Message-ID: <20230523193017.4109557-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The big motivation for this patch series is mostly described in the patch
("drm/panel: Add a way for other devices to follow panel state"), but to
quickly summarize here: for touchscreens that are connected to a panel we
need the ability to power sequence the two device together. This is not a
new need, but so far we've managed to get by through a combination of
inefficiency, added costs, or perhaps just a little bit of brokenness.
It's time to do better. This patch series allows us to do better.

Assuming that people think this patch series looks OK, we'll have to
figure out the right way to land it. The panel patches and i2c-hid
patches will go through very different trees and so either we'll need
an Ack from one side or the other or someone to create a tag for the
other tree to pull in. This will _probably_ require the true drm-misc
maintainers to get involved, not a lowly committer. ;-)


Douglas Anderson (9):
  dt-bindings: HID: i2c-hid: Add "panel" property to i2c-hid backed
    panels
  drm/panel: Check for already prepared/enabled in drm_panel
  drm/panel: Add a way for other devices to follow panel state
  HID: i2c-hid: Switch to SYSTEM_SLEEP_PM_OPS()
  HID: i2c-hid: Rearrange probe() to power things up later
  HID: i2c-hid: Make suspend and resume into helper functions
  HID: i2c-hid: Support being a panel follower
  HID: i2c-hid: Do panel follower work on the system_wq
  arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels

 .../bindings/input/elan,ekth6915.yaml         |   6 +
 .../bindings/input/goodix,gt7375p.yaml        |   6 +
 .../bindings/input/hid-over-i2c.yaml          |   6 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |   1 +
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |   1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |   1 +
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |   1 +
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |   1 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   1 +
 drivers/gpu/drm/drm_panel.c                   | 194 +++++++++-
 drivers/hid/i2c-hid/i2c-hid-core.c            | 330 +++++++++++++-----
 include/drm/drm_panel.h                       |  89 +++++
 12 files changed, 542 insertions(+), 95 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

