Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA75D6B1EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCIIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIIvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:51:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF8D5165
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:51:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so5287394pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nbaEHflVZL5dlWTuN5W+WJeZFrR+YCDbALQzvFDeUI=;
        b=xZl4xrCphaclVvOHH9SHYkNDGZzHVT5svIUNpTkKZKGy+C36y3iykpnD+CqmukAkBb
         HYocbnskA6QMYwSxXxMxvlB47uZAToJBYKORSZ4aE58Nfppj8Jt/01RzxloIb2UZ/YnT
         diYgOF0+rWcBZ48l76pssyY6AVWLXhZIQjtCkSLumZa8C0u9xWxj0/qbVimG03DLmVqf
         +m6z+FXW4zhrOgcOpQ4fCqRgczFGI3g7baoxOWF86auzC+f52joxbfdquosOaIs3ja1Y
         2Y++MImluC+VTPKnxSjt4OSr6dZ4CiB4l1oeJtR2/9gdk9OLImpOnexDGrPu9yZSTGaH
         h2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nbaEHflVZL5dlWTuN5W+WJeZFrR+YCDbALQzvFDeUI=;
        b=z3YbwWTjE1sExkP4WbR5GWK0M39BvxzWTnEgBokVHr3TyqoVMlizOUeIYcfYa2EsBD
         IxUUWgtzb9A70W8Fyi0JqyfdEc2bu/eNpL/hloIWPXKUOKNGV9rG0ReQqFpcXyevFWAJ
         HbW2/F1Wmcto/Rs+N8cthrskJ+ReXEMPNxcnjEtvz1AW4kbRX+M4Rw3dDqR/iqKrf1EI
         otV7qQnwN427wvQMLYIqat40seDPPgZw6KupKDZN+K5vJ9FcbRlkWduvWh97gzr58Z4n
         YYvAvt7EH31MLm0Vd21e30t6kVbHLy2bifODaMNBuaqvQYjpv4qZ1JSezCgqPqNAwS+J
         hDUA==
X-Gm-Message-State: AO0yUKXEYxgocqqPnqU7Lz+QuLMh2rwl2sR/JEUHBCQgsqYZJBU5Dm9c
        TDeiB9FW7Jzx1GSy16rXNh+S
X-Google-Smtp-Source: AK7set82hGbpx0oe2f74RDSZH8c4Rcay0qoYAsa2LxwmhOCetZDxXPeGGrEUQM/rFYibcyCO27DzPA==
X-Received: by 2002:a05:6a20:6a03:b0:cc:f9f2:3034 with SMTP id p3-20020a056a206a0300b000ccf9f23034mr22471322pzk.40.1678351872382;
        Thu, 09 Mar 2023 00:51:12 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/17] Qcom PCIe cleanups and improvements
Date:   Thu,  9 Mar 2023 14:20:45 +0530
Message-Id: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series brings in several code cleanups and improvements to the
Qualcomm PCIe controller drivers (RC and EP). The cleanup part mostly
cleans up the bitfield definitions and transitions to bulk APIs for clocks,
and resets. The improvement part adds the debugfs entry to track link
transition counts in RC driver.

Testing
-------

I have tested this series on SDM845, SM8250 and SC8280XP based platforms.
However, I'm counting on Qualcomm folks CCed to do testing on older IPQ/APQ
platforms.

Merging Strategy
----------------

Binding and driver patches through PCI tree and DTS patches through Qcom
tree.

NOTE: For the sake of maintaining dependency, I've clubbed both cleanup and
improvement patches in the same series. If any of the maintainers prefer to
have them splitted, please let me know.

Thanks,
Mani

Changes in v2:

* Moved the "mhi" region to last in the binding and dtsi's
* Dropped the patches renaming the "mmio" region

Manivannan Sadhasivam (17):
  PCI: qcom: Remove PCIE20_ prefix from register definitions
  PCI: qcom: Sort and group registers and bitfield definitions
  PCI: qcom: Use bitfield definitions for register fields
  PCI: qcom: Add missing macros for register fields
  PCI: qcom: Use lower case for hex
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
  PCI: qcom: Use macros for defining total no. of clocks & supplies
  dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
  arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
  PCI: qcom: Expose link transition counts via debugfs

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   12 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   25 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   10 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 1009 ++++++-----------
 5 files changed, 402 insertions(+), 669 deletions(-)

-- 
2.25.1

