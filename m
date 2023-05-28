Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68F713741
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE1AKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1AKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:10:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58EA8;
        Sat, 27 May 2023 17:10:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f7a546efb1so11032271cf.2;
        Sat, 27 May 2023 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685232636; x=1687824636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMCsGvkoxWSUFyaRQ4KyoqEeH9gxDpYDK1XiImU4CBA=;
        b=r18LUXZbEyf295PSaklp4P9NGUmzPbTYzCAwdHwZtRNoSN4MoWP2YuVp0GrIvexMeR
         0dvZK3/dzViFqtqSyIVKcS75h47Z0HTRdZULgLqHn2pijGNSXfYcVcXPL0hrV6LrRbm7
         IX8y8whrqzZgXL+eL5zMEHBOGAGQtjUhnaRSRsbI9xAtH6fwP4sRU+lNPC64EJu6xyVN
         EDKroP22n1mKX+NLw59ouc86TefbafTsydeKStJtYZOP8nCuX96jJIMZJft6AfGIcFcd
         iOlQpbN0xsl0XMoaCYaseu5Hk9mHZgNMJPIabNvxynvvt+MYt2fjdaILPYyFh4JA3DMm
         1phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685232636; x=1687824636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMCsGvkoxWSUFyaRQ4KyoqEeH9gxDpYDK1XiImU4CBA=;
        b=Bo7WLOQoSYEXQAivFGdTCmP7MLBwHYqasexNkDfiSmPU42HoQf4dPHC3U/okqRxJtO
         iD6mQPE+y+crev5OO9K/4nuozRgzl2FKAhnAlDGNnlXOX3HEcLYFivNQBKQqGajeKxTd
         ULVd6X10SAIzJrZ3j18th2IBoFc4T+JWRlp2+jmulhtTUxBt5o16OnzL+iTJW8KvpSw2
         KwhPKc3ZYgBI9mn4dZZJvD6lhP+zFuc2pTIqzX7nCxGnM0IuHP+LySZnvAkGt1AgX9G9
         CJagF8xuf5Wg1lfNWzz56Ir4YVQBHC5YQDUdj1wxCqGSH268xWGjBKik3y3mr8DLb2IV
         aD5w==
X-Gm-Message-State: AC+VfDwP50dyHrYPL4RMKEz+hldSGO9LOmJkv3bCjUCUfv1hNit9GKjv
        yq3+pnj6Wex653yIhIpwRq9t546T7sf6MQ==
X-Google-Smtp-Source: ACHHUZ7MIP/VcIjwshjdNl1IQZV0vU+2dA96XzmQnwrcz12nJc3u2smpOSknIIHBeMqz6BwKzt6pug==
X-Received: by 2002:a05:622a:3d1:b0:3f2:f35:8e6f with SMTP id k17-20020a05622a03d100b003f20f358e6fmr6671214qtx.25.1685232636346;
        Sat, 27 May 2023 17:10:36 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:28b2:2867:6311:b7d0])
        by smtp.gmail.com with ESMTPSA id t18-20020ac865d2000000b003f6a7ab1450sm2518454qto.30.2023.05.27.17.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:10:35 -0700 (PDT)
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
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH v2 0/4] Samsung Galaxy Express SGH-I437 Support
Date:   Sat, 27 May 2023 20:10:05 -0400
Message-Id: <20230528001010.47868-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527040905.stmnoshkdqgiaex6@ripper>
References: <20230527040905.stmnoshkdqgiaex6@ripper>
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
Currently the following things work on this phone: UART, eMMC, SD Card, and USB.

version 2:
- Combined patch 1 into patch 4, as the sleep_clk label is specifically needed for the USB node.
- Reformatted the commit messages to align with the style used in other commit messages that modify the same files.
- Included a cover letter to provide an overview of the patch series.
- Slight refactoring of the device tree source (DTS) file.

Rudraksha Gupta (4):
  dt-bindings: arm: qcom: Add Samsung Galaxy Express
  dt-bindings: Add qcom,usb-hs-phy-msm8960
  ARM: dts: qcom: msm8960: Add USB node
  ARM: dts: qcom: Add Samsung Galaxy Express support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/phy/qcom,usb-hs-phy.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 334 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi           |  35 +-
 5 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

-- 
2.34.1

