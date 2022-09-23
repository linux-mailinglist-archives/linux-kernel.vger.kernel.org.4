Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26715E778B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiIWJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiIWJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:42:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030EF186F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:42:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so11274410ply.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YgDH86hPc16pB2oMIGUw4voP7vAQRlty8oK4VOR6rgw=;
        b=sztWpYlthp/N0cpALMmSKQB3SDLeivDBB+R24iLWIvf7rDk4wDnhyEqnnJ/HzSgVaM
         /Hni5MtH1TyOhAX0xxzghjjsBf2UK1UOL7C4dag71jglJ3RPk/V15dJECDtgyt+mUOpD
         YTkfzoVSJcxXZYg9UPhaDzIR5WPJeL3VtQxRzBV2iOqSS2/4sdqxigfc+V8CoMp9j60+
         8Gld02UPhBQMqzAbJ0pcPucHu4fvjqvcIHUs6zLorW2jhtSn+q5+AHgjz0Y03/w59zkY
         PJU7EJDshQYVP5g6mpw52PBPjsqijIUH3ob4IzN6+VLzNwU8byO3FP5Wt2LqLgusn9dm
         xJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YgDH86hPc16pB2oMIGUw4voP7vAQRlty8oK4VOR6rgw=;
        b=5uqDlRWYGC/khuLqHAw1RnWf8b+ThydisfiPMs7/wfRnjUATLatd3ff0Tv04SJHqL1
         iNMvLbjLKRvZvy8Sid1tG5kpxeawOehSIkKR390OSd+LpvcWbVAby0V71y1bkV6M6PEi
         eYhyI6Vee7GDokHNsb0aFDDAj14OvpWHMlUIHmamqMPIbIDRI1ORilv/49Ub9jFxK9PQ
         gA5pJZ2Pj2iMI1sJqDeqogPgNodDDCYvuXSO4pdHTsVsOXFEhD8CENM8uop+CijEbnk3
         MYqzWwmOR3uPb65uXlTOvxxG5QURcLpUJKT4TPAj/VZWkZEdszsw2kVlZ4GX48YascQl
         3rig==
X-Gm-Message-State: ACrzQf0fuKya6gzP+wIymaawK9kyb2Px0aDmymllmqdPfzpmbiuN6aff
        J7zS6Pbgshl+CegwWww9UiXDikwm47RqMw==
X-Google-Smtp-Source: AMsMyM46gppCUkC1tPFiij/RtPy+fBmd2x9FC9EFKvUY1JR6pk5oEuZq1oRwjgjs3u/CmCk06082fQ==
X-Received: by 2002:a17:902:c702:b0:178:9fb3:419a with SMTP id p2-20020a170902c70200b001789fb3419amr7851219plp.35.1663926170128;
        Fri, 23 Sep 2022 02:42:50 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902eb8800b0017515e598c5sm5512855plg.40.2022.09.23.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:42:49 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add LTE SKU for sc7280-evoker family
Date:   Fri, 23 Sep 2022 17:42:40 +0800
Message-Id: <20220923094242.4361-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v3:
- none

Changes in v2:
- none

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

