Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA95FCB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJLSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJLSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:54:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ED1FBCE1;
        Wed, 12 Oct 2022 11:54:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sc25so33785636ejc.12;
        Wed, 12 Oct 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpNAjIP3+/CYveBRP1wK/QYkcqvRFS3jNUinLQYeflQ=;
        b=L14dIfx8sUT5dwY0c4owUOXGJoyaq7E8rFKe9s4Fy5EyDUGDxJ/coXeSiaDLgItJcq
         hgbDS9Ent15GVDV3kqohjV5E8AEI1pqEYrkrcFkZYiv+fwo7UumrTo/als1ZDP2jlyWa
         DU4LxX8Nv90I+X6gy5TDv5+4EHcEBAaC+s8lRg/YU5nl3IJHcCHZuFuTdbC4CiLiIBKO
         llYtadqOytjMUm8xH+DmmIecmJhVmog9uMQG+RdhT3XR/rnL+P0gTy+JUJvW3eD1Cz5B
         zSBIFKveODf9mGBZsfvp5bu8CBxF//gVm00wFe2N2+9DfW8Zt1tSQYZ1+HE2u9LBCaLl
         BRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpNAjIP3+/CYveBRP1wK/QYkcqvRFS3jNUinLQYeflQ=;
        b=gmjKLF7I4Qc8vnKjpGMghCJoXM+m5yKOH7MW24YsswPqxzxsg6UzDKpx4FGuVnkqF+
         QlVk37D8+6whTbxxDwytmriqa+CoSHYCj1mxa3wcD4nBf1MkUliIWO2P6njcpeJ0BgPF
         ChF9nPeuZmJmDQT1wLFnMcIRDTvWHYwyXOfAVE6wmI89ZMPiPQIEUxCWYqzZkK6nXpyk
         6rIQiu2E85Y+wBDkVSuW+7yXkqSSEkwMLaSw3rwwZ1IWHaYXHh5Y/YgNNqiMVFgQjwe0
         mQ3Y5rAgOwiseunQaB5NCgczfSSxV4VhBH9sOIRKG3r377JLDJTiPlVKkpCdEJcqCRHA
         f/LA==
X-Gm-Message-State: ACrzQf00jvdW9IwpJHhKMPuOFuLCwNAEzWhsnds94kvJ+Q/Q4WAVDqMU
        QyxpJ3ErinHro8VxCrkgxNGAe0uYM90=
X-Google-Smtp-Source: AMsMyM4+dkMPTk53nm+2lFF6ZKKWyQQOA4QE6x4T9y0IFp/QJYLp9gQuL+7OR9DwC3DHYxwZxJqhMw==
X-Received: by 2002:a17:907:6e09:b0:78d:a326:49c6 with SMTP id sd9-20020a1709076e0900b0078da32649c6mr15728366ejc.507.1665600856015;
        Wed, 12 Oct 2022 11:54:16 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id ay8-20020a170906d28800b00788c622fa2csm1668235ejb.135.2022.10.12.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:54:15 -0700 (PDT)
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
Subject: [PATCH v3 0/2] add device Samsung Galaxy S9 phone (codename starqltechn) and board binding
Date:   Wed, 12 Oct 2022 21:54:09 +0300
Message-Id: <20221012185411.1282838-1-dsankouski@gmail.com>
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

Add initial support for Samsung Galaxy S9 phone (codename starqltechn) and board binding

Dzmitry Sankouski (2):
  dt-bindings: arm: add samsung,starqltechn board based on sdm845 chip
  arm64: dts: qcom: starqltechn: add initial device tree for starqltechn

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sdm845-samsung-starqltechn.dts   | 460 ++++++++++++++++++
 3 files changed, 462 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts

-- 
2.30.2

