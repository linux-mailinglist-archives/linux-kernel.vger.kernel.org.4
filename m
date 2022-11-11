Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E53624ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKKATN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKKATB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:19:01 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165E42F42;
        Thu, 10 Nov 2022 16:18:59 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q21so2597742iod.4;
        Thu, 10 Nov 2022 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=CvFghUzcRpXlVKjjQCyXnTZ/vC6FSGvSukfK4fbSJvwCAcJRPzdhDzmoSxt0NrA+2V
         waJMubcTtWqkhQCqMBAj3WwGlgaCkqHf5v/JXf09QoNVUfjlR0sy/MmOq9lhk2TbAe6Q
         sNOt/nMjhrfDAtn4gqwRyiUXZ8nlp5rruPriq0XrZJSDB2HXbSbWYnyLVndG1nVd1AQl
         9+D9WQPJ8FjWz4ku+l4WuewtvAljNW3yBXs60q+B7CIJnxWgnhkWyWhy+WAGzbCQ0OCq
         l4o28Wp50Kf/+qF0CfcTkmSjWZvzK9SHSw9j80cGkE/f1Spz/Vqeo2/yEqreT3QOdILD
         yVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=CElZNCWmR/ukr2B2+jsqmpaAyAfgFZoW/jdS0sRtD31g3a+JfOBs7mG4OG5wf2dxti
         LvZbQgOsJjcPYOc+6oIbSQ9o0QP/Cfm0dFnYy5j+IcNKrrhIrLchvIHMY5Cm4yozVHbJ
         mdq+r1iFqHqj/t8v0yqZiFNylNcaeRXcRWZ/K7oRjRR7be5C3/zEOoblB3Lh2E4sQ2s4
         VeS/r45TmPmXhFq4ug9/QYxgKeHNPOAlWebUM0f5YXl3qbr5Xz4zPXsMCiIplL2xyKvp
         HhWOjxgbuCZPxKWuvf12srJjI6xMNjB0EpypyYhm/FCOYjBNsIHSmgGXcGcWlA7axklM
         uvNQ==
X-Gm-Message-State: ACrzQf2ionJfasqxMYe4bUpTRHqoH76Gue/lvoKkWKdko6FSvgixhaW2
        +w2w752DdQrCYL6cDH5Pzgo=
X-Google-Smtp-Source: AMsMyM6trXHbN59ViQHLdAbq4sdKMo1sVCqJi2EaohsXeMVhB4ns7o+E12hMhwgUO3HuLnTwsu/MBg==
X-Received: by 2002:a05:6638:40a1:b0:374:ff83:34b8 with SMTP id m33-20020a05663840a100b00374ff8334b8mr3988698jam.60.1668125939165;
        Thu, 10 Nov 2022 16:18:59 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id f21-20020a056638113500b00363faa1ea9asm330643jar.15.2022.11.10.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:18:58 -0800 (PST)
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
Subject: [PATCH v4 3/4] dt-bindings: firmware: scm: add sdm670 compatible
Date:   Thu, 10 Nov 2022 19:18:18 -0500
Message-Id: <20221111001818.124901-4-mailingradian@gmail.com>
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

The Snapdragon 670 uses SCM as for PSCI power management. Document the
appropriate compatible string for it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index be1b5746eddb..25688571ee7c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp
+          - qcom,scm-sdm670
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
-- 
2.38.1

