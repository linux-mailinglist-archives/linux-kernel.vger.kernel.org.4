Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4F6F05A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbjD0MWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbjD0MWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:22:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814472130;
        Thu, 27 Apr 2023 05:22:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51452556acdso6211855a12.2;
        Thu, 27 Apr 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682598149; x=1685190149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Je9dOfRheV0xbkP5D8rz4YMFOXvOjexxPPlhbTAEfPg=;
        b=GQkHqLCx9QOiCVqkmdxf0PEzuwjMhhQn140pliLqoJPgOQ5nb4HFSUeFmKRAUUFL65
         ygD+kZbwE/NQVPdP2oeBIAXKvHhkanPAeWnkIkz9JlAxYph7Rh+fF2hJqEUFSCO4jOO+
         mie45R/RwxKV4XqV301GJksXsUh+PpMsyvjT0T/yMpZnEIFbHNI+2ADNuPmvtxQRjbL7
         qfeqLmsNO6dxA/XznhGoOIvDCAtl/J/xBFWbEIidS5y/piZ8gfH5Z9VHGjUJbqhhVvBi
         v4zdblaFMnGtRS50BUFUUv4E95KhJbOxxNclkMMex9+fV9mdbVYdz8xAFlZyNEYqgqnt
         DRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598149; x=1685190149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Je9dOfRheV0xbkP5D8rz4YMFOXvOjexxPPlhbTAEfPg=;
        b=fv36iiC6hfnLFNE9gSKrbl6UWdp0sdR2ENLYlg6o3j9ta+hYkki+UOPVnwfdwpSysP
         gI2jHErHwrenHlzBDjAFQImB+KSAe6baw1LTHMFGmvwfWpMqmhrSQgHhXezTVds0N+K0
         RaxP0noipJ9b3xhdOZaO4FYo4UwG6y7GuXUmYc3zvGGgS0qjNGVU26coFpzs1Qx/ltyG
         n2jyRYirBBi8J7bc+q2LDZVnjx0RvOIbeh3jDrxfMQy9uef0PozkmWT+U1WObk3fSElL
         aik9JL9hw/oadLW7emjjc4MzuD7KcN0SJkJMC3waE58fUOTPRZbmx6EcutzEEpG0oBTr
         TOQA==
X-Gm-Message-State: AC+VfDyZMVTQmsq0FUYeE1i747F3NpPePyO9QOF1s9KFnDzho7Afsg+c
        WVN5TvPK6j1b/+i7OKV3OFg=
X-Google-Smtp-Source: ACHHUZ60LSwIT0w8lkNEvMzM0Y0TrOpiNVgl24TggeN+M+JPyg2fFsrpOK3fdBeW4lKJvNEje1Dz8w==
X-Received: by 2002:a17:90a:f312:b0:24c:1cc:e15 with SMTP id ca18-20020a17090af31200b0024c01cc0e15mr1813547pjb.12.1682598148867;
        Thu, 27 Apr 2023 05:22:28 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id ot2-20020a17090b3b4200b0023cfdbb6496sm13443011pjb.1.2023.04.27.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:22:28 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: display/msm: dsi-controller-main: Document qcom,master-dsi and qcom,sync-dual-dsi
Date:   Thu, 27 Apr 2023 20:21:32 +0800
Message-Id: <20230427122132.24840-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes warning:
  sm8250-xiaomi-elish-csot.dtb: dsi@ae94000: Unevaluated properties are not allowed ('qcom,master-dsi', 'qcom,sync-dual-dsi' were unexpected)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - pick up tags
  - fix typo (need -> needs)

 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e6c1ebfe8a32..130e16d025bc 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -82,6 +82,18 @@ properties:
       Indicates if the DSI controller is driving a panel which needs
       2 DSI links.
 
+  qcom,master-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller is the master DSI controller when
+      qcom,dual-dsi-mode enabled.
+
+  qcom,sync-dual-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller needs to sync the other DSI controller
+      with MIPI DCS commands when qcom,dual-dsi-mode enabled.
+
   assigned-clocks:
     minItems: 2
     maxItems: 4
-- 
2.39.2

