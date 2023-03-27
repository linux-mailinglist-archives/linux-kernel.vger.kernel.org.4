Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290A6CA747
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjC0ORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjC0OQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:16:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7D37AB5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so36916332edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=979bDGKht4sTcPvoh4er/U+zmo9ulR4Dq1wytmjDqYM=;
        b=oUzd/9aUKVm0GdaahbuFfy/DWKP1+FYgEMM+RyLeGyzPjXluHrME8MeMAtJyiimfX5
         5PJgNbjghIwrjwWhfMxSjK2S/z4olHqIUVrHVJh5JDkyUD4ne5Gn0LyQ0gRH5N6KVX8f
         wnuUL5JImmvpCzzn9rLiREBxYVAq0y5Xd4OBRWQ8T9om1NaRGnXtm5eWNXn730hs2EA9
         ps/D+cRwlferKDpr3FJEdqcrE+dFXYSnCy6T4juqEYHxw2znkOZ5FImQ6/HoQR2hAilY
         r0Nct8QYn/ac+r5CRdA/8MIxprxkQagW05chgX4szLAuDKkH7B+jsY+6rTTbgSSl0Ri2
         1BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=979bDGKht4sTcPvoh4er/U+zmo9ulR4Dq1wytmjDqYM=;
        b=5DCQJTUThB53nue2Jr8ieI0ncaskl9qzVz6LVLwFcnR24RYSvGA9cIeHp71QsqGvpN
         UFIQkIoVoyoFT5lTNfdS8Ig/zxKPjsFv4/vvfbsmwQBn0O3seUZ0VoB9KmgXK/iWHu5Q
         ccVecD5ZJaGEY3kTtikbE0TvKVtytcaSRTIxyOnlilgmuITRmrOhUGGfIOFUUgih3v3a
         9m/p+9F9x1XyoEwijSWQtfz7/rTOFJfyvlGQYCE7n3grH/4QavPbl8gZjroU+YnuKDiv
         9ZTjP6QltUHGGhQxG6ynUVaMDLgUzSVCLDLjg596tXN0iBO4KCvqcaj9Mv2kuWLgl7ev
         WQ3w==
X-Gm-Message-State: AAQBX9eXtvtqptbmMIa5OyvcIAAM6+V4NQKxZYmGzmqUyk0E+iqpZc0f
        gCGOrBVUa4/l3QGP7gASSdiNqQ==
X-Google-Smtp-Source: AKy350bVl9nCxCIg/cC2I6S/Kr1LzGtEnS4bTindm15Jh7tvtqQmZV5ORAHb+zAA52IBp2P13iHSNA==
X-Received: by 2002:a17:906:cb98:b0:931:73d:4cc3 with SMTP id mf24-20020a170906cb9800b00931073d4cc3mr13061245ejb.11.1679926471484;
        Mon, 27 Mar 2023 07:14:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm11273339ejb.198.2023.03.27.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:14:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/5] arm64: dts: qcom: ipq8074: add compatible fallback to mailbox
Date:   Mon, 27 Mar 2023 16:07:50 +0200
Message-Id: <20230327140752.163009-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 mailbox is compatible with IPQ6018.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index fe37dcdc52c8..84e715aa4310 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -686,7 +686,8 @@ watchdog: watchdog@b017000 {
 		};
 
 		apcs_glb: mailbox@b111000 {
-			compatible = "qcom,ipq8074-apcs-apps-global";
+			compatible = "qcom,ipq8074-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
 			clocks = <&a53pll>, <&xo>;
 			clock-names = "pll", "xo";
-- 
2.34.1

