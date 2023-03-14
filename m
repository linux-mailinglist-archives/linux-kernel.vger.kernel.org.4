Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDC6BA122
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCNVGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCNVGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:06:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCC4391E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:06:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f1so13406875qvx.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678827992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeNB1KMktbKdte2S+8YaFoHdeVrmArJ/QSpeQ+IzHvI=;
        b=vStZHalSBpSrjs1dz4MKVe8u9ZGY4fa5qVhmJJ4hp0YbIkwLmbqOAQP7LSxJqnPhXX
         ph5yKvV2UMG6thgSpJTRDoPMWfJ23dx0GY0I/JKn7dgOtb3xshaisNBvBIm3mswA50rv
         Hx9dr758uY1D0O6W4jRLeMfm7V4AJ7NcG0k7/EnxflfiAG1H71be9/jTMsmZI8p7+YI1
         a9G3yn7K5AtbVI6nSV2eE+AcK+2Uo2LCZUFeNbn19s5v51/oV/1kLi3J9pXqMoACFykT
         Oe4WAn6yIOc9V7p2PPMthjTYHAW9nqPUxf/+OLnmlOV9i4WwywsRaqiDjE3wJOSYmhP5
         p6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678827992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeNB1KMktbKdte2S+8YaFoHdeVrmArJ/QSpeQ+IzHvI=;
        b=aKDjb2kOn4R1AiEc8O7tNqmwzFZ316Th1G6UmshMEVMf2jSadjW1vpQTFggBXRj/wL
         /mHTRWrHdf8c+O5+1QvIrvGr81dVpjvKPMkaUixwvWSQod9/Ij+1DY9jNUJjXvpkIKkV
         zkX3pI9HZoib1DQmLtktDisDm9cEOfqWI1m/7+DMZ0tLTG3MKUEBo0LEH8e1bierlxdu
         iDkOsBleBVhgVF0XhGUjRboieYQXbhCSisz6x+nXKPNnu2KDCU/4kO9XCeDpEISRmggc
         06NtTueMZpzGu1OzJypm5T7qpg1PQJimV3LyUjyiTdwVeFHhkcpJ0L4jL4KnREWW49Ro
         hDZQ==
X-Gm-Message-State: AO0yUKW13oFdZVB4kloDl+Obfl3eBJgD34hXbkrKqgrIcnOyPC7RjR8T
        FnwiOTGsr6h2vOCC3EZ9oDm3sg==
X-Google-Smtp-Source: AK7set9T4ospnPE72hHIectrswsBpVlkH/xN+vJpMdera9IowF0rZDhs29RWjz9lNHHW1mpOj4cfcg==
X-Received: by 2002:a05:6214:4001:b0:570:ccb9:a4d0 with SMTP id kd1-20020a056214400100b00570ccb9a4d0mr18793766qvb.16.1678827992287;
        Tue, 14 Mar 2023 14:06:32 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id d78-20020a376851000000b0074571b64f0fsm2443156qkc.53.2023.03.14.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:06:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: qcom,ipa: add SDX65 compatible
Date:   Tue, 14 Mar 2023 16:06:28 -0500
Message-Id: <20230314210628.1579816-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SDX65, which uses IPA v5.0.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 4aeda379726fa..2d5e4ffb2f9ef 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -49,6 +49,7 @@ properties:
       - qcom,sc7280-ipa
       - qcom,sdm845-ipa
       - qcom,sdx55-ipa
+      - qcom,sdx65-ipa
       - qcom,sm6350-ipa
       - qcom,sm8350-ipa
 
-- 
2.34.1

