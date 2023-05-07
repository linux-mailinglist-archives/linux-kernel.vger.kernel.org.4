Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7385A6F9B53
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjEGUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjEGUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9A269E;
        Sun,  7 May 2023 13:12:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so30151711fa.0;
        Sun, 07 May 2023 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490361; x=1686082361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkTrjWn9MXIx9ar7sdUfBpNB62vFCZeO4ohEw8FEUIo=;
        b=VdixB5NjZcMvRHt8b1EKbYy8A/KU5sq5dWqBZLGQVLGcq751KXhSInQRhGRPNGy3DV
         nPlinNKv6AdF5FV4ecOTfUlwQdgO2CLTD21rtkRdPyZpr7cedoJsDJT6Cj4TGNvTjizm
         N2rUkMWqurGp2u7mpazlcLYHsBwDK02vFctv+trdUjqSXbyZbbnulNbd1ekFN1qoNBAO
         0z2A0b/te1uVJctzUQTvZyEBiGL4WEsQsFWK1A6q5oWGPyt7sPBrLyYvXpXZcqd/jjfD
         JyUrVLrcIwQ2D1RxbeKgyUrukWH9h5NRxfh5un5DL5rQsHyKnPzdFCW2b+TPEcTLfdeM
         a89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490361; x=1686082361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkTrjWn9MXIx9ar7sdUfBpNB62vFCZeO4ohEw8FEUIo=;
        b=FUZHQoY89EmvfMkHlVuXnuerKilwrX1BAB7dL5RgHnkx9/+uTOgsGfglTgLgFzA8vJ
         Hp/N4Mt2tPukfqFINqjhEHdoub6puRlnzJYZbY2F2rLucqZVDqTW+thxEqjhmc+fL6yU
         iBMsJqPFX/e/caPIEOOLlaxaZErHDsb8u9CnPe179oFBmSuPEg2phqiU6XVr9jiWDGjh
         voYuEt/+GxGMcNrdLEj1ywP3OqNdJkm+eDGYUDM9HBqARWlHCDN5pv9rEhZ49ToVHWjV
         K9kpIRRhfoxSnVH9SR7VWVaNuDxLHI4bo1fBsCRN2RNOHu+AYH3z9qSFpzAeF8zrAJIb
         bolw==
X-Gm-Message-State: AC+VfDw2fIBK9K5kobmsSjri4Q3SecGZeykHGyjHaC5O+zVf7ggdgruQ
        KZVxSN5Dx44X7/UjegxWUkoktPDhbDk=
X-Google-Smtp-Source: ACHHUZ51+VQTFiy6DyJv03cqNFG965h0mnjVDc23i/s7gKTCdIFqUYaOOQdAYhuoOZzUe8YkCY0JAg==
X-Received: by 2002:a05:651c:1044:b0:2a8:c858:fb9 with SMTP id x4-20020a05651c104400b002a8c8580fb9mr2289679ljm.29.1683490361330;
        Sun, 07 May 2023 13:12:41 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:40 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/6] Enable MSM8226 TSENS support
Date:   Sun,  7 May 2023 23:12:18 +0300
Message-Id: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for tsens in MSM8226. Add qfprom compatible for MSM8226.
Add device tree nodes for qfprom, tsens and thermal zones for MSM8226.

Matti Lehtimäki (6):
  dt-bindings: nvmem: qfprom: Add compatible for MSM8226
  dt-bindings: thermal: tsens: Add compatible for MSM8226
  thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
  ARM: dts: msm8226: Add qfprom node
  ARM: dts: msm8226: Add tsens node and related nvmem cells
  ARM: dts: msm8226: Add thermal zones node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 164 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v0_1.c             |  27 ++-
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 6 files changed, 196 insertions(+), 2 deletions(-)

-- 
2.34.1

