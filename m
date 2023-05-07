Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3926F97E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjEGJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEGJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:13:05 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274F3AB6;
        Sun,  7 May 2023 02:13:03 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 44226C70AF;
        Sun,  7 May 2023 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450781; bh=jvJNwlKthS3/mkOJOwGgF7mnK8b7h/R3pEVKlDmWcPA=;
        h=From:Subject:Date:To:Cc;
        b=GTjPS31zvw/UUzBFfUcjZ9AShGiCivevEjcTWd8p+02P2+vBDOomB4G6Rmviw3hN7
         xSQ4YmDF+J/JWOLWFG23REBeNQ6tSy6CSydVDkqXQz73U/bkaqQrUUtwJgBqLGPwa0
         8UgyX85Pylzp6F5Pnkxg/PyZoO25vqSMj0TmaYaI=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/6] Add MSM8226 OCMEM support plus some extra OCMEM driver
 fixes
Date:   Sun, 07 May 2023 11:12:17 +0200
Message-Id: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFrV2QC/x2NzQrCMBAGX6Xs2YUk0h98FfGQxE+70KSSRRFK3
 71LjzMwzEaKJlC6dRs1/ERlrQb+0lGeY32D5WlMwYWr693ARcsUwsBrLiicAD/2o8eERNakqOD
 UYs2zVfW7LCY/DS/5n5P7Y98P/JYXA3QAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=jvJNwlKthS3/mkOJOwGgF7mnK8b7h/R3pEVKlDmWcPA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2t6Rf/j2PCgD+0bT7X74gHOu71WOltn5mXNo
 5cDD40Zbk2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdregAKCRBy2EO4nU3X
 VmEKD/9crh4orNCRzsbIgSEvhq44x9UsW4USeE7tbH5lsaZLd46lI2VZ7B6zXPg0CCMLTSHrCy+
 OuLzAUyOLR/JoYfb99lBG9PK4cwPlbW3iu85SG3qGZwOXnlvEFy9gpEskrB+PPo4NUS74HNU7PD
 LOff5zYo8OYnJbe0HtTn3C+v62okCerz2sTsq7tQRl/Uv7zmtRt0k25PPYqrCBCepwLUyvQlj86
 izk3WyG/uAoFpGTKlW7nPKMXWYyD1z7UD1HNUqUk4DPvTEWvMSuI2K7AenFAwqw1RUWpXi0PY1i
 BNqYTgI15GkfBw9GzeYlWFIjk6AkKqETEKtROltmII4nl0I76V4g9bWDoRMQkpZZ+lpZMpDqzDz
 R551/h9E/oqTJL8OAnekYaBekFKw3ZBmf9m+zAaQdp2BIxQTW6W3rxRcpSkmEn+78CxYxYEgeFE
 fd9aTaTHjGZ5zEf+HsLUtcMIM36IXTg1f451CfHVWUwsh+Aim/Kvtp7za8n2Jn0L8u3TErKaIG/
 TQPROP5odqiJ9JibFRvCincZKMcshYUkcsCiQWEzgtkaZ95loD0qfEnFx5Ztir1zhFl5cKb/Ill
 3NBxVvNOIMx/8FsqS302yMiuwPWUdM1pRmtdeSW2eiPmxxCPrKwWNTydzKjhhgRG17nXoygWpCp
 r/ZRNWnk8WwtBWA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like MSM8974 the MSM8226 SoC also contains some OCMEM but it has just
one region for graphics compared to 8974.

While adding support I found a bug in the existing driver that is being
fixed in this series also and the rest of the matches are mostly
preparations for MSM8226 support.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (6):
      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
      soc: qcom: ocmem: Use dev_err_probe where appropriate
      soc: qcom: ocmem: make iface clock optional
      dt-bindings: sram: qcom,ocmem: Add msm8226 support
      soc: qcom: ocmem: Add support for msm8226
      ARM: dts: qcom: msm8226: Add ocmem

 .../devicetree/bindings/sram/qcom,ocmem.yaml       |  6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi                | 17 ++++++
 drivers/soc/qcom/ocmem.c                           | 67 ++++++++++++----------
 3 files changed, 58 insertions(+), 32 deletions(-)
---
base-commit: 2e210278b67c67e76aeefc1a16d18a692d15c847
change-id: 20230506-msm8226-ocmem-bee17571e8eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

