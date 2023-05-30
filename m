Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447271650A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjE3OuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjE3OuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:50:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BB8F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso46958005e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685458181; x=1688050181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udNghephkvKhPZuJBjEix+UuL920fK/8W/QzTCO5Pcg=;
        b=W+7ofkddfcWJ06zeU0Da9XAhr+E4Vfz4rR3jL63NhJI+86PbNPD1NqbIUy2FS+9h4p
         jbzV2VPtF3LhpyKSiJWN5UqkQmx5LK2/wCHSuLL5wy2qILsQ4nDcgQkrmCwY9n1rrOIr
         GlDCNJ6jgx3+e7ql8RJFM9G1LgUfgjr4Io1MCLTwjyBw+1ngsJy1uKqsGnkhcZR9GmWr
         zEU8kIuY6sMgHKNnu7tYrkVtm3OlR9kxLlWmtLGGb2X4v9nNMQ1Gv1BCp0H9b/nDi0EH
         4eY/QLB97/Jo6DF4CjJ/AToKbqAsAuxeydt6ifJBMflL9KnCYnQfLLB2LGwrvc2ZaVdG
         JLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458181; x=1688050181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udNghephkvKhPZuJBjEix+UuL920fK/8W/QzTCO5Pcg=;
        b=EVKFYLybZ7PHn27eyq/jQ4wESjw5yp2UTpsampKqWMOwBEy7TRcyqcQG82lWmB6nkt
         F5nq4nVgFG5/uhsvzO78yByoBWtMzlUW6QlXnrDvdbTteXl4J+wmJg62k83qtllPl4RA
         7rHOUWnWkpOScdGjh7N9QHu+gcJhIeTtozElTxGzq7Yyjyav7tF5I5af3G7ZGIpFkrWT
         PVdUcp/9AvA/0r6TLMD2vY9BXYsdDR1dKGIZJnWL5QHWtogPjPHypyw6sfXJt6XwEJHm
         1pMs1YIY6qA4+Xtn/KLdpAL8Im8POygHjOIdmBdfE3Lb71F+ylB/vJhpJ8uACiw1c61m
         Ak7w==
X-Gm-Message-State: AC+VfDwF9HlED1/8IF/1kjhn3EgSehtQ/5fGwFRkjF+LKdMEZJqCW9Pf
        6/oefvawQPrJObJyHKP01e8/bSjgLuxV+xo0Gwo=
X-Google-Smtp-Source: ACHHUZ75uX94LvL6Mu4X8bBwL6aHIfbExTPA32GAruz4VRZiaZa0LwAOuzBPJm+FdPrWQQgM8rwz0w==
X-Received: by 2002:a1c:790e:0:b0:3f6:72ec:5fc3 with SMTP id l14-20020a1c790e000000b003f672ec5fc3mr2087614wme.12.1685458181458;
        Tue, 30 May 2023 07:49:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5bdd:98ce:604e:9cf0])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b003f423508c6bsm17323488wmj.44.2023.05.30.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
Date:   Tue, 30 May 2023 16:49:31 +0200
Message-Id: <20230530144931.188900-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPU SMMU will require the clocks property to be set so put the
relevant compatible into the adreno if-then block.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Resending with all IOMMU maintainers in CC.

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ba677d401e24..53bed0160be8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -79,6 +79,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
@@ -331,7 +332,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sc7280-smmu-500
+            enum:
+              - qcom,sa8775p-smmu-500
+              - qcom,sc7280-smmu-500
     then:
       properties:
         clock-names:
@@ -413,7 +416,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
-              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.39.2

