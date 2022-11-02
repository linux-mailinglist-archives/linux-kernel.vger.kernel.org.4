Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7761669E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKBP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:56:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614E2A70A;
        Wed,  2 Nov 2022 08:56:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so25202938wrq.3;
        Wed, 02 Nov 2022 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uQnyMkfHV2JZkc9Ftq7KUX0pW3IG1YkRo3sfduWCHQ=;
        b=bOYY07J0cXn40vy6H7M1QgEnig7aqvdMF++mLaKvndLOXXzr5QXlMAKD/NZ76fftXl
         Juf2TGGCMRlGuo01PZ0YOoTZ/fglO673mZuUGOpCmdUYbIWPO7tAtw0ER1ELAEbXEuJT
         /GXvhFsl/aDDUaWkGMOEzWg7EdyWSvbAfwGa9+Ahkbi17bpk77hXE0ClfB7o76rKtV/0
         c3ZfKWEesJusyhDm/YqhDBTtIMzvhmJSTnwZoJOgwMP7DdpH+0IXlR1fKIFBg4njRPjk
         aBSS5FZYBNy8sYGhMOqzH953gvGeXCNvNM3FeosQcM7h/r7aZdynzUfAPrh+PT3Y+4Gs
         Ec9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uQnyMkfHV2JZkc9Ftq7KUX0pW3IG1YkRo3sfduWCHQ=;
        b=SyPYZn5P0Ld3IUeswlNqgkv4BeaNIO7hM6C72GLs0NcplJ0oRNtWtNVijt1BWHcM59
         TivTyc+cmAzp3imOiwYAZT0yFGmt3hrgX4FLvByR3v5tnBiU//kHlMj2GDXZ93THXlYj
         np7tZUG3ISt1Hew4jj8V6+ib56GreKcn3sEWJjKMXjYVvPqks5P9xZUoJW3DkOBDKbvV
         moqR0PtcvKHa2yHjkpRQ76Z7+sqycR+8qGWEkZ3BcJk+gEXAxXA5YlM/8i1FEQIAgCKx
         ktVOPgfhAEkH1NiDh17K6Fyo3y7chjHT8uO9w/USHR6cZREWWgQY/dqlyhlVMNXqfDRj
         /HIA==
X-Gm-Message-State: ACrzQf2QLJ9CayxfC42L1e+S4n7BAljFdvLvFtj0XS16zccQQhq3JuoY
        pIK/KwbdRx3GL6gW7wgSGOO94PL6Xhc=
X-Google-Smtp-Source: AMsMyM7vor70MXA5ODcZgaYz2Bqi2au7dw8WDDp8flN3/ViWLuxBYJaTkJr3u8LUQuaDCDVfl+hMhA==
X-Received: by 2002:adf:ecd0:0:b0:236:bb73:7f81 with SMTP id s16-20020adfecd0000000b00236bb737f81mr13407568wro.562.1667404563454;
        Wed, 02 Nov 2022 08:56:03 -0700 (PDT)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id r10-20020a05600c35ca00b003cf6e1df4a8sm2915162wmq.15.2022.11.02.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:56:02 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v11 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Wed,  2 Nov 2022 18:55:56 +0300
Message-Id: <20221102155558.1895829-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
  arm64: dts: qcom: sagit: add initial device tree for sagit

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 711 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
 4 files changed, 721 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

