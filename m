Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704F26DDE02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDKOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:32:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15BE56;
        Tue, 11 Apr 2023 07:32:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso11166981pjs.0;
        Tue, 11 Apr 2023 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681223525; x=1683815525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXgLo5OVfNAMT7/smDiYjz0MFkV0iyCkx0eeELk7SYQ=;
        b=nWRgNU6YMWDga7MwAbjU/V74AQGnljhjJKMzMvS5+zZe+eZkOWLvU0j0Kj2gkVbslF
         JbJNdl6F3f4bhb7ulZcZ7RWGJMGc8jaBuEiPKZvhTbERDDQAp3gygl20Xuy9NntBgtab
         CTzVb4XHhPYunKKJ6RDg+blRZY8agaSnfX9ZNLnVpbCyzzdGxi2aL3k3yrAoqxlxiWQF
         +jm5uA5h3wLbKPyN0iM7oh0R/yPlC+O5PptXtwm5fvPK65cpjo0c8NMoTu7+CJWQtW0I
         HDa4eqjUl6+tHKrogQqOms+cjKPdTF3c6dVBeFc/8iyo1ZJpDUegBw8XdYm3Aw+S3Lb+
         hV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223525; x=1683815525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXgLo5OVfNAMT7/smDiYjz0MFkV0iyCkx0eeELk7SYQ=;
        b=J48I/Vy3KO1ZINlpjh77nTE8F3jeSPs1MT0UPAZdF53kv6nndpWgeQEGH1v8nOtgEI
         xNAv0Hya88NNWy3KT8LB6dutVOA4k5kh6Bi0W6JBJQVNPLs9WCmAa2aprs80bPzNFhwP
         DXM0O+HOtfyMJGoGJ92jh798iyaI0qAnZ1irCkHU6cZ7az13dOQ3KKKUg7BOgwtSyhd4
         Z36K/+BsQxnUidTPwjz3bCW60MFpuivOKBfXZp9UUy+tHvybdq6NZKXe0XyoXia0xUk4
         3kIG+ktNbPcKA1bhXGuCmAkYAtX5n4Bbi86GGFkfh/wAoNAnw8dbSSkFLW5SNo3RyrX2
         ajgQ==
X-Gm-Message-State: AAQBX9cOL29fLFcE8wNN1MJWojXc1Z9hVm0A/NCPtUNi94hxQ86Vrzgm
        018jMz91yvptXPwFkMLxU8aPv/Jk9tM=
X-Google-Smtp-Source: AKy350ZvBkJkHrK+EOEBnmvu2iSV8npZ2azOJz2Iz/9s7a8goU5uQtXMWfijuKHhwAIu8hkJ7Kn6KA==
X-Received: by 2002:a17:902:ecca:b0:1a1:ab85:1e1e with SMTP id a10-20020a170902ecca00b001a1ab851e1emr15137887plh.22.1681223524440;
        Tue, 11 Apr 2023 07:32:04 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id jk1-20020a170903330100b0019ea9e5815bsm9829721plb.45.2023.04.11.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:32:04 -0700 (PDT)
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
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] dt-bindings: display/msm: dsi-controller-main: Document qcom,master-dsi and qcom,sync-dual-dsi
Date:   Tue, 11 Apr 2023 22:31:49 +0800
Message-Id: <20230411143149.16742-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes warning:
  sm8250-xiaomi-elish-csot.dtb: dsi@ae94000: Unevaluated properties are not allowed ('qcom,master-dsi', 'qcom,sync-dual-dsi' were unexpected)

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e6c1ebfe8a32..940a506a289d 100644
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
+      Indicates if the DSI controller need to sync the other DSI controller
+      with MIPI DCS commands when qcom,dual-dsi-mode enabled.
+
   assigned-clocks:
     minItems: 2
     maxItems: 4
-- 
2.39.2

