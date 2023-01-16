Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4ED66BA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjAPJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjAPJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:39:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A518B3E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x40so7829814lfu.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saz9hpoZgo7u5MG5Pq91afbON+uRh8poYrgYzXbRk6A=;
        b=bAEIh88vIcEBYhLrEAG7qCjHIaG/IyJ80MVbdJgmQCnt2Zk0m1IAMucB42yylxMQ4G
         Pa5Izbkh1WXY/kZ/b9Rb+IIUlD6Wykndx+yF8gg5CXYpulMwnEoIFTHvKaKTNQBEVTj6
         wqbOwYFtoIHp4k3kHSJpoIOPUIMj1i4LpQ54kx5s2r9+n7tkiAWsvaNX7voqbQORn1O8
         y6HF40Pg6uWsRG3UjjUCy0dd23i1REkdtcFK6GSZXgzCBD/pMp0CyJryFQAC7pkLmy4R
         eam11nCpanBd7uM9CoFf0RsYv9T0WP+VtamD4F+fdueYocFTuQI0zGKXKVOpWQnpZYzd
         MY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saz9hpoZgo7u5MG5Pq91afbON+uRh8poYrgYzXbRk6A=;
        b=LUtuW91Cz5FnezIBJjqByvxNvhDrU8A0n/3omJ0e5E8BDM0kajgkcj7ytLj1ZXxsyj
         /7Lh4qfN+1CoJGnNQxFDIhNB05Vq3rl6+HuZ9zhj964n7VIL3tURUDff9LMaoJ+MZg7+
         hVS7HyeXStW1EJt9jQSvS7aHlC0qduPfS3mghXwNAmLFtw/tKJ5DRFyHespLhYlHvI6x
         dW6sMg/EqawuegB4SIsLHrXc9c3lfPk1r/GgO8giPCjuN5Cgci6RzTFlCkGL/MHZGLkO
         qSNQEGYZIqwibZVlmYmEQaddMVe4F3ZsALbpwgnOblLy5NYHTMt1DnLWyMIi1P3Fqbj5
         uqjw==
X-Gm-Message-State: AFqh2koKRDJnCaGnVLlcz+OiYp8zMqp64/30VYEkiwW1qyMlHzn3FGfH
        d2nMPIT29MEdQAjsupreRIvNBA==
X-Google-Smtp-Source: AMrXdXvPDL0tFy4gOYBbq+lByuyrqmsVr+fuR/ikhvfhI6LdZEd1gwoefJARABkXEyp5OstZN7t1iQ==
X-Received: by 2002:a05:6512:b9c:b0:4cc:5909:8360 with SMTP id b28-20020a0565120b9c00b004cc59098360mr15222106lfv.46.1673861944811;
        Mon, 16 Jan 2023 01:39:04 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512074500b004b53eb60e3csm316985lfs.256.2023.01.16.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:39:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/6] dt-bindings: opp: v2-qcom-level: Let qcom,opp-fuse-level be a 2-long array
Date:   Mon, 16 Jan 2023 10:38:42 +0100
Message-Id: <20230116093845.72621-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116093845.72621-1-konrad.dybcio@linaro.org>
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some instances (particularly with CPRh) we might want to specifiy
more than one qcom,opp-fuse-level, as the same OPP subnodes may be
used by different "CPR threads". We need to make sure that
n = num_threads entries is legal and so far nobody seems to use more
than two, so let's allow that.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index b9ce2e099ce9..a30ef93213c0 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -30,7 +30,9 @@ patternProperties:
           this OPP node. Sometimes several corners/levels shares a certain fuse
           corner/level. A fuse corner/level contains e.g. ref uV, min uV,
           and max uV.
-        $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 2
 
     required:
       - opp-level
-- 
2.39.0

