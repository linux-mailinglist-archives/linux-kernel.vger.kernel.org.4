Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61D631466
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 14:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 08:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 08:41:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30F23172;
        Sun, 20 Nov 2022 05:41:29 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l8so11891615ljh.13;
        Sun, 20 Nov 2022 05:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNF/kNtbO6GK1B3nzJQq6Q9EeflceLft+xrnXuyeMeo=;
        b=DDnt9gVC5ya+migDiScvg5lZuWSaBByLu4liDWKPFUASHA939CLQMs8PBoBNeTvCxm
         iUA5oZEFkRe5SJ5gSTq5DJq/2p5l5pwIQxaje7pi3vV7Lr0X1u0JBChXgmjeMcEUrvuV
         eFYbATH1bILvOcXPPvJKNxzu7A4zZxjLe2bNpO5JNmQzzoidDxwFf7dHNlC4oVulvFqC
         cysGz1VOplPYltdogRf1A8Jd4B4+NdlkK7AFJJ9phLznqORla6nY1P7PMZ8gkR6Ex4/A
         6HwNJsVUwB+Iyja+4J9FTAI5sKKuMU1Qd61Tg2yv8XzqHjoHDAf3S/3RR+kwogpdfetb
         CHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNF/kNtbO6GK1B3nzJQq6Q9EeflceLft+xrnXuyeMeo=;
        b=z4SJuZlmTzb6T/2AtV8pMddgnrCbEMQt7+zePff6A5ux+PywsAwka1NVsti+oZ+rm5
         QTqt0a0/csUNz6GJ6vFX3whbDOquNAp4nrhGsGo+k+j8hHakIGP+8nZjfgWBIixoepfY
         Ybag9xBQrU/q1iC2jgnxr2YI9UCLrwHIitVv5GUlnv8jDPsUlCh+Y5T2cLNyiCB6C8q4
         Dm4i6ZmTIc7NBZKL2PO5Z2KK9+gHPJYY8LMn7SXwgjn92bDp/EjSuI1DQlgf/3w8iXcR
         deV2G0PcFd70dqG2tGRIWkdCij5YqfXIqt/B1TVoULlq+iPhfkp0wmNhfa/nNy8YQwQi
         XQUA==
X-Gm-Message-State: ANoB5pnWqVZrG7c478cqcNaHYnHs9Llt7wi+sezH8mXdVnbEsrnRcRUn
        DBeMe8MZk+TF9YK59VTsVYiq6Tf/x3w=
X-Google-Smtp-Source: AA0mqf61XDCq0NCQSdMy3bngtqan9E4X4cICS/OiRi0bwydYg4UvH5qZxFbhuWbViFRaeJQWlIK6/A==
X-Received: by 2002:a05:651c:2002:b0:278:a1bc:ad26 with SMTP id s2-20020a05651c200200b00278a1bcad26mr4853728ljo.235.1668951687554;
        Sun, 20 Nov 2022 05:41:27 -0800 (PST)
Received: from localhost.localdomain (cds73.neoplus.adsl.tpnet.pl. [83.30.168.73])
        by smtp.gmail.com with ESMTPSA id m3-20020a056512114300b004afac783b5esm1536287lfg.238.2022.11.20.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 05:41:26 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jason Wang <wangborong@cdjrlc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add SM6115 MDSS/DPU support
Date:   Sun, 20 Nov 2022 14:37:35 +0100
Message-Id: <20221120133744.24808-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for MDSS and DPU block found on SM6115.
These patches were tested on Xiaomi Redmi 9T smartphone.

Adam Skladowski (2):
  dt-bindings: display/msm: add support for the display on SM6115
  drm/msm/disp/dpu1: add support for display on SM6115

 .../bindings/display/msm/qcom,sm6115-dpu.yaml |  87 ++++++++
 .../display/msm/qcom,sm6115-mdss.yaml         | 187 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |  87 ++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                |   5 +
 6 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml

-- 
2.25.1

