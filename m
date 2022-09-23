Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA65E73DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIWGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIWGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:18:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8B124C12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:18:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a29so11477514pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=f05ljLlUO9sOr4KvcyD5u6idMugfpqT7D62/tn0sbO8=;
        b=pAvhqToInZNWXhG5z96xzXs+MzZS5uqkxvSry9ySyYz+8JEQ2tND181S0DlMybrFVF
         w9mQcz4K1+mUBdiR7jMk1OgouLtp3SIbWTIdJAuInKMUMlC3zgcqfadD9bthLMIhcxJV
         NlWa43k4iW9B685LT1MgSDhmG2HVZp50lFSWPmGj9tI8hYXuCiRtHIa6zpmH+mPXyeO3
         GJX0ozoHvatgXFpit87GcEYn4y2HqDv++gZQKG3CgMwqShpYwfCHUrWCLAt0bPT0diZh
         dZgixhDbnM3FuGLYxWY62s/n25z5NY1wYDP+6ZFzWhlGsgpB4WJf0D1iZKYaFOtQJsaU
         WJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f05ljLlUO9sOr4KvcyD5u6idMugfpqT7D62/tn0sbO8=;
        b=y6E051RPjxFceFt/dYTxhv7zcjkB+vgH+kX0SB6H0GP4a9I7Lo2+L7jUka3qAEJqWu
         1oia/GtiCNHrL0eSWxNU9O65H7BdY6ggf3dHK3r7+SEH+8fMZgTuxadhXOraEykAzbBU
         DYrMdAWEubpSW0/uJOPL8rzmfXJjZ3txBbGoAgrFdgfecVbS+TC7OKRJTz63dW0vCgT+
         vm7kXVORIWAPnzAEcxkCQUBMH3lKKGyETva6L0n7/Aj8dgkzJKhGgb2DHd4dPzGkpIZq
         CkQVOuk6A1QPtjtA0BK5JotYoj0Gkr5Fm3Cms7H2Wxegk0wTukuZfF0Az7JB8hHqLeqx
         KTuA==
X-Gm-Message-State: ACrzQf2NOj4pGJNAs8Z63ntD5ZhjsZGZ+DxVRTDsVVxJzdooZbcMzvVA
        VE0h18P0QzTsH/qE5T+nTfrBJdQEGqSn9A==
X-Google-Smtp-Source: AMsMyM7Yk+O5UM+vUUWL9QNeCbgNalG8zHkQHUtJtwzxGXbiqGa6c/4GNh20lsyAoFvR3tRsLjTxOw==
X-Received: by 2002:a63:ff4f:0:b0:439:61d6:197 with SMTP id s15-20020a63ff4f000000b0043961d60197mr6165593pgk.67.1663913887935;
        Thu, 22 Sep 2022 23:18:07 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c190-20020a624ec7000000b00540f3ac5fb8sm5515248pfb.69.2022.09.22.23.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 23:18:07 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/2] Add LTE SKU for sc7280-evoker family
Date:   Fri, 23 Sep 2022 14:17:54 +0800
Message-Id: <20220923061756.2557403-1-sheng-liang.pan@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

This patch add common dtsi and WIFI/LTE dts for evoker.

Changes in v2:
- change Cover-letter tittle

Sheng-Liang Pan (2):
  dt-bindings: arm: qcom: Separete LTE/WIFI SKU for sc7280-evoker
  arm64: dts: qcom: Add LTE SKU for sc7280-evoker family

 .../devicetree/bindings/arm/qcom.yaml         |  5 ++++
 arch/arm64/boot/dts/qcom/Makefile             |  3 ++-
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  | 14 ++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 16 ++++++++++++
 ...er-r0.dts => sc7280-herobrine-evoker.dtsi} | 26 +++++--------------
 5 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (93%)

-- 
2.34.1

