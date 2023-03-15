Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935E46BBED1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCOVTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCOVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:18:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670F1C5A4;
        Wed, 15 Mar 2023 14:18:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn12so20296815pjb.5;
        Wed, 15 Mar 2023 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcbadi4LHnNl9v6BB5vI5hfKPMXT8EmjVagT497j48w=;
        b=azPPRZdmIadaQL+HcQC0VCZN780tRkHWb5C648D7kxCoeQKAe9ifIXfnl/USGsYt2T
         79x3PvUHrBbEq1LDxEQBEM05wmWdOsuecJWqxY+sU1JjoVnQTv+oVRUHlxiSv8YwpGP9
         Uw3gMDpLZ3lHxPjR2ANcqByVnHkSGH9IWSykssxmFKrF1lSfecegwq2EBANRgMGT4JnN
         5uKmIQYPmh+sq1q/NYRFEnEUZN6k4VXmT0i+0AuZ4qWezm1NflRqIZLn+P9IyIyfz8SZ
         pPOSyO9bxNSbcHxelLth4HwWolOgj9NJYZo4K5YD6KZbYW9Cq7GVJ91pBtNs/7DEe2CH
         5CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcbadi4LHnNl9v6BB5vI5hfKPMXT8EmjVagT497j48w=;
        b=sz4NXlgh81eWgOXUehlkirFAKn8n7tf4myJ+mkhM3u+THLThAd0RiCpv3XPvmFlz/s
         Rc/rI0x11ONQJBkbu406FceaUDNljWA1SimfPaNmzFiXTtA2R2scDUmf1oWgU+Bb3OVc
         cOXhmwVzsUnrKo5ZFRmS1etCzPclU3pIIGOpY7ra7y9D5fpsQxekIVD7Yoo2P2M6vUch
         QsWPEbsjcIRERV+Fv5Hczzw5Q9VMWPa9cVVgX4d3oe2gs+sqAeHY/oi9Al74bk9tuMzz
         rOMNPo4Zmhhl/RWT/mivsa5xxeuKIHAXdaZO0L1zS4VjtkVwlArgzKvw1FrOk/hzhe9z
         XQGg==
X-Gm-Message-State: AO0yUKUO4g7BiFd8JMOAb5V59FY7/O2bO6+7spFbH4g0lRWvezTCSfFt
        XvzFSeM1TjIqdntLfk3EBlc=
X-Google-Smtp-Source: AK7set+GGbc3V2FYuUvRcQG8mWp6MgEdFmH5gsq5boNcL/JLMDJMf3VklXqUeRlNqQDmdKwE+auxQA==
X-Received: by 2002:a05:6a20:3c91:b0:cd:238f:4f4b with SMTP id b17-20020a056a203c9100b000cd238f4f4bmr1371413pzj.23.1678915089113;
        Wed, 15 Mar 2023 14:18:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b005897f5436c0sm3981695pfo.118.2023.03.15.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:18:08 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add CRG driver for Hi3798MV100 SoC
Date:   Thu, 16 Mar 2023 05:16:19 +0800
Message-Id: <20230315211628.963205-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch
v3: fix bindings commit message, reorganize patches
v4: add ethernet and gpu clocks

David Yang (4):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  dt-bindings: clock: Add Hi3798MV100 CRG
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 612 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ------------
 include/dt-bindings/clock/histb-clock.h       |  13 +
 6 files changed, 631 insertions(+), 405 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.2

