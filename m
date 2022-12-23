Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E9654AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiLWCKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiLWCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448C20F4E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so3381353wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hu/pgFNNxfeH2Gjp98s64ccughmNvrwi5MiArHpcHo=;
        b=yGfe4DQ3KTq24nSAmHQc46jlKLMrFw+CZHP76fuhN/IebnDh20dINzhgLujYqKVX+Y
         dXgJ2eP1ZKXLeOM6QoxMhqcpwOgoEejsvHf9d2BghPVYx62uqO2xtM2ky4/bLGMMHWXt
         rI9xvCXv3MSDG5h0FyJl5qV4R6BUPJB63A7kN86CDGbvDqJB7sP5y9Bz8s3zHfDTx4Wh
         1rmntAJPoc2qG9vCfGqtnQ75Srt6XE8pzFV9AbvBfcJd2ReH0qUsjsoYvGUOe4nPAWcl
         8YFRd04buMiGVmi+MF7lA0m064vhPo+nshLgB18tEfW9vYMl/lO5oUnGdPE1Ti3BXwM3
         nvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Hu/pgFNNxfeH2Gjp98s64ccughmNvrwi5MiArHpcHo=;
        b=bgxsqnR0omr2YU21Zo6Kr7lXFmiTVOBCGOYFJU1iy33ytIdjpLnM183t3cdWmkg6sj
         auuE6L/zRamAQVg4z1qw5kLCW7poY95RssSO5yW1ZPcImf/88bfDQFh1E4330f3y6VBe
         ApLu8vwfF4caLnz2LXlxkYd17efuBw4/5OtWgOyc+x8wwnHv0Ye1zXYCU9BvPJoFUAOf
         rzNUG1gFFNXMvWXwiRNcZ5c0paLeTrPoFlW6l++sC3kZZ3tp6N7th1aJGYPL50Z7D2zA
         wlDcNQL6FkP9WBBhdOtFIhsoNrGWmULulhVkWobTbpmwp2rPuzvB0i3+JybGyhNSqtuj
         86Og==
X-Gm-Message-State: AFqh2kqJYmz4G1ZcMsZI4b/T17MZO6olrhmXY94QPTJGLkBj1XnFwBx9
        NpIq+g4rr9QuWpLSdLUrRrrPeQ==
X-Google-Smtp-Source: AMrXdXsqclnk5dTKs8dX2sprcRns0P/6Ejt8NwsXpgOv6nEraTPK8YW8miSgwRDhRTOx+hRIEHHMcQ==
X-Received: by 2002:a05:6000:1373:b0:242:30b3:3ca7 with SMTP id q19-20020a056000137300b0024230b33ca7mr4544772wrz.11.1671761429741;
        Thu, 22 Dec 2022 18:10:29 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:29 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/18] dt-bindings: msm: dsi-controller-main: Fix operating-points-v2 constraint
Date:   Fri, 23 Dec 2022 02:10:08 +0000
Message-Id: <20221223021025.1646636-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
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

The existing msm8916.dtsi does not depend on nor require operating points.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index f2c143730a551..55bfe1101d6f4 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -138,7 +138,6 @@ required:
   - assigned-clocks
   - assigned-clock-parents
   - power-domains
-  - operating-points-v2
   - ports
 
 additionalProperties: false
-- 
2.38.1

