Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAB6DDBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDKNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDKNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:05:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA83F1BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:04:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso9309863wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681218290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZABJR6WjNS1+vU+nCbOWkSpTrGq/wc/uSNYECFHn+0s=;
        b=g4lhiJz6JYqqr7hk0Sw4KNjdPe4yBLH7Yzek0taHb+eT0YP9HFnpu3rMAW/kishYEF
         NQQ+pYS0MJI8O+AcdfEKD0s0Igjy/ViOs7PO2BDvq0R6ya9ZNAfdRdK2in7MqQv4rlnx
         4B0k4K9qSCxf+0If4x8y8WuRxGgjabVWuhl66PMyaWaO+Wov1bUuT4d6XNenr+Al8kQO
         XSQIqrG4HD2qfyhRBQgFfQX5XEPyyE4aE1YzVbxeS7rPn/E5/R7Sjueh80ZloeoaruWZ
         oY5fAOMWkYrj5xV3zRcZ+YeGd7tRhmW/39kOnCPTzvFEgKwJwrtf8cHupSG+4nYhrnXu
         GxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZABJR6WjNS1+vU+nCbOWkSpTrGq/wc/uSNYECFHn+0s=;
        b=ohS3SRg4R7Ie3tnCrK1/Dk82wzQ05nzsKXktgUUejyuJDINrrwum+pxRQpZNMcHtZy
         H58PIyNcbmJR90M2SEewcDgrYyv8pu9ISs0ryhuOnsh4QHApzSUbzC1dvkN+i0pTFgHh
         nJvaQZi/hjPQnCQqBvsIZIrHAjDovHCjyrefLUwGn2SnMQ4C1e4lA1UnWXllj8e07u+n
         Vu6VVfeeVGY+D08/BOQBivrMnmmaWj5UZn0ngWBWyKonqe68ubjAtmk4ZeazURgWI0kc
         6TuD9MgfsFuJAkKMz4QnTdzCqzHxRMOrmoVdHfVdlcVCxVnqR5VxWD1CNqoVqR32zwie
         KzeQ==
X-Gm-Message-State: AAQBX9eIoG8S4TZJ3s7fBFRNtZa9dp6qQnf1xKD8AIrZhqieCMMnzjKH
        doioNzt20xt22uNPUZImw2Vy2Q==
X-Google-Smtp-Source: AKy350YI13gmG6S7gmym+AEjXDik99JPHoT1o6t6tlN3d3qWfgUrhOR2bKrzX16M1BoFOlIK8QXlsA==
X-Received: by 2002:a05:600c:2941:b0:3ed:2eb5:c2e8 with SMTP id n1-20020a05600c294100b003ed2eb5c2e8mr9269451wmd.10.1681218290354;
        Tue, 11 Apr 2023 06:04:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id t6-20020a7bc3c6000000b003f04646838esm16921301wmj.39.2023.04.11.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:04:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/5] dt-bindings: ufs: qcom: add compatible for sa8775p
Date:   Tue, 11 Apr 2023 15:04:42 +0200
Message-Id: <20230411130446.401440-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411130446.401440-1-brgl@bgdev.pl>
References: <20230411130446.401440-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the compatible string for the UFS on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..b1c00424c2b0 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8994-ufshc
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
+          - qcom,sa8775p-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6350-ufshc
@@ -105,6 +106,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-ufshc
+              - qcom,sa8775p-ufshc
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-- 
2.37.2

