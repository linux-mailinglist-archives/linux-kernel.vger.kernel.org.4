Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F0626B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 21:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKLUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 15:33:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED6DBB;
        Sat, 12 Nov 2022 12:33:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t25so19752249ejb.8;
        Sat, 12 Nov 2022 12:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uQnyMkfHV2JZkc9Ftq7KUX0pW3IG1YkRo3sfduWCHQ=;
        b=BvjZunhMCrS4ml64CqULd94Gnqt8jgl9tJ/shrfGtvFwW28okOpximVcMiTrz6DUnk
         qY6lFHjRKDlTjDGdoIAkCBcYIwwLa0xmtnkoZJ0eipBgoRDbM0RP1pZe8WEgSHY4JwQ6
         jLmf6EkfmA7eIWfBmJ5x5hRZU4tj6sn3Er9nWS+VERTO4tHxNVQEI5d6II3eHo94gbQW
         MTxexyKENavqpHqNLUSrUvtCfXn/XXKx3blMI59oVSFO7PQt0m3FhGHKPYqGlww6LMHD
         Yo+ZStQgdqB1G9Ge//AryeuF6PiSrDlpt3RkPuE4m98BhHLp9J3dU6M1LOQPdbPQBjyu
         j5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uQnyMkfHV2JZkc9Ftq7KUX0pW3IG1YkRo3sfduWCHQ=;
        b=qdyblWoi6Idv+ZZ8sgDMuSQXxtnOMfTX/F7XmtmvtIRYE56YdVYSSLqLfayif2m8hf
         O/7pnOHXVleblHufMaBjOw47TaIbPFzBlTLY8cQEzys7nG4WzJhskeZgcat9nplJqhwf
         gVT82G7RyI5nzF2e+qr7MlQxFke2rW2Q4SsA7Gn+tRpNR9zFh1+l4D9LhccXLu2DZHCL
         kBq+fETNIpIUQWvRLgqKvHUFQ7AJ9VqldeX7s8zsyGJ2nnwq+b5B8pnieWE1fup6QMjf
         cn//TGI+7ULhdJ0j5JBDPSoPyNl+jZxwIv03QGV7/pxd/OuPKnO7Vz4OFZjX+o2OJQYQ
         gm2Q==
X-Gm-Message-State: ANoB5plyX4PAkCq+pZ9XSwMbLIEHkI32TbtGi2GX7kseisL+jq/wRZo5
        eesP3c7Ghj6VuC/lJU/RNwW99WHGS5c=
X-Google-Smtp-Source: AA0mqf7oYSDBawFhy682HCoZhpa/BntmWjFY+T60Xv2PFMsKLi5GDMUMtyW4sNoLN9WZTvAzkfJeUg==
X-Received: by 2002:a17:906:f74e:b0:7ad:975f:b576 with SMTP id jp14-20020a170906f74e00b007ad975fb576mr6062515ejb.49.1668285210602;
        Sat, 12 Nov 2022 12:33:30 -0800 (PST)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c441000000b004638ba0ea96sm2648962edr.97.2022.11.12.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 12:33:30 -0800 (PST)
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
Subject: [PATCH v12 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Sat, 12 Nov 2022 23:32:58 +0300
Message-Id: <20221112203300.536010-1-dsankouski@gmail.com>
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

