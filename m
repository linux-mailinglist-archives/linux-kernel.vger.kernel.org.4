Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887A6110B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJ1MIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1MIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:08:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B81D3A7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z97so7540293ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TuHMOYtgntRlqrUPHzqn+/W9rCLxqfiv1KR+wOTGa/o=;
        b=qYLOPDk6E5l+vIE4I34Ig+IbPUBMvJLN3+xzmNbGft8VEMPxNPz2AQeynQxL73OhaQ
         J0s/GY3/SM2OQIwylsa59J1MLNDYIw3VlTdD8Rpx5QHsNiBSGjJ4yUin1lkjZ5yhu0Tp
         8SKxBpCGevtEck6cPiHv4I3u6BKSlJBc7u4V9m1ScJygEwUuG5byF9zjNTY1JG0uw36u
         nNJp5k7gZKyreb2Zrd5JkjkByHhVznRXxYW1dTksqL9Ykl/dQdirXJUv3qxgbe8aQ5+n
         4/o7bDduxmC7Si3Ua/eCFAru4hqq5quCw2Ue8osi4Nrfq7vX8PLhpCIh8p6gZztVtGfH
         AyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuHMOYtgntRlqrUPHzqn+/W9rCLxqfiv1KR+wOTGa/o=;
        b=sGtm+GrYqqXMP4QAp0w4NjP75kA2jDymyF5Bx2KHbjDG82/u4+/5WUoKZnMEEypPyv
         iAAaQRlkfmPF3LzA2R6qlywWyktfl7aSrjRt+BbqMm7syq8YDfjBNDs64Y29NJbBUYAF
         1EZb7m0yyxgRUQXWVCrW468u3audWbpvrHXFc2X8GhGgk4KbdjRlziGlVFsxS7IQU9fg
         Iabchc2G7RWS1DcU4ri6gtDDhkSjj6dDvZFqUSs+5TJsudxIiXwZfYvd5KTi5N0lz0jK
         G8Ii36W7lUk6PWARYc0UjVe25h85W1jWqxcU9m+YBIzg75ovWCnt9II66JYg0JfnP+AA
         1kaw==
X-Gm-Message-State: ACrzQf0ng63NB3CAFbDbBqsCfCs7zWEMx/PQssKb52vxK0Ah/JwZdIMY
        ANBppp/4jHuWMzbyz2zrJoLrzw==
X-Google-Smtp-Source: AMsMyM5OQSCfAm8WdRuXRXGqKjaB68/quVPLiq+P/+A/qL26ccve+eRNTxZenQ8jGwajbiZeyubHAw==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr49793579edb.102.1666958898318;
        Fri, 28 Oct 2022 05:08:18 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906124d00b00782e3cf7277sm2067258eja.120.2022.10.28.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:08:17 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: [PATCH v1 0/9] Enable Display for SM8350
Date:   Fri, 28 Oct 2022 14:08:03 +0200
Message-Id: <20221028120812.339100-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements display support for SM8350 and
enables HDMI output for the SM8350-HDK platform.

Robert Foss (9):
  drm/msm: Add compatibles for SM8350 display
  drm/msm/dpu: Refactor sc7280_pp location
  drm/msm/dpu: Add SM8350 to hw catalog
  arm64: dts: qcom: sm8350: Add &tlmm gpio-line-names
  arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
  arm64: dts: qcom: sm8350: Use 2 interconnect cells
  arm64: dts: qcom: sm8350: Add display system nodes
  arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
  arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge

 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       | 333 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 217 +++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 227 +++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                |   1 +
 6 files changed, 760 insertions(+), 20 deletions(-)

-- 
2.34.1

