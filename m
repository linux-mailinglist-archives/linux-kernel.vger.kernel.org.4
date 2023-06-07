Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411272531A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjFGFAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjFGFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:00:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9110FB;
        Tue,  6 Jun 2023 22:00:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75ec7e8e826so186891785a.0;
        Tue, 06 Jun 2023 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686114029; x=1688706029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnDSNztBm4J3NasuTfQRWgwfyES7T9XRaUOrSTDLNZ4=;
        b=hfOxgLDZXBPnbDuIG7QLJvtBnPCEgqErrK1gQCRO8R2Wv36kpvTnKynhJCefBg/5NR
         NgSk+cqo5oY2Gh58WRiu06UYRiXSUdH5znj7CDiyDPfN7QnE/Wi1dNHq5bTLSO/wRuNu
         9TXuzHyIen3xPyALTGrZdxvFldOR1EHSDFcoKAjDx4I5pM5+vZv7ZxLOpuUbQXh2NF0k
         XnmX3zbaLDU2rrftRUuBPIL4NTJ1l4UGaB7RSbsYqcUilHqJfY0P3NqG5LS5cUyIU/N8
         XdpJVR2MHevcF+aVYrkSDLyqlanxCJ01MOugzFHuwgoCdgEczFtQCC3X2mepC+cTQPHA
         wjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114029; x=1688706029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnDSNztBm4J3NasuTfQRWgwfyES7T9XRaUOrSTDLNZ4=;
        b=FaxHrapHGMWfuI3P3djHgFgdOVQTmgsojpm7O7naNddZ7Y3SL/FVlaqiUqHUclK5OP
         47dIYG6rjUI5559Y77+YIvxnOepyQcJfLR9A2p+yKNgzmXfP7Sx+0hnbqAaMLTk+1LfV
         6vu0Tf5OkI336oEKxtsSF8rOhIvdLt6HYmKq5WLyHNwd5v/pvCfrx+IHrRn+WFLMEZ8W
         XPpNllTPe6pWwm/ppH/I9Ct3bmfVotn5fAqET4hmVevsCItcCxdIDfV+IpnPgBZRNHxr
         bbbc4xcva/eY6/X3JqNtX4KWPsah8VQ4lBg51z2yMan8veqX2/ynPPDUTq3vPkdP5/Cs
         hlfg==
X-Gm-Message-State: AC+VfDxEGv7LfNNjCHiYrbp489B7tvRekuLP8qZCOyQOARaOvYMZZwT7
        WDl821yhYcayt6OkCD+wtobnE+YtYjweXw==
X-Google-Smtp-Source: ACHHUZ6FSOUL8gqKJKG6injW2YR28bdwhMVki0CET5tehnYzxt3S9hid7iykw0he0o1Ml6HfPwuWIw==
X-Received: by 2002:a05:6214:1d2b:b0:625:b3a2:f637 with SMTP id f11-20020a0562141d2b00b00625b3a2f637mr2236823qvd.8.1686114029079;
        Tue, 06 Jun 2023 22:00:29 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:c358:f4f2:89b6:ca7d])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44481000000b00621430707f7sm5848980qvt.83.2023.06.06.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 22:00:28 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Samsung Galaxy Express SGH-I437 Support
Date:   Wed,  7 Jun 2023 01:00:19 -0400
Message-Id: <20230607050025.86636-1-guptarud@gmail.com>
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

version 5:
- use enum instead of anyOf in qcom,usb-hs-phy.yaml

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

