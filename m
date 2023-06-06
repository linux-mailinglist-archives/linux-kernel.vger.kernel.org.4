Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE84B723606
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjFFEFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFFEFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:05:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511A18E;
        Mon,  5 Jun 2023 21:05:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62615694bb9so40902366d6.0;
        Mon, 05 Jun 2023 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686024339; x=1688616339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYhswQiRt1WsRhH2+UJS4EAOlVs+4YtiTEvdONDNyWM=;
        b=BtHZ1AlOOj/vG4h1Rnh/9nHPW2BHrVUgJvzOSOKj/iM1SBLLQPoT7l0xjaKzdF3z+x
         ThgkPrOK5vFvdtNA+9cP4eb5vdozupnDpmdc5QCZrBCtGqHPnHctWK+wtvX5yow+SQS9
         tqqyCeZcbjOrBmdFGGzgQH0mzfspVNxvtcHmTE0F6zINae5vVyhh6z5213Qv3R6XYzGU
         J+WbrSl79pGKBs9z8u1XliCwQa3oWccz4jIYDczYTJhg7/qBFfIhjezDM8tqSSf2Yazm
         G+g4fbxzrP4giT6INSHqdtL+KaeEX2HsLmc+NMWMu9ylcLX6HmThYdnrP8XmC5ZAaVjH
         YewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686024339; x=1688616339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYhswQiRt1WsRhH2+UJS4EAOlVs+4YtiTEvdONDNyWM=;
        b=BJGcBkZfZMUNimM9fqex6xe7TtgG2kk7pRB2GHabimIC6qFNyMeHdEzncDhZOwNDxI
         snpMnQx44WXzRCUbeEfaJRCiAuRjggvDkTgHAr1IK1Yc+WNN7vNXC1XB4eTpEsGEku5+
         HoR+zK5cn/VFkIRhNU7qu3IuuM5VJ3uZa1eZDWNLLMRupbn8Z0t5/AHI4XhKH7GfSgAp
         ntFwi1hTZLjgUmOuIbcap+50wEuRBbJLHFf3uK0THVmTxkJr5vomdRyQ1/yF4goyiPr/
         AiNv3F9Sz9XJh+v2/a3lZAzqVQszNBFXqo7fPCCIqKmjW1q5NPc099c7i8gmn05yIqBV
         nJGg==
X-Gm-Message-State: AC+VfDxqK8Bc3GSNcxFUpZI4/QAV3LJUUPcRsH0ni225ow0Da1+ImdfH
        4+gACtYVTQH1W45ekPoWMiE=
X-Google-Smtp-Source: ACHHUZ5ZjW8Lgt8vljRskIoL0Pq7bwAOEFKuBRFF/VtJSVNzmAcxf4EOO0i8RN6aZbg99iOCiB27JQ==
X-Received: by 2002:a05:6214:2423:b0:61b:7115:559e with SMTP id gy3-20020a056214242300b0061b7115559emr1228066qvb.1.1686024338736;
        Mon, 05 Jun 2023 21:05:38 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:aac8:d62:35cc:958c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b003e388264753sm382980qts.65.2023.06.05.21.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:05:38 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] Samsung Galaxy Express SGH-I437 Support
Date:   Tue,  6 Jun 2023 00:05:23 -0400
Message-Id: <20230606040529.122433-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Samsung Galaxy Express SGH-I437.
Currently the following things work on this phone: UART, eMMC, SD Card, and
USB.

version 4:
- Rebase onto rc1
- Fix qcom,usb-hs-phy.yaml patch so it doesn't break other devices

version 3:
- Added Ack
- Fixed compatible in qcom,usb-hs-phy.yaml. `make dt_binding_check dtbs_check`
  no longer complains about USB
- Fixed formatting in qcom-msm8960.dtsi and qcom-msm8960-samsung-expressatt.dts
- Fixed the spi1_default node in qcom-msm8960-samsung-expressatt.dts.
  `make dt_binding_check dtbs_check` no longer complains

version 2:
- Combined patch 1 into patch 4, as the sleep_clk label is specifically needed
  for the USB node.
- Reformatted the commit messages to align with the style used in other commit
  messages that modify the same files.
- Included a cover letter to provide an overview of the patch series.
- Slight refactoring of the device tree source (DTS) file.

Rudraksha Gupta (4):
  dt-bindings: arm: qcom: Add Samsung Galaxy Express
  dt-bindings: phy: qcom,usb-hs-phy: Add compatible
  ARM: dts: qcom: msm8960: Add USB node
  ARM: dts: qcom: Add Samsung Galaxy Express support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/phy/qcom,usb-hs-phy.yaml         |   5 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 331 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi           |  34 +-
 5 files changed, 370 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

-- 
2.34.1

