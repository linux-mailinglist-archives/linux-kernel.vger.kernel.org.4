Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17F5F05D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiI3HiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiI3HiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:38:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750C1F5A39
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:38:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so3489684pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=c8cSDxaoc+Bwbc6lxhsGSESz1SuPfGrG+FUcw6yQ/oM=;
        b=aQNGJGokDXmOp/q10VSxiouxd37Pc19eHXcMvvbKpeJojCPi/3Xn4AqsdE80ed8iZy
         tyugOLljSxGiIeLiGML3y5ocQxo/2/OnPd09GtYeSvTafh655iM/O+mIg7FDp6XiYdhQ
         NHhrrwZYrC/GXtp+Gqs1svqRQf8k2gUP7gZYPD4B2zKQTTVoCWEecMogHyzwTrhpJYCM
         CxeCGBeJuIRj3131zpeAS0dEWWt0oq9e3Wgiw2OXmK2qkNa3m4Fp1lhA6EEhG7v8+GKP
         mpoNWQyDjL7sPMA1lNL21YmYDW/sCGv1q2TJbpP4rWTOzQTkJHNU6tMaTlz4w6vlgptl
         7u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c8cSDxaoc+Bwbc6lxhsGSESz1SuPfGrG+FUcw6yQ/oM=;
        b=XMY5Va5Bt+L5og8tHrtfluHo8WWRTaQinjGiI+nei1xvIoUHb3k1xleGYtVUcZXrEu
         PBRBEBZdpdXVwe4dcWAnOuW6xCRbJqIRVFLBFt+7yYHvBM1BXWErKU2KJRZScCN5ODzg
         zvEu9PoWgp5xjw3/uMkLbSv+ZetZ2VD79QWTJBZ6aBb6hZn1e3EcaXKt86Pb/ZPGpb03
         S4+BN7cvZR+t3yCMutCXK9P/z6qQzhOcqrOcXY1ssjKaafE+dj6rEKQbxN7RUepe1zjS
         Vi4LVHr86L5So7693bCR7BAB0OxyrocXod10EuaCS8878bc2LCZJjtpwjI5SiPmGuo4s
         LFjA==
X-Gm-Message-State: ACrzQf0PvUCcmKXrX83YWMZ0HAn/ABF9dNbJpekUHhzmgNt6K6GUGnP7
        ULK6pQHv8VrNoyp5rjAITVqOrlyvmGUDqTqY
X-Google-Smtp-Source: AMsMyM5lennRdw+b8Ndqaqu5CYeSBrEn2mbncHCY3LWvEZM9dVDcmSN1NEIUnVlXMEd2greTNpmrBQ==
X-Received: by 2002:a63:b545:0:b0:43c:2ad9:b00 with SMTP id u5-20020a63b545000000b0043c2ad90b00mr6366407pgo.535.1664523479991;
        Fri, 30 Sep 2022 00:37:59 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902ef4800b0017ba371b0a9sm1166132plx.167.2022.09.30.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 00:37:59 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/3] Add LTE SKU for sc7280-evoker family
Date:   Fri, 30 Sep 2022 15:37:51 +0800
Message-Id: <20220930073754.1391044-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v5:
- new patch add touchpad and touchscreen for evoker
- remove unnecessary whitespace

Changes in v4:
- fix typo in tittle and commit
- remove change for trackpad and touchscreen

Changes in v3:
- none

Changes in v2:
- none

Sheng-Liang Pan (3):
  dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
  arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
  arm64: dts: qcom: Add touchscreen and touchpad support for evoker

 .../devicetree/bindings/arm/qcom.yaml         |  5 ++++
 arch/arm64/boot/dts/qcom/Makefile             |  3 ++-
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  | 14 +++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 15 ++++++++++++
 ...er-r0.dts => sc7280-herobrine-evoker.dtsi} | 24 ++++++-------------
 5 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (93%)

-- 
2.34.1

