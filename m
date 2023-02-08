Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808068EC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBHKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBHKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:16:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F142DD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:16:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2164455wmp.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIP8R/xQ7Af6ETfQwAtdNDiVKk4oUEjwkSgHlIW4k74=;
        b=xf5P1mZEQ/f8xsXxbbauz7U4oW97zmEDzPAR0GIA0F5EDCDkpZUY+iw2NzZnbALPST
         TVc6K+bd2QnughBFtQjAMZgZm7kKlhkxxvJ39ct/UqN4rfbYPLfZ17F5zd9cMq8WmqyB
         iIEStiLAR467EaRWFZIL2D26DlCk/x1W6S4AWVmxfgq/N6jxGI6Bhov/30Ozk1ekxdoK
         +AIAhD8xo6sEo/W4CgDu0iXlpBOHfDcZqAGFQJ3Kj+5DUFa0VpWWFn3q3XGRrD7FqGXg
         jIAv9a8SvAaUUYlm9kIal6+y1sYhHU4VEISUeAAAH7Xb9FBAN6eZPMHpur7FJfMtcwqe
         Lv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIP8R/xQ7Af6ETfQwAtdNDiVKk4oUEjwkSgHlIW4k74=;
        b=kzWkDSl/t3sGU9pUJEUCvLGb5epysWfTf68bMRdV+teuA56phSo2LNN9lvWYBXVFxi
         YVLipLtEbSR0woiwVZJXvUZuevrnKS6sB9iD4Gv0LPBM+yKHqRSJf6wDwgy7caiZRQHu
         paZpddl4U96ldLxpHhhiNjAdCi2r3t2y1+WkFGXlgkVO3Ij8s9luiv2puddiwpxJY6Mp
         bNf38mjbl5OOraeoIFSIVGkol9jjeWVuIR0OMSYn5ka0yFjzeTrmHO2behlc0ym4u5nc
         J42HdtfxerieIv4ePV6/xafWPwGsAO8lr2kqKdcHqjP+vt15i4V0IJJ5bijS+EudYgvM
         N4SA==
X-Gm-Message-State: AO0yUKW2zLDJeP+Np3NCG4F0BYz9DXex+aw44giz5tdmqv0QWYY+0MCP
        h0Wi6LvovOgG6nuHZkRvRPndkg==
X-Google-Smtp-Source: AK7set+f5AbP6DO1p1Rfbv0AhFB9vPMBJ9BONhfBuIOjQDgrlQaXszTkx7Bz9W4uMCB6M3CKPbrG9g==
X-Received: by 2002:a05:600c:3c9c:b0:3dc:d5b:5f6a with SMTP id bg28-20020a05600c3c9c00b003dc0d5b5f6amr6011165wmb.30.1675851361711;
        Wed, 08 Feb 2023 02:16:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dc4ecfc4d7sm1496328wmq.29.2023.02.08.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:16:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 7/7] dt-bindings: remoteproc: qcom,glink-edge: correct label description
Date:   Wed,  8 Feb 2023 11:15:45 +0100
Message-Id: <20230208101545.45711-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the description of 'label' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None
---
 .../devicetree/bindings/remoteproc/qcom,glink-edge.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
index 8e133ab55ff3..15e6851e1ff8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -42,7 +42,9 @@ properties:
     maxItems: 1
 
   label:
-    description: The names of the state bits used for SMP2P output
+    description:
+      Name of the edge, used for debugging and identification purposes. The
+      node name will be used if this is not present.
 
   mboxes:
     maxItems: 1
-- 
2.34.1

