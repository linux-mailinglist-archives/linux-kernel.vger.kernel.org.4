Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97322607581
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJUK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:56:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35425CDBB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:56:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f9-20020a17090a654900b00210928389f8so6344849pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7fcvrE1BvqWs8Ve2suGBYVJ5y1iMJPXMU/J5Xu4wR0=;
        b=Lv1gkYwuYjUDyFpYbTZJ4OuDrjsyWSEjwXdreZab8eK6JrSnz3c4Xf5Q3wMvtoNjiR
         uollZWggI6wCsnupHGsGKw9sv9MqxJx7DZvhiHYhEalEAoI+TO5vb+VSM8Lbng5BD4ob
         vW/F+zLaI2kURlv5IZyGaD7u2vSDqK5b/J/zbXJIW20mQU5R9db1Wh/T2xjTV8u8LRDP
         8emFH6NMX2LG8bIvTU/pZgjgij4SJxZh/wgBHRvdDFeQ1mV45aJ87tdPpu/uFmWi7G6T
         1F7+FMPvU4UV4SVgU6BsWNKZ7q3Qnxg0tI5dyzKmn2ZB/dpcLoI3IcGTRrKikN+NK7vm
         PwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7fcvrE1BvqWs8Ve2suGBYVJ5y1iMJPXMU/J5Xu4wR0=;
        b=6c79qF9rpmtFa8oGYwJwyL4UqALC9JavQBwd9I8OCfg1b7ZXf7szLjDrn3oo+yV1kY
         L34uwEOiQrZztZhuiH0RrapahJG0aAGvIfS2dhRGKNAP0srLpkrNA+aPeIkvZ6pP3JDW
         jwi+442ZUlXrefT8gpKjXqQ5JXiXcAgRmjY4X0efALjI1MRp/x30o/noVcBHiAEl40H4
         vgeD66hsZ2lahZAwr6QGCgf3Eyg05T53D8Cz65NKOM8m1WwTjfQqAEFh1VbmhnKmY4f4
         0vo+O70Hy/NUb6nAZu02+89JRRRx1ElvhY1gjpNSizgD1LOzANyAIEf7PJGu46o++xKN
         pdYg==
X-Gm-Message-State: ACrzQf0qR0++Yj5TI3EBs7/OFZ2FgxcLku2j6UD7IA3mbBKoFD3Ae5g8
        3bHgLCM3O1R+vb28XKg/sFDtsrhip0A6cw==
X-Google-Smtp-Source: AMsMyM60Eq4v6d3CvvovFeCd89nRBD8VnZ1hOrwML/oo0VKKGoC/+kmdRjS90j26oe8QTO4mq6C9xQ==
X-Received: by 2002:a17:90b:2705:b0:20a:b4fa:f624 with SMTP id px5-20020a17090b270500b0020ab4faf624mr21498742pjb.124.1666349806257;
        Fri, 21 Oct 2022 03:56:46 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (2001-b400-e339-bb7d-a809-3af0-ee98-4fc4.emome-ip6.hinet.net. [2001:b400:e339:bb7d:a809:3af0:ee98:4fc4])
        by smtp.gmail.com with ESMTPSA id 2-20020a620602000000b0052d4cb47339sm14822957pfg.151.2022.10.21.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:56:45 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 1/4] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
Date:   Fri, 21 Oct 2022 18:56:20 +0800
Message-Id: <20221021185331.v8.1.Ic800ee7b604bcb0519ca404600d7be2352725686@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021105623.3520859-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221021105623.3520859-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evoker will have WIFI/LTE SKU, separate it for each different setting.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- fix typo in tittle and commit
- recover change for trackpad and touchscreen

 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e282602064..04928ca8cd556 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -592,6 +592,11 @@ properties:
           - const: google,evoker
           - const: qcom,sc7280
 
+      - description: Google Evoker with LTE (newest rev)
+        items:
+          - const: google,evoker-sku512
+          - const: qcom,sc7280
+
       - description: Google Herobrine (newest rev)
         items:
           - const: google,herobrine
-- 
2.34.1

