Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F60613371
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJaKUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJaKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:20:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E652DF31
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g129so10292587pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/CtGnfpUoVcDjqfnqcJteWSP4xfI2BXBO2LF/caGshQ=;
        b=B2IZAZrG+ncX6qy+AJqurgkHwYFbcSSEKTLfAHzB+P8rkHzCaMp479Eqo721glfxy5
         x5UYRI5AMP3+RjAi7ZxuKgSrRVviD2hJ3F0J03YxizSkNO28rnd1SJTpY8UJIYqp7NRr
         kxhQqwcP76u5NQ7el1QOhsh6Wv+xydv2tigrzJCDoUDeM+pC82TRZFHZ3kcKRpzbzgro
         ZrhWHDW4UbzwSM3qW27lfs3GBNB8FxrDcbCMU/NA5UkPOQMmsQYHjfHZrj9VtP14oFHX
         +gA4VRqya4V72FWrbuxMeXLioOkuAWbE7vyxMZBred/4j3w9rrwkNtIY4/7L+gJNyWe+
         2JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CtGnfpUoVcDjqfnqcJteWSP4xfI2BXBO2LF/caGshQ=;
        b=qCIsGbyo87H8Ul/nV0HC0LxlD90k2DIXFQjtZAUKe0Qwsx6wl6KwQJylNaBvoGbL3O
         6HHONAkBoC6rctq4cMa6zp8NVk9j8IlC2gz/hGVpACAj4SAEoXi/FPRkb/M9aiz8EtUD
         YQoaFT46wbvBxrvzVWca4bkZro9nlDjfDf9g9UySxanX+kBdWGa1F/MHfevPSOVzGEXJ
         O2wm6fD2xhC4baOcYbz5lOVm3DeN1AM+uNJG8q8cBQdG9e3LeRf72yzgzZs9dPd92YA2
         bUsHgTJpl7GTvs0nXhKTnPNNcMCXCyo12LQOQq03qdUCgA+7een6apFt2HFzGkJ0TRme
         Q6FQ==
X-Gm-Message-State: ACrzQf1dNTv5olIo3M7NWmP1AoWpvD9ZRrCoXNZKXPbmXpaa7GTba1Kl
        GdhyVAgfvOK/hSUEej7QkrGzHtZaEyOkgQ==
X-Google-Smtp-Source: AMsMyM7V7Y2X2khFat8fRh7gfF/yB9PfTMJ97+3tSoNvJ40U8nSweIuOm5IDVLSSbfeYOoz3U17Bng==
X-Received: by 2002:a63:1803:0:b0:46f:73ce:fe28 with SMTP id y3-20020a631803000000b0046f73cefe28mr12054349pgl.219.1667211616365;
        Mon, 31 Oct 2022 03:20:16 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b00186881e1feasm4136551plk.112.2022.10.31.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 03:20:16 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v9 0/4] Add LTE SKU for sc7280-evoker family
Date:   Mon, 31 Oct 2022 18:20:07 +0800
Message-Id: <20221031102011.136945-1-sheng-liang.pan@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add common dtsi and WIFI/LTE dts for evoker.

Changes in v9:
- new patch for evoker include rt5682.dtsi

Changes in v8:
- updated patch subjects

Changes in v7:
- goodix gt7986 dt bindings added in v7
- add compiatable for gt7986

Changes in v6:
- add removed pinctrl and align touchscreen label with herobrine board

Changes in v5:
- recover whitespace change
- new patch for Touchscreen/trackpad in v5

Changes in v4:
- fix typo in tittle and commit
- recover change for trackpad and touchscreen

Changes in v3:
- none

Changes in v2:
- none

Sheng-Liang Pan (4):
  dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
  arm64: dts: qcom: sc7280: Add LTE SKU for sc7280-evoker family
  arm64: dts: qcom: sc7280: Add touchscreen and touchpad support for
    evoker
  arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
    in evoker

 .../devicetree/bindings/arm/qcom.yaml         |   5 +
 arch/arm64/boot/dts/qcom/Makefile             |   3 +-
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  |  14 ++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 147 ++++++++++++++++++
 ...er-r0.dts => sc7280-herobrine-evoker.dtsi} |  22 +--
 5 files changed, 175 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (95%)

-- 
2.34.1

