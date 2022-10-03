Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882855F2EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJCK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJCK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:28:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E72497C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:28:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a23so1610464pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vwTz/shfVewcrDBvcSjpajC//P90vkQhNtpNZ6DDe5A=;
        b=yj6HwP5esn+I50lkL5E2w0oayFCvorxGV4H3QvW3nqLSELFte78H6CyJmJFJmSCQZF
         rdLII6j/UFiolYCyXGtBKuP/ZZ7FU9PgLeX/HXEbPf2oZW9AkKupV4kEBqTKCFvBkeki
         7LobV/AZWjuKcNblXVrioNI5ar3PUv3rAAs1e1EsZJsiHOUU1g9BVZLnGco3w8ffJtXf
         UGuUHHLi8pyQ4Ix2fb7vHzkKVFPLoSe02/2ttcYyQTn0uZ8uLz9KoeXFO6kFlfauwXYx
         JpC9z9G9mpdtYGgvFTyhKPlPLlqZJqwET9OqJ9sRnq0mqb1nLXQyRsT3TIAnwiFWZfOf
         2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vwTz/shfVewcrDBvcSjpajC//P90vkQhNtpNZ6DDe5A=;
        b=mKZ7KsKd6nLfYCBcw9y6fBAR9UTu8xbUQ1YR6aZJs/jtNUOGLCKC1XwLpwJBGPuwDU
         bmKQBQ/dtyLPrlS/xcs6PYbtxaMjFJA493xKF3LSB81ybtpGmhcCFMSs8wPo9zunFmfp
         SRl1amBxPwZEV31N3kzKqhUpPsuwcU2958WLgyv3veIZC04ARAu8wooUjiXBVBVArMMD
         ygQuZTtgN2tn89zjFJqDfL/w56HsIZ2jgaNEUr/OIgmPQS64mwWoExIY/dvKmE/Z8Wmx
         PUc4D3uEr8vVOT3byO/hjXE6wovuZsTLRCFmDbPMOQpI8H8mWldCDrM1sShILRGHZalU
         YuuA==
X-Gm-Message-State: ACrzQf08jUF2Qh7lulEZEC/lvdcr9q3nG/QUwYUnOWEalioPHnfq3nE3
        rKEkF2BgD59zkhPzNIlVpTdEtvgTBxIVQ2uR
X-Google-Smtp-Source: AMsMyM6BRtr0h4ck7dIeqAUby/GmyRQ7aZ74UiNeugdFxz/161OPtngBUffa/PAMRFoe0wlTLs3nQw==
X-Received: by 2002:a63:2a82:0:b0:43c:1ef8:4093 with SMTP id q124-20020a632a82000000b0043c1ef84093mr18261616pgq.251.1664792894115;
        Mon, 03 Oct 2022 03:28:14 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b00172951ddb12sm6860249plr.42.2022.10.03.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:28:13 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 0/3] Add LTE SKU for sc7280-evoker family
Date:   Mon,  3 Oct 2022 18:27:33 +0800
Message-Id: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v6:
- add removed pinctrl and align touchscreen label with herobrine board

Changes in v5:
- new patch add touchpad and touchscreen for evoker
- remove unnecessary whitespace
- Touchscreen / trackpad patch new for v5

Changes in v4:
- fix typo in tittle and commit
- remove change for trackpad and touchscreen
- remove change for trackpad and touchscreen

Changes in v3:
- none

Changes in v2:
- none

Sheng-Liang Pan (3):
  dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
  arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
  arm64: dts: qcom: Add touchscreen and touchpad support for evoker

 .../devicetree/bindings/arm/qcom.yaml         |  5 +++++
 arch/arm64/boot/dts/qcom/Makefile             |  3 ++-
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  | 14 ++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 15 +++++++++++++
 ...er-r0.dts => sc7280-herobrine-evoker.dtsi} | 22 ++++++-------------
 5 files changed, 43 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (95%)

-- 
2.34.1

