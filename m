Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C15B395B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiIINlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiIINlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:41:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90E89938
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e16so2798541wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/JHla0F35IozkiqQIzTjVO2NcrigeN2J9tZgph/xMOA=;
        b=xYS02JxKcU8z9lsEwG+80y7sOqwKKgMVwCBmJg9JOM60JsMnjHv9V2RuPC7qxs87Om
         tZ4hzIINi+dzyOwyNAEtaC/lVGT7c5dgJ1I18w6s99dPWq2YrtJxwjtvfASjWxb1A2+F
         ZJ2H9l0vCg63xymiqntsVDvt6rE6ooPYoWGAMCTHeZUPuVzaSX9MxxlUbcOqHP+Mwu8Q
         sixBfceNipqP2ccDug6YkH3kFXEJtSYl43g8AUv5FLJpwLUfBughdG6YKbKx0ZzVD6wh
         fzf0/XknGUTc1CWidf21Pm6rLxbEriS9LKgNWnLeC7vR0rkV2FJRkauzgzMXpwqQZQ1y
         gKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/JHla0F35IozkiqQIzTjVO2NcrigeN2J9tZgph/xMOA=;
        b=CB14J3MA+nhX0DQQXa79scq18grkA6VDFwayGmxjcyODdqpZAmSscK7uZzajywx38G
         p5Yhgx1s3er1R/wHJo/prP8SoSJW4+WD6wg7TPotvCy943KtmhdQ3ZUI+/1YKY2yRgNn
         d9ChRWJdCK6scGKUhkVbZdLhATnPjvYYJLm1vM7T2/nKObnEl112MMgPLj94CgBrgmzV
         rU6w1XfgExUocKaPw1XSHAuAILpZAwWCeheACTig9oR5Owsqa5D+4Ne3kN8PgZK0lxTr
         NieEToGeFUbazRxNerepFhsqgGSv8toayX1yke3D1raXFqhGq6DUpQX5ChKd6dKMuvWZ
         ECZw==
X-Gm-Message-State: ACgBeo2uYsF8vcLIsCM1xZiJW59XOYACbJX/f4CaSztLcvmEh0dPCvip
        qjGUDGbo5vQjoVPNb4AOvvM/HQ==
X-Google-Smtp-Source: AA6agR6XWBSpwXLYjMZyN5U5ayd2lacGsWUZoiyhYHBfQziKSJVbUVNcgqqnvTkFCv3EiK5ZvzO4bA==
X-Received: by 2002:a5d:4285:0:b0:228:6321:c6e with SMTP id k5-20020a5d4285000000b0022863210c6emr8082125wrq.433.1662730842211;
        Fri, 09 Sep 2022 06:40:42 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:41 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 03/10] dt-bindings: misc: fastrpc: Document memory-region property
Date:   Fri,  9 Sep 2022 16:39:31 +0300
Message-Id: <20220909133938.3518520-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory-region property to the list of optional properties, specify
the value type and a definition. This property is used to specify the
memory region which should be used for remote heap CMA.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * addressed Krzysztof's comment by specifying what's the use of the
   memory region

 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index f25924d33fa9..62c8a553b120 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -27,6 +27,11 @@ properties:
       - sdsp
       - cdsp
 
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to a node describing memory to be used for remote heap CMA.
+
   qcom,glink-channels:
     description:
       A list of channels tied to this function, used for matching
-- 
2.34.1

