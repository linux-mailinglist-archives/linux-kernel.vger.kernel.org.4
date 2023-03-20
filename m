Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCF6C2468
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCTWRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE43400C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679350596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/pYp/+TvIZEdbO864hX1ZaEe6NV95MuM6NldpNo+j88=;
        b=Pr907x99p8cXhsmjCMDomakKJWq1FiX8YUXtpZCrp1bFPDvw/7lZXuL3Gb+K6CBpt6XRg8
        Phvpmpk43RyxIUhNHQ/uvUjtbXGU33y7rhG7sjQdlaxuzj7CaIA2OvfIR+w/UbaAXPsdi+
        CJUxpAWSEqDX6YzQm1Rmz1v7H3wWQ4s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-m7i3dFlXOFm-_J37QCpTww-1; Mon, 20 Mar 2023 18:16:33 -0400
X-MC-Unique: m7i3dFlXOFm-_J37QCpTww-1
Received: by mail-oo1-f72.google.com with SMTP id w3-20020a4ae083000000b0052645d4a2dfso4057743oos.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pYp/+TvIZEdbO864hX1ZaEe6NV95MuM6NldpNo+j88=;
        b=s/DfHhVSGc+B2LWtGgz4l28Iv0m53ffaSvFSaDZyhs+SecjmqAbwkkO8yhXIDW9JXC
         Du0jxzSlwkOB4wIqBLacI6tiBe6pEEb7Yac7w0iFVoNnhExF0RvSTzeKbvnnlOorQSXY
         XFzr6tgZBiNKt1JMPQWXqhkldEoDb1oVlo/5If/tl4XM+AK7K/5zh0yL6BUlqydJ8Cnl
         2ep3/2LIs5AuQkTyHQbF3E3bFlvYwiZ4kKJTm6WOlr9JX8/PRaTGBt7KuM170pO/+yqy
         1LkSUMrwcZdGpOpZi1LktMawAwLQil6UP16/pDiMVSsEk10wgEIASaNDr/9ZUBdu/yBJ
         H6nw==
X-Gm-Message-State: AO0yUKVr9afr+BkwbU0BnZDi6ok+LyrmBV00wZIshmuKNA9yXJBOXY5k
        rk+Yqk5Vyd//DEavFu4TbyDlOHWqGw9ZvpgeVB2zOzyTxLQThhadfhe7R1Wrx5YIJr1z7VMCT0k
        ltqcvztt03JVd9a1RWXQ3SDqsgLfKNYVvbhEZF4zYfEJxE4avKETlFS+b1a7YIMD63bx8bHFOUg
        f98emnSroFdxk=
X-Received: by 2002:a05:6808:10c:b0:387:117f:f7fb with SMTP id b12-20020a056808010c00b00387117ff7fbmr25046oie.20.1679350592251;
        Mon, 20 Mar 2023 15:16:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set+FD0dDk0+dvXSvybPdytDkBKj3L/oyZtE72xtPkWildC/DlDoAUTQxy/hAD04b7A6y0cPDLA==
X-Received: by 2002:a05:6808:10c:b0:387:117f:f7fb with SMTP id b12-20020a056808010c00b00387117ff7fbmr24984oie.20.1679350590464;
        Mon, 20 Mar 2023 15:16:30 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm4092465ooq.8.2023.03.20.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:16:29 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 00/12] Add EMAC3 support for sa8540p-ride
Date:   Mon, 20 Mar 2023 17:16:05 -0500
Message-Id: <20230320221617.236323-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a forward port / upstream refactor of code delivered
downstream by Qualcomm over at [0] to enable the DWMAC5 based
implementation called EMAC3 on the sa8540p-ride dev board.

From what I can tell with the board schematic in hand,
as well as the code delivered, the main changes needed are:

    1. A new address space layout for /dwmac5/EMAC3 MTL/DMA regs
    2. A new programming sequence required for the EMAC3 base platforms

This series makes those adaptations as well as other housekeeping items
such as converting dt-bindings to yaml, adding clock descriptions, etc.

[0] https://git.codelinaro.org/clo/la/kernel/ark-5.14/-/commit/510235ad02d7f0df478146fb00d7a4ba74821b17

v1: https://lore.kernel.org/netdev/20230313165620.128463-1-ahalaney@redhat.com/

Thanks,
Andrew

Andrew Halaney (8):
  dt-bindings: net: qcom,ethqos: Add Qualcomm sc8280xp compatibles
  clk: qcom: gcc-sc8280xp: Add EMAC GDSCs
  arm64: dts: qcom: sc8280xp: Add ethernet nodes
  arm64: dts: qcom: sa8540p-ride: Add ethernet nodes
  net: stmmac: Remove unnecessary if statement brackets
  net: stmmac: dwmac-qcom-ethqos: Respect phy-mode and TX delay
  net: stmmac: dwmac-qcom-ethqos: Use loopback_en for all speeds
  net: stmmac: dwmac-qcom-ethqos: Add EMAC3 support

Bhupesh Sharma (3):
  dt-bindings: net: snps,dwmac: Update interrupt-names
  dt-bindings: net: snps,dwmac: Add Qualcomm Ethernet ETHQOS compatibles
  dt-bindings: net: qcom,ethqos: Convert bindings to yaml

Brian Masney (1):
  net: stmmac: Add EMAC3 variant of dwmac4

 .../devicetree/bindings/net/qcom,ethqos.txt   |  66 ----
 .../devicetree/bindings/net/qcom,ethqos.yaml  | 111 ++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   9 +-
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     | 181 ++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  53 +++
 drivers/clk/qcom/gcc-sc8280xp.c               |  18 +
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 161 ++++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  32 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 235 ++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  | 334 ++++++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  38 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  | 144 ++++++--
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  29 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  17 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |   9 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |   4 +-
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h |   2 +
 include/linux/stmmac.h                        |   1 +
 21 files changed, 1196 insertions(+), 258 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/qcom,ethqos.txt
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ethqos.yaml

-- 
2.39.2

