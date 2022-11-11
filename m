Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659AF624ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiKKATE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiKKAS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:18:58 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93712528E;
        Thu, 10 Nov 2022 16:18:56 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b2so2570933iof.12;
        Thu, 10 Nov 2022 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=HBIcOn3aZwnpDChgpkAgz6CjDeqoLvyycnOuXJ3G6Tpur7mzx8FSozWrSB+eAVGcLK
         7kpTAKDS+XtVRIWL4nPc/mjwJwfx9NHWNnf6rSbpBJOQ+srftD0G2GtbjrA2X4pCu6Ui
         bJZpXFBx4IElmpzrRje09Fk3XpqaxCtQkPOX6uanwtx1X+NPGEYxSGzUmS9XBfRvl09Q
         g/Aqgs0YViNVGDiT9x6DZtiNZZ83lbxBg5XhWsTO7rPm/PujLONb65ok534kaoeHclP8
         TFlamWyiZhvCYBaVEPNX0op3pmWeV85sDIxAND+NkHjkVxCuc7AI2eQ9cWyHgxQG4FlS
         7RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=h/j42++JOrEkMCltvA+YnrKDMWox6ObG+YsjtqYQIW06SYS7HxRVYXJM7/XreC8wk5
         Qo8JXa50tQjbOgU3jyn3cnK/zI4YNUpHi+rH9VSRkDsjneLwzNTnI9SExP4BxQ8MrxvT
         OFKvYf44zWIVUYSO0qD274vCoRb042Lk0o5IVtfEDGhkFkuFyZgmRnBnj0gCHI4ppnDv
         6N+nbLuCNIwOzFcb3DeeJmT1o6LcXI+VB1nE2s41ib91LWIaMxfpim6BNWeCgF2DNJ28
         jsRaYjrJR4sVFzyzxv7GmRE5rS6xirhAjB1klFN3Z9x49U/jPgKUtT8EBcjqg3AB/qPV
         wuTA==
X-Gm-Message-State: ACrzQf3Fm0UqQUdc1DLqs4AQd6ErVn/bIO++k4jtEGw9b18Pu0YqOhx+
        JtPBjKb/rko2ARjDtkwdFyd2LLFk9tANUQ==
X-Google-Smtp-Source: AMsMyM4LpIaxT1hlXHyMP4uqCqWQKrBcjjovUttOgCLLkDd8sxytJQc96HKH2uYaxN5gA6JKTx066A==
X-Received: by 2002:a05:6602:178a:b0:6d6:8005:8527 with SMTP id y10-20020a056602178a00b006d680058527mr3499328iox.166.1668125936189;
        Thu, 10 Nov 2022 16:18:56 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id l13-20020a05660227cd00b006c1819ffe60sm220101ios.53.2022.11.10.16.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:18:55 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: arm: cpus: add qcom kryo 360 compatible
Date:   Thu, 10 Nov 2022 19:18:16 -0500
Message-Id: <20221111001818.124901-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111001818.124901-1-mailingradian@gmail.com>
References: <20221111001818.124901-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Snapdragon 670 uses CPUs named Kryo 360 silver and Kryo 360 gold.
Add the compatible string in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5c13b73e4d57..1247e9a975c9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -178,6 +178,7 @@ properties:
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
+      - qcom,kryo360
       - qcom,kryo385
       - qcom,kryo468
       - qcom,kryo485
-- 
2.38.1

