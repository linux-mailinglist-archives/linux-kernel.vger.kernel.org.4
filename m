Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9C656C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiL0Olh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiL0OlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:41:15 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF9CF4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y25so19861187lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrBufiZn12apVd74EI4F9Sr/fFC/dV5wnBICQesdpA8=;
        b=U+XBF7EH5YqVgUikSD0knmchw8ONlmRIxqxD4So8PTKozqMkQfkMVfGXpvUo6h+E/7
         Rzxi64YHO9pFezpzdIjiWHaa+Esj9doX7B8Tc/mL5/XWVeiKcgzlbcOl1/jJoN6IEhvt
         hIisDQYTK74mryb85ywmBvZvKDG1pSgN1ZoMkFUOAi+2vE1ygLPpy+RwN9N1aHMrKBqc
         ILZPiL0LsrzrpKkkWYfK0/WuZzkDKnLkj45DxHA9BaQ+sehkyNcR+LM0THyl/AUF0xbm
         SDaq/DwuzgW+n/TLfXh8ENzX/Zn182I+AFjQ8jniGuxhqKTBNFD3jjTkP+jphewc98un
         Ft9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrBufiZn12apVd74EI4F9Sr/fFC/dV5wnBICQesdpA8=;
        b=JNocPD8aD5NQiCD9UNOGc1kBQODDuiywNy0v0lktqR2jV5mZwKFtAdQafbyospt+Ne
         FVmJOyo/K1C3S0sYDheEXFj1fnAx0LOzZ1DUMbn+g1cYRvq7BYMIk1f5L1OJrAi6STN5
         19eROJIfsMGRpqzin7RDX0iMAL9yx72xanBkigEcSn8k1otwhJfNx0qOxyylxlSH/25A
         Etg0O14PI6CeoyvP/IZmxPhow6fX4Eufyuu8Lgfw9U3kUxqQ92C7L7wZJK2ZC0pxSvvX
         mFM4fKp5qo3lvuOlZWopZVVMQpCJeo/ORDhXtK1UEnD1xfBr0iFXXGkiQewvQNPeGFEc
         PiWw==
X-Gm-Message-State: AFqh2krOgqzVNKFbIGP+0VrlKrgxOIFS0V1mTzuTOFcCc7k5yDRbVwpn
        n45MFOAjRylEeGvrQssvMkdHtQ==
X-Google-Smtp-Source: AMrXdXuXEqCJxfK8sKlagKcbKAzPtQXsg0xWu42M1eBnEoNNNCrMeXT7K9zfjhMZAht2p/Vg5fKQLg==
X-Received: by 2002:a05:6512:52a:b0:4b5:7988:9146 with SMTP id o10-20020a056512052a00b004b579889146mr7103480lfc.16.1672152071849;
        Tue, 27 Dec 2022 06:41:11 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004b5853f0fc6sm2261126lfr.246.2022.12.27.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:41:11 -0800 (PST)
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
Subject: [PATCH 7/8] media: dt-bindings: qcom,sm8250-venus: document OPP table
Date:   Tue, 27 Dec 2022 15:41:01 +0100
Message-Id: <20221227144102.79391-7-krzysztof.kozlowski@linaro.org>
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

Venus on Qualcomm SM8250 uses Operating Performance Points (both in DTS
and driver):

  sm8250-hdk.dtb: video-codec@aa00000: 'operating-points-v2', 'opp-table' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/qcom,sm8250-venus.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index 1cfeb136a5ca..7915dcd2d99f 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -51,6 +51,10 @@ properties:
       - const: cpu-cfg
       - const: video-mem
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
   resets:
     maxItems: 2
 
-- 
2.34.1

