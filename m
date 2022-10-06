Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421C15F64A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJFK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJFK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:58:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27E9A9E2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:58:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 70so1425676pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjvc6KvX1lZgQ0h1CLOFlzzmfsAs3MjCO/T6JD8d9jU=;
        b=nnyh33Tw6QiA/+QgG+C7ZXp/zsqRgaVsurGHWgCZhHSklzVoTkFxNgjxWZDPiQKeEy
         XM3c5HtzjgWBcCsMlPFT6D6ncVqq8rlerNUqQRDPfPd8elLjvzboSo6hrkUx7o+qIDRy
         zf/GQr+IPaH3N5Xjei0qoAfTU6VsR3UmCOiR307G5W5OCq8bltvEXDzCW70DxLu6uxtt
         GBibhHYcVpqeygNiQe7JXkaPkbZNErc80YT7AXjhy81j/ty0Z/hYXqHFD8JsyRX44SYk
         cKB9oJvA5xFlZwPyrEtUUyyEY+BRh1j7DKHRSTOWNgXKGLe5s0jwt7L7UuL9UL1m9eyZ
         RSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjvc6KvX1lZgQ0h1CLOFlzzmfsAs3MjCO/T6JD8d9jU=;
        b=uKO2h0NDoos7eENidigKM4+P/cmtG0AlX4nb/Zkh9kM0ec7x0LDPDgSKmGAzd5kPGP
         omqLsmIbw4iJ9xBw/1AbIihXYF4QeO/FytgghV1mc5DKkG9HNUvhToK4IOsN40pObFfU
         NSoKqZFNk3eSKH9W8wcp+dCvfIgR929VBucucS3aQif99xJwJo+J9XbEnSdDf4bvMdOF
         N1vF+rETCNrvp4r1iyDetFwPY8ypwSdFxAJr0Fw2vob7HQ0VdF+DpNhH979X0MTCh2th
         rHUjPf3YyiYVrjUjamgifCvBloDx56Z88+SX0E8piYfGramXHYAfuazWUhkBT9L0+01N
         EPtA==
X-Gm-Message-State: ACrzQf2/0K+a/rgGg1fi2rKlM/Mxeh8oDxYlkQIKXXv/TaA/SktgYZgl
        eMt6W9IqU9ouqTam9wK3S8G7zdYj/l2txNI5
X-Google-Smtp-Source: AMsMyM5SA5sOyZ6DfeFrw2SlkaEKqEyPfliAkQ6r+5ItAGpIcSOt8cmGVvPjdDID5WIo7DfcDI+7UQ==
X-Received: by 2002:a17:902:ba95:b0:17f:9943:2dea with SMTP id k21-20020a170902ba9500b0017f99432deamr515092pls.81.1665053913502;
        Thu, 06 Oct 2022 03:58:33 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0017d12d86901sm10504297plh.187.2022.10.06.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:58:33 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 1/4] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
Date:   Thu,  6 Oct 2022 18:58:20 +0800
Message-Id: <20221006185333.v7.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

(no changes since v4)

Changes in v4:
- fix typo in tittle and commit

 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8060c35d003b4..c15a729a6852e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -513,6 +513,11 @@ properties:
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

