Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563A656C17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiL0Ol0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiL0OlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:41:12 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE6D7E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:08 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q2so13918758ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH3nDOs4cybUjXuednNp+VWmm1qC64KB4HBglBEawlw=;
        b=udW3OU2GQBVCJk1uKmktXQEHOgBE4x1fkj92d8q2ZBJJwz3S0ney0ZPLps5Z6+wEy+
         O+oioiuEDCYEry4DZqxlbJHg7C/Emo/9qgGezGZH52CXPVy49N16xK84qq8h2b319xug
         7KZMYHFqSFcQL31m470+BdvJPOAbgyHx2WIbd+OlaZIl8rHWZ47ZkvLCp8Fb5MFSz25u
         DOooDotFsTe+yM+r/A4Vrh6dQHWow9lagjouFJ7kO87sU2s25C3GS7cU0Qep4utNJkxK
         1wWnaiVnFlbCnuroTEidOtifG65kJBqmniShNay925TJ8UUbgFpAXj3EkgauK1PkZhPD
         ItPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH3nDOs4cybUjXuednNp+VWmm1qC64KB4HBglBEawlw=;
        b=HwKRhW3/bBWXodqOju3wvAacL9cUyKKlq6YryspLrfA+y+XXPzhdrO74VzKwXHRTt7
         TaX6ylDBFQwq3Pud8upfOW58WhmXqv1luXpUJgafWPJIlvZksQ9gzdRmlTNCdxeNYPgp
         48qscjTSFKKbeFM/h29K9aLxJGnSC5rZwsyQahC38X8K8B5Y01SaJ9bSCF2OqfHGz9zx
         +y9nMF5UbVYMpXENC46MR2niJfcl43noWvkpF2axxT9wk0CZ4fWRm/H4JfAkh81jVvHY
         OaCwRvfofA+w+DBm0X9DRQZ36j2Y1fV6W35wP7GUv0bNaC2A+NvVJvZ/wkSVcXTvDNhQ
         VqAA==
X-Gm-Message-State: AFqh2kqvwSFnsJKZS2qlDR9yg0ePRF01uCMOrsryS+pIaxqozcjohqfD
        fx7/aAdPBRgj/Lo7WHpAWCVJCw==
X-Google-Smtp-Source: AMrXdXtfFDymns2lbGkMzG6rSIvw0Gm9+FBKf5Mx4n7I9teL0WBPSJmkrFnolHsHPHXTEnWxWov2EQ==
X-Received: by 2002:a05:651c:90:b0:27f:b833:c50a with SMTP id 16-20020a05651c009000b0027fb833c50amr3093495ljq.14.1672152066981;
        Tue, 27 Dec 2022 06:41:06 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004b5853f0fc6sm2261126lfr.246.2022.12.27.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:41:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/8] media: dt-bindings: qcom,msm8996-venus: document interconnects
Date:   Tue, 27 Dec 2022 15:40:57 +0100
Message-Id: <20221227144102.79391-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
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

Venus on Qualcomm MSM8996 defines interconnects:

  apq8096-db820c.dtb: video-codec@c00000: Unevaluated properties are not allowed ('interconnect-names', 'interconnects' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/qcom,msm8996-venus.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
index 4a68f924ad9e..3a4d817e544e 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
@@ -33,6 +33,14 @@ properties:
       - const: bus
       - const: mbus
 
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: video-mem
+      - const: cpu-cfg
+
   iommus:
     maxItems: 20
 
-- 
2.34.1

