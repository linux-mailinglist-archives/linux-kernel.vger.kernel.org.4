Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD7670BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAQWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAQWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:42:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361595D91F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so21404967ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti+F59dwmnBVoTf/TrsKke+wcsbpbxaJrIFqVhERiI0=;
        b=C5TrC53PHhrt4Vb6IDm8yVvw8vSb8dmZy4pvQkwkA2HIgN0L0wf4u35P9oiqei3XBk
         D8heP9Hjk3gfrhSeeK9a0p8cFc7HWdlOANH2mmUj5LB0wqTSSyvxP0fDEXqRAEmXzsHr
         VP6R0CXufDBjiCMHFczquqXTDrCiWS/nWhpCm+jOrmyVHa5CH/V9rl8V6Gmq0goGMKE/
         AizBwooxHuUJ2y+Vy/L8+w8OGuhdxar31ubnVow33JlHxzoYCut6SR5AqJawnN97plWM
         LYiWXd8zsrhVv9/j0K4boWKG6urumT0Igv5slT0I1hVt8ytq/0VLHtUIyncn8XU7T0xH
         bgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti+F59dwmnBVoTf/TrsKke+wcsbpbxaJrIFqVhERiI0=;
        b=3ZxwQmovMhNUqk7/QLL7fjL6A/DKKD7Jm7HZ+r7IzJyxUUHFV9rHlNyef4iwVVQlzr
         /dR/uBHaA4q3HQN7tmmZn9rd/VbqMpMK83MexaWJ1XoXv5b4LZdeM3jASdxjLAArr+3Z
         ehogNcPfsqZHHCu+Vntf0ichvJ+4tGY5gTitLPPST076LDFwhc/p+JpD74fLHPuMwH4t
         piU4wXAJzJMZP9tiVvBXTuWFTblJk6B3tCPRLRmrxera0X1VSp+cnJVPQcqYLc3nfsRY
         xunYk7MDnv9zY2HWc0xUkmlcVQPiGKDBNEng4J9KqrU5lbEWC2VlREl1M3Zbocyqa3w+
         g+Pw==
X-Gm-Message-State: AFqh2kpIhoc7ZKeutB18kJaP7OVtj2wlTt3h/RIpzxIVzxYmcZZEWjMN
        M3Du4XRztq1ge6qRhlI47oABPQ==
X-Google-Smtp-Source: AMrXdXvSrv2OQ9UaAFQLdEBJeB8/jVPapHDhn3u9mCTsQiiU2bq+TQfCjA4YIXMkxapfLx9sS40ARA==
X-Received: by 2002:a17:907:bb92:b0:871:89d:75e with SMTP id xo18-20020a170907bb9200b00871089d075emr4961117ejc.16.1673994614735;
        Tue, 17 Jan 2023 14:30:14 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ec20-20020a170906b6d400b007c0f5d6f754sm13835189ejb.79.2023.01.17.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:30:14 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] clk: qcom: msm8996: add APCS clock driver
Date:   Wed, 18 Jan 2023 00:30:07 +0200
Message-Id: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_apcs_aux clock can be used by CPU and CBF clock drivers to drive
those clocks from GPLL0 while doing initial setup. Add simple driver to
setup and export this clock.

Changes since v2:
- Added the conditional clause to schema forbidding usage of clocks and
  clock-names on platforms which do not pass additional clocks to the
  APCS device node (Krzysztof)
- Added SDX55 compat string
- Moved MSM8976 compat to the list of platforms using syscon.

Changes since v1:
- Removed the clk.h header inclusion (Stephen)
- Changed the module license from GPL v2 to bare GPL.

Dmitry Baryshkov (6):
  dt-bindings: mailbox: qcom: add SDX55 compatible
  dt-bindings: mailbox: qcom: enable syscon compatible for msm8976
  dt-bindings: mailbox: qcom: correct the list of platforms using clocks
  dt-bindings: mailbox: qcom: add #clock-cells to msm8996 example
  mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
  clk: qcom: add the driver for the MSM8996 APCS clocks

 .../mailbox/qcom,apcs-kpss-global.yaml        | 37 ++++++---
 drivers/clk/qcom/Makefile                     |  2 +-
 drivers/clk/qcom/apcs-msm8996.c               | 76 +++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       |  2 +-
 4 files changed, 106 insertions(+), 11 deletions(-)
 create mode 100644 drivers/clk/qcom/apcs-msm8996.c

-- 
2.39.0

